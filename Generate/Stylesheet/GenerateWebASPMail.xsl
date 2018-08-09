<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:include href="GenerateIncludeASP.xsl"/>
<!--===============================================================================
	Auth: Mike Wisniewski	
	Date: November 2001
	Desc: Creates an Update Page ASP file from the entity definition
	Copyright 2001 WinTech, Inc.
===================================================================================-->
	<xsl:key name="key-objects" match="WTWEBPAGE/*/WTOBJECT" use="@name"/>
	<xsl:key name="key-attributes" match="/Data/WTENTITY/WTWEBPAGE/WTCONTENT/WTROW/*[@value]" use="value"/>

	<xsl:template match="/">
		<WEB><xsl:apply-templates/></WEB>
	</xsl:template>

	<xsl:template match="WTENTITY">
		<xsl:variable name="unique-objects" select="WTWEBPAGE/*/WTOBJECT[generate-id() = generate-id(key('key-objects',@name))]"/>

		<!--========== INCLUDES ==========-->
		<xsl:call-template name="ASPInclude">
			<xsl:with-param name="filename">Include\System.asp</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ASPInclude">
			<xsl:with-param name="filename">Include\Comm.asp</xsl:with-param>
		</xsl:call-template>

		<!-- If we are auditing this page, include the audit file -->
		<xsl:if test="/Data/WTENTITY/WTWEBPAGE/@audit">
			<xsl:call-template name="ASPInclude">
				<xsl:with-param name="filename">Include\Audit.asp</xsl:with-param>
			</xsl:call-template>
		</xsl:if>

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

		<!--========== ERROR/LOG FUNCTIONS ==========-->
		<xsl:call-template name="ASPErrorFunction"/>
		<xsl:value-of select="$cr"/>
		<xsl:call-template name="ASPErrorInit"/>
		<xsl:value-of select="$cr"/>
		<xsl:if test="$LogProject and ($LogPage or $LogAction)">
			<xsl:call-template name="ASPLogFunction"/>
			<xsl:value-of select="$cr"/>
		</xsl:if>

		<!--========== SET COMMON ==========-->
		<xsl:call-template name="ASPSystemRequestItems"/>
		<xsl:value-of select="$cr"/>

		<!--========== SET PARAMETERS ==========-->
		<xsl:apply-templates select="WTWEBPAGE/WTPARAM" mode="fetch">
			<xsl:with-param name="indent">0</xsl:with-param>
		</xsl:apply-templates>
		<xsl:value-of select="$cr"/>

		<xsl:apply-templates select="WTWEBPAGE/WTSETATTRIBUTE">
			<xsl:with-param name="indent">0</xsl:with-param>
		</xsl:apply-templates>

		<!--========== COMMON PAGE STARTUP ==========-->
		<xsl:call-template name="ASPSecurityCheck"/>
		<xsl:value-of select="$cr"/>
		<xsl:call-template name="ASPLanguageCheck"/>
		<xsl:value-of select="$cr"/>

		<!--========== GET SYSTEM XML ==========-->
		<xsl:call-template name="ASPSystemData">
			<xsl:with-param name="pagetype">mail</xsl:with-param>
		</xsl:call-template>

		<!--========== LOAD STYLESHEET ========-->
		<xsl:call-template name="ASPStyleSheet"/>

		<!--========== CREATE SUB FUNCTIONS ==========-->
		<xsl:apply-templates select="WTWEBPAGE/WTSUB">
			<xsl:with-param name="indent">0</xsl:with-param>
		</xsl:apply-templates>

		<!--========== HANDLE PRE-CODE ==========-->
		<xsl:apply-templates select="WTWEBPAGE/WTCODEGROUP"/>

		<!--========== HANDLE ACTION CODES ==========-->
		<xsl:apply-templates select="WTWEBPAGE/WTACTION" mode="docase">
			<xsl:with-param name="indent">0</xsl:with-param>
		</xsl:apply-templates>

		<!--========== LOG PAGE =========-->
		<xsl:if test="$LogProject and $LogPage">
			<xsl:call-template name="LogPage"/>
		</xsl:if>

		<xsl:value-of select="$cr"/>
		<xsl:value-of select="concat($tab0, 'If reqMailReturnURL &lt;&gt; &quot;&quot; Then', $cr)"/>
		<xsl:value-of select="concat($tab1, 'Response.Redirect Replace(reqMailReturnURL, &quot;%26&quot;, &quot;&amp;&quot;)', $cr)"/>
		<xsl:value-of select="concat($tab0, 'End If', $cr, $cr)"/>
		
		<!--========== END PAGE ==========-->
		<xsl:call-template name="ASPPageEnd"/>
		<xsl:value-of select="$cr"/>

	</xsl:template>
</xsl:stylesheet>
