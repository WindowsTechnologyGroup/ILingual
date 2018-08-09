<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<!--==================================================================-->
	<!-- TEMPLATE: START SHELL -->
	<!-- start the outer shell for a contained body  -->
	<!--==================================================================-->
	<xsl:template name="XSLStartShell">
		<xsl:param name="body">

		<!--====================INCLUDES====================-->

		<xsl:value-of select="concat('&lt;xsl:stylesheet version=&quot;1.0&quot; xmlns:xsl=&quot;http://www.w3.org/1999/XSL/Transform&quot; xmlns:msxsl=&quot;urn:schemas-microsoft-com:xslt&quot;&gt;', $cr)"/>

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

		<xsl:value-of select="concat($tab2, '&lt;xsl:variable name=&quot;usergroup&quot; select=&quot;/DATA/SYSTEM/@usergroup&quot;/&gt;', $cr, $cr)"/>

		<!--==========BEGIN PAGE==========-->
		<xsl:call-template name="XSLPageBegin">
			<xsl:with-param name="name" select="$body"/>
		</xsl:call-template>

		<!--==========BEGIN FORM==========-->
		<xsl:call-template name="XSLFormBegin">
			<xsl:with-param name="name" select="$body"/>
		</xsl:call-template>

		<xsl:call-template name="XSLHiddenInput">
			<xsl:with-param name="name">ActionCode</xsl:with-param>
			<xsl:with-param name="indent">5</xsl:with-param>
		</xsl:call-template>

		<!--==========BEGIN PAGE LAYOUT ROW==========-->
		<xsl:call-template name="XSLPageRow"/>

		<!--==========PAGE HEADER==========-->
		<xsl:call-template name="XSLHeaderRow"/>

		<!--==========BEGIN CONTENT==========-->
		<xsl:call-template name="XSLContentBegin"/>

	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: END SHELL -->
	<!-- end the outer shell for a contained body  -->
	<!--==================================================================-->
	<xsl:template name="XSLEndShell">
		<xsl:param name="body">

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

