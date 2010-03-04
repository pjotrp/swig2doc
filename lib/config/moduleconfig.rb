
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

  def paths
    @module[:paths]
  end

  def expand_filename s
    paths.each do | var, path |
      s.gsub!(/\$#{var}/,path)
    end
    s
  end

end
