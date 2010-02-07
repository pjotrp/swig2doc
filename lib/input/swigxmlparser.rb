
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
      while @xml.name != 'cdecl' and @xml.name != 'class'
        @xml.read
      end
      name = @xml.name
      @xml.read
      @xml.read
      p @xml.name
      CDecl.parse(@xml.expand.to_s)
    end
  end

  def objects
  end
end

module CDecl
  include LibXML

  # A buffer gets put in consisting of an attribute list and 
  # attributes. These get returned in a Hash of attributes.
  def CDecl.parse buf
    print buf
    print "\n----\n"
    doc = XML::Parser.string(buf.to_s).parse
    # attributes = doc.find("/attributelist")
    # p attributes
  end
end
