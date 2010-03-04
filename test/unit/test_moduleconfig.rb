require 'test/unit'

$srcpath = '../../'+File.dirname(__FILE__)
$: << $srcpath+'/lib'

CONFIG=$srcpath+'/test/data/affyio.yaml'

require 'config/moduleconfig'

class TestModuleConfig < Test::Unit::TestCase

  def test_yaml
    m = ModuleConfig.new(CONFIG)
    assert('affyio',m.modulename)
  end

end
