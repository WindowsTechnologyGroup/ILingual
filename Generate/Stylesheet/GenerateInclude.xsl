<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:variable name="apos"><xsl:text>&apos;</xsl:text></xsl:variable>
	<xsl:variable name="cr" select="'&#010;'"/>

	<xsl:variable name="tab0" select="''"/>
	<xsl:variable name="tab1" select="'&#009;'"/>
	<xsl:variable name="tab2" select="concat($tab1, $tab1)"/>
	<xsl:variable name="tab3" select="concat($tab2, $tab1)"/>
	<xsl:variable name="tab4" select="concat($tab3, $tab1)"/>
	<xsl:variable name="tab5" select="concat($tab4, $tab1)"/>
	<xsl:variable name="tab6" select="concat($tab5, $tab1)"/>
	<xsl:variable name="tab7" select="concat($tab6, $tab1)"/>
	<xsl:variable name="tab8" select="concat($tab7, $tab1)"/>
	<xsl:variable name="tab9" select="concat($tab8, $tab1)"/>
	<xsl:variable name="tab10" select="concat($tab9, $tab1)"/>
	<xsl:variable name="tab11" select="concat($tab10, $tab1)"/>
	<xsl:variable name="tab12" select="concat($tab11, $tab1)"/>
	<xsl:variable name="tab13" select="concat($tab12, $tab1)"/>
	<xsl:variable name="tab14" select="concat($tab13, $tab1)"/>
	<xsl:variable name="tab15" select="concat($tab14, $tab1)"/>
	<xsl:variable name="tab16" select="concat($tab15, $tab1)"/>
	<xsl:variable name="tab17" select="concat($tab16, $tab1)"/>
	<xsl:variable name="tab18" select="concat($tab17, $tab1)"/>
	<xsl:variable name="tab19" select="concat($tab18, $tab1)"/>
	<xsl:variable name="tab20" select="concat($tab19, $tab1)"/>
	<xsl:variable name="tab21" select="concat($tab20, $tab1)"/>
	<xsl:variable name="tab22" select="concat($tab21, $tab1)"/>
	<xsl:variable name="tab23" select="concat($tab22, $tab1)"/>
	<xsl:variable name="tab24" select="concat($tab23, $tab1)"/>
	<xsl:variable name="tab25" select="concat($tab24, $tab1)"/>
	<xsl:variable name="tab26" select="concat($tab25, $tab1)"/>
	<xsl:variable name="tab27" select="concat($tab26, $tab1)"/>
	<xsl:variable name="tab28" select="concat($tab27, $tab1)"/>
	<xsl:variable name="tab29" select="concat($tab28, $tab1)"/>
	<xsl:variable name="tab30" select="concat($tab29, $tab1)"/>
	
	<!--SYSTEM/APPLICATION reference variables-->
		<xsl:variable name="dbowner" select="/Data/@dbo"/>
		<xsl:variable name="systemname" select="/Data/@system"/>
		<xsl:variable name="appprefix" select="/Data/@prefix"/>
		<xsl:variable name="PagesLanguage" select="/Data/@language"/>
		<xsl:variable name="PageLanguage" select="/Data/WTENTITY/WTWEBPAGE/@language"/>

	<!--ENTITY reference variables-->
		<xsl:variable name="entityname" select="/Data/WTENTITY/@name"/>
		<xsl:variable name="entityid" select="/Data/WTENTITY/@id"/>
		<xsl:variable name="entityalias" select="/Data/WTENTITY/@alias"/>
		<xsl:variable name="entityobj" select="concat('o', $entityname)"/>
		<xsl:variable name="collname" select="concat($entityname, 's')"/>
		<xsl:variable name="collobj" select="concat('o', $collname)"/>

	<!--PARENT (immediate) reference variables-->	
		<xsl:variable name="ischild" select="count(/Data/WTENTITY/WTPARENTS/WTPARENT) > 0"/>
		<xsl:variable name="parentname" select="/Data/WTENTITY/WTPARENTS/WTPARENT[position()=last()]/@entity"/>
		<xsl:variable name="parentobj" select="concat('o', $parentname)"/>
		<xsl:variable name="parenttitle" select="/Data/WTENTITY/WTPARENTS/WTPARENT[position() = last()]/@title"/>

	<!--TEMPLATE reference variables-->	
		<xsl:variable name="hastemplate" select="/Data/WTENTITY/WTTEMPLATE"/>
		<xsl:variable name="templatename" select="/Data/WTENTITY/WTTEMPLATE/@name"/>

	<!--ATTRIBUTE  reference variables-->
		<!--indicates the name of the attribute that is the identity column-->	
		<xsl:variable name="identity" select="/Data/WTENTITY/WTATTRIBUTE[@identity='true']/@name"/>
		<xsl:variable name="identityid" select="/Data/WTENTITY/WTATTRIBUTE[@identity='true']/@id"/>
		<!--a node-set containing a WTENTITY/WTATTRIBUTE node for each attribute that is initialized to the identity value-->
		<xsl:variable name="identityinits" select="/Data/WTENTITY/WTATTRIBUTE[WTINIT[@type='system' and @value='sysidentity']]"/>
		<!--a node-set containing a .../WTRELATIONSHIP/WTENTITY/WTATTRIBUTE node for each column needed to join to the parent-->
		<xsl:variable name="parentfields" select="/Data/WTENTITY/WTRELATIONSHIPS/WTRELATIONSHIP[@name=$parentname]/WTENTITY[@entity=$parentname]/WTATTRIBUTE"/>
		<!--a node-set containing a .../WTATTRIBUTE node for each attribute that is a lookup-->
		<xsl:variable name="attrlookups" select="/Data/WTENTITY/WTATTRIBUTE[WTLOOKUP]"/>
		<xsl:variable name="attrInputOptions" select="/Data/WTENTITY/WTATTRIBUTE[WTINPUTOPTIONS]"/>
		<xsl:variable name="attrlookupsFiltered" select="/Data/WTENTITY/WTATTRIBUTE[WTLOOKUP][count(WTLOOKUP/WTPARAM)&gt;1]"/>
		<xsl:variable name="attrlookupsNotFiltered" select="/Data/WTENTITY/WTATTRIBUTE[WTLOOKUP][count(WTLOOKUP/WTPARAM)&lt;=1]"/>
		<!--a node-set containing a .../WTATTRIBUTE node for each attribute that is an enum-->
		<xsl:variable name="attrenums" select="/Data/WTENTITY/WTATTRIBUTE[WTENUM]"/>
		<!--a node-set containing a .../WTATTRIBUTE node for each attribute that is a yesno field-->
		<xsl:variable name="attryesnos" select="/Data/WTENTITY/WTATTRIBUTE[@type='yesno']"/>

	<!--PROCEDURAL/FUNCTIONALITY reference variables-->
		<!--indicates if the procedure has child parameters-->
		<xsl:variable name="hasprocparams" select="count(/Data/WTENTITY/WTPROCEDURE/WTPARAM) != 0"/>	
		<!--a node-set containing a .../WTPARAM node for each parameter to a procedure-->
		<xsl:variable name="procparams" select="/Data/WTENTITY/WTPROCEDURE/WTPARAM"/>
		<!--a node-set containing a .../WTORDER node for each order by specified for a procedure-->
		<xsl:variable name="procorders" select="/Data/WTENTITY/WTPROCEDURE/WTORDER"/>
		<!--indicates if the entity has/needs list method functionality-->
		<xsl:variable name="haslist" select="count(/Data/WTENTITY/WTENUM[@type='list']) != 0"/>	
		<!--indicates if the entity has multiple list by methods-->
		<xsl:variable name="multilist" select="count(/Data/WTENTITY/WTENUM[@type='list']/WTATTRIBUTE) > 0"/>
		<!--indicates if the procedure has a bookmark-->
		<xsl:variable name="hasbookmark" select="count(/Data/WTENTITY/WTPROCEDURE/WTBOOKMARK) > 0"/>
		<!--indicates if the procedure has a search-->
		<xsl:variable name="hassearch" select="count(/Data/WTENTITY/WTPROCEDURE/WTSEARCH) > 0"/>
		<!--indicates the name of the attribute to use as the description in the enum of the entity-->
		<xsl:variable name="enumcolumn" select="/Data/WTENTITY/WTPROCEDURES/WTPROCEDURE[@type='Enum']/@column"/>
		<!--a node-set containing a cumulative list of ...WTPROCEDURE/WTPARAM nodes for each additional parameter to a Find method-->
		<xsl:variable name="findparams" select="/Data/WTENTITY/WTPROCEDURES/WTPROCEDURE[@type='Find']/WTPARAM"/>
		<!--indicates if the procedure has child conditions-->
		<xsl:variable name="hasconditions" select="(count(/Data/WTENTITY/WTPROCEDURE/WTCONDITION) > 0)"/>

	<!-- TRANSLATE variables-->
	<xsl:variable name="translate">
		<xsl:choose>
			<xsl:when test="/Data/WTENTITY/WTWEBPAGE/@translate='true'">true</xsl:when>
			<xsl:when test="/Data/WTENTITY/WTWEBPAGE/@translate='false'">false</xsl:when>
			<xsl:when test="/Data/WTENTITY/@translate='false'">false</xsl:when>
			<xsl:when test="/Data/WTENTITY/WTWEBPAGE/@translate">true</xsl:when>
			<xsl:when test="/Data/WTPAGE/@translate">true</xsl:when>
			<xsl:otherwise>false</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>

		<!--LOGGING reference variables-->
		<xsl:variable name="LogGoogle" select="/Data/WTPAGE/@log='Google'"/>
		<xsl:variable name="LogProject" select="/Data/WTPAGE/@log='true'"/>
		<xsl:variable name="LogPage" select="/Data/WTENTITY/WTWEBPAGE/@track"/>
		<xsl:variable name="LogAction" select="descendant::WTTRACK"/>
		<xsl:variable name="TrackAction" select="count(/Data/WTENTITY/WTWEBPAGE/WTTRACK/@action) &gt; 0"/>

  <!--Worker Page variables-->
  <xsl:variable name="WorkerPage" select="/Data/WTENTITY/WTWEBPAGE/@worker"/>

  <!--Widht Percentages-->
  <xsl:variable name="widthpercent">
    <xsl:choose>
      <xsl:when test="contains(/Data/WTENTITY/WTWEBPAGE/@page-width, '%')">true</xsl:when>
      <xsl:when test="contains(/Data/WTENTITY/WTWEBPAGE/@content-width, '%')">true</xsl:when>
      <xsl:otherwise>false</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="wrapper">
			<xsl:choose>
				<xsl:when test="/Data/WTENTITY/WTWEBPAGE/@wrapper or /Data/WTPAGE/@wrapper">
					<xsl:choose>
						<xsl:when test="/Data/WTENTITY/WTWEBPAGE/@wrapper='false'"></xsl:when>
						<xsl:when test="/Data/WTENTITY/WTWEBPAGE/@wrapper"><xsl:value-of select="/Data/WTENTITY/WTWEBPAGE/@wrapper"/></xsl:when>
						<xsl:when test="/Data/WTENTITY/WTWEBPAGE/@page-width"></xsl:when>
						<xsl:when test="/Data/WTPAGE/@wrapper"><xsl:value-of select="/Data/WTPAGE/@wrapper"/></xsl:when>
						<xsl:otherwise>wrapper</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="wrapper-width">
			<xsl:value-of select="sum(/Data/WTENTITY/WTWEBPAGE/WTCONTENT/WTCOLUMN/@width)"/>
		</xsl:variable>

