<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:include href="GenerateIncludeXSL.xsl"/>
<!--=====================================================================
	Auth:   Mike Wisniewski
	Date:   November 2001
	Desc:   Generates an XSL template 
	Copyright 2001 WinTech, Inc.
======================================================================-->

	<xsl:template match="/">
		<WEB><xsl:apply-templates/></WEB>
	</xsl:template>

	<xsl:template match="Data">
		<xsl:apply-templates/>
	</xsl:template>
</xsl:stylesheet>

