# This class turns SWIG generated raw data into a nice object structure.

class Cvariable
  attr_reader :name, :type
  def initialize obj
    @name = obj['name']
    @type = obj['type']
  end
end

class Cparameter < Cvariable
end

class Cfunction
  attr_reader :name, :type, :parameters
  def initialize obj
    @name = obj['name']
    @decl = obj['decl']
    @type = obj['type']
    @parameters = []
    obj['parmlist'].each do | parameter |
      @parameters.push Cparameter.new(parameter)
    end
  end

  def to_s
    @name
  end

  def <=> obj
    @name <=> obj.name
  end
end

class Cstruct
  def initialize obj
  end
end


