<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<!-- Transforms the contents of each line element `l` into HTML -->

  <xsl:template match="/TEI/text/body//l" >
    <xsl:element name="span">
    <xsl:attribute name="id">
      <xsl:value-of select="@xml:id" />
    </xsl:attribute>
    <xsl:apply-templates />
    </xsl:element>
  </xsl:template>

  <xsl:template match="hi">
    <!-- send @rendition value to @id value  -->
    <xsl:element name="span">
      <xsl:attribute name="class">
        <xsl:value-of select="@rendition" />
      </xsl:attribute>
      <xsl:apply-templates />
    </xsl:element>
  </xsl:template>

  <xsl:template match="g">
    <xsl:element name="span">
    <xsl:attribute name="class">
      <xsl:value-of select="@ref" />
    </xsl:attribute>
    <!-- need to case on @ref and conditionally add real text inside this <span> -->

    </xsl:element>
  </xsl:template>

  <!-- copy everything else -->
  <xsl:template match="@* | node()">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
    </xsl:copy>
  </xsl:template>

</xsl:stylesheet>
