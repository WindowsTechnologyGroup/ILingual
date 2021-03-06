<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:include href="GenerateIncludeSQL.xsl"/>
<!--===============================================================================
	Auth: Bob Wood
	Date: February 2005
	Desc: Transforms an ILingual Entity Definition to a SQL Create Table script 
	Copyright 2005 WinTech, Inc.
===================================================================================-->

	<xsl:template match="/">
		<SQL><xsl:apply-templates/></SQL>
	</xsl:template>

	<xsl:template match="WTENTITY">
		<xsl:call-template name="CheckTableRebuild"/>

		<!--==========DEFAULT CONSTRAINTS==========-->

		<xsl:value-of select="concat($tab0, 'ALTER TABLE [', $dbowner, '].[', @name, '] WITH NOCHECK ADD', $cr)"/>

		<xsl:for-each select="WTATTRIBUTE[@source='entity' and not(@identity) and not(WTCOMPUTE) and not(@persist)]">
			<xsl:value-of select="concat($tab1, 'CONSTRAINT [DF_', $entityname, '_', @name, '] DEFAULT (')"/>
			<xsl:choose>
				<xsl:when test="WTDEFAULT">
					<xsl:choose>
						<xsl:when test="WTDEFAULT/@type='constant'">
							<xsl:choose>
								<xsl:when test="WTDEFAULT/@value='true'">1</xsl:when>
								<xsl:otherwise>0</xsl:otherwise>
							</xsl:choose>
						</xsl:when>
						<xsl:otherwise>0</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:when test="not(WTDEFAULT)">
					<xsl:choose>
					  <xsl:when test="@type='char'">''</xsl:when>
					  <xsl:when test="@type='text'">''</xsl:when>
					  <xsl:when test="@type='password'">''</xsl:when>
					  <xsl:otherwise>0</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
			</xsl:choose>
			<xsl:if test="position() != last()">
				<xsl:value-of select="concat(') FOR [', @name, '] ,', $cr)"/>
			</xsl:if>
			<xsl:if test="position() = last()">
				<xsl:value-of select="concat(') FOR [', @name, ']')"/>
			</xsl:if>
		</xsl:for-each>
		<xsl:if test="not(@audit='true')">
				<xsl:value-of select="$cr"/>
		</xsl:if>
		<xsl:if test="@audit='true'">
			<xsl:value-of select="concat(',',$cr)"/>
			<xsl:value-of select="concat($tab1, 'CONSTRAINT [DF_', $entityname, '_CreateDate] DEFAULT (0) FOR [CreateDate] ,', $cr)"/>
			<xsl:value-of select="concat($tab1, 'CONSTRAINT [DF_', $entityname, '_CreateID] DEFAULT (0) FOR [CreateID] ,', $cr)"/>
			<xsl:value-of select="concat($tab1, 'CONSTRAINT [DF_', $entityname, '_ChangeDate] DEFAULT (0) FOR [ChangeDate] ,', $cr)"/>
			<xsl:value-of select="concat($tab1, 'CONSTRAINT [DF_', $entityname, '_ChangeID] DEFAULT (0) FOR [ChangeID]', $cr)"/>
		</xsl:if>
		<xsl:value-of select="concat($tab0, 'GO', $cr, $cr)"/>

		<!--==========PRIMARY KEY==========-->

		<xsl:value-of select="concat($tab0, 'ALTER TABLE [', $dbowner, '].[', @name, '] WITH NOCHECK ADD', $cr)"/>

		<xsl:for-each select="WTATTRIBUTE[@identity]">
			<xsl:value-of select="concat($tab1, 'CONSTRAINT [PK_', $entityname, '] PRIMARY KEY NONCLUSTERED', $cr, $tab1, '([', @name, '])', $cr)"/>
		</xsl:for-each>

		<xsl:value-of select="concat($tab1, 'WITH FILLFACTOR = 80 ON [PRIMARY]', $cr, 'GO', $cr, $cr)"/>

		<!--==========INDEXES==========-->

		<xsl:for-each select="WTINDEX">
			<xsl:value-of select="concat($tab0, 'CREATE ')"/>
			<xsl:if test="@unique">
				<xsl:text>UNIQUE </xsl:text>
			</xsl:if>
			<xsl:text>INDEX [</xsl:text>
			<xsl:if test="@unique">
				<xsl:text>U</xsl:text>
			</xsl:if>
			<xsl:value-of select="concat('I_', $entityname, '_', @name, ']', $cr, $tab1, 'ON [', $dbowner, '].[', $entityname, ']', $cr)"/>
			<xsl:value-of select="concat($tab1, '(')"/>
			<xsl:for-each select="WTATTRIBUTE">
				<xsl:value-of select="concat('[', @name, ']')"/>
				<xsl:if test="position() != last()">
					<xsl:text>, </xsl:text>
				</xsl:if>
			</xsl:for-each>
			<xsl:value-of select="concat(')', $cr, $tab1, 'WITH FILLFACTOR = 80 ON [PRIMARY]', $cr, 'GO', $cr, $cr)"/>
		</xsl:for-each>
	</xsl:template>
</xsl:stylesheet>
