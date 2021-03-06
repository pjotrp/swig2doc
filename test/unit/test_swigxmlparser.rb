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
    header = xml.parse_member_attributelist(reader.xml.expand)
    assert_equal('affyio',header['name'])
    assert_equal('perl_affyio.i',header['infile'])
  end

  def test_reader
    xml = SwigXMLParser.new(SWIGXML)
    cobjs = xml.cobjs  # invokes parser
    assert_equal('perl', xml.language)
    assert_equal('affyio', xml.modulename)
    assert_equal('affyio', cobjs.name)
    assert_equal(29,cobjs.functions.size)
    assert_equal(145,cobjs.variables.size)
    assert_equal(20,cobjs.structs.size)
    assert_equal(0,cobjs.classes.size)
  end

  def test_functions
    xml = SwigXMLParser.new(SWIGXML)
    cobjs = xml.cobjs  # invokes parser
    function = cobjs.functions.first
    assert_equal("isTextCDFFile",function.name)
    assert_equal("int",function.type)
    assert_equal(1,function.parameters.size)
  end
 
end
