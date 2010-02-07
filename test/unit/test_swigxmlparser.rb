require 'test/unit'

$srcpath = '../../'+File.dirname(__FILE__)
$: << $srcpath+'/lib'

SWIGXML=$srcpath+'/test/data/swig/perl_affyio_wrap.xml'

require 'input/swigxmlparser'

class TestSwigXMLParser < Test::Unit::TestCase

  def setup
    @xml = SwigXMLParser.new(SWIGXML)
  end

  def test_reader
    objects = @xml.objects
    assert_equal(29,objects.num_functions)
    assert_equal(145,objects.num_vars)
    assert_equal(20,objects.num_structs)
  end
 
end
