<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:include href="GenerateIncludeXSL.xsl"/>
<!--=====================================================================
	Auth:   Bob Wood
	Date:   February 2002
	Desc:   Generates the NavBar.xsl
	Copyright 2002 WinTech, Inc.
======================================================================-->

	<xsl:template match="/">
		<WEB><xsl:apply-templates/></WEB>
	</xsl:template>

	<xsl:template match="WTROOT">
	
		<xsl:value-of select="concat($tab0, '&lt;xsl:stylesheet version=&quot;1.0&quot; xmlns:xsl=&quot;http://www.w3.org/1999/XSL/Transform&quot; xmlns:msxsl=&quot;urn:schemas-microsoft-com:xslt&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($tab1, '&lt;xsl:output omit-xml-declaration=&quot;yes&quot;/&gt;', $cr, $cr)"/>
		<xsl:value-of select="concat($tab1, '&lt;xsl:template name=&quot;NavBar&quot;&gt;', $cr, $cr)"/>
		<xsl:for-each select="WTUSERGROUPS/WTUSERGROUP">
			<xsl:variable name="entity" select="@entity"/>
			<xsl:variable name="columnid">
				<xsl:call-template name="CaseLower">
					<xsl:with-param name="value" select="/WTROOT/WTENTITIES/WTENTITY[@name=$entity]/@identity"/>
				</xsl:call-template>
			</xsl:variable>
			<xsl:value-of select="concat($tab2, '&lt;xsl:variable name=&quot;is', @name, '&quot; select=&quot;(/DATA/SYSTEM/@usergroup=',$apos, @id,$apos, ')' )"/>
			<xsl:if test="@entity">
				<xsl:value-of select="concat(' and (/DATA/SYSTEM/@', $columnid, '!=', $apos, '0', $apos, ')' )"/>
			</xsl:if>
			<xsl:value-of select="concat('&quot;/&gt;', $cr)"/>
		</xsl:for-each>

		<xsl:value-of select="concat($cr, $tab2, '&lt;xsl:element name=&quot;TABLE&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($tab3, '&lt;xsl:attribute name=&quot;border&quot;&gt;0&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($tab3, '&lt;xsl:attribute name=&quot;cellpadding&quot;&gt;0&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($tab3, '&lt;xsl:attribute name=&quot;cellspacing&quot;&gt;0&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($tab3, '&lt;xsl:attribute name=&quot;width&quot;&gt;140&lt;/xsl:attribute&gt;', $cr, $cr)"/>

		<xsl:value-of select="concat($tab3, '&lt;xsl:element name=&quot;TR&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($tab4, '&lt;xsl:attribute name=&quot;height&quot;&gt;20&lt;/xsl:attribute&gt;', $cr)"/>

		<xsl:value-of select="concat($tab4, '&lt;xsl:element name=&quot;TD&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($tab5, '&lt;xsl:attribute name=&quot;width&quot;&gt;130&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($tab4, '&lt;/xsl:element&gt;', $cr)"/>
		<xsl:value-of select="concat($tab4, '&lt;xsl:element name=&quot;TD&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($tab5, '&lt;xsl:attribute name=&quot;width&quot;&gt;10&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($tab4, '&lt;/xsl:element&gt;', $cr)"/>
		<xsl:value-of select="concat($tab3, '&lt;/xsl:element&gt;', $cr, $cr)"/>
				
		<xsl:value-of select="concat($tab3, '&lt;xsl:if test=&quot;/DATA/SYSTEM/@userid=',$apos,$apos,'&quot;&gt;', $cr)"/>

			<xsl:for-each select="/WTROOT/WTNAVBAR/WTITEM[@unsecure]">
				<xsl:choose>
					<xsl:when test="@separator">
						<xsl:value-of select="concat($tab6, '&lt;xsl:call-template name=&quot;NavBarSeparator&quot;/&gt;', $cr)"/>
					</xsl:when>
					<xsl:when test="@label">
						<xsl:value-of select="concat($tab6, '&lt;xsl:call-template name=&quot;NavBarItem&quot;&gt;', $cr)"/>
						<xsl:value-of select="concat($tab7, '&lt;xsl:with-param name=&quot;name&quot;&gt;', @label, '&lt;/xsl:with-param&gt;', $cr)"/>
						<xsl:value-of select="concat($tab6, '&lt;/xsl:call-template&gt;', $cr)"/>
					</xsl:when>
					<xsl:otherwise><xsl:call-template name="NavItem"/></xsl:otherwise>
				</xsl:choose>
			</xsl:for-each>

		<xsl:value-of select="concat($tab3, '&lt;/xsl:if&gt;', $cr)"/>

		<xsl:value-of select="concat($cr, $tab3, '&lt;xsl:if test=&quot;/DATA/SYSTEM/@userid!=',$apos,$apos,'&quot;&gt;', $cr)"/>

		<xsl:value-of select="concat($tab4, '&lt;xsl:choose&gt;', $cr)"/>

		<xsl:for-each select="WTUSERGROUPS/WTUSERGROUP">
			<xsl:variable name="id" select="@id"/>
			<xsl:variable name="entity" select="@entity"/>

			<xsl:value-of select="concat($tab5, '&lt;xsl:when test=&quot;$is', @name, '&quot;&gt;', $cr)"/>

			<xsl:for-each select="/WTROOT/WTNAVBAR/WTITEM">
				<xsl:variable name="name" select="@name"/>
				<xsl:variable name="ishidden" select="@hidden and (@hidden&lt;=$id)"/>
				<xsl:variable name="issecure" select="@secure and (@secure&lt;=$id)"/>

				<xsl:if test="not($ishidden)">
					<xsl:choose>
						<xsl:when test="@separator">
							<xsl:value-of select="concat($tab6, '&lt;xsl:call-template name=&quot;NavBarSeparator&quot;/&gt;', $cr)"/>
						</xsl:when>
						<xsl:when test="@label">
							<xsl:value-of select="concat($tab6, '&lt;xsl:call-template name=&quot;NavBarItem&quot;&gt;', $cr)"/>
							<xsl:value-of select="concat($tab7, '&lt;xsl:with-param name=&quot;name&quot;&gt;', @label, '&lt;/xsl:with-param&gt;', $cr)"/>
							<xsl:value-of select="concat($tab6, '&lt;/xsl:call-template&gt;', $cr)"/>
						</xsl:when>
						<xsl:when test="not($issecure)"><xsl:call-template name="NavItem"/></xsl:when>
						<xsl:when test="$issecure">
							<xsl:call-template name="SecuredEntity">
								<xsl:with-param name="userentity" select="$entity"/>
							</xsl:call-template>
						</xsl:when>
					</xsl:choose>
				</xsl:if>

			</xsl:for-each>

			<xsl:value-of select="concat($tab6, '&lt;xsl:call-template name=&quot;Logon&quot;/&gt;', $cr)"/>
			<xsl:value-of select="concat($tab5, '&lt;/xsl:when&gt;', $cr)"/>

		</xsl:for-each>

		<xsl:value-of select="concat($tab4, '&lt;/xsl:choose&gt;', $cr, $cr)"/>

		<xsl:value-of select="concat($tab4, '&lt;xsl:element name=&quot;TR&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($tab5, '&lt;xsl:attribute name=&quot;height&quot;&gt;20&lt;/xsl:attribute&gt;', $cr)"/>

		<xsl:value-of select="concat($tab5, '&lt;xsl:element name=&quot;TD&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($tab6, '&lt;xsl:attribute name=&quot;width&quot;&gt;130&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($tab5, '&lt;/xsl:element&gt;', $cr)"/>
		<xsl:value-of select="concat($tab5, '&lt;xsl:element name=&quot;TD&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($tab6, '&lt;xsl:attribute name=&quot;width&quot;&gt;10&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($tab5, '&lt;/xsl:element&gt;', $cr)"/>
		<xsl:value-of select="concat($tab4, '&lt;/xsl:element&gt;', $cr, $cr)"/>
				
		<xsl:value-of select="concat($tab3, '&lt;/xsl:if&gt;', $cr, $cr)"/>
		<xsl:value-of select="concat($tab2, '&lt;/xsl:element&gt;', $cr, $cr)"/>
		
		<xsl:value-of select="concat($tab1, '&lt;/xsl:template&gt;', $cr, $cr)"/>

		<!--build all the item templates-->
		<xsl:for-each select="/WTROOT/WTNAVBAR/WTITEM">
			<xsl:choose>
				<xsl:when test="@separator"/>
				<xsl:when test="@label"/>
				<xsl:when test="@custom"><xsl:call-template name="Custom"/></xsl:when>
				<xsl:when test="@name"><xsl:call-template name="Entity"/></xsl:when>
				<xsl:when test="@section"><xsl:call-template name="Section"/></xsl:when>
			</xsl:choose>
		</xsl:for-each>

		<xsl:call-template name="Logon"/>

		<xsl:value-of select="concat($tab0, '&lt;/xsl:stylesheet&gt;', $cr, $cr)"/>

	</xsl:template>

