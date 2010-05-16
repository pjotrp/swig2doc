# This class turns Source generated raw data into a nice object structure.

class SourceCobject 

  attr_reader :remark, :remark_prefix, :declaration, :code
  def initialize obj
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
  def brief
  end

  def detailed
  end

end

class SourceCfunction < SourceCobject
  def name
  end

  def doxy_remark
    r = @remark.dup
    r[0] = "/*!"
    r.join("\n")+"\n"
  end
end

