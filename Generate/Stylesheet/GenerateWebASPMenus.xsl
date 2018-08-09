<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:include href="GenerateIncludeASP.xsl"/>
<xsl:include href="GenerateWebASPMenu.xsl"/>
<!--===============================================================================
	Auth: Bob Wood	
	Date: February 2006
	Desc: Creates a ASP Menu definition
	Copyright 2006 WinTech, Inc.
===================================================================================-->

	<xsl:template match="/">
		<WEB><xsl:apply-templates/></WEB>
	</xsl:template>

</xsl:stylesheet>
