
# $:.unshift '/var/lib/gems/1.8/gems/libxml-ruby-1.1.3/lib/'

require 'libxml'
require 'input/xmleasyreader'
require 'cobj/swig/swigcmodule'

class SwigXMLParser

  attr_reader :reader, :language, :modulename

  include LibXML

  def initialize fn
    print XML::LIBXML_VERSION
    print " LibXML reading #{fn}\n"
    @fn = fn
    @reader = XMLEasyReader.new(fn)
  end

  # Tell if this is a SWIG document - this has to be called before 
  # any other reads!
  def swig?
    @reader.get_element.name == 'top'
  end

  def parse
    objectlist = []
    xml = @reader.xml
    if !swig?
      raise "#{@fn} is not a SWIG XML document!"
    end
    # parse header
    element = @reader.get_element('attributelist')
    header = parse_member_attributelist(reader.xml.expand)
    set_language(header['infile'])
    @modulename = header['name']
    # ---- Now find each cdecl|class and push a Hash of values
    @reader.each_element_tree("cdecl|class",nil,"attributelist") do | type, tree |
      h = parse_member_attributelist(tree)
      objectlist.push h
    end
    objectlist
  end

  # Parse the source code and return set of objects for the module
  def cobjs
    objectlist = parse
    SwigCModule.new(@modulename,objectlist)
  end

  # Return a hash of SWIG function attributes as a Hash
  def parse_member_attributelist(tree)
    h = {}
    tree.each do | attribute |
      # p attribute
      if attribute.child?
        next if ['typescope'].index(attribute.name)
        if attribute.name != 'parmlist'
          raise "Error unknown type <#{attribute.name}>"
        end
        parameters = []
        attribute.each do | parm |
          parm.each do | attrs |
            ps = parse_member_attributelist(attrs)
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
    h
  end

  def set_language name
    @language = 'perl' if name =~ /perl/
    @language = 'python' if name =~ /python/
    @language = 'ruby' if name =~ /ruby/
  end
end


