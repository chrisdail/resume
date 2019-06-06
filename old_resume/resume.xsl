<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
        xmlns:fo="http://www.w3.org/1999/XSL/Format"
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    
    <xsl:template match="/">
        <fo:root>
            <fo:layout-master-set>
                <fo:simple-page-master margin-bottom="1in" margin-left="1in" margin-right="1in"
                    margin-top="1in" master-name="simple" page-height="11in" page-width="8.5in">
                    <fo:region-body />
                </fo:simple-page-master>
            </fo:layout-master-set>
            
            <fo:page-sequence master-reference="simple">
                <fo:flow flow-name="xsl-region-body" font-family="Helvetica">
                    <xsl:apply-templates/>
                </fo:flow>
            </fo:page-sequence>
        </fo:root>
    </xsl:template>
    
    <!-- Name block -->
    <xsl:template match="person">
        <fo:block font-size="12pt" font-weight="bold" text-align="center">
            <xsl:value-of select="name"/>
        </fo:block>
        <fo:block font-size="12pt" text-align="center">
            <xsl:value-of select="street"/>
        </fo:block>
        <fo:block font-size="12pt" text-align="center">
            <xsl:value-of select="city"/>, <xsl:value-of select="province"/><xsl:text> </xsl:text><xsl:value-of select="postal-code"/>
        </fo:block>
        <fo:block font-size="12pt" text-align="center">
            <xsl:value-of select="phone"/>
        </fo:block>
        <fo:block font-size="12pt" text-align="center">
            <xsl:value-of select="email"/>
        </fo:block>
        <xsl:if test="citizen">
            <fo:block font-size="12pt" text-align="center">
                <xsl:value-of select="citizen"/>
            </fo:block>
        </xsl:if>
        <fo:block line-height="3px" text-align="center">
            <fo:leader leader-pattern="rule" leader-length="50%"/>
        </fo:block>
    </xsl:template>
    
    <xsl:template match="objectives">
        <xsl:if test="objective">
            <xsl:call-template name="title">
                <xsl:with-param name="title">Objective</xsl:with-param>
            </xsl:call-template>

            <fo:list-block provisional-distance-between-starts=".43in"
                provisional-label-separation=".1in" space-before=".1in">

                <xsl:apply-templates/>
            </fo:list-block>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="objective">
        <fo:list-item>
            <fo:list-item-label text-align="end" end-indent="label-end()">
                <fo:block font-size="10pt">•</fo:block>
            </fo:list-item-label>
            <fo:list-item-body start-indent="body-start()">
                <fo:block font-size="10pt"><xsl:value-of select="."/></fo:block>
            </fo:list-item-body>
        </fo:list-item>
    </xsl:template>
    
    <xsl:template match="education">
        <xsl:call-template name="title">
            <xsl:with-param name="title">Education</xsl:with-param>
        </xsl:call-template>

        <fo:table border="none" table-layout="fixed" keep-together="always">
            <fo:table-column column-width="3.25in"/>
            <fo:table-column column-width="3.25in"/>
            <fo:table-body>
                <xsl:apply-templates select="school"/>
            </fo:table-body>
        </fo:table>
        <fo:block/>
    </xsl:template>
    
    <xsl:template match="work">
        <xsl:call-template name="title">
            <xsl:with-param name="title">Experience</xsl:with-param>
        </xsl:call-template>
        
        <fo:table border="none" table-layout="fixed">
            <fo:table-column column-width="3.25in"/>
            <fo:table-column column-width="3.25in"/>
            <fo:table-body>
                <xsl:apply-templates select="job"/>
            </fo:table-body>
        </fo:table>
        <fo:block/>
    </xsl:template>
    
    <xsl:template match="job">
        <fo:table-row>
            <xsl:apply-templates select="title|dates"/>
        </fo:table-row>
        <fo:table-row>
            <xsl:apply-templates select="company|location"/>
        </fo:table-row>
        <fo:table-row>
            <fo:table-cell number-columns-spanned="2" height=".05in"/>
        </fo:table-row>
        <xsl:apply-templates select="description"/>
        <fo:table-row>
            <fo:table-cell number-columns-spanned="2" height=".1in"/>
        </fo:table-row>
    </xsl:template>
    
    <xsl:template match="description">
        <fo:table-row>
            <fo:table-cell number-columns-spanned="2">
                <fo:block font-size="9pt" text-align="left" padding-after=".05in"><xsl:value-of select="."/></fo:block>
            </fo:table-cell>
        </fo:table-row>
    </xsl:template>

    <xsl:template match="job/title|company|degree|institution">
        <fo:table-cell>
            <fo:block font-size="9pt" text-align="left" font-weight="bold" keep-with-next="always"><xsl:value-of select="."/></fo:block>
        </fo:table-cell>
    </xsl:template>
    
    <xsl:template match="dates|location">
        <fo:table-cell>
            <fo:block font-size="9pt" text-align="right" keep-with-next="always"><xsl:value-of select="."/></fo:block>
        </fo:table-cell>
    </xsl:template>
    
    <xsl:template match="school">
        <fo:table-row>
            <xsl:apply-templates select="degree|dates"/>
        </fo:table-row>
        <fo:table-row>
            <xsl:apply-templates select="institution|location"/>
        </fo:table-row>
        <fo:table-row>
            <fo:table-cell number-columns-spanned="2" height=".05in" keep-with-next="always"/>
        </fo:table-row>
        <fo:table-row>
            <fo:table-cell number-columns-spanned="2" keep-with-next="always">
                <fo:block font-size="9pt" text-align="left" keep-with-next="always"><xsl:value-of select="description"/></fo:block>
            </fo:table-cell>
        </fo:table-row>
        <fo:table-row>
            <fo:table-cell number-columns-spanned="2" height=".1in"/>
        </fo:table-row>
    </xsl:template>
    
    <xsl:template match="skills">
        <xsl:call-template name="title">
            <xsl:with-param name="title">Skills</xsl:with-param>
        </xsl:call-template>
        
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="skill-set">
        <fo:block font-size="10pt" font-weight="bold" keep-with-next="always"><xsl:value-of select="title"/></fo:block>
        <xsl:for-each select="description">
            <fo:block font-size="9pt" keep-with-next="always" padding-after=".05in"><xsl:value-of select="."/></fo:block>
        </xsl:for-each>
        <fo:block padding-after=".1in"/>
    </xsl:template>
    
    <xsl:template match="references">
        <xsl:call-template name="title">
            <xsl:with-param name="title">References</xsl:with-param>
        </xsl:call-template>
        
        <xsl:if test="count(reference) = 0">
            <fo:block font-size="10pt">Available Upon Request</fo:block>
        </xsl:if>
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="personal">
        <xsl:call-template name="title">
            <xsl:with-param name="title">Personal</xsl:with-param>
        </xsl:call-template>
        
        <fo:block font-size="10pt"><xsl:value-of select="interests"/></fo:block>
        <fo:block padding-after=".1in"/>
    </xsl:template>
    
    <xsl:template match="reference">
        <fo:block font-size="10pt" font-weight="bold" keep-with-next="always"><xsl:value-of select="name"/></fo:block>
        <xsl:for-each select="description">
            <fo:block font-size="9pt" keep-with-next="always" padding-after=".05in"><xsl:value-of select="."/></fo:block>
        </xsl:for-each>
        <fo:block padding-after=".1in"/>
    </xsl:template>
    
    <xsl:template name="title">
        <xsl:param name="title"/>
        <fo:block-container padding-before=".25in" padding-left=".1in" 
                width="2in" border-after-style="solid" border-after-width="1px">
            
            <fo:block font-size="12pt" font-weight="bold" keep-with-next="always">
                <xsl:value-of select="$title"/>
            </fo:block>
        </fo:block-container>
        <fo:block padding-after=".05in" keep-with-next="always"/>
    </xsl:template>
</xsl:stylesheet>
