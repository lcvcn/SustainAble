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
        
        <xsl:text>&#10;&#10;</xsl:text>
    
        <!-- Titolo -->
        <xsl:text>🌍 </xsl:text>
        <xsl:value-of select="normalize-space(doc:Document/doc:Headline)"/>
        <xsl:text> 🌱&#10;&#10;&#10;</xsl:text>
    
        <!-- Sezioni -->
        <xsl:for-each select="doc:Document/doc:Body/doc:Section">
            <xsl:text>📌 </xsl:text>
            <xsl:value-of select="normalize-space(doc:SectionTitle)"/>
            <xsl:text>&#10;&#10;</xsl:text>
    
            <!-- Paragrafi -->
            <xsl:for-each select="doc:Paragraph">
                <xsl:value-of select="normalize-space(.)"/>
                <xsl:text>&#10;&#10;</xsl:text>
            </xsl:for-each>
            <xsl:text>&#10;</xsl:text>
        </xsl:for-each>
    
        <!-- Suggestion -->
        <xsl:if test="doc:Document/doc:Suggestion">
            <xsl:text>💡 Suggerimento: </xsl:text>
            
            <!-- Description -->
            <xsl:value-of select="normalize-space(doc:Document/doc:Suggestion/doc:Description)"/>
            <xsl:text>&#10;&#10;</xsl:text>
            
            <!-- Cause -->
            <xsl:text>❓ Cause:&#10;</xsl:text>
            <xsl:for-each select="doc:Document/doc:Suggestion/doc:Reason/doc:Detail">
                <xsl:text>- </xsl:text>
                <xsl:value-of select="normalize-space(.)"/>
                <xsl:text>&#10;</xsl:text>
            </xsl:for-each>
            <xsl:text>&#10;</xsl:text>

            <!-- Come fare -->
            <xsl:text>🫵 Consigli pratici:&#10;</xsl:text>
            <xsl:for-each select="doc:Document/doc:Suggestion/doc:HowTo/doc:Step">
                <xsl:value-of select="position()"/>
                <xsl:text>. </xsl:text>
                <xsl:value-of select="normalize-space(.)"/>
                <xsl:text>&#10;</xsl:text>
            </xsl:for-each>
            <xsl:text>&#10;&#10;</xsl:text>
        </xsl:if>

        <!-- Citazioni -->
        <xsl:if test="doc:Document/doc:Bibliography/doc:Reference">
            <xsl:text>📖 Citazioni:&#10;</xsl:text>
            
            <xsl:for-each select="doc:Document/doc:Bibliography/doc:Reference">
                <xsl:text>📰 "</xsl:text>
                <xsl:value-of select="normalize-space(doc:Title)"/>
                <xsl:text>"</xsl:text>
                <xsl:text> | 🔗 </xsl:text>
                <xsl:choose>
                    <xsl:when test="doc:URL">
                        <xsl:value-of select="normalize-space(doc:URL)"/>
                    </xsl:when>
                    <xsl:when test="doc:DOI">
                        <xsl:text>https://doi.org/</xsl:text>
                        <xsl:value-of select="normalize-space(doc:DOI)"/>
                    </xsl:when>
                </xsl:choose>
                <xsl:text>.&#10;</xsl:text>
            </xsl:for-each>
        </xsl:if>

        <!-- HashTags -->
        <xsl:text>&#10;&#10;</xsl:text>
        <xsl:for-each select="doc:Document/doc:Metadata/doc:Keywords/doc:Keyword">
            <xsl:text>#</xsl:text>
            <xsl:value-of select="translate(., ' ', '')"/>
            <xsl:text> </xsl:text>
        </xsl:for-each>

    </xsl:template>

</xsl:stylesheet>