<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:include href="GenerateInclude.xsl"/>
<!--===============================================================================
	Auth: Bob Wood
	Date: February 2002
	Desc: Creates the Header for the SQL Scripter File for all stored procedures
	Copyright 2002 WinTech, Inc.
===================================================================================-->

	<xsl:template match="/">
		<SCRIPT><xsl:apply-templates/></SCRIPT>
	</xsl:template>

	<xsl:template match="WTROOT">

		<xsl:variable name="prefix" select="@prefix"/>
	
		<xsl:call-template name="header"><xsl:with-param name="prefix" select="$prefix"/></xsl:call-template>

		<xsl:value-of select="concat($cr, '&lt;!--', $cr)"/>

		<xsl:for-each select="/WTROOT/WTENTITIES/WTENTITY">
			<xsl:value-of select="concat($tab1, '&lt;TABLE name=&quot;', @name, '&quot;/&gt;', $cr)"/>
		</xsl:for-each>

		<xsl:value-of select="concat('--&gt;', $cr)"/>
		<xsl:call-template name="footer"><xsl:with-param name="prefix" select="$prefix"/></xsl:call-template>

	</xsl:template>

<xsl:template name="header">
<xsl:param name="prefix"/>
	<xsl:value-of select="concat($tab1, '&lt;ROOT&gt;', $cr, $cr)"/>
	<xsl:value-of select="concat($tab1, '&lt;!--SQL Scripter takes errors running these three system procs. Need to figure out why	--&gt;', $cr)"/>
	<xsl:value-of select="concat($tab0, '&lt;!--', $cr)"/>
	<xsl:value-of select="concat($tab1, '&lt;PROC name=&quot;', $prefix, '_CheckProc&quot;/&gt;', $cr)"/>
	<xsl:value-of select="concat($tab1, '&lt;PROC name=&quot;', $prefix, '_CheckForeignKey&quot;/&gt;', $cr)"/>
	<xsl:value-of select="concat($tab1, '&lt;PROC name=&quot;', $prefix, '_CheckTable&quot;/&gt;', $cr)"/>
	<xsl:value-of select="concat($tab0, '--&gt;', $cr)"/>
</xsl:template>

<xsl:template name="footer">
<xsl:param name="prefix"/>
	<xsl:value-of select="concat($tab1, '&lt;!-- KEYS name=&quot;ForeignKeyScriptName&quot; /&gt;	--&gt;', $cr)"/>
	<xsl:value-of select="concat($tab1, '&lt;PROC name=&quot;', $prefix, '_System_GetSeed&quot;/&gt;', $cr)"/>
	<xsl:value-of select="concat($tab1, '&lt;PROC name=&quot;', $prefix, '_System_GetLogon&quot;/&gt;', $cr)"/>
	<xsl:value-of select="concat($tab1, '&lt;PROC name=&quot;', $prefix, '_System_GetPassword&quot;/&gt;', $cr)"/>
	<xsl:value-of select="concat($tab1, '&lt;PROC name=&quot;', $prefix, '_System_EmailFooter&quot;/&gt;', $cr)"/>
	<xsl:value-of select="concat($tab1, '&lt;PROC name=&quot;', $prefix, '_System_EmailSend&quot;/&gt;', $cr)"/>
	<xsl:value-of select="concat($tab1, '&lt;PROC name=&quot;', $prefix, '_System_EmailSend&quot;/&gt;', $cr)"/>
	<xsl:value-of select="concat($tab1, '&lt;PROC name=&quot;', $prefix, '_System_EmailResetLogon&quot;/&gt;', $cr)"/>
	<xsl:value-of select="concat($tab1, '&lt;PROC name=&quot;', $prefix, '_System_EmailResetPassword&quot;/&gt;', $cr)"/>
	<xsl:value-of select="concat($tab1, '&lt;PROC name=&quot;', $prefix, '_AuthUser_Fetch&quot;/&gt;', $cr)"/>
	<xsl:value-of select="concat($tab1, '&lt;PROC name=&quot;', $prefix, '_AuthUser_FetchEmail&quot;/&gt;', $cr)"/>
	<xsl:value-of select="concat($tab1, '&lt;PROC name=&quot;', $prefix, '_AuthUser_FetchCustomerID&quot;/&gt;', $cr)"/>
	<xsl:value-of select="concat($tab1, '&lt;PROC name=&quot;', $prefix, '_AuthUser_Add&quot;/&gt;', $cr)"/>
	<xsl:value-of select="concat($tab1, '&lt;PROC name=&quot;', $prefix, '_AuthUser_ChangeLogon&quot;/&gt;', $cr)"/>
	<xsl:value-of select="concat($tab1, '&lt;PROC name=&quot;', $prefix, '_AuthUser_ChangePassword&quot;/&gt;', $cr)"/>
	<xsl:value-of select="concat($tab1, '&lt;PROC name=&quot;', $prefix, '_AuthUser_Count&quot;/&gt;', $cr)"/>

	<xsl:for-each select="/WTROOT/WTUSERGROUPS/WTUSERGROUP[not(@entity=preceding-sibling::WTUSERGROUP/@entity)]">
		<xsl:value-of select="concat($tab1, '&lt;PROC name=&quot;', $prefix, '_AuthUser_Delete',@entity, '&quot;/&gt;', $cr)"/>
	</xsl:for-each>

	<xsl:value-of select="concat($tab1, '&lt;PROC name=&quot;', $prefix, '_AuthUser_Delete&quot;/&gt;', $cr)"/>
	<xsl:value-of select="concat($tab1, '&lt;PROC name=&quot;', $prefix, '_AuthUser_Enum&quot;/&gt;', $cr)"/>
	<xsl:value-of select="concat($tab1, '&lt;PROC name=&quot;', $prefix, '_AuthUser_FindEmail&quot;/&gt;', $cr)"/>
	<xsl:value-of select="concat($tab1, '&lt;PROC name=&quot;', $prefix, '_AuthUser_FindLogon&quot;/&gt;', $cr)"/>
	<xsl:value-of select="concat($tab1, '&lt;PROC name=&quot;', $prefix, '_AuthUser_FindName&quot;/&gt;', $cr)"/>
	<xsl:value-of select="concat($tab1, '&lt;PROC name=&quot;', $prefix, '_AuthUser_List&quot;/&gt;', $cr)"/>
	<xsl:value-of select="concat($tab1, '&lt;PROC name=&quot;', $prefix, '_AuthUser_ResetLogon&quot;/&gt;', $cr)"/>
	<xsl:value-of select="concat($tab1, '&lt;PROC name=&quot;', $prefix, '_AuthUser_ResetPassword&quot;/&gt;', $cr)"/>
	<xsl:value-of select="concat($tab1, '&lt;PROC name=&quot;', $prefix, '_AuthUser_SignIn&quot;/&gt;', $cr)"/>
	<xsl:value-of select="concat($tab1, '&lt;PROC name=&quot;', $prefix, '_AuthUser_Update&quot;/&gt;', $cr)"/>
</xsl:template>

</xsl:stylesheet>


