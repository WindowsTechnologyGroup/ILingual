<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:include href="GenerateInclude.xsl"/>
<!--===============================================================================
	Auth: Bob Wood
	Date: October 2002
	Desc: Validates an ILingual Application Definition
	Copyright 2002 WinTech, Inc.
===================================================================================-->

<xsl:template match="/">
<VALID>
	<xsl:apply-templates/>
</VALID>
</xsl:template>

<xsl:template match="WTROOT">

	<!--TEST valid attributes-->
	<xsl:for-each select="@*">
	 <xsl:choose>
	  	  <xsl:when test="name()='prefix'"/>
	  	  <xsl:when test="name()='dbo'"/>
	  	  <xsl:when test="name()='system'"/>
	  	  <xsl:otherwise><xsl:value-of select="concat( 'Invalid WTROOT Attribute (', name(), ')', $cr)"/></xsl:otherwise>
	 </xsl:choose>
	</xsl:for-each>

	<xsl:if test="not(@prefix)">
		<xsl:value-of select="concat( 'Missing Root prefix Attribute',$cr)"/>
	</xsl:if>
	<xsl:if test="not(@dbo)">
		<xsl:value-of select="concat( 'Missing Root dbo Attribute',$cr)"/>
	</xsl:if>
	<xsl:if test="not(@system)">
		<xsl:value-of select="concat( 'Missing Root system Attribute',$cr)"/>
	</xsl:if>

	<xsl:if test="count(WTENTITIES/WTENTITY)=0">
		<xsl:value-of select="concat( 'No Entities Defined',$cr)"/>
	</xsl:if>

	<xsl:if test="count(WTUSERGROUPS/WTUSERGROUP)=0">
		<xsl:value-of select="concat( 'No User Groups Defined',$cr)"/>
	</xsl:if>

	<xsl:if test="count(WTCOLORS/WTCOLOR)=0">
		<xsl:value-of select="concat( 'No Colors Defined',$cr)"/>
	</xsl:if>

	<xsl:if test="count(WTLANGUAGES/WTLANGUAGE)=0">
		<xsl:value-of select="concat( 'No Languages Defined',$cr)"/>
	</xsl:if>
<!--
	<xsl:if test="count(WTLANGUAGES/WTLABELS/LABEL)=0">
		<xsl:value-of select="concat( 'No Language Labels Defined',$cr)"/>
	</xsl:if>
-->
	<xsl:if test="count(WTLANGUAGES/WTLANGUAGE[@default])!=1">
		<xsl:value-of select="concat( 'Exactly one Language must be the default',$cr)"/>
	</xsl:if>

	<xsl:if test="count(WTCONDITIONS/WTCONDITION)=0">
		<xsl:value-of select="concat( 'No Conditions Defined',$cr)"/>
	</xsl:if>

	<xsl:if test="count(WTLANGUAGES/WTCOMMONLABELS/LABEL)=0">
		<xsl:value-of select="concat( 'No Common Labels Defined',$cr)"/>
	</xsl:if>

	<xsl:if test="count(WTTEMPLATE)=0">
		<xsl:value-of select="concat( 'No Templates Defined',$cr)"/>
	</xsl:if>

	<xsl:if test="count(WTENTITIES/WTENTITY[@number=preceding-sibling::WTENTITY/@number])!=0">
		<xsl:value-of select="concat( 'All Entity Numbers are NOT Unique',$cr)"/>
	</xsl:if>
	<xsl:if test="count(WTENTITIES/WTENTITY[@alias=preceding-sibling::WTENTITY/@alias])!=0">
		<xsl:value-of select="concat( 'All Entity Aliases are NOT Unique',$cr)"/>
	</xsl:if>
	<xsl:if test="count(WTENTITIES/WTENTITY[@name=preceding-sibling::WTENTITY/@name])!=0">
		<xsl:value-of select="concat( 'All Entity Names are NOT Unique',$cr)"/>
	</xsl:if>

	<xsl:if test="count(WTCONDITIONS/WTCONDITION[@name=preceding-sibling::WTCONDITION/@name])!=0">
		<xsl:value-of select="concat( 'All Condition Names are NOT Unique',$cr)"/>
	</xsl:if>
	
	<xsl:apply-templates/>

</xsl:template>

