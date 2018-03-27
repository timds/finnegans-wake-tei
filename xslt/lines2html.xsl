<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="3.0"
                expand-text="yes">
  <!-- Transforms the contents of each line element `l` into HTML -->

  <xsl:template match="l">
    <span id="{@xml:id}">
      <xsl:apply-templates />
    </span>
  </xsl:template>

  <xsl:template match="hi">
    <!-- send @rendition value to @id value  -->
    <span class="{@rendition}">
      <xsl:apply-templates />
    </span>
  </xsl:template>

  <xsl:template match="g">
    <span class="{@ref}">
      <!-- need to case on @ref and conditionally add real text inside this <span> -->
      <xsl:apply-templates />
    </span>
  </xsl:template>

  <!-- copy everything else -->
  <xsl:template match=".">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
    </xsl:copy>
  </xsl:template>

</xsl:stylesheet>
