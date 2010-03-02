require 'test/unit'

$srcpath = '../../'+File.dirname(__FILE__)
$: << $srcpath+'/lib'

DOXYXML=$srcpath+'/test/data/doxygen/xml/output/open_cdf.xml'
HTMLXSL=$srcpath+'/etc/xsl/doxy2html.xsl'

require 'output/transform/doxytransform'

class TestDoxyTransform < Test::Unit::TestCase

  def test_open_cdf
    print XSLT_Xalan::transform(HTMLXSL,DOXYXML)
  end

end
