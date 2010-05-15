# Parse a C source code file and transform into Cobjs.
#
# In the first round the source is split into comments+source blocks, 
# based on level 0 curly braces. Next each of these blocks is parsed
# into a SourceCobj.
#
# This code is used by transform2doxy

class SourceCParser

  attr_reader :reader, :language, :modulename

  # Prepare and open a Sourcegen C file
  def initialize fn
    print "SourceCParser reads #{fn}\n"
    @fn = fn
    @language = 'C'
    @modulename = nil
  end

  # Tell if this is a Source document - this has to be called before 
  # any other reads!
  def cfile?
    @name =~ /\.(c|cpp|h|hpp|cxx)$/i
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


