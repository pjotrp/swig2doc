
require 'input/swigxmlparser'
require 'input/doxyxmlparser'

class ParserFactory

  attr_reader :type

  def initialize fn
    File.open(fn) do | f |
      s = f.gets
      s += f.gets
      s += f.gets
      case s
        when /<doxygen/
          @parser = DoxyXMLParser.new(fn)
          @type   = :doxy
        when /<top/
          @parser = SwigXMLParser.new(fn)
          @type   = :swig
        else
          raise "No parser for <#{fn}>"
      end
    end
  end

  def cobjs
    @parser.cobjs
  end

end
