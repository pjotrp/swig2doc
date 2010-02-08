
class XMLEasyElement
  attr_accessor :name, :text
end

class XMLEasyReader

  attr_reader :xml

  include LibXML

  def initialize fn
    @fn = fn
    @xml = XML::Reader.file(fn) 
  end

  # Get the element and return XMLEasyReader
  def get_element
    e = XMLEasyElement.new()
    @xml.read
    # make sure the node type is an element
    raise 'Element problem' if @xml.node_type != XML::Reader::TYPE_ELEMENT
    e.name = @xml.name
    @xml.read
    # raise 'Element problem' if @xml.node_type != XML::Reader::TYPE_TEXT
    e.text = @xml.value
    e
  end

  # Move to the position where node matches element name (start)
  def find_node name
    while ((e = get_element).name != name)
      print e.name
    end
    e
  end

end
