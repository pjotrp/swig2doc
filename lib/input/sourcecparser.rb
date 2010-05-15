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
    @fn =~ /\.(c|cpp|h|hpp|cxx)$/i
  end

  # Parse the Source C and turn the information into a simple object list
  def parse
    objectlist = []
    if !cfile?
      raise "#{@fn} is not a Source C document!"
    end
    blocklist = split_on_curlybrace0(@fn)
    blocklist.each do | b |
      print "\n>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<<<<\n"
      print b
    end
    objectlist
  end

  # Parse the source code and return set of objects for the module
  def cobjs
    objectlist = parse
    SourceCModule.new(@modulename,objectlist)
  end

  def split_on_curlybrace0(fn)
    list = []
    outside = ""   # outside curly
    inside  = ""   # inside curly
    inside_remarkblock = false
    inside_qq = false
    curly = 0
    lineno = 1
    prev_c = nil
    File.open(@fn).each_char do | c |
      if c == '{' and !inside_qq and !inside_remarkblock
        # count curly block open
        curly += 1
      elsif c == '}' and !inside_qq and !inside_remarkblock
        # count curly block close
        curly -= 1
        if curly == 0
          inside += c
          c = ''
          # write object out
          list.push([outside,inside])
          inside = ""
          outside = ""
        end
      elsif c == '*' and prev_c == '/' and !inside_qq
        # Open remark block on /*
        inside_remarkblock = true
        print "/*"
      elsif c == '/' and prev_c == '*' and !inside_qq
        # Close remark block on */
        inside_remarkblock = false
        print "*/"
      elsif (c == '"') and prev_c != "\\" and !inside_remarkblock
        # String boundary change happens outside remarks, and when there
        # is no prepending backslash
        inside_qq = !inside_qq
        print prev_c,c,inside_qq,"\n"
      elsif c == "\n"
        lineno += 1
      end
      raise "Problem with source file #{fn} at line #{lineno}" if curly < 0
      if curly > 0
        inside += c
      else
        outside += c
      end
      prev_c = c
    end
    print lineno," lines parsed"
    list
  end
end


