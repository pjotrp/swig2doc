require 'cobj/source/sourcecobjs'

class SourceCModule

  attr_reader :filename, :name, :functions, :variables
  def initialize filename, name, objects
    @filename = filename
    @name = name
    @functions = []
    @variables = []
    convert_from_raw(objects)
  end

  # Convert a simple list of objects (Hash/Array) as generated from Source XML
  # into a OOP object hierarchy
  def convert_from_raw objects
    objects.each do | obj |
      # if obj['kind'] == 'function'
      #  @functions.push SourceCfunction.new(obj)
      #elsif obj['kind'] == 'variable'
      #  @variables.push SourceCvariable.new(obj)
      #elsif obj['kind'] == 'struct'
      #  @structs.push SourceCstruct.new(obj)
      #elsif obj['kind'] == 'global'
      #  @descriptions.push SourceCremark.new(obj)
      #else
      #  raise "Unknow type <#{obj['kind']}>"
      #end
    end
  end
end
