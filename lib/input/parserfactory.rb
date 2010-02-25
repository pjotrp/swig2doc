
require 'input/swigxmlparser'
require 'input/doxyxmlparser'

class ParserFactory

  def initialize fn
    File.open(fn) do | f |
      p f.gets
      p f.gets
      p f.gets
      @parser = SwigXMLParser.new(fn)
    end
  end

  def cmodule
    # @parser.cmodule
  end

end
