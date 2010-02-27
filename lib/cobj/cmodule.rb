
class CFunction

  attr_reader :name, :swig, :doxy

  def initialize name
    @name = name
  end

  def add_swig swig
    raise "You can only add one swig for #{@swig.name}" if @swig != nil
    @swig = swig
  end

  def add_doxy doxy
    if @doxy
      @doxy.merge(doxy)
    else
      @doxy = doxy
    end
  end

  def mapped?
    @swig != nil
  end
end

class CModule

  attr_reader :functions
  attr_accessor :name
  # , :variables, :classes, :structs

  def initialize 
    @functions = {}
    @unmappedfunctions = {}
    # @variables = []
    # @classes   = []
    # @structs   = []
  end

  def add_swig_mapped_func func
    raise "Function mapped twice #{func.name}" if @functions[func.name]
    cfunc = CFunction.new(func.name)
    cfunc.add_swig func
    @functions[func.name] = cfunc
  end

  def add_doxy_func func
    if @functions[func.name] 
      @functions[func.name].add_doxy(func)
    else
      cfunc = CFunction.new(func.name)
      cfunc.add_doxy func
      @functions[func.name] = cfunc
    end
  end

  def each_func
    @functions.each do | name, func |
      yield func
    end
  end

  def each_mapped_func
    each_func do | func |
      yield func if func.mapped?
    end
  end

  def each_unmapped_func
    each_func do | func |
      yield func if !func.mapped?
    end
  end

end
