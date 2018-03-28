<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet version="3.0" expand-text="yes"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="xml" indent="no"/>
  <xsl:mode on-no-match="shallow-copy"/>

  <xsl:template match="div[@type='C10-C']//
                       hi[@rendition='#sup']
                         [child::*[1][self::hi][@rendition='#small']]">
    <hi rendition="FootnoteNumber">{descendant::text()[string-length(.) = 1]}</hi>
  </xsl:template>

  <!-- <xsl:template match="div[@type='C10-C']//hi[@rendition='#sup']/child::*[1][self::hi][@rendition='#small']"> -->
  <!--   <xsl:apply-templates/> -->
  <!-- </xsl:template> -->

</xsl:stylesheet>
