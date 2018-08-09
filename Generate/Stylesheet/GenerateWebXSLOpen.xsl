<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:include href="GenerateIncludeXSL.xsl"/>
<!--=====================================================================
	Auth:   Bob Wood
	Date:   March 2006
	Desc:   Generates the Open Page stylesheet from the entity definition 
	Copyright 2006 WinTech, Inc.
======================================================================-->

	<xsl:template match="/">
		<WEB><xsl:apply-templates/></WEB>
	</xsl:template>

	<xsl:template match="WTENTITY">
		<xsl:call-template name="LayoutOpen"/>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: LAYOUT OPEN -->
	<!-- lays out a complete form for an open page -->
	<!--==================================================================-->
	<xsl:template name="LayoutOpen">

		<!--====================VARIABLES====================-->

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

		<!--====================INCLUDES====================-->
		<xsl:value-of select="concat('&lt;xsl:stylesheet version=&quot;1.0&quot; xmlns:xsl=&quot;http://www.w3.org/1999/XSL/Transform&quot; xmlns:msxsl=&quot;urn:schemas-microsoft-com:xslt&quot;&gt;', $cr)"/>

    <!-- If we have input options, include the InputOptions file -->
    <xsl:if test="/Data/WTENTITY/WTWEBPAGE/descendant::*[name()='WTINPUTOPTIONS']">
      <xsl:call-template name="XSLInclude">
        <xsl:with-param name="filename">InputOptions</xsl:with-param>
      </xsl:call-template>
    </xsl:if>

    <!-- If we have custom fields, include the CustomFields file -->
    <xsl:if test="/Data/WTENTITY/WTWEBPAGE/descendant::*[name()='WTCUSTOMFIELDS']">
      <xsl:call-template name="XSLInclude">
        <xsl:with-param name="filename">CustomFields</xsl:with-param>
      </xsl:call-template>
    </xsl:if>

    <!-- If we have input options, include the InputOptions file -->
		<xsl:if test="/Data/WTENTITY/WTWEBPAGE/descendant::*[name()='WTCUSTOMREPORT']">
			<xsl:call-template name="XSLInclude">
				<xsl:with-param name="filename">CustomReport</xsl:with-param>
			</xsl:call-template>
		</xsl:if>
		
		<xsl:value-of select="concat($tab1, '&lt;xsl:output omit-xml-declaration=&quot;yes&quot;/&gt;', $cr, $cr)"/>

		<!--==========HEADER==========-->
		<xsl:value-of select="concat($tab1, '&lt;xsl:template match=&quot;/&quot;&gt;', $cr, $cr)"/>

		<xsl:if test="/Data/WTENTITY/WTWEBPAGE/@top">
			<xsl:value-of select="concat($tab2, '&lt;xsl:value-of select=&quot;', /Data/WTENTITY/WTWEBPAGE/@top, '&quot; disable-output-escaping=&quot;yes&quot;/&gt;', $cr, $cr)"/>
		</xsl:if>

		<xsl:if test="/Data/WTENTITY/WTWEBPAGE/@stylesheet">
			<xsl:value-of select="concat($tab2, '&lt;xsl:element name=&quot;link&quot;&gt;', $cr)"/>
			<xsl:value-of select="concat($tab3, '&lt;xsl:attribute name=&quot;rel&quot;&gt;stylesheet&lt;/xsl:attribute&gt;', $cr)"/>
			<xsl:value-of select="concat($tab3, '&lt;xsl:attribute name=&quot;type&quot;&gt;text/css&lt;/xsl:attribute&gt;', $cr)"/>
			<xsl:value-of select="concat($tab3, '&lt;xsl:attribute name=&quot;href&quot;&gt;include/', /Data/WTENTITY/WTWEBPAGE/@stylesheet, '&lt;/xsl:attribute&gt;', $cr)"/>
			<xsl:value-of select="concat($tab2, '&lt;/xsl:element&gt;', $cr, $cr)"/>
		</xsl:if>

		<xsl:if test="/Data/WTENTITY/WTWEBPAGE/@calendar">
			<xsl:value-of select="concat($tab2, '&lt;xsl:element name=&quot;SCRIPT&quot;&gt;', $cr)"/>
			<xsl:value-of select="concat($tab3, '&lt;xsl:attribute name=&quot;language&quot;&gt;JavaScript&lt;/xsl:attribute&gt;', $cr)"/>
			<xsl:value-of select="concat($tab3, '&lt;xsl:attribute name=&quot;src&quot;&gt;Include/wtcalendar.js&lt;/xsl:attribute&gt;', $cr)"/>
			<xsl:value-of select="concat($tab3, '&lt;xsl:text&gt; &lt;/xsl:text&gt;', $cr)"/>
			<xsl:value-of select="concat($tab2, '&lt;/xsl:element&gt;', $cr, $cr)"/>
		</xsl:if>

<!--
		<xsl:call-template name="XSLComment">
			<xsl:with-param name="indent">2</xsl:with-param>
			<xsl:with-param name="value">BEGIN HEAD</xsl:with-param>
		</xsl:call-template>
		<xsl:value-of select="concat($tab2, '&lt;xsl:element name=&quot;HEAD&quot;&gt;', $cr)"/>
