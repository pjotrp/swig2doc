
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

  def doxy_description
    return '' if !doxy
    doxy.detaileddescription
  end

  def mapped?
    @swig != nil
  end

  def to_perl
    res = name() + '('
    if mapped?
      @swig.parameters.each do | p |
        res += '$'+p.name+','
      end
      res.chop!
    else
      res += '...'
    end
    res + ')'
  end

  def <=> func
    # Check whether functions are documented - make sure they are at the 
    # end of the list
    return -1 if !func.doxy 
    return 1 if !doxy
    doxy.line <=> func.doxy.line
  end
end

class CFunctions < Hash

  # Iterate an ordered list of functions - these are sorted by filename
  # and line number.
  def ordered
    list = []
    each do | name, func |
      list.push func
    end
    list.sort.each do | func |
      yield func.name, func
    end
  end
end

class CModule

  attr_reader :functions
  attr_accessor :name
  # , :variables, :classes, :structs

  def initialize 
    @functions = CFunctions.new
    @unmappedfunctions = {}
    @descriptions = []
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

  def add_description obj
    @descriptions.push obj
  end

  def each_func
    @functions.ordered do | name, func |
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

  def each_description
    @descriptions.each do | descr |
      yield descr
    end
  end
end
