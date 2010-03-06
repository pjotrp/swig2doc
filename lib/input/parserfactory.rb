
require 'input/swigxmlparser'
require 'input/doxyxmlparser'

class ParserFactory

  attr_reader :type

  def initialize fn
    if fn =~ /\.yaml$/
      
    else
      File.open(fn) do | f |
        s = f.gets
        s += f.gets
        s += f.gets
        case s
          when /<doxygen/
            @xmlparser = DoxyXMLParser.new(fn)
            @type   = :doxy
          when /<top/
            @xmlparser = SwigXMLParser.new(fn)
            @type   = :swig
          else
            raise "No parser for <#{fn}>"
        end
      end
    end
  end

  def cobjs
    @xmlparser.cobjs
  end

  def language
    @xmlparser.language
  end

  def modulename
    @xmlparser.modulename
  end
end
