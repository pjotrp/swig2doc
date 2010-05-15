class CWriter

  def initialize(cobjs)
    @cobjs = cobjs
  end

  def write path
    fn = path + '/' + @cobjs.filename
    print "\nWriting #{fn}..."
    Dir.mkdir(path) if !File.directory?(path)
  end
end
