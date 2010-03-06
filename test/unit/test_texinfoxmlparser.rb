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
    memberdef = reader.get_element_with_attributes('memberdef')
    assert_equal('function',memberdef.attributes['kind'])
    reader.xml.read
    memberdef = reader.get_element_with_attributes('memberdef')
    assert_equal('function',memberdef.attributes['kind'])
    reader.xml.read
    reader.each_element_tree("memberdef",nil,nil) do | type, tree |
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
