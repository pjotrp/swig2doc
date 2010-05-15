require 'cobj/source/sourcecobjs'

class SourceCModule

  attr_reader :name, :functions, :variables, :classes, :structs, :descriptions
  def initialize name, objects
    @name = name
    @functions = []
    @variables = []
    @classes   = []
    @structs   = []
    @descriptions = []
    convert_from_raw(objects)
  end

  # Convert a simple list of objects (Hash/Array) as generated from Source XML
  # into a OOP object hierarchy
  def convert_from_raw objects
    objects.each do | obj |
      if obj['kind'] == 'function'
        @functions.push SourceCfunction.new(obj)
      elsif obj['kind'] == 'variable'
        @variables.push SourceCvariable.new(obj)
      elsif obj['kind'] == 'struct'
        @structs.push SourceCstruct.new(obj)
      elsif obj['kind'] == 'global'
        @descriptions.push SourceCremark.new(obj)
      else
        raise "Unknow type <#{obj['kind']}>"
      end
    end
  end
end
