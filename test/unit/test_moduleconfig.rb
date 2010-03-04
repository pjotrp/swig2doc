require 'test/unit'

$srcpath = '../../'+File.dirname(__FILE__)
$: << $srcpath+'/lib'

CONFIGY=$srcpath+'/test/data/affyio.yaml'

require 'config/moduleconfig'

class TestModuleConfig < Test::Unit::TestCase

  def test_yaml
    m = ModuleConfig.new(CONFIGY)
    assert_equal('affyio',m.modulename)
    assert_equal('affyio',m.module[:name])
    assert_equal({'test'=>'../data'},m.module[:paths])
    assert_equal({'test'=>'../data'},m.paths)
    assert_equal('$test/DESCRIPTION',m.module[:version][:file])
    assert_equal('../data/DESCRIPTION',m.expand_filename(m.module[:version][:file]))
  end

end
