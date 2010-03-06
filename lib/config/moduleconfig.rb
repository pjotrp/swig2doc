
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
    res = nil
    return res if (res = readit(v[:file],v[:regex]))
    @module[:version]
  end

  def module_author
    v = @module[:author]
    res = nil
    return res if (res = readit(v[:file],v[:regex]))
    @module[:author]
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
    # p ['regex',regex]
    buf = File.new(expand_filename(fn)).read
    return buf.strip if regex == nil
    buf.split(/\n/).each do | s |
      if s =~ /#{regex}/
        if $1 
          return $1 
        else
          return $'
        end
      end
    end
    nil
  end
end
