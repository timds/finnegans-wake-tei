<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                expand-text="yes">
  <xsl:output method="xml" indent="yes"/>
  <xsl:mode on-no-match="shallow-copy"/>
  <xsl:strip-space elements="*"/>
  <xsl:preserve-space elements="l"/>

  <!--
      Matches footnote lines which are the first line of a specific footnote.
  -->
  <xsl:template match="l[parent::div[@type='C10-F']]
                       [child::text()[1][starts-with(., '    ')]]">
    <xsl:variable name="lineID" select="@xml:id"/>
    <xsl:variable name="footNum" select="hi[1][@rendition='#sup']"/>
    <xsl:variable name="pageID" select="'F'||substring($lineID, 2, 9)||'.'"/>
    <ab xml:id="{$pageID||$footNum}">
      <xsl:copy-of select="."/>
      <!--
          Selects the following footnote lines that are part of
          this particular footnote. Also preserves any <lb> elems.
      -->
      <xsl:copy-of
          select="following-sibling::*
                  [count(preceding-sibling::l[child::text()[1]
                                             [starts-with(., '    ')]])
                                             = number($footNum)]
                  [self::lb or text()[1][not(starts-with(., '    '))]]"/>
    </ab>
  </xsl:template>

  <!--
      Skip footnote lines that are a continuation of a footnote.
      These lines have been pulled in by the first template.
  -->
  <xsl:template match="*[parent::div[@type='C10-F']]
                        [not(child::text()[1][starts-with(., '    ')])]"/>

</xsl:stylesheet>
