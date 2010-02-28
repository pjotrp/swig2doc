require 'test/unit'

$srcpath = '../../'+File.dirname(__FILE__)
$: << $srcpath+'/lib'

DOXYXML=$srcpath+'/test/data/doxygen/xml/output/open_cdf.xml'

require 'output/transform/doxyxml'

class TestDoxyTransform < Test::Unit::TestCase

  def test_open_cdf
    true
  end

end
