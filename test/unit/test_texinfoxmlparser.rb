require 'test/unit'

$srcpath = '../../'+File.dirname(__FILE__)
$: << $srcpath+'/lib'

TEXIXML=$srcpath+'/test/data/texinfo/statistics.xml'

require 'input/texinfoxmlparser'

class TestTexInfoXMLParser < Test::Unit::TestCase

  def setup
  end

  def test_attributelist
    xml = TexInfoXMLParser.new(TEXIXML)
    reader = xml.reader
    assert(xml.texinfo?)   # this tests get_element implicitely
    element = reader.get_element_with_attributes('section')
    assert_equal("<section>\n      <title>Mean, Standard Deviation and Variance</title>\n      <defin",reader.xml.expand.to_s[0..80])
  end

  def test_parse_function
    xml = TexInfoXMLParser.new(TEXIXML)
    reader = xml.reader
    assert(xml.texinfo?)   # this tests get_element implicitely
    # memberdef = reader.get_element('definition')
    reader.each_element_tree("definition",nil,nil) do | type, tree |
      # parse the member DOM tree
      p tree.to_s
      h = xml.parse_definition(tree)
      assert('Function',h['defcategory'])
      assert('gsl_stats_mean',h['deffunction'])
      return  # just read one function
    end

  end

  def test_reader
    xml = TexInfoXMLParser.new(TEXIXML)
    cobjs = xml.cobjs  # invokes parser
    assert_equal('C', xml.language)
    # assert_equal('affyio', xml.modulename)
    # assert_equal('affyio', cobjs.name)
    assert_equal(25,cobjs.functions.size)
    # assert_equal(145,cobjs.variables.size)
    # assert_equal(20,cobjs.structs.size)
    # assert_equal(0,cobjs.classes.size)
  end

  def test_functions
    xml = TexInfoXMLParser.new(TEXIXML)
    cobjs = xml.cobjs  # invokes parser
    function = cobjs.functions.first
    assert_equal("open_celfile",function.name)
    assert_equal("<ref refid=\"structCELOBJECT\" kindref=\"compound\">CELOBJECT</ref>",function.type)
  end
 
end
