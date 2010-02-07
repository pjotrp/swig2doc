
$:.unshift '/var/lib/gems/1.8/gems/libxml-ruby-1.1.3/lib/'

require 'libxml'

class SwigXMLParser

  include LibXML

  def initialize fn
    print XML::LIBXML_VERSION
    print "Reading #{fn}\n"
    @xml = XML::Reader.file(fn) 
    # read top
    @xml.read
    if @xml.name != 'top'
      raise "#{fn} is not a SWIG XML document!"
    end
    # if @xml.has_attributes?
    #   p @xml['addr']
    # end
    # while @xml.read_state!=XML::Reader::MODE_EOF and @xml.read_state!=XML::Reader::MODE_ERROR
    while @xml.read_state==1
      while @xml.name != 'cdecl' and @xml.name != 'class'
        @xml.read
      end
      name = @xml.name
      CDecl.parse_attributelist(@xml.expand)
      @xml.next
    end
  end

  def objects
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
