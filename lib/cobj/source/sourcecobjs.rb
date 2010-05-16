# This class turns Source generated raw data into a nice object structure.

class SourceCobject 

  attr_reader :remark, :remark_prefix, :declaration, :code
  def initialize obj
    @remark = obj[:remark]
    @remark_prefix = obj[:remark_prefix]
    @declaration = obj[:declaration]
    @code = obj[:code]
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
end

