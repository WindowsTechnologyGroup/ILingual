<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<!--==================================================================-->
	<!-- TEMPLATE: LAYOUT FORM -->
	<!-- lays out a complete form for an Add or Update page -->
	<!--==================================================================-->
	<xsl:template name="LayoutForm">
		<xsl:param name="formtype" select="item"/>

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
		<xsl:variable name="NavBar">
			<xsl:choose>
				<xsl:when test="/Data/WTENTITY/WTWEBPAGE/@navbar='false'"/>
				<xsl:when test="/Data/WTENTITY/WTWEBPAGE/@navbar='true'">NavBar</xsl:when>
				<xsl:when test="/Data/WTENTITY/WTWEBPAGE/@navbar"><xsl:value-of select="/Data/WTENTITY/WTWEBPAGE/@navbar"/></xsl:when>
				<xsl:when test="/Data/WTPAGE/@navbar='false'"/>
				<xsl:when test="/Data/WTPAGE/@navbar"><xsl:value-of select="/Data/WTPAGE/@navbar"/></xsl:when>
				<xsl:otherwise>NavBar</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="MenuBar">
			<xsl:choose>
				<xsl:when test="$NavBar=''"/>
				<xsl:when test="/Data/WTENTITY/WTWEBPAGE/@worker='true'"/>
				<xsl:when test="/Data/WTENTITY/WTWEBPAGE/@type='mail'"/>
				<xsl:when test="/Data/WTPAGE/@menubar"><xsl:value-of select="/Data/WTPAGE/@menubar"/></xsl:when>
				<xsl:otherwise/>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="IsMenu">
			<xsl:choose>
				<xsl:when test="$MenuBar!=''">true</xsl:when>
				<xsl:when test="count(/Data/WTENTITY/WTWEBPAGE/WTCONTENT/WTMENU[@type='xpbar'])&gt;0">true</xsl:when>
				<xsl:when test="count(/Data/WTENTITY/WTWEBPAGE/WTCONTENT/WTMENU[@type='bar'])&gt;0">true</xsl:when>
				<xsl:otherwise>false</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="IsMenuTree">
			<xsl:choose>
				<xsl:when test="count(/Data/WTENTITY/WTWEBPAGE/WTCONTENT/WTMENU[@type='tree'])&gt;0">true</xsl:when>
				<xsl:otherwise>false</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="IsTab">
			<xsl:choose>
				<xsl:when test="count(/Data/WTENTITY/WTWEBPAGE/WTCONTENT/WTTAB)&gt;0">true</xsl:when>
				<xsl:otherwise>false</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="IsTree2">
			<xsl:choose>
				<xsl:when test="count(/Data/WTENTITY/WTWEBPAGE/WTCONTENT/descendant::*[name()='WTTREE2'])&gt;0">true</xsl:when>
					<xsl:otherwise>false</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="NavBarName">
			<xsl:value-of select="$NavBar"/>
<!--
			<xsl:choose>
				<xsl:when test="/Data/WTPAGE/@navbar='userclass'">
					<xsl:value-of select="'&lt;xsl:value-of select=&quot;substring(/DATA/SYSTEM/@usergroup,1,1)&quot;/&gt;'"/>
				</xsl:when>
				<xsl:when test="/Data/WTPAGE/@navbar='usergroup'">
					<xsl:value-of select="'&lt;xsl:value-of select=&quot;/DATA/SYSTEM/@usergroup&quot;/&gt;'"/>
				</xsl:when>
			</xsl:choose>
