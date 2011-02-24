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
                <script src="/{xdjango:MEDIA_URL()}swfobject.js"></script>
                <script src="/{xdjango:MEDIA_URL()}jquery-1.4.4.min.js"></script>
                <script src="/{xdjango:MEDIA_URL()}player.js"></script>
                <script src="/{xdjango:MEDIA_URL()}moment.js"></script>
                <script type="text/javascript" language="javascript">
                    params = {
                    "allowScriptAccess": "always",
                    "wmode": "opaque",
                    "bgcolor": "#ffffff"
                    };
                    swfobject.embedSWF("/<xsl:value-of select="xdjango:MEDIA_URL()"/>player.swf", "player", "0px", "0px", "10.0.0", null, "", params);
                </script>
            </head>
            <body>
                <xsl:call-template name="episode"/>
                <xsl:call-template name="form"/>
            </body>
        </html>
    </xsl:template>

    <xsl:template name="episode">
        <a id="audio" href="{xdjango:episode.url()}">audio</a>
        <div id="player">
        </div>
        <button id="playctrl">play</button>
        <button id="skipback">&lt;&lt;</button>
        <button id="skipfwd">&gt;&gt;</button>
        <button id="timectrl">time?</button>
        <span id="currenttimepanel">?</span>
    </xsl:template>

    <xsl:template name="form">
        <xsl:comment>
            <xsl:copy-of select="xdjango:comment()"/>
        </xsl:comment>
        <form id="comment" method="POST" >
            <input type="hidden" name="episode" value="{xdjango:episode.id()}"/>
            <input type="hidden" name="time" value=""/>
            <fieldset id="commentform">
                <label for="comment">comment: </label>
                <textarea id="comment" name="comment" cols="40"></textarea>
                <label for="author">author: </label>
                <input type="text" name="author" value=""/>
                <input type="submit" name="doit" value="make comment"/>
            </fieldset>
        </form>
    </xsl:template>

</xsl:stylesheet>
