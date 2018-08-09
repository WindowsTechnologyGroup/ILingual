<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:include href="GenerateIncludeXSL.xsl"/>
<!--=====================================================================
	Auth:   Bob Wood
	Date:   October 2002
	Desc:   Generates the Email Body Stylesheet from the entity definition 
	Copyright 2002 WinTech, Inc.
======================================================================-->

	 <xsl:template match="/">
		  <WEB><xsl:apply-templates/></WEB>
	 </xsl:template>

	 <xsl:template match="WTENTITY">
		  <xsl:value-of select="concat($tab0, '&lt;xsl:stylesheet version=&quot;1.0&quot; xmlns:xsl=&quot;http://www.w3.org/1999/XSL/Transform&quot; xmlns:msxsl=&quot;urn:schemas-microsoft-com:xslt&quot;&gt;', $cr)"/>

 		<!-- ***************** Error Checking ************************************************-->
<!-- This is no longer required (email can be sent in the background with an HTTP object) -->
<!--
		<xsl:if test="not(WTWEBPAGE/WTPARAM[@name='MailReturnURL'])">
		    <xsl:call-template name="Error">
		    	<xsl:with-param name="msg" select="'Mail Page Missing MailReturnURL Parameter'"/>
		    	<xsl:with-param name="text" select="/Data/WTENTITY/WTWEBPAGE/@name"/>
		    </xsl:call-template>
		</xsl:if>
-->
		<!-- *********************************************************************************-->

		<xsl:variable name="pagename">
			<xsl:choose>
				<xsl:when test="/Data/WTENTITY/WTWEBPAGE/@caption">/DATA/LANGUAGE/LABEL[@name='<xsl:value-of select="/Data/WTENTITY/WTWEBPAGE/@caption"/>']</xsl:when>
				<xsl:otherwise>'<xsl:value-of select="$entityname"/>'</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		  <!--====================INCLUDES====================-->
		  <xsl:call-template name="XSLInclude">
	 		  <xsl:with-param name="filename">HTMLEmail</xsl:with-param>
		  </xsl:call-template>

		<xsl:if test="/Data/WTENTITY/WTWEBPAGE/@css">
			<xsl:call-template name="XSLInclude">
				<xsl:with-param name="filename" select="/Data/WTENTITY/WTWEBPAGE/@css"/>
			</xsl:call-template>
		</xsl:if>

		  <xsl:value-of select="concat($tab1, '&lt;xsl:output omit-xml-declaration=&quot;yes&quot;/&gt;', $cr, $cr)"/>
		  <xsl:value-of select="concat($tab1, '&lt;xsl:template match=&quot;/&quot;&gt;', $cr, $cr)"/>

	  		<xsl:variable name="pagewidth">
	  			<xsl:choose>
	  				<xsl:when test="/Data/WTENTITY/WTWEBPAGE/@page-width"><xsl:value-of select="/Data/WTENTITY/WTWEBPAGE/@page-width"/></xsl:when>
	  				<xsl:otherwise><xsl:value-of select="sum(/Data/WTENTITY/WTWEBPAGE/WTCONTENT/WTCOLUMN/@width)"/></xsl:otherwise>
	  			</xsl:choose>
	  		</xsl:variable>

		  	<xsl:variable name="colcount" select="count(/Data/WTENTITY/WTWEBPAGE/WTCONTENT/WTCOLUMN/@width)"/>

		  <!--==========BEGIN PAGE==========-->
		  <xsl:call-template name="XSLPageBegin">
		  	<xsl:with-param name="name" select="$pagename"/>
		  	<xsl:with-param name="pagewidth" select="$pagewidth"/>
			<xsl:with-param name="content" select="/Data/WTENTITY/WTWEBPAGE/WTCONTENT"/>
			<xsl:with-param name="errorhandling" select="false()"/>
			<xsl:with-param name="email" select="true()"/>
		  </xsl:call-template>

		  <!--==========BEGIN BODY==========-->
		  <xsl:apply-templates select="/Data/WTENTITY/WTWEBPAGE/WTCONTENT" mode="report">
		  	<xsl:with-param name="indent">4</xsl:with-param>
		  </xsl:apply-templates>

		  <!--==========END PAGE==========-->
		  <xsl:call-template name="XSLPageEnd"/>

		  <xsl:value-of select="concat($tab1, '&lt;/xsl:template&gt;', $cr)"/>
		  <xsl:value-of select="concat($tab0, '&lt;/xsl:stylesheet&gt;', $cr, $cr)"/>

	 </xsl:template>

</xsl:stylesheet>
