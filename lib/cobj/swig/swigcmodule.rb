require 'cobj/swig/swigcobjs'

class SwigCModule

  attr_reader :name, :language, :functions, :variables, :classes, :structs
  def initialize name, language, objects
    @name = name
    @language = language
    @functions = []
    @variables = []
    @classes   = []
    @structs   = []
    convert_from_raw(objects)
  end

  # Convert a simple list of objects (Hash/Array) as generated from SWIG XML
  # into a OOP object hierarchy
  def convert_from_raw objects
    objects.each do | obj |
      if obj['kind'] == 'function'
        @functions.push SwigCfunction.new(obj)
      elsif obj['kind'] == 'variable'
        @variables.push SwigCvariable.new(obj)
      elsif obj['kind'] == 'struct'
        @structs.push SwigCstruct.new(obj)
      else
        raise "Unknow type <#{obj['kind']}>"
      end
    end
  end
end
