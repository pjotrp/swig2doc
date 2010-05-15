# This class turns Source generated raw data into a nice object structure.

class SourceCvariable
  attr_reader :name, :type
  def initialize obj
    @name = obj['name']
    @type = obj['type']
  end
end

class SourceCparameter < SourceCvariable
end

class SourceCremark
  attr_reader :brief, :detailed

  def initialize obj
    @brief = obj['briefdescription']
    @detailed = obj['detaileddescription']
  end
end

class SourceCfunction
  attr_reader :name, :type, :briefdescription, :detaileddescription
  attr_reader :file, :line, :bodyfile, :bodystart, :bodyend

  # Initialize an object from a Hash 
  def initialize obj
    @is_includefile = false
    @is_includefile = true if obj['bodyfile']
    @name = obj['name']
    @type = obj['type']
    @briefdescription = obj['briefdescription']
    @detaileddescription = obj['detaileddescription']
    @file = obj['file']
    @line = obj['line']
    @bodyfile = obj['bodyfile']
    @bodystart = obj['bodystart']
    @bodyend = obj['bodyend']
    # p [@is_includefile, @bodyfile, @file]
  end

  # Merge the information from a second Source object
  def merge obj
    merge_item(@name,obj.name)
    merge_item(@type,obj.type)
    merge_item(@briefdescription,obj.briefdescription)
    merge_item(@detaileddescription,obj.detaileddescription)
    if !@is_includefile
      @file = obj.file
      @line = obj.line
      @bodystart = obj.bodystart
      @bodyend = obj.bodyend
      @bodyfile = obj.bodyfile
    end
    # p [2,@is_includefile,@bodyfile, @file]
  end

  def to_s
    @name
  end

  def <=> obj
    @name <=> obj.name
  end

private

  def merge_item var, value
    return value if var==nil
    if var != value 
      raise "var != value (#{var} != #{value})"
    end
    var
  end

end

class SourceCstruct
  def initialize obj
  end
end


