require 'cobj/cobjs'

class CModule

  attr_reader :name, :functions, :variables, :classes, :structs
  def initialize name, objects
    @name = name
    @functions = []
    @variables = []
    @classes   = []
    @structs   = []
    convert_from_raw(objects)
  end

  def convert_from_raw objects
    objects.each do | obj |
      if obj['kind'] == 'function'
        @functions.push Cfunction.new(obj)
      elsif obj['kind'] == 'variable'
        @variables.push Cvariable.new(obj)
      elsif obj['kind'] == 'struct'
        @structs.push Cstruct.new(obj)
      else
        raise "Unknow type <#{obj['kind']}>"
      end
    end
  end
end
