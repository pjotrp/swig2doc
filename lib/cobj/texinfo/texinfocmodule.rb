require 'cobj/texinfo/texinfocobjs'

class TexInfoCModule

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

  # Convert a simple list of objects (Hash/Array) as generated from TexInfo XML
  # into a OOP object hierarchy
  def convert_from_raw objects
    objects.each do | obj |
      if obj['kind'] == 'function'
        @functions.push TexInfoCfunction.new(obj)
      elsif obj['kind'] == 'variable'
        @variables.push TexInfoCvariable.new(obj)
      elsif obj['kind'] == 'struct'
        @structs.push TexInfoCstruct.new(obj)
      elsif obj['kind'] == 'global'
        @descriptions.push TexInfoCremark.new(obj)
      else
        raise "Unknow type <#{obj['kind']}>"
      end
    end
  end
end