-->
		</xsl:variable>
		<xsl:variable name="margin">
			<xsl:choose>
				<xsl:when test="/Data/WTENTITY/WTWEBPAGE/@margin='true'">true</xsl:when>
				<xsl:when test="/Data/WTENTITY/WTWEBPAGE/@margin='false'">false</xsl:when>
				<xsl:when test="/Data/WTPAGE/@margin='false'">false</xsl:when>
				<xsl:otherwise>true</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="colcount">
			<xsl:choose>
				<xsl:when test="$NavBar='' and $margin='false'">1</xsl:when>
				<xsl:when test="$NavBar=''">2</xsl:when>
				<xsl:when test="$margin='false'">2</xsl:when>
				<xsl:otherwise>3</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="PageHeader">
			<xsl:choose>
				<xsl:when test="/Data/WTENTITY/WTWEBPAGE/@header='false'"/>
				<xsl:when test="/Data/WTENTITY/WTWEBPAGE/@header"><xsl:value-of select="/Data/WTENTITY/WTWEBPAGE/@header"/></xsl:when>
				<xsl:otherwise>PageHeader</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="PageFooter">
			<xsl:choose>
				<xsl:when test="/Data/WTENTITY/WTWEBPAGE/@footer='false'"/>
				<xsl:when test="/Data/WTENTITY/WTWEBPAGE/@footer"><xsl:value-of select="/Data/WTENTITY/WTWEBPAGE/@footer"/></xsl:when>
				<xsl:otherwise>PageFooter</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="pagewidth">
			<xsl:choose>
				<xsl:when test="/Data/WTENTITY/WTWEBPAGE/@page-width"><xsl:value-of select="/Data/WTENTITY/WTWEBPAGE/@page-width"/></xsl:when>
				<xsl:when test="/Data/WTPAGE/@page-width"><xsl:value-of select="/Data/WTPAGE/@page-width"/></xsl:when>
				<xsl:otherwise>750</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="includecalendar">
			<xsl:choose>
				<xsl:when test="$formtype='list'">
					<xsl:if test="not(/Data/WTENTITY/WTWEBPAGE/@includecalendar)">false()</xsl:if>
				</xsl:when>
				<xsl:otherwise>true()</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="includehtmleditor" select="/Data/WTENTITY/WTWEBPAGE/WTCONTENT/descendant::*[@htmleditor]"/>
		<xsl:variable name="htmleditor">
			<xsl:choose>
				<xsl:when test="$includehtmleditor/@htmleditor='true'">editor</xsl:when>
				<xsl:otherwise><xsl:value-of select="$includehtmleditor/@htmleditor"/></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<!--====================INCLUDES====================-->
		<xsl:value-of select="concat('&lt;xsl:stylesheet version=&quot;1.0&quot; xmlns:xsl=&quot;http://www.w3.org/1999/XSL/Transform&quot; xmlns:msxsl=&quot;urn:schemas-microsoft-com:xslt&quot;&gt;', $cr)"/>

		<xsl:if test="/Data/WTENTITY/WTWEBPAGE/@heading">
			<xsl:call-template name="XSLInclude">
				<xsl:with-param name="filename" select="/Data/WTENTITY/WTWEBPAGE/@heading"/>
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="not(/Data/WTENTITY/WTWEBPAGE/@heading)">
			<xsl:call-template name="XSLInclude">
				<xsl:with-param name="filename">HTMLHeading</xsl:with-param>
			</xsl:call-template>
		</xsl:if>

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

    <!-- If we have custom report, include the CustomReport file -->
		<xsl:if test="/Data/WTENTITY/WTWEBPAGE/descendant::*[name()='WTCUSTOMREPORT']">
			<xsl:call-template name="XSLInclude">
				<xsl:with-param name="filename">CustomReport</xsl:with-param>
			</xsl:call-template>
		</xsl:if>

		<xsl:if test="/Data/WTENTITY/WTWEBPAGE/@css">
			<xsl:call-template name="XSLInclude">
				<xsl:with-param name="filename" select="/Data/WTENTITY/WTWEBPAGE/@css"/>
			</xsl:call-template>
		</xsl:if>

		<xsl:if test="/Data/WTENTITY/WTWEBPAGE/@meta">
			<xsl:call-template name="XSLInclude">
				<xsl:with-param name="filename" select="/Data/WTENTITY/WTWEBPAGE/@meta"/>
			</xsl:call-template>
		</xsl:if>

		<xsl:if test="$PageHeader!=''">
		 	<xsl:call-template name="XSLInclude">
	 	 		 <xsl:with-param name="filename" select="$PageHeader"/>
		 	</xsl:call-template>
		</xsl:if>
		<xsl:if test="$PageFooter!=''">
		 	<xsl:call-template name="XSLInclude">
		 		 <xsl:with-param name="filename" select="$PageFooter"/>
		 	</xsl:call-template>
		</xsl:if>
		<xsl:if test="$IsMenu='false'">
			<xsl:if test="$NavBar!='' and $NavBar!='blank'">
				<xsl:call-template name="XSLInclude">
					<xsl:with-param name="filename" select="$NavBarName"/>
				</xsl:call-template>
			</xsl:if>
		</xsl:if>
		<xsl:call-template name="XSLInclude">
			<xsl:with-param name="filename">Bookmark</xsl:with-param>
		</xsl:call-template>
		<xsl:if test="$IsMenu='true'">
			<xsl:call-template name="XSLInclude">
				<xsl:with-param name="filename">Include\wtMenu</xsl:with-param>
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="$IsMenuTree='true'">
			<xsl:call-template name="XSLInclude">
				<xsl:with-param name="filename">Include\wtMenuTree</xsl:with-param>
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="$IsTab='true'">
			<xsl:if test="not($IsMenu='true')">
				<xsl:call-template name="XSLInclude">
					<xsl:with-param name="filename">Include\wtSystem</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<xsl:call-template name="XSLInclude">
				<xsl:with-param name="filename">Include\wtTab</xsl:with-param>
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="$IsTree2='true'">
			<xsl:call-template name="XSLInclude">
				<xsl:with-param name="filename">Include\wtTree</xsl:with-param>
			</xsl:call-template>
		</xsl:if>

		<xsl:value-of select="concat($tab1, '&lt;xsl:output omit-xml-declaration=&quot;yes&quot;/&gt;', $cr, $cr)"/>

		<!--==========WTTREE==========-->
		<xsl:for-each select="/Data/WTENTITY/WTWEBPAGE/WTCONTENT/descendant::*[name()='WTTREE']">
			<xsl:call-template name="TreeNode"/>
		</xsl:for-each>

		<!--==========WTTREE2==========-->
		<xsl:for-each select="/Data/WTENTITY/WTWEBPAGE/WTCONTENT/descendant::*[name()='WTTREE2']">
			<xsl:call-template name="DefineTree2"/>
		</xsl:for-each>

		<!--==========HEADER==========-->
		<xsl:value-of select="concat($tab1, '&lt;xsl:template match=&quot;/&quot;&gt;', $cr, $cr)"/>

		<!--		<xsl:value-of select="concat($tab2, '&lt;xsl:value-of select=&quot;&amp;lt;!DOCTYPE HTML PUBLIC &amp;quot;-//W3C//DTD HTML 4.01 Transitional//EN&amp;quot; &amp;quot;http://www.w3.org/TR/html4/loose.dtd&amp;quot;&quot;/&gt;', $cr, $cr)"/>-->
		<!--==========BEGIN HTML==========-->
		<xsl:value-of select="concat($tab2, '&lt;xsl:element name=&quot;HTML&quot;&gt;', $cr, $cr)"/> 
		
		<xsl:value-of select="concat($tab2, '&lt;xsl:variable name=&quot;usergroup&quot; select=&quot;/DATA/SYSTEM/@usergroup&quot;/&gt;', $cr, $cr)"/>

		<!--==========BEGIN PAGE==========-->
		<xsl:choose>
			<xsl:when test="$includehtmleditor and $includecalendar">
				<xsl:call-template name="XSLPageBegin">
					<xsl:with-param name="name" select="$pagename"/>
					<xsl:with-param name="includecalendar" select="true()"/>
					<xsl:with-param name="htmleditor" select="$htmleditor"/>
				  	<xsl:with-param name="pagewidth" select="$pagewidth"/>
					<xsl:with-param name="content" select="/Data/WTENTITY/WTWEBPAGE/WTCONTENT"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="$includecalendar">
				<xsl:call-template name="XSLPageBegin">
					<xsl:with-param name="name" select="$pagename"/>
					<xsl:with-param name="includecalendar" select="true()"/>
				  	<xsl:with-param name="pagewidth" select="$pagewidth"/>
					<xsl:with-param name="content" select="/Data/WTENTITY/WTWEBPAGE/WTCONTENT"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="$includehtmleditor">
				<xsl:call-template name="XSLPageBegin">
					<xsl:with-param name="name" select="$pagename"/>
					<xsl:with-param name="htmleditor" select="$htmleditor"/>
				  	<xsl:with-param name="pagewidth" select="$pagewidth"/>
					<xsl:with-param name="content" select="/Data/WTENTITY/WTWEBPAGE/WTCONTENT"/>
				</xsl:call-template>
			</xsl:when>
		</xsl:choose>

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

		<xsl:if test="$MenuBar!=''">
			<xsl:call-template name="XSLHiddenInput">
				<xsl:with-param name="name">MenuBarState</xsl:with-param>
				<xsl:with-param name="indent">5</xsl:with-param>
				<xsl:with-param name="value" select="'/DATA/SYSTEM/@menubarstate'"/>
			</xsl:call-template>
		</xsl:if>

		<!-- Process page tracking -->
