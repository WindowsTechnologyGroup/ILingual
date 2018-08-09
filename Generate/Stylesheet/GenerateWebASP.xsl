<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:include href="GenerateIncludeASP.xsl"/>
<xsl:include href="GenerateWebASPMenu.xsl"/>
<xsl:include href="GenerateWebASPTab.xsl"/>
<!--===============================================================================
	Auth: Bob Wood	
	Date: November 2001
	Desc: Creates an Update Page ASP file from the entity definition
	Copyright 2001 WinTech, Inc.
===================================================================================-->
	<xsl:key name="key-objects" match="WTWEBPAGE/*/WTOBJECT" use="@name"/>
	<xsl:key name="key-attributes" match="/Data/WTENTITY/WTWEBPAGE/WTCONTENT/WTROW/*[@value]" use="value"/>

	<xsl:template match="/">
		<WEB><xsl:apply-templates select="/Data/WTENTITY"/></WEB>
	</xsl:template>

	<xsl:template match="WTENTITY">
		<xsl:variable name="unique-objects" select="WTWEBPAGE/*/WTOBJECT[generate-id() = generate-id(key('key-objects',@name))]"/>

		<!--========== INCLUDES ==========-->
		<xsl:call-template name="ASPInclude">
			<xsl:with-param name="filename">Include\System.asp</xsl:with-param>
		</xsl:call-template>

		<!-- If we have a navbar and it uses a menubar, include the menu file -->
		<xsl:if test="$MenuBar!=''">
			<xsl:call-template name="ASPInclude">
				<xsl:with-param name="filename" select="concat($MenuBar, '.asp')"/>
			</xsl:call-template>
		</xsl:if>

		<!-- If we are auditing this page, include the audit file -->
		<xsl:if test="/Data/WTENTITY/WTWEBPAGE/@audit">
			<xsl:call-template name="ASPInclude">
				<xsl:with-param name="filename">Include\Audit.asp</xsl:with-param>
			</xsl:call-template>
		</xsl:if>

    <!-- If we have input options, include the InputOptions file -->
    <xsl:if test="/Data/WTENTITY/WTWEBPAGE/descendant::*[name()='WTINPUTOPTIONS']">
      <xsl:call-template name="ASPInclude">
        <xsl:with-param name="filename">Include\InputOptions.asp</xsl:with-param>
      </xsl:call-template>
    </xsl:if>

    <!-- If we have custom fields, include the CustomFields file -->
    <xsl:if test="/Data/WTENTITY/WTWEBPAGE/descendant::*[name()='WTCUSTOMFIELDS']">
      <xsl:call-template name="ASPInclude">
        <xsl:with-param name="filename">Include\CustomFields.asp</xsl:with-param>
      </xsl:call-template>
    </xsl:if>

    <!-- include all webpage menus that are persisted -->
<!--
		<xsl:for-each select="/Data/WTENTITY/WTWEBPAGE/WTCONTENT/WTMENU[@persist]">
			<xsl:call-template name="ASPInclude">
				<xsl:with-param name="filename" select="concat(@name, '.asp')"/>
			</xsl:call-template>
		</xsl:for-each>
