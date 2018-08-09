<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:include href="GenerateIncludeXSL.xsl"/>
<!--=====================================================================
	Auth:   Mike Wisniewski
	Date:   November 2001
	Desc:   Generates the Find Page stylesheet from the entity definition 
	Copyright 2001 WinTech, Inc.
======================================================================-->

	<xsl:template match="/">
		<WEB><xsl:apply-templates/></WEB>
	</xsl:template>

	<xsl:template match="WTENTITY">
		<xsl:value-of select="concat($tab0, '&lt;xsl:stylesheet version=&quot;1.0&quot; xmlns:xsl=&quot;http://www.w3.org/1999/XSL/Transform&quot; xmlns:msxsl=&quot;urn:schemas-microsoft-com:xslt&quot;&gt;', $cr)"/>

		<!--====================INCLUDES====================-->
		<xsl:call-template name="XSLInclude">
			<xsl:with-param name="filename">HTMLHeading</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="XSLInclude">
			<xsl:with-param name="filename">PageFooter</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="XSLInclude">
			<xsl:with-param name="filename">NavBar</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="XSLInclude">
			<xsl:with-param name="filename">Bookmark</xsl:with-param>
		</xsl:call-template>
		<xsl:value-of select="concat($tab1, '&lt;xsl:output omit-xml-declaration=&quot;yes&quot;/&gt;', $cr, $cr)"/>
		<xsl:value-of select="concat($tab1, '&lt;xsl:template match=&quot;/&quot;&gt;', $cr, $cr)"/>

		<!--==========DECLARE VARIABLE FOR FIND BY CHOICE==========-->
		<xsl:value-of select="concat($tab2, '&lt;xsl:variable name=&quot;findchoice&quot; select=&quot;/DATA/TXN/FINDTYPES/ENUM[@selected=', $apos, 'True', $apos, ']/@name&quot;/&gt;', $cr, $cr)"/>

		<!--==========BEGIN PAGE==========-->
		<xsl:call-template name="XSLPageBegin">
			<xsl:with-param name="name">Find</xsl:with-param>
		</xsl:call-template>

		<!--==========BEGIN FORM==========-->
		<xsl:call-template name="XSLFormBegin">
			<xsl:with-param name="name">Find</xsl:with-param>
		</xsl:call-template>

		<xsl:call-template name="XSLHiddenInput">
			<xsl:with-param name="name">ActionCode</xsl:with-param>
			<xsl:with-param name="indent">5</xsl:with-param>
		</xsl:call-template>

		<xsl:if test="/Data/WTENTITY/WTWEBPAGE/@contentpage='true'">
			<xsl:call-template name="XSLHiddenInput">
				<xsl:with-param name="name">ContentPage</xsl:with-param>
				<xsl:with-param name="indent">5</xsl:with-param>
				<xsl:with-param name="value" select="'/DATA/PARAM/@contentpage'"/>
			</xsl:call-template>
		</xsl:if>

		<xsl:call-template name="XSLHiddenInput">
			<xsl:with-param name="name">Bookmark</xsl:with-param>
			<xsl:with-param name="value">/DATA/BOOKMARK/@nextbookmark</xsl:with-param>
			<xsl:with-param name="indent">5</xsl:with-param>
		</xsl:call-template>

		<!--==========BEGIN PAGE LAYOUT ROW==========-->
		<xsl:call-template name="XSLPageRow"/>

		<!--==========PAGE HEADER==========-->
		<xsl:call-template name="XSLHeaderRow"/>

		<!--==========BEGIN CONTENT==========-->
		<xsl:call-template name="XSLContentBegin"/>

		<!--==========build first blank line==========-->
		<xsl:value-of select="concat($tab8, '&lt;xsl:element name=&quot;TR&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($tab9, '&lt;xsl:element name=&quot;TD&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($tab10, '&lt;xsl:attribute name=&quot;width&quot;&gt;600&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($tab9, '&lt;/xsl:element&gt;', $cr)"/>
		<xsl:value-of select="concat($tab8, '&lt;/xsl:element&gt;', $cr)"/>

		<!--==========PAGE HEADING==========-->
		<xsl:call-template name="XSLPageHeading">
			<xsl:with-param name="header" select="/Data/WTENTITY/WTWEBPAGE/WTHEADER"/>
			<xsl:with-param name="type">Find</xsl:with-param>
			<xsl:with-param name="indent">8</xsl:with-param>
		</xsl:call-template>
		<xsl:value-of select="$cr"/>

		<xsl:call-template name="XSLBlankLine">
			<xsl:with-param name="height">12</xsl:with-param>
			<xsl:with-param name="indent">8</xsl:with-param>
		</xsl:call-template>

		<!--==========BEGIN FIND ROW==========-->
		<xsl:call-template name="XSLComment">
			<xsl:with-param name="indent">8</xsl:with-param>
			<xsl:with-param name="value">BEGIN FIND ROW</xsl:with-param>
		</xsl:call-template>
		<xsl:value-of select="concat($tab8, '&lt;xsl:element name=&quot;TR&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($tab9, '&lt;xsl:element name=&quot;TD&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($tab10, '&lt;xsl:attribute name=&quot;align&quot;&gt;left&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($tab10, '&lt;xsl:attribute name=&quot;valign&quot;&gt;center&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($tab10, '&lt;xsl:attribute name=&quot;class&quot;&gt;ColumnHeader&lt;/xsl:attribute&gt;', $cr)"/>

		<!--==========SEARCH FOR SELECTION==========-->
		<xsl:call-template name="XSLComment">
			<xsl:with-param name="indent">10</xsl:with-param>
			<xsl:with-param name="value">BEGIN SEARCH BY</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="XSLLabelText">
			<xsl:with-param name="label">SearchBy</xsl:with-param>
			<xsl:with-param name="islabel" select="true()"/>
			<xsl:with-param name="indent">10</xsl:with-param>
			<xsl:with-param name="newline" select="true()"/>
		</xsl:call-template>		
		<xsl:value-of select="$tab10"/>
		<xsl:call-template name="XSLDblSpace"/>
		<xsl:value-of select="$cr"/>
		<xsl:value-of select="concat($tab10, '&lt;xsl:element name=&quot;SELECT&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($tab11, '&lt;xsl:attribute name=&quot;name&quot;&gt;FindType&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($tab11, '&lt;xsl:for-each select=&quot;/DATA/TXN/FINDTYPES/ENUM&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($tab12, '&lt;xsl:variable name=&quot;ename&quot; select=&quot;@name&quot;/&gt;', $cr)"/>
		<xsl:value-of select="concat($tab12, '&lt;xsl:element name=&quot;Option&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($tab13, '&lt;xsl:attribute name=&quot;value&quot;&gt;&lt;xsl:value-of select=&quot;@id&quot;/&gt;&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($tab13, '&lt;xsl:if test=&quot;@selected=', $apos, 'True', $apos, '&quot;&gt;&lt;xsl:attribute name=&quot;SELECTED&quot;/&gt;&lt;/xsl:if&gt;', $cr)"/>
		<xsl:call-template name="XSLLabelText">
			<xsl:with-param name="label">$ename</xsl:with-param>
			<xsl:with-param name="noquote" select="true()"/>
			<xsl:with-param name="indent">13</xsl:with-param>
			<xsl:with-param name="newline" select="true()"/>
		</xsl:call-template>
		<xsl:value-of select="concat($tab12, '&lt;/xsl:element&gt;', $cr)"/>
		<xsl:value-of select="concat($tab11, '&lt;/xsl:for-each&gt;', $cr)"/>
		<xsl:value-of select="concat($tab10, '&lt;/xsl:element&gt;', $cr)"/>
		<xsl:call-template name="XSLComment">
			<xsl:with-param name="indent">10</xsl:with-param>
			<xsl:with-param name="value">END SEARCH BY</xsl:with-param>
		</xsl:call-template>
		<xsl:value-of select="$cr"/>
		<xsl:value-of select="$tab10"/>
		<xsl:call-template name="XSLDblSpace"/>
		<xsl:value-of select="$cr"/>

		<!--==========FIND TEXT==========-->
		<xsl:call-template name="XSLComment">
			<xsl:with-param name="indent">10</xsl:with-param>
			<xsl:with-param name="value">BEGIN FIND TEXT</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="XSLLabelText">
			<xsl:with-param name="label">SearchFor</xsl:with-param>
			<xsl:with-param name="islabel" select="true()"/>
			<xsl:with-param name="indent">10</xsl:with-param>
			<xsl:with-param name="newline" select="true()"/>
		</xsl:call-template>		
		<xsl:value-of select="$tab10"/>
		<xsl:call-template name="XSLDblSpace"/>
		<xsl:value-of select="concat($tab10, '&lt;xsl:element name=&quot;INPUT&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($tab11, '&lt;xsl:attribute name=&quot;type&quot;&gt;text&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($tab11, '&lt;xsl:attribute name=&quot;name&quot;&gt;SearchText&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($tab11, '&lt;xsl:attribute name=&quot;id&quot;&gt;SearchText&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($tab11, '&lt;xsl:attribute name=&quot;value&quot;&gt;&lt;xsl:value-of select=&quot;/DATA/BOOKMARK/@searchtext&quot;/&gt;&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($tab10, '&lt;/xsl:element&gt;', $cr)"/>
		<xsl:call-template name="XSLComment">
			<xsl:with-param name="indent">10</xsl:with-param>
			<xsl:with-param name="value">END FIND TEXT</xsl:with-param>
		</xsl:call-template>
		<xsl:value-of select="$cr"/>
		<xsl:value-of select="$tab10"/>
		<xsl:call-template name="XSLDblSpace"/>
		<xsl:value-of select="$cr"/>

		<!--==========GO BUTTON==========-->
		<xsl:call-template name="XSLComment">
			<xsl:with-param name="indent">10</xsl:with-param>
			<xsl:with-param name="value">BEGIN FIND BUTTON</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="XSLButton">
			<xsl:with-param name="name">Go</xsl:with-param>
			<xsl:with-param name="actioncode">5</xsl:with-param>
			<xsl:with-param name="indent">10</xsl:with-param>
		</xsl:call-template>
		<xsl:value-of select="$tab10"/>
		<xsl:call-template name="XSLDblSpace"/>
		<xsl:value-of select="$cr"/>

		<!--==========END FIND ROW==========-->
		<xsl:call-template name="XSLComment">
			<xsl:with-param name="indent">10</xsl:with-param>
			<xsl:with-param name="value">END FIND BUTTON</xsl:with-param>
		</xsl:call-template>
		<xsl:value-of select="$cr"/>
		<xsl:value-of select="concat($tab9, '&lt;/xsl:element&gt;', $cr)"/>
		<xsl:value-of select="concat($tab8, '&lt;/xsl:element&gt;', $cr)"/>
		<xsl:call-template name="XSLComment">
			<xsl:with-param name="indent">8</xsl:with-param>
			<xsl:with-param name="value">END FIND ROW</xsl:with-param>
		</xsl:call-template>
		<xsl:value-of select="$cr"/>

		<!--==========DIVIDER==========-->
		<xsl:value-of select="concat($tab8, '&lt;xsl:element name=&quot;TR&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($tab9, '&lt;xsl:element name=&quot;TD&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($tab10, '&lt;xsl:attribute name=&quot;height&quot;&gt;6&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($tab9, '&lt;/xsl:element&gt;', $cr)"/>
		<xsl:value-of select="concat($tab8, '&lt;/xsl:element&gt;', $cr, $cr)"/>

		<!--==========BEGIN RECORDSET ==========-->
		<xsl:for-each select="/Data/WTENTITY/WTWEBPAGE/WTDATAROW">
			<xsl:call-template name="XSLDataRow">
				<xsl:with-param name="indent">8</xsl:with-param>
				<xsl:with-param name="width">600</xsl:with-param>
				<xsl:with-param name="srcpage">Find</xsl:with-param>
			</xsl:call-template>
		</xsl:for-each>
		
		<xsl:call-template name="XSLBlankLine">
			<xsl:with-param name="height">2</xsl:with-param>
			<xsl:with-param name="indent">8</xsl:with-param>
		</xsl:call-template>

		<!--==========PREVIOUS/NEXT==========-->
		<xsl:call-template name="XSLComment">
			<xsl:with-param name="indent">8</xsl:with-param>
			<xsl:with-param name="value">PREVIOUS/NEXT LINE</xsl:with-param>
		</xsl:call-template>

		<xsl:value-of select="concat($tab8, '&lt;xsl:element name=&quot;TR&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($tab9, '&lt;xsl:element name=&quot;TD&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($tab10, '&lt;xsl:element name=&quot;TABLE&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($tab11, '&lt;xsl:attribute name=&quot;border&quot;&gt;0&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($tab11, '&lt;xsl:attribute name=&quot;cellpadding&quot;&gt;0&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($tab11, '&lt;xsl:attribute name=&quot;cellspacing&quot;&gt;0&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($tab11, '&lt;xsl:attribute name=&quot;width&quot;&gt;600&lt;/xsl:attribute&gt;', $cr, $cr)"/>
		<xsl:value-of select="concat($tab11, '&lt;xsl:element name=&quot;TR&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($tab12, '&lt;xsl:element name=&quot;TD&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($tab13, '&lt;xsl:attribute name=&quot;width&quot;&gt;100&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($tab13, '&lt;xsl:attribute name=&quot;class&quot;&gt;EndList&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($tab13, '&lt;xsl:if test=&quot;/DATA/BOOKMARK/@next=', $apos, 'False', $apos, '&quot;&gt;', $cr)"/>
		<xsl:call-template name="XSLLabelText">
			<xsl:with-param name="label">EndOfList</xsl:with-param>
			<xsl:with-param name="indent">14</xsl:with-param>
			<xsl:with-param name="newline" select="true()"/>
		</xsl:call-template>
		<xsl:value-of select="concat($tab13, '&lt;/xsl:if&gt;', $cr)"/>
		<xsl:value-of select="concat($tab12, '&lt;/xsl:element&gt;', $cr)"/>
		<xsl:value-of select="concat($tab12, '&lt;xsl:element name=&quot;TD&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($tab13, '&lt;xsl:attribute name=&quot;width&quot;&gt;500&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($tab13, '&lt;xsl:attribute name=&quot;align&quot;&gt;right&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($tab13, '&lt;xsl:call-template name=&quot;PreviousNext&quot;/&gt;', $cr)"/>
		<xsl:value-of select="concat($tab12, '&lt;/xsl:element&gt;', $cr)"/>
		<xsl:value-of select="concat($tab11, '&lt;/xsl:element&gt;', $cr, $cr)"/>
		<xsl:value-of select="concat($tab10, '&lt;/xsl:element&gt;', $cr)"/>
		<xsl:value-of select="concat($tab9, '&lt;/xsl:element&gt;', $cr, $cr)"/>
		<xsl:value-of select="concat($tab8, '&lt;/xsl:element&gt;', $cr, $cr)"/>

		<xsl:call-template name="XSLBlankLine">
			<xsl:with-param name="height">4</xsl:with-param>
			<xsl:with-param name="indent">8</xsl:with-param>
		</xsl:call-template>

		<!--==========END CONTENT==========-->
		<xsl:call-template name="XSLContentEnd"/>

		<!--==========PAGE FOOTER==========-->
		<xsl:call-template name="XSLFooterRow"/>

		<!--==========END FORM==========-->
		<xsl:call-template name="XSLFormEnd"/>

		<!--==========END PAGE==========-->
		<xsl:call-template name="XSLPageEnd"/>
		<xsl:value-of select="concat($tab1, '&lt;/xsl:template&gt;', $cr)"/>
		<xsl:value-of select="concat($tab0, '&lt;/xsl:stylesheet&gt;', $cr, $cr)"/>
	</xsl:template>

</xsl:stylesheet>
