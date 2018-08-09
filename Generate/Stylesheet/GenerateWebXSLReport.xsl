<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:include href="GenerateIncludeXSL.xsl"/>
<!--=====================================================================
	Auth:   Bob Wood
	Date:   August 2002
	Desc:   Generates the Report Page stylesheet from the entity definition 
	Copyright 2002 WinTech, Inc.
======================================================================-->

	 <xsl:template match="/">
		  <WEB><xsl:apply-templates/></WEB>
	 </xsl:template>

	 <xsl:template match="WTENTITY">
		  <xsl:value-of select="concat($tab0, '&lt;xsl:stylesheet version=&quot;1.0&quot; xmlns:xsl=&quot;http://www.w3.org/1999/XSL/Transform&quot; xmlns:msxsl=&quot;urn:schemas-microsoft-com:xslt&quot;&gt;', $cr)"/>

		<xsl:variable name="pagename">
			<xsl:choose>
				<xsl:when test="contains(/Data/WTENTITY/WTWEBPAGE/@caption,' ')">'<xsl:value-of select="/Data/WTENTITY/WTWEBPAGE/@caption"/>'</xsl:when>
				<xsl:when test="/Data/WTENTITY/WTWEBPAGE/@caption">/DATA/LANGUAGE/LABEL[@name='<xsl:value-of select="/Data/WTENTITY/WTWEBPAGE/@caption"/>']</xsl:when>
				<xsl:otherwise>'<xsl:value-of select="$entityname"/>'</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="formname">
			<xsl:choose>
				<xsl:when test="/Data/WTENTITY/WTWEBPAGE/@form"><xsl:value-of select="/Data/WTENTITY/WTWEBPAGE/@form"/></xsl:when>
				<xsl:otherwise><xsl:value-of select="$entityname"/></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		  <xsl:variable name="ReportHeader">
		    <xsl:choose>
	 	     	<xsl:when test="/Data/WTENTITY/WTWEBPAGE/@header='false'"/>
	 	     	<xsl:when test="/Data/WTENTITY/WTWEBPAGE/@header"><xsl:value-of select="/Data/WTENTITY/WTWEBPAGE/@header"/></xsl:when>
	 	     	<xsl:otherwise>ReportHeader</xsl:otherwise>
		    </xsl:choose>
		  </xsl:variable>
		  <xsl:variable name="ReportFooter">
		    <xsl:choose>
	 	     	<xsl:when test="/Data/WTENTITY/WTWEBPAGE/@footer='false'"/>
	 	     	<xsl:when test="/Data/WTENTITY/WTWEBPAGE/@footer"><xsl:value-of select="/Data/WTENTITY/WTWEBPAGE/@footer"/></xsl:when>
	 	     	<xsl:otherwise>ReportFooter</xsl:otherwise>
		    </xsl:choose>
		  </xsl:variable>

		  <!--====================INCLUDES====================-->
		<xsl:call-template name="XSLInclude">
	 		  <xsl:with-param name="filename">HTMLHeading</xsl:with-param>
		</xsl:call-template>

		<xsl:if test="/Data/WTENTITY/WTWEBPAGE/@css">
			<xsl:call-template name="XSLInclude">
				<xsl:with-param name="filename" select="/Data/WTENTITY/WTWEBPAGE/@css"/>
			</xsl:call-template>
		</xsl:if>

		  <xsl:if test="string-length($ReportHeader)&gt;0">
				<xsl:call-template name="XSLInclude">
	 				 <xsl:with-param name="filename" select="$ReportHeader"/>
				</xsl:call-template>
		  </xsl:if>
		  <xsl:if test="string-length($ReportFooter)&gt;0">
				<xsl:call-template name="XSLInclude">
					 <xsl:with-param name="filename" select="$ReportFooter"/>
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
			<xsl:with-param name="includecalendar" select="true()"/>
		  	<xsl:with-param name="pagewidth" select="$pagewidth"/>
			<xsl:with-param name="content" select="/Data/WTENTITY/WTWEBPAGE/WTCONTENT"/>
		  </xsl:call-template>

		<!--==========BEGIN FORM==========-->
		<xsl:call-template name="XSLFormBegin">
			<xsl:with-param name="name" select="$formname"/>
			<xsl:with-param name="content" select="/Data/WTENTITY/WTWEBPAGE/WTCONTENT"/>
			<xsl:with-param name="submit" select="/Data/WTENTITY/WTWEBPAGE/@submit"/>
			<xsl:with-param name="type" select="/Data/WTENTITY/WTWEBPAGE/@type"/>
		</xsl:call-template>

		<xsl:if test="not(/Data/WTENTITY/WTWEBPAGE/@action='false')">
			<xsl:call-template name="XSLHiddenInput">
				<xsl:with-param name="name">ActionCode</xsl:with-param>
				<xsl:with-param name="indent">5</xsl:with-param>
				<xsl:with-param name="value" select="/Data/WTENTITY/WTWEBPAGE/@action"/>
			</xsl:call-template>
		</xsl:if>


		<xsl:if test="/Data/WTENTITY/WTWEBPAGE/@contentpage='true'">
			<xsl:call-template name="XSLHiddenInput">
				<xsl:with-param name="name">ContentPage</xsl:with-param>
				<xsl:with-param name="indent">5</xsl:with-param>
				<xsl:with-param name="value" select="'/DATA/PARAM/@contentpage'"/>
			</xsl:call-template>
		</xsl:if>

		  <!--==========PAGE HEADER==========-->
		  <xsl:if test="string-length($ReportHeader)&gt;0">
				<xsl:call-template name="XSLHeaderRow">
					 <xsl:with-param name="name" select="$ReportHeader"/>
					 <xsl:with-param name="indent">4</xsl:with-param>
					 <xsl:with-param name="colspan" select="$colcount"/>
				</xsl:call-template>
		  </xsl:if>

		  <!--==========BEGIN BODY==========-->
		  <xsl:apply-templates select="/Data/WTENTITY/WTWEBPAGE/WTCONTENT" mode="report">
		  	<xsl:with-param name="indent">4</xsl:with-param>
		  </xsl:apply-templates>

		  <!--==========PAGE FOOTER==========-->
		  <xsl:if test="string-length($ReportFooter)&gt;0">
				<xsl:call-template name="XSLFooterRow">
					 <xsl:with-param name="name" select="$ReportFooter"/>
					 <xsl:with-param name="indent">4</xsl:with-param>
					 <xsl:with-param name="colspan" select="$colcount"/>
				</xsl:call-template>
		  </xsl:if>

		<!--==========END FORM==========-->
		<xsl:call-template name="XSLFormEnd"/>

		  <!--==========END PAGE==========-->
		  <xsl:call-template name="XSLPageEnd"/>

		  <xsl:value-of select="concat($tab1, '&lt;/xsl:template&gt;', $cr)"/>
		  <xsl:value-of select="concat($tab0, '&lt;/xsl:stylesheet&gt;', $cr, $cr)"/>

	 </xsl:template>

</xsl:stylesheet>