-->
		<xsl:apply-templates select="WTWEBPAGE/WTINCLUDE"/>

		<xsl:value-of select="concat($tab0, '&lt;% Response.Buffer=true', $cr)"/>

		<!--========== DECLARE ACTION CODES ==========-->
		<xsl:apply-templates select="WTWEBPAGE/WTACTION" mode="declare">
			<xsl:with-param name="indent">0</xsl:with-param>
		</xsl:apply-templates>

		<!--========== DECLARE COMMON ==========-->
		<xsl:call-template name="ASPPageDeclares"/>
		<xsl:call-template name="ASPSystemDeclares"/>
		<xsl:call-template name="ASPLanguageDeclares"/>

		<!--========== DECLARE OBJECTS ==========-->
		<xsl:apply-templates select="$unique-objects" mode="declare">
			<xsl:with-param name="indent">0</xsl:with-param>
		</xsl:apply-templates>

		<!--========== DECLARE EXTRA DATA ==========-->
		<xsl:apply-templates select="WTWEBPAGE/WTDATA" mode="declare">
			<xsl:with-param name="indent">0</xsl:with-param>
		</xsl:apply-templates>

		<!--========== DECLARE EXTRA TXN DATA ==========-->
		<xsl:apply-templates select="WTWEBPAGE/WTDATATXN" mode="declare">
			<xsl:with-param name="indent">0</xsl:with-param>
		</xsl:apply-templates>

		<!--========== DECLARE PARAMETERS ==========-->
		<xsl:apply-templates select="WTWEBPAGE/WTPARAM" mode="declare">
			<xsl:with-param name="indent">0</xsl:with-param>
		</xsl:apply-templates>

		<!--========== DECLARE VARIABLES ==========-->
		<xsl:apply-templates select="WTWEBPAGE/WTVARIABLE" mode="declare">
			<xsl:with-param name="indent">0</xsl:with-param>
		</xsl:apply-templates>

		<!--========== ERROR HANDLER ==========-->
		<xsl:call-template name="ASPErrorStart"/>
		<xsl:value-of select="$cr"/>
		
		<!--========== CALL COMMON SYSTEM FUNCTION ==========-->
		<xsl:call-template name="ASPComment">
			<xsl:with-param name="value">Call Common System Function</xsl:with-param>
		</xsl:call-template>
		<xsl:value-of select="concat('CommonSystem()', $cr, $cr)"/>

		<!--========== ERROR/LOG FUNCTIONS ==========-->
		<xsl:call-template name="ASPErrorFunction"/>
		<xsl:value-of select="$cr"/>
		<xsl:call-template name="ASPErrorInit"/>
		<xsl:value-of select="$cr"/>
		<xsl:if test="$LogProject and ($LogPage or $LogAction)">
			<xsl:call-template name="ASPLogFunction"/>
			<xsl:value-of select="$cr"/>
		</xsl:if>

		<!--========== SET RETURN URL ==========-->
		<xsl:call-template name="ASPReturnURLSet">
			<xsl:with-param name="pageno" select="/Data/WTENTITY/WTWEBPAGE/@name"/>
		</xsl:call-template>

		<!--========== SET COMMON ==========-->
		<xsl:call-template name="ASPSystemRequestItems"/>
		<xsl:value-of select="$cr"/>

		<!--========== SET PARAMETERS ==========-->
		<xsl:apply-templates select="WTWEBPAGE/WTPARAM" mode="fetch">
			<xsl:with-param name="indent">0</xsl:with-param>
		</xsl:apply-templates>

		<xsl:apply-templates select="WTWEBPAGE/WTSETATTRIBUTE">
			<xsl:with-param name="indent">0</xsl:with-param>
		</xsl:apply-templates>

		<!--========== CREATE RETURN URL ==========-->
		<xsl:call-template name="ASPReturnURLCreate"/>

		<!--========== COMMON PAGE STARTUP ==========-->
		<xsl:call-template name="ASPSecurityCheck"/>
		<xsl:value-of select="$cr"/>
		<xsl:call-template name="ASPLanguageCheck"/>
		<xsl:value-of select="$cr"/>

		<!--========== CREATE SUB FUNCTIONS ==========-->
		<xsl:apply-templates select="WTWEBPAGE/WTSUB">
			<xsl:with-param name="indent">0</xsl:with-param>
		</xsl:apply-templates>

		<!--========== HANDLE PRE-CODE ==========-->
		<xsl:apply-templates select="WTWEBPAGE/WTCODEGROUP[not(@post)]"/>

		<!--========== HANDLE ACTION CODES ==========-->
		<xsl:apply-templates select="WTWEBPAGE/WTACTION" mode="docase">
			<xsl:with-param name="indent">0</xsl:with-param>
		</xsl:apply-templates>

		<!--========== HANDLE COMMON OBJECT ==========-->
		<xsl:apply-templates select="WTWEBPAGE/WTOBJECT" mode="docase">
			<xsl:with-param name="indent">0</xsl:with-param>
		</xsl:apply-templates>
		<xsl:value-of select="$cr"/>

		<!--========== HANDLE POST-CODE ==========-->
		<xsl:apply-templates select="WTWEBPAGE/WTCODEGROUP[@post]"/>

		<!--========== GET SYSTEM XML ==========-->
		<xsl:call-template name="ASPSystemData"/>

		<!--========== GET TRANSACTION XML ==========-->
		<xsl:call-template name="ASPBuildTXNData">
			<xsl:with-param name="unique-objects" select="$unique-objects"/>
			<xsl:with-param name="datatxn-objects" select="WTWEBPAGE/WTDATATXN"/>
		</xsl:call-template>

		<!--========== HANDLE CONFIRMATION MESSAGE ==========-->
		<xsl:call-template name="ASPCheckConfirm"/>

		<!--========== GET LANGUAGE XML ==========-->
		<xsl:call-template name="ASPLanguageData"/>

		<!--========== Get MENUS =========-->
		<xsl:if test="$MenuBar!='' or count(/Data/WTENTITY/WTWEBPAGE/WTCONTENT/WTMENU)!=0">
			<xsl:call-template name="BuildMenus"/>
		</xsl:if>

		<!--========== BUILD TABS =========-->
		<xsl:for-each select="/Data/WTENTITY/WTWEBPAGE/WTCONTENT">
			<xsl:apply-templates select="WTTAB"/>
		</xsl:for-each>

		<!--========== GET DATA XML ==========-->
		<xsl:call-template name="ASPBuildXMLData"/>

		<!--========== LOAD STYLESHEET ========-->
		<xsl:call-template name="ASPStyleSheet"/>

		<!--========== LOAD XML DATA ==========-->
		<xsl:call-template name="ASPXMLData"/>

		<!--========== SAVE XML DATA ==========-->
		<xsl:call-template name="ASPSaveXMLData"/>

		<!--========== TRANSFORM PAGE =========-->
		<xsl:call-template name="ASPTransform"/>

		<!--========== LOG PAGE =========-->
		<xsl:if test="$LogProject and $LogPage">
			<xsl:call-template name="LogPage"/>
		</xsl:if>

		<!--========== END PAGE ==========-->
		<xsl:call-template name="ASPPageEnd"/>
		<xsl:value-of select="$cr"/>

	</xsl:template>
</xsl:stylesheet>
