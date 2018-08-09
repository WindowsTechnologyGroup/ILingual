<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:include href="GenerateInclude.xsl"/>
<!--===============================================================================
	Auth: Bob Wood
	Date: February 2002
	Desc: Creates the SQL Scripter File for all stored procedures
	Copyright 2002 WinTech, Inc.
===================================================================================-->

	<xsl:template match="/">
		<SCRIPT><xsl:apply-templates/></SCRIPT>
	</xsl:template>

<xsl:template match="WTROOT">

	<xsl:variable name="prefix" select="@prefix"/>
	<xsl:variable name="project" select="@project"/>
	
	<xsl:value-of select="concat($tab1, '&lt;!--', $project, '--&gt;', $cr)"/>
	<xsl:for-each select="/WTROOT/WTPROCEDURES/WTPROCEDURE[@type!='Custom']">

		<xsl:choose>
			<xsl:when test="@type='Find'">
				<xsl:variable name="findname" select="@name"/>
		
				<xsl:for-each select="/WTROOT/WTENTITY/WTENUM[@type='find']/WTATTRIBUTE">
					<xsl:value-of select="concat($tab1, '&lt;PROC name=&quot;', $prefix, '_', $project, '_', $findname, @name, '&quot;/&gt;', $cr)"/>
				</xsl:for-each>

			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="concat($tab1, '&lt;PROC name=&quot;', $prefix, '_', $project, '_', @name, '&quot;/&gt;', $cr)"/>
			</xsl:otherwise>
		</xsl:choose>

	</xsl:for-each>

</xsl:template>

</xsl:stylesheet>
