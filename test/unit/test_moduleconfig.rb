require 'test/unit'

$srcpath = '../../'+File.dirname(__FILE__)
$: << $srcpath+'/lib'

CONFIG=$srcpath+'/test/data/affyio.yaml'

require 'config/moduleconfig'

class TestModuleConfig < Test::Unit::TestCase

  def test_yaml
    mc = ModuleConfig.new(CONFIG)
  end

end