<!--************************************************************************************************-->
<xsl:template name="NavItem">
	<xsl:variable name="template">
		<xsl:if test="@custom"><xsl:value-of select="@custom"/></xsl:if>
		<xsl:if test="@name"><xsl:value-of select="@name"/></xsl:if>
		<xsl:if test="@section"><xsl:value-of select="@section"/></xsl:if>
	</xsl:variable>
	<xsl:value-of select="concat($tab6, '&lt;xsl:call-template name=&quot;', $template, '&quot;/&gt;', $cr)"/>
</xsl:template>

<xsl:template name="NavSectionItem">
	<xsl:value-of select="concat($tab2, '&lt;xsl:call-template name=&quot;', @name, '&quot;/&gt;', $cr)"/>
</xsl:template>

<!--************************************************************************************************-->
<xsl:template name="Entity">

	<xsl:variable name="entity" select="@name"/>
	<xsl:variable name="number" select="/WTROOT/WTENTITIES/WTENTITY[@name=$entity]/@number"/>
	<xsl:variable name="lookup" select="/WTROOT/WTENTITIES/WTENTITY[@name=$entity]/@lookup"/>
	<xsl:variable name="page">
		<xsl:choose>
			<xsl:when test="string-length($number)=1">0<xsl:value-of select="$number"/></xsl:when>
			<xsl:otherwise><xsl:value-of select="$number"/></xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="pagefindlist">
		<xsl:value-of select="$page"/>
		<xsl:choose>
			<xsl:when test="$lookup">11</xsl:when>
			<xsl:otherwise>01</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="pageadd">
		<xsl:choose>
			<xsl:when test="@newpage"><xsl:value-of select="@newpage"/></xsl:when>
			<xsl:otherwise><xsl:value-of select="$page"/>02.asp</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>

	<xsl:value-of select="concat($tab1, '&lt;xsl:template name=&quot;', @name, '&quot;&gt;', $cr)"/>

		<xsl:choose>
			<xsl:when test="@sub">
				<xsl:value-of select="concat($tab2, '&lt;xsl:call-template name=&quot;NavBarSubItem&quot;&gt;', $cr)"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="concat($tab2, '&lt;xsl:call-template name=&quot;NavBarItem&quot;&gt;', $cr)"/>
			</xsl:otherwise>
		</xsl:choose>
		
			<xsl:value-of select="concat($tab3, '&lt;xsl:with-param name=&quot;name&quot;&gt;', @name, 's&lt;/xsl:with-param&gt;', $cr)"/>
			<xsl:value-of select="concat($tab3, '&lt;xsl:with-param name=&quot;link&quot;&gt;', $pagefindlist, '.asp&lt;/xsl:with-param&gt;', $cr)"/>
		<xsl:value-of select="concat($tab2, '&lt;/xsl:call-template&gt;', $cr)"/>

		<xsl:if test="not(/WTROOT/WTRELATIONSHIPS/WTRELATIONSHIP[@entity=$entity and @parent]) and not($lookup)">

			<xsl:if test="@hiddennew">
				<xsl:value-of select="concat($tab2, '&lt;xsl:if test=&quot;/DATA/SYSTEM/@usergroup &amp;lt;', @hiddennew, '&quot;&gt;', $cr )"/>
			</xsl:if>

			<xsl:value-of select="concat($tab2, '&lt;xsl:call-template name=&quot;NavBarSubItem&quot;&gt;', $cr)"/>
				<xsl:value-of select="concat($tab3, '&lt;xsl:with-param name=&quot;name&quot;&gt;New&lt;/xsl:with-param&gt;', $cr)"/>
				<xsl:value-of select="concat($tab3, '&lt;xsl:with-param name=&quot;link&quot;&gt;', $pageadd, '?ReturnURL=',$page  ,'01.asp&lt;/xsl:with-param&gt;', $cr)"/>
				<xsl:value-of select="concat($tab3, '&lt;xsl:with-param name=&quot;readonly&quot; select=&quot;true()&quot;/&gt;', $cr)"/>
			<xsl:value-of select="concat($tab2, '&lt;/xsl:call-template&gt;', $cr)"/>

			<xsl:if test="@hiddennew">
				<xsl:value-of select="concat($tab2, '&lt;/xsl:if&gt;', $cr )"/>
			</xsl:if>

		</xsl:if>

	<xsl:value-of select="concat($tab1, '&lt;/xsl:template&gt;', $cr, $cr)"/>

