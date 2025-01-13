<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    version="1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:doc="http://www.example.org/document"
    exclude-result-prefixes="doc">

    <xsl:strip-space elements="*"/>

    <xsl:output method="text" encoding="UTF-8"/>
    
    <xsl:template match="/">
        <!-- YAML -->
        <xsl:text>---&#10;</xsl:text>
        
            <!-- Title -->
            <xsl:text>title: "</xsl:text>
            <xsl:value-of select="normalize-space(doc:Document/doc:Metadata/doc:Title)"/>
            <xsl:text>"&#10;</xsl:text>
            
            <!-- Description -->
            <xsl:text>description: "</xsl:text>
            <xsl:value-of select="normalize-space(doc:Document/doc:Metadata/doc:Description)"/>
            <xsl:text>"&#10;</xsl:text>
            
            <!-- Author -->
            <xsl:text>author: "</xsl:text>
            <xsl:for-each select="doc:Document/doc:Metadata/doc:Authors/doc:Author">
                <xsl:value-of select="normalize-space(doc:Name)"/>
                <xsl:if test="position() != last()">
                    <xsl:text>, </xsl:text>
                </xsl:if>
            </xsl:for-each>
            <xsl:text>"&#10;</xsl:text>
            
            <!-- Date -->
            <xsl:text>date: "</xsl:text>
            <xsl:value-of select="normalize-space(doc:Document/doc:Metadata/doc:PublicationDate)"/>
            <xsl:text>"&#10;</xsl:text>
            
            <!-- Tags -->
            <xsl:text>tags:</xsl:text>
            <xsl:text>&#10;</xsl:text>
            <xsl:for-each select="doc:Document/doc:Metadata/doc:Keywords/doc:Keyword">
                <xsl:text>  - </xsl:text>
                <xsl:value-of select="normalize-space(.)"/>
                <xsl:text>&#10;</xsl:text>
            </xsl:for-each>
        
        <!-- Chiusura YAML -->
        <xsl:text>---</xsl:text>
        <xsl:text>&#10;&#10;</xsl:text>
    
        <!-- HEADLINE -->
        <xsl:value-of select="concat('# ', normalize-space(doc:Document/doc:Headline))"/>
        <xsl:text>&#10;&#10;</xsl:text>
    
        <!-- Sezioni -->
        <xsl:for-each select="doc:Document/doc:Body/doc:Section">
            <xsl:value-of select="concat('### ', normalize-space(doc:SectionTitle))"/>
            <xsl:text>&#10;&#10;</xsl:text>
    
            <!-- Paragrafi -->
            <xsl:for-each select="doc:Paragraph">
                <xsl:value-of select="normalize-space(.)"/>
                <xsl:text>&#10;&#10;</xsl:text>
            </xsl:for-each>
    
            <!-- Immagini in Markdown -->
            <xsl:for-each select="doc:Image">
                <xsl:value-of select="concat('![', normalize-space(@alt), '](', normalize-space(@src), ')')"/>
                <xsl:text>&#10;&#10;</xsl:text>
            </xsl:for-each>
        </xsl:for-each>
    
        <!-- Suggestion -->
        <xsl:if test="doc:Document/doc:Suggestion">
            <xsl:text>## Suggerimento&#10;&#10;</xsl:text>
            
            <!-- Description -->
            <xsl:value-of select="normalize-space(doc:Document/doc:Suggestion/doc:Description)"/>
            <xsl:text>&#10;&#10;</xsl:text>
            
            <!-- Ragioni -->
            <xsl:text>### Ragioni&#10;&#10;</xsl:text>
            <xsl:for-each select="doc:Document/doc:Suggestion/doc:Reason/doc:Detail">
                <xsl:text>- </xsl:text>
                <xsl:value-of select="normalize-space(.)"/>
                <xsl:text>&#10;</xsl:text>
            </xsl:for-each>
            <xsl:text>&#10;</xsl:text>

            <!-- Come fare -->
            <xsl:text>### Come fare&#10;&#10;</xsl:text>
            <xsl:for-each select="doc:Document/doc:Suggestion/doc:HowTo/doc:Step">
                <xsl:value-of select="position()"/>
                <xsl:text>. </xsl:text>
                <xsl:value-of select="normalize-space(.)"/>
                <xsl:text>&#10;</xsl:text>
            </xsl:for-each>
            <xsl:text>&#10;</xsl:text>
        </xsl:if>

        <!-- Bibliografia -->
        <xsl:if test="doc:Document/doc:Bibliography/doc:Reference">
            <xsl:text>## Bibliografia&#10;&#10;</xsl:text>
            
            <xsl:for-each select="doc:Document/doc:Bibliography/doc:Reference">
                <xsl:text>- *[</xsl:text>
                <xsl:value-of select="normalize-space(doc:Title)"/>
                <xsl:text>](</xsl:text>
                <xsl:choose>
                    <xsl:when test="doc:URL">
                        <xsl:value-of select="normalize-space(doc:URL)"/>
                    </xsl:when>
                    <xsl:when test="doc:DOI">
                        <xsl:text>https://doi.org/</xsl:text>
                        <xsl:value-of select="normalize-space(doc:DOI)"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>#</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
                <xsl:text>)*</xsl:text>
                <xsl:text>&#10;</xsl:text>
            </xsl:for-each>
        </xsl:if>

    </xsl:template>

</xsl:stylesheet>