-->
<!--
		<xsl:value-of select="concat($tab3, '&lt;xsl:if test=&quot;/DATA/HEAD/@css&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($tab4, '&lt;xsl:element name=&quot;LINK&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($tab5, '&lt;xsl:attribute name=&quot;href&quot;&gt;&lt;xsl:value-of select=&quot;/DATA/HEAD/@css&quot;/&gt;&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($tab5, '&lt;xsl:attribute name=&quot;rel&quot;&gt;stylesheet&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($tab5, '&lt;xsl:attribute name=&quot;type&quot;&gt;text/css&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($tab4, '&lt;/xsl:element&gt;', $cr)"/>
		<xsl:value-of select="concat($tab3, '&lt;/xsl:if&gt;', $cr, $cr)"/>

		<xsl:value-of select="concat($tab3, '&lt;xsl:if test=&quot;/DATA/HEAD/@title&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($tab4, '&lt;xsl:element name=&quot;TITLE&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($tab5, '&lt;xsl:value-of select=&quot;/DATA/HEAD/@title&quot;/&gt;', $cr)"/>
		<xsl:value-of select="concat($tab4, '&lt;/xsl:element&gt;', $cr)"/>
		<xsl:value-of select="concat($tab3, '&lt;/xsl:if&gt;', $cr, $cr)"/>

		<xsl:value-of select="concat($tab3, '&lt;xsl:if test=&quot;/DATA/HEAD/@description&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($tab4, '&lt;xsl:element name=&quot;meta&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($tab5, '&lt;xsl:attribute name=&quot;name&quot;&gt;description&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($tab5, '&lt;xsl:attribute name=&quot;content&quot;&gt;&lt;xsl:value-of select=&quot;/DATA/HEAD/@description&quot;/&gt;&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($tab4, '&lt;/xsl:element&gt;', $cr)"/>
		<xsl:value-of select="concat($tab3, '&lt;/xsl:if&gt;', $cr, $cr)"/>
-->
<!--
		<xsl:value-of select="concat($tab3, '&lt;xsl:if test=&quot;/DATA/HEAD/@content&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($tab4, '&lt;xsl:element name=&quot;meta&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($tab5, '&lt;xsl:attribute name=&quot;name&quot;&gt;content&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($tab5, '&lt;xsl:attribute name=&quot;content&quot;&gt;&lt;xsl:value-of select=&quot;/DATA/HEAD/@content&quot;/&gt;&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($tab4, '&lt;/xsl:element&gt;', $cr)"/>
		<xsl:value-of select="concat($tab3, '&lt;/xsl:if&gt;', $cr, $cr)"/>
-->
<!--
		<xsl:value-of select="concat($tab3, '&lt;xsl:if test=&quot;/DATA/HEAD/@keywords&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($tab4, '&lt;xsl:element name=&quot;meta&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($tab5, '&lt;xsl:attribute name=&quot;name&quot;&gt;keywords&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($tab5, '&lt;xsl:attribute name=&quot;content&quot;&gt;&lt;xsl:value-of select=&quot;/DATA/HEAD/@keywords&quot;/&gt;&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($tab4, '&lt;/xsl:element&gt;', $cr)"/>
		<xsl:value-of select="concat($tab3, '&lt;/xsl:if&gt;', $cr, $cr)"/>

		<xsl:value-of select="concat($tab3, '&lt;xsl:if test=&quot;/DATA/HEAD/@robots&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($tab4, '&lt;xsl:element name=&quot;meta&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($tab5, '&lt;xsl:attribute name=&quot;name&quot;&gt;robots&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($tab5, '&lt;xsl:attribute name=&quot;content&quot;&gt;&lt;xsl:value-of select=&quot;/DATA/HEAD/@robots&quot;/&gt;&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($tab4, '&lt;/xsl:element&gt;', $cr)"/>
		<xsl:value-of select="concat($tab3, '&lt;/xsl:if&gt;', $cr, $cr)"/>
-->
<!--
		<xsl:value-of select="concat($tab2, '&lt;/xsl:element&gt;', $cr, $cr)"/>
-->
		<!--==========BEGIN PAGE==========-->

		<xsl:if test="/Data/WTENTITY/WTWEBPAGE/@body">
			<xsl:call-template name="XSLComment">
				<xsl:with-param name="indent">2</xsl:with-param>
				<xsl:with-param name="value">BEGIN BODY</xsl:with-param>
			</xsl:call-template>

			<xsl:variable name="topmargin">
				<xsl:choose>
					<xsl:when test="/Data/WTENTITY/WTWEBPAGE/@page-top"><xsl:value-of select="/Data/WTENTITY/WTWEBPAGE/@page-top"/></xsl:when>
					<xsl:otherwise>0</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			<xsl:variable name="leftmargin">
				<xsl:choose>
					<xsl:when test="/Data/WTENTITY/WTWEBPAGE/@page-left"><xsl:value-of select="/Data/WTENTITY/WTWEBPAGE/@page-left"/></xsl:when>
					<xsl:otherwise>0</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>

			<xsl:value-of select="concat($tab2, '&lt;xsl:element name=&quot;BODY&quot;&gt;', $cr)"/>