</xsl:template>


<!--************************************************************************************************-->
<xsl:template name="Page">
	<xsl:value-of select="concat($tab1, '&lt;xsl:template name=&quot;', @name, '&quot;&gt;', $cr)"/>
	<xsl:value-of select="concat($tab2, '&lt;xsl:call-template name=&quot;NavBarItem&quot;&gt;', $cr)"/>
	<xsl:value-of select="concat($tab3, '&lt;xsl:with-param name=&quot;name&quot;&gt;', @name, 's&lt;/xsl:with-param&gt;', $cr)"/>
	<xsl:value-of select="concat($tab3, '&lt;xsl:with-param name=&quot;link&quot;&gt;', @page, '&lt;/xsl:with-param&gt;', $cr)"/>
	<xsl:value-of select="concat($tab2, '&lt;/xsl:call-template&gt;', $cr)"/>
	<xsl:value-of select="concat($tab1, '&lt;/xsl:template&gt;', $cr, $cr)"/>
</xsl:template>

<!--************************************************************************************************-->
<xsl:template name="Custom">
	<xsl:value-of select="concat($tab1, '&lt;xsl:template name=&quot;', @custom, '&quot;&gt;', $cr)"/>
	<xsl:value-of select="concat($tab2, '&lt;xsl:call-template name=&quot;NavBarItem&quot;&gt;', $cr)"/>
	<xsl:value-of select="concat($tab3, '&lt;xsl:with-param name=&quot;name&quot;&gt;', @custom, '&lt;/xsl:with-param&gt;', $cr)"/>
	<xsl:value-of select="concat($tab3, '&lt;xsl:with-param name=&quot;link&quot;&gt;', @link, '&lt;/xsl:with-param&gt;', $cr)"/>
	<xsl:value-of select="concat($tab2, '&lt;/xsl:call-template&gt;', $cr)"/>
	<xsl:value-of select="concat($tab1, '&lt;/xsl:template&gt;', $cr, $cr)"/>
