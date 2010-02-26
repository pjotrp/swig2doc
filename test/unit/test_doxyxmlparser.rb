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
    element = reader.get_element_with_attributes('sectiondef')
    assert_equal('func',element.attributes['kind'])
    assert_equal("<sectiondef kind=\"func\">\n      <memberdef kind=\"function\" id=\"group__affyio_1ge0b",reader.xml.expand.to_s[0..80])
  end

  def test_parse_function
    xml = DoxyXMLParser.new(DOXYXML)
    reader = xml.reader
    assert(xml.doxygen?)   # this tests get_element implicitely
    sectiondef = reader.get_element_with_attributes('sectiondef')
    assert_equal('func',sectiondef.attributes['kind'])
    memberdef = reader.get_element_with_attributes('memberdef')
    assert_equal("group__affyio_1ge0bdacab9809b9b475b9d7bfe1332bc6",memberdef.attributes['id'])
  end

  def test_parse_function2
    p "function2"
    xml = DoxyXMLParser.new(DOXYXML)
    reader = xml.reader
    assert(xml.doxygen?)   # this tests get_element implicitely
    memberdef = reader.get_element_with_attributes('memberdef')
    assert_equal('function',memberdef.attributes['kind'])
    reader.xml.read
    memberdef = reader.get_element_with_attributes('memberdef')
    assert_equal('function',memberdef.attributes['kind'])
    reader.xml.read
    reader.each_element_tree("memberdef") do | type, tree |
      # assert it is a function
      assert('function',reader.get_attributes['kind'])
      # parse the member DOM tree
      h = xml.parse_memberdef(tree)
      assert('cel_num_cols',h['name'])
      assert('unsigned long',h['type'])
      assert(80,h['line'])
      return  # just read once
    end

  end

  def test_reader
    xml = DoxyXMLParser.new(DOXYXML)
    cmodule = xml.cmodule  # invokes parser
    assert_equal('C', xml.language)
    # assert_equal('affyio', xml.modulename)
    # assert_equal('affyio', cmodule.name)
    assert_equal(25,cmodule.functions.size)
    # assert_equal(145,cmodule.variables.size)
    # assert_equal(20,cmodule.structs.size)
    # assert_equal(0,cmodule.classes.size)
  end

  def test_functions
    xml = DoxyXMLParser.new(DOXYXML)
    cmodule = xml.cmodule  # invokes parser
    function = cmodule.functions.first
    assert_equal("open_celfile",function.name)
    assert_equal("<ref refid=\"structCELOBJECT\" kindref=\"compound\">CELOBJECT</ref>",function.type)
  end
 
end
