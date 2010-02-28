
require 'lib/cobj/cmodule'

class SourceTree 

  def initialize
    @swig            = []
    @doxy            = []
    @module          = CModule.new
  end

  # Add a list of cobjs type
  def add parser
    if parser.language and @language and parser.language != @language
      raise "Only one language is allowed! (now #{@language} and @{parser.language}"
    end
    type = parser.type
    cobjs = parser.cobjs
    case type 
      when :swig
        raise "Only one SWIG module is supported" if @swig.size > 1
        @module.name = cobjs.name
        @swig.push cobjs
      when :doxy
        @doxy.push cobjs
      else 
        raise "Unknown type"
    end
  end

  def analyse
    @swig.each do | mapped |
      mapped.functions.each do | mappedfunc |
        @module.add_swig_mapped_func mappedfunc
      end
    end
    @doxy.each do | doxy |
      doxy.functions.each do | doxyfunc |
        @module.add_doxy_func doxyfunc
      end
      doxy.descriptions.each do | descr |
        @module.add_description descr
      end
    end
  end

  def each_module
    yield @module  
  end

end
