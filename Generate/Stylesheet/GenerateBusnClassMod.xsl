<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:include href="GenerateIncludeVB.xsl"/>
<!--===============================================================================
	Auth: Mike Wisniewski
	Date: October 2001
	Desc: Transforms an ILingual Entity Definition to Constant Declaration List
	Copyright 2001 WinTech, Inc.
===================================================================================-->

	<xsl:template match="/">
		<VB><xsl:apply-templates/></VB>
	</xsl:template>

	<xsl:template match="WTENTITY">

		<xsl:call-template name="VBHeaderBasModule">
			<xsl:with-param name="name" select="concat('C', @name)"/>
		</xsl:call-template>

		<xsl:call-template name="VBComment">
			<xsl:with-param name="value">constants</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="VBConstant">
			<xsl:with-param name="name">ModName</xsl:with-param>
			<xsl:with-param name="type">text</xsl:with-param>
			<xsl:with-param name="value" select="concat('C', @name, 'Mod')"/>
		</xsl:call-template>
		<xsl:value-of select="$cr"/>

		<xsl:variable name="constprefix" select="concat($appprefix, $entityname)"/>

		<!--====================Enum Item Type Constants====================-->
		<xsl:if test="($hasenum) or ($hasfind) or ($haslist)">
			<xsl:call-template name="VBComment">
				<xsl:with-param name="value">enum item type constants</xsl:with-param>
			</xsl:call-template>

			<xsl:if test="($hasfind)">
				<xsl:call-template name="VBConstant">
					<xsl:with-param name="scope">Public</xsl:with-param>
					<xsl:with-param name="name" select="concat($constprefix, 'Enum', 'FindType')"/>
					<xsl:with-param name="type">number</xsl:with-param>
					<xsl:with-param name="value" select="/Data/WTENTITY/WTENUM[@type='find']/@id"/>
				</xsl:call-template>
			</xsl:if>

			<!--if the entity has a list method, build constant for the enum list types-->
			<xsl:if test="($haslist)">
				<xsl:call-template name="VBConstant">
					<xsl:with-param name="scope">Public</xsl:with-param>
					<xsl:with-param name="name" select="concat($constprefix, 'Enum', 'ListType')"/>
					<xsl:with-param name="type">number</xsl:with-param>
					<xsl:with-param name="value" select="/Data/WTENTITY/WTENUM[@type='list']/@id"/>
				</xsl:call-template>
			</xsl:if>

			<xsl:for-each select="WTATTRIBUTE[WTENUM]">
				<xsl:call-template name="VBConstant">
					<xsl:with-param name="scope">Public</xsl:with-param>
					<xsl:with-param name="name" select="concat($constprefix, 'Enum', @name)"/>
					<xsl:with-param name="type">number</xsl:with-param>
					<xsl:with-param name="value" select="@id"/>
				</xsl:call-template>
			</xsl:for-each>
			<xsl:value-of select="$cr"/>
		</xsl:if>

		<!--====================Enum Find Type Constants====================-->
		<xsl:if test="($hasfind)">
			<xsl:call-template name="VBComment">
				<xsl:with-param name="value">enum FindType constants</xsl:with-param>
			</xsl:call-template>

			<xsl:for-each select="/Data/WTENTITY/WTENUM[@type='find' and @id=1]/WTATTRIBUTE">
				<xsl:variable name="aname" select="@name"/>
				<xsl:for-each select="/Data/WTENTITY/WTATTRIBUTE[@name=$aname]">
					<xsl:call-template name="VBConstant">
						<xsl:with-param name="scope">Public</xsl:with-param>
						<xsl:with-param name="name" select="concat($constprefix, 'Find', @name)"/>
						<xsl:with-param name="type">number</xsl:with-param>
						<xsl:with-param name="value" select="@id"/>
					</xsl:call-template>
				</xsl:for-each>
			</xsl:for-each>

      <xsl:for-each select="/Data/WTENTITY/WTENUM[@type='find']/WTATTRIBUTE[@const='1']">
        <xsl:variable name="aname" select="@name"/>
        <xsl:for-each select="/Data/WTENTITY/WTATTRIBUTE[@name=$aname]">
          <xsl:call-template name="VBConstant">
            <xsl:with-param name="scope">Public</xsl:with-param>
            <xsl:with-param name="name" select="concat($constprefix, 'Find', @name)"/>
            <xsl:with-param name="type">number</xsl:with-param>
            <xsl:with-param name="value" select="@id"/>
          </xsl:call-template>
        </xsl:for-each>
      </xsl:for-each>
      <xsl:value-of select="$cr"/>
		</xsl:if>

		<!--if the entity has lists, build constants for list by-->
		<xsl:if test="($haslist)">
			<xsl:call-template name="VBComment">
				<xsl:with-param name="value">enum ListType constants</xsl:with-param>
			</xsl:call-template>
			<xsl:choose>
				<xsl:when test="($multilist)">
					<xsl:for-each select="/Data/WTENTITY/WTENUM[@type='list']/WTATTRIBUTE">
						<xsl:choose>	
							<xsl:when test="@id">
								<xsl:call-template name="VBConstant">
									<xsl:with-param name="scope">Public</xsl:with-param>
									<xsl:with-param name="name" select="concat($constprefix, 'List', @name)"/>
									<xsl:with-param name="type">number</xsl:with-param>
									<xsl:with-param name="value" select="@id"/>
								</xsl:call-template>
							</xsl:when>
							<xsl:otherwise>
								<xsl:variable name="aname" select="@name"/>
								<xsl:for-each select="/Data/WTENTITY/WTATTRIBUTE[@name=$aname]">
									<xsl:call-template name="VBConstant">
										<xsl:with-param name="scope">Public</xsl:with-param>
										<xsl:with-param name="name" select="concat($constprefix, 'List', @name)"/>
										<xsl:with-param name="type">number</xsl:with-param>
										<xsl:with-param name="value" select="@id"/>
									</xsl:call-template>
								</xsl:for-each>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:for-each>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="VBConstant">
						<xsl:with-param name="scope">Public</xsl:with-param>
						<xsl:with-param name="name" select="concat($constprefix, 'ListAll')"/>
						<xsl:with-param name="type">number</xsl:with-param>
						<xsl:with-param name="value">0</xsl:with-param>
					</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:value-of select="$cr"/>
		</xsl:if>

		<!--====================Enum Attribute Constants====================-->
		<xsl:if test="($hasenum)">
			<xsl:for-each select="WTATTRIBUTE[WTENUM]">
				<xsl:variable name="enumprefix" select="concat($constprefix, @name)"/>

				<xsl:call-template name="VBComment">
					<xsl:with-param name="value" select="concat('enum ', @name, ' constants')"/>
				</xsl:call-template>
				<xsl:for-each select="WTENUM">
					<xsl:call-template name="VBConstant">
						<xsl:with-param name="scope">Public</xsl:with-param>
						<xsl:with-param name="name" select="concat($enumprefix, @name)"/>
						<xsl:with-param name="type">number</xsl:with-param>
						<xsl:with-param name="value" select="@id"/>
					</xsl:call-template>
				</xsl:for-each>
				<xsl:value-of select="$cr"/>
			</xsl:for-each>
		</xsl:if>

	</xsl:template>
</xsl:stylesheet>

