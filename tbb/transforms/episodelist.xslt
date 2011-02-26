<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet  version="1.0" 
    extension-element-prefixes="xdjango"
    exclude-result-prefixes="xdjango"
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xdjango="http://djangoproject.com/template/xslt"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output 
        method="xml" 
        indent="yes" 
        omit-xml-declaration="yes"
        doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
        doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" />

    <xsl:template match="/">
        <html>
            <head>
                <title>time thing</title>
                <link href="/{xdjango:MEDIA_URL()}style.css" rel="stylesheet" type="text/css"/>
                <script src="/{xdjango:MEDIA_URL()}jquery-1.4.4.min.js"></script>
            </head>
            <body>
                <ul>
                    <xsl:for-each select="xdjango:episodes()//episode">
                        <li><a href="/e/{@name}"><xsl:value-of select="@name"/></a></li>
                    </xsl:for-each>
                </ul>
            </body>
        </html>
    </xsl:template>

</xsl:stylesheet>
