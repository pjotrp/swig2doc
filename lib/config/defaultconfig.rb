
require 'yaml'

class DefaultConfig

  def initialize fn
    @h = YAML::load(File.read(fn))
    @global = @h[:global]
  end

  def version
    @global[:version]
  end

  def vdate
    @global[:vdate]
  end

  def copyright
    @global[:copyright]
  end

  def copyright_msg
    "#{@global[:progname]} #{version} (#{vdate}) #{copyright}"
  end
end