</xsl:template>

<!--************************************************************************************************-->
<xsl:template name="Section">

	<xsl:value-of select="concat($tab1, '&lt;xsl:template name=&quot;', @section, '&quot;&gt;', $cr)"/>
	<xsl:value-of select="concat($tab2, '&lt;xsl:call-template name=&quot;NavBarSeparator&quot;/&gt;', $cr)"/>
	<xsl:variable name="section" select="@section"/>
	
	<xsl:for-each select="/WTROOT/WTNAVBAR/WTSECTION[@name=$section]/WTITEM">
		<xsl:choose>
			<xsl:when test="@separator">
				<xsl:value-of select="concat($tab6, '&lt;xsl:call-template name=&quot;NavBarSeparator&quot;/&gt;', $cr)"/>
			</xsl:when>
			<xsl:when test="@label">
				<xsl:value-of select="concat($tab2, '&lt;xsl:call-template name=&quot;NavBarItem&quot;&gt;', $cr)"/>
				<xsl:value-of select="concat($tab3, '&lt;xsl:with-param name=&quot;name&quot;&gt;', @label, '&lt;/xsl:with-param&gt;', $cr)"/>
				<xsl:value-of select="concat($tab2, '&lt;/xsl:call-template&gt;', $cr)"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="NavSectionItem"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:for-each>
	<xsl:value-of select="concat($tab1, '&lt;/xsl:template&gt;', $cr, $cr)"/>

	<xsl:for-each select="/WTROOT/WTNAVBAR/WTSECTION[@name=$section]/WTITEM">
		<xsl:choose>
			<xsl:when test="@separator"/>
			<xsl:when test="@label"/>
			<xsl:when test="@page"><xsl:call-template name="Page"/></xsl:when>
			<xsl:otherwise><xsl:call-template name="Entity"/></xsl:otherwise>
		</xsl:choose>
	</xsl:for-each>
	
