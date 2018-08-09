<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:include href="GenerateIncludeXSL.xsl"/>
<!--=====================================================================
	Auth:   Mike Wisniewski
	Date:   November 2001
	Desc:   Generates the English Language file from the entity definition 
	Copyright 2001 WinTech, Inc.
======================================================================-->

	<!--==================================================================-->
	<xsl:template match="/">
	<!--==================================================================-->
		<WEB><xsl:apply-templates/></WEB>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTROOT">
	<!--==================================================================-->
		<xsl:apply-templates select="WTCOMMONLABELS"/>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTENTITY">
	<!--==================================================================-->
		<xsl:value-of select="concat($tab1, '&lt;LANGUAGE&gt;', $cr)"/>

		<!--label for each Entity variation-->
		<xsl:call-template name="MakeLabel">
			<xsl:with-param name="name" select="@name"/>
			<xsl:with-param name="common" select="true()"/>
		</xsl:call-template>
		<xsl:call-template name="MakeLabel">
			<xsl:with-param name="name" select="concat(@name, 's')"/>
			<xsl:with-param name="common" select="true()"/>
		</xsl:call-template>
		<xsl:call-template name="MakeLabel">
			<xsl:with-param name="name" select="concat('New', @name)"/>
			<xsl:with-param name="common" select="true()"/>
		</xsl:call-template>
		<xsl:call-template name="MakeLabel">
			<xsl:with-param name="name" select="concat('Find', @name)"/>
			<xsl:with-param name="common" select="true()"/>
		</xsl:call-template>

		<!--label for each entity attribute-->
		<xsl:for-each select="/Data/WTENTITY/WTATTRIBUTE[not(@label='false')]">
			<xsl:call-template name="MakeLabel">
				<xsl:with-param name="name" select="@name"/>
			</xsl:call-template>
		</xsl:for-each>

		<!--label for each value for a static enum-->
		<xsl:for-each select="/Data/WTENTITY/WTATTRIBUTE[not(@label)]/WTENUM">
			<xsl:call-template name="MakeLabel">
				<xsl:with-param name="name" select="@name"/>
			</xsl:call-template>
		</xsl:for-each>

		<!--label for each true/false value for a yesno attribute-->

		<xsl:for-each select="/Data/WTENTITY/WTATTRIBUTE[@type='yesno' and not(@label)]">
			<xsl:call-template name="MakeLabel">
				<xsl:with-param name="name" select="concat(@name, 'True')"/>
			</xsl:call-template>
			<xsl:call-template name="MakeLabel">
				<xsl:with-param name="name" select="concat(@name, 'False')"/>
			</xsl:call-template>
		</xsl:for-each>

		<!--label for each true/false value for a yesno attribute-->

		<xsl:for-each select="//WTSTATIC[@type='yesno']">
			<xsl:variable name="nametext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>
			<xsl:call-template name="MakeLabel">
				<xsl:with-param name="name" select="concat($nametext, 'True')"/>
			</xsl:call-template>
			<xsl:call-template name="MakeLabel">
				<xsl:with-param name="name" select="concat($nametext, 'False')"/>
			</xsl:call-template>
		</xsl:for-each>

		<!--label for each label specified in the xml-->
		<xsl:for-each select="/Data/WTENTITY/WTWEBPAGES/WTWEBPAGE[not(@langfile)]//*[@label]">
			<xsl:call-template name="MakeLabel">
				<xsl:with-param name="name" select="@label"/>
				<xsl:with-param name="label" select="true()"/>
			</xsl:call-template>
		</xsl:for-each>

		<!--label for each tag specified in the xml-->
		<xsl:for-each select="/Data/WTENTITY/WTWEBPAGES/WTWEBPAGE[not(@langfile)]//*[@tag]">
			<xsl:call-template name="MakeLabel">
				<xsl:with-param name="name" select="@tag"/>
				<xsl:with-param name="label" select="true()"/>
			</xsl:call-template>
		</xsl:for-each>

		<!--label for each msg specified in the xml-->
		<xsl:for-each select="/Data/WTENTITY/WTWEBPAGES/WTWEBPAGE[not(@langfile)]//*[@msg]">
			<xsl:call-template name="MakeLabel">
				<xsl:with-param name="name" select="@msg"/>
				<xsl:with-param name="label" select="true()"/>
			</xsl:call-template>
		</xsl:for-each>

		<!--label for each button value specified in the xml-->
		<xsl:for-each select="/Data/WTENTITY/WTWEBPAGES/WTWEBPAGE[not(@langfile)]//WTBUTTON[@value]">
			<xsl:variable name="nametext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>
			<xsl:call-template name="MakeLabel">
				<xsl:with-param name="name" select="$nametext"/>
				<xsl:with-param name="label" select="true()"/>
			</xsl:call-template>
		</xsl:for-each>

		<xsl:value-of select="concat($tab1, '&lt;/LANGUAGE&gt;', $cr)"/>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTCOMMONLABELS">
	<!--==================================================================-->
		<xsl:value-of select="concat($tab1, '&lt;LANGUAGE&gt;', $cr)"/>

		<!--common labels for each entity-->
