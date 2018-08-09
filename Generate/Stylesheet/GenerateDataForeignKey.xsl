<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:include href="GenerateIncludeSQL.xsl"/>
<!--===============================================================================
	Auth: Mike Wisniewski
	Date: October 2001
	Desc: Transforms an ILingual Entity Definition to a SQL Create Foreign Keys script 
	Copyright 2001 WinTech, Inc.
===================================================================================-->
	<xsl:template match="/">
		<SQL><xsl:apply-templates/></SQL>
	</xsl:template>

	<xsl:template match="WTENTITY">
		<xsl:call-template name="CheckForeignKey"/>

		<!--=====Create Foreign Key=====================-->
		<xsl:variable name="keyname" select="concat('FK_', $entityname, $parentfields[position()=last()]/@name)"/>

		<xsl:value-of select="concat('ALTER TABLE [', $dbowner, '].[', $entityname, '] WITH NOCHECK ADD', $cr)"/>
		<xsl:value-of select="concat($tab1, 'CONSTRAINT [', $keyname, '] FOREIGN KEY (')"/>
			
		<xsl:for-each select="$parentfields">
			<xsl:value-of select="concat('[', @name, ']')"/>
			<xsl:if test="position() != last()">
				<xsl:text>, </xsl:text>
			</xsl:if>
		</xsl:for-each>
		<xsl:value-of select="concat($tab0, $cr)"/>

		<xsl:value-of select="concat($tab1, 'REFERENCES [', $dbowner, '].[', @entity, '] (')"/>

		<xsl:for-each select="$parentfields">
		<xsl:value-of select="concat('[', @relname, ']')"/>
			<xsl:if test="position() != last()">
				<xsl:text>, </xsl:text>
			</xsl:if>
		</xsl:for-each>
			
		<xsl:value-of select="concat(') NOT FOR REPLICATION', $cr, 'GO', $cr, $cr, 'ALTER TABLE [', $dbowner, '].[', $entityname)"/>
		<xsl:value-of select="concat('] NOCHECK CONSTRAINT [', $keyname, ']', $cr, 'GO', $cr, $cr)"/>

	</xsl:template>
</xsl:stylesheet>