<!--OLD-->
	<xsl:variable name="column" select="/Data/WTENTITY/WTPROCEDURE/@column"/>
	<xsl:variable name="isinherit" select="count(WTATTRIBUTE[@source='inherit']/WTJOIN[not (@entity=preceding::WTATTRIBUTE[@source='inherit']/WTJOIN/@entity)]) > 0"/>
	<xsl:variable name="inheritentity" select="/Data/WTENTITY/WTPROCEDURE/@entity"/>
	<xsl:variable name="searchfld" select="/Data/WTENTITY/WTPROCEDURE/@column"/>
	<xsl:variable name="doparent" select="(/Data/WTENTITY/WTPROCEDURE/@parent='true')"/>
	<xsl:variable name="hasfind" select="count(/Data/WTENTITY/WTENUM[@type='find']) != 0"/>
	<xsl:variable name="hasenum" select="count(/Data/WTENTITY/WTATTRIBUTE[WTENUM]) != 0"/>
	<xsl:variable name="findcolcount" select="count(/Data/WTENTITY/WTWEBPAGE/WTATTRIBUTE) + 1"/>

	<!--==========Indent==========-->
	<xsl:template name="Indent">
		<xsl:param name="level"/>
		<xsl:choose>
			<xsl:when test="($level='0')"><xsl:value-of select="$tab0"/></xsl:when>
			<xsl:when test="($level='1')"><xsl:value-of select="$tab1"/></xsl:when>
			<xsl:when test="($level='2')"><xsl:value-of select="$tab2"/></xsl:when>
			<xsl:when test="($level='3')"><xsl:value-of select="$tab3"/></xsl:when>
			<xsl:when test="($level='4')"><xsl:value-of select="$tab4"/></xsl:when>
			<xsl:when test="($level='5')"><xsl:value-of select="$tab5"/></xsl:when>
			<xsl:when test="($level='6')"><xsl:value-of select="$tab6"/></xsl:when>
			<xsl:when test="($level='7')"><xsl:value-of select="$tab7"/></xsl:when>
			<xsl:when test="($level='8')"><xsl:value-of select="$tab8"/></xsl:when>
			<xsl:when test="($level='9')"><xsl:value-of select="$tab9"/></xsl:when>
			<xsl:when test="($level='10')"><xsl:value-of select="$tab10"/></xsl:when>
			<xsl:when test="($level='11')"><xsl:value-of select="$tab11"/></xsl:when>
			<xsl:when test="($level='12')"><xsl:value-of select="$tab12"/></xsl:when>
			<xsl:when test="($level='13')"><xsl:value-of select="$tab13"/></xsl:when>
			<xsl:when test="($level='14')"><xsl:value-of select="$tab14"/></xsl:when>
			<xsl:when test="($level='15')"><xsl:value-of select="$tab15"/></xsl:when>
			<xsl:when test="($level='16')"><xsl:value-of select="$tab16"/></xsl:when>
			<xsl:when test="($level='17')"><xsl:value-of select="$tab17"/></xsl:when>
			<xsl:when test="($level='18')"><xsl:value-of select="$tab18"/></xsl:when>
			<xsl:when test="($level='19')"><xsl:value-of select="$tab19"/></xsl:when>
			<xsl:when test="($level='20')"><xsl:value-of select="$tab20"/></xsl:when>
			<xsl:when test="($level='21')"><xsl:value-of select="$tab21"/></xsl:when>
			<xsl:when test="($level='22')"><xsl:value-of select="$tab22"/></xsl:when>
			<xsl:when test="($level='23')"><xsl:value-of select="$tab23"/></xsl:when>
			<xsl:when test="($level='24')"><xsl:value-of select="$tab24"/></xsl:when>
			<xsl:when test="($level='25')"><xsl:value-of select="$tab25"/></xsl:when>
			<xsl:when test="($level='26')"><xsl:value-of select="$tab26"/></xsl:when>
			<xsl:when test="($level='27')"><xsl:value-of select="$tab27"/></xsl:when>
			<xsl:when test="($level='28')"><xsl:value-of select="$tab28"/></xsl:when>
			<xsl:when test="($level='29')"><xsl:value-of select="$tab29"/></xsl:when>
			<xsl:when test="($level='30')"><xsl:value-of select="$tab30"/></xsl:when>
			<xsl:otherwise></xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!--==========Case Lower==========-->
	<xsl:template name="CaseLower">
		<xsl:param name="value"/>
		<xsl:value-of select="translate($value,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz')"/>
	</xsl:template>

	<!--==========Case Upper==========-->
	<xsl:template name="CaseUpper">
		<xsl:param name="value"/>
		<xsl:value-of select="translate($value,'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ')"/>
	</xsl:template>

	<!--==========StripText==========-->
	<xsl:template name="StripText">
		<xsl:param name="value"/>
		<xsl:value-of select="translate($value,'#','')"/>
	</xsl:template>

	<!--==========QualifiedType=======-->
	<xsl:template name="QualifiedType">
		<xsl:param name="value"/>
		
		<xsl:variable name="text">
		<xsl:choose>
			<xsl:when test="(substring($value, 1, 3) = 'DOC')">DOC</xsl:when>
			<xsl:when test="(substring($value, 1, 3) = 'TAG')">TAG</xsl:when>
			<xsl:when test="(substring($value, 1, 6) = 'ENTITY')">ENTITY</xsl:when>
			<xsl:when test="(substring($value, 1, 9) = 'ATTRIBUTE')">ATTRIBUTE</xsl:when>
			<xsl:when test="(substring($value, 1, 6) = 'SYSCON')">SYSCON</xsl:when>
			<xsl:when test="(substring($value, 1, 3) = 'SYS')">SYS</xsl:when>
			<xsl:when test="(substring($value, 1, 4) = 'ATTR')">ATTR</xsl:when>
			<xsl:when test="(substring($value, 1, 4) = 'EVAL')">EVAL</xsl:when>
			<xsl:when test="(substring($value, 1, 4) = 'DATA')">DATA</xsl:when>
			<xsl:when test="(substring($value, 1, 4) = 'FORM')">FORM</xsl:when>
			<xsl:when test="(substring($value, 1, 4) = 'JAVA')">JAVA</xsl:when>
			<xsl:when test="(substring($value, 1, 5) = 'LABEL')">LABEL</xsl:when>
			<xsl:when test="(substring($value, 1, 5) = 'VALUE')">VALUE</xsl:when>
			<xsl:when test="(substring($value, 1, 5) = 'CONST')">CONST</xsl:when>
			<xsl:when test="(substring($value, 1, 5) = 'PARAM')">PARAM</xsl:when>
			<xsl:when test="(substring($value, 1, 6) = 'FINDID')">FINDID</xsl:when>
			<xsl:when test="(substring($value, 1, 6) = 'LISTID')">LISTID</xsl:when>
			<xsl:when test="(substring($value, 1, 6) = 'CONFIG')">CONFIG</xsl:when>
			<xsl:when test="(substring($value, 1, 6) = 'OBJECT')">OBJECT</xsl:when>
			<xsl:when test="(substring($value, 1, 8) = 'PROPERTY')">PROPERTY</xsl:when>
			<xsl:otherwise>NONE</xsl:otherwise>
		</xsl:choose>
		</xsl:variable>

		  <xsl:value-of select="$text"/>

		  <xsl:if test="$text!='NONE'">
				<xsl:if test="not(contains($value, '('))">
					<xsl:call-template name="Error">
						<xsl:with-param name="msg" select="'Qualified Type Missing Opening Parenthesis'"/>
						<xsl:with-param name="text" select="$value"/>
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="not(contains($value, ')'))">
					<xsl:call-template name="Error">
						<xsl:with-param name="msg" select="'Qualified Type Missing Closing Parenthesis'"/>
						<xsl:with-param name="text" select="$value"/>
					</xsl:call-template>
				</xsl:if>
		  </xsl:if>

	</xsl:template>

	<!--==========QualifiedValue=========-->
	<xsl:template name="QualifiedValue">
		<xsl:param name="value"/>

		<xsl:variable name="temp">
			<xsl:choose>
				<xsl:when test="(substring($value, 1, 3) = 'DOC')"><xsl:value-of select="substring($value, 5, string-length($value)-5)"/></xsl:when>
				<xsl:when test="(substring($value, 1, 3) = 'TAG')"><xsl:value-of select="substring($value, 5, string-length($value)-5)"/></xsl:when>
				<xsl:when test="(substring($value, 1, 6) = 'ENTITY')"><xsl:value-of select="substring($value, 8, string-length($value)-8)"/></xsl:when>
				<xsl:when test="(substring($value, 1, 9) = 'ATTRIBUTE')"><xsl:value-of select="substring($value, 11, string-length($value)-11)"/></xsl:when>
				<xsl:when test="(substring($value, 1, 6) = 'SYSCON')"><xsl:value-of select="substring($value, 8, string-length($value)-8)"/></xsl:when>
				<xsl:when test="(substring($value, 1, 3) = 'SYS')"><xsl:value-of select="substring($value, 5, string-length($value)-5)"/></xsl:when>
				<xsl:when test="(substring($value, 1, 4) = 'ATTR')"><xsl:value-of select="substring($value, 6, string-length($value)-6)"/></xsl:when>
				<xsl:when test="(substring($value, 1, 4) = 'EVAL')"><xsl:value-of select="substring($value, 6, string-length($value)-6)"/></xsl:when>
				<xsl:when test="(substring($value, 1, 4) = 'DATA')"><xsl:value-of select="substring($value, 6, string-length($value)-6)"/></xsl:when>
				<xsl:when test="(substring($value, 1, 4) = 'FORM')"><xsl:value-of select="substring($value, 6, string-length($value)-6)"/></xsl:when>
				<xsl:when test="(substring($value, 1, 4) = 'JAVA')"><xsl:value-of select="substring($value, 6, string-length($value)-6)"/></xsl:when>
				<xsl:when test="(substring($value, 1, 5) = 'LABEL')"><xsl:value-of select="substring($value, 7, string-length($value)-7)"/></xsl:when>
				<xsl:when test="(substring($value, 1, 5) = 'CONST')"><xsl:value-of select="substring($value, 7, string-length($value)-7)"/></xsl:when>
				<xsl:when test="(substring($value, 1, 5) = 'PARAM')"><xsl:value-of select="substring($value, 7, string-length($value)-7)"/></xsl:when>
				<xsl:when test="(substring($value, 1, 5) = 'VALUE')"><xsl:value-of select="substring($value, 7, string-length($value)-7)"/></xsl:when>
				<xsl:when test="(substring($value, 1, 6) = 'FINDID')"><xsl:value-of select="substring($value, 8, string-length($value)-8)"/></xsl:when>
				<xsl:when test="(substring($value, 1, 6) = 'LISTID')"><xsl:value-of select="substring($value, 8, string-length($value)-8)"/></xsl:when>
				<xsl:when test="(substring($value, 1, 6) = 'CONFIG')"><xsl:value-of select="substring($value, 8, string-length($value)-8)"/></xsl:when>
				<xsl:when test="(substring($value, 1, 6) = 'OBJECT')"><xsl:value-of select="substring($value, 8, string-length($value)-8)"/></xsl:when>
				<xsl:when test="(substring($value, 1, 8) = 'PROPERTY')"><xsl:value-of select="substring($value, 10, string-length($value)-10)"/></xsl:when>
				<xsl:otherwise>NONE</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		  <xsl:if test="$temp!='NONE'">
				<xsl:if test="not(contains($value, '('))">
					<xsl:call-template name="Error">
						<xsl:with-param name="msg" select="'Qualified Value Missing Opening Parenthesis'"/>
						<xsl:with-param name="text" select="$value"/>
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="not(contains($value, ')'))">
					<xsl:call-template name="Error">
						<xsl:with-param name="msg" select="'Qualified Value Missing Closing Parenthesis'"/>
						<xsl:with-param name="text" select="$value"/>
					</xsl:call-template>
				</xsl:if>
		  </xsl:if>

		<xsl:variable name="text">
		  <xsl:choose>
		  		<xsl:when test="$temp='NONE'"><xsl:value-of select="$value"/></xsl:when>
		  		<xsl:otherwise><xsl:value-of select="$temp"/></xsl:otherwise>
		  </xsl:choose>
		</xsl:variable>
		
		<xsl:choose>
			<xsl:when test="(substring($value, 1, 5) = 'CONST')"><xsl:value-of select="($text)"/></xsl:when>
			<xsl:when test="(substring($value, 1, 4) = 'JAVA')"><xsl:value-of select="($text)"/></xsl:when>
			<xsl:when test="contains($text, '.')"><xsl:value-of select="substring-after($text,'.')"/></xsl:when>
			<xsl:otherwise><xsl:value-of select="($text)"/></xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!--==========QualifiedPrefix=========-->
	<xsl:template name="QualifiedPrefix">
		<xsl:param name="value"/>

		<xsl:variable name="text">
			<xsl:choose>
				<xsl:when test="(substring($value, 1, 3) = 'DOC')"><xsl:value-of select="substring($value, 5, string-length($value)-5)"/></xsl:when>
				<xsl:when test="(substring($value, 1, 3) = 'TAG')"><xsl:value-of select="substring($value, 5, string-length($value)-5)"/></xsl:when>
				<xsl:when test="(substring($value, 1, 6) = 'ENTITY')"><xsl:value-of select="substring($value, 8, string-length($value)-8)"/></xsl:when>
				<xsl:when test="(substring($value, 1, 9) = 'ATTRIBUTE')"><xsl:value-of select="substring($value, 11, string-length($value)-11)"/></xsl:when>
				<xsl:when test="(substring($value, 1, 6) = 'SYSCON')"><xsl:value-of select="substring($value, 8, string-length($value)-8)"/></xsl:when>
				<xsl:when test="(substring($value, 1, 3) = 'SYS')"><xsl:value-of select="substring($value, 5, string-length($value)-5)"/></xsl:when>
				<xsl:when test="(substring($value, 1, 4) = 'ATTR')"><xsl:value-of select="substring($value, 6, string-length($value)-6)"/></xsl:when>
				<xsl:when test="(substring($value, 1, 4) = 'EVAL')"><xsl:value-of select="substring($value, 6, string-length($value)-6)"/></xsl:when>
				<xsl:when test="(substring($value, 1, 4) = 'FORM')"><xsl:value-of select="substring($value, 6, string-length($value)-6)"/></xsl:when>
				<xsl:when test="(substring($value, 1, 4) = 'DATA')"><xsl:value-of select="substring($value, 6, string-length($value)-6)"/></xsl:when>
				<xsl:when test="(substring($value, 1, 4) = 'JAVA')"><xsl:value-of select="substring($value, 6, string-length($value)-6)"/></xsl:when>
				<xsl:when test="(substring($value, 1, 5) = 'LABEL')"><xsl:value-of select="substring($value, 7, string-length($value)-7)"/></xsl:when>
				<xsl:when test="(substring($value, 1, 5) = 'VALUE')"><xsl:value-of select="substring($value, 7, string-length($value)-7)"/></xsl:when>
				<xsl:when test="(substring($value, 1, 5) = 'CONST')"><xsl:value-of select="substring($value, 7, string-length($value)-7)"/></xsl:when>
				<xsl:when test="(substring($value, 1, 5) = 'PARAM')"><xsl:value-of select="substring($value, 7, string-length($value)-7)"/></xsl:when>
				<xsl:when test="(substring($value, 1, 6) = 'FINDID')"><xsl:value-of select="substring($value, 8, string-length($value)-8)"/></xsl:when>
				<xsl:when test="(substring($value, 1, 6) = 'LISTID')"><xsl:value-of select="substring($value, 8, string-length($value)-8)"/></xsl:when>
				<xsl:when test="(substring($value, 1, 6) = 'CONFIG')"><xsl:value-of select="substring($value, 8, string-length($value)-8)"/></xsl:when>
				<xsl:when test="(substring($value, 1, 6) = 'OBJECT')"><xsl:value-of select="substring($value, 8, string-length($value)-8)"/></xsl:when>
				<xsl:when test="(substring($value, 1, 8) = 'PROPERTY')"><xsl:value-of select="substring($value, 10, string-length($value)-10)"/></xsl:when>
				<xsl:otherwise><xsl:value-of select="$value"/></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:choose>
			<xsl:when test="(substring($value, 1, 5) = 'CONST')"></xsl:when>
			<xsl:when test="(substring($value, 1, 4) = 'JAVA')"></xsl:when>
			<xsl:when test="contains($text, '.')"><xsl:value-of select="substring-before($text,'.')"/></xsl:when>
			<xsl:otherwise></xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	 <!--==================================================================-->
	 <xsl:template name="Error">
	 <!--==================================================================-->
		  <xsl:param name="msg"/>
		  <xsl:param name="text"/>
 		  <xsl:value-of select="concat('***ERROR ', $msg)"/>
		  <xsl:if test="string-length($text)&gt;0">
	  		  <xsl:value-of select="concat(' - ', $text)"/>
		  </xsl:if>
 		  <xsl:value-of select="' ***'"/>
	 </xsl:template>
	
</xsl:stylesheet>
