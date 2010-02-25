
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
  def get_element name=nil, fetch_attributes=false
    e = XMLEasyElement.new()
    ok = nil
    begin
      # p [name, @reader.name, XML::Reader::TYPE_ELEMENT, @reader.node_type] # if name == @reader.name
      if @reader.node_type == XML::Reader::TYPE_ELEMENT
        if name==nil  # returns the next element
          ok = true
          break
        end
        break if @reader.name==name 
      end
      ok = @reader.read
      if ok != true
        # p ["ERROR=",ok]
        return nil 
      end
    end while ok==true
    # p [@reader.name,'ok=',ok]
    if ok==true and @reader.node_type == XML::Reader::TYPE_ELEMENT
      e.name = @reader.name
      e.attributes = get_attributes() if fetch_attributes
    else 
      return nil
    end
    p e
    e
  end

  # Similar to get_element; fetches attributes automatically
  def get_element_with_attributes name=nil
    get_element(name,true)
  end

  # Find all elements matching regex and iterating the contained nodes as 
  # a mini DOM tree. You can use the regex to find a master node, and yield
  # a subset based on _subtree_.
  def each_element_tree regex, subtree=nil
    begin
      @reader.read # move pointer forward
      e = get_element
      p e
      break if e == nil
      if e.name =~ /#{regex}/
        get_element(subtree) if subtree
        yield e.name, @reader.expand
      end 
    end while e != nil
  end

  # Return one element's attributes as a Hash
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
