<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:include href="GenerateIncludeXSL.xsl"/>
<!--=====================================================================
	Auth:   Bob Wood
	Date:   February 2002
	Desc:   Creates the common labels file (Common[en-us].xml)
	Copyright 2002 WinTech, Inc.
======================================================================-->

	<xsl:template match="/">
		<WEB><xsl:apply-templates/></WEB>
	</xsl:template>

	<xsl:template match="WTROOT">
	
		<xsl:value-of select="concat($tab0, '&lt;LANGUAGE&gt;', $cr)"/>
		
		<xsl:for-each select="/WTROOT/WTENTITIES/WTENTITY">

			<xsl:value-of select="concat($tab1, '&lt;LABEL name=&quot;', @name, '&quot;&gt;', @name, '&lt;/LABEL&gt;', $cr)"/>
			<xsl:value-of select="concat($tab1, '&lt;LABEL name=&quot;', @name, 's&quot;&gt;', @name, 's&lt;/LABEL&gt;', $cr)"/>
			<xsl:value-of select="concat($tab1, '&lt;LABEL name=&quot;New', @name, '&quot;&gt;New ', @name, '&lt;/LABEL&gt;', $cr)"/>
			<xsl:if test="not(lookup)">
				<xsl:value-of select="concat($tab1, '&lt;LABEL name=&quot;Find', @name, '&quot;&gt;Find ', @name, '&lt;/LABEL&gt;', $cr)"/>
			</xsl:if>

		</xsl:for-each>
		
		<xsl:call-template name="Labels"/>
		<xsl:value-of select="concat($tab0, '&lt;/LANGUAGE&gt;', $cr)"/>
	
	</xsl:template>


<!--************************************************************************************************-->
<xsl:template name="Labels">
<xsl:text>
	&lt;LABEL name="LookupLists"&gt;Lookup Lists&lt;/LABEL&gt; 

	&lt;LABEL name="MyInfo"&gt;My Information&lt;/LABEL&gt; 
	&lt;LABEL name="LogonPassword"&gt;Logon / Password&lt;/LABEL&gt; 
	&lt;LABEL name="ResetLogons"&gt;Reset Logon&lt;/LABEL&gt; 
	&lt;LABEL name="ChangeLogon"&gt;Change Logon&lt;/LABEL&gt; 
	&lt;LABEL name="ChangePassword"&gt;Change Password&lt;/LABEL&gt; 
	&lt;LABEL name="ResetLogon"&gt;Reset Logon&lt;/LABEL&gt; 
	&lt;LABEL name="SignOut"&gt;Sign Out&lt;/LABEL&gt; 

	&lt;LABEL name="Find"&gt;Find&lt;/LABEL&gt; 
	&lt;LABEL name="SearchBy"&gt;Search By&lt;/LABEL&gt; 
	&lt;LABEL name="SearchFor"&gt;Find&lt;/LABEL&gt; 
	&lt;LABEL name="Go"&gt;Go&lt;/LABEL&gt; 
	&lt;LABEL name="NextPage"&gt;Next Page&lt;/LABEL&gt;
	&lt;LABEL name="PreviousPage"&gt;Previous Page&lt;/LABEL&gt;
	&lt;LABEL name="NoItems"&gt;No Items Found&lt;/LABEL&gt;
	&lt;LABEL name="EndOfList"&gt;End Of List&lt;/LABEL&gt; 
	&lt;LABEL name="ItemsDisplayed"&gt;items displayed&lt;/LABEL&gt; 

	&lt;LABEL name="New"&gt;New&lt;/LABEL&gt; 
	&lt;LABEL name="Add"&gt;Add&lt;/LABEL&gt; 
	&lt;LABEL name="Delete"&gt;Delete&lt;/LABEL&gt; 
	&lt;LABEL name="Update"&gt;Update&lt;/LABEL&gt; 
	&lt;LABEL name="Cancel"&gt;Cancel&lt;/LABEL&gt; 

	&lt;LABEL name="Month"&gt;Month&lt;/LABEL&gt; 
	&lt;LABEL name="Day"&gt;Day&lt;/LABEL&gt; 
	&lt;LABEL name="Year"&gt;Year&lt;/LABEL&gt; 
	&lt;LABEL name="Jan"&gt;January&lt;/LABEL&gt; 
	&lt;LABEL name="Feb"&gt;February&lt;/LABEL&gt; 
	&lt;LABEL name="Mar"&gt;March&lt;/LABEL&gt; 
	&lt;LABEL name="Apr"&gt;April&lt;/LABEL&gt; 
	&lt;LABEL name="May"&gt;May&lt;/LABEL&gt; 
	&lt;LABEL name="Jun"&gt;June&lt;/LABEL&gt; 
	&lt;LABEL name="Jul"&gt;July&lt;/LABEL&gt; 
	&lt;LABEL name="Aug"&gt;August&lt;/LABEL&gt; 
	&lt;LABEL name="Sep"&gt;September&lt;/LABEL&gt; 
	&lt;LABEL name="Oct"&gt;October&lt;/LABEL&gt; 
	&lt;LABEL name="Nov"&gt;November&lt;/LABEL&gt; 
	&lt;LABEL name="Dec"&gt;December&lt;/LABEL&gt; 

	&lt;LABEL name="Copyright"&gt;Copyright (c) 2001.  All rights reserved.&lt;/LABEL&gt; 
	&lt;LABEL name="RequiredField"&gt;indicates a required field.&lt;/LABEL&gt; 
	&lt;LABEL name="ConfirmDelete"&gt;DELETE! Are you completely sure you want to delete this?&lt;/LABEL&gt; 
</xsl:text>
</xsl:template>

</xsl:stylesheet>

