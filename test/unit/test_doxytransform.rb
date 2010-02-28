require 'test/unit'

$srcpath = '../../'+File.dirname(__FILE__)
$: << $srcpath+'/lib'

DOXYXML=$srcpath+'/test/data/doxygen/xml/output/open_cdf.xml'
HTMLXSL=$srcpath+'/etc/xsl/doxy2html.xsl'
XALAN='/usr/bin/xalan'

require 'output/transform/doxytransform'

class TestDoxyTransform < Test::Unit::TestCase

  def test_open_cdf
    print `#{XALAN} -xsl #{HTMLXSL} -in #{DOXYXML}`
  end

end
