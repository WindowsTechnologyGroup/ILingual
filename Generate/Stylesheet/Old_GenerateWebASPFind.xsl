<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:include href="GenerateIncludeASP.xsl"/>
<!--=====================================================================
	Auth:   Mike Wisniewski
	Date:   November 2001
	Desc:   Genrates the Find Page ASP file from the entity definition 
	Copyright 2001 WinTech, Inc.
======================================================================-->

	<xsl:template match="/">
		<WEB><xsl:apply-templates/></WEB>
	</xsl:template>

	<xsl:template match="WTENTITY">

		<xsl:variable name="itemname" select="$entityname"/>
		<xsl:variable name="collname" select="concat($itemname, 's')"/>
		<xsl:variable name="collobj" select="concat('o', $collname)"/>
		<xsl:variable name="fname" select="/Data/WTENTITY/WTENUM[@type='find']/WTATTRIBUTE[@default='true']/@name"/>
		<xsl:variable name="defaultfind" select="/Data/WTENTITY/WTATTRIBUTE[@name=$fname]/@id"/>

		<!--====================INCLUDES====================-->
		<xsl:call-template name="ASPInclude">
			<xsl:with-param name="filename">Include\System.asp</xsl:with-param>
		</xsl:call-template>
		<xsl:value-of select="concat($tab0, '&lt;% Response.Buffer=true', $cr)"/>

		<!--====================ACTION CODES====================-->
		<xsl:call-template name="ASPComment">
			<xsl:with-param name="value">action code constants</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ASPActionCodeDeclare">
			<xsl:with-param name="name">New</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ASPActionCodeDeclare">
			<xsl:with-param name="name">Find</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ASPActionCodeDeclare">
			<xsl:with-param name="name">Previous</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ASPActionCodeDeclare">
			<xsl:with-param name="name">Next</xsl:with-param>
		</xsl:call-template>

		<!--====================DECLARES====================-->
		<xsl:call-template name="ASPPageDeclares"/>
		<xsl:call-template name="ASPSystemDeclares"/>
		<xsl:call-template name="ASPLanguageDeclares"/>

		<xsl:call-template name="ASPComment">
			<xsl:with-param name="value">bookmark variables</xsl:with-param>
		</xsl:call-template>
		<xsl:value-of select="concat($tab0, 'Dim oBookmark, xmlBookmark', $cr)"/>
		<xsl:value-of select="concat($tab0, 'Dim reqSearchText', $cr)"/>
		<xsl:value-of select="concat($tab0, 'Dim reqFindType', $cr)"/>
		<xsl:value-of select="concat($tab0, 'Dim reqDirection', $cr)"/>
		<xsl:value-of select="concat($tab0, 'Dim reqBookmark', $cr)"/>

		<xsl:call-template name="ASPComment">
			<xsl:with-param name="value">object variables</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ASPObjectDeclares">
			<xsl:with-param name="name" select="$collname"/>
		</xsl:call-template>

		<!--==========create request variables for the parent==========-->
		<xsl:if test="($ischild)">
			<xsl:for-each select="($parentfields)">
				<xsl:variable name="aname" select="@name"/>
				<xsl:for-each select = "/Data/WTENTITY/WTATTRIBUTE[@name=$aname]">
					<xsl:value-of select="concat($tab0, 'Dim req', @name, $cr)"/>
				</xsl:for-each>
			</xsl:for-each>
		</xsl:if>
		
		<!--==========create request variables for secure fields==========-->
		<xsl:for-each select="WTWEBPAGE/WTCONDITION[@secured='true']">
			<xsl:variable name="aname" select="@column"/>
			<xsl:if test="count($parentfields[@name = $aname])=0">
				<xsl:for-each select = "/Data/WTENTITY/WTATTRIBUTE[@name=$aname]">
					<xsl:value-of select="concat($tab0, 'Dim req', @name, $cr)"/>
				</xsl:for-each>
			</xsl:if>
		</xsl:for-each>
		<xsl:value-of select="$cr"/>

		<!--==========ERROR HANDLER==========-->
		<xsl:call-template name="ASPErrorStart"/>
		<xsl:value-of select="$cr"/>

		<!--==========GET REQUEST VALUES==========-->
		<xsl:call-template name="ASPReturnURLSet">
			<xsl:with-param name="pageno" select="/Data/WTENTITY/WTWEBPAGE/@name"/>
		</xsl:call-template>
		<xsl:call-template name="ASPSystemRequestItems">
			<xsl:with-param name="defaultaction">
				<xsl:call-template name="ASPActionCode">
					<xsl:with-param name="name">Find</xsl:with-param>
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>

		<!--==========GET SECURE PAGE PARAMETER==========-->
		<xsl:if test="(count(WTWEBPAGE/WTCONDITION[@secured='true']) > 0)">
			<xsl:call-template name="ASPComment">
				<xsl:with-param name="value">get secure request items</xsl:with-param>
			</xsl:call-template>
		</xsl:if>

		<xsl:for-each select="WTWEBPAGE/WTCONDITION[@secured='true']">
			<xsl:variable name="aname" select="@column"/>
			<xsl:for-each select = "/Data/WTENTITY/WTATTRIBUTE[@name=$aname]">
				<xsl:call-template name="ASPSecureRequestItem">
					<xsl:with-param name="name" select="@name"/>
				</xsl:call-template>
			</xsl:for-each>
		</xsl:for-each>
		
		<xsl:value-of select="$cr"/>

		<xsl:value-of select="concat($tab0, 'reqSearchText = GetInput(&quot;SearchText&quot;, reqPageData)', $cr)"/>
		<xsl:value-of select="concat($tab0, 'reqFindType = CLng(GetInput(&quot;FindType&quot;, reqPageData))', $cr)"/>
		<xsl:value-of select="concat($tab0, 'reqBookmark = GetInput(&quot;Bookmark&quot;, reqPageData)', $cr, $cr)"/>

		<!--==========CREATE RETURN URL AND DATA==========-->
		<xsl:call-template name="ASPReturnURLCreate"/>

		<!--==========COMMON PAGE STARTUP==========-->
		<xsl:call-template name="ASPErrorFunction"/>
		<xsl:value-of select="$cr"/>
		<xsl:call-template name="ASPErrorInit"/>
		<xsl:value-of select="$cr"/>
		<xsl:call-template name="ASPSecurityCheck"/>
		<xsl:value-of select="$cr"/>
		<xsl:call-template name="ASPSystemData"/>
		<xsl:value-of select="$cr"/>

		<!--==========CREATE BUSINESS OBJECTS==========-->
		<xsl:call-template name="ASPComment">
			<xsl:with-param name="value">create business objects</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ASPCreateObject">
			<xsl:with-param name="name" select="$collobj"/>
			<xsl:with-param name="project" select="concat($appprefix, $itemname, 'User')"/>
			<xsl:with-param name="class" select="concat('C', $collname)"/>
		</xsl:call-template>
		<xsl:value-of select="$cr"/>

		<!--==========HANDLE ACTION CODES==========-->
		<xsl:call-template name="ASPComment">
			<xsl:with-param name="value">do the appropriate action based on the action code</xsl:with-param>
		</xsl:call-template>

		<xsl:value-of select="concat($tab0, 'Select Case CLng(reqActionCode)', $cr)"/>

		<xsl:call-template name="ASPActionCodeCase">
			<xsl:with-param name="name">New</xsl:with-param>
			<xsl:with-param name="indent">1</xsl:with-param>
		</xsl:call-template>
		<xsl:value-of select="concat($tab2, 'If (CLng(reqFindType) = 0) Then reqFindType = CLng(', $defaultfind, ')', $cr)"/>
		<xsl:value-of select="concat($tab2, 'reqDirection = CLng(1)', $cr)"/>
		<xsl:value-of select="concat($tab2, 'reqBookmark = &quot;&quot;', $cr)"/>

		<xsl:call-template name="ASPActionCodeCase">
			<xsl:with-param name="name">Find</xsl:with-param>
			<xsl:with-param name="indent">1</xsl:with-param>
		</xsl:call-template>
		<xsl:value-of select="concat($tab2, 'If (CLng(reqFindType) = 0) Then reqFindType = CLng(', $defaultfind, ')', $cr)"/>
		<xsl:value-of select="concat($tab2, 'reqDirection = CLng(1)', $cr)"/>
		<xsl:value-of select="concat($tab2, 'reqBookmark = &quot;&quot;', $cr)"/>

		<xsl:call-template name="ASPActionCodeCase">
			<xsl:with-param name="name">Previous</xsl:with-param>
			<xsl:with-param name="indent">1</xsl:with-param>
		</xsl:call-template>
		<xsl:value-of select="concat($tab2, 'reqDirection = CLng(2)', $cr)"/>

		<xsl:call-template name="ASPActionCodeCase">
			<xsl:with-param name="name">Next</xsl:with-param>
			<xsl:with-param name="indent">1</xsl:with-param>
		</xsl:call-template>
		<xsl:value-of select="concat($tab2, 'reqDirection = CLng(1)', $cr)"/>

		<xsl:value-of select="concat($tab0, 'End Select', $cr, $cr)"/>

		<!--==========GET BUSINESS OBJECT XML==========-->
		<xsl:call-template name="ASPComment">
			<xsl:with-param name="value">get the business object XML</xsl:with-param>
		</xsl:call-template>
		<xsl:value-of select="concat($tab0, 'With ', $collobj, $cr)"/>
		<xsl:value-of select="concat($tab1, 'reqBookmark = .Find(CLng(reqFindType), reqBookmark, reqSearchText, CLng(reqDirection), ')"/>

		<!--==========add parent parameter if child entity==========-->
		<xsl:if test="($ischild)">
			<xsl:for-each select="$parentfields">
				<xsl:variable name="aname" select="@name"/>
				<xsl:for-each select = "/Data/WTENTITY/WTATTRIBUTE[@name=$aname]">
					<xsl:value-of select="concat('CLng(req', @name, '), ')"/>
				</xsl:for-each>
			</xsl:for-each>
		</xsl:if>
		<xsl:value-of select="concat($tab0, 'CLng(reqSysUserID)')"/>

		<!--==========add parameters for secure fields==========-->
		<xsl:for-each select="WTWEBPAGE/WTCONDITION[@secured='true']">
			<xsl:variable name="aname" select="@column"/>
			<xsl:if test="count($parentfields[@name = $aname])=0">
				<xsl:for-each select = "/Data/WTENTITY/WTATTRIBUTE[@name=$aname]">
					<xsl:value-of select="concat(', CLng(req', @name, ')')"/>
				</xsl:for-each>
			</xsl:if>
		</xsl:for-each>
		<xsl:value-of select="concat($tab0, ')', $cr)"/>

		<xsl:call-template name="ASPErrorCheck">
			<xsl:with-param name="indent">1</xsl:with-param>
		</xsl:call-template>
		<xsl:value-of select="concat($tab1, 'xml', $collname, ' = xml', $collname, ' + .XML', $cr)"/>
		<xsl:value-of select="concat($tab1, 'xml', $collname, ' = xml', $collname, ' + ')"/>
		<xsl:value-of select="concat($tab0, '.EnumItems(', /Data/WTENTITY/WTENUM[@type='find']/@id, ', CLng(reqSysUserGroup)).XML(&quot;FINDTYPES&quot;,CLng(reqFindType))', $cr)"/>
		<xsl:value-of select="concat($tab0, 'End With', $cr, $cr)"/>

		<!--==========GET BOOKMARK XML==========-->
		<xsl:call-template name="ASPComment">
			<xsl:with-param name="value">get the bookmark XML</xsl:with-param>
		</xsl:call-template>

		<xsl:call-template name="ASPCreateObject">
			<xsl:with-param name="name">oBookmark</xsl:with-param>
			<xsl:with-param name="project">wtSystem</xsl:with-param>
			<xsl:with-param name="class">CBookmark</xsl:with-param>
		</xsl:call-template>
		<xsl:value-of select="concat($tab0, 'With oBookmark', $cr)"/>
		<xsl:value-of select="concat($tab1, '.LastBookmark = reqBookmark', $cr)"/>
		<xsl:value-of select="concat($tab1, 'xmlBookmark = .XML', $cr)"/>
		<xsl:value-of select="concat($tab0, 'End With', $cr, $cr)"/>

		<!--==========GET TRANSACTION XML==========-->
		<xsl:call-template name="ASPComment">
			<xsl:with-param name="value">get the transaction XML</xsl:with-param>
		</xsl:call-template>

		<xsl:value-of select="concat($tab0, 'xmlTransaction = xmlTransaction + &quot;&lt;TXN&gt;&quot;', $cr)"/>
		<xsl:value-of select="concat($tab0, 'xmlTransaction = xmlTransaction +  xml', $collname, $cr)"/>
		<xsl:value-of select="concat($tab0, 'xmlTransaction = xmlTransaction + &quot;&lt;/TXN&gt;&quot;', $cr, $cr)"/>

		<!--==========HANDLE CONFIRMATION MESSAGE==========-->
		<xsl:call-template name="ASPCheckConfirm"/>
		<xsl:value-of select="$cr"/>

		<!--==========GET LANGUAGE XML==========-->
		<xsl:call-template name="ASPLanguageData"/>
		<xsl:value-of select="$cr"/>

		<!--==========GET DATA XML==========-->
		<xsl:call-template name="ASPComment">
			<xsl:with-param name="value">get the data XML</xsl:with-param>
		</xsl:call-template>

		<xsl:value-of select="concat($tab0, 'xmlData = xmlData + &quot;&lt;DATA&gt;&quot;', $cr)"/>
		<xsl:value-of select="concat($tab0, 'xmlData = xmlData +  xmlTransaction', $cr)"/>
		<xsl:value-of select="concat($tab0, 'xmlData = xmlData +  xmlSystem', $cr)"/>
		<xsl:value-of select="concat($tab0, 'xmlData = xmlData +  xmlConfig', $cr)"/>
		<xsl:value-of select="concat($tab0, 'xmlData = xmlData +  xmlParent', $cr)"/>
		<xsl:value-of select="concat($tab0, 'xmlData = xmlData +  xmlLanguage', $cr)"/>
		<xsl:value-of select="concat($tab0, 'xmlData = xmlData +  xmlError', $cr)"/>
		<xsl:value-of select="concat($tab0, 'xmlData = xmlData +  xmlBookmark', $cr)"/>
		<xsl:value-of select="concat($tab0, 'xmlData = xmlData + &quot;&lt;/DATA&gt;&quot;', $cr, $cr)"/>

		<!--==========GET STYLESHEET XSL==========-->
		<xsl:call-template name="ASPStyleSheet"/>
		<xsl:value-of select="$cr"/>

		<!--==========TRANSFORM PAGE==========-->
		<xsl:call-template name="ASPTransform"/>
		<xsl:value-of select="$cr"/>

		<!--==========END PAGE==========-->
		<!--collection object-->
		<xsl:value-of select="concat($tab0, 'Set ', $collobj, ' = Nothing', $cr)"/>
	
		<!--bookmark object-->
		<xsl:value-of select="concat($tab0, 'Set oBookmark = Nothing', $cr)"/>

		<!--common page objects-->
		<xsl:call-template name="ASPPageEnd"/>
		<xsl:value-of select="$cr"/>

	</xsl:template>
</xsl:stylesheet>