</xsl:template>

<!--************************************************************************************************-->
<xsl:template name="SecuredEntity">
	<xsl:param name="userentity"/>

	<xsl:variable name="useridentity" select="/WTROOT/WTENTITIES/WTENTITY[@name=$userentity]/@identity"/>
	<xsl:variable name="entity" select="@name"/>
	<xsl:variable name="number" select="/WTROOT/WTENTITIES/WTENTITY[@name=$entity]/@number"/>
	<xsl:variable name="page">
		<xsl:choose>
			<xsl:when test="string-length($number)=1">0<xsl:value-of select="$number"/></xsl:when>
			<xsl:otherwise><xsl:value-of select="$number"/></xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="columnid">
		<xsl:call-template name="CaseLower">
			<xsl:with-param name="value" select="$useridentity"/>
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="myname">
		<xsl:choose>
			<xsl:when test="$userentity=$entity">MyInfo</xsl:when>
			<xsl:otherwise><xsl:value-of select="$entity"/>s</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="mypage">
		<xsl:choose>
			<xsl:when test="$userentity=$entity">03</xsl:when>
			<xsl:otherwise>01</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>

	<xsl:value-of select="concat($tab6, '&lt;xsl:call-template name=&quot;NavBarItem&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($tab7, '&lt;xsl:with-param name=&quot;name&quot;&gt;', $myname, '&lt;/xsl:with-param&gt;', $cr)"/>
		<xsl:value-of select="concat($tab7, '&lt;xsl:with-param name=&quot;link&quot;&gt;&lt;xsl:value-of select=&quot;concat(', $apos, $page, $mypage, '.asp?', $useridentity,'=', $apos, ', /DATA/SYSTEM/@', $columnid, ')&quot;/&gt;&lt;/xsl:with-param&gt;', $cr)"/>
	<xsl:value-of select="concat($tab6, '&lt;/xsl:call-template&gt;', $cr)"/>

	<xsl:if test="$userentity!=$entity">
		<xsl:if test="not(/WTROOT/WTRELATIONSHIPS/WTRELATIONSHIP[@entity=$entity and @parent])">

			<xsl:value-of select="concat($tab6, '&lt;xsl:call-template name=&quot;NavBarSubItem&quot;&gt;', $cr)"/>
				<xsl:value-of select="concat($tab7, '&lt;xsl:with-param name=&quot;name&quot;&gt;New&lt;/xsl:with-param&gt;', $cr)"/>
				<xsl:value-of select="concat($tab7, '&lt;xsl:with-param name=&quot;link&quot;&gt;&lt;xsl:value-of select=&quot;concat(', $apos, $page, '02.asp?', $useridentity,'=', $apos, ', /DATA/SYSTEM/@', $columnid, ')&quot;/&gt;&lt;/xsl:with-param&gt;', $cr)"/>
				<xsl:value-of select="concat($tab3, '&lt;xsl:with-param name=&quot;readonly&quot; select=&quot;true()&quot;/&gt;', $cr)"/>
			<xsl:value-of select="concat($tab6, '&lt;/xsl:call-template&gt;', $cr)"/>
		</xsl:if>
	</xsl:if>
