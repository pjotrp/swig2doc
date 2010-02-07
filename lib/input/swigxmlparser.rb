
require 'libxml'

class SwigXMLParser

  include LibXML

  def initialize fn
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
    while @xml.read_state!=XML::Reader::MODE_EOF and @xml.read_state!=XML::Reader::MODE_ERROR
      while @xml.name != 'cdecl'
        @xml.read
      end
      p @xml.name
      object = CDecl::parse(@xml.read_inner_xml)
      @xml.read
    end
  end

  def objects
  end
end

module CDecl
  def CDecl.parse buf
    print buf
  end
end
