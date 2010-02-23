
class XMLEasyElement
  attr_accessor :name, :attributes
  def initialize
  end
end

class XMLEasyReader

  include LibXML

  def initialize fn
    @fn = fn
    @reader = XML::Reader.file(fn) 
  end

  # Get the element and return XML element (always start). If name is specified
  # it will search for the first match. Returns nil when end of data. It 
  # also picks up the attributes of the element (if any)
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
    e.attributes = get_attributes()
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

  # Return attributes as a Hash
  def get_attributes
    h = {}
    if @reader.has_attributes?
      # p @reader.move_to_first_attribute
      # p @reader.name
      while @reader.move_to_next_attribute == 1
        h[@reader.name] = @reader.value
      end
    end
    p h
    h
  end

  def xml
    @reader
  end

end
