# This class turns Source generated raw data into a nice object structure.

module EmbossFunctionEdit

  # remove EMBOSS marker
  def removeDoubleAt list
    list.map { | s | s.gsub(/\@\@/,'') }  
  end

  def moveCategory list
    list.map { | s | s.gsub(/\@category/i,"@par Category:\n") }  
  end
end

class SourceCobject 

  attr_reader :remark, :remark_prefix, :declaration, :code
  def initialize obj, style, filename
    @style = style
    @filename = filename
    @remark = obj[:remark]
    @remark_prefix = obj[:remark_prefix]
    @declaration = obj[:declaration]
    @code = obj[:code]
  end

  def to_doxy
    ret = ""
    ret += @remark_prefix.join("\n")+"\n" if @remark_prefix
    ret += doxy_remark if @remark
    ret += @declaration.join("\n")+"\n" if @declaration
    ret += @code if @code
    ret
  end

  def doxy_remark 
    ret = ""
    ret += @remark.join("\n")+"\n" if @remark
    ret
  end
end

class SourceCremark < SourceCobject
  include EmbossFunctionEdit

  def brief
  end

  def detailed
  end

  # Change header remark to comply with Doxygen
  def to_doxy_header
    r = @remark.dup
    # Change the remark init for Doxygen
    r[0] = "/*!"
    r.insert(1,"@defgroup #{@style} #{@filename}")
    if @style == :emboss
      r = removeDoubleAt(r)
    end

    buf = r.join("\n")+"\n"
    buf
  end
end

class SourceCfunction < SourceCobject

  include EmbossFunctionEdit

  def name
  end

  def doxy_remark 
    r = @remark.dup
    # Change the remark init for Doxygen
    r[0] = "/*!"
    if @style == :emboss
      r = removeDoubleAt(r)
      r = moveCategory(r)
    end

    buf = r.join("\n")+"\n"
    buf
  end
end

