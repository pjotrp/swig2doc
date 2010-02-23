
class CModule

  attr_reader :name, :functions, :variables, :classes, :structs
  def initialize name, objects
    @name = name
    @functions = []
    @variables = []
    @classes   = []
    @structs   = []
  end

end