<!--		
		<xsl:for-each select="/WTROOT/WTENTITIES/WTENTITY">
			<xsl:call-template name="MakeLabel">
				<xsl:with-param name="name" select="@name"/>
				<xsl:with-param name="common" select="true()"/>
			</xsl:call-template>
			<xsl:call-template name="MakeLabel">
				<xsl:with-param name="name" select="concat(@name, 's')"/>
				<xsl:with-param name="common" select="true()"/>
			</xsl:call-template>
			<xsl:call-template name="MakeLabel">
				<xsl:with-param name="name" select="concat('New', @name)"/>
				<xsl:with-param name="common" select="true()"/>
			</xsl:call-template>
			<xsl:call-template name="MakeLabel">
				<xsl:with-param name="name" select="concat('Find', @name)"/>
				<xsl:with-param name="common" select="true()"/>
			</xsl:call-template>
		</xsl:for-each>
-->
		<!--application defined common labels-->
		<xsl:for-each select="LABEL">
			<xsl:call-template name="MakeLabel">
				<xsl:with-param name="name" select="@name"/>
				<xsl:with-param name="common" select="true()"/>
			</xsl:call-template>
		</xsl:for-each>
		<xsl:value-of select="concat($tab1, '&lt;/LANGUAGE&gt;', $cr)"/>
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

			<!--do default language first-->
<!--
			<xsl:choose>
				<xsl:when test="$common">
					<xsl:value-of select="concat($tab3, '&lt;', /WTROOT/WTLANGUAGES/WTLANGUAGE[@default='true']/@code, ' translate=', $apos, 'true', $apos, '&gt;')"/>
					<xsl:value-of select="$defaulttext"/>
					<xsl:value-of select="concat('&lt;/', /WTROOT/WTLANGUAGES/WTLANGUAGE[@default='true']/@code, '&gt;', $cr)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="concat($tab3, '&lt;', /Data/WTENTITY/WTLANGUAGES/WTLANGUAGE[@default='true']/@code, ' translate=', $apos, 'true', $apos, '&gt;')"/>
					<xsl:value-of select="$defaulttext"/>
					<xsl:value-of select="concat('&lt;/', /Data/WTENTITY/WTLANGUAGES/WTLANGUAGE[@default='true']/@code, '&gt;', $cr)"/>
				</xsl:otherwise>
			</xsl:choose>
-->
			<!--do all the rest of the supported languages-->
<!--
			<xsl:choose>
				<xsl:when test="$common">
					<xsl:for-each select="/WTROOT/WTLANGUAGES/WTLANGUAGE[not(@default)]">
						<xsl:value-of select="concat($tab3, '&lt;', @code, ' translate=', $apos, 'true', $apos, '&gt;')"/>
						<xsl:value-of select="$defaulttext"/>
						<xsl:value-of select="concat('&lt;/', @code,'&gt;', $cr)"/>
					</xsl:for-each>
				</xsl:when>
				<xsl:otherwise>
					<xsl:for-each select="/Data/WTENTITY/WTLANGUAGES/WTLANGUAGE[not(@default)]">
						<xsl:value-of select="concat($tab3, '&lt;', @code, ' translate=', $apos, 'true', $apos, '&gt;')"/>
						<xsl:value-of select="$defaulttext"/>
						<xsl:value-of select="concat('&lt;/', @code,'&gt;', $cr)"/>
					</xsl:for-each>
				</xsl:otherwise>
			</xsl:choose>

			<xsl:value-of select="concat($tab2, '&lt;/LABEL&gt;', $cr)"/>
-->
		</xsl:if>			
	</xsl:template>

</xsl:stylesheet>

