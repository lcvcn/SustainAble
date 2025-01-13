<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    version="1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:doc="http://www.example.org/document"
    exclude-result-prefixes="doc">

    <xsl:strip-space elements="*"/>

    <xsl:output method="text" encoding="UTF-8"/>
    
    <xsl:template match="/">
        
        <!-- Title -->
        <xsl:text>📘 </xsl:text>
        <xsl:value-of select="normalize-space(doc:Document/doc:Metadata/doc:Title)"/>
        <xsl:text>&#10;</xsl:text>
        
        <!-- Author -->
        <xsl:text>✍️ </xsl:text>
        <xsl:for-each select="doc:Document/doc:Metadata/doc:Authors/doc:Author">
            <xsl:value-of select="normalize-space(doc:Name)"/>
            <xsl:if test="position() != last()">
                <xsl:text>, </xsl:text>
            </xsl:if>
        </xsl:for-each>
        <xsl:text>&#10;</xsl:text>
        
        <!-- Date -->
        <xsl:text>📅 </xsl:text>
        <xsl:value-of select="normalize-space(doc:Document/doc:Metadata/doc:PublicationDate)"/>
        <xsl:text>&#10;</xsl:text>

        <xsl:text>🌐 https://luca-vicini.gitbook.io/sustainable</xsl:text>
        
        <xsl:text>&#10;&#10;</xsl:text>

        <!-- HashTags -->
        <xsl:for-each select="doc:Document/doc:Metadata/doc:Keywords/doc:Keyword">
            <xsl:text>#</xsl:text>
            <xsl:value-of select="translate(., ' ', '')"/>
            <xsl:text> </xsl:text>
        </xsl:for-each>

    </xsl:template>

</xsl:stylesheet>