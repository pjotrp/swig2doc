class CWriter

  def initialize(list)
    @list = list
  end

  def write path
    Dir.mkdir(path) if !File.directory?(path)
  end
end
