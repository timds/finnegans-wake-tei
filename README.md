# A TEI encoding of Finnegans Wake #

This is a lexical-only [TEI](http://www.tei-c.org) encoding of [Finnegans Wake](https://en.wikipedia.org/wiki/Finnegans_Wake).

The reference system is still evolving, and a `<refsDecl>` will be added when finalised.

Some XSLT scripts are included. You will need an XSLT3.0 and XPath 3.1 processor to use them (e.g. the free edition of [Saxon](http://www.saxonica.com/welcome/welcome.xml)).To convert to JSON, for example, run:

`saxon-he -s:finnegans-wake.xml -xsl:xslt/to-json.xsl -o:finnegans-wake.json`
