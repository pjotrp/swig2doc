class CWriter

  def initialize(cmodule)
    @cmodule = cmodule
  end

  def write path
    fn = path + '/' + @cmodule.filename
    print "\nWriting #{fn}..."
    Dir.mkdir(path) if !File.directory?(path)

    objs = @cmodule
    File.open(fn,"w") do | f |
      objs.descriptions.each do | d |
        f.print d.to_doxy
      end
      objs.functions.each do | func |
        f.print func.to_doxy
      end
      f.print "\n"
    end
  end

  # Write the original file (for testing)
  def write_original path
    fn = path + '/' + @cmodule.filename
    print "\nWriting #{fn}..."
    Dir.mkdir(path) if !File.directory?(path)

    objs = @cmodule
    File.open(fn,"w") do | f |
      objs.descriptions.each do | d |
        f.print d.to_doxy
      end
      objs.functions.each do | func |
        f.print func.to_doxy
      end
      f.print "\n"
    end
  end
end
