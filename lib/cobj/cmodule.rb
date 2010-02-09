

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
        @functions.push obj
      elsif obj['kind'] == 'variable'
        @variables.push obj
      elsif obj['kind'] == 'struct'
        @structs.push obj
      else
        raise "Unknow type <#{obj['kind']}>"
      end
    end
  end
end
