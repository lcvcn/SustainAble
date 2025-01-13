<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    version="1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:doc="http://www.example.org/document"
    exclude-result-prefixes="doc">

    <xsl:output method="html" encoding="UTF-8"/>

    <xsl:template match="/">
        <html>
            <head>
                <title>
                    <xsl:text>🌱 SustainAble</xsl:text>
                </title>
                <link rel="stylesheet" type="text/css" href="style.css"/>
            </head>
            <body>
                <!-- Logo -->
                <div class="logo">
                    <xsl:text>🌱 SustainAble</xsl:text>
                </div>

                <!-- Title -->
                <div class="title">
                    <xsl:value-of select="normalize-space(doc:Document/doc:Headline)"/>
                </div>

                <!-- Subtitle -->
                <div class="subtitle">
                    <xsl:value-of select="normalize-space(doc:Document/doc:IntroMessage)"/>
                </div>

                <!-- Chart -->
                <div class="chart-space">
                    <img src="inserireManualmente.png" alt="inserireManualmente.png" />
                </div>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>