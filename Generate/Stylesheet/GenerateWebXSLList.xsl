<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:include href="GenerateIncludeXSL.xsl"/>
<xsl:include href="GenerateIncludeXSLForm.xsl"/>
<!--=====================================================================
	Auth:   Bob Wood
	Date:   April 2003
	Desc:   Generates the List Page stylesheet from the entity definition 
	Copyright 2003 WinTech, Inc.
======================================================================-->

	<xsl:template match="/">
		<WEB><xsl:apply-templates/></WEB>
	</xsl:template>

	<xsl:template match="WTENTITY">
		<xsl:call-template name="LayoutForm">
			<xsl:with-param name="formtype" select="'list'"/>
		</xsl:call-template>
	</xsl:template>

</xsl:stylesheet>
