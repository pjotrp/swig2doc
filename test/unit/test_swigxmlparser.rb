require 'test/unit'

$srcpath = '../../'+File.dirname(__FILE__)
$: << $srcpath+'/lib'

SWIGXML=$srcpath+'/test/data/swig/perl_affyio_wrap.xml'

require 'input/swigxmlparser'

class TestSwigXMLParser < Test::Unit::TestCase

  def setup
  end

  def test_attributelist
    xml = SwigXMLParser.new(SWIGXML)
    reader = xml.reader
    assert(xml.swig?)   # this tests get_element
    element = reader.get_element('attributelist')
    assert_equal('attributelist',element.name)
    assert_equal("<attributelist id=\"2\" addr=\"b7cd59a8\">\n        <attribute name=\"outfile\" value=\"p",reader.xml.expand.to_s[0..80])
  end

  def test_reader
    if false
    objects = @xml.objects
    assert_equal(29,objects.num_functions)
    assert_equal(145,objects.num_vars)
    assert_equal(20,objects.num_structs)
    end
  end
 
end
