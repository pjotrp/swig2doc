
require 'yaml'

class ModuleConfig

  attr_reader :module

  def initialize fn
    @h = YAML::load(File.read(fn))
    @module = @h[:module]
  end

  def modulename
    @module[:name]
  end

end
