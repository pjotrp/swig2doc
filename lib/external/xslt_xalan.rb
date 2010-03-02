# Call external xalan
#

module XSLT_Xalan
  XALAN = '/usr/bin/xalan'

  def XSLT_Xalan::transform xslfn, xmlfn
    `#{XALAN} -xsl #{xslfn} -in #{xmlfn}`
  end
end