<!--		<xsl:for-each select="/Data/WTENTITY/WTWEBPAGE/WTTRACK">-->
		<!-- only get unique tracking account numbers -->
		<xsl:for-each select="/Data/WTENTITY/WTWEBPAGE/WTTRACK[not(@acct=preceding-sibling::WTTRACK/@acct)]">
			<xsl:variable name="tracktype"><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="@acct"/></xsl:call-template></xsl:variable>
			<xsl:variable name="tracktext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@acct"/></xsl:call-template></xsl:variable>
			<xsl:variable name="trackentity"><xsl:call-template name="QualifiedPrefix"><xsl:with-param name="value" select="@acct"/></xsl:call-template></xsl:variable>
			<xsl:variable name="track">
				<xsl:call-template name="GetValue">
		  			<xsl:with-param name="type" select="$tracktype"/>
		  			<xsl:with-param name="text" select="$tracktext"/>
		  			<xsl:with-param name="entity" select="$trackentity"/>
		  			<xsl:with-param name="noselect" select="true()"/>
		  		</xsl:call-template>
			</xsl:variable>
			<xsl:call-template name="XSLHiddenInput">
				<xsl:with-param name="name" select="$tracktext"/>
				<xsl:with-param name="indent">5</xsl:with-param>
				<xsl:with-param name="value" select="$track"/>
			</xsl:call-template>
		</xsl:for-each>

		<xsl:if test="$formtype='list'">
			<xsl:call-template name="XSLHiddenInput">
				<xsl:with-param name="name">Bookmark</xsl:with-param>
				<xsl:with-param name="indent">5</xsl:with-param>
				<xsl:with-param name="value">/DATA/BOOKMARK/@nextbookmark</xsl:with-param>
			</xsl:call-template>
		</xsl:if>

		<!--==========BEGIN PAGE LAYOUT ROW==========-->
		<xsl:call-template name="XSLPageRow"/>

		<!--==========PAGE HEADER====================-->
		<xsl:if test="$PageHeader!=''">
		 	<xsl:call-template name="XSLHeaderRow">
		 		 <xsl:with-param name="name" select="$PageHeader"/>
		 		 <xsl:with-param name="colspan" select="$colcount"/>
		 	</xsl:call-template>
		</xsl:if>

		<!--==========BEGIN BODY=======================-->
		<xsl:apply-templates select="/Data/WTENTITY/WTWEBPAGE/WTCONTENT">
			<xsl:with-param name="indent">5</xsl:with-param>
		</xsl:apply-templates>		

		<!--==========PAGE FOOTER======================-->
		<xsl:if test="$PageFooter!=''">
		 	<xsl:call-template name="XSLFooterRow">
		 		 <xsl:with-param name="name" select="$PageFooter"/>
		 		 <xsl:with-param name="colspan" select="$colcount"/>
		 	</xsl:call-template>
		</xsl:if>

		<!--==========END FORM==========-->
		<xsl:call-template name="XSLFormEnd"/>

		<!--==========END PAGE==========-->
		<xsl:call-template name="XSLPageEnd"/>

		<!--==========END HTML==========-->
		<xsl:value-of select="concat($tab2, '&lt;/xsl:element&gt;', $cr, $cr)"/>

		<xsl:value-of select="concat($tab1, '&lt;/xsl:template&gt;', $cr)"/>

		<xsl:value-of select="concat($tab0, '&lt;/xsl:stylesheet&gt;', $cr, $cr)"/>
	</xsl:template>

</xsl:stylesheet>

