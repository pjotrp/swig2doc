# This class turns SWIG generated raw data into a nice object structure.

class SwigCvariable
  attr_reader :name, :type
  def initialize obj
    @name = obj['name']
    @type = obj['type']
  end
end

class SwigCparameter < SwigCvariable
end

class SwigCfunction
  attr_reader :name, :type, :parameters
  def initialize obj
    @name = obj['name']
    @decl = obj['decl']
    @type = obj['type']
    @parameters = []
    obj['parmlist'].each do | parameter |
      @parameters.push SwigCparameter.new(parameter)
    end
  end

  def to_s
    @name
  end

  def <=> obj
    @name <=> obj.name
  end
end

class SwigCstruct
  def initialize obj
  end
end


