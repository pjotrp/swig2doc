
class CFunction

  attr_reader :name

  def initialize swigfunc
    @swig = swigfunc
    @name = swigfunc.name
  end

end

class CModule

  attr_reader :functions
  attr_accessor :name
  # , :variables, :classes, :structs

  def initialize 
    @functions = {}
    # @variables = []
    # @classes   = []
    # @structs   = []
  end

  def add_swig_mapped_func func
    raise "Function mapped twice #{func.name}" if @functions[func.name]
    @functions[func.name] = CFunction.new(func)
  end

  def each_func
    @functions.each do | name, func |
      yield func
    end
  end
end
