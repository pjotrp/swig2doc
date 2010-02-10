require 'test/unit'

$srcpath = '../../'+File.dirname(__FILE__)
$: << $srcpath+'/lib'

DOXYXML=$srcpath+'/test/data/doxygen/xml/affyio/biolib__affyio_8c.xml'

require 'input/doxyxmlparser'

class TestDoxyXMLParser < Test::Unit::TestCase

  def setup
  end

  def test_attributelist
    xml = DoxyXMLParser.new(DOXYXML)
    reader = xml.reader
    assert(xml.doxygen?)   # this tests get_element implicitely
    element = reader.get_element('sectiondef')
    assert_equal('function',element.attrib['kind'])
    assert_equal("<sectiondef id=\"2\" addr=\"b7cd59a8\">\n        <attribute name=\"outfile\" value=\"p",reader.xml.expand.to_s[0..80])
  end

  def test_reader
    xml = DoxyXMLParser.new(DOXYXML)
    cmodule = xml.cmodule  # invokes parser
    assert_equal('C', xml.language)
    assert_equal('affyio', xml.modulename)
    assert_equal('affyio', cmodule.name)
    assert_equal(29,cmodule.functions.size)
    # assert_equal(145,cmodule.variables.size)
    # assert_equal(20,cmodule.structs.size)
    # assert_equal(0,cmodule.classes.size)
  end

  def test_functions
    xml = DoxyXMLParser.new(DOXYXML)
    cmodule = xml.cmodule  # invokes parser
    function = cmodule.functions.first
    assert_equal("isTextCDFFile",function.name)
    assert_equal("int",function.type)
    assert_equal(1,function.parameters.size)
  end
 
end
