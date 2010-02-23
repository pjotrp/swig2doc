require 'cobj/doxy/doxycobjs'

class DoxyCModule

  attr_reader :name, :functions, :variables, :classes, :structs
  def initialize name, objects
    @name = name
    @functions = []
    @variables = []
    @classes   = []
    @structs   = []
    convert_from_raw(objects)
  end

  # Convert a simple list of objects (Hash/Array) as generated from Doxy XML
  # into a OOP object hierarchy
  def convert_from_raw objects
    objects.each do | obj |
      if obj['kind'] == 'function'
        @functions.push DoxyCfunction.new(obj)
      elsif obj['kind'] == 'variable'
        @variables.push DoxyCvariable.new(obj)
      elsif obj['kind'] == 'struct'
        @structs.push DoxyCstruct.new(obj)
      else
        raise "Unknow type <#{obj['kind']}>"
      end
    end
  end
end
