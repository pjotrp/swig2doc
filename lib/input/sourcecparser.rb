class SourceCParser

  attr_reader :reader, :language, :modulename

  # Prepare and open a Sourcegen C file
  def initialize fn
    print C::LIBC_VERSION
    print "SourceCParser reads #{fn}\n"
    @fn = fn
    @language = 'C'
    @modulename = nil
  end

  # Tell if this is a Source document - this has to be called before 
  # any other reads!
  def cfile?
  end

  # Parse the Source C and turn the information into a simple object list
  def parse
    objectlist = []
    if !cfile?
      raise "#{@fn} is not a Source C document!"
    end
    objectlist
  end

  # Parse the source code and return set of objects for the module
  def cobjs
    objectlist = parse
    SourceCModule.new(@modulename,objectlist)
  end

end


