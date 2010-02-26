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
  attr_reader :name, :type, :briefdescription, :detaileddescription
  attr_reader :file, :line, :bodystart, :bodyend
  def initialize obj
    @name = obj['name']
    @type = obj['type']
    @briefdescription = obj['briefdescription']
    @detaileddescription = obj['detaileddescription']
    @file = obj['file']
    @line = obj['line']
    @bodystart = obj['bodystart']
    @bodyend = obj['bodyend']
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


