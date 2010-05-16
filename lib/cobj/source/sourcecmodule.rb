require 'cobj/source/sourcecobjs'

class SourceCModule

  attr_reader :filename, :name, :functions, :descriptions
  attr_reader :style # :basic, :emboss

  def initialize filename, name, objects
    @filename = filename
    @name = name
    @functions = []
    @descriptions = []
    # @source_objects = objects
    cobjs = convert_from_raw(objects)
    @style = guess_style(objects)
    print " (",@style,")"
    cobjs
  end

  # Convert a raw list of objects as generated from Source 
  # into a OOP object hierarchy
  def convert_from_raw objects
    objects.each do | obj |
      decl = obj[:declaration].join
      if decl.count("(") == 1 and decl.count(")") == 1
        @functions.push SourceCfunction.new(obj)
      else 
        @descriptions.push SourceCremark.new(obj)
      end
    end
  end

private

  # Find the documentation style of the source code
  #
  # :emboss
  #
  #   If a function remark has the format "/* @func funcname **"
  #
  def guess_style objs
    objs.each do | obj |
      remark = obj[:remark]
      return :emboss if remark and remark[0] =~ /\/\* @func \w+ \*\*/
    end
    :basic
  end
end
