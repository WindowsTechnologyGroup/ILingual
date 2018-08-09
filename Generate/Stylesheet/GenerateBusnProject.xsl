<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:include href="GenerateIncludeVB.xsl"/>
<!--===============================================================================
	Auth: Mike Wisniewski
	Date: October 2001
	Desc: Creates a VB Business Project 
	Copyright 2001 WinTech, Inc.
===================================================================================-->
	<xsl:template match="/">
		<VB><xsl:apply-templates/></VB>
	</xsl:template>

	<!--=============Create the VB Business Project====================================-->
	<xsl:template match="WTENTITY">
		<xsl:variable name="prefix" select="concat($appprefix, /Data/@project)"/>

		<xsl:value-of select="concat($tab0, 'Type=OleDll', $cr)"/>
		<xsl:value-of select="concat($tab0, 'Reference=*\G{00020430-0000-0000-C000-000000000046}#2.0#0#C:\WINNT\System32\STDOLE2.TLB#OLE Automation', $cr)"/>
		<xsl:value-of select="concat($tab0, 'Reference=*\G{00000206-0000-0010-8000-00AA006D2EA4}#2.6#0#C:\Program Files\Common Files\System\ADO\msado26.tlb#Microsoft ActiveX Data Objects 2.6 Library', $cr)"/>
		<xsl:value-of select="concat($tab0, 'Reference=*\G{2A005C00-A5DE-11CF-9E66-00AA00A3F464}#1.0#0#C:\WINNT\System32\COMSVCS.DLL#COM+ Services Type Library', $cr)"/>
		<xsl:value-of select="concat($tab0, 'Reference=*\G{811576F5-E91B-41D6-8F1A-A6CDA4268D37}#4.0#0#..\..\..\WinTech\wtSystem\wtSystem.dll#WinTech System Library', $cr)"/>

		<xsl:value-of select="concat($tab0, 'Class=C', /Data/@project, 'B; C', /Data/@project, 'B.cls', $cr)"/>

		<xsl:value-of select="concat($tab0, 'Module=C', /Data/@project, 'Mod; C', /Data/@project, 'Mod.bas', $cr)"/>
		<xsl:value-of select="concat($tab0, 'Module=wtiCommonADOMod; ..\_common\wtiCommonADOMod.bas', $cr)"/>
		<xsl:value-of select="concat($tab0, 'Module=', $appprefix, 'CommonMod; ..\_common\', $appprefix, 'CommonMod.bas', $cr)"/>
		<xsl:value-of select="concat($tab0, 'Module=', $appprefix, 'ErrorMod; ..\_common\', $appprefix, 'ErrorMod.bas', $cr)"/>
		<xsl:value-of select="concat($tab0, 'Startup=&quot;(None)&quot;', $cr)"/>
		<xsl:value-of select="concat($tab0, 'HelpFile=&quot;&quot;', $cr)"/>

		<xsl:value-of select="concat($tab0, 'Title=&quot;', $prefix, 'Busn&quot;', $cr)"/>
		<xsl:value-of select="concat($tab0, 'ExeName32=&quot;', $prefix, 'Busn.dll&quot;', $cr)"/>
		<xsl:value-of select="concat($tab0, 'Path32=&quot;..\..\LIB', $cr)"/>
		<xsl:value-of select="concat($tab0, 'Command32=&quot;&quot;', $cr)"/>
		<xsl:value-of select="concat($tab0, 'Name=&quot;', $prefix, 'Busn&quot;', $cr)"/>
		<xsl:value-of select="concat($tab0, 'HelpContextID=&quot;0&quot;', $cr)"/>
		<xsl:value-of select="concat($tab0, 'Description=&quot;', $appprefix, ' ', /Data/@project, ' Business Library&quot;', $cr)"/>
		<xsl:value-of select="concat($tab0, 'CompatibleMode=&quot;1&quot;', $cr)"/>
		<xsl:value-of select="concat($tab0, 'CompatibleEXE32=&quot;..\..\LIB\', $prefix, 'Busn.dll&quot;', $cr)"/>
		<xsl:value-of select="concat($tab0, 'MajorVer=1', $cr)"/>
		<xsl:value-of select="concat($tab0, 'MinorVer=0', $cr)"/>
		<xsl:value-of select="concat($tab0, 'RevisionVer=0', $cr)"/> 
		<xsl:value-of select="concat($tab0, 'AutoIncrementVer=1', $cr)"/> 
		<xsl:value-of select="concat($tab0, 'ServerSupportFiles=0', $cr)"/>
		<xsl:value-of select="concat($tab0, 'VersionComments=&quot;', $appprefix, ' ', /Data/@project, ' Business Library&quot;', $cr)"/>
		<xsl:value-of select="concat($tab0, 'VersionCompanyName=&quot;WinTech, Inc.&quot;', $cr)"/> 
		<xsl:value-of select="concat($tab0, 'VersionFileDescription=&quot;', $appprefix, ' ', /Data/@project, ' Business Library&quot;', $cr)"/>
		<xsl:value-of select="concat($tab0, 'VersionLegalCopyright=&quot;Copyright (c) 2001 WinTech, Inc. All rights reserved.&quot;', $cr)"/>
		<xsl:value-of select="concat($tab0, 'VersionProductName=&quot;Case Management System&quot;', $cr)"/>
		<xsl:value-of select="concat($tab0, 'CompilationType=0', $cr)"/>
		<xsl:value-of select="concat($tab0, 'OptimizationType=0', $cr)"/>
		<xsl:value-of select="concat($tab0, 'FavorPentiumPro(tm)=0', $cr)"/>
		<xsl:value-of select="concat($tab0, 'CodeViewDebugInfo=0', $cr)"/>
		<xsl:value-of select="concat($tab0, 'NoAliasing=0', $cr)"/>
		<xsl:value-of select="concat($tab0, 'BoundsCheck=0', $cr)"/>
		<xsl:value-of select="concat($tab0, 'OverflowCheck=0', $cr)"/>
		<xsl:value-of select="concat($tab0, 'FlPointCheck=0', $cr)"/>
		<xsl:value-of select="concat($tab0, 'FDIVCheck=0', $cr)"/>
		<xsl:value-of select="concat($tab0, 'UnroundedFP=0', $cr)"/>
		<xsl:value-of select="concat($tab0, 'StartMode=1', $cr)"/>
		<xsl:value-of select="concat($tab0, 'Unattended=1', $cr)"/>
		<xsl:value-of select="concat($tab0, 'Retained=1', $cr)"/>
		<xsl:value-of select="concat($tab0, 'ThreadPerObject=0', $cr)"/>
		<xsl:value-of select="concat($tab0, 'MaxNumberOfThreads=1', $cr)"/>
		<xsl:value-of select="concat($tab0, 'DebugStartupOption=0', $cr, $cr)"/>
		
		<xsl:value-of select="concat($tab0, '[MS Transaction Server]', $cr)"/>
		<xsl:value-of select="concat($tab0, 'AutoRefresh=1', $cr)"/>
	</xsl:template>
</xsl:stylesheet>