<xsl:template match="WTENTITIES/WTENTITY">
	<!--TEST valid attributes-->
	<xsl:for-each select="@*">
		<xsl:choose>
			<xsl:when test="name()='number'"/>
			<xsl:when test="name()='alias'"/>
			<xsl:when test="name()='name'"/>
			<xsl:when test="name()='identity'"/>
			<xsl:when test="name()='title'"/>
			<xsl:when test="name()='file'"/>
			<xsl:otherwise><xsl:value-of select="concat( 'Invalid WTENTITY Attribute (', name(), ')', $cr)"/></xsl:otherwise>
		</xsl:choose>
	</xsl:for-each>
	<xsl:if test="not(@number)">
		<xsl:value-of select="concat( 'Missing Entity number Attribute - ', @name, $cr)"/>
	</xsl:if>
	<xsl:if test="not(@alias)">
		<xsl:value-of select="concat( 'Missing Entity alias Attribute - ', @name, $cr)"/>
	</xsl:if>
	<xsl:if test="not(@name)">
		<xsl:value-of select="concat( 'Missing Entity name Attribute - ', position(), $cr)"/>
	</xsl:if>
	<xsl:if test="string-length(@name)&gt;14">
		<xsl:value-of select="concat( 'Entity name too long - ', @name, ' (14 character limit)', $cr)"/>
	</xsl:if>
	<xsl:if test="not(@identity)">
		<xsl:value-of select="concat( 'Missing Entity identity Attribute - ', @name, $cr)"/>
	</xsl:if>
	<xsl:if test="not(@title)">
		<xsl:value-of select="concat( 'Missing Entity title Attribute - ', @name, $cr)"/>
	</xsl:if>
	<xsl:if test="not(@file)">
		<xsl:value-of select="concat( 'Missing Entity file Attribute - ', @name, $cr)"/>
	</xsl:if>
</xsl:template>

<xsl:template match="WTUSERGROUPS/WTUSERGROUP">
	<!--TEST valid attributes-->
	<xsl:for-each select="@*">
		<xsl:choose>
			<xsl:when test="name()='id'"/>
			<xsl:when test="name()='name'"/>
			<xsl:when test="name()='entity'"/>
			<xsl:when test="name()='secure'"/>
			<xsl:otherwise><xsl:value-of select="concat( 'Invalid WTUSERGROUP Attribute (', name(), ')', $cr)"/></xsl:otherwise>
		</xsl:choose>
	</xsl:for-each>
	<xsl:if test="not(@id)">
		<xsl:value-of select="concat( 'Missing UserGroup id Attribute - ', @name, $cr)"/>
	</xsl:if>
	<xsl:if test="not(@name)">
		<xsl:value-of select="concat( 'Missing UserGroup name Attribute - ', position(), $cr)"/>
	</xsl:if>
	<xsl:if test="count(WTUSERGROUPS/WTUSERGROUP[@id=preceding-sibling::WTUSERGROUP/@id])!=0">
		<xsl:value-of select="concat( 'All UserGroup IDs are NOT Unique',$cr)"/>
	</xsl:if>
	<xsl:if test="count(WTUSERGROUPS/WTUSERGROUP[@name=preceding-sibling::WTUSERGROUP/@name])!=0">
		<xsl:value-of select="concat( 'All UserGroup Names are NOT Unique',$cr)"/>
	</xsl:if>
</xsl:template>

<xsl:template match="WTCOLORS/WTCOLOR">
	<!--TEST valid attributes-->
	<xsl:for-each select="@*">
		<xsl:choose>
			<xsl:when test="name()='name'"/>
			<xsl:when test="name()='value'"/>
			<xsl:otherwise><xsl:value-of select="concat( 'Invalid WTCOLOR Attribute (', name(), ')', $cr)"/></xsl:otherwise>
		</xsl:choose>
	</xsl:for-each>
	<xsl:if test="not(@value)">
		<xsl:value-of select="concat( 'Missing Color value Attribute - ', @name, $cr)"/>
	</xsl:if>
	<xsl:if test="not(@name)">
		<xsl:value-of select="concat( 'Missing Color name Attribute - ', position(), $cr)"/>
	</xsl:if>
	<xsl:if test="count(WTCOLORS/WTCOLOR[@name=preceding-sibling::WTCOLOR/@name])!=0">
		<xsl:value-of select="concat( 'All Color Names are NOT Unique',$cr)"/>
	</xsl:if>
</xsl:template>

