
require 'yaml'

class ModuleConfig

  attr_reader :module

  def initialize fn
    @h = YAML::load(File.read(fn))
    @module = @h[:module]
  end

  def module_name
    @module[:name]
  end

  def module_version
    v = @module[:version]
    return res if (res = readit(v[:file],v[:regex]) != nil)
    @module[:version]
  end

  def module_author
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

  def readit(fn,regex=nil)
    buf = File.new(fn).read
    return buf.strip if regex == nil
    buf.split(/\r/)
    p buf
  end
end
