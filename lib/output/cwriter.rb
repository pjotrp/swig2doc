class CWriter

  def initialize(cmodule)
    @cmodule = cmodule
  end

  def write path
    fn = path + '/' + @cmodule.filename
    print "\nWriting #{fn}..." if !$options.quiet
    Dir.mkdir(path) if !File.directory?(path)

    objs = @cmodule
    File.open(fn,"w") do | f |
      # Treat the first description differently
      if objs.descriptions.size > 0
        f.print objs.descriptions.first.to_doxy_header
        f.print "\n/*@{*/\n"
        objs.descriptions[1..-1].each do | d |
          f.print d.to_doxy
        end
      else
        print "Warning #{fn} is missing a header!\n"
      end
      objs.functions.each do | func |
        f.print func.to_doxy
      end
      f.print "\n/*@}*/\n"
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
