
$:.unshift '/var/lib/gems/1.8/gems/libxml-ruby-1.1.3/lib/'

require 'libxml'
require 'input/xmleasyreader'

class SwigXMLParser

  attr_reader :reader, :language, :module

  include LibXML

  def initialize fn
    print XML::LIBXML_VERSION
    print "Reading #{fn}\n"
    @fn = fn
    @reader = XMLEasyReader.new(fn)
  end

  # Tell if this is a SWIG document - this has to be called before 
  # any other reads!
  def swig?
    @reader.get_element.name == 'top'
  end

  def parse
    xml = @reader.xml
    if !swig?
      raise "#{@fn} is not a SWIG XML document!"
    end
    # parse header
    element = @reader.get_element('attributelist')
    header = attributelist(reader.xml.expand)
    set_language(header['infile'])
    @module = header['name']
    # @reader.each_element_tree("cdecl|class") do | type, tree |
    @reader.each_element_tree("cdecl|class") do | type, tree |
      # print tree.to_s
      h = attributelist(tree)
      p h
      # p [type, attributelist(tree)]
    end
  end

  def objects
  end

  # Return a hash of attributes
  def attributelist(node)
    h = {}
    node.each do | attribute |
      # p attribute
      if attribute.child?
        next if ['typescope'].index(attribute.name)
        if attribute.name != 'parmlist'
          raise "Error unknown type <#{attribute.name}>"
        end
        parameters = []
        attribute.each do | parm |
          parm.each do | attrs |
            ps = attributelist(attrs)
            parameters.push ps if ps != {}
          end
        end 
        h['parmlist'] = parameters
      else
        name = attribute['name']
        if name
          h[name] = attribute['value']
        end
      end
    end
    # p h
    h
  end

  def set_language name
    @language = :perl if name =~ /perl/
    @language = :python if name =~ /python/
    @language = :ruby if name =~ /ruby/
  end
end


