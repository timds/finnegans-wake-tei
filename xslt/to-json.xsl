<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet version="3.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:j="http://www.w3.org/2005/xpath-functions"
                expand-text="yes">
  <xsl:output method="json" indent="yes"/>
  <xsl:preserve-space elements="l"/>
  <xsl:mode on-no-match="shallow-skip"/>

  <xsl:template name="toJSON">
    <xsl:param name="json"/>
    {xml-to-json($json)}
  </xsl:template>

  <xsl:template match="/TEI/text/body">
    <xsl:call-template name="toJSON">
      <xsl:with-param name="json">
        <j:map>
          <xsl:apply-templates/>
        </j:map>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="div[@type='book']">
    <j:map key="{@n}">
      <xsl:apply-templates/>
    </j:map>
  </xsl:template>

  <xsl:template match="div[@type='chapter']">
    <j:map key="{@n}">
      <xsl:apply-templates/>
    </j:map>
  </xsl:template>

  <xsl:template match="div[@type='page'][not(@subtype)]">
    <j:map key="{@n}">
      <j:string key="id">{@n}</j:string>
      <j:string key="kind">FWPageNormal</j:string>
      <j:array key="lines">
        <xsl:apply-templates/>
      </j:array>
    </j:map>
  </xsl:template>

  <xsl:template match="div[@type='page'][@subtype='C10' or @subtype='C10-wide' or @subtype='C10-287']">
    <j:map key="{@n}">
      <j:string key="kind">FWPageC10</j:string>
      <j:string key="id">{@n}</j:string>
      <j:array key="centre">
        <xsl:apply-templates select="div[@type='C10-C' or @type='C10-C-wide']"/>
      </j:array>
      <j:array key="leftColumn">
        <xsl:apply-templates select="div[@type='C10-L']/ab"/>
      </j:array>
      <j:array key="rightColumn">
        <xsl:apply-templates select="div[@type='C10-R']/ab"/>
      </j:array>
      <j:array key="footnotes">
        <xsl:apply-templates select="div[@type='C10-F']/ab"/>
      </j:array>
    </j:map>
  </xsl:template>

  <xsl:template match="div[@type='C10-F' or @type='C10-R' or @type='C10-L']/ab">
    <j:map>
      <j:string key="id">{@xml:id}</j:string>
      <xsl:choose>
        <xsl:when test="@corresp">
          <j:string key="corresp">{@corresp}</j:string>
        </xsl:when>
      </xsl:choose>
      <j:array key="lines">
        <xsl:apply-templates/>
      </j:array>
    </j:map>
  </xsl:template>

  <xsl:template match="l">
    <j:array>
      <xsl:apply-templates/>
    </j:array>
  </xsl:template>

  <xsl:template match="l//hi">
    <j:map>
      <j:string key="rendition">{substring-after(@rendition, '#')}</j:string>
      <j:array key="children">
        <xsl:apply-templates/>
      </j:array>
    </j:map>
  </xsl:template>

  <xsl:template match="self::text()[ancestor::l]">
    <j:string>{self::text()}</j:string>
  </xsl:template>

</xsl:stylesheet>
