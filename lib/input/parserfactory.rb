
require 'input/swigxmlparser'
require 'input/doxyxmlparser'

class ParserFactory

  def initialize fn
    File.open(fn) do | f |
      s = f.gets
      s += f.gets
      s += f.gets
      case s
        when /<doxygen/
          @parser = DoxyXMLParser.new(fn)
        when /<top/
          @parser = SwigXMLParser.new(fn)
        else
          raise "No parser for <#{fn}>"
      end
    end
  end

  def cmodule
    @parser.cmodule
  end

end
