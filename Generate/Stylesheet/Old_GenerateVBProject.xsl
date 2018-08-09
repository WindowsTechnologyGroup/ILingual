<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:include href="GenerateIncludeVB.xsl"/>

	<!--==================================================================-->
	<xsl:template match="/">
	<!--==================================================================-->
		<VB><xsl:apply-templates/></VB>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="/Data">
	<!--==================================================================-->
		<xsl:apply-templates select="WTENTITY/WTCOMPONENT">
			<xsl:with-param name="indent">0</xsl:with-param>
		</xsl:apply-templates>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTCOMPONENT">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>

		<xsl:value-of select="concat($ind1, 'Type=OleDll', $cr)"/>

		<xsl:apply-templates select="WTREFERENCE">
			<xsl:with-param name="indent">0</xsl:with-param>
		</xsl:apply-templates>

		<xsl:apply-templates select="WTCLASS">
			<xsl:with-param name="indent">0</xsl:with-param>
		</xsl:apply-templates>

		<xsl:apply-templates select="WTMODULE">
			<xsl:with-param name="indent">0</xsl:with-param>
		</xsl:apply-templates>

		<xsl:value-of select="concat($ind1, 'Startup=&quot;(None)&quot;', $cr)"/>
		<xsl:value-of select="concat($ind1, 'HelpFile=&quot;&quot;', $cr)"/>
		<xsl:value-of select="concat($ind1, 'Title=&quot;', $appprefix, @name, '&quot;', $cr)"/>
		<xsl:value-of select="concat($ind1, 'ExeName32=&quot;', $appprefix, @name, '.dll&quot;', $cr)"/>
		<xsl:value-of select="concat($ind1, 'Command32=&quot;&quot;', $cr)"/>
		<xsl:value-of select="concat($ind1, 'Name=&quot;', $appprefix, @name, '&quot;', $cr)"/>
		<xsl:value-of select="concat($ind1, 'HelpContextID=&quot;0&quot;', $cr)"/>
		<xsl:value-of select="concat($ind1, 'Description=&quot;', $appprefix, ' ', @name, ' Library&quot;', $cr)"/>
		<xsl:value-of select="concat($ind1, 'CompatibleMode=&quot;1&quot;', $cr)"/>
		<xsl:value-of select="concat($ind1, 'CompatibleEXE32=&quot;&quot;', $cr)"/>
		<xsl:value-of select="concat($ind1, 'MajorVer=1', $cr)"/>
		<xsl:value-of select="concat($ind1, 'MinorVer=0', $cr)"/>
		<xsl:value-of select="concat($ind1, 'RevisionVer=0', $cr)"/> 
		<xsl:value-of select="concat($ind1, 'AutoIncrementVer=1', $cr)"/> 
		<xsl:value-of select="concat($ind1, 'ServerSupportFiles=0', $cr)"/>
		<xsl:value-of select="concat($ind1, 'VersionComments=&quot;', $appprefix, ' ', @name, ' Library&quot;', $cr)"/>
		<xsl:value-of select="concat($ind1, 'VersionCompanyName=&quot;WinTech, Inc.&quot;', $cr)"/> 
		<xsl:value-of select="concat($ind1, 'VersionFileDescription=&quot;', $appprefix, ' ', @name, ' Library&quot;', $cr)"/>
		<xsl:value-of select="concat($ind1, 'VersionLegalCopyright=&quot;Copyright (c) 2002 ', /Data/@copyright, ' All rights reserved.&quot;', $cr)"/>
		<xsl:value-of select="concat($ind1, 'VersionProductName=&quot;', /Data/@product, '&quot;', $cr)"/>
		<xsl:value-of select="concat($ind1, 'CompilationType=0', $cr)"/>
		<xsl:value-of select="concat($ind1, 'OptimizationType=0', $cr)"/>
		<xsl:value-of select="concat($ind1, 'FavorPentiumPro(tm)=0', $cr)"/>
		<xsl:value-of select="concat($ind1, 'CodeViewDebugInfo=0', $cr)"/>
		<xsl:value-of select="concat($ind1, 'NoAliasing=0', $cr)"/>
		<xsl:value-of select="concat($ind1, 'BoundsCheck=0', $cr)"/>
		<xsl:value-of select="concat($ind1, 'OverflowCheck=0', $cr)"/>
		<xsl:value-of select="concat($ind1, 'FlPointCheck=0', $cr)"/>
		<xsl:value-of select="concat($ind1, 'FDIVCheck=0', $cr)"/>
		<xsl:value-of select="concat($ind1, 'UnroundedFP=0', $cr)"/>
		<xsl:value-of select="concat($ind1, 'StartMode=1', $cr)"/>
		<xsl:value-of select="concat($ind1, 'Unattended=0', $cr)"/>
		<xsl:value-of select="concat($ind1, 'Retained=0', $cr)"/>
		<xsl:value-of select="concat($ind1, 'ThreadPerObject=0', $cr)"/>
		<xsl:value-of select="concat($ind1, 'MaxNumberOfThreads=1', $cr)"/>
		<xsl:value-of select="concat($ind1, 'ThreadingModel=1', $cr)"/>
		<xsl:value-of select="concat($ind1, 'DebugStartupOption=0', $cr, $cr)"/>
		
		<xsl:value-of select="concat($ind1, '[MS Transaction Server]', $cr)"/>
		<xsl:value-of select="concat($ind1, 'AutoRefresh=1', $cr, $cr)"/>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTCLASS">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>

		<xsl:value-of select="concat($ind1, 'Class=', @name, '; ', @name, '.cls', $cr)"/>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTREFERENCE">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>

		<xsl:value-of select="concat($ind1, 'Reference=*\G{', @guid, '}#', @version, '#', @revision, '#', @path, '#', @name, $cr)"/>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTMODULE">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>

		<xsl:value-of select="concat($ind1, 'Module=', @name, '; ', @path, $cr)"/>
	</xsl:template>

</xsl:stylesheet>
