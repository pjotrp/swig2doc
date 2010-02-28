<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
    xmlns:xalan="http://xml.apache.org/xalan"
    exclude-result-prefixes="xalan"
    xmlns="http://www.w3.org/1999/xhtml"
    >

  <xsl:template match="/">
  <html>
    <head>
      <link rel="stylesheet" media="screen" href="/maqi-skin/maqi_html.css" />
    </head>
    <body>
		<xsl:if test="$test != '0'">
			<font color="red">TEST VERSION</font> -- 
				<xsl:if test="$fetch != '0'">
					<font color="red"> FETCH</font> -- 
				</xsl:if>
				<xsl:if test="$geo != '0'">
					<font color="red"> GEO</font> -- 
				</xsl:if>
				<xsl:if test="$all != '0'">
					<font color="red"> ALL STATS</font> -- 
				</xsl:if>
		</xsl:if>
	
   <xsl:template match="version|date|hostname|user|file|channels|probes|calc|slice|consistency|consistentgenes">
    <tr class="headerrow">
      <td>
        <xsl:value-of select="name()" />
      </td>
      <td class="{name()}" colspan="{$columns}">
        <xsl:value-of select="text()"/>
      </td>
    </tr>
  </xsl:template>

   <xsl:template match="headers">
    <tr class="headers">
<xsl:apply-templates />
    </tr>
  </xsl:template>
 
  <xsl:template match="maqi/Toplist200">
    <tr class="tablerow">
      <td class="name"><xsl:value-of select="name()" />
      </td>
      <td colspan="{$columns}" align="left">
        <xsl:apply-templates />,
      </td>
    </tr>
  </xsl:template>
  
   <xsl:template match="node()|@*">
    <xsl:copy>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates/>
    </xsl:copy>
  </xsl:template>

</xsl:stylesheet>              


