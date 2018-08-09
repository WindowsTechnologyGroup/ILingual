<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:include href="GenerateIncludeXSL.xsl"/>
<!--=====================================================================
	Auth:   Bob Wood
	Date:   February 2002
	Desc:   Create the Compile Batch file
	Copyright 2002 WinTech, Inc.
======================================================================-->

	<xsl:template match="/">
		<BAT><xsl:apply-templates/></BAT>
	</xsl:template>

	<xsl:template match="WTROOT">
		<xsl:variable name="path" select="@path"/>	
		<xsl:variable name="prefix" select="@prefix"/>	
		
		<xsl:call-template name="CompileHeader"/>
		
		<xsl:for-each select="/WTROOT/WTENTITIES/WTENTITY">
			<xsl:value-of select="concat('CALL CompilePgm.bat C ', $path, $prefix, @name, '  ', $path, $prefix, @name, '  ', $prefix, @name, 'Busn', $cr)"/>
		</xsl:for-each>

			<xsl:value-of select="concat( $cr, 'REM ----- user components', $cr)"/>
			<xsl:value-of select="concat(':user', $cr)"/>

		<xsl:for-each select="/WTROOT/WTENTITIES/WTENTITY">
			<xsl:value-of select="concat('CALL CompilePgm.bat C ', $path, $prefix, @name, '  ', $path, $prefix, @name, '  ', $prefix, @name, 'User', $cr)"/>
		</xsl:for-each>

		<xsl:call-template name="CompileFooter"/>
	
	</xsl:template>


<!--************************************************************************************************-->
<xsl:template name="CompileHeader">
<xsl:text>
@echo off
REM Note: if this code fails to execute or asks for a login name and password
REM you need to modify your source safe ini file to point to the source safe
REM database on the network, rather than your local machine. To do this,
REM modify C:\Program Files\Microsoft\Visual Studio\Common\VSS\srcsafe.ini
REM Data_Path = \\Wt-source\Visual Source Safe\data
REM Temp_Path = \\Wt-source\Visual Source Safe\temp
REM Users_Path = \\Wt-source\Visual Source Safe\users
REM Users_Txt = \\Wt-source\Visual Source Safe\users.txt

REM ----- stop Norton AntiVirus Auto-Protect
REM net stop "NAV Auto-Protect" /y

REM ----- stop IIS service
net stop iisadmin /y

REM ----- system object
:system
REM CALL CompilePgm.bat C WinTech  WinTech  wtSystem

REM ----- business components
:busn
</xsl:text>
</xsl:template>

<!--************************************************************************************************-->
<xsl:template name="CompileFooter">
<xsl:text>
REM ----- production components
:prod
CALL CompilePgm.bat C WinTech\ILingual  WinTech/ILingual  wtiWeb

REM ----- re-start IIS service
net start w3svc /y

REM ----- start Norton AntiVirus Auto-Protect
REM net start "NAV Auto-Protect" /y

:end
echo .................... end of script ....................  
pause
</xsl:text>
</xsl:template>

</xsl:stylesheet>

