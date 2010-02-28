<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
    xmlns:xalan="http://xml.apache.org/xalan"
    exclude-result-prefixes="xalan"
    >

  <xsl:template match="/">
    <xsl:apply-templates />
  </xsl:template>

  <xsl:template match="detaileddescription">
    <xsl:apply-templates />
  </xsl:template>
 
  <xsl:template match="programlisting">
    <div class="programlisting">
      <xsl:apply-templates />
    </div>
  </xsl:template>

  <xsl:template match="highlight">
    <xsl:apply-templates />
  </xsl:template>

  <xsl:template match="codeline">
    <xsl:apply-templates /><br />
  </xsl:template>


  <xsl:template match="sp">_<xsl:apply-templates /></xsl:template>
 
  <xsl:template match="para"><p><xsl:apply-templates /></p></xsl:template>
 
  <xsl:template match="node()|@*">
    <xsl:copy>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates/>
    </xsl:copy>
  </xsl:template>

</xsl:stylesheet>              


