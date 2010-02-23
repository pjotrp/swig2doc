# This class turns Doxy generated raw data into a nice object structure.

class DoxyCvariable
  attr_reader :name, :type
  def initialize obj
    @name = obj['name']
    @type = obj['type']
  end
end

class DoxyCparameter < DoxyCvariable
end

class DoxyCfunction
  attr_reader :name, :type, :parameters
  def initialize obj
    @name = obj['name']
    @decl = obj['decl']
    @type = obj['type']
    @parameters = []
    obj['parmlist'].each do | parameter |
      @parameters.push DoxyCparameter.new(parameter)
    end
  end

  def to_s
    @name
  end

  def <=> obj
    @name <=> obj.name
  end
end

class DoxyCstruct
  def initialize obj
  end
end