<!--
			<xsl:value-of select="concat($tab3, '&lt;xsl:attribute name=&quot;topmargin&quot;&gt;0&lt;/xsl:attribute&gt;', $cr)"/>
			<xsl:value-of select="concat($tab3, '&lt;xsl:attribute name=&quot;leftmargin&quot;&gt;0&lt;/xsl:attribute&gt;', $cr, $cr)"/>
-->
			<xsl:value-of select="concat($tab3, '&lt;xsl:attribute name=&quot;topmargin&quot;&gt;', $topmargin, '&lt;/xsl:attribute&gt;', $cr)"/>
			<xsl:value-of select="concat($tab3, '&lt;xsl:attribute name=&quot;leftmargin&quot;&gt;', $leftmargin, '&lt;/xsl:attribute&gt;', $cr, $cr)"/>
		</xsl:if>

		<!--==========ERROR HANDLING==========-->
		<xsl:if test="/Data/WTENTITY/WTWEBPAGE/@error">
			<xsl:call-template name="ErrorHandler">
				<xsl:with-param name="content" select="/Data/WTENTITY/WTWEBPAGE/WTCONTENT"/>
			</xsl:call-template>
		</xsl:if>

		<!--==========BEGIN FORM==========-->
		<xsl:if test="not(/Data/WTENTITY/WTWEBPAGE/@form='false')">
			<xsl:call-template name="XSLFormBegin">
				<xsl:with-param name="name" select="$formname"/>
			</xsl:call-template>
		</xsl:if>

		<!--==========BEGIN CONTENT=======================-->
		<xsl:apply-templates select="/Data/WTENTITY/WTWEBPAGE/WTCONTENT/WTCODEGROUP">
			<xsl:with-param name="indent">4</xsl:with-param>
		</xsl:apply-templates>


		<xsl:if test="not(/Data/WTENTITY/WTWEBPAGE/@form='false')">
			<xsl:call-template name="XSLHiddenInput">
				<xsl:with-param name="name">ActionCode</xsl:with-param>
				<xsl:with-param name="indent">5</xsl:with-param>
			</xsl:call-template>
		</xsl:if>

		<!--==========END FORM==========-->
		<xsl:if test="not(/Data/WTENTITY/WTWEBPAGE/@form='false')">
			<xsl:call-template name="XSLFormEnd"/>
		</xsl:if>

		<xsl:if test="/Data/WTENTITY/WTWEBPAGE/@translate='google'">
			<xsl:call-template name="DoTranslate"/>
		</xsl:if>

		<!--==========END PAGE==========-->
		<xsl:if test="/Data/WTENTITY/WTWEBPAGE/@body">
			<xsl:value-of select="concat($tab2, '&lt;/xsl:element&gt;', $cr)"/>
			<xsl:call-template name="XSLComment">
				<xsl:with-param name="indent">2</xsl:with-param>
				<xsl:with-param name="value">END BODY</xsl:with-param>
			</xsl:call-template>
			<xsl:value-of select="$cr"/>
		</xsl:if>

		<xsl:if test="not(/Data/WTENTITY/WTWEBPAGE/@form='false')">
			<xsl:value-of select="concat($tab2, '&lt;xsl:element name=&quot;SCRIPT&quot;&gt;', $cr)"/>
			<xsl:value-of select="concat($tab3, '&lt;xsl:attribute name=&quot;language&quot;&gt;JavaScript&lt;/xsl:attribute&gt;', $cr)"/>
			<xsl:value-of select="concat($tab3, '&lt;![CDATA[function doSubmit(iAction, sMsg){document.', $formname, '.elements[', $apos, 'ActionCode', $apos, '].value=iAction;document.', $formname, '.submit();}]]&gt;', $cr)"/>
			<xsl:value-of select="concat($tab3, '&lt;![CDATA[function doErrorMsg(sError){alert(sError);}]]&gt;', $cr)"/>
			<xsl:if test="/Data/WTENTITY/WTWEBPAGE/@calendar">
				<xsl:value-of select="concat($tab3, '&lt;![CDATA[function CalendarPopup(frm, fld) {  displayDatePicker(fld.name, fld);}]]&gt;', $cr)"/>
			</xsl:if>
			<xsl:value-of select="concat($tab2, '&lt;/xsl:element&gt;', $cr, $cr)"/>
		</xsl:if>

		<xsl:if test="(/Data/WTPAGE/@translate or /Data/WTENTITY/WTWEBPAGE/@translate) and not(/Data/WTENTITY/WTWEBPAGE/@translate='false')">
			<xsl:call-template name="DoTranslate"/>
		</xsl:if>

		<xsl:value-of select="concat($tab1, '&lt;/xsl:template&gt;', $cr)"/>

		<xsl:value-of select="concat($tab0, '&lt;/xsl:stylesheet&gt;', $cr, $cr)"/>
	</xsl:template>

</xsl:stylesheet>

