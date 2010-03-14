
require 'external/xslt_xalan'

class DoxyTransform

  def initialize doxybuf
    @doxybuf = doxybuf
  end

  def to_s
    s = @doxybuf.dup
    # print s
    s = s.gsub(/<\/?(brief|detailed)description>/,'')
    s = s.gsub(/<\/?(programlisting|highlight|codeline)>/,'')
    s = s.gsub(/<\/?(parameteritem|parameternamelist)>/,'')
    s = s.gsub(/<parameterlist kind="\w+">/,"    Parameters:\n")
    s = s.gsub(/<parameterdescription>\n<para>/,"       ")
    s = s.gsub(/<parameterdescription>/,"       ")
    s = s.gsub(/<codeline>/,"\n")
    s = s.gsub(/<parametername>/,"     ")
    s = s.gsub(/<\/parameterdescription>/,"")
    s = s.gsub(/<\/parametername>/,": ")
    s = s.gsub(/<\/para>/,'')
    s = s.gsub(/<\/parameterlist>/,'')
    s = s.gsub(/<\/ref>/,'')
    s = s.gsub(/<highlight class="\w+">/,'')
    s = s.gsub(/<(simplesect) kind="return">(<para>)?/,"\n   Returns: ")
    s = s.gsub(/<(simplesect) kind="see">(<para>)?/,"\n   See also: ")
    s = s.gsub(/<(simplesect) kind="note">(<para>)?/,"\n   Note: ")
    s = s.gsub(/<(simplesect) kind="author">(<para>)?/,'    Author: ')
    # s = s.gsub(/<(simplesect) kind="\w+">/,'')
    s = s.gsub(/<\/simplesect>/,"\n\n")
    s = s.gsub(/<sp\/>/," ")
    s = s.gsub(/\&lt;/,'<')
    s = s.gsub(/\&gt;/,'>')
    s = s.gsub(/<ref.*?>/,'')
    s = s.gsub(/<para\/?>/,"\n\n")
    # Now remove all triple newlines
    s = s.gsub(/\n\s*(\n\s*)+\n/,"\n\n")
    s.strip
  end
end