</xsl:template>

<!--************************************************************************************************-->
<xsl:template name="Logon">
<xsl:text>
	&lt;!--==========LOGON SECTION==========--&gt;
	&lt;xsl:template name="Logon"&gt;
		&lt;xsl:call-template name="NavBarSeparator"/&gt;
		&lt;xsl:call-template name="NavBarItem"&gt;
			&lt;xsl:with-param name="name"&gt;LogonPassword&lt;/xsl:with-param&gt;
		&lt;/xsl:call-template&gt;
		&lt;xsl:if test="(/DATA/SYSTEM/@userid &gt; '99')"&gt;
			&lt;xsl:call-template name="NavBarSubItem"&gt;
				&lt;xsl:with-param name="name"&gt;ChangeLogon&lt;/xsl:with-param&gt;
				&lt;xsl:with-param name="link"&gt;0103.asp&lt;/xsl:with-param&gt;
			&lt;/xsl:call-template&gt;
		&lt;/xsl:if&gt;
		&lt;xsl:call-template name="NavBarSubItem"&gt;
			&lt;xsl:with-param name="name"&gt;ChangePassword&lt;/xsl:with-param&gt;
			&lt;xsl:with-param name="link"&gt;0104.asp&lt;/xsl:with-param&gt;
		&lt;/xsl:call-template&gt;
		&lt;xsl:call-template name="NavBarSubItem"&gt;
			&lt;xsl:with-param name="name"&gt;SignOut&lt;/xsl:with-param&gt;
			&lt;xsl:with-param name="link"&gt;0101.asp?ActionCode=9&lt;/xsl:with-param&gt;
		&lt;/xsl:call-template&gt;	
	&lt;/xsl:template&gt;
	
	&lt;!--==========NAV BAR ITEM==========--&gt;
	&lt;xsl:template name="NavBarItem"&gt;
		&lt;xsl:param name="name"/&gt;
		&lt;xsl:param name="link"/&gt;
		
		&lt;xsl:element name="TR"&gt;
			&lt;xsl:element name="TD"&gt;
				&lt;xsl:attribute name="height"&gt;2&lt;/xsl:attribute&gt;
			&lt;/xsl:element&gt;
		&lt;/xsl:element&gt;
		&lt;xsl:choose&gt;
			&lt;xsl:when test = "($link != '')"&gt;
				&lt;xsl:element name="TR"&gt;
					&lt;xsl:element name="TD"&gt;
						&lt;xsl:attribute name="align"&gt;right&lt;/xsl:attribute&gt;
						&lt;xsl:element name="A"&gt;
							&lt;xsl:attribute name="class"&gt;NavBar&lt;/xsl:attribute&gt;
							&lt;xsl:attribute name="href"&gt;&lt;xsl:value-of select="$link"/&gt;&lt;/xsl:attribute&gt;
							&lt;xsl:value-of select="/DATA/LANGUAGE/LABEL[@name=$name]"/&gt;
						&lt;/xsl:element&gt;
					&lt;/xsl:element&gt;
				&lt;/xsl:element&gt;
			&lt;/xsl:when&gt;
			&lt;xsl:otherwise&gt;
				&lt;xsl:element name="TR"&gt;
					&lt;xsl:element name="TD"&gt;
						&lt;xsl:attribute name="align"&gt;right&lt;/xsl:attribute&gt;
						&lt;xsl:attribute name="class"&gt;NavBar&lt;/xsl:attribute&gt;
						&lt;xsl:value-of select="/DATA/LANGUAGE/LABEL[@name=$name]"/&gt;
					&lt;/xsl:element&gt;
				&lt;/xsl:element&gt;
			&lt;/xsl:otherwise&gt;
		&lt;/xsl:choose&gt;
	&lt;/xsl:template&gt;

	&lt;!--==========NAV BAR SUBITEM==========--&gt;
	&lt;xsl:template name="NavBarSubItem"&gt;
		&lt;xsl:param name="name"/&gt;
		&lt;xsl:param name="link"/&gt;
		&lt;xsl:param name="readonly" select="false()"/&gt;
		
		&lt;xsl:choose&gt;
			&lt;xsl:when test=&quot;($readonly=true())&quot;&gt;
				&lt;xsl:if test=&quot;(/DATA/SYSTEM/@userstatus = 1)&quot;&gt;
					&lt;xsl:element name="TR"&gt;
						&lt;xsl:element name="TD"&gt;
							&lt;xsl:attribute name="align"&gt;right&lt;/xsl:attribute&gt;
							&lt;xsl:element name="A"&gt;
								&lt;xsl:attribute name="href"&gt;&lt;xsl:value-of select="$link"/&gt;&lt;/xsl:attribute&gt;
								&lt;xsl:value-of select=&quot;/DATA/LANGUAGE/LABEL[@name=$name]&quot;/&gt;
							&lt;/xsl:element&gt;
						&lt;/xsl:element&gt;
					&lt;/xsl:element&gt;
				&lt;/xsl:if&gt;
			&lt;/xsl:when&gt;
			&lt;xsl:otherwise&gt;
				&lt;xsl:element name="TR"&gt;
					&lt;xsl:element name="TD"&gt;
						&lt;xsl:attribute name="align"&gt;right&lt;/xsl:attribute&gt;
						&lt;xsl:element name="A"&gt;
							&lt;xsl:attribute name="href"&gt;&lt;xsl:value-of select="$link"/&gt;&lt;/xsl:attribute&gt;
							&lt;xsl:value-of select="/DATA/LANGUAGE/LABEL[@name=$name]"/&gt;
						&lt;/xsl:element&gt;
					&lt;/xsl:element&gt;
				&lt;/xsl:element&gt;
			&lt;/xsl:otherwise&gt;
		&lt;/xsl:choose&gt;
	&lt;/xsl:template&gt;

	&lt;!--==========NAV BAR SEPARATOR==========--&gt;
	&lt;xsl:template name="NavBarSeparator"&gt;
		&lt;xsl:element name="TR"&gt;
			&lt;xsl:element name="TD"&gt;
				&lt;xsl:element name="HR"&gt;
					&lt;xsl:attribute name="width"&gt;120&lt;/xsl:attribute&gt;
					&lt;xsl:attribute name="align"&gt;right&lt;/xsl:attribute&gt;
					&lt;xsl:attribute name="size"&gt;1&lt;/xsl:attribute&gt;
				&lt;/xsl:element&gt;
			&lt;/xsl:element&gt;
		&lt;/xsl:element&gt;
	&lt;/xsl:template&gt;

</xsl:text>
</xsl:template>

</xsl:stylesheet>

