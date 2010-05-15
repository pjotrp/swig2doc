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
    print "\nSourceCParser reading #{fn}"
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

    # now we have the preamble + code, so let's split out the main remarks
    # The first block gets special treatment, so as to pull out the file
    # header remark

    blocklist.each do | b |
      (head,remark,tail) = split_remark_block(b[:preamble])
      h = {}
      h[:remark_head]   = head    # before the remark
      h[:remark]        = remark  # the main remark
      h[:declaration]   = tail    # the var or function definition 
      h[:code]          = b[:code]  
      objectlist.push h
    end
    objectlist
  end

  # Parse the source code and return set of objects for the module
  def cobjs
    objectlist = parse
    SourceCModule.new(@modulename,objectlist)
  end

  # Returns a list of tuples - where the first is the remark block
  # and the second the code block
  def split_on_curlybrace0(fn)
    list = []
    outside = ""   # outside curly
    inside  = ""   # inside curly
    inside_remarkblock = false
    inside_remark      = false
    inside_qq = false # double quoted
    inside_q = false  # single quoted 
    curly = 0
    lineno = 1
    prev_c = nil
    File.open(@fn).each_char do | c |
      if c == '{' and !inside_qq and !inside_q and !inside_remarkblock and !inside_remark
        # count curly block open
        curly += 1
      elsif c == '}' and !inside_qq and !inside_q and !inside_remarkblock and !inside_remark
        # count curly block close
        curly -= 1
        if curly == 0
          inside += c
          c = ''
          # write object out
          h = {:preamble => outside, :code => inside}
          list.push(h)
          inside = ""
          outside = ""
        end
      elsif c == '/' and prev_c == '/' and !inside_remarkblock and !inside_qq and !inside_remark
        inside_remark = true
      elsif c == '*' and prev_c == '/' and !inside_qq and !inside_remark
        # Open remark block on /*
        inside_remarkblock = true
      elsif c == '/' and prev_c == '*' and !inside_qq and !inside_remark
        # Close remark block on */
        inside_remarkblock = false
      elsif (c == '"') and prev_c != "\\" and !inside_remarkblock and !inside_q and !inside_remark
        # String boundary change happens outside remarks, and when there
        # is no prepending backslash
        inside_qq = !inside_qq
      elsif (c == "\'") and prev_c != "\\" and !inside_remarkblock and !inside_qq and !inside_remark
        # Char boundary change happens outside remarks, and when there
        # is no prepending backslash
        inside_q = !inside_q
      elsif c == "\n"
        inside_remark = false   # always at eol
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
    raise "#{fn} has mismatching curly braces" if curly != 0
    # print lineno," lines parsed"
    list
  end

  # takes buf and walks it backwards to split out the remark
  def split_remark_block(buf)
    lines = buf.split(/\n/)

    remark = []
    declaration = []

    inside_remark = false
    # working backwards
    while (line = lines.pop)
      # print line,"\n"
      short = line.strip
      if short.rindex("*/") == short.length-2
        # p [short.rindex("*/"),short.length-2]
        # starting in remark block
        inside_remark = true 
      elsif short.index("/*") == 0 
        # end of remark block (really the start)
        remark.push line
        break
      end
      if !inside_remark
        declaration.push line
      else
        remark.push line
      end
    end
    return lines,remark.reverse,declaration.reverse
  end
end


