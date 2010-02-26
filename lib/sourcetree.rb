
class SourceTree 

  def initialize
    @swig         = []
    @doxy         = []        
  end

  # Add a list of cobjs type
  def add type, cobjs
    case type 
      when :swig
        @swig.push cobjs
      when :doxy
        @doxy.push cobjs
      else 
        raise "Unknown type"
    end
  end

  def analyse
    @swig.each do | mod |
       mod.functions.each do | func |
         p func.name
       end
    end
  end

  def each_module
   
  end

end
