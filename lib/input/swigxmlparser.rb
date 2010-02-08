
$:.unshift '/var/lib/gems/1.8/gems/libxml-ruby-1.1.3/lib/'

require 'libxml'
require 'input/xmleasyreader'

class SwigXMLParser

  attr_reader :reader, :language

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
    if !swig?
      raise "#{@fn} is not a SWIG XML document!"
    end
  end

  def objects
  end

  # Return a hash of attributes
  def attributelist(node)
    h = {}
    node.each do | attribute |
      # p attribute
      name = attribute['name']
      if name
        # h[name] = { :value => attribute['value'] }
        h[name] = attribute['value']
      # if attribute.is_list?
      #   list[:parmlist] = parse_list(attribute,attributelist.fetch('parmlist/parm/attributelist')) 
      # else
      #   list[attribute['name']] = { :value => attribute['value'] }
      # end
      end
    end
    # p h
    h
  end

end

module CDecl
  include LibXML

  # A buffer gets put in consisting of an attribute list and 
  # attributes. These get returned in a Hash of attributes.
  def CDecl.parse_attributelist node
    # print node.to_s
    # print "\n++++\n"
    h = Hash.new
    node = node.each do | attributelist |
      attributelist.each do | attribute |
        name = attribute.name
        if name == 'attribute'
          h[attribute['name']] = attribute['value']
        elsif name == 'parlist'
          attribute.each do | parm |
            p parm
          end
        elsif name == 'text' or name == 'typescope'
          next
        else
          raise 'Strange '+name
        end
      end
    end
    p h
    print "\n----\n"
    # attributes = node.find("/attributelist")
    # p attributes
  end
end
