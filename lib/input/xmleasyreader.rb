
class XMLEasyElement
  attr_accessor :name
end

class XMLEasyReader

  include LibXML

  def initialize fn
    @fn = fn
    @reader = XML::Reader.file(fn) 
  end

  # Get the element and return readerEasyReader. If name is specified it 
  # will search for the first match
  def get_element name=nil
    e = XMLEasyElement.new()
    begin
      # p [name, @reader.name, @reader.node_type]
      if @reader.node_type == XML::Reader::TYPE_ELEMENT
        break if name==nil 
        break if @reader.name==name 
      end
      ok = @reader.read
    end while ok==true
    e.name = @reader.name
    e
  end

  def xml
    @reader
  end
end