<xsl:template match="WTLANGUAGES/WTLANGUAGE">
	<!--TEST valid attributes-->
	<xsl:for-each select="@*">
		<xsl:choose>
			<xsl:when test="name()='name'"/>
			<xsl:when test="name()='code'"/>
			<xsl:when test="name()='default'"/>
			<xsl:otherwise><xsl:value-of select="concat( 'Invalid WTLANGUAGE Attribute (', name(), ')', $cr)"/></xsl:otherwise>
		</xsl:choose>
	</xsl:for-each>
	<xsl:if test="not(@code)">
		<xsl:value-of select="concat( 'Missing Language code Attribute - ', @name, $cr)"/>
	</xsl:if>
	<xsl:if test="not(@name)">
		<xsl:value-of select="concat( 'Missing Language name Attribute - ', position(), $cr)"/>
	</xsl:if>
	<xsl:if test="count(WTLANGUAGES/WTLANGUAGE[@name=preceding-sibling::WTLANGUAGE/@name])!=0">
		<xsl:value-of select="concat( 'All Language Names are NOT Unique',$cr)"/>
	</xsl:if>
	<xsl:if test="count(WTLANGUAGES/WTLANGUAGE[@code=preceding-sibling::WTLANGUAGE/@code])!=0">
		<xsl:value-of select="concat( 'All Language Codes are NOT Unique',$cr)"/>
	</xsl:if>
</xsl:template>

<xsl:template match="WTPAGE/WTSYSVAR">
	<!--TEST valid attributes-->
	<xsl:for-each select="@*">
		<xsl:choose>
			<xsl:when test="name()='name'"/>
			<xsl:when test="name()='type'"/>
			<xsl:otherwise><xsl:value-of select="concat( 'Invalid WTPAGE/WTSYSVAR Attribute (', name(), ')', $cr)"/></xsl:otherwise>
		</xsl:choose>
	</xsl:for-each>

	<xsl:variable name="ltext">
		<xsl:call-template name="CaseLower">
			<xsl:with-param name="value" select="@name"/>
		</xsl:call-template>
	</xsl:variable>

	<xsl:variable name="tmpvar">
		<xsl:choose>
		<xsl:when test="$ltext='headerimage'">X</xsl:when>
		<xsl:when test="$ltext='footerimage'">X</xsl:when>
		<xsl:when test="$ltext='returnimage'">X</xsl:when>
		<xsl:when test="$ltext='headerurl'">X</xsl:when>
		<xsl:when test="$ltext='returnurl'">X</xsl:when>
		<xsl:when test="$ltext='language'">X</xsl:when>
		<xsl:when test="$ltext='langdialect'">X</xsl:when>
		<xsl:when test="$ltext='langcountry'">X</xsl:when>
		<xsl:when test="$ltext='langdefault'">X</xsl:when>
		<xsl:when test="$ltext='userid'">X</xsl:when>
		<xsl:when test="$ltext='usergroup'">X</xsl:when>
		<xsl:when test="$ltext='userstatus'">X</xsl:when>
		<xsl:when test="$ltext='username'">X</xsl:when>
		<xsl:when test="$ltext='employeeid'">X</xsl:when>
		<xsl:when test="$ltext='actioncode'">X</xsl:when>
		<xsl:when test="$ltext='customerid'">X</xsl:when>
		<xsl:when test="$ltext='affiliateid'">X</xsl:when>
		<xsl:when test="$ltext='affiliatetype'">X</xsl:when>
		<xsl:when test="$ltext='date'">X</xsl:when>
		<xsl:when test="$ltext='time'">X</xsl:when>
		<xsl:when test="$ltext='timeno'">X</xsl:when>
		<xsl:when test="$ltext='searchtype'">X</xsl:when>
		<xsl:when test="$ltext='listtype'">X</xsl:when>
		<xsl:when test="$ltext='owner'">X</xsl:when>
		<xsl:when test="$ltext='ownerid'">X</xsl:when>
		<xsl:when test="$ltext='ownertitle'">X</xsl:when>
		<xsl:when test="$ltext='servername'">X</xsl:when>
		<xsl:when test="$ltext='serverpath'">X</xsl:when>
		<xsl:when test="$ltext='webdirectory'">X</xsl:when>
<!--		<xsl:when test="$ltext='options'">X</xsl:when>-->
		</xsl:choose>
	</xsl:variable>
	
	<xsl:if test="$tmpvar='X'">
		<xsl:value-of select="concat( 'WTPAGE/WTSYSVAR System Variable Already Defined (', @name, ')', $cr)"/>
	</xsl:if>
	
</xsl:template>

</xsl:stylesheet>

