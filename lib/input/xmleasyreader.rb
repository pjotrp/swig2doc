
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
    ok = nil
    begin
      # p [name, @reader.name, @reader.node_type]
      if @reader.node_type == XML::Reader::TYPE_ELEMENT
        break if name==nil  # returns the next element
        break if @reader.name==name 
      end
      ok = @reader.read
      return nil if ok == false
    end while ok==true
    if ok==true
      e.name = @reader.name
      e.attributes = get_attributes()
    end
    p e
    e
  end

  # Find all elements matching regex and returns the contained nodes as 
  # a node - this method is SWIG specific as it looks for an attributelist 
  # element
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
      if @reader.move_to_first_attribute == 1
        h[@reader.name] = @reader.value
        while @reader.move_to_next_attribute == 1
          h[@reader.name] = @reader.value
        end
      end
      @reader.move_to_element # reset main pointer in libxml
    end
    # p h
    h
  end

  def xml
    @reader
  end

end
