<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet  version="1.0"
                xmlns="http://www.w3.org/1999/xhtml"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- 

     This XSLT can transform a page of the techgrumps website into a django load file 

     see the README.creole for details.

-->

<xsl:output method="xml" indent="yes"/>

<xsl:template match="/">
    <django-objects version="1.0">
        <xsl:for-each select="//a[@rel='bookmark']">
            <xsl:if test="../..//a[text()='Download MP3']/@href">
                <object pk="{position()}" model="metaize.episode">
                    <field type="CharField" name="url"><xsl:value-of select="../..//a[text()='Download MP3']/@href"/></field>
                    <field type="TextField" name="name"><xsl:value-of select="text()"/></field>
                </object>
            </xsl:if>
        </xsl:for-each>
    </django-objects>
</xsl:template>

</xsl:stylesheet>
