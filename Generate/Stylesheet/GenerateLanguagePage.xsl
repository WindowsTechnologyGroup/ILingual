<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:include href="GenerateIncludeXSL.xsl"/>
<!--=====================================================================
	Auth:   Bob Wood
	Date:   September 2002
	Desc:   Generates the Language file for a single page 
	Copyright 2002 WinTech, Inc.
======================================================================-->

	<!--==================================================================-->
	<xsl:template match="/">
	<!--==================================================================-->
		<WEB><xsl:apply-templates/></WEB>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTROOT">
	<!--==================================================================-->
		<xsl:apply-templates select="WTENTITY"/>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTENTITY">
	<!--==================================================================-->
		<xsl:value-of select="concat($tab1, '&lt;LANGUAGE&gt;', $cr)"/>

		<!--label for each label specified in the xml-->
		<xsl:for-each select="/Data/WTENTITY/WTWEBPAGE//*[@label]">
			<xsl:call-template name="MakeLabels">
				<xsl:with-param name="name" select="@label"/>
			</xsl:call-template>
		</xsl:for-each>

		<!--label for each tag specified in the xml-->
		<xsl:for-each select="/Data/WTENTITY/WTWEBPAGE//*[@tag]">
			<xsl:call-template name="MakeLabels">
				<xsl:with-param name="name" select="@tag"/>
			</xsl:call-template>
		</xsl:for-each>

		<!--label for each msg specified in the xml-->
		<xsl:for-each select="/Data/WTENTITY/WTWEBPAGE//*[@msg]">
			<xsl:call-template name="MakeLabels">
				<xsl:with-param name="name" select="@msg"/>
			</xsl:call-template>
		</xsl:for-each>

		<!--label for each button value specified in the xml-->
		<xsl:for-each select="/Data/WTENTITY/WTWEBPAGE//WTBUTTON[@value]">
			<xsl:variable name="nametext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>
			<xsl:call-template name="MakeLabels">
				<xsl:with-param name="name" select="$nametext"/>
			</xsl:call-template>
		</xsl:for-each>

		<xsl:value-of select="concat($tab1, '&lt;/LANGUAGE&gt;', $cr)"/>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template name="MakeLabels">
	<!--==================================================================-->
		<xsl:param name="name"/>

		<!--make this label -->
		  <xsl:call-template name="MakeLabel">
				<xsl:with-param name="name" select="$name"/>
				<xsl:with-param name="label" select="false()"/>
		  </xsl:call-template>

		<!--labels if this attribute has Enums -->
		<xsl:for-each select="/Data/WTENTITY/WTATTRIBUTE[@name=$name]/WTENUM">
			<xsl:call-template name="MakeLabel">
				<xsl:with-param name="name" select="@name"/>
			</xsl:call-template>
		</xsl:for-each>

		<!--labels if this attribute is a yesno attribute-->
		<xsl:for-each select="/Data/WTENTITY/WTATTRIBUTE[@name=$name and @type='yesno']">
			<xsl:call-template name="MakeLabel">
				<xsl:with-param name="name" select="concat(@name, 'True')"/>
			</xsl:call-template>
			<xsl:call-template name="MakeLabel">
				<xsl:with-param name="name" select="concat(@name, 'False')"/>
			</xsl:call-template>
		</xsl:for-each>

	</xsl:template>

	<!--==================================================================-->
	<xsl:template name="MakeLabel">
	<!--==================================================================-->
		<xsl:param name="name"/>
		<xsl:param name="common" select="false()"/>
		<xsl:param name="label" select="false()"/>

		<xsl:variable name="attr" select="/Data/WTENTITY/WTATTRIBUTE[@name=$name]"/>

		<xsl:variable name="nametype"><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="$name"/></xsl:call-template></xsl:variable>
		<xsl:variable name="isdup">
			<xsl:choose>
				<xsl:when test="($nametype != 'NONE')">TRUE</xsl:when>
				<xsl:when test="($common)">FALSE</xsl:when>
				<xsl:when test="($label) and ($name=$attr/@name)">TRUE</xsl:when>
				<xsl:when test="/Data/WTENTITY/LANGUAGE/LABEL[@name=$name]">TRUE</xsl:when>
				<xsl:otherwise>FALSE</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:if test="($isdup='FALSE')">

			<xsl:value-of select="concat($tab2, '&lt;LABEL name=&quot;', $name, '&quot;&gt;')"/>

			<!--set default label translations-->
			<xsl:variable name="defaulttext">
				<xsl:choose>

					<!--any fields ending in '...ID' drop 'ID' -->
					<xsl:when test="(substring($attr/@name, string-length($attr/@name)-1)='ID')"><xsl:value-of select="substring($attr/@name, 1, string-length($attr/@name)-2)"/></xsl:when>

					<!--the title field for the entity is just 'Name'-->
					<xsl:when test="($attr/@title='true') and ($attr/@source='entity')">Name</xsl:when>

					<!-- any fields ending in '...NameLast' or '...NameFirst' are just 'Last Name' and 'First Name'-->
					<xsl:when test="(substring($attr/@name, string-length($attr/@name)-7)='NameLast')">Last Name</xsl:when>
					<xsl:when test="(substring($attr/@name, string-length($attr/@name)-8)='NameFirst')">First Name</xsl:when>

					<!-- any fields ending in '...Name' drop 'Name' -->
					<xsl:when test="(substring($attr/@name, string-length($attr/@name)-3)='Name')"><xsl:value-of select="substring($attr/@name, 1, string-length($attr/@name)-4)"/></xsl:when>

					<!-- any boolean fields starting with 'Is...' drop 'Is' -->
					<xsl:when test="($attr/@type='yesno') and (substring($attr/@name, 1, 2) = 'Is')"><xsl:value-of select="substring($attr/@name, 3)"/></xsl:when>

					<!-- any other fields just use the label name -->
					<xsl:otherwise><xsl:value-of select="$name"/></xsl:otherwise>

				</xsl:choose>
			</xsl:variable>

			<xsl:value-of select="concat($defaulttext, '&lt;/LABEL&gt;', $cr)"/>

		</xsl:if>			
	</xsl:template>

</xsl:stylesheet>

