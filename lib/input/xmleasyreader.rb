
class XMLEasyElement
  attr_accessor :name, :attributes
end

class XMLEasyReader

  include LibXML

  def initialize fn
    @fn = fn
    @reader = XML::Reader.file(fn) 
  end

  # Get the element and return XML element (always start). If name is specified
  # it will search for the first match. Returns nil when end of data
  def get_element name=nil
    e = XMLEasyElement.new()
    begin
      # p [name, @reader.name, @reader.node_type]
      if @reader.node_type == XML::Reader::TYPE_ELEMENT
        break if name==nil 
        break if @reader.name==name 
      end
      ok = @reader.read
      return nil if ok == false
    end while ok==true
    e.name = @reader.name
    e.attributes = @reader[
    e
  end

  # Find all elements matching regex and returns the contained nodes as 
  # a node
  def each_element_tree regex
    begin
      @reader.read # move pointer forward
      e = get_element
      break if e == nil
      if e.name =~ /#{regex}/
        get_element('attributelist')
        yield e.name, @reader.expand
      end 
    end while e != nil
  end

  def xml
    @reader
  end

end
