<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:include href="GenerateInclude.xsl"/>
	<xsl:include href="GenerateIncludeXSLTree.xsl"/>
	<xsl:include href="GenerateIncludeXSLScroll.xsl"/>

	<xsl:variable name="colcount" select="2"/>
	<xsl:variable name="labelwidth" select="160"/>
	<xsl:variable name="fieldwidth" select="440"/>
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
			<xsl:when test="$NavBar='blank'"/>
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
	<xsl:variable name="IsScroll">
		<xsl:choose>
			<xsl:when test="count(/Data/WTENTITY/WTWEBPAGE/WTCONTENT/descendant::*[name()='WTSCROLL'])&gt;0">true</xsl:when>
			<xsl:otherwise>false</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="IsScroll2">
		<xsl:choose>
			<xsl:when test="count(/Data/WTENTITY/WTWEBPAGE/WTCONTENT/descendant::*[name()='WTSCROLL2'])&gt;0">true</xsl:when>
			<xsl:otherwise>false</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="IsSlide">
		<xsl:choose>
			<xsl:when test="count(/Data/WTENTITY/WTWEBPAGE/WTCONTENT/descendant::*[name()='WTSLIDE'])&gt;0">true</xsl:when>
			<xsl:otherwise>false</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="IsSlide2">
		<xsl:choose>
			<xsl:when test="count(/Data/WTENTITY/WTWEBPAGE/WTCONTENT/descendant::*[name()='WTSLIDE2'])&gt;0">true</xsl:when>
			<xsl:otherwise>false</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="IsJQuery">
		<xsl:choose>
			<xsl:when test="$IsScroll='true' or $IsScroll2='true' or $IsSlide='true' or $IsSlide2='true'">true</xsl:when>
			<xsl:otherwise>false</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
  <xsl:variable name="IsOSMap">
    <xsl:choose>
      <xsl:when test="count(/Data/WTENTITY/WTWEBPAGE/WTCONTENT/descendant::*[name()='WTOSMAP'])&gt;0">true</xsl:when>
      <xsl:otherwise>false</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="IsOSMapFullScreen">
    <xsl:choose>
      <xsl:when test="count(/Data/WTENTITY/WTWEBPAGE/WTCONTENT/descendant::*[name()='WTOSMAP'][@fullscreen])&gt;0">true</xsl:when>
      <xsl:otherwise>false</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <!--==================================================================-->
	<xsl:template match="WTFRAME">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="ind2" select="concat($ind1, $tab1)"/>
		<xsl:variable name="indent2" select="$indent+1"/>
		<xsl:variable name="ind3" select="concat($ind2, $tab1)"/>
		<xsl:variable name="indent3" select="$indent2+1"/>
		<xsl:variable name="ind4" select="concat($ind3, $tab1)"/>
		<xsl:variable name="indent4" select="$indent3+1"/>
		<xsl:variable name="srctype"><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="@src"/></xsl:call-template></xsl:variable>
		<xsl:variable name="srctext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@src"/></xsl:call-template></xsl:variable>
		<xsl:variable name="srcentity"><xsl:call-template name="QualifiedPrefix"><xsl:with-param name="value" select="@src"/></xsl:call-template></xsl:variable>
		<xsl:variable name="widthtype"><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="@frmwidth"/></xsl:call-template></xsl:variable>
		<xsl:variable name="widthtext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@frmwidth"/></xsl:call-template></xsl:variable>
		<xsl:variable name="widthentity"><xsl:call-template name="QualifiedPrefix"><xsl:with-param name="value" select="@frmwidth"/></xsl:call-template></xsl:variable>
		<xsl:variable name="heighttype"><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="@frmheight"/></xsl:call-template></xsl:variable>
		<xsl:variable name="heighttext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@frmheight"/></xsl:call-template></xsl:variable>
		<xsl:variable name="heightentity"><xsl:call-template name="QualifiedPrefix"><xsl:with-param name="value" select="@frmheight"/></xsl:call-template></xsl:variable>

	 <!-- ***************** Error Checking *******************-->
	<xsl:if test="not(ancestor::WTSTATIC)">
		<xsl:if test="not(@col)">
			<xsl:call-template name="Error">
	     		<xsl:with-param name="msg" select="'WTFRAME Column Missing'"/>
	     		<xsl:with-param name="text" select="position()"/>
			</xsl:call-template>
		</xsl:if>
	 </xsl:if>
	 <xsl:if test="not(@src)">
	     <xsl:call-template name="Error">
	     	<xsl:with-param name="msg" select="'WTFRAME Source Missing'"/>
	     	<xsl:with-param name="text" select="@name"/>
	     </xsl:call-template>
	 </xsl:if>
	 <!--Test valid attributes-->
	 <xsl:for-each select="@*">
			<xsl:variable name="testcol">
				<xsl:call-template name="TestColAttr">
					<xsl:with-param name="attr" select="name()"/>
				</xsl:call-template>
			</xsl:variable>
		   <xsl:if test="$testcol='0'">
				<xsl:choose>
					<xsl:when test="name()='name'"/>
					<xsl:when test="name()='src'"/>
					<xsl:when test="name()='frmwidth'"/>
					<xsl:when test="name()='frmheight'"/>
					<xsl:when test="name()='label'"/>
					<xsl:when test="name()='scrolling'"/>
					<xsl:when test="name()='border'"/>
					<xsl:when test="name()='seamless'"/>
					<xsl:when test="name()='onload'"/>
					<xsl:when test="name()='frmstyle'"/>
					<xsl:when test="name()='frmclass'"/>
					<xsl:otherwise>
						 <xsl:call-template name="Error">
							  <xsl:with-param name="msg" select="'WTFRAME Invalid Attribute'"/>
							  <xsl:with-param name="text" select="name()"/>
	 					</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose>
		   </xsl:if>
	 </xsl:for-each>
	 <!-- ****************************************************-->

		<xsl:variable name="srcfile">
			<xsl:call-template name="GetValue">
				<xsl:with-param name="type" select="$srctype"/>
				<xsl:with-param name="text" select="$srctext"/>
				<xsl:with-param name="entity" select="$srcentity"/>
				<xsl:with-param name="hidden" select="true()"/>
			</xsl:call-template>
		</xsl:variable>

		<xsl:variable name="width">
			<xsl:if test="@frmwidth">
				<xsl:call-template name="GetValue">
					<xsl:with-param name="type" select="$widthtype"/>
					<xsl:with-param name="text" select="$widthtext"/>
					<xsl:with-param name="entity" select="$widthentity"/>
					<xsl:with-param name="hidden" select="true()"/>
				</xsl:call-template>
			</xsl:if>
      <xsl:if test="not(@frmwidth)">800</xsl:if>
      <xsl:if test="$widthpercent='true'">%</xsl:if>
    </xsl:variable>

		<xsl:variable name="height">
			<xsl:if test="@frmheight">
				<xsl:call-template name="GetValue">
					<xsl:with-param name="type" select="$heighttype"/>
					<xsl:with-param name="text" select="$heighttext"/>
					<xsl:with-param name="entity" select="$heightentity"/>
					<xsl:with-param name="hidden" select="true()"/>
				</xsl:call-template>
			</xsl:if>
			 <xsl:if test="not(@frmheight)">600</xsl:if>
		</xsl:variable>

		<!--begin the column tag-->
		<xsl:if test="@col">
			<xsl:apply-templates select="." mode="cell-begin">
				<xsl:with-param name="indent" select="$indent"/>
				<xsl:with-param name="wrap" select="true()"/>
				<xsl:with-param name="isfirst" select="position()=1"/>
			</xsl:apply-templates>
		</xsl:if>

		<!--embed frame-->
		<xsl:value-of select="concat($ind2, '&lt;xsl:element name=&quot;IFRAME&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;src&quot;&gt;', $srcfile, '&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;width&quot;&gt;', $width, '&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;height&quot;&gt;', $height, '&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;frmheight&quot;&gt;', $height, '&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:if test="@name">
			<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;id&quot;&gt;', @name, '&lt;/xsl:attribute&gt;', $cr)"/>
			<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;name&quot;&gt;', @name, '&lt;/xsl:attribute&gt;', $cr)"/>
		</xsl:if>
		<xsl:if test="@frmclass">
			<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;class&quot;&gt;', @frmclass, '&lt;/xsl:attribute&gt;', $cr)"/>
		</xsl:if>
		<xsl:if test="@frmstyle">
			<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;style&quot;&gt;', @frmstyle, '&lt;/xsl:attribute&gt;', $cr)"/>
		</xsl:if>
		<xsl:if test="@scrolling">
			<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;scrolling&quot;&gt;', @scrolling, '&lt;/xsl:attribute&gt;', $cr)"/>
		</xsl:if>
		<xsl:if test="@border">
			<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;frameborder&quot;&gt;', @border, '&lt;/xsl:attribute&gt;', $cr)"/>
		</xsl:if>
		<xsl:if test="@onload">
			<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;onload&quot;&gt;', @onload, '&lt;/xsl:attribute&gt;', $cr)"/>
		</xsl:if>

		<xsl:value-of select="concat($ind3, '&lt;xsl:element name=&quot;A&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;href&quot;&gt;', $srcfile, '&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:if test="@label">
			<xsl:call-template name="XSLLabelText">
			 	<xsl:with-param name="label" select="@label"/>
			 	<xsl:with-param name="indent" select="$indent4"/>
			 	<xsl:with-param name="newline" select="true()"/>
			</xsl:call-template>
		</xsl:if>
		<xsl:value-of select="concat($ind3, '&lt;/xsl:element&gt;', $cr)"/>

		<xsl:value-of select="concat($ind2, '&lt;/xsl:element&gt;', $cr)"/>

		<!--end the column tag-->
		<xsl:if test="@col">
			<xsl:apply-templates select="." mode="cell-end">
				<xsl:with-param name="indent" select="$indent"/>
			</xsl:apply-templates>
		</xsl:if>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTAUDIO">
		<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:variable name="ind1">
			<xsl:call-template name="Indent">
				<xsl:with-param name="level" select="$indent"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="ind2" select="concat($ind1, $tab1)"/>
		<xsl:variable name="ind3" select="concat($ind2, $tab1)"/>
		<xsl:variable name="ind4" select="concat($ind3, $tab1)"/>
		<xsl:variable name="ind5" select="concat($ind4, $tab1)"/>

		<!-- ***************** Error Checking *******************-->
		<xsl:if test="not(@col)">
			<xsl:call-template name="Error">
				<xsl:with-param name="msg" select="'WTAUDIO Column Missing'"/>
				<xsl:with-param name="text" select="position()"/>
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="not(@type)">
			<xsl:call-template name="Error">
				<xsl:with-param name="msg" select="'WTAUDIO Type Missing'"/>
				<xsl:with-param name="text" select="@name"/>
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="not(@src)">
			<xsl:call-template name="Error">
				<xsl:with-param name="msg" select="'WTAUDIO Source Missing'"/>
				<xsl:with-param name="text" select="@name"/>
			</xsl:call-template>
		</xsl:if>
		<!--Test valid attributes-->
		<xsl:for-each select="@*">
			<xsl:variable name="testcol">
				<xsl:call-template name="TestColAttr">
					<xsl:with-param name="attr" select="name()"/>
				</xsl:call-template>
			</xsl:variable>
			<xsl:if test="$testcol='0'">
				<xsl:choose>
					<xsl:when test="name()='type'"/>
					<xsl:when test="name()='src'"/>
					<xsl:otherwise>
						<xsl:call-template name="Error">
							<xsl:with-param name="msg" select="'WTAUDIO Invalid Attribute'"/>
							<xsl:with-param name="text" select="name()"/>
						</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:if>
		</xsl:for-each>
		<!-- ****************************************************-->

		<!--begin the column tag-->
		<xsl:apply-templates select="." mode="cell-begin">
			<xsl:with-param name="indent" select="$indent"/>
		</xsl:apply-templates>

		<!--embed audio-->
		<xsl:value-of select="concat($ind2, '&lt;xsl:element name=&quot;AUDIO&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;controls&quot;&gt;controls&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;autoplay&quot;&gt;autoplay&lt;/xsl:attribute&gt;', $cr)"/>

		<xsl:value-of select="concat($ind3, '&lt;xsl:element name=&quot;SOURCE&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;type&quot;&gt;audio/mpeg&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;src&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($ind5, '&lt;xsl:value-of select=&quot;/DATA/TXN/PTSLESSON/@mediaurl&quot;/&gt;', $cr)"/>
		<xsl:value-of select="concat($ind4, '&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($ind3, '&lt;/xsl:element&gt;', $cr)"/>

		<xsl:value-of select="concat($ind2, '&lt;/xsl:element&gt;', $cr)"/>

		<!--end the column tag-->
		<xsl:apply-templates select="." mode="cell-end">
			<xsl:with-param name="indent" select="$indent"/>
		</xsl:apply-templates>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTVIDEO">
		<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:variable name="ind1">
			<xsl:call-template name="Indent">
				<xsl:with-param name="level" select="$indent"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="ind2" select="concat($ind1, $tab1)"/>
		<xsl:variable name="ind3" select="concat($ind2, $tab1)"/>
		<xsl:variable name="ind4" select="concat($ind3, $tab1)"/>
		<xsl:variable name="ind5" select="concat($ind4, $tab1)"/>
		<xsl:variable name="widthtype">
			<xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="@imgwidth"/></xsl:call-template>
		</xsl:variable>
		<xsl:variable name="widthtext">
			<xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@imgwidth"/></xsl:call-template>
		</xsl:variable>
		<xsl:variable name="widthentity">
			<xsl:call-template name="QualifiedPrefix"><xsl:with-param name="value" select="@imgwidth"/></xsl:call-template>
		</xsl:variable>
		<xsl:variable name="heighttype">
			<xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="@imgheight"/></xsl:call-template>
		</xsl:variable>
		<xsl:variable name="heighttext">
			<xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@imgheight"/></xsl:call-template>
		</xsl:variable>
		<xsl:variable name="heightentity">
			<xsl:call-template name="QualifiedPrefix"><xsl:with-param name="value" select="@imgheight"/></xsl:call-template>
		</xsl:variable>

		<!-- ***************** Error Checking *******************-->
		<xsl:if test="not(@col)">
			<xsl:call-template name="Error">
				<xsl:with-param name="msg" select="'WTVIDEO Column Missing'"/>
				<xsl:with-param name="text" select="position()"/>
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="not(@type)">
			<xsl:call-template name="Error">
				<xsl:with-param name="msg" select="'WTVIDEO Type Missing'"/>
				<xsl:with-param name="text" select="@name"/>
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="not(@src)">
			<xsl:call-template name="Error">
				<xsl:with-param name="msg" select="'WTVIDEO Source Missing'"/>
				<xsl:with-param name="text" select="@name"/>
			</xsl:call-template>
		</xsl:if>
		<!--Test valid attributes-->
		<xsl:for-each select="@*">
			<xsl:variable name="testcol">
				<xsl:call-template name="TestColAttr">
					<xsl:with-param name="attr" select="name()"/>
				</xsl:call-template>
			</xsl:variable>
			<xsl:if test="$testcol='0'">
				<xsl:choose>
					<xsl:when test="name()='type'"/>
					<xsl:when test="name()='src'"/>
					<xsl:when test="name()='imgwidth'"/>
					<xsl:when test="name()='imgheight'"/>
					<xsl:otherwise>
						<xsl:call-template name="Error">
							<xsl:with-param name="msg" select="'WTVIDEO Invalid Attribute'"/>
							<xsl:with-param name="text" select="name()"/>
						</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:if>
		</xsl:for-each>
		<!-- ****************************************************-->

		<xsl:variable name="width">
			<xsl:call-template name="GetValue">
				<xsl:with-param name="type" select="$widthtype"/>
				<xsl:with-param name="text" select="$widthtext"/>
				<xsl:with-param name="entity" select="$widthentity"/>
				<xsl:with-param name="hidden" select="true()"/>
			</xsl:call-template>
		</xsl:variable>

		<xsl:variable name="height">
			<xsl:call-template name="GetValue">
				<xsl:with-param name="type" select="$heighttype"/>
				<xsl:with-param name="text" select="$heighttext"/>
				<xsl:with-param name="entity" select="$heightentity"/>
				<xsl:with-param name="hidden" select="true()"/>
			</xsl:call-template>
		</xsl:variable>

		<!--begin the column tag-->
		<xsl:apply-templates select="." mode="cell-begin">
			<xsl:with-param name="indent" select="$indent"/>
		</xsl:apply-templates>

		<!--embed audio-->
		<xsl:value-of select="concat($ind2, '&lt;xsl:element name=&quot;VIDEO&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;controls&quot;&gt;controls&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;autoplay&quot;&gt;autoplay&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;width&quot;&gt;', $width, '&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;height&quot;&gt;', $height, '&lt;/xsl:attribute&gt;', $cr)"/>

		<xsl:value-of select="concat($ind3, '&lt;xsl:element name=&quot;SOURCE&quot;&gt;', $cr)"/>

		<xsl:if test="@type='mp4'">
			<xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;type&quot;&gt;video/mp4&lt;/xsl:attribute&gt;', $cr)"/>
		</xsl:if>
		<xsl:if test="@type='ogg'">
			<xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;type&quot;&gt;video/ogg&lt;/xsl:attribute&gt;', $cr)"/>
		</xsl:if>
		<xsl:if test="@type='webm'">
			<xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;type&quot;&gt;video/webm&lt;/xsl:attribute&gt;', $cr)"/>
		</xsl:if>
		<xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;src&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($ind5, '&lt;xsl:value-of select=&quot;/DATA/TXN/PTSLESSON/@mediaurl&quot;/&gt;', $cr)"/>
		<xsl:value-of select="concat($ind4, '&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($ind3, '&lt;/xsl:element&gt;', $cr)"/>

		<xsl:value-of select="concat($ind2, '&lt;/xsl:element&gt;', $cr)"/>

		<!--end the column tag-->
		<xsl:apply-templates select="." mode="cell-end">
			<xsl:with-param name="indent" select="$indent"/>
		</xsl:apply-templates>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTVIDEO[@type='media']">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="ind2" select="concat($ind1, $tab1)"/>
		<xsl:variable name="indent2" select="$indent+1"/>
		<xsl:variable name="ind3" select="concat($ind2, $tab1)"/>
		<xsl:variable name="indent3" select="$indent2+1"/>
		<xsl:variable name="ind4" select="concat($ind3, $tab1)"/>
		<xsl:variable name="srctype"><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="@src"/></xsl:call-template></xsl:variable>
		<xsl:variable name="srctext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@src"/></xsl:call-template></xsl:variable>
		<xsl:variable name="srcentity"><xsl:call-template name="QualifiedPrefix"><xsl:with-param name="value" select="@src"/></xsl:call-template></xsl:variable>
		<xsl:variable name="widthtype"><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="@imgwidth"/></xsl:call-template></xsl:variable>
		<xsl:variable name="widthtext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@imgwidth"/></xsl:call-template></xsl:variable>
		<xsl:variable name="widthentity"><xsl:call-template name="QualifiedPrefix"><xsl:with-param name="value" select="@imgwidth"/></xsl:call-template></xsl:variable>
		<xsl:variable name="heighttype"><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="@imgheight"/></xsl:call-template></xsl:variable>
		<xsl:variable name="heighttext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@imgheight"/></xsl:call-template></xsl:variable>
		<xsl:variable name="heightentity"><xsl:call-template name="QualifiedPrefix"><xsl:with-param name="value" select="@imgheight"/></xsl:call-template></xsl:variable>

	 <!-- ***************** Error Checking *******************-->
	 <xsl:if test="not(@col)">
	     <xsl:call-template name="Error">
	     	<xsl:with-param name="msg" select="'WTVIDEO Column Missing'"/>
	     	<xsl:with-param name="text" select="position()"/>
	     </xsl:call-template>
	 </xsl:if>
	 <xsl:if test="not(@type)">
	     <xsl:call-template name="Error">
	     	<xsl:with-param name="msg" select="'WTVIDEO Type Missing'"/>
	     	<xsl:with-param name="text" select="@name"/>
	     </xsl:call-template>
	 </xsl:if>
	 <xsl:if test="not(@src)">
	     <xsl:call-template name="Error">
	     	<xsl:with-param name="msg" select="'WTVIDEO Source Missing'"/>
	     	<xsl:with-param name="text" select="@name"/>
	     </xsl:call-template>
	 </xsl:if>
	 <!--Test valid attributes-->
	 <xsl:for-each select="@*">
			<xsl:variable name="testcol">
				<xsl:call-template name="TestColAttr">
					<xsl:with-param name="attr" select="name()"/>
				</xsl:call-template>
			</xsl:variable>
		   <xsl:if test="$testcol='0'">
				<xsl:choose>
					<xsl:when test="name()='type'"/>
					<xsl:when test="name()='src'"/>
					<xsl:when test="name()='path'"/>
					<xsl:when test="name()='imgwidth'"/>
					<xsl:when test="name()='imgheight'"/>
					<xsl:when test="name()='stretch'"/>
					<xsl:otherwise>
						 <xsl:call-template name="Error">
							  <xsl:with-param name="msg" select="'WTVIDEO Invalid Attribute'"/>
							  <xsl:with-param name="text" select="name()"/>
	 					</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose>
		   </xsl:if>
	 </xsl:for-each>
	 <!-- ****************************************************-->

		<xsl:variable name="srcfile">
			<xsl:if test="@path">
				<xsl:value-of select="concat( @path, '\')"/>
			</xsl:if>
			<xsl:call-template name="GetValue">
				<xsl:with-param name="type" select="$srctype"/>
				<xsl:with-param name="text" select="$srctext"/>
				<xsl:with-param name="entity" select="$srcentity"/>
				<xsl:with-param name="hidden" select="true()"/>
			</xsl:call-template>
		</xsl:variable>

		<xsl:variable name="width">
			<xsl:call-template name="GetValue">
				<xsl:with-param name="type" select="$widthtype"/>
				<xsl:with-param name="text" select="$widthtext"/>
				<xsl:with-param name="entity" select="$widthentity"/>
				<xsl:with-param name="hidden" select="true()"/>
			</xsl:call-template>
		</xsl:variable>

		<xsl:variable name="height">
			<xsl:call-template name="GetValue">
				<xsl:with-param name="type" select="$heighttype"/>
				<xsl:with-param name="text" select="$heighttext"/>
				<xsl:with-param name="entity" select="$heightentity"/>
				<xsl:with-param name="hidden" select="true()"/>
			</xsl:call-template>
		</xsl:variable>

		<!--begin the column tag-->
		<xsl:apply-templates select="." mode="cell-begin">
			<xsl:with-param name="indent" select="$indent"/>
		</xsl:apply-templates>

		<!--embed video-->
		<xsl:value-of select="concat($ind2, '&lt;xsl:element name=&quot;OBJECT&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;width&quot;&gt;', $width, '&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;height&quot;&gt;', $height, '&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;classid&quot;&gt;clsid:6BF52A52-394A-11D3-B153-00C04F79FAA6&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;id&quot;&gt;WMP&lt;/xsl:attribute&gt;', $cr)"/>

		<xsl:value-of select="concat($ind3, '&lt;xsl:element name=&quot;PARAM&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;name&quot;&gt;Name&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;value&quot;&gt;WMP1&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($ind3, '&lt;/xsl:element&gt;', $cr)"/>

		<xsl:value-of select="concat($ind3, '&lt;xsl:element name=&quot;PARAM&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;name&quot;&gt;URL&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;value&quot;&gt;', $srcfile, '&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($ind3, '&lt;/xsl:element&gt;', $cr)"/>

		<xsl:if test="@stretch">
			<xsl:value-of select="concat($ind3, '&lt;xsl:element name=&quot;PARAM&quot;&gt;', $cr)"/>
			<xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;name&quot;&gt;stretchToFit&lt;/xsl:attribute&gt;', $cr)"/>
			<xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;value&quot;&gt;1&lt;/xsl:attribute&gt;', $cr)"/>
			<xsl:value-of select="concat($ind3, '&lt;/xsl:element&gt;', $cr)"/>
		</xsl:if>

		<!-- INCLUDE EMBED DATA FOR OLDER BROWSERS -->
		<xsl:value-of select="concat($ind3, '&lt;xsl:element name=&quot;EMBED&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;src&quot;&gt;', $srcfile, '&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;align&quot;&gt;center&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;border&quot;&gt;0&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;width&quot;&gt;', $width, '&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;height&quot;&gt;', $height, '&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;type&quot;&gt;application/x-mplayer2&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;pluginspage&quot;&gt;http://www.microsoft.com/windows/windowsmedia/download/default.asp&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;name&quot;&gt;MediaPlayer&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;showstatusbar&quot;&gt;1&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;showpositioncontrols&quot;&gt;0&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($ind3, '&lt;/xsl:element&gt;', $cr)"/>

		<xsl:value-of select="concat($ind2, '&lt;/xsl:element&gt;', $cr)"/>

		<!--end the column tag-->
		<xsl:apply-templates select="." mode="cell-end">
			<xsl:with-param name="indent" select="$indent"/>
		</xsl:apply-templates>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTVIDEO[@type='real']">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="ind2" select="concat($ind1, $tab1)"/>
		<xsl:variable name="indent2" select="$indent+1"/>
		<xsl:variable name="ind3" select="concat($ind2, $tab1)"/>
		<xsl:variable name="indent3" select="$indent2+1"/>
		<xsl:variable name="srctype"><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="@src"/></xsl:call-template></xsl:variable>
		<xsl:variable name="srctext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@src"/></xsl:call-template></xsl:variable>
		<xsl:variable name="srcentity"><xsl:call-template name="QualifiedPrefix"><xsl:with-param name="value" select="@src"/></xsl:call-template></xsl:variable>
		<xsl:variable name="widthtype"><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="@imgwidth"/></xsl:call-template></xsl:variable>
		<xsl:variable name="widthtext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@imgwidth"/></xsl:call-template></xsl:variable>
		<xsl:variable name="widthentity"><xsl:call-template name="QualifiedPrefix"><xsl:with-param name="value" select="@imgwidth"/></xsl:call-template></xsl:variable>
		<xsl:variable name="heighttype"><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="@imgheight"/></xsl:call-template></xsl:variable>
		<xsl:variable name="heighttext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@imgheight"/></xsl:call-template></xsl:variable>
		<xsl:variable name="heightentity"><xsl:call-template name="QualifiedPrefix"><xsl:with-param name="value" select="@imgheight"/></xsl:call-template></xsl:variable>

	 <!-- ***************** Error Checking *******************-->
	 <xsl:if test="not(@col)">
	     <xsl:call-template name="Error">
	     	<xsl:with-param name="msg" select="'WTVIDEO Column Missing'"/>
	     	<xsl:with-param name="text" select="position()"/>
	     </xsl:call-template>
	 </xsl:if>
	 <xsl:if test="not(@type)">
	     <xsl:call-template name="Error">
	     	<xsl:with-param name="msg" select="'WTVIDEO Type Missing'"/>
	     	<xsl:with-param name="text" select="@name"/>
	     </xsl:call-template>
	 </xsl:if>
	 <xsl:if test="not(@src)">
	     <xsl:call-template name="Error">
	     	<xsl:with-param name="msg" select="'WTVIDEO Source Missing'"/>
	     	<xsl:with-param name="text" select="@name"/>
	     </xsl:call-template>
	 </xsl:if>
	 <!--Test valid attributes-->
	 <xsl:for-each select="@*">
			<xsl:variable name="testcol">
				<xsl:call-template name="TestColAttr">
					<xsl:with-param name="attr" select="name()"/>
				</xsl:call-template>
			</xsl:variable>
		   <xsl:if test="$testcol='0'">
				<xsl:choose>
					<xsl:when test="name()='type'"/>
					<xsl:when test="name()='src'"/>
					<xsl:when test="name()='path'"/>
					<xsl:when test="name()='imgwidth'"/>
					<xsl:when test="name()='imgheight'"/>
					<xsl:when test="name()='status'"/>
					<xsl:when test="name()='control'"/>
					<xsl:when test="name()='loop'"/>
					<xsl:otherwise>
						 <xsl:call-template name="Error">
							  <xsl:with-param name="msg" select="'WTVIDEO Invalid Attribute'"/>
							  <xsl:with-param name="text" select="name()"/>
	 					</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose>
		   </xsl:if>
	 </xsl:for-each>
	 <!-- ****************************************************-->

		<xsl:variable name="srcfile">
			<xsl:if test="@path">
				<xsl:value-of select="concat( @path, '\')"/>
			</xsl:if>
			<xsl:call-template name="GetValue">
				<xsl:with-param name="type" select="$srctype"/>
				<xsl:with-param name="text" select="$srctext"/>
				<xsl:with-param name="entity" select="$srcentity"/>
				<xsl:with-param name="hidden" select="true()"/>
			</xsl:call-template>
		</xsl:variable>

		<xsl:variable name="width">
			<xsl:call-template name="GetValue">
				<xsl:with-param name="type" select="$widthtype"/>
				<xsl:with-param name="text" select="$widthtext"/>
				<xsl:with-param name="entity" select="$widthentity"/>
				<xsl:with-param name="hidden" select="true()"/>
			</xsl:call-template>
		</xsl:variable>

		<xsl:variable name="height">
			<xsl:call-template name="GetValue">
				<xsl:with-param name="type" select="$heighttype"/>
				<xsl:with-param name="text" select="$heighttext"/>
				<xsl:with-param name="entity" select="$heightentity"/>
				<xsl:with-param name="hidden" select="true()"/>
			</xsl:call-template>
		</xsl:variable>

		<!--begin the column tag-->
		<xsl:apply-templates select="." mode="cell-begin">
			<xsl:with-param name="indent" select="$indent"/>
		</xsl:apply-templates>

		<!--embed video-->
		<xsl:value-of select="concat($ind2, '&lt;xsl:element name=&quot;EMBED&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;src&quot;&gt;', $srcfile, '&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;type&quot;&gt;audio/x-pn-realaudio-plugin&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;width&quot;&gt;', $width, '&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;height&quot;&gt;', $height, '&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;controls&quot;&gt;ImageWindow&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;autostart&quot;&gt;false&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:if test="@loop">
			<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;loop&quot;&gt;true&lt;/xsl:attribute&gt;', $cr)"/>
		</xsl:if>
		<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;console&quot;&gt;Clip1&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;pluginspace&quot;&gt;http://www.real.com/player/index.html?src=404&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($ind2, '&lt;/xsl:element&gt;', $cr)"/>
		<xsl:value-of select="concat($ind2, '&lt;xsl:element name=&quot;BR&quot;/&gt;', $cr)"/>


		<!--embed status bar-->
		<xsl:if test = "(@status='true')">
			<xsl:value-of select="concat($ind2, '&lt;xsl:element name=&quot;EMBED&quot;&gt;', $cr)"/>
			<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;src&quot;&gt;', $srcfile, '&lt;/xsl:attribute&gt;', $cr)"/>
			<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;type&quot;&gt;audio/x-pn-realaudio-plugin&lt;/xsl:attribute&gt;', $cr)"/>
			<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;width&quot;&gt;', $width, '&lt;/xsl:attribute&gt;', $cr)"/>
			<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;height&quot;&gt;30&lt;/xsl:attribute&gt;', $cr)"/>
			<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;controls&quot;&gt;StatusBar&lt;/xsl:attribute&gt;', $cr)"/>
			<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;autostart&quot;&gt;false&lt;/xsl:attribute&gt;', $cr)"/>
			<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;console&quot;&gt;Clip1&lt;/xsl:attribute&gt;', $cr)"/>
			<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;pluginspace&quot;&gt;http://www.real.com/player/index.html?src=404&lt;/xsl:attribute&gt;', $cr)"/>
			<xsl:value-of select="concat($ind2, '&lt;/xsl:element&gt;', $cr)"/>
			<xsl:value-of select="concat($ind2, '&lt;xsl:element name=&quot;BR&quot;/&gt;', $cr)"/>
		</xsl:if>

		<!--embed control panel-->
		<xsl:if test = "(@control='true')">
			<xsl:value-of select="concat($ind2, '&lt;xsl:element name=&quot;EMBED&quot;&gt;', $cr)"/>
			<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;src&quot;&gt;', $srcfile, '&lt;/xsl:attribute&gt;', $cr)"/>
			<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;type&quot;&gt;audio/x-pn-realaudio-plugin&lt;/xsl:attribute&gt;', $cr)"/>
			<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;width&quot;&gt;', $width, '&lt;/xsl:attribute&gt;', $cr)"/>
			<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;height&quot;&gt;30&lt;/xsl:attribute&gt;', $cr)"/>
			<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;controls&quot;&gt;ControlPanel&lt;/xsl:attribute&gt;', $cr)"/>
			<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;autostart&quot;&gt;true&lt;/xsl:attribute&gt;', $cr)"/>
			<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;console&quot;&gt;Clip1&lt;/xsl:attribute&gt;', $cr)"/>
			<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;pluginspace&quot;&gt;http://www.real.com/player/index.html?src=404&lt;/xsl:attribute&gt;', $cr)"/>
			<xsl:value-of select="concat($ind2, '&lt;/xsl:element&gt;', $cr)"/>
			<xsl:value-of select="concat($ind2, '&lt;xsl:element name=&quot;BR&quot;/&gt;', $cr)"/>
		</xsl:if>

		<!--end the column tag-->
		<xsl:apply-templates select="." mode="cell-end">
			<xsl:with-param name="indent" select="$indent"/>
		</xsl:apply-templates>
	</xsl:template>


	<!--==================================================================-->
	<xsl:template match="WTTRANSLATE">
		<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="ind2" select="concat($ind1, $tab1)"/>

		<xsl:if test="$translate='true'">
			<xsl:if test="/Data/WTPAGE/@translate='google' or /Data/WTENTITY/WTWEBPAGE/@translate='google'">
				<xsl:value-of select="concat($ind1, '&lt;xsl:element name=&quot;div&quot;&gt;', $cr)"/>
				<xsl:value-of select="concat($ind2, '&lt;xsl:attribute name=&quot;id&quot;&gt;google_translate_element&lt;/xsl:attribute&gt;', $cr)"/>
				<xsl:value-of select="concat($ind2, '&lt;xsl:text&gt; &lt;/xsl:text&gt;', $cr)"/>
				<xsl:value-of select="concat($ind1, '&lt;/xsl:element&gt;', $cr)"/>
			</xsl:if>
		</xsl:if>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template name="DoTranslate">
		<!--==================================================================-->
		<xsl:if test="/Data/WTPAGE/@translate='google' or /Data/WTENTITY/WTWEBPAGE/@translate='google'">
			<xsl:variable name="style">
				<xsl:choose>
					<xsl:when test="/Data/WTENTITY/WTWEBPAGE/@translate-style">
						<xsl:value-of select="/Data/WTENTITY/WTWEBPAGE/@translate-style"/>
					</xsl:when>
					<xsl:when test="/Data/WTPAGE/@translate-style">
						<xsl:value-of select="/Data/WTPAGE/@translate-style"/>
					</xsl:when>
					<xsl:otherwise></xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			<xsl:value-of select="concat($tab0, '&lt;xsl:element name=&quot;script&quot;&gt;', $cr)"/>
			<xsl:value-of select="concat($tab1, '&lt;xsl:attribute name=&quot;type&quot;&gt;text/javascript&lt;/xsl:attribute&gt;', $cr)"/>
			<xsl:value-of select="concat($tab1, '&lt;xsl:text&gt;function googleTranslateElementInit() {&lt;/xsl:text&gt;', $cr)"/>

			<xsl:if test="$style=''">
				<xsl:value-of select="concat($tab1, '&lt;xsl:text&gt;new google.translate.TranslateElement({pageLanguage:', $apos, 'en', $apos, '}, ', $apos, 'google_translate_element', $apos, ');&lt;/xsl:text&gt;', $cr)"/>
			</xsl:if>
			<xsl:if test="not($style='')">
				<xsl:value-of select="concat($tab1, '&lt;xsl:text&gt;new google.translate.TranslateElement({pageLanguage:', $apos, 'en', $apos, ', ', $style, '}, ', $apos, 'google_translate_element', $apos, ');&lt;/xsl:text&gt;', $cr)"/>
			</xsl:if>

			<xsl:value-of select="concat($tab1, '&lt;xsl:text&gt;}&lt;/xsl:text&gt;', $cr)"/>
			<xsl:value-of select="concat($tab0, '&lt;/xsl:element&gt;', $cr)"/>

			<xsl:value-of select="concat($tab0, '&lt;xsl:element name=&quot;script&quot;&gt;', $cr)"/>
			<xsl:value-of select="concat($tab1, '&lt;xsl:attribute name=&quot;type&quot;&gt;text/javascript&lt;/xsl:attribute&gt;', $cr)"/>
			<xsl:value-of select="concat($tab1, '&lt;xsl:attribute name=&quot;src&quot;&gt;//translate.google.com/translate_a/element.js?cb=googleTranslateElementInit&lt;/xsl:attribute&gt;', $cr)"/>
			<xsl:value-of select="concat($tab0, '&lt;/xsl:element&gt;', $cr)"/>
		</xsl:if>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTFLASH">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="ind2" select="concat($ind1, $tab1)"/>
		<xsl:variable name="indent2" select="$indent+1"/>
		<xsl:variable name="ind3" select="concat($ind2, $tab1)"/>
		<xsl:variable name="indent3" select="$indent2+1"/>
		<xsl:variable name="ind4" select="concat($ind3, $tab1)"/>
		<xsl:variable name="srctype"><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="@src"/></xsl:call-template></xsl:variable>
		<xsl:variable name="srctext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@src"/></xsl:call-template></xsl:variable>
		<xsl:variable name="srcentity"><xsl:call-template name="QualifiedPrefix"><xsl:with-param name="value" select="@src"/></xsl:call-template></xsl:variable>
		<xsl:variable name="widthtype"><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="@imgwidth"/></xsl:call-template></xsl:variable>
		<xsl:variable name="widthtext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@imgwidth"/></xsl:call-template></xsl:variable>
		<xsl:variable name="widthentity"><xsl:call-template name="QualifiedPrefix"><xsl:with-param name="value" select="@imgwidth"/></xsl:call-template></xsl:variable>
		<xsl:variable name="heighttype"><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="@imgheight"/></xsl:call-template></xsl:variable>
		<xsl:variable name="heighttext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@imgheight"/></xsl:call-template></xsl:variable>
		<xsl:variable name="heightentity"><xsl:call-template name="QualifiedPrefix"><xsl:with-param name="value" select="@imgheight"/></xsl:call-template></xsl:variable>

	 <!-- ***************** Error Checking *******************-->
	 <xsl:if test="not(@col)">
	     <xsl:call-template name="Error">
	     	<xsl:with-param name="msg" select="'WTFLASH Column Missing'"/>
	     	<xsl:with-param name="text" select="position()"/>
	     </xsl:call-template>
	 </xsl:if>
	 <!--Test valid attributes-->
	 <xsl:for-each select="@*">
			<xsl:variable name="testcol">
				<xsl:call-template name="TestColAttr">
					<xsl:with-param name="attr" select="name()"/>
				</xsl:call-template>
			</xsl:variable>
		   <xsl:if test="$testcol='0'">
				<xsl:choose>
					<xsl:when test="name()='name'"/>
					<xsl:when test="name()='src'"/>
					<xsl:when test="name()='path'"/>
					<xsl:when test="name()='version'"/>
					<xsl:when test="name()='install'"/>
					<xsl:when test="name()='imgwidth'"/>
					<xsl:when test="name()='imgheight'"/>
					<xsl:when test="name()='color'"/>
					<xsl:otherwise>
						 <xsl:call-template name="Error">
							  <xsl:with-param name="msg" select="'WTFLASH Invalid Attribute'"/>
							  <xsl:with-param name="text" select="name()"/>
	 					</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose>
		   </xsl:if>
	 </xsl:for-each>
	 <!-- ****************************************************-->

		<xsl:variable name="srcfile">
			<xsl:if test="@path">
				<xsl:value-of select="concat( @path, '\')"/>
			</xsl:if>
			<xsl:call-template name="GetValue">
				<xsl:with-param name="type" select="$srctype"/>
				<xsl:with-param name="text" select="$srctext"/>
				<xsl:with-param name="entity" select="$srcentity"/>
				<xsl:with-param name="hidden" select="true()"/>
			</xsl:call-template>
		</xsl:variable>

		<xsl:variable name="width">
			<xsl:call-template name="GetValue">
				<xsl:with-param name="type" select="$widthtype"/>
				<xsl:with-param name="text" select="$widthtext"/>
				<xsl:with-param name="entity" select="$widthentity"/>
				<xsl:with-param name="hidden" select="true()"/>
			</xsl:call-template>
		</xsl:variable>

		<xsl:variable name="height">
			<xsl:call-template name="GetValue">
				<xsl:with-param name="type" select="$heighttype"/>
				<xsl:with-param name="text" select="$heighttext"/>
				<xsl:with-param name="entity" select="$heightentity"/>
				<xsl:with-param name="hidden" select="true()"/>
			</xsl:call-template>
		</xsl:variable>
		
		<xsl:variable name="name">
			<xsl:if test="@name"><xsl:value-of select="@name"/></xsl:if>
			<xsl:if test="not(@name)">FlashContent</xsl:if>
		</xsl:variable>
		<xsl:variable name="version">
			<xsl:if test="@version"><xsl:value-of select="@version"/></xsl:if>
			<xsl:if test="not(@version)">9.0.0</xsl:if>
		</xsl:variable>
		<xsl:variable name="install">
			<xsl:if test="@install"><xsl:value-of select="concat('&quot;', @install, '&quot;')"/></xsl:if>
			<xsl:if test="not(@install)">false</xsl:if>
		</xsl:variable>

		<!--begin the column tag-->
		<xsl:apply-templates select="." mode="cell-begin">
			<xsl:with-param name="indent" select="$indent"/>
		</xsl:apply-templates>

		<!--embed flash-->
		<xsl:value-of select="concat($ind2, '&lt;script type=&quot;text/javascript&quot;&gt;', $cr)"/>
		
		<xsl:value-of select="concat($ind3, 'var flashvars = {')"/>
		<xsl:apply-templates select="WTVARIABLE"/>
		<xsl:value-of select="concat('};', $cr)"/>
		
		<xsl:value-of select="concat($ind3, 'var params = {')"/>
		<xsl:apply-templates select="WTPARAM"/>
		<xsl:value-of select="concat('};', $cr)"/>
		
		<xsl:value-of select="concat($ind3, 'var attributes = {')"/>
		<xsl:apply-templates select="WTATTRIBUTE"/>
		<xsl:value-of select="concat('};', $cr)"/>
		
		<xsl:value-of select="concat($ind3, 'swfobject.embedSWF(&quot;', @src, '&quot;, &quot;' $name, '&quot;, &quot;', $width, '&quot;, &quot;', $height, '&quot;, &quot;', $version, '&quot;, ', $install, ', flashvars, params, attributes);', $cr)"/>
		<xsl:value-of select="concat($ind2, '&lt;/script&gt;', $cr)"/>

		<xsl:value-of select="concat($ind2, '&lt;div id=&quot;', $name, '&quot;&gt;', $cr)"/>
		<xsl:apply-templates select="WTCODEGROUP">
			<xsl:with-param name="indent" select="$indent2"/>
		</xsl:apply-templates>
		<xsl:value-of select="concat($ind2, '&lt;/div&gt;', $cr)"/>

		<!--end the column tag-->
		<xsl:apply-templates select="." mode="cell-end">
			<xsl:with-param name="indent" select="$indent"/>
		</xsl:apply-templates>
	</xsl:template>

	 <!--==================================================================-->
	 <xsl:template match="WTFLASH/WTVARIABLE">
	 <!--==================================================================-->
		  <xsl:variable name="valuetype"><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>
		  <xsl:variable name="valuetext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>
		  <xsl:variable name="valueentity"><xsl:call-template name="QualifiedPrefix"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>

		<!-- ***************** Error Checking *******************-->
		<xsl:if test="not(@name)">
			<xsl:call-template name="Error">
	     		<xsl:with-param name="msg" select="'WTFLASH/WTVARIABLE Name Missing'"/>
	     		<xsl:with-param name="text" select="position()"/>
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="not(@value)">
			<xsl:call-template name="Error">
	     		<xsl:with-param name="msg" select="'WTFLASH/WTVARIABLE Value Missing'"/>
	     		<xsl:with-param name="text" select="@name"/>
			</xsl:call-template>
		</xsl:if>
		<!--Test valid attributes-->
		<xsl:for-each select="@*">
			<xsl:choose>
					<xsl:when test="name()='name'"/>
					<xsl:when test="name()='value'"/>
					<xsl:otherwise>
						<xsl:call-template name="Error">
							<xsl:with-param name="msg" select="'WTFLASH/WTVARIABLE Invalid Attribute'"/>
							<xsl:with-param name="text" select="name()"/>
	 					</xsl:call-template>
					</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
		<!-- ****************************************************-->

		<xsl:if test="position()!=1"><xsl:value-of select="', '"/></xsl:if>
		  <xsl:value-of select="concat(@name, ': &quot;')"/>
		  <xsl:call-template name="GetValue">
				<xsl:with-param name="type" select="$valuetype"/>
				<xsl:with-param name="text" select="$valuetext"/>
				<xsl:with-param name="entity" select="$valueentity"/>
				<xsl:with-param name="hidden" select="true()"/>
		  </xsl:call-template>
		  <xsl:value-of select="'&quot;'"/>

	 </xsl:template>

	 <!--==================================================================-->
	 <xsl:template match="WTFLASH/WTPARAM">
	 <!--==================================================================-->
		  <xsl:variable name="valuetype"><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>
		  <xsl:variable name="valuetext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>
		  <xsl:variable name="valueentity"><xsl:call-template name="QualifiedPrefix"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>

		<!-- ***************** Error Checking *******************-->
		<xsl:if test="not(@name)">
			<xsl:call-template name="Error">
	     		<xsl:with-param name="msg" select="'WTFLASH/WTPARAM Name Missing'"/>
	     		<xsl:with-param name="text" select="position()"/>
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="not(@value)">
			<xsl:call-template name="Error">
	     		<xsl:with-param name="msg" select="'WTFLASH/WTPARAM Value Missing'"/>
	     		<xsl:with-param name="text" select="@name"/>
			</xsl:call-template>
		</xsl:if>
		<!--Test valid attributes-->
		<xsl:for-each select="@*">
			<xsl:choose>
					<xsl:when test="name()='name'"/>
					<xsl:when test="name()='value'"/>
					<xsl:otherwise>
						<xsl:call-template name="Error">
							<xsl:with-param name="msg" select="'WTFLASH/WTPARAM Invalid Attribute'"/>
							<xsl:with-param name="text" select="name()"/>
	 					</xsl:call-template>
					</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
		<!-- ****************************************************-->

		<xsl:if test="position()!=1"><xsl:value-of select="', '"/></xsl:if>
		  <xsl:value-of select="concat(@name, ': &quot;')"/>
		  <xsl:call-template name="GetValue">
				<xsl:with-param name="type" select="$valuetype"/>
				<xsl:with-param name="text" select="$valuetext"/>
				<xsl:with-param name="entity" select="$valueentity"/>
				<xsl:with-param name="hidden" select="true()"/>
		  </xsl:call-template>
		  <xsl:value-of select="'&quot;'"/>

	 </xsl:template>

	 <!--==================================================================-->
	 <xsl:template match="WTFLASH/WTATTRIBUTE">
	 <!--==================================================================-->
		  <xsl:variable name="valuetype"><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>
		  <xsl:variable name="valuetext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>
		  <xsl:variable name="valueentity"><xsl:call-template name="QualifiedPrefix"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>

		<!-- ***************** Error Checking *******************-->
		<xsl:if test="not(@name)">
			<xsl:call-template name="Error">
	     		<xsl:with-param name="msg" select="'WTFLASH/WTATTRIBUTE Name Missing'"/>
	     		<xsl:with-param name="text" select="position()"/>
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="not(@value)">
			<xsl:call-template name="Error">
	     		<xsl:with-param name="msg" select="'WTFLASH/WTATTRIBUTE Value Missing'"/>
	     		<xsl:with-param name="text" select="@name"/>
			</xsl:call-template>
		</xsl:if>
		<!--Test valid attributes-->
		<xsl:for-each select="@*">
			<xsl:choose>
					<xsl:when test="name()='name'"/>
					<xsl:when test="name()='value'"/>
					<xsl:otherwise>
						<xsl:call-template name="Error">
							<xsl:with-param name="msg" select="'WTFLASH/WTATTRIBUTE Invalid Attribute'"/>
							<xsl:with-param name="text" select="name()"/>
	 					</xsl:call-template>
					</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
		<!-- ****************************************************-->

		<xsl:if test="position()!=1"><xsl:value-of select="', '"/></xsl:if>
		  <xsl:value-of select="concat(@name, ': &quot;')"/>
		  <xsl:call-template name="GetValue">
				<xsl:with-param name="type" select="$valuetype"/>
				<xsl:with-param name="text" select="$valuetext"/>
				<xsl:with-param name="entity" select="$valueentity"/>
				<xsl:with-param name="hidden" select="true()"/>
		  </xsl:call-template>
		  <xsl:value-of select="'&quot;'"/>

	 </xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTAPPLET">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="ind2" select="concat($ind1, $tab1)"/>
		<xsl:variable name="indent2" select="$indent+1"/>
		<xsl:variable name="ind3" select="concat($ind2, $tab1)"/>
		<xsl:variable name="indent3" select="$indent2+1"/>
		<xsl:variable name="basetype"><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="@codebase"/></xsl:call-template></xsl:variable>
		<xsl:variable name="basetext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@codebase"/></xsl:call-template></xsl:variable>
		<xsl:variable name="baseentity"><xsl:call-template name="QualifiedPrefix"><xsl:with-param name="value" select="@codebase"/></xsl:call-template></xsl:variable>

	 <!-- ***************** Error Checking *******************-->
	 <xsl:if test="not(@col)">
	     <xsl:call-template name="Error">
	     	<xsl:with-param name="msg" select="'WTAPPLET Column Missing'"/>
	     	<xsl:with-param name="text" select="position()"/>
	     </xsl:call-template>
	 </xsl:if>
<!--	*** this is not required ***
	 <xsl:if test="not(@codebase)">
	     <xsl:call-template name="Error">
	     	<xsl:with-param name="msg" select="'WTAPPLET Codebase Missing'"/>
	     	<xsl:with-param name="text" select="@name"/>
	     </xsl:call-template>
	 </xsl:if>
-->	 
	 <xsl:if test="not(@code or @classid)">
	     <xsl:call-template name="Error">
	     	<xsl:with-param name="msg" select="'WTAPPLET Either Code or ClassID is Required'"/>
	     	<xsl:with-param name="text" select="@name"/>
	     </xsl:call-template>
	 </xsl:if>
	 <xsl:if test="@code and @classid">
	     <xsl:call-template name="Error">
	     	<xsl:with-param name="msg" select="'WTAPPLET Only Code or ClassID is Allowed'"/>
	     	<xsl:with-param name="text" select="@name"/>
	     </xsl:call-template>
	 </xsl:if>
	 <!--Test valid attributes-->
	 <xsl:for-each select="@*">
			<xsl:variable name="testcol">
				<xsl:call-template name="TestColAttr">
					<xsl:with-param name="attr" select="name()"/>
				</xsl:call-template>
			</xsl:variable>
		   <xsl:if test="$testcol='0'">
				<xsl:choose>
					 <xsl:when test="name()='code'"/>
					 <xsl:when test="name()='classid'"/>
					 <xsl:when test="name()='data'"/>
					 <xsl:when test="name()='codebase'"/>
					 <xsl:when test="name()='archive'"/>
					 <xsl:when test="name()='imgwidth'"/>
					 <xsl:when test="name()='imgheight'"/>
					 <xsl:when test="name()='id'"/>
					 <xsl:when test="name()='style'"/>
					 <xsl:when test="name()='name'"/>
					 <xsl:when test="name()='viewastext'"/>
					<xsl:otherwise>
						 <xsl:call-template name="Error">
							  <xsl:with-param name="msg" select="'WTAPPLET Invalid Attribute'"/>
							  <xsl:with-param name="text" select="name()"/>
	 					</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose>
		   </xsl:if>
	 </xsl:for-each>
	 <!-- ****************************************************-->

		<!--begin the column tag-->
		<xsl:apply-templates select="." mode="cell-begin">
			<xsl:with-param name="indent" select="$indent"/>
		</xsl:apply-templates>

		  <!--applet tag-->
		<xsl:choose>
			<xsl:when test="@code">
				<xsl:value-of select="concat($ind2, '&lt;xsl:element name=&quot;APPLET&quot;&gt;', $cr)"/>
				<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;code&quot;&gt;', @code, '&lt;/xsl:attribute&gt;', $cr)"/>
			</xsl:when>
			<xsl:when test="@classid">
				<xsl:value-of select="concat($ind2, '&lt;xsl:element name=&quot;OBJECT&quot;&gt;', $cr)"/>
				<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;classid&quot;&gt;', @classid, '&lt;/xsl:attribute&gt;', $cr)"/>
				<xsl:if test="(@data)">
					<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;data&quot;&gt;', @data, '&lt;/xsl:attribute&gt;', $cr)"/>
				</xsl:if>
			</xsl:when>
		</xsl:choose>

		<xsl:if test="(@codebase)">
			<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;codebase&quot;&gt;')"/>

			  <xsl:call-template name="GetValue">
					<xsl:with-param name="type" select="$basetype"/>
					<xsl:with-param name="text" select="$basetext"/>
					<xsl:with-param name="entity" select="$baseentity"/>
					<xsl:with-param name="hidden" select="true()"/>
			  </xsl:call-template>

			  <xsl:value-of select="concat('&lt;/xsl:attribute&gt;', $cr)"/>
		</xsl:if>
		<xsl:if test="(@archive)">
			<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;archive&quot;&gt;', @archive, '&lt;/xsl:attribute&gt;', $cr)"/>
		</xsl:if>
		<xsl:if test="(@id)">
			<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;id&quot;&gt;', @id, '&lt;/xsl:attribute&gt;', $cr)"/>
		</xsl:if>
		<xsl:if test="(@name)">
			<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;name&quot;&gt;', @name, '&lt;/xsl:attribute&gt;', $cr)"/>
		</xsl:if>
		<xsl:if test="(@style)">
			<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;style&quot;&gt;', @style, '&lt;/xsl:attribute&gt;', $cr)"/>
		</xsl:if>
		<xsl:if test="(@imgwidth)">
			<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;width&quot;&gt;', @imgwidth, '&lt;/xsl:attribute&gt;', $cr)"/>
		</xsl:if>
		<xsl:if test="(@imgheight)">
			<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;height&quot;&gt;', @imgheight, '&lt;/xsl:attribute&gt;', $cr)"/>
		</xsl:if>
		<xsl:if test="(@viewastext)">
			<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;viewastext&quot;&gt;1&lt;/xsl:attribute&gt;', $cr)"/>
		</xsl:if>

		<!--add the parameters for the applet-->
		<xsl:apply-templates select="WTPARAM">
			<xsl:with-param name="indent" select="$indent3"/>
		</xsl:apply-templates>

		<xsl:value-of select="concat($ind2, 'Error: could not load applet or object.', $cr)"/>

		<xsl:value-of select="concat($ind2, '&lt;/xsl:element&gt;', $cr)"/>

		<!--end the column tag-->
		<xsl:apply-templates select="." mode="cell-end">
			<xsl:with-param name="indent" select="$indent"/>
		</xsl:apply-templates>
	</xsl:template>
	 <!--==================================================================-->
	 <xsl:template match="WTAPPLET/WTPARAM">
	 <!--==================================================================-->
		  <xsl:param name="indent"/>
		  <xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		  <xsl:variable name="ind2" select="concat($ind1, $tab1)"/>
		  <xsl:variable name="indent2" select="$indent+1"/>
		  <xsl:variable name="valuetype"><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>
		  <xsl:variable name="valuetext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>
		  <xsl:variable name="valueentity"><xsl:call-template name="QualifiedPrefix"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>

	 <!-- ***************** Error Checking *******************-->
	 <xsl:if test="not(@name)">
	     <xsl:call-template name="Error">
	     	<xsl:with-param name="msg" select="'WTAPPLET/WTPARAM Name Missing'"/>
	     	<xsl:with-param name="text" select="position()"/>
	     </xsl:call-template>
	 </xsl:if>
	 <xsl:if test="not(@value)">
	     <xsl:call-template name="Error">
	     	<xsl:with-param name="msg" select="'WTAPPLET/WTPARAM Value Missing'"/>
	     	<xsl:with-param name="text" select="@name"/>
	     </xsl:call-template>
	 </xsl:if>
	 <!--Test valid attributes-->
	 <xsl:for-each select="@*">
		  <xsl:choose>
				<xsl:when test="name()='name'"/>
				<xsl:when test="name()='value'"/>
				<xsl:otherwise>
					 <xsl:call-template name="Error">
						  <xsl:with-param name="msg" select="'WTAPPLET/WTPARAM Invalid Attribute'"/>
						  <xsl:with-param name="text" select="name()"/>
	 				</xsl:call-template>
				</xsl:otherwise>
		  </xsl:choose>
	 </xsl:for-each>
	 <!-- ****************************************************-->

		  <!--param-->
		  <xsl:value-of select="concat($ind1, '&lt;xsl:element name=&quot;PARAM&quot;&gt;', $cr)"/>
		  <xsl:value-of select="concat($ind2, '&lt;xsl:attribute name=&quot;name&quot;&gt;', @name, '&lt;/xsl:attribute&gt;', $cr)"/>

		  <xsl:value-of select="concat($ind2, '&lt;xsl:attribute name=&quot;value&quot;&gt;')"/>

		  <xsl:variable name="entity">
				<xsl:choose>
					 <xsl:when test="$valueentity != ''"><xsl:value-of select="$valueentity"/></xsl:when>
					 <xsl:otherwise><xsl:value-of select="$entityname"/></xsl:otherwise>
				</xsl:choose>
		  </xsl:variable>
		
		  <xsl:call-template name="GetValue">
				<xsl:with-param name="type" select="$valuetype"/>
				<xsl:with-param name="text" select="$valuetext"/>
				<xsl:with-param name="entity" select="$entity"/>
				<xsl:with-param name="hidden" select="true()"/>
		  </xsl:call-template>
		
		  <xsl:value-of select="concat('&lt;/xsl:attribute&gt;', $cr)"/>
		  <xsl:value-of select="concat($ind1, '&lt;/xsl:element&gt;', $cr)"/>
	 </xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTFILTER">
	<!--==================================================================-->
		<xsl:variable name="nametype"><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="@name"/></xsl:call-template></xsl:variable>
		<xsl:variable name="nametext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@name"/></xsl:call-template></xsl:variable>
		<xsl:variable name="nameentity"><xsl:call-template name="QualifiedPrefix"><xsl:with-param name="value" select="@name"/></xsl:call-template></xsl:variable>
		<xsl:variable name="valuetype"><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>
		<xsl:variable name="valuetext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>
		<xsl:variable name="valueentity"><xsl:call-template name="QualifiedPrefix"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>

	 <!-- ***************** Error Checking *******************-->
	 <xsl:if test="not(@name)">
	     <xsl:call-template name="Error">
	     	<xsl:with-param name="msg" select="'WTFILTER Name Missing'"/>
	     	<xsl:with-param name="text" select="position()"/>
	     </xsl:call-template>
	 </xsl:if>
	 <xsl:if test="not(@oper)">
	     <xsl:call-template name="Error">
	     	<xsl:with-param name="msg" select="'WTFILTER Operator Missing'"/>
	     	<xsl:with-param name="text" select="@name"/>
	     </xsl:call-template>
	 </xsl:if>
	 <xsl:if test="not(@value)">
	     <xsl:call-template name="Error">
	     	<xsl:with-param name="msg" select="'WTFILTER Value Missing'"/>
	     	<xsl:with-param name="text" select="@name"/>
	     </xsl:call-template>
	 </xsl:if>
	 <!--Test valid attributes-->
	 <xsl:for-each select="@*">
		  <xsl:choose>
				<xsl:when test="name()='name'"/>
				<xsl:when test="name()='oper'"/>
				<xsl:when test="name()='value'"/>
				<xsl:when test="name()='connector'"/>
				<xsl:otherwise>
					 <xsl:call-template name="Error">
						  <xsl:with-param name="msg" select="'WTFILTER Invalid Attribute'"/>
						  <xsl:with-param name="text" select="name()"/>
	 				</xsl:call-template>
				</xsl:otherwise>
		  </xsl:choose>
	 </xsl:for-each>
	 <!-- ****************************************************-->

		<!--==========enclose the test in brackets==========-->
		<xsl:if test="position()=1">
			<xsl:value-of select="('[(')"/>
		</xsl:if>

		<!--==========if not the first, then close parenthesis for previous condition==========-->
		<xsl:if test="@connector">
			<xsl:value-of select="concat(') ', @connector, '(')"/>
		</xsl:if>

		<!--==========handle the expression==========-->
		<xsl:if test="$nametype='DATA' and $nameentity = 'Current'">current()/</xsl:if>

		  <xsl:call-template name="GetValue">
		  	<xsl:with-param name="type" select="$nametype"/>
		  	<xsl:with-param name="text" select="$nametext"/>
		  	<xsl:with-param name="entity" select="$nameentity"/>
			<xsl:with-param name="noselect" select="true()"/>
			<xsl:with-param name="hidden" select="true()"/>
		  </xsl:call-template>

		  <!--==========handle the operator==========-->
		  <xsl:call-template name="GetOperator">
		  	<xsl:with-param name="oper" select="@oper"/>
		  </xsl:call-template>
				
		  <!--==========handle the value==========-->
			<xsl:if test="$valuetype='DATA' and $valueentity = 'Current'">current()/</xsl:if>
		  <xsl:call-template name="GetValue">
		  	<xsl:with-param name="type" select="$valuetype"/>
		  	<xsl:with-param name="text" select="$valuetext"/>
		  	<xsl:with-param name="entity" select="$valueentity"/>
			<xsl:with-param name="noselect" select="true()"/>
			<xsl:with-param name="hidden" select="true()"/>
		  </xsl:call-template>

		<xsl:if test="position()=last()">
			<xsl:value-of select="(')]')"/>
		</xsl:if>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTREPEAT">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:variable name="hasconditions" select="(count(WTCONDITION) > 0)"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="ind2"><xsl:choose><xsl:when test="$hasconditions"><xsl:value-of select="concat($ind1, $tab1)"/></xsl:when><xsl:otherwise><xsl:value-of select="$ind1"/></xsl:otherwise></xsl:choose></xsl:variable>
		<xsl:variable name="indent2"><xsl:choose><xsl:when test="$hasconditions"><xsl:value-of select="$indent+1"/></xsl:when><xsl:otherwise><xsl:value-of select="$indent+1"/></xsl:otherwise></xsl:choose></xsl:variable>
		<xsl:variable name="ind3" select="concat($ind2, $tab1)"/>
		<xsl:variable name="indent3" select="$indent2+1"/>

	 <!-- ***************** Error Checking *******************-->
	 <xsl:if test="not(@entity or @xpath)">
	     <xsl:call-template name="Error">
	     	<xsl:with-param name="msg" select="'WTREPEAT Entity or xPath Missing'"/>
	     	<xsl:with-param name="text" select="position()"/>
	     </xsl:call-template>
	 </xsl:if>
	 <!--Test valid attributes-->
	 <xsl:for-each select="@*">
		  <xsl:choose>
				<xsl:when test="name()='entity'"/>
				<xsl:when test="name()='xpath'"/>
				<xsl:otherwise>
					 <xsl:call-template name="Error">
						  <xsl:with-param name="msg" select="'WTREPEAT Invalid Attribute'"/>
						  <xsl:with-param name="text" select="name()"/>
	 				</xsl:call-template>
				</xsl:otherwise>
		  </xsl:choose>
	 </xsl:for-each>
	 <!-- ****************************************************-->

		<!--generate IF statement for conditions if they exist-->
		<xsl:if test="($hasconditions)">
			<xsl:call-template name="XSLConditionStart">
				<xsl:with-param name="indent" select="$indent"/>
				<xsl:with-param name="conditions" select="WTCONDITION"/>
			</xsl:call-template>
		</xsl:if>

		<!--for-each-->
		<xsl:value-of select="concat($ind2, '&lt;xsl:for-each select=&quot;')"/>
		<xsl:choose>
			<xsl:when test="@xpath"><xsl:value-of select="@xpath"/></xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="XSLDataPath">
					<xsl:with-param name="entity" select="@entity"/>
					<xsl:with-param name="iscollection" select="true()"/>
				</xsl:call-template>
				<!--filter-->
				<xsl:apply-templates select="WTFILTER"/>
			</xsl:otherwise>
		</xsl:choose>
		
		<xsl:value-of select="concat($tab0, '&quot;&gt;', $cr)"/>

		<xsl:apply-templates select="child::*[name() != 'WTFILTER']">		
			<xsl:with-param name="indent" select="$indent3"/>
		</xsl:apply-templates>		

		<!--end for-each-->
		<xsl:value-of select="concat($ind2, '&lt;/xsl:for-each&gt;', $cr)"/>

		<!--close IF statement for conditions if they exist-->
		<xsl:if test="($hasconditions)">
			<xsl:call-template name="XSLConditionEnd">
				<xsl:with-param name="indent" select="$indent"/>			
			</xsl:call-template>
		</xsl:if>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTSORT">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:variable name="hasconditions" select="(count(WTCONDITION) > 0)"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="ind2"><xsl:choose><xsl:when test="$hasconditions"><xsl:value-of select="concat($ind1, $tab1)"/></xsl:when><xsl:otherwise><xsl:value-of select="$ind1"/></xsl:otherwise></xsl:choose></xsl:variable>
		<xsl:variable name="indent2"><xsl:choose><xsl:when test="$hasconditions"><xsl:value-of select="$indent+1"/></xsl:when><xsl:otherwise><xsl:value-of select="$indent+1"/></xsl:otherwise></xsl:choose></xsl:variable>

	 <!-- ***************** Error Checking *******************-->
	 <xsl:if test="not(@name)">
	     <xsl:call-template name="Error">
	     	<xsl:with-param name="msg" select="'WTSORT Name Missing'"/>
	     	<xsl:with-param name="text" select="position()"/>
	     </xsl:call-template>
	 </xsl:if>
	 <!--Test valid attributes-->
	 <xsl:for-each select="@*">
		  <xsl:choose>
				<xsl:when test="name()='name'"/>
				<xsl:when test="name()='datatype'"/>
				<xsl:when test="name()='order'"/>
				<xsl:otherwise>
					 <xsl:call-template name="Error">
						  <xsl:with-param name="msg" select="'WTSORT Invalid Attribute'"/>
						  <xsl:with-param name="text" select="name()"/>
	 				</xsl:call-template>
				</xsl:otherwise>
		  </xsl:choose>
	 </xsl:for-each>
	 <!-- ****************************************************-->

		<xsl:value-of select="concat($ind2, '&lt;xsl:sort select=&quot;', @name, '&quot;')"/>
		<xsl:if test="@datatype">
			<xsl:value-of select="concat(' data-type=&quot;', @datatype, '&quot;')"/>
		</xsl:if>
		<xsl:if test="@order">
			<xsl:value-of select="concat(' order=&quot;', @order, '&quot;')"/>
		</xsl:if>
		<xsl:value-of select="concat('/&gt;', $cr)"/>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTTABLE">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:variable name="hasconditions" select="(count(WTCONDITION) > 0)"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="ind2" select="concat($ind1, $tab1)"/>
		<xsl:variable name="indent2" select="$indent+1"/>
		<xsl:variable name="ind3"><xsl:choose><xsl:when test="$hasconditions"><xsl:value-of select="concat($ind2, $tab1)"/></xsl:when><xsl:otherwise><xsl:value-of select="$ind2"/></xsl:otherwise></xsl:choose></xsl:variable>
		<xsl:variable name="indent3"><xsl:choose><xsl:when test="$hasconditions"><xsl:value-of select="$indent2+1"/></xsl:when><xsl:otherwise><xsl:value-of select="$indent2+1"/></xsl:otherwise></xsl:choose></xsl:variable>
		<xsl:variable name="ind4" select="concat($ind3, $tab1)"/>
		<xsl:variable name="indent4" select="$indent3+1"/>

	 <!-- ***************** Error Checking *******************-->
	 <xsl:if test="not(@col) and not(ancestor::WTTREE) and not(ancestor::WTTREE2) and not(ancestor::WTDIVISION) and (ancestor::WTROW)">
	    <xsl:call-template name="Error">
	    	<xsl:with-param name="msg" select="'WTTABLE Column Missing'"/>
	    	<xsl:with-param name="text" select="position()"/>
	    </xsl:call-template>
	 </xsl:if>
	 <!--Test valid attributes-->
	 <xsl:for-each select="@*">
			<xsl:variable name="testcol">
				<xsl:call-template name="TestColAttr">
					<xsl:with-param name="attr" select="name()"/>
				</xsl:call-template>
			</xsl:variable>
		   <xsl:if test="$testcol='0'">
				<xsl:choose>
					<xsl:when test="name()='id'"/>
					<xsl:when test="name()='width'"/>
					<xsl:when test="name()='height'"/>
					<xsl:when test="name()='color'"/>
					<xsl:when test="name()='background'"/>
					<xsl:when test="name()='border'"/>
					<xsl:when test="name()='bordercolor'"/>
					<xsl:when test="name()='padding'"/>
					<xsl:when test="name()='spacing'"/>
					<xsl:when test="name()='firstrow'"/>
					<xsl:when test="name()='style'"/>
					<xsl:when test="name()='tableclass'"/>
					<xsl:otherwise>
						 <xsl:call-template name="Error">
							  <xsl:with-param name="msg" select="'WTTABLE Invalid Attribute'"/>
							  <xsl:with-param name="text" select="name()"/>
	 					</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose>
		   </xsl:if>
	 </xsl:for-each>
	 <!-- ****************************************************-->

		<!--begin the column tag-->
		<xsl:if test="not(ancestor::WTTREE) and not(ancestor::WTTREE2) and (ancestor::WTROW)">
			<xsl:apply-templates select="." mode="cell-begin">
				<xsl:with-param name="indent" select="$indent"/>
				<xsl:with-param name="wrap" select="false"/>
				<xsl:with-param name="isfirst" select="position()=1"/>
			</xsl:apply-templates>
		</xsl:if>

		<!--generate IF statement for conditions if they exist-->
		<xsl:if test="($hasconditions)">
			<xsl:call-template name="XSLConditionStart">
				<xsl:with-param name="indent" select="$indent2"/>
				<xsl:with-param name="conditions" select="WTCONDITION"/>
			</xsl:call-template>
		</xsl:if>

	  	<xsl:variable name="contentwidth">
	  		<xsl:choose>
				<xsl:when test="@width"><xsl:value-of select="@width"/></xsl:when>
				<xsl:otherwise><xsl:value-of select="sum(WTCOLUMN/@width)"/></xsl:otherwise>
	  		</xsl:choose>
        <xsl:if test="$widthpercent='true'">%</xsl:if>
      </xsl:variable>
		<xsl:variable name="border">
			<xsl:choose>
				<xsl:when test="/Data/WTENTITY/WTWEBPAGE/@test or /Data/WTPAGE/@test">1</xsl:when>
				<xsl:when test="@border"><xsl:value-of select="@border"/></xsl:when>
				<xsl:otherwise>0</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="padding">
			<xsl:choose>
				<xsl:when test="@padding"><xsl:value-of select="@padding"/></xsl:when>
				<xsl:otherwise>0</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="spacing">
			<xsl:choose>
				<xsl:when test="@spacing"><xsl:value-of select="@spacing"/></xsl:when>
				<xsl:otherwise>0</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		
		<xsl:value-of select="concat($ind3, '&lt;xsl:element name=&quot;TABLE&quot;&gt;', $cr)"/>

		<xsl:if test="@id">
			<xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;id&quot;&gt;', @id, '&lt;/xsl:attribute&gt;', $cr)"/>
		</xsl:if>

		<xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;border&quot;&gt;', $border, '&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;cellpadding&quot;&gt;', $padding, '&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;cellspacing&quot;&gt;', $spacing, '&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;width&quot;&gt;', $contentwidth, '&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:if test="@height">
			<xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;height&quot;&gt;', @height, '&lt;/xsl:attribute&gt;', $cr)"/>
		</xsl:if>
		<xsl:if test="@bordercolor">
	 		<xsl:variable name="bordercolor"><xsl:call-template name="GetColor"><xsl:with-param name="color" select="@bordercolor"/></xsl:call-template></xsl:variable>
			<xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;bordercolor&quot;&gt;', $bordercolor, '&lt;/xsl:attribute&gt;', $cr)"/>
		</xsl:if>
		<xsl:if test="@color">
	 		<xsl:variable name="bgcolor"><xsl:call-template name="GetColor"><xsl:with-param name="color" select="@color"/></xsl:call-template></xsl:variable>
			<xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;bgcolor&quot;&gt;', $bgcolor, '&lt;/xsl:attribute&gt;', $cr)"/>
		</xsl:if>
		<xsl:if test="@background">
			<xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;background&quot;&gt;Images/', @background, '&lt;/xsl:attribute&gt;', $cr)"/>
		</xsl:if>
		<xsl:if test="@style">
			<xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;style&quot;&gt;', @style, '&lt;/xsl:attribute&gt;', $cr)"/>
		</xsl:if>
		<xsl:if test="@tableclass">
			<xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;class&quot;&gt;', @tableclass, '&lt;/xsl:attribute&gt;', $cr)"/>
		</xsl:if>
		<xsl:value-of select="$cr"/>

		<!--table layout line-->
		<xsl:if test="not(@firstrow='false')">
			<xsl:apply-templates select="WTCOLUMN" mode="layout">		
				<xsl:with-param name="indent" select="$indent4"/>
			</xsl:apply-templates>		
		</xsl:if>

		<xsl:apply-templates select="child::*[name() != 'WTCOLUMN']">		
			<xsl:with-param name="indent" select="$indent4"/>
		</xsl:apply-templates>	

		<xsl:value-of select="concat($ind3, '&lt;/xsl:element&gt;', $cr)"/>

		<!--close IF statement for conditions if they exist-->
		<xsl:if test="($hasconditions)">
			<xsl:call-template name="XSLConditionEnd">
				<xsl:with-param name="indent" select="$indent2"/>			
			</xsl:call-template>
		</xsl:if>

		<!--end the column tag-->
		<xsl:if test="not(ancestor::WTTREE) and not(ancestor::WTTREE2) and (ancestor::WTROW)">
			<xsl:apply-templates select="." mode="cell-end">
				<xsl:with-param name="indent" select="$indent"/>
				<xsl:with-param name="wrap" select="false"/>
				<xsl:with-param name="islast" select="position()=last()"/>
			</xsl:apply-templates>
		</xsl:if>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTTEMPLATE">
	<!--==================================================================-->
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="1"/></xsl:call-template></xsl:variable>
		<xsl:variable name="ind2" select="concat($ind1, $tab1)"/>
		<xsl:variable name="indent2" select="2"/>
		<xsl:variable name="ind3" select="concat($ind2, $tab1)"/>
		<xsl:variable name="indent3" select="$indent2+1"/>

	 <!-- ***************** Error Checking *******************-->
	 <xsl:if test="not(@name)">
	     <xsl:call-template name="Error">
	     	<xsl:with-param name="msg" select="'WTTEMPLATE Name Missing'"/>
	     	<xsl:with-param name="text" select="position()"/>
	     </xsl:call-template>
	 </xsl:if>
	 <!--Test valid attributes-->
	 <xsl:for-each select="@*">
		  <xsl:choose>
				<xsl:when test="name()='name'"/>
				<xsl:otherwise>
					 <xsl:call-template name="Error">
						  <xsl:with-param name="msg" select="'WTTEMPLATE Invalid Attribute'"/>
						  <xsl:with-param name="text" select="name()"/>
	 				</xsl:call-template>
				</xsl:otherwise>
		  </xsl:choose>
	 </xsl:for-each>
	 <!-- ****************************************************-->

		<xsl:value-of select="concat($ind1, '&lt;xsl:stylesheet version=&quot;1.0&quot; xmlns:xsl=&quot;http://www.w3.org/1999/XSL/Transform&quot; xmlns:msxsl=&quot;urn:schemas-microsoft-com:xslt&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($ind2, '&lt;xsl:output omit-xml-declaration=&quot;yes&quot;/&gt;', $cr, $cr)"/>
		<xsl:value-of select="concat($ind2, '&lt;xsl:template name=&quot;', @name, '&quot;&gt;', $cr)"/>

		<xsl:apply-templates>		
			<xsl:with-param name="indent" select="$indent3"/>
		</xsl:apply-templates>		

		<xsl:value-of select="concat($ind2, '&lt;/xsl:template&gt;', $cr)"/>
		<xsl:value-of select="concat($ind1, '&lt;/xsl:stylesheet&gt;', $cr)"/>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="*" mode="cell-end">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:param name="wrap"/>
		<xsl:param name="islast"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="ind2" select="concat($ind1, $tab1)"/>
		<xsl:variable name="ind3" select="concat($ind2, $tab1)"/>

		<xsl:if test="WTSPAN">
			<xsl:value-of select="concat($ind2, '&lt;/xsl:element&gt;', $cr)"/>
		</xsl:if>

		<xsl:if test="not(@col='false')">
			<xsl:if test="($wrap and $islast) or (not($wrap))">
				<xsl:value-of select="concat($ind1, '&lt;/xsl:element&gt;', $cr)"/>
			</xsl:if>
		</xsl:if>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="*" mode="cell-begin">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:param name="wrap"/>
		<xsl:param name="isfirst"/>

		<xsl:if test="not(@col='false')">

			<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
			<xsl:variable name="ind2" select="concat($ind1, $tab1)"/>
			<xsl:variable name="indent2" select="$indent+1"/>
			<xsl:variable name="ind3" select="concat($ind2, $tab1)"/>

			<xsl:variable name="width">
				<xsl:choose>
					<xsl:when test="@headerwidth"><xsl:value-of select="@headerwidth"/></xsl:when>
					<xsl:when test="@width"><xsl:value-of select="@width"/></xsl:when>
					<xsl:when test="(name()='WTTABLE')"><xsl:value-of select="sum(WTCOLUMN/@width)"/></xsl:when>
					<xsl:when test="ancestor::WTRECORDSET"></xsl:when>
					<xsl:when test="(ancestor::WTTABLE) and (@merge)">
						<xsl:value-of select="sum(ancestor::WTTABLE[1]/WTCOLUMN[(position() &gt;= (current()/@col)) and (position() &lt;= (current()/@col + current()/@merge - 1))]/@width)"/>
					</xsl:when>
					<xsl:when test="ancestor::WTTABLE"><xsl:value-of select="ancestor::WTTABLE[1]/WTCOLUMN[position()=current()/@col]/@width"/></xsl:when>
					<xsl:otherwise>			
						<xsl:choose>
							<xsl:when test="@merge"><xsl:value-of select="sum(ancestor::WTCONTENT/WTCOLUMN[(position() &gt;= (current()/@col)) and (position() &lt;= (current()/@col + current()/@merge - 1))]/@width)"/></xsl:when>
							<xsl:otherwise><xsl:value-of select="ancestor::WTCONTENT/WTCOLUMN[position()=current()/@col]/@width"/></xsl:otherwise>
						</xsl:choose>
					</xsl:otherwise>
				</xsl:choose>
        <xsl:if test="$widthpercent='true'">%</xsl:if>
      </xsl:variable>

			<xsl:variable name="align">
				<xsl:choose>
					<xsl:when test="@align"><xsl:value-of select="@align"/></xsl:when>
					<xsl:when test="ancestor::WTRECORDSET"><xsl:value-of select="ancestor::WTRECORDSET/WTCOLUMN[position()=current()/@col]/@align"/></xsl:when>
					<xsl:when test="ancestor::WTTABLE"><xsl:value-of select="ancestor::WTTABLE/WTCOLUMN[position()=current()/@col]/@align"/></xsl:when>
					<xsl:otherwise><xsl:value-of select="ancestor::WTCONTENT/WTCOLUMN[position()=current()/@col]/@align"/></xsl:otherwise>
				</xsl:choose>
			</xsl:variable>

			<xsl:variable name="valign">
				<xsl:choose>
					<xsl:when test="@valign"><xsl:value-of select="@valign"/></xsl:when>
					<xsl:when test="(name()='WTLINKGROUP')">bottom</xsl:when>
					<xsl:otherwise>center</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			<xsl:variable name="class">
				<xsl:choose>
					<xsl:when test="ancestor::WTROW/@class"></xsl:when>
					<xsl:when test="@class and not(@class='false')"><xsl:value-of select="@class"/></xsl:when>
					<xsl:when test="(name()='WTLINKGROUP' and not(@class='false'))">PrevNext</xsl:when>
					<xsl:otherwise></xsl:otherwise>
				</xsl:choose>
			</xsl:variable>

			<!--build the column-->
			<xsl:choose>
				<xsl:when test="($wrap and $isfirst) or (not($wrap))">
					<xsl:value-of select="concat($ind1, '&lt;xsl:element name=&quot;TD&quot;&gt;', $cr)"/>
<!--
					<xsl:if test="@style">
						<xsl:value-of select="concat($ind2, '&lt;xsl:attribute name=&quot;style&quot;&gt;', @style, '&lt;/xsl:attribute&gt;', $cr)"/>
					</xsl:if>
-->					
					<xsl:if test="@rowspan">
						<xsl:value-of select="concat($ind2, '&lt;xsl:attribute name=&quot;rowspan&quot;&gt;', @rowspan, '&lt;/xsl:attribute&gt;', $cr)"/>
					</xsl:if>
					<xsl:if test="@merge">
						<xsl:value-of select="concat($ind2, '&lt;xsl:attribute name=&quot;colspan&quot;&gt;', @merge, '&lt;/xsl:attribute&gt;', $cr)"/>
					</xsl:if>
					<xsl:if test="($width != '')">
						<xsl:value-of select="concat($ind2, '&lt;xsl:attribute name=&quot;width&quot;&gt;', $width, '&lt;/xsl:attribute&gt;', $cr)"/>
					</xsl:if>
					<xsl:if test="(@height)">
						<xsl:value-of select="concat($ind2, '&lt;xsl:attribute name=&quot;height&quot;&gt;', @height, '&lt;/xsl:attribute&gt;',  $cr)"/>
					</xsl:if>
					<xsl:if test="@backcolor">
	 					<xsl:variable name="bgcolor"><xsl:call-template name="GetColor"><xsl:with-param name="color" select="@backcolor"/></xsl:call-template></xsl:variable>
						<xsl:value-of select="concat($ind2, '&lt;xsl:attribute name=&quot;bgcolor&quot;&gt;', $bgcolor, '&lt;/xsl:attribute&gt;', $cr)"/>
					</xsl:if>
					<xsl:if test="@bgimg">
						<xsl:variable name="type"><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="@bgimg"/></xsl:call-template></xsl:variable>
						<xsl:variable name="text"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@bgimg"/></xsl:call-template></xsl:variable>
						<xsl:variable name="background">
							<xsl:call-template name="GetValue">
								<xsl:with-param name="type" select="$type"/>
								<xsl:with-param name="text" select="$text"/>
							</xsl:call-template>
						</xsl:variable>
						<xsl:value-of select="concat($ind2 '&lt;xsl:attribute name=&quot;background&quot;&gt;Imagesb/', $background, '&lt;/xsl:attribute&gt;', $cr)"/>
					</xsl:if>
					<xsl:if test="ancestor::WTROW/@background">
						<xsl:value-of select="concat($ind2 '&lt;xsl:attribute name=&quot;background&quot;&gt;Images/', ancestor::WTROW/@background, '&lt;/xsl:attribute&gt;', $cr)"/>
					</xsl:if>

					<xsl:if test="@colid">
						<xsl:value-of select="concat($ind2, '&lt;xsl:attribute name=&quot;id&quot;&gt;', @colid, '&lt;/xsl:attribute&gt;', $cr)"/>
					</xsl:if>

					<xsl:choose>
						<xsl:when test="(name()='WTSTATIC') and (not(@tag)) and (not(@label)) and (not(@value)) and (not(child::*))"></xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="concat($ind2, '&lt;xsl:attribute name=&quot;align&quot;&gt;', $align, '&lt;/xsl:attribute&gt;', $cr)"/>
							<xsl:value-of select="concat($ind2, '&lt;xsl:attribute name=&quot;valign&quot;&gt;', $valign, '&lt;/xsl:attribute&gt;', $cr)"/>
							
							<xsl:if test="$class='prompt' or $class='Prompt'">
								<!-- If using system colors, use the promptsys class -->
								<xsl:if test="/Data/WTENTITY/WTWEBPAGE/@system-colors or /Data/WTPAGE/@system-colors">
									<xsl:value-of select="concat($ind2, '&lt;xsl:attribute name=&quot;class&quot;&gt;promptsys&lt;/xsl:attribute&gt;', $cr)"/>
								</xsl:if>
								<xsl:if test="not(/Data/WTENTITY/WTWEBPAGE/@system-colors or /Data/WTPAGE/@system-colors)">
									<xsl:value-of select="concat($ind2, '&lt;xsl:attribute name=&quot;class&quot;&gt;', $class, '&lt;/xsl:attribute&gt;', $cr)"/>
								</xsl:if>
							</xsl:if>
							<xsl:if test="$class!='' and $class!='prompt' and $class!='Prompt'">
								<xsl:value-of select="concat($ind2, '&lt;xsl:attribute name=&quot;class&quot;&gt;', $class, '&lt;/xsl:attribute&gt;', $cr)"/>
							</xsl:if>
							
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<xsl:if test="not(@noprespace or @prespace='false')">
						<xsl:call-template name="XSLDblSpace">
							<xsl:with-param name="indent" select="$indent2"/>
							<xsl:with-param name="space" select="@space"/>
						</xsl:call-template>
					</xsl:if>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:if test="WTSPAN">
				<xsl:value-of select="concat($ind2, '&lt;xsl:element name=&quot;span&quot;&gt;', $cr)"/>
				<xsl:if test="WTSPAN/@id">
					<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;id&quot;&gt;', WTSPAN/@id, '&lt;/xsl:attribute&gt;', $cr)"/>
				</xsl:if>
				<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;style&quot;&gt;', WTSPAN/@style, '&lt;/xsl:attribute&gt;', $cr)"/>
			</xsl:if>
		</xsl:if>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="*" mode="read-only">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="ind2" select="concat($ind1, $tab1)"/>
		<xsl:variable name="indent2" select="$indent+1"/>

		<xsl:variable name="protected" select="ancestor-or-self::*/@protected"/>

		<xsl:if test="$protected">
			<xsl:call-template name="XSLConditionStart">
				<xsl:with-param name="indent" select="$indent"/>
				<xsl:with-param name="protected" select="$protected[position()=last()]"/>
			</xsl:call-template>
			<xsl:value-of select="concat($ind2, '&lt;xsl:attribute name=&quot;DISABLED&quot;/&gt;', $cr)"/>
			<xsl:call-template name="XSLConditionEnd">
				<xsl:with-param name="indent" select="$indent"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="*" mode="require-mark">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="ind2" select="concat($ind1, $tab1)"/>
		<xsl:variable name="indent2" select="$indent+1"/>

		<xsl:if test="not(@requiremark='false')">
			<xsl:call-template name="XSLDblSpace">
				<xsl:with-param name="indent" select="$indent"/>
				<xsl:with-param name="space" select="0"/>
			</xsl:call-template>
			<xsl:value-of select="concat($ind1, '&lt;xsl:element name=&quot;IMG&quot;&gt;', $cr)"/>
			<xsl:value-of select="concat($ind2, '&lt;xsl:attribute name=&quot;src&quot;&gt;Images/Required.gif&lt;/xsl:attribute&gt;', $cr)"/>
			<xsl:value-of select="concat($ind2, '&lt;xsl:attribute name=&quot;alt&quot;&gt;Required Field&lt;/xsl:attribute&gt;', $cr)"/>
			<xsl:value-of select="concat($ind1, '&lt;/xsl:element&gt;', $cr)"/>
		</xsl:if>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="*" mode="language-mark">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="ind2" select="concat($ind1, $tab1)"/>
		<xsl:variable name="ind3" select="concat($ind2, $tab1)"/>
		<xsl:variable name="ind4" select="concat($ind3, $tab1)"/>
		<xsl:variable name="indent2" select="$indent+1"/>
		<xsl:variable name="valuetext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>
		<xsl:variable name="attribute" select="/Data/WTENTITY/WTATTRIBUTE[@name=$valuetext]"/>

		<xsl:call-template name="XSLDblSpace">
			<xsl:with-param name="indent" select="$indent"/>
		</xsl:call-template>

		  <xsl:value-of select="concat($ind1, '&lt;xsl:element name=&quot;A&quot;&gt;', $cr)"/>

		  <xsl:value-of select="concat($ind2, '&lt;xsl:attribute name=&quot;href&quot;&gt;')"/>

        <xsl:value-of select="concat('9911.asp?EntityID=', $entityid, '&amp;amp;AttributeID=', $attribute/@id, '&amp;amp;ItemID=')"/>

			<xsl:call-template name="GetValue">
				<xsl:with-param name="type" select="'ATTR'"/>
				<xsl:with-param name="entity" select="$entityname"/>
				<xsl:with-param name="text" select="$identity"/>
			</xsl:call-template>

		  <xsl:value-of select="'&amp;amp;ReturnURL=&lt;xsl:value-of select=&quot;/DATA/SYSTEM/@pageURL&quot;/&gt;&amp;amp;ReturnData=&lt;xsl:value-of select=&quot;/DATA/SYSTEM/@pageData&quot;/&gt;'"/>
		  <xsl:value-of select="concat('&lt;/xsl:attribute&gt;', $cr)"/>

		<xsl:value-of select="concat($ind2, '&lt;xsl:element name=&quot;IMG&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;src&quot;&gt;Images/Language.gif&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;border&quot;&gt;0&lt;/xsl:attribute&gt;', $cr)"/>		<xsl:value-of select="concat($ind2, '&lt;/xsl:element&gt;', $cr)"/>

		  <xsl:value-of select="concat($ind1, '&lt;/xsl:element&gt;', $cr)"/>

	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="*" mode="calendar">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="protected" select="ancestor-or-self::*/@protected"/>
		<xsl:variable name="ind2"><xsl:choose><xsl:when test="$protected"><xsl:value-of select="concat($ind1, $tab1)"/></xsl:when><xsl:otherwise><xsl:value-of select="$ind1"/></xsl:otherwise></xsl:choose></xsl:variable>
		<xsl:variable name="indent2"><xsl:choose><xsl:when test="$protected"><xsl:value-of select="$indent+1"/></xsl:when><xsl:otherwise><xsl:value-of select="$indent"/></xsl:otherwise></xsl:choose></xsl:variable>
		<xsl:variable name="ind3" select="concat($ind2, $tab1)"/>
		<xsl:variable name="indent3" select="$indent2+1"/>
		<xsl:variable name="valuetext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>

		<xsl:if test="$protected">
			<xsl:call-template name="XSLConditionStart">
				<xsl:with-param name="indent" select="$indent"/>
				<xsl:with-param name="unprotected" select="$protected"/>
			</xsl:call-template>
		</xsl:if>

		<xsl:call-template name="XSLDblSpace">
			<xsl:with-param name="indent" select="$indent2"/>
		</xsl:call-template>
		<xsl:value-of select="concat($ind2, '&lt;xsl:element name=&quot;IMG&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;name&quot;&gt;Calendar&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;src&quot;&gt;Images/Calendar.gif&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;width&quot;&gt;16&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;height&quot;&gt;16&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;border&quot;&gt;0&lt;/xsl:attribute&gt;', $cr)"/>

		<xsl:if test="@name">
			<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;onclick&quot;&gt;CalendarPopup(document.forms[0], document.getElementById(', $apos, @name, $apos, '))&lt;/xsl:attribute&gt;', $cr)"/>
		</xsl:if>
		<xsl:if test="not(@name)">
			<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;onclick&quot;&gt;CalendarPopup(document.forms[0], document.getElementById(', $apos, $valuetext, $apos, '))&lt;/xsl:attribute&gt;', $cr)"/>
		</xsl:if>

		<xsl:value-of select="concat($ind2, '&lt;/xsl:element&gt;', $cr)"/>

		<xsl:if test="$protected">
			<xsl:call-template name="XSLConditionEnd">
				<xsl:with-param name="indent" select="$indent"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template name="ValidateEventHandler">
	<!--==================================================================-->
	  <xsl:param name="event"/>
	 <!--Test valid attributes-->
	 <xsl:for-each select="@*">
		  <xsl:choose>
				<xsl:when test="name()='escape'"/>
				<xsl:otherwise>
					 <xsl:call-template name="Error">
						  <xsl:with-param name="msg" select="concat($event, ' Invalid Attribute')"/>
						  <xsl:with-param name="text" select="name()"/>
	 				</xsl:call-template>
				</xsl:otherwise>
		  </xsl:choose>
	 </xsl:for-each>
	</xsl:template>

	<!-- JavaScript Function =============================================-->
	<xsl:template match="WTFUNCTION">
	<!--==================================================================-->
		  <xsl:param name="indent"/>
		  <xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		  <xsl:variable name="ind2" select="concat($ind1, $tab1)"/>
		  <xsl:variable name="indent2" select="$indent+1"/>

		  <!-- ***************** Error Checking *******************-->
		  <xsl:if test="not(@name)">
		      <xsl:call-template name="Error">
		      	<xsl:with-param name="msg" select="'WTFUNCTION Name Missing'"/>
		      	<xsl:with-param name="text" select="position()"/>
		      </xsl:call-template>
		  </xsl:if>
		  <!--Test valid attributes-->
		  <xsl:for-each select="@*">
		    <xsl:choose>
		  		<xsl:when test="name()='name'"/>
		  		<xsl:when test="name()='init'"/>
		  		<xsl:otherwise>
		  			 <xsl:call-template name="Error">
		  				  <xsl:with-param name="msg" select="'WTFUNCTION Invalid Attribute'"/>
		  				  <xsl:with-param name="text" select="name()"/>
		  				</xsl:call-template>
		  		</xsl:otherwise>
		    </xsl:choose>
		  </xsl:for-each>
		  <!-- ****************************************************-->

		  <xsl:value-of select="concat($ind1, '&lt;xsl:element name=&quot;SCRIPT&quot;&gt;', $cr)"/>
		  <xsl:value-of select="concat($ind2, '&lt;xsl:attribute name=&quot;language&quot;&gt;JavaScript&lt;/xsl:attribute&gt;', $cr)"/>
		  <xsl:value-of select="concat($ind2, '&lt;xsl:text disable-output-escaping=&quot;yes&quot;&gt;&lt;![CDATA[', @init, ' function ', @name, '{ ', ., ' }]]&gt;&lt;/xsl:text&gt;', $cr)"/>
		  <xsl:value-of select="concat($ind1, '&lt;/xsl:element&gt;', $cr, $cr)"/>
	</xsl:template>

	<!-- JavaScript Function =============================================-->
	<xsl:template match="WTSCRIPT">
	<!--==================================================================-->
		  <xsl:param name="indent"/>
		  <xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		  <xsl:variable name="ind2" select="concat($ind1, $tab1)"/>
		  <xsl:variable name="indent2" select="$indent+1"/>

		  <xsl:value-of select="concat($ind1, '&lt;xsl:element name=&quot;SCRIPT&quot;&gt;', $cr)"/>
		  <xsl:if test="@defer">
			  <xsl:value-of select="concat($ind2, '&lt;xsl:attribute name=&quot;defer&quot;&gt;', @defer, '&lt;/xsl:attribute&gt;', $cr)"/>
		  </xsl:if>
		  <xsl:if test="@type">
			  <xsl:value-of select="concat($ind2, '&lt;xsl:attribute name=&quot;type&quot;&gt;', @type, '&lt;/xsl:attribute&gt;', $cr)"/>
		  </xsl:if>
		  <xsl:if test="@src">
			  <xsl:value-of select="concat($ind2, '&lt;xsl:attribute name=&quot;src&quot;&gt;', @src, '&lt;/xsl:attribute&gt;', $cr)"/>
		  </xsl:if>
		  <xsl:value-of select="concat($ind1, '&lt;/xsl:element&gt;', $cr, $cr)"/>

	</xsl:template>

	<!-- JavaScript Function =============================================-->
	<xsl:template name="GoogleLog">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="ind2" select="concat($ind1, $tab1)"/>
		<xsl:variable name="ind3" select="concat($ind2, $tab1)"/>
		<xsl:variable name="indent2" select="$indent+1"/>

		<xsl:value-of select="concat($ind1, '&lt;xsl:element name=&quot;SCRIPT&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($ind2, '(function(i,s,o,g,r,a,m){i[', $apos, 'GoogleAnalyticsObject', $apos, ']=r;i[r]=i[r]||function(){', $cr)"/>
		<xsl:value-of select="concat($ind2, '(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),', $cr)"/>
		<xsl:value-of select="concat($ind2, 'm=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)', $cr)"/>
		<xsl:value-of select="concat($ind2, '})(window,document,', $apos, 'script', $apos, ',', $apos, '//www.google-analytics.com/analytics.js', $apos, ',', $apos, 'ga', $apos, ');', $cr)"/>
		<xsl:value-of select="concat($ind2, 'var tmpID = ', $apos, '&lt;xsl:value-of select=&quot;/DATA/SYSTEM/@ga_acctid&quot;/&gt;', $apos, $cr)"/>
		<xsl:value-of select="concat($ind2, 'var tmpDomain = ', $apos, '&lt;xsl:value-of select=&quot;/DATA/SYSTEM/@ga_domain&quot;/&gt;', $apos, $cr)"/>

		<xsl:if test="string(number(/Data/WTENTITY/WTWEBPAGE/@track)) != 'NaN' or $TrackAction">
			<xsl:value-of select="concat($ind2, 'var tmpAction = ', $apos, '&lt;xsl:value-of select=&quot;/DATA/SYSTEM/@actioncode&quot;/&gt;', $apos, $cr)"/>
		</xsl:if>

		<xsl:value-of select="concat($ind2, '&lt;xsl:text disable-output-escaping=&quot;yes&quot;&gt;', 'if( tmpID.length != 0 &amp;amp;&amp;amp; tmpDomain.length != 0')"/>

		<xsl:if test="string(number(/Data/WTENTITY/WTWEBPAGE/@track)) != 'NaN' or $TrackAction">
			<xsl:value-of select="' &amp;amp;&amp;amp; ('"/>
			<xsl:if test="string(number(/Data/WTENTITY/WTWEBPAGE/@track)) != 'NaN'">
				<xsl:value-of select="concat('tmpAction = ', $apos, /Data/WTENTITY/WTWEBPAGE/@track, $apos )"/>
				<xsl:if test="$TrackAction">
					<xsl:value-of select="' || '"/>
				</xsl:if>
			</xsl:if>

			<xsl:for-each select="/Data/WTENTITY/WTWEBPAGE/WTTRACK[@action]">
				<xsl:if test="position() != 1"><xsl:value-of select="' || '"/></xsl:if>
				<xsl:value-of select="concat('tmpAction = ', $apos, @action, $apos )"/>
			</xsl:for-each>

			<xsl:value-of select="')'"/>
		</xsl:if>

		<xsl:value-of select="concat(' ) {', '&lt;/xsl:text&gt;', $cr)"/>
		<xsl:value-of select="concat($ind3, 'ga(', $apos, 'create', $apos, ', tmpID, tmpDomain);', $cr)"/>
		<xsl:value-of select="concat($ind3, 'ga(', $apos, 'send', $apos, ', ', $apos, 'pageview', $apos, ');', $cr)"/>
		<xsl:value-of select="concat($ind2, '}', $cr)"/>
		<xsl:value-of select="concat($ind1, '&lt;/xsl:element&gt;', $cr)"/>
	</xsl:template>

	<!-- Event Handler for Window -->
	<!--==================================================================-->
	<xsl:template match="WTLOAD">
	<!--==================================================================-->
		  <xsl:param name="indent"/>
		  <xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>

		  <!-- ***************** Error Checking *******************-->
		  <xsl:call-template name="ValidateEventHandler">
		  	<xsl:with-param name="event">WTLOAD</xsl:with-param>
		  </xsl:call-template>
		  <!-- ****************************************************-->

		  <xsl:value-of select="concat($ind1, '&lt;xsl:attribute name=&quot;onLoad&quot;&gt;')"/>
		  <xsl:if test="not(@escape)">
			  <xsl:value-of select="concat('&lt;xsl:text disable-output-escaping=&quot;yes&quot;&gt;&lt;![CDATA[', ., ']]&gt;&lt;/xsl:text&gt;' )"/>
		  </xsl:if>
		  <xsl:if test="@escape">
			  <xsl:value-of select="."/>
		  </xsl:if>
			<xsl:if test="/Data/WTENTITY/WTWEBPAGE/@top">
					<xsl:value-of select="concat(';location.hash=',$apos,'#top',$apos,';')"/>
			</xsl:if>
		  <xsl:value-of select="concat('&lt;/xsl:attribute&gt;', $cr)"/>
	</xsl:template>

	<!-- Event Handler for Window -->
	<!--==================================================================-->
	<xsl:template match="WTUNLOAD">
	<!--==================================================================-->
		  <xsl:param name="indent"/>
		  <xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
	 
		  <!-- ***************** Error Checking *******************-->
		  <xsl:call-template name="ValidateEventHandler">
		  	<xsl:with-param name="event">WTUNLOAD</xsl:with-param>
		  </xsl:call-template>
		  <!-- ****************************************************-->

		  <xsl:value-of select="concat($ind1, '&lt;xsl:attribute name=&quot;onunload&quot;&gt;')"/>
		  <xsl:if test="not(@escape)">
			  <xsl:value-of select="concat('&lt;xsl:text disable-output-escaping=&quot;yes&quot;&gt;&lt;![CDATA[', ., ']]&gt;&lt;/xsl:text&gt;' )"/>
		  </xsl:if>
		  <xsl:if test="@escape">
			  <xsl:value-of select="."/>
		  </xsl:if>
		  <xsl:value-of select="concat('&lt;/xsl:attribute&gt;', $cr)"/>
	</xsl:template>

	<!-- Event Handler for Form -->
	<!--==================================================================-->
	<xsl:template match="WTSUBMIT">
	<!--==================================================================-->
		  <xsl:param name="indent"/>
		  <xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>

		  <!-- ***************** Error Checking *******************-->
		  <xsl:call-template name="ValidateEventHandler">
		  	<xsl:with-param name="event">WTSUBMIT</xsl:with-param>
		  </xsl:call-template>
		  <!-- ****************************************************-->

		  <xsl:value-of select="concat($ind1, '&lt;xsl:attribute name=&quot;onsubmit&quot;&gt;')"/>
		  <xsl:if test="not(@escape)">
			  <xsl:value-of select="concat('&lt;xsl:text disable-output-escaping=&quot;yes&quot;&gt;&lt;![CDATA[', ., ']]&gt;&lt;/xsl:text&gt;' )"/>
		  </xsl:if>
		  <xsl:if test="@escape">
			  <xsl:value-of select="."/>
		  </xsl:if>
		  <xsl:value-of select="concat('&lt;/xsl:attribute&gt;', $cr)"/>
	</xsl:template>

	<!-- Event Handler for Button, Checkbox, radio -->
	<!--==================================================================-->
	<xsl:template match="WTCLICK">
	<!--==================================================================-->
		  <xsl:param name="indent"/>
		  <xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>

		  <!-- ***************** Error Checking *******************-->
		  <xsl:call-template name="ValidateEventHandler">
		  	<xsl:with-param name="event">WTCLICK</xsl:with-param>
		  </xsl:call-template>
		  <!-- ****************************************************-->

		  <xsl:value-of select="concat($ind1, '&lt;xsl:attribute name=&quot;onclick&quot;&gt;')"/>
		  <xsl:if test="not(@escape)">
			  <xsl:value-of select="concat('&lt;xsl:text disable-output-escaping=&quot;yes&quot;&gt;&lt;![CDATA[', ., ']]&gt;&lt;/xsl:text&gt;' )"/>
		  </xsl:if>
		  <xsl:if test="@escape">
			  <xsl:value-of select="."/>
		  </xsl:if>
		  <xsl:value-of select="concat('&lt;/xsl:attribute&gt;', $cr)"/>
		  <xsl:if test="@target">
			  <xsl:value-of select="concat($ind1, '&lt;xsl:attribute target=&quot;', @target, '&quot;/&gt;')"/>
		  </xsl:if>

	</xsl:template>

	<!-- Event Handler for Text, Textarea, Select -->
	<!--==================================================================-->
	<xsl:template match="WTENTER">
	<!--==================================================================-->
		  <xsl:param name="indent"/>
		  <xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>

		  <!-- ***************** Error Checking *******************-->
		  <xsl:call-template name="ValidateEventHandler">
		  	<xsl:with-param name="event">WTENTER</xsl:with-param>
		  </xsl:call-template>
		  <!-- ****************************************************-->

		  <xsl:value-of select="concat($ind1, '&lt;xsl:attribute name=&quot;onfocus&quot;&gt;')"/>
		  <xsl:if test="not(@escape)">
			  <xsl:value-of select="concat('&lt;xsl:text disable-output-escaping=&quot;yes&quot;&gt;&lt;![CDATA[', ., ']]&gt;&lt;/xsl:text&gt;' )"/>
		  </xsl:if>
		  <xsl:if test="@escape">
			  <xsl:value-of select="."/>
		  </xsl:if>
		  <xsl:value-of select="concat('&lt;/xsl:attribute&gt;', $cr)"/>
	</xsl:template>

	<!-- Event Handler for Text, Textarea, Select -->
	<!--==================================================================-->
	<xsl:template match="WTCHANGE">
	<!--==================================================================-->
		  <xsl:param name="indent"/>
		  <xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>

		  <!-- ***************** Error Checking *******************-->
		  <xsl:call-template name="ValidateEventHandler">
		  	<xsl:with-param name="event">WTCHANGE</xsl:with-param>
		  </xsl:call-template>
		  <!-- ****************************************************-->

		  <xsl:value-of select="concat($ind1, '&lt;xsl:attribute name=&quot;onchange&quot;&gt;')"/>
		  <xsl:if test="not(@escape)">
			  <xsl:value-of select="concat('&lt;xsl:text disable-output-escaping=&quot;yes&quot;&gt;&lt;![CDATA[', ., ']]&gt;&lt;/xsl:text&gt;' )"/>
		  </xsl:if>
		  <xsl:if test="@escape">
			  <xsl:value-of select="."/>
		  </xsl:if>
		  <xsl:value-of select="concat('&lt;/xsl:attribute&gt;', $cr)"/>
	</xsl:template>

	<!-- Event Handler for Text, Textarea, Select -->
	<!--==================================================================-->
	<xsl:template match="WTEXIT">
	<!--==================================================================-->
		  <xsl:param name="indent"/>
		  <xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>

		  <!-- ***************** Error Checking *******************-->
		  <xsl:call-template name="ValidateEventHandler">
		  	<xsl:with-param name="event">WTEXIT</xsl:with-param>
		  </xsl:call-template>
		  <!-- ****************************************************-->

		  <xsl:value-of select="concat($ind1, '&lt;xsl:attribute name=&quot;onblur&quot;&gt;')"/>
		  <xsl:if test="not(@escape)">
			  <xsl:value-of select="concat('&lt;xsl:text disable-output-escaping=&quot;yes&quot;&gt;&lt;![CDATA[', ., ']]&gt;&lt;/xsl:text&gt;' )"/>
		  </xsl:if>
		  <xsl:if test="@escape">
			  <xsl:value-of select="."/>
		  </xsl:if>
		  <xsl:value-of select="concat('&lt;/xsl:attribute&gt;', $cr)"/>
	</xsl:template>

	<!-- Event Handler for Text, Textarea, Select -->
	<!--==================================================================-->
	<xsl:template match="WTKEY">
	<!--==================================================================-->
		  <xsl:param name="indent"/>
		  <xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>

		  <!-- ***************** Error Checking *******************-->
		  <xsl:call-template name="ValidateEventHandler">
		  	<xsl:with-param name="event">WTKEY</xsl:with-param>
		  </xsl:call-template>
		  <!-- ****************************************************-->

		  <xsl:value-of select="concat($ind1, '&lt;xsl:attribute name=&quot;onkeyup&quot;&gt;')"/>
		  <xsl:if test="not(@escape)">
			  <xsl:value-of select="concat('&lt;xsl:text disable-output-escaping=&quot;yes&quot;&gt;&lt;![CDATA[', ., ']]&gt;&lt;/xsl:text&gt;' )"/>
		  </xsl:if>
		  <xsl:if test="@escape">
			  <xsl:value-of select="."/>
		  </xsl:if>
		  <xsl:value-of select="concat('&lt;/xsl:attribute&gt;', $cr)"/>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTBUTTON">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:param name="wrap" select="false()"/>
		<xsl:variable name="hasconditions" select="(count(WTCONDITION) > 0)"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="ind2"><xsl:choose><xsl:when test="$hasconditions"><xsl:value-of select="concat($ind1, $tab1)"/></xsl:when><xsl:otherwise><xsl:value-of select="$ind1"/></xsl:otherwise></xsl:choose></xsl:variable>
		<xsl:variable name="indent2"><xsl:choose><xsl:when test="$hasconditions"><xsl:value-of select="$indent+1"/></xsl:when><xsl:otherwise><xsl:value-of select="$indent"/></xsl:otherwise></xsl:choose></xsl:variable>
		<xsl:variable name="ind3" select="concat($ind2, $tab1)"/>
		<xsl:variable name="indent3" select="$indent2+1"/>
		<xsl:variable name="ind4" select="concat($ind3, $tab1)"/>
		<xsl:variable name="indent4" select="$indent3+1"/>
		<xsl:variable name="ind5" select="concat($ind4, $tab1)"/>
		<xsl:variable name="valuetext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>

	 <!-- ***************** Error Checking *******************-->
	<xsl:if test="not(ancestor::WTSTATIC) and not(ancestor::WTBUTTON) and not(ancestor::WTTREE) and not(ancestor::WTTREE2) and not(ancestor::WTDIVISION) and (ancestor::WTROW)">
		<xsl:if test="not(@col)">
			<xsl:call-template name="Error">
	     		<xsl:with-param name="msg" select="'WTBUTTON Column Missing'"/>
	     		<xsl:with-param name="text" select="position()"/>
			</xsl:call-template>
		</xsl:if>
	 </xsl:if>

	 <!--Test valid attributes-->
	 <xsl:for-each select="@*">
			<xsl:variable name="testcol">
				<xsl:call-template name="TestColAttr">
					<xsl:with-param name="attr" select="name()"/>
				</xsl:call-template>
			</xsl:variable>
		   <xsl:if test="$testcol='0'">
				<xsl:choose>
	 				<xsl:when test="name()='name'"/>
	 				<xsl:when test="name()='id'"/>
	 				<xsl:when test="name()='action'"/>
	 				<xsl:when test="name()='msg'"/>
	 				<xsl:when test="name()='default'"/>
	 				<xsl:when test="name()='disable'"/>
	 				<xsl:when test="name()='disabled'"/>
	 				<xsl:when test="name()='btnclass'"/>
	 				<xsl:when test="name()='valuex'"/>
	 				<xsl:when test="name()='valuez'"/>
          <xsl:when test="name()='new'"/>
          <xsl:when test="name()='clipboard'"/>
          <xsl:when test="name()='style'"/>
          <xsl:otherwise>
						 <xsl:call-template name="Error">
							  <xsl:with-param name="msg" select="'WTBUTTON Invalid Attribute'"/>
							  <xsl:with-param name="text" select="name()"/>
	 					</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose>
		   </xsl:if>
	 </xsl:for-each>
	 <!-- ****************************************************-->

		<!--begin the column tag-->
		<xsl:if test="not(ancestor::WTSTATIC) and not(ancestor::WTBUTTON) and not(ancestor::WTTREE) and not(ancestor::WTTREE2) and not(ancestor::WTDIVISION) and (ancestor::WTROW)">
			<xsl:apply-templates select="." mode="cell-begin">
				<xsl:with-param name="indent" select="$indent"/>
				<xsl:with-param name="wrap" select="$wrap"/>
				<xsl:with-param name="isfirst" select="position()=1"/>
			</xsl:apply-templates>
		</xsl:if>

		<!--generate IF statement for conditions if they exist-->
		<xsl:if test="($hasconditions)">
			<xsl:call-template name="XSLConditionStart">
				<xsl:with-param name="indent" select="$indent2"/>
				<xsl:with-param name="conditions" select="WTCONDITION"/>
			</xsl:call-template>
		</xsl:if>

		<xsl:if test="not(ancestor::WTROW) and @align='center'">
			<xsl:value-of select="concat($ind2, '&lt;xsl:element name=&quot;CENTER&quot;&gt;', $cr)"/>
		</xsl:if>

		<xsl:if test="not(@new)">
			<!--build the input control-->
			<xsl:value-of select="concat($ind3, '&lt;xsl:element name=&quot;INPUT&quot;&gt;', $cr)"/>
			<xsl:if test="@default">
				<xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;type&quot;&gt;submit&lt;/xsl:attribute&gt;', $cr)"/>
			</xsl:if>
			<xsl:if test="not(@default)">
				<xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;type&quot;&gt;button&lt;/xsl:attribute&gt;', $cr)"/>
			</xsl:if>
      <xsl:if test="@id">
        <xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;id&quot;&gt;', @id, '&lt;/xsl:attribute&gt;', $cr)"/>
      </xsl:if>
      <xsl:if test="@style">
        <xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;style&quot;&gt;', @style, '&lt;/xsl:attribute&gt;', $cr)"/>
      </xsl:if>
      <xsl:if test="@btnclass">
        <xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;class&quot;&gt;', @btnclass, '&lt;/xsl:attribute&gt;', $cr)"/>
      </xsl:if>
      <xsl:if test="@clipboard">
        <xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;data-clipboard-target&quot;&gt;', @clipboard, '&lt;/xsl:attribute&gt;', $cr)"/>
      </xsl:if>
      <xsl:if test="@disabled">
					<xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;DISABLED&quot;/&gt;', $cr)"/>
			</xsl:if>
			<xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;value&quot;&gt;', $cr)"/>
		</xsl:if>
		<xsl:if test="@new">
			<!--build the button control-->
			<xsl:value-of select="concat($ind3, '&lt;xsl:element name=&quot;BUTTON&quot;&gt;', $cr)"/>
		</xsl:if>

		<xsl:choose>
			<xsl:when test="WTSTATIC">
				<xsl:apply-templates select="WTSTATIC">
					<xsl:with-param name="indent" select="$indent4"/>
				</xsl:apply-templates>
			</xsl:when>
			<xsl:when test="@valuex">
				<xsl:value-of select="concat($ind5, '&lt;xsl:value-of select=&quot;', $apos, @valuex, $apos, '&quot;/&gt;', $cr)"/>
			</xsl:when>
			<xsl:when test="@valuez">
				<xsl:value-of select="concat($ind5, '&lt;xsl:value-of select=&quot;', @valuez, '&quot;/&gt;', $cr)"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$ind5"/>
				<xsl:call-template name="XSLLabelText">
					<xsl:with-param name="label" select="$valuetext"/>
					<xsl:with-param name="newline" select="true()"/>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
		
		<xsl:if test="not(@new)">
			<xsl:value-of select="concat($ind4, '&lt;/xsl:attribute&gt;', $cr)"/>
		</xsl:if>
		
		<xsl:variable name="disable">
			<xsl:if test="@disable">; this.disabled = true</xsl:if>
		</xsl:variable>

		<xsl:choose>
			<xsl:when test="WTCLICK">
				<xsl:apply-templates select="WTCLICK">
					<xsl:with-param name="indent" select="$indent4"/>
				</xsl:apply-templates>
			</xsl:when>
			<xsl:when test="/Data/WTENTITY/WTWEBPAGE/@action='false'">
			</xsl:when>
			<xsl:when test="(@msg)">
				<xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;onclick&quot;&gt;doSubmit(', @action, ',', $apos)"/>
				<xsl:call-template name="XSLLabelText">
					<xsl:with-param name="label" select="@msg"/>
					<xsl:with-param name="newline" select="false()"/>
				</xsl:call-template>
				<xsl:value-of select="concat($apos, ')', $disable, '&lt;/xsl:attribute&gt;', $cr)"/>
			</xsl:when>
			<xsl:otherwise>
        <xsl:if test="@action">
          <xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;onclick&quot;&gt;doSubmit(', @action, ',&quot;&quot;)', $disable, '&lt;/xsl:attribute&gt;', $cr)"/>
        </xsl:if>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:value-of select="concat($ind3, '&lt;/xsl:element&gt;', $cr)"/>

		<xsl:if test="not(ancestor::WTROW) and @align='center'">
			<xsl:value-of select="concat($ind2, '&lt;/xsl:element&gt;', $cr)"/>
		</xsl:if>
		
		<!--close IF statement for conditions if they exist-->
		<xsl:if test="($hasconditions)">
			<xsl:call-template name="XSLConditionEnd">
				<xsl:with-param name="indent" select="$indent2"/>			
			</xsl:call-template>
		</xsl:if>

		<!--end the column tag-->
		<xsl:if test="not(ancestor::WTSTATIC) and not(ancestor::WTBUTTON) and not(ancestor::WTTREE) and not(ancestor::WTTREE2) and not(ancestor::WTDIVISION) and (ancestor::WTROW)">
			<xsl:apply-templates select="." mode="cell-end">
				<xsl:with-param name="indent" select="$indent"/>
				<xsl:with-param name="wrap" select="$wrap"/>
				<xsl:with-param name="islast" select="position()=last()"/>
			</xsl:apply-templates>
		</xsl:if>
	</xsl:template>

	<!--==================================================================-->
	<!-- Test for the common column attributes                            -->
	<!--==================================================================-->
	<xsl:template name="TestColAttr">
	<!--==================================================================-->
		  <xsl:param name="attr"/>
		  <xsl:choose>
				<xsl:when test="$attr='col'"/>
				<xsl:when test="$attr='colid'"/>
				<xsl:when test="$attr='merge'"/>
				<xsl:when test="$attr='value'"/>
				<xsl:when test="$attr='width'"/>
				<xsl:when test="$attr='headerwidth'"/>
				<xsl:when test="$attr='align'"/>
				<xsl:when test="$attr='valign'"/>
				<xsl:when test="$attr='height'"/>
				<xsl:when test="$attr='class'"/>
				<xsl:when test="$attr='focus'"/>
				<xsl:when test="$attr='prespace'"/>
				<xsl:when test="$attr='noprespace'"/>
				<xsl:when test="$attr='backcolor'"/>
			  <xsl:when test="$attr='bgimg'"/>
			  <xsl:when test="$attr='background'"/>
			  <xsl:when test="$attr='rowspan'"/>
				<xsl:when test="$attr='requiremark'"/>
				<xsl:when test="$attr='style'"/>
				<xsl:otherwise>0</xsl:otherwise>
		  </xsl:choose>
	</xsl:template>
		
	<!--==================================================================-->
	<xsl:template match="WTCHECK">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:param name="wrap" select="false()"/>
		<xsl:variable name="hasconditions" select="(count(WTCONDITION) > 0)"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="ind2" select="concat($ind1, $tab1)"/>
		<xsl:variable name="indent2" select="$indent+1"/>
		<xsl:variable name="ind3"><xsl:choose><xsl:when test="$hasconditions"><xsl:value-of select="concat($ind2, $tab1)"/></xsl:when><xsl:otherwise><xsl:value-of select="$ind2"/></xsl:otherwise></xsl:choose></xsl:variable>
		<xsl:variable name="indent3"><xsl:choose><xsl:when test="$hasconditions"><xsl:value-of select="$indent2 +1"/></xsl:when><xsl:otherwise><xsl:value-of select="$indent2"/></xsl:otherwise></xsl:choose></xsl:variable>
		<xsl:variable name="ind4" select="concat($ind3, $tab1)"/>
		<xsl:variable name="indent4" select="$indent3+1"/>
		  <xsl:variable name="valuetype"><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>
		  <xsl:variable name="valuetext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>
		  <xsl:variable name="valueentity"><xsl:call-template name="QualifiedPrefix"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>
		<xsl:variable name="attribute" select="/Data/WTENTITY/WTATTRIBUTE[@name=$valuetext]"/>

	 <!-- ***************** Error Checking *******************-->
	 <xsl:if test="not(ancestor::WTSTATIC) and not(ancestor::WTTREE) and not(ancestor::WTTREE2)">
		<xsl:if test="not(@col)">
		    <xsl:call-template name="Error">
		    	<xsl:with-param name="msg" select="'WTCHECK Column Missing'"/>
		    	<xsl:with-param name="text" select="position()"/>
		    </xsl:call-template>
		</xsl:if>
	 </xsl:if>
	 <!--Test valid attributes-->
	 <xsl:for-each select="@*">
			<xsl:variable name="testcol">
				<xsl:call-template name="TestColAttr">
					<xsl:with-param name="attr" select="name()"/>
				</xsl:call-template>
			</xsl:variable>
		   <xsl:if test="$testcol='0'">
				<xsl:choose>
					<xsl:when test="name()='name'"/>
					<xsl:when test="name()='label'"/>
					<xsl:when test="name()='action'"/>
					<xsl:when test="name()='datapath'"/>
					<xsl:when test="name()='datapathx'"/>
		  		<xsl:when test="name()='disabled'"/>
		  		<xsl:when test="name()='check'"/>
		  		<xsl:when test="name()='translate'"/>
          <xsl:when test="name()='bold'"/>
          <xsl:when test="name()='space'"/>
          <xsl:when test="name()='checkclass'"/>
          <xsl:otherwise>
						 <xsl:call-template name="Error">
							  <xsl:with-param name="msg" select="'WTCHECK Invalid Attribute'"/>
							  <xsl:with-param name="text" select="name()"/>
	 					</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose>
		   </xsl:if>
	 </xsl:for-each>
	 <!-- ****************************************************-->

		<!--begin the column tag-->
		<xsl:if test="@col">
			<xsl:apply-templates select="." mode="cell-begin">
				<xsl:with-param name="indent" select="$indent"/>
				<xsl:with-param name="wrap" select="$wrap"/>
				<xsl:with-param name="isfirst" select="position()=1"/>
			</xsl:apply-templates>
	   </xsl:if>

		<!--generate IF statement for conditions if they exist-->
		<xsl:if test="($hasconditions)">
			<xsl:call-template name="XSLConditionStart">
				<xsl:with-param name="indent" select="$indent2"/>
				<xsl:with-param name="conditions" select="WTCONDITION"/>
			</xsl:call-template>
		</xsl:if>

		<!--build the input control-->
		<xsl:value-of select="concat($ind2, '&lt;xsl:element name=&quot;INPUT&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;type&quot;&gt;checkbox&lt;/xsl:attribute&gt;', $cr)"/>
    <xsl:if test="@checkclass">
      <xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;class&quot;&gt;', @checkclass, '&lt;/xsl:attribute&gt;', $cr)"/>
    </xsl:if>

    <xsl:choose>
			<xsl:when test="@name">
			
				<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;name&quot;&gt;', @name, '&lt;/xsl:attribute&gt;', $cr)"/>
        <xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;id&quot;&gt;', @name, '&lt;/xsl:attribute&gt;', $cr)"/>

        <xsl:choose>
					 <xsl:when test="@check='false'"/>
					 <xsl:when test="@check='true'">
					 	<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;CHECKED&quot;/&gt;', $cr)"/>
					 </xsl:when>
          <xsl:when test="@check='first'">
            <xsl:value-of select="concat($ind3, '&lt;xsl:if test=&quot;position()=1&quot;&gt;', $cr)"/>
            <xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;CHECKED&quot;/&gt;', $cr)"/>
            <xsl:value-of select="concat($ind3, '&lt;/xsl:if&gt;', $cr)"/>
          </xsl:when>
          <xsl:when test="@check">
					 	<xsl:value-of select="concat($ind3, '&lt;xsl:if test=&quot;', @check, '&quot;&gt;', $cr)"/>
					 	<xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;CHECKED&quot;/&gt;', $cr)"/>
					 	<xsl:value-of select="concat($ind3, '&lt;/xsl:if&gt;', $cr)"/>
					 </xsl:when>
					 <xsl:when test="@datapath">
					 	<xsl:value-of select="concat($ind3, '&lt;xsl:if test=&quot;', @datapath, '=', $apos, 'on', $apos, '&quot;&gt;', $cr)"/>
					 	<xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;CHECKED&quot;/&gt;', $cr)"/>
					 	<xsl:value-of select="concat($ind3, '&lt;/xsl:if&gt;', $cr)"/>
					 </xsl:when>
					 <xsl:when test="@datapathx">
					 	<xsl:value-of select="concat($ind3, '&lt;xsl:if test=&quot;', @datapathx, '&quot;&gt;', $cr)"/>
					 	<xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;CHECKED&quot;/&gt;', $cr)"/>
					 	<xsl:value-of select="concat($ind3, '&lt;/xsl:if&gt;', $cr)"/>
					 </xsl:when>
					 <xsl:when test="not($valuetext='')">
					 	<xsl:value-of select="concat($ind3, '&lt;xsl:if test=&quot;', $valuetext, '=', $apos, 'on', $apos, '&quot;&gt;', $cr)"/>
					 	<xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;CHECKED&quot;/&gt;', $cr)"/>
					 	<xsl:value-of select="concat($ind3, '&lt;/xsl:if&gt;', $cr)"/>
					 </xsl:when>
				</xsl:choose>

        <xsl:if test="@space">
          <xsl:call-template name="XSLSpace">
            <xsl:with-param name="indent" select="$indent"/>
            <xsl:with-param name="space" select="@space"/>
          </xsl:call-template>
        </xsl:if>

        <xsl:choose>
					 <xsl:when test="@label">
             <xsl:call-template name="XSLLabelText">
								<xsl:with-param name="label" select="@label"/>
								<xsl:with-param name="indent" select="$indent3"/>
								<xsl:with-param name="newline" select="true()"/>
						  </xsl:call-template>
					 </xsl:when>
<!--
					 <xsl:otherwise>
						  <xsl:call-template name="XSLLabelText">
								<xsl:with-param name="label" select="@name"/>
								<xsl:with-param name="indent" select="$indent3"/>
								<xsl:with-param name="newline" select="true()"/>
						  </xsl:call-template>
					 </xsl:otherwise>
-->					 
				</xsl:choose>
					
				<xsl:apply-templates select="WTCLICK">
					<xsl:with-param name="indent" select="$indent3"/>
				</xsl:apply-templates>
			</xsl:when>

			<xsl:otherwise>
			
				<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;name&quot;&gt;', $valuetext, '&lt;/xsl:attribute&gt;', $cr)"/>
				<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;id&quot;&gt;', $valuetext, '&lt;/xsl:attribute&gt;', $cr)"/>
				<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;value&quot;&gt;1&lt;/xsl:attribute&gt;', $cr)"/>

				<xsl:apply-templates select="WTCLICK">
					<xsl:with-param name="indent" select="$indent3"/>
				</xsl:apply-templates>
<!--
				<xsl:variable name="datapath">
					<xsl:call-template name="XSLDataField">
						<xsl:with-param name="entity" select="$valueentity"/>
						<xsl:with-param name="name" select="$valuetext"/>
						<xsl:with-param name="newline" select="false()"/>
						<xsl:with-param name="noselect" select="true()"/>
					</xsl:call-template>
				</xsl:variable>
-->
				<xsl:variable name="val">
					  <xsl:call-template name="GetValue">
	 					  <xsl:with-param name="type" select="$valuetype"/>
	 					  <xsl:with-param name="text" select="$valuetext"/>
						  <xsl:with-param name="entity" select="$valueentity"/>
	 					  <xsl:with-param name="noselect" select="true()"/>
					  </xsl:call-template>
				</xsl:variable>

				<xsl:value-of select="concat($ind3, '&lt;xsl:if test=&quot;(', $val, ' = '1')&quot;&gt;&lt;xsl:attribute name=&quot;CHECKED&quot;/&gt;&lt;/xsl:if&gt;', $cr)"/>

<!--
				<xsl:apply-templates select="." mode="read-only">
					<xsl:with-param name="indent" select="$indent3"/>
				</xsl:apply-templates>
-->
				<xsl:if test="@bold">
					<xsl:value-of select="concat($ind3, '&lt;xsl:element name=&quot;b&quot;&gt;', $cr)"/>
				</xsl:if>

        <xsl:if test="@space">
          <xsl:call-template name="XSLSpace">
            <xsl:with-param name="indent" select="$indent"/>
            <xsl:with-param name="space" select="@space"/>
          </xsl:call-template>
        </xsl:if>

        <xsl:choose>
					 <xsl:when test="@label">
						 <xsl:if test="not(@label='false')">
							 <xsl:call-template name="XSLLabelText">
								<xsl:with-param name="label" select="@label"/>
								<xsl:with-param name="indent" select="$indent3"/>
								<xsl:with-param name="newline" select="true()"/>
							  </xsl:call-template>
						 </xsl:if>
					 </xsl:when>
					<xsl:otherwise>
						<xsl:call-template name="XSLLabelText">
							<xsl:with-param name="label" select="$valuetext"/>
							<xsl:with-param name="indent" select="$indent3"/>
							<xsl:with-param name="newline" select="true()"/>
						</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose>

				<xsl:if test="@bold">
					<xsl:value-of select="concat($ind3, '&lt;/xsl:element&gt;', $cr)"/>
				</xsl:if>

			</xsl:otherwise>
		</xsl:choose>

		<!--disable the field if specified-->
		<xsl:if test="@disabled">
			<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;DISABLED&quot;/&gt;', $cr)"/>
		</xsl:if>

		<xsl:value-of select="concat($ind2, '&lt;/xsl:element&gt;', $cr)"/>

		<xsl:if test="($hasconditions)">
			<xsl:call-template name="XSLConditionEnd">
				<xsl:with-param name="indent" select="$indent2"/>			
			</xsl:call-template>
		</xsl:if>

		<!--end the column tag-->
		<xsl:if test="@col">
			<xsl:apply-templates select="." mode="cell-end">
				<xsl:with-param name="indent" select="$indent"/>
				<xsl:with-param name="wrap" select="$wrap"/>
				<xsl:with-param name="islast" select="position()=last()"/>
			</xsl:apply-templates>
		</xsl:if>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTRADIO">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:param name="wrap" select="false()"/>
		<xsl:variable name="hasconditions" select="(count(WTCONDITION) > 0)"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="ind2" select="concat($ind1, $tab1)"/>
		<xsl:variable name="indent2" select="$indent+1"/>
		<xsl:variable name="ind3"><xsl:choose><xsl:when test="$hasconditions"><xsl:value-of select="concat($ind2, $tab1)"/></xsl:when><xsl:otherwise><xsl:value-of select="$ind2"/></xsl:otherwise></xsl:choose></xsl:variable>
		<xsl:variable name="indent3"><xsl:choose><xsl:when test="$hasconditions"><xsl:value-of select="$indent2 +1"/></xsl:when><xsl:otherwise><xsl:value-of select="$indent2"/></xsl:otherwise></xsl:choose></xsl:variable>
		<xsl:variable name="ind4" select="concat($ind3, $tab1)"/>
		<xsl:variable name="indent4" select="$indent3+1"/>
		  <xsl:variable name="valuetype"><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>
		  <xsl:variable name="valuetext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>
		  <xsl:variable name="valueentity"><xsl:call-template name="QualifiedPrefix"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>
		  <xsl:variable name="datapathtext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@datapath"/></xsl:call-template></xsl:variable>
		<xsl:variable name="attribute" select="/Data/WTENTITY/WTATTRIBUTE[@name=$valuetext]"/>

	 <!-- ***************** Error Checking *******************-->
	 <xsl:if test="not(ancestor::WTSTATIC) and not(ancestor::WTTREE) and not(ancestor::WTTREE2)">
		<xsl:if test="not(@col)">
		    <xsl:call-template name="Error">
		    	<xsl:with-param name="msg" select="'WTRADIO Column Missing'"/>
		    	<xsl:with-param name="text" select="position()"/>
		    </xsl:call-template>
		</xsl:if>
	 </xsl:if>
	 <!--Test valid attributes-->
	 <xsl:for-each select="@*">
			<xsl:variable name="testcol">
				<xsl:call-template name="TestColAttr">
					<xsl:with-param name="attr" select="name()"/>
				</xsl:call-template>
			</xsl:variable>
		   <xsl:if test="$testcol='0'">
				<xsl:choose>
					<xsl:when test="name()='name'"/>
					<xsl:when test="name()='group'"/>
					<xsl:when test="name()='label'"/>
					<xsl:when test="name()='datapath'"/>
					<xsl:when test="name()='datapathx'"/>
		  			<xsl:when test="name()='disabled'"/>
		  			<xsl:when test="name()='check'"/>
		  			<xsl:when test="name()='translate'"/>
					<xsl:otherwise>
						 <xsl:call-template name="Error">
							  <xsl:with-param name="msg" select="'WTRADIO Invalid Attribute'"/>
							  <xsl:with-param name="text" select="name()"/>
	 					</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose>
		   </xsl:if>
	 </xsl:for-each>
	 <!-- ****************************************************-->

		<!--begin the column tag-->
		<xsl:if test="@col">
			<xsl:apply-templates select="." mode="cell-begin">
				<xsl:with-param name="indent" select="$indent"/>
				<xsl:with-param name="wrap" select="$wrap"/>
				<xsl:with-param name="isfirst" select="position()=1"/>
			</xsl:apply-templates>
		</xsl:if>

		<!--generate IF statement for conditions if they exist-->
		<xsl:if test="($hasconditions)">
			<xsl:call-template name="XSLConditionStart">
				<xsl:with-param name="indent" select="$indent2"/>
				<xsl:with-param name="conditions" select="WTCONDITION"/>
			</xsl:call-template>
		</xsl:if>

		<!--build the input control-->
		<xsl:value-of select="concat($ind2, '&lt;xsl:element name=&quot;INPUT&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;type&quot;&gt;radio&lt;/xsl:attribute&gt;', $cr)"/>

		<xsl:if test="@group">
		 	<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;name&quot;&gt;', @group, '&lt;/xsl:attribute&gt;', $cr)"/>
		 	<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;id&quot;&gt;', @group, '&lt;/xsl:attribute&gt;', $cr)"/>
		</xsl:if>
		<xsl:if test="not(@group)">
		 	<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;name&quot;&gt;Radio&lt;/xsl:attribute&gt;', $cr)"/>
		 	<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;id&quot;&gt;Radio&lt;/xsl:attribute&gt;', $cr)"/>
		</xsl:if>

		  <xsl:apply-templates select="WTCLICK">
		  	<xsl:with-param name="indent" select="$indent3"/>
		  </xsl:apply-templates>

		<xsl:choose>

			<xsl:when test="@name">
			
				<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;value&quot;&gt;', @name, '&lt;/xsl:attribute&gt;', $cr)"/>

				<xsl:choose>
					 <xsl:when test="@check='first'">
					 	<xsl:value-of select="concat($ind3, '&lt;xsl:if test=&quot;position()=1&quot;&gt;', $cr)"/>
					 	<xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;CHECKED&quot;/&gt;', $cr)"/>
					 	<xsl:value-of select="concat($ind3, '&lt;/xsl:if&gt;', $cr)"/>
					 </xsl:when>
					 <xsl:when test="@check">
					 	<xsl:value-of select="concat($ind3, '&lt;xsl:if test=&quot;', @check, '&quot;&gt;', $cr)"/>
					 	<xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;CHECKED&quot;/&gt;', $cr)"/>
					 	<xsl:value-of select="concat($ind3, '&lt;/xsl:if&gt;', $cr)"/>
					 </xsl:when>
					 <xsl:when test="@datapath">
					 	<xsl:value-of select="concat($ind3, '&lt;xsl:if test=&quot;', @datapath, '=', $apos, 'on', $apos, '&quot;&gt;', $cr)"/>
					 	<xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;CHECKED&quot;/&gt;', $cr)"/>
					 	<xsl:value-of select="concat($ind3, '&lt;/xsl:if&gt;', $cr)"/>
					 </xsl:when>
					 <xsl:when test="@datapathx">
					 	<xsl:value-of select="concat($ind3, '&lt;xsl:if test=&quot;', @datapathx, '&quot;&gt;', $cr)"/>
					 	<xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;CHECKED&quot;/&gt;', $cr)"/>
					 	<xsl:value-of select="concat($ind3, '&lt;/xsl:if&gt;', $cr)"/>
					 </xsl:when>
					 <xsl:when test="not($valuetext='')">
					 	<xsl:value-of select="concat($ind3, '&lt;xsl:if test=&quot;', $valuetext, '=', $apos, 'on', $apos, '&quot;&gt;', $cr)"/>
					 	<xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;CHECKED&quot;/&gt;', $cr)"/>
					 	<xsl:value-of select="concat($ind3, '&lt;/xsl:if&gt;', $cr)"/>
					 </xsl:when>
				</xsl:choose>

				<xsl:choose>
					 <xsl:when test="@label">
						  <xsl:call-template name="XSLLabelText">
								<xsl:with-param name="label" select="@label"/>
								<xsl:with-param name="indent" select="$indent3"/>
								<xsl:with-param name="newline" select="true()"/>
						  </xsl:call-template>
					 </xsl:when>
<!--					 
					 <xsl:otherwise>
						  <xsl:call-template name="XSLLabelText">
								<xsl:with-param name="label" select="@name"/>
								<xsl:with-param name="indent" select="$indent3"/>
								<xsl:with-param name="newline" select="true()"/>
						  </xsl:call-template>
					 </xsl:otherwise>
-->
				</xsl:choose>
					
			</xsl:when>

			<xsl:otherwise>	
				
				<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;value&quot;&gt;')"/>
				<xsl:choose>
					<xsl:when test="@translate='false'">
					   	<xsl:call-template name="GetValue">
	 				   		  <xsl:with-param name="type" select="$valuetype"/>
	 				   		  <xsl:with-param name="text" select="$valuetext"/>
	 				   		  <xsl:with-param name="entity" select="$valueentity"/>
	 				   		  <xsl:with-param name="noselect" select="true()"/>
					   	</xsl:call-template>
					</xsl:when>
					<xsl:otherwise>
					    <xsl:value-of select="$valuetext"/> 
					</xsl:otherwise>
				</xsl:choose>
				<xsl:value-of select="concat('&lt;/xsl:attribute&gt;', $cr)"/>
				
<!-- <xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;value&quot;&gt;', $valuetext, '&lt;/xsl:attribute&gt;', $cr)"/>	-->			
	
				<xsl:variable name="datapath">
					<xsl:call-template name="XSLDataField">
						<xsl:with-param name="entity" select="$valueentity"/>
						<xsl:with-param name="name" select="$valuetext"/>
						<xsl:with-param name="newline" select="false()"/>
						<xsl:with-param name="noselect" select="true()"/>
					</xsl:call-template>
				</xsl:variable>	
		
				<xsl:choose>
					<xsl:when test="@translate='false'">
					   	<xsl:value-of select="concat($ind3, '&lt;xsl:if test=&quot;(', $datapathtext, ' = '1')&quot;&gt;&lt;xsl:attribute name=&quot;CHECKED&quot;/&gt;&lt;/xsl:if&gt;', $cr)"/>
					</xsl:when>
					<xsl:otherwise>
					    <xsl:value-of select="concat($ind3, '&lt;xsl:if test=&quot;(', $datapath, ' = '1')&quot;&gt;&lt;xsl:attribute name=&quot;CHECKED&quot;/&gt;&lt;/xsl:if&gt;', $cr)"/>
					</xsl:otherwise>
				</xsl:choose>

<!--
				<xsl:apply-templates select="." mode="read-only">
					<xsl:with-param name="indent" select="$indent3"/>
				</xsl:apply-templates>
-->
				<xsl:choose>
					<xsl:when test="@translate='false'">
<!--						<xsl:value-of select="concat($ind3, '&lt;xsl:value-of select=&quot;', $valuetext, '&quot;/&gt;', $cr)"/>	-->
							<xsl:value-of select="$ind3"/>
							<xsl:call-template name="GetValue">
	 							  <xsl:with-param name="type" select="$valuetype"/>
	 							  <xsl:with-param name="text" select="$valuetext"/>
	 							  <xsl:with-param name="entity" select="$valueentity"/>
	 							  <xsl:with-param name="noselect" select="true()"/>
							</xsl:call-template>
							<xsl:value-of select="$cr"/>
					 </xsl:when>
					 <xsl:otherwise>
						<xsl:call-template name="XSLLabelText">
							<xsl:with-param name="label" select="$valuetext"/>
							<xsl:with-param name="indent" select="$indent3"/>
							<xsl:with-param name="newline" select="true()"/>
						</xsl:call-template>
					 </xsl:otherwise>
				</xsl:choose>

			</xsl:otherwise>
		</xsl:choose>

		<!--disable the field if specified-->
		<xsl:if test="@disabled">
			<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;DISABLED&quot;/&gt;', $cr)"/>
		</xsl:if>

		<xsl:value-of select="concat($ind2, '&lt;/xsl:element&gt;', $cr)"/>

		<xsl:if test="($hasconditions)">
			<xsl:call-template name="XSLConditionEnd">
				<xsl:with-param name="indent" select="$indent2"/>			
			</xsl:call-template>
		</xsl:if>

		<!--end the column tag-->
		<xsl:if test="@col">
			<xsl:apply-templates select="." mode="cell-end">
				<xsl:with-param name="indent" select="$indent"/>
				<xsl:with-param name="wrap" select="$wrap"/>
				<xsl:with-param name="islast" select="position()=last()"/>
			</xsl:apply-templates>
		</xsl:if>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTCOLUMN">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="ind2" select="concat($ind1, $tab1)"/>
		<xsl:variable name="indent2" select="$indent+1"/>

	 <!-- ***************** Error Checking *******************-->
	 <xsl:if test="not(@width)">
	     <xsl:call-template name="Error">
	     	<xsl:with-param name="msg" select="'WTCOLUMN Width Missing'"/>
	     	<xsl:with-param name="text" select="position()"/>
	     </xsl:call-template>
	 </xsl:if>
	 <!--Test valid attributes-->
	 <xsl:for-each select="@*">
		  <xsl:choose>
		   <xsl:when test="name()='width'"/>
		   <xsl:when test="name()='align'"/>
		  	<xsl:otherwise>
		  		 <xsl:call-template name="Error">
		  			  <xsl:with-param name="msg" select="'WTCOLUMN Invalid Attribute'"/>
		  			  <xsl:with-param name="text" select="name()"/>
	 	  		</xsl:call-template>
		  	</xsl:otherwise>
		  </xsl:choose>
	 </xsl:for-each>
	 <!-- ****************************************************-->

    <xsl:variable name="width">
      <xsl:value-of select="@width"/>
      <xsl:if test="$widthpercent='true'">%</xsl:if>
    </xsl:variable>

    <xsl:value-of select="concat($ind1, '&lt;xsl:element name=&quot;TD&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($ind2, '&lt;xsl:attribute name=&quot;width&quot;&gt;', $width, '&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($ind1, '&lt;/xsl:element&gt;', $cr)"/>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTCOLUMN" mode="layout">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="ind2" select="concat($ind1, $tab1)"/>
		<xsl:variable name="indent2" select="$indent+1"/>
		<xsl:variable name="ind3" select="concat($ind2, $tab1)"/>
		<xsl:variable name="indent3" select="$indent2+1"/>

	 <!-- ***************** Error Checking *******************-->
	 <xsl:if test="not(@width)">
	     <xsl:call-template name="Error">
	     	<xsl:with-param name="msg" select="'WTCOLUMN Width Missing'"/>
	     	<xsl:with-param name="text" select="position()"/>
	     </xsl:call-template>
	 </xsl:if>
	 <!--Test valid attributes-->
	 <xsl:for-each select="@*">
		  <xsl:choose>
		   <xsl:when test="name()='width'"/>
		   <xsl:when test="name()='align'"/>
		   <xsl:when test="name()='label'"/>
		   <xsl:when test="name()='class'"/>
		   <xsl:when test="name()='value'"/>
		  	<xsl:otherwise>
		  		 <xsl:call-template name="Error">
		  			  <xsl:with-param name="msg" select="'WTCOLUMN Invalid Attribute'"/>
		  			  <xsl:with-param name="text" select="name()"/>
	 	  		</xsl:call-template>
		  	</xsl:otherwise>
		  </xsl:choose>
	 </xsl:for-each>
	 <!-- ****************************************************-->

    <xsl:variable name="width">
      <xsl:value-of select="@width"/>
      <xsl:if test="$widthpercent='true'">%</xsl:if>
    </xsl:variable>

    <xsl:if test="position() = 1">
			<xsl:value-of select="concat($ind1, '&lt;xsl:element name=&quot;TR&quot;&gt;', $cr)"/>
		</xsl:if>

		<xsl:value-of select="concat($ind2, '&lt;xsl:element name=&quot;TD&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;width&quot;&gt;', $width, '&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:if test="@align">
			<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;align&quot;&gt;', @align, '&lt;/xsl:attribute&gt;', $cr)"/>
		</xsl:if>
		<xsl:if test="@class">
			<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;class&quot;&gt;', @class, '&lt;/xsl:attribute&gt;', $cr)"/>
		</xsl:if>
		<xsl:if test="@label">
			<xsl:call-template name="XSLLabelText">
				<xsl:with-param name="label" select="@label"/>
				<xsl:with-param name="indent" select="$indent3"/>
				<xsl:with-param name="newline" select="true()"/>
			</xsl:call-template>
		</xsl:if>
		<xsl:value-of select="concat($ind2, '&lt;/xsl:element&gt;', $cr)"/>

		<xsl:if test="position() = last()">
			<xsl:value-of select="concat($ind1, '&lt;/xsl:element&gt;', $cr)"/>
		</xsl:if>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTCOMBO">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:param name="wrap" select="false()"/>
		<xsl:variable name="hasconditions" select="(count(WTCONDITION) > 0)"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="ind2"><xsl:choose><xsl:when test="$hasconditions"><xsl:value-of select="concat($ind1, $tab1)"/></xsl:when><xsl:otherwise><xsl:value-of select="$ind1"/></xsl:otherwise></xsl:choose></xsl:variable>
		<xsl:variable name="indent2"><xsl:choose><xsl:when test="$hasconditions"><xsl:value-of select="$indent+1"/></xsl:when><xsl:otherwise><xsl:value-of select="$indent"/></xsl:otherwise></xsl:choose></xsl:variable>
		<xsl:variable name="ind3" select="concat($ind2, $tab1)"/>
		<xsl:variable name="indent3" select="$indent2+1"/>
		<xsl:variable name="ind4" select="concat($ind3, $tab1)"/>
		<xsl:variable name="indent4" select="$indent3+1"/>
		<xsl:variable name="ind5" select="concat($ind4, $tab1)"/>
		<xsl:variable name="indent5" select="$indent4+1"/>
		<xsl:variable name="ind6" select="concat($ind5, $tab1)"/>
		<xsl:variable name="indent6" select="$indent5+1"/>
		<xsl:variable name="valuetype"><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>
		<xsl:variable name="valuetext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>
		<xsl:variable name="valueentity"><xsl:call-template name="QualifiedPrefix"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>
		<xsl:variable name="idtext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@id"/></xsl:call-template></xsl:variable>
		<xsl:variable name="attribute" select="/Data/WTENTITY/WTATTRIBUTE[@name=$valuetext]"/>

	 <!-- ***************** Error Checking *******************-->
	<xsl:if test="not(ancestor::WTSTATIC) and not(ancestor::WTBUTTON) and not(ancestor::WTTREE) and not(ancestor::WTTREE2) and not(ancestor::WTDIVISION) and (ancestor::WTROW)">
		<xsl:if test="not(@col)">
			<xsl:call-template name="Error">
	     		<xsl:with-param name="msg" select="'WTCOMBO Column Missing'"/>
	     		<xsl:with-param name="text" select="position()"/>
			</xsl:call-template>
		</xsl:if>
	 </xsl:if>
	 <!--Test valid attributes-->
	 <xsl:for-each select="@*">
			<xsl:variable name="testcol">
				<xsl:call-template name="TestColAttr">
					<xsl:with-param name="attr" select="name()"/>
				</xsl:call-template>
			</xsl:variable>
		   <xsl:if test="$testcol='0'">
				<xsl:choose>
		  			<xsl:when test="name()='name'"/>
		  			<xsl:when test="name()='translate'"/>
		  			<xsl:when test="name()='required'"/>
		  			<xsl:when test="name()='datapath'"/>
		  			<xsl:when test="name()='id'"/>
		  			<xsl:when test="name()='optionid'"/>
		  			<xsl:when test="name()='optionnamex'"/>
		  			<xsl:when test="name()='valuetype'"/>
		  			<xsl:when test="name()='disabled'"/>
		  			<xsl:when test="name()='setselected'"/>
		  			<xsl:when test="name()='select'"/>
					<xsl:when test="name()='style'"/>
					<xsl:when test="name()='comboclass'"/>
					<xsl:when test="name()='label'"/>
					<xsl:otherwise>
						 <xsl:call-template name="Error">
							  <xsl:with-param name="msg" select="'WTCOMBO Invalid Attribute'"/>
							  <xsl:with-param name="text" select="name()"/>
	 					</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose>
		   </xsl:if>
	 </xsl:for-each>
	 <!-- ****************************************************-->

		<!--begin the column tag-->
		<xsl:if test="@col">
			<xsl:apply-templates select="." mode="cell-begin">
				<xsl:with-param name="indent" select="$indent"/>
				<xsl:with-param name="wrap" select="$wrap"/>
				<xsl:with-param name="isfirst" select="position()=1"/>
			</xsl:apply-templates>
	   </xsl:if>

		<!--generate IF statement for conditions if they exist-->
		<xsl:if test="($hasconditions)">
			<xsl:call-template name="XSLConditionStart">
				<xsl:with-param name="indent" select="$indent2"/>
				<xsl:with-param name="conditions" select="WTCONDITION"/>
			</xsl:call-template>
		</xsl:if>

		<!--build the input control-->
		<xsl:value-of select="concat($ind3, '&lt;xsl:element name=&quot;SELECT&quot;&gt;', $cr)"/>
		<xsl:if test="@comboclass">
			<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;class&quot;&gt;', @comboclass, '&lt;/xsl:attribute&gt;', $cr)"/>
		</xsl:if>
		<xsl:choose>
			<xsl:when test="(@name)">
				<xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;name&quot;&gt;', @name, '&lt;/xsl:attribute&gt;', $cr)"/>
				<xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;id&quot;&gt;', @name, '&lt;/xsl:attribute&gt;', $cr)"/>
			</xsl:when>
			<xsl:when test="(@id)">
				<xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;name&quot;&gt;&lt;xsl:value-of select=&quot;concat(', $apos, $valuetext, $apos, ', @', $idtext, ')&quot;/&gt;&lt;/xsl:attribute&gt;', $cr)"/>
				<xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;id&quot;&gt;&lt;xsl:value-of select=&quot;@', $idtext, '&quot;/&gt;&lt;/xsl:attribute&gt;', $cr)"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;name&quot;&gt;', $valuetext, '&lt;/xsl:attribute&gt;', $cr)"/>
				<xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;id&quot;&gt;', $valuetext, '&lt;/xsl:attribute&gt;', $cr)"/>
			</xsl:otherwise>
		</xsl:choose>

			<xsl:if test="@style">
				<xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;style&quot;&gt;', @style, '&lt;/xsl:attribute&gt;', $cr)"/>
			</xsl:if>

		  <xsl:apply-templates select="WTENTER">
		  	<xsl:with-param name="indent" select="$indent4"/>
		  </xsl:apply-templates>

		  <xsl:apply-templates select="WTKEY">
		  	<xsl:with-param name="indent" select="$indent4"/>
		  </xsl:apply-templates>

		  <xsl:apply-templates select="WTCHANGE">
		  	<xsl:with-param name="indent" select="$indent4"/>
		  </xsl:apply-templates>

		  <xsl:apply-templates select="WTEXIT">
		  	<xsl:with-param name="indent" select="$indent4"/>
		  </xsl:apply-templates>

		  <!--disable the field if specified-->
		  <xsl:if test="@disabled">
				<xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;DISABLED&quot;/&gt;', $cr)"/>
		  </xsl:if>
<!--
		<xsl:apply-templates select="." mode="read-only">
			<xsl:with-param name="indent" select="$indent4"/>
		</xsl:apply-templates>
-->
		<xsl:choose>
			<xsl:when test="WTOPTION">
				<xsl:if test="not(@select='false')">
					<xsl:value-of select="concat($ind4, '&lt;xsl:variable name=&quot;tmp&quot;&gt;')"/>
					<xsl:value-of select="'&lt;xsl:value-of select=&quot;'"/>
					<xsl:call-template name="GetValue">
	 					  <xsl:with-param name="type" select="$valuetype"/>
	 					  <xsl:with-param name="text" select="$valuetext"/>
	 					  <xsl:with-param name="entity" select="$valueentity"/>
	 					  <xsl:with-param name="noselect" select="true()"/>
					</xsl:call-template>
					<xsl:value-of select="'&quot;/&gt;'"/>
					<xsl:value-of select="concat('&lt;/xsl:variable&gt;', $cr)"/>
				</xsl:if>
		
				<xsl:apply-templates select="WTOPTION">
					<xsl:with-param name="indent" select="$indent4"/>
					<xsl:with-param name="value" select="$valuetext"/>
					<xsl:with-param name="selected" select="count(WTOPTION[@select])"/>
				</xsl:apply-templates>
			</xsl:when>
			
			<xsl:otherwise>

				<xsl:variable name="datapath">
					<xsl:choose>
						<xsl:when test="@datapath"><xsl:value-of select="@datapath"/></xsl:when>
						<xsl:when test="($valueentity='Current')">
							<!--WTLOOKUP and WTENUM look to their parent for their list -->
							<xsl:if test="/Data/WTENTITY/WTATTRIBUTE[@name=$valuetext][/WTLOOKUP][count(/WTLOOKUP/WTPARAM)&lt;=1]">
								<xsl:value-of select="'../'"/>
							</xsl:if>
							<xsl:if test="/Data/WTENTITY/WTATTRIBUTE[@name=$valuetext]/WTENUM">
								<xsl:value-of select="'../'"/>
							</xsl:if>
							<xsl:call-template name="CaseUpper">
								<xsl:with-param name="value" select="concat($appprefix, $valuetext, 'S/ENUM')"/>
							</xsl:call-template>
						</xsl:when>
						<xsl:otherwise>
							<xsl:call-template name="CaseUpper">
								<xsl:with-param name="value" select="concat('/DATA/TXN/', $appprefix, $valueentity, '/', $appprefix, $valuetext, 'S/ENUM')"/>
							</xsl:call-template>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>

				<xsl:variable name="tmpOption">
					<xsl:if test="@name"><xsl:value-of select="concat(@name,'Option')"/></xsl:if>
					<xsl:if test="not(@name)"><xsl:value-of select="concat($valuetext,'Option')"/></xsl:if>
				</xsl:variable>
				<xsl:if test="@setselected">
<!--					<xsl:value-of select="concat($ind4, '&lt;xsl:variable name=&quot;', $tmpOption, '&quot;&gt;')"/>-->
					<xsl:value-of select="concat($ind4, '&lt;xsl:variable name=&quot;tmp&quot;&gt;')"/>
					<xsl:value-of select="'&lt;xsl:value-of select=&quot;'"/>
					<xsl:call-template name="GetValue">
	 					  <xsl:with-param name="type" select="$valuetype"/>
	 					  <xsl:with-param name="text" select="$valuetext"/>
	 					  <xsl:with-param name="entity" select="$valueentity"/>
	 					  <xsl:with-param name="noselect" select="true()"/>
					</xsl:call-template>
					<xsl:value-of select="'&quot;/&gt;'"/>
					<xsl:value-of select="concat('&lt;/xsl:variable&gt;', $cr)"/>
				</xsl:if>

				<xsl:value-of select="concat($ind4, '&lt;xsl:for-each select=&quot;', $datapath, '&quot;&gt;', $cr)"/>
				<xsl:value-of select="concat($ind5, '&lt;xsl:element name=&quot;OPTION&quot;&gt;', $cr)"/>
				<xsl:choose>
					<xsl:when test="@optionid">
						<xsl:value-of select="concat($ind6, '&lt;xsl:attribute name=&quot;value&quot;&gt;&lt;xsl:value-of select=&quot;', @optionid, '&quot;/&gt;&lt;/xsl:attribute&gt;', $cr)"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="concat($ind6, '&lt;xsl:attribute name=&quot;value&quot;&gt;&lt;xsl:value-of select=&quot;@id&quot;/&gt;&lt;/xsl:attribute&gt;', $cr)"/>
					</xsl:otherwise>
				</xsl:choose>

				<xsl:choose>
					<xsl:when test="@setselected">
						<xsl:choose>
							<xsl:when test="@optionid">
<!--								<xsl:value-of select="concat($ind6, '&lt;xsl:if test=&quot;$', $tmpOption, '=', @optionid, '&quot;&gt;&lt;xsl:attribute name=&quot;SELECTED&quot;/&gt;&lt;/xsl:if&gt;', $cr)"/>-->
								<xsl:value-of select="concat($ind6, '&lt;xsl:if test=&quot;$tmp=', @optionid, '&quot;&gt;&lt;xsl:attribute name=&quot;SELECTED&quot;/&gt;&lt;/xsl:if&gt;', $cr)"/>
							</xsl:when>
							<xsl:otherwise>
<!--								<xsl:value-of select="concat($ind6, '&lt;xsl:if test=&quot;$', $tmpOption, '=@id&quot;&gt;&lt;xsl:attribute name=&quot;SELECTED&quot;/&gt;&lt;/xsl:if&gt;', $cr)"/>-->
								<xsl:value-of select="concat($ind6, '&lt;xsl:if test=&quot;$tmp=@id&quot;&gt;&lt;xsl:attribute name=&quot;SELECTED&quot;/&gt;&lt;/xsl:if&gt;', $cr)"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="concat($ind6, '&lt;xsl:if test=&quot;@selected&quot;&gt;&lt;xsl:attribute name=&quot;SELECTED&quot;/&gt;&lt;/xsl:if&gt;', $cr)"/>
					</xsl:otherwise>
				</xsl:choose>

				<xsl:choose>
					<xsl:when test="@optionnamex">
						<xsl:value-of select="concat($ind6, @optionnamex, $cr)"/>
					</xsl:when>
					<xsl:when test="@optionname">
						<xsl:value-of select="concat($ind6, '&lt;xsl:value-of select=&quot;', @optionname, '&quot;/&gt;', $cr)"/>
					</xsl:when>
					<xsl:when test="(count(/Data/WTENTITY/WTATTRIBUTE[@name=$valuetext]/WTENUM)>0) or (@translate='true')">
						<xsl:call-template name="XSLLabelText">
							<xsl:with-param name="noquote" select="true()"/>
							<xsl:with-param name="label" select="'current()/@name'"/>
							<xsl:with-param name="indent" select="$indent6"/>
							<xsl:with-param name="newline" select="true()"/>
						</xsl:call-template>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="concat($ind6, '&lt;xsl:value-of select=&quot;@name&quot;/&gt;', $cr)"/>
					</xsl:otherwise>
				</xsl:choose>
		
				<xsl:value-of select="concat($ind5, '&lt;/xsl:element&gt;', $cr)"/>
				<xsl:value-of select="concat($ind4, '&lt;/xsl:for-each&gt;', $cr)"/>
		
			</xsl:otherwise>
		</xsl:choose>

		<xsl:value-of select="concat($ind3, '&lt;/xsl:element&gt;', $cr)"/>

		<!--required field indicator-->
		<xsl:if test="not(@required='false') and (@required='true' or ($attribute/@required='true'))">
			<xsl:apply-templates select="." mode="require-mark">
				<xsl:with-param name="indent" select="$indent2"/>
			</xsl:apply-templates>
		</xsl:if>

		<!--close IF statement for conditions if they exist-->
		<xsl:if test="($hasconditions)">
			<xsl:call-template name="XSLConditionEnd">
				<xsl:with-param name="indent" select="$indent2"/>			
			</xsl:call-template>
		</xsl:if>

		<!--end the column tag-->
		<xsl:if test="@col">
			<xsl:apply-templates select="." mode="cell-end">
				<xsl:with-param name="indent" select="$indent"/>
				<xsl:with-param name="wrap" select="$wrap"/>
				<xsl:with-param name="islast" select="position()=last()"/>
			</xsl:apply-templates>
		</xsl:if>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTOPTION">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:param name="value"/>
		<xsl:param name="selected"/>
		<xsl:variable name="hasconditions" select="(count(WTCONDITION) > 0)"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="ind2"><xsl:choose><xsl:when test="$hasconditions"><xsl:value-of select="concat($ind1, $tab1)"/></xsl:when><xsl:otherwise><xsl:value-of select="$ind1"/></xsl:otherwise></xsl:choose></xsl:variable>
		<xsl:variable name="indent2"><xsl:choose><xsl:when test="$hasconditions"><xsl:value-of select="$indent+1"/></xsl:when><xsl:otherwise><xsl:value-of select="$indent+1"/></xsl:otherwise></xsl:choose></xsl:variable>
		<xsl:variable name="ind3" select="concat($ind2, $tab1)"/>
		<xsl:variable name="indent3" select="$indent2+1"/>
		<xsl:variable name="idtype"><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="@id"/></xsl:call-template></xsl:variable>
		<xsl:variable name="idtext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@id"/></xsl:call-template></xsl:variable>
		<xsl:variable name="identity"><xsl:call-template name="QualifiedPrefix"><xsl:with-param name="value" select="@id"/></xsl:call-template></xsl:variable>
		<xsl:variable name="valuetype"><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>
		<xsl:variable name="valuetext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>
		<xsl:variable name="valueentity"><xsl:call-template name="QualifiedPrefix"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>

	 <!-- ***************** Error Checking *******************-->
	 <xsl:if test="not(@id)">
	     <xsl:call-template name="Error">
	     	<xsl:with-param name="msg" select="'WTOPTION ID Missing'"/>
	     	<xsl:with-param name="text" select="position()"/>
	     </xsl:call-template>
	 </xsl:if>
	 <!--Test valid attributes-->
	 <xsl:for-each select="@*">
		  <xsl:choose>
		   <xsl:when test="name()='id'"/>
		   <xsl:when test="name()='label'"/>
		   <xsl:when test="name()='value'"/>
		   <xsl:when test="name()='selected'"/>
		  	<xsl:otherwise>
		  		 <xsl:call-template name="Error">
		  			  <xsl:with-param name="msg" select="'WTOPTION Invalid Attribute'"/>
		  			  <xsl:with-param name="text" select="name()"/>
	 	  		</xsl:call-template>
		  	</xsl:otherwise>
		  </xsl:choose>
	 </xsl:for-each>
	 <!-- ****************************************************-->

		<!--generate IF statement for conditions if they exist-->
		<xsl:if test="($hasconditions)">
			<xsl:call-template name="XSLConditionStart">
				<xsl:with-param name="indent" select="$indent"/>
				<xsl:with-param name="conditions" select="WTCONDITION"/>
			</xsl:call-template>
		</xsl:if>

	  <xsl:variable name="OptionID">
		  <xsl:call-template name="GetValue">
	 		  <xsl:with-param name="type" select="$idtype"/>
	 		  <xsl:with-param name="text" select="$idtext"/>
			  <xsl:with-param name="noselect" select="true()"/>
		  </xsl:call-template>
	  </xsl:variable>
	  
	  <xsl:variable name="id">
  		  <xsl:if test="../@valuetype='text'"><xsl:value-of select="$apos"/></xsl:if>
  		  <xsl:value-of select="$OptionID"/>
  		  <xsl:if test="../@valuetype='text'"><xsl:value-of select="$apos"/></xsl:if>
	  </xsl:variable>
	  
		<xsl:value-of select="concat($ind2, '&lt;xsl:element name=&quot;OPTION&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;value&quot;&gt;', $OptionID, '&lt;/xsl:attribute&gt;', $cr)"/>

		<xsl:if test="@selected">
			<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;SELECTED&quot;/&gt;', $cr)"/>
		</xsl:if>
		<!-- check if no options are selected -->
		<xsl:if test="$selected=0 and not(../@select='false')">
			<xsl:value-of select="concat($ind3, '&lt;xsl:if test=&quot;$tmp=',$apos,$id,$apos,'&quot;&gt;&lt;xsl:attribute name=&quot;SELECTED&quot;/&gt;&lt;/xsl:if&gt;', $cr)"/>
		</xsl:if>
		
		<xsl:if test="@label">
			<xsl:call-template name="XSLLabelText">
				<xsl:with-param name="noquote" select="false()"/>
				<xsl:with-param name="label" select="@label"/>
				<xsl:with-param name="indent" select="$indent2"/>
				<xsl:with-param name="newline" select="true()"/>
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="@value">
			<xsl:value-of select="$ind3"/>
		  <xsl:call-template name="GetValue">
	 		  <xsl:with-param name="type" select="$valuetype"/>
	 		  <xsl:with-param name="text" select="$valuetext"/>
		  </xsl:call-template>
			<xsl:value-of select="$cr"/>
		</xsl:if>
		
		<xsl:value-of select="concat($ind2, '&lt;/xsl:element&gt;', $cr)"/>

		<xsl:if test="($hasconditions)">
			<xsl:call-template name="XSLConditionEnd">
				<xsl:with-param name="indent" select="$indent"/>			
			</xsl:call-template>
		</xsl:if>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTCONTENT" mode="template">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="ind2" select="concat($ind1, $tab1)"/>
		<xsl:variable name="indent2" select="$indent+1"/>
		<xsl:variable name="ind3" select="concat($ind2, $tab1)"/>
		<xsl:variable name="indent3" select="$indent2+1"/>
		
	 <!-- ***************** Error Checking *******************-->
	 <!--Test valid attributes-->
	 <xsl:for-each select="@*">
		  <xsl:choose>
			<xsl:when test="name()='mode'"/>
			<xsl:when test="name()='width'"/>
			<xsl:when test="name()='height'"/>
			<xsl:when test="name()='color'"/>
			<xsl:when test="name()='background'"/>
			<xsl:when test="name()='border'"/>
			<xsl:when test="name()='bordercolor'"/>
			<xsl:when test="name()='padding'"/>
			<xsl:when test="name()='spacing'"/>
			<xsl:when test="name()='firstrow'"/>
		  	<xsl:otherwise>
		  		 <xsl:call-template name="Error">
		  			  <xsl:with-param name="msg" select="'WTCONTENT Invalid Attribute'"/>
		  			  <xsl:with-param name="text" select="name()"/>
	 	  		</xsl:call-template>
		  	</xsl:otherwise>
		  </xsl:choose>
	 </xsl:for-each>
	 <!-- ****************************************************-->

		<!--define custom functions-->
		<xsl:apply-templates select="/Data/WTENTITY/WTWEBPAGE/WTCONTENT/WTFUNCTION">
			<xsl:with-param name="indent" select="$indent"/>
		</xsl:apply-templates>

		<!--define Google log-->
		<xsl:if test="$LogGoogle and $LogPage">
			<xsl:call-template name="GoogleLog">
				<xsl:with-param name="indent" select="$indent"/>
			</xsl:call-template>
		</xsl:if>

		<xsl:variable name="border">
			<xsl:choose>
				<xsl:when test="/Data/WTPAGE/@test">1</xsl:when>
				<xsl:when test="@border"><xsl:value-of select="@border"/></xsl:when>
				<xsl:otherwise>0</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

	  	<xsl:variable name="contentwidth">
	  		<xsl:choose>
				<xsl:when test="@width"><xsl:value-of select="@width"/></xsl:when>
				<xsl:otherwise><xsl:value-of select="sum(WTCOLUMN/@width)"/></xsl:otherwise>
	  		</xsl:choose>
        <xsl:if test="$widthpercent='true'">%</xsl:if>
      </xsl:variable>
		<xsl:variable name="padding">
			<xsl:choose>
				<xsl:when test="@padding"><xsl:value-of select="@padding"/></xsl:when>
				<xsl:otherwise>0</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="spacing">
			<xsl:choose>
				<xsl:when test="@spacing"><xsl:value-of select="@spacing"/></xsl:when>
				<xsl:otherwise>0</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<!--begin content table-->
		<xsl:value-of select="concat($ind1, '&lt;xsl:element name=&quot;TABLE&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($ind2, '&lt;xsl:attribute name=&quot;border&quot;&gt;', $border, '&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($ind2, '&lt;xsl:attribute name=&quot;cellpadding&quot;&gt;', $padding, '&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($ind2, '&lt;xsl:attribute name=&quot;cellspacing&quot;&gt;', $spacing, '&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($ind2, '&lt;xsl:attribute name=&quot;width&quot;&gt;', $contentwidth, '&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:if test="@height">
			<xsl:value-of select="concat($ind2, '&lt;xsl:attribute name=&quot;height&quot;&gt;', @height, '&lt;/xsl:attribute&gt;', $cr)"/>
		</xsl:if>
		<xsl:if test="@bordercolor">
	 		<xsl:variable name="bordercolor"><xsl:call-template name="GetColor"><xsl:with-param name="color" select="@bordercolor"/></xsl:call-template></xsl:variable>
			<xsl:value-of select="concat($ind2, '&lt;xsl:attribute name=&quot;bordercolor&quot;&gt;', $bordercolor, '&lt;/xsl:attribute&gt;', $cr)"/>
		</xsl:if>
		<xsl:if test="@color">
	 		<xsl:variable name="bgcolor"><xsl:call-template name="GetColor"><xsl:with-param name="color" select="@color"/></xsl:call-template></xsl:variable>
			<xsl:value-of select="concat($ind2, '&lt;xsl:attribute name=&quot;bgcolor&quot;&gt;', $bgcolor, '&lt;/xsl:attribute&gt;', $cr)"/>
		</xsl:if>
		<xsl:if test="@background">
			<xsl:value-of select="concat($ind2, '&lt;xsl:attribute name=&quot;background&quot;&gt;Images/', @background, '&lt;/xsl:attribute&gt;', $cr)"/>
		</xsl:if>
		<xsl:value-of select="$cr"/>

		<!--first blank line for the table-->
		<xsl:if test="not(@firstrow='false')">
			<xsl:value-of select="concat($ind2, '&lt;xsl:element name=&quot;TR&quot;&gt;', $cr)"/>
			<xsl:apply-templates select="WTCOLUMN">
				<xsl:with-param name="indent" select="$indent3"/>
			</xsl:apply-templates>		
			<xsl:value-of select="concat($ind2, '&lt;/xsl:element&gt;', $cr, $cr)"/>
		</xsl:if>

 		<xsl:apply-templates select="WTVARIABLE">
			<xsl:with-param name="indent" select="$indent2"/>
		</xsl:apply-templates>		

		<!--apply child elements (ROWS)-->
		<xsl:apply-templates select="WTROW | WTREPEAT | WTCODEGROUP | WTINPUTOPTIONS | WTCUSTOMFIELDS | WTSCRIPT">
			<xsl:with-param name="indent" select="$indent2"/>
		</xsl:apply-templates>		

		<xsl:value-of select="concat($ind1, '&lt;/xsl:element&gt;', $cr, $cr)"/>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTCONTENT" mode="report">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="ind2" select="concat($ind1, $tab1)"/>
		<xsl:variable name="indent2" select="$indent+1"/>

	 <!-- ***************** Error Checking *******************-->
	 <!--Test valid attributes-->
	 <xsl:for-each select="@*">
		  <xsl:choose>
			<xsl:when test="name()='mode'"/>
			<xsl:when test="name()='border'"/>
			<xsl:when test="name()='firstrow'"/>
		  	<xsl:otherwise>
		  		 <xsl:call-template name="Error">
		  			  <xsl:with-param name="msg" select="'WTCONTENT Invalid Attribute'"/>
		  			  <xsl:with-param name="text" select="name()"/>
	 	  		</xsl:call-template>
		  	</xsl:otherwise>
		  </xsl:choose>
	 </xsl:for-each>
	 <!-- ****************************************************-->

		<!--define custom functions-->
		<xsl:apply-templates select="/Data/WTENTITY/WTWEBPAGE/WTCONTENT/WTFUNCTION">
			<xsl:with-param name="indent" select="$indent"/>
		</xsl:apply-templates>

		<!--define Google log-->
		<xsl:if test="$LogGoogle and $LogPage">
			<xsl:call-template name="GoogleLog">
				<xsl:with-param name="indent" select="$indent"/>
			</xsl:call-template>
		</xsl:if>

		<!--first blank line for the table-->
		<xsl:if test="not(@firstrow='false')">
			<xsl:value-of select="concat($ind1, '&lt;xsl:element name=&quot;TR&quot;&gt;', $cr)"/>
			<xsl:apply-templates select="WTCOLUMN">
				<xsl:with-param name="indent" select="$indent2"/>
			</xsl:apply-templates>		
			<xsl:value-of select="concat($ind1, '&lt;/xsl:element&gt;', $cr, $cr)"/>
		</xsl:if>

 		<xsl:apply-templates select="WTVARIABLE">
			<xsl:with-param name="indent" select="$indent2"/>
		</xsl:apply-templates>		

		<!--apply child elements (ROWS)-->
		<xsl:apply-templates select="WTROW | WTREPEAT | WTCODEGROUP | WTMETA | WTINPUTOPTIONS | WTCUSTOMFIELDS | WTSCRIPT">
			<xsl:with-param name="indent" select="$indent"/>
		</xsl:apply-templates>		

	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTCONTENT">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="ind2" select="concat($ind1, $tab1)"/>
		<xsl:variable name="indent2" select="$indent+1"/>
		<xsl:variable name="ind3" select="concat($ind2, $tab1)"/>
		<xsl:variable name="indent3" select="$indent2+1"/>
		<xsl:variable name="ind4" select="concat($ind3, $tab1)"/>
		<xsl:variable name="indent4" select="$indent3+1"/>
		<xsl:variable name="ind5" select="concat($ind4, $tab1)"/>
		<xsl:variable name="indent5" select="$indent4+1"/>
		<xsl:variable name="ind6" select="concat($ind5, $tab1)"/>
		<xsl:variable name="indent6" select="$indent5+1"/>

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
		<xsl:variable name="navbarcolor">
			<xsl:choose>
				<xsl:when test="/Data/WTENTITY/WTWEBPAGE/@navbar-color"><xsl:value-of select="/Data/WTENTITY/WTWEBPAGE/@navbar-color"/></xsl:when>
				<xsl:when test="/Data/WTPAGE/@navbar-color"><xsl:value-of select="/Data/WTPAGE/@navbar-color"/></xsl:when>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="margincolor">
			<xsl:choose>
				<xsl:when test="/Data/WTENTITY/WTWEBPAGE/@margin-color"><xsl:value-of select="/Data/WTENTITY/WTWEBPAGE/@margin-color"/></xsl:when>
				<xsl:when test="/Data/WTPAGE/@margin-color"><xsl:value-of select="/Data/WTPAGE/@margin-color"/></xsl:when>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="contentcolor">
			<xsl:choose>
				<xsl:when test="/Data/WTENTITY/WTWEBPAGE/@content-color"><xsl:value-of select="/Data/WTENTITY/WTWEBPAGE/@content-color"/></xsl:when>
				<xsl:when test="/Data/WTPAGE/@content-color"><xsl:value-of select="/Data/WTPAGE/@content-color"/></xsl:when>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="navbarimage">
			<xsl:choose>
				<xsl:when test="/Data/WTENTITY/WTWEBPAGE/@navbar-image='false'"></xsl:when>
				<xsl:when test="/Data/WTENTITY/WTWEBPAGE/@navbar-image"><xsl:value-of select="/Data/WTENTITY/WTWEBPAGE/@navbar-image"/></xsl:when>
				<xsl:when test="/Data/WTPAGE/@navbar-image='false'"></xsl:when>
				<xsl:when test="/Data/WTPAGE/@navbar-image"><xsl:value-of select="/Data/WTPAGE/@navbar-image"/></xsl:when>
				<xsl:when test="$NavBar='blank'"></xsl:when>
				<xsl:otherwise>Toolbar.gif</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="marginimage">
			<xsl:choose>
				<xsl:when test="/Data/WTENTITY/WTWEBPAGE/@margin-image"><xsl:value-of select="/Data/WTENTITY/WTWEBPAGE/@margin-image"/></xsl:when>
				<xsl:when test="/Data/WTPAGE/@margin-image"><xsl:value-of select="/Data/WTPAGE/@margin-image"/></xsl:when>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="contentimage">
			<xsl:choose>
				<xsl:when test="@background"><xsl:value-of select="@background"/></xsl:when>
				<xsl:when test="/Data/WTENTITY/WTWEBPAGE/@content-image"><xsl:value-of select="/Data/WTENTITY/WTWEBPAGE/@content-image"/></xsl:when>
				<xsl:when test="/Data/WTPAGE/@content-image"><xsl:value-of select="/Data/WTPAGE/@content-image"/></xsl:when>
			</xsl:choose>
		</xsl:variable>
	  	<xsl:variable name="navbarwidth">
	  		<xsl:choose>
	  			<xsl:when test="/Data/WTENTITY/WTWEBPAGE/@navbar-width"><xsl:value-of select="/Data/WTENTITY/WTWEBPAGE/@navbar-width"/></xsl:when>
	  			<xsl:when test="/Data/WTPAGE/@navbar-width"><xsl:value-of select="/Data/WTPAGE/@navbar-width"/></xsl:when>
	  			<xsl:otherwise>140</xsl:otherwise>
	  		</xsl:choose>
      </xsl:variable>
	  	<xsl:variable name="marginwidth">
	  		<xsl:choose>
	  			<xsl:when test="/Data/WTENTITY/WTWEBPAGE/@margin-width"><xsl:value-of select="/Data/WTENTITY/WTWEBPAGE/@margin-width"/></xsl:when>
	  			<xsl:when test="/Data/WTPAGE/@margin-width"><xsl:value-of select="/Data/WTPAGE/@margin-width"/></xsl:when>
	  			<xsl:otherwise>10</xsl:otherwise>
	  		</xsl:choose>
      </xsl:variable>
	  	<xsl:variable name="contentwidth">
	  		<xsl:choose>
	  			<xsl:when test="/Data/WTENTITY/WTWEBPAGE/@content-width"><xsl:value-of select="/Data/WTENTITY/WTWEBPAGE/@content-width"/></xsl:when>
	  			<xsl:when test="/Data/WTPAGE/@content-width"><xsl:value-of select="/Data/WTPAGE/@content-width"/></xsl:when>
				<xsl:otherwise><xsl:value-of select="sum(WTCOLUMN/@width)"/><xsl:if test="$widthpercent='true'">%</xsl:if></xsl:otherwise>
	  		</xsl:choose>
      </xsl:variable>

	 <!-- ***************** Error Checking *******************-->
	 <!--Test valid attributes-->
	 <xsl:for-each select="@*">
		  <xsl:choose>
			<xsl:when test="name()='mode'"/>
			<xsl:when test="name()='background'"/>
			<xsl:when test="name()='border'"/>
			<xsl:when test="name()='firstrow'"/>
		  	<xsl:otherwise>
		  		 <xsl:call-template name="Error">
		  			  <xsl:with-param name="msg" select="'WTCONTENT Invalid Attribute'"/>
		  			  <xsl:with-param name="text" select="name()"/>
	 	  		</xsl:call-template>
		  	</xsl:otherwise>
		  </xsl:choose>
	 </xsl:for-each>
	 <!-- ****************************************************-->

		<xsl:choose>
			<xsl:when test="ancestor::WTTEMPLATE">
				<xsl:apply-templates select="." mode="template">
					<xsl:with-param name="indent" select="$indent"/>
				</xsl:apply-templates>
			</xsl:when>
			<xsl:otherwise>

				<!--define custom functions-->
				<xsl:apply-templates select="/Data/WTENTITY/WTWEBPAGE/WTCONTENT/WTFUNCTION">
					<xsl:with-param name="indent" select="$indent"/>
				</xsl:apply-templates>

				<!--define Google log-->
				<xsl:if test="$LogGoogle and $LogPage">
					<xsl:call-template name="GoogleLog">
						<xsl:with-param name="indent" select="$indent"/>
					</xsl:call-template>
				</xsl:if>

				<!--display header text-->
				<xsl:apply-templates select="/Data/WTENTITY/WTWEBPAGE/WTCONTENT/WTHEADER">
					<xsl:with-param name="indent" select="$indent"/>
				</xsl:apply-templates>

				<xsl:value-of select="concat($ind1, '&lt;xsl:element name=&quot;TR&quot;&gt;', $cr, $cr)"/>

				<xsl:if test="/Data/WTENTITY/WTWEBPAGE/@contentpage">

					<!--***** Setup NavBar Column ************************************************************************-->
					<xsl:if test="$NavBar!=''">
						<xsl:value-of select="concat($ind2, '&lt;xsl:if test=&quot;/DATA/PARAM/@contentpage=0&quot;&gt;', $cr)"/>

						<xsl:if test="$IsMenu='false'">
							<xsl:if test="/Data/WTENTITY/WTWEBPAGE/@system-navbarimage or /Data/WTPAGE/@system-navbarimage">
								<xsl:value-of select="concat($ind3, '&lt;xsl:variable name=&quot;tmpNavBarImage&quot;&gt;', $cr)"/>
								<xsl:value-of select="concat($ind4, '&lt;xsl:if test=&quot;/DATA/SYSTEM/@navbarimage=', $apos, $apos, '&quot;&gt;Images/', $navbarimage, '&lt;/xsl:if&gt;', $cr)"/>
								<xsl:value-of select="concat($ind4, '&lt;xsl:if test=&quot;/DATA/SYSTEM/@navbarimage!=', $apos, $apos, '&quot;&gt;&lt;xsl:value-of select=&quot;/DATA/SYSTEM/@navbarimage&quot;/&gt;&lt;/xsl:if&gt;', $cr)"/>
								<xsl:value-of select="concat($ind3, '&lt;/xsl:variable&gt;', $cr)"/>
							</xsl:if>
						</xsl:if>

						<xsl:value-of select="concat($ind3, '&lt;xsl:element name=&quot;TD&quot;&gt;', $cr)"/>
						<xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;align&quot;&gt;right&lt;/xsl:attribute&gt;', $cr)"/>
						<xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;valign&quot;&gt;top&lt;/xsl:attribute&gt;', $cr)"/>
						<xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;width&quot;&gt;', $navbarwidth, '&lt;/xsl:attribute&gt;', $cr)"/>

						<xsl:if test="$IsMenu='false'">
							<xsl:if test="$navbarcolor!=''">
	 							<xsl:variable name="bgcolor"><xsl:call-template name="GetColor"><xsl:with-param name="color" select="$navbarcolor"/></xsl:call-template></xsl:variable>
								<xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;bgcolor&quot;&gt;', $bgcolor, '&lt;/xsl:attribute&gt;', $cr)"/>
							</xsl:if>
							<xsl:if test="$navbarimage!=''">
								<xsl:choose>
									<xsl:when test="/Data/WTENTITY/WTWEBPAGE/@system-navbarimage or /Data/WTPAGE/@system-navbarimage">
										<xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;background&quot;&gt;&lt;xsl:value-of select=&quot;$tmpNavBarImage&quot;/&gt;&lt;/xsl:attribute&gt;', $cr)"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;background&quot;&gt;Images/', $navbarimage, '&lt;/xsl:attribute&gt;', $cr)"/>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:if>
							<xsl:if test="$NavBar!='blank'">
								<xsl:value-of select="concat($ind4, '&lt;xsl:call-template name=&quot;', $NavBarName, '&quot;/&gt;', $cr)"/>
							</xsl:if>
						</xsl:if>
						<xsl:if test="$IsMenu='true'">
							<xsl:value-of select="concat($tab0, '&lt;xsl:element name=&quot;SCRIPT&quot;&gt;', $cr)"/>
							<xsl:value-of select="concat($tab1, '&lt;xsl:attribute name=&quot;language&quot;&gt;JavaScript&lt;/xsl:attribute&gt;', $cr)"/>
							<xsl:value-of select="concat($tab1, 'var ', $MenuBar, ' = new CXPBar(', $MenuBar, 'Def, ', $apos, $MenuBar, $apos, '); ', $MenuBar, '.create();', $cr)"/>
							<xsl:value-of select="concat($tab0, '&lt;/xsl:element&gt;', $cr, $cr)"/>
						</xsl:if>
						<xsl:value-of select="concat($ind3, '&lt;/xsl:element&gt;', $cr)"/>
						<xsl:value-of select="concat($ind2, '&lt;/xsl:if&gt;', $cr)"/>
					</xsl:if>
					
					<xsl:value-of select="concat($ind2, '&lt;xsl:if test=&quot;/DATA/PARAM/@contentpage!=1&quot;&gt;', $cr)"/>
						<xsl:if test="$margin='true'">
							<xsl:value-of select="concat($ind3, '&lt;xsl:element name=&quot;TD&quot;&gt;', $cr)"/>
							<xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;width&quot;&gt;', $marginwidth, '&lt;/xsl:attribute&gt;', $cr)"/>
							<xsl:if test="$margincolor!=''">
	 							<xsl:variable name="bgcolor"><xsl:call-template name="GetColor"><xsl:with-param name="color" select="$margincolor"/></xsl:call-template></xsl:variable>
								<xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;bgcolor&quot;&gt;', $bgcolor, '&lt;/xsl:attribute&gt;', $cr)"/>
							</xsl:if>
							<xsl:if test="$marginimage!=''">
								<xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;background&quot;&gt;Images/', $marginimage, '&lt;/xsl:attribute&gt;', $cr)"/>
							</xsl:if>
							<xsl:value-of select="concat($ind3, '&lt;/xsl:element&gt;', $cr)"/>
						</xsl:if>
					<xsl:value-of select="concat($ind2, '&lt;/xsl:if&gt;', $cr)"/>

				</xsl:if>
				<xsl:if test="not(/Data/WTENTITY/WTWEBPAGE/@contentpage)">

					<!--***** Setup NavBar Column ************************************************************************-->
					<xsl:if test="$NavBar!=''">
						<xsl:if test="$IsMenu='false'">
							<xsl:if test="/Data/WTENTITY/WTWEBPAGE/@system-navbarimage or /Data/WTPAGE/@system-navbarimage">
								<xsl:value-of select="concat($ind2, '&lt;xsl:variable name=&quot;tmpNavBarImage&quot;&gt;', $cr)"/>
								<xsl:value-of select="concat($ind3, '&lt;xsl:if test=&quot;/DATA/SYSTEM/@navbarimage=', $apos, $apos, '&quot;&gt;Images/', $navbarimage, '&lt;/xsl:if&gt;', $cr)"/>
								<xsl:value-of select="concat($ind3, '&lt;xsl:if test=&quot;/DATA/SYSTEM/@navbarimage!=', $apos, $apos, '&quot;&gt;&lt;xsl:value-of select=&quot;/DATA/SYSTEM/@navbarimage&quot;/&gt;&lt;/xsl:if&gt;', $cr)"/>
								<xsl:value-of select="concat($ind2, '&lt;/xsl:variable&gt;', $cr)"/>
							</xsl:if>
						</xsl:if>

						<xsl:value-of select="concat($ind2, '&lt;xsl:element name=&quot;TD&quot;&gt;', $cr)"/>
						<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;align&quot;&gt;right&lt;/xsl:attribute&gt;', $cr)"/>
						<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;valign&quot;&gt;top&lt;/xsl:attribute&gt;', $cr)"/>
						<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;width&quot;&gt;', $navbarwidth, '&lt;/xsl:attribute&gt;', $cr)"/>

						<xsl:if test="$IsMenu='false'">
							<xsl:if test="$navbarcolor!=''">
	 							<xsl:variable name="bgcolor"><xsl:call-template name="GetColor"><xsl:with-param name="color" select="$navbarcolor"/></xsl:call-template></xsl:variable>
								<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;bgcolor&quot;&gt;', $bgcolor, '&lt;/xsl:attribute&gt;', $cr)"/>
							</xsl:if>
							<xsl:if test="$navbarimage!=''">
								<xsl:choose>
									<xsl:when test="/Data/WTENTITY/WTWEBPAGE/@system-navbarimage or /Data/WTPAGE/@system-navbarimage">
										<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;background&quot;&gt;&lt;xsl:value-of select=&quot;$tmpNavBarImage&quot;/&gt;&lt;/xsl:attribute&gt;', $cr)"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;background&quot;&gt;Images/', $navbarimage, '&lt;/xsl:attribute&gt;', $cr)"/>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:if>
							<xsl:if test="$NavBar!='blank'">
								<xsl:value-of select="concat($ind3, '&lt;xsl:call-template name=&quot;', $NavBarName, '&quot;/&gt;', $cr)"/>
							</xsl:if>
						</xsl:if>
						<xsl:if test="$IsMenu='true'">
							<xsl:value-of select="concat($tab0, '&lt;xsl:element name=&quot;SCRIPT&quot;&gt;', $cr)"/>
							<xsl:value-of select="concat($tab1, '&lt;xsl:attribute name=&quot;language&quot;&gt;JavaScript&lt;/xsl:attribute&gt;', $cr)"/>
							<xsl:value-of select="concat($tab1, 'var ', $MenuBar, ' = new CXPBar(', $MenuBar, 'Def, ', $apos, $MenuBar, $apos, '); ', $MenuBar, '.create();', $cr)"/>
							<xsl:value-of select="concat($tab0, '&lt;/xsl:element&gt;', $cr, $cr)"/>
						</xsl:if>
						<xsl:value-of select="concat($ind2, '&lt;/xsl:element&gt;', $cr, $cr)"/>
					</xsl:if>

					<xsl:if test="$margin='true'">
						<xsl:value-of select="concat($ind2, '&lt;xsl:element name=&quot;TD&quot;&gt;', $cr)"/>
						<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;width&quot;&gt;', $marginwidth, '&lt;/xsl:attribute&gt;', $cr)"/>
						<xsl:if test="$margincolor!=''">
	 						<xsl:variable name="bgcolor"><xsl:call-template name="GetColor"><xsl:with-param name="color" select="$margincolor"/></xsl:call-template></xsl:variable>
							<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;bgcolor&quot;&gt;', $bgcolor, '&lt;/xsl:attribute&gt;', $cr)"/>
						</xsl:if>
						<xsl:if test="$marginimage!=''">
							<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;background&quot;&gt;Images/', $marginimage, '&lt;/xsl:attribute&gt;', $cr)"/>
						</xsl:if>
						<xsl:value-of select="concat($ind2, '&lt;/xsl:element&gt;', $cr, $cr)"/>
					</xsl:if>

				</xsl:if>

				<!--***** Setup Content Column ************************************************************************-->
				<xsl:value-of select="concat($ind2, '&lt;xsl:element name=&quot;TD&quot;&gt;', $cr)"/>
				<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;valign&quot;&gt;top&lt;/xsl:attribute&gt;', $cr)"/>
				<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;width&quot;&gt;', $contentwidth, '&lt;/xsl:attribute&gt;', $cr, $cr)"/>
				<xsl:if test="$contentcolor!=''">
	 				<xsl:variable name="bgcolor"><xsl:call-template name="GetColor"><xsl:with-param name="color" select="$contentcolor"/></xsl:call-template></xsl:variable>
					<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;bgcolor&quot;&gt;', $bgcolor, '&lt;/xsl:attribute&gt;', $cr)"/>
				</xsl:if>
				<xsl:if test="$contentimage!=''">
					<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;background&quot;&gt;Images/', $contentimage, '&lt;/xsl:attribute&gt;', $cr)"/>
				</xsl:if>

				<xsl:variable name="border">
					<xsl:choose>
						<xsl:when test="/Data/WTENTITY/WTWEBPAGE/@test or /Data/WTPAGE/@test">1</xsl:when>
						<xsl:when test="@border"><xsl:value-of select="@border"/></xsl:when>
						<xsl:otherwise>0</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>

				<!--begin content table-->
				<xsl:value-of select="concat($ind3, '&lt;xsl:element name=&quot;TABLE&quot;&gt;', $cr)"/>
				<xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;border&quot;&gt;', $border, '&lt;/xsl:attribute&gt;', $cr)"/>
				<xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;cellpadding&quot;&gt;0&lt;/xsl:attribute&gt;', $cr)"/>
				<xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;cellspacing&quot;&gt;0&lt;/xsl:attribute&gt;', $cr)"/>
				<xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;width&quot;&gt;', $contentwidth, '&lt;/xsl:attribute&gt;', $cr, $cr)"/>

				<!--first blank line for the table-->
				<xsl:if test="not(@firstrow='false')">
					<xsl:value-of select="concat($ind4, '&lt;xsl:element name=&quot;TR&quot;&gt;', $cr)"/>
					<xsl:apply-templates select="WTCOLUMN">
						<xsl:with-param name="indent" select="$indent5"/>
					</xsl:apply-templates>		
					<xsl:value-of select="concat($ind4, '&lt;/xsl:element&gt;', $cr, $cr)"/>
				</xsl:if>

 				<xsl:apply-templates select="WTVARIABLE">
					<xsl:with-param name="indent" select="$indent4"/>
				</xsl:apply-templates>		

				<!--apply child elements (ROWS)-->
				<xsl:apply-templates select="WTROW | WTREPEAT | WTCODEGROUP | WTMETA | WTINPUTOPTIONS | WTCUSTOMFIELDS | WTSCRIPT">
					<xsl:with-param name="indent" select="$indent4"/>
				</xsl:apply-templates>		

				<!--end content table-->
				<xsl:value-of select="concat($ind3, '&lt;/xsl:element&gt;', $cr, $cr)"/>

				<xsl:value-of select="concat($ind2, '&lt;/xsl:element&gt;', $cr)"/>
				<xsl:call-template name="XSLComment">
					<xsl:with-param name="indent" select="$indent2"/>
					<xsl:with-param name="value">END CONTENT COLUMN</xsl:with-param>
				</xsl:call-template>
				<xsl:value-of select="$cr"/>

				<xsl:value-of select="concat($ind1, '&lt;/xsl:element&gt;', $cr, $cr)"/>
			</xsl:otherwise>
		</xsl:choose>

	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTINPUTOPTIONS">
	<!--==================================================================-->
		<xsl:param name="indent" select="1"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="ind2" select="concat($ind1, $tab1)"/>
		<xsl:variable name="ind3" select="concat($ind2, $tab1)"/>
		<xsl:variable name="indent3" select="$indent+2"/>
		<xsl:variable name="indent4" select="$indent+3"/>

		<!-- ***************** Error Checking *******************-->
		<xsl:if test="not(@name)">
		    <xsl:call-template name="Error">
		    	<xsl:with-param name="msg" select="'WTINPUTOPTIONS Name Missing'"/>
		    	<xsl:with-param name="text" select="position()"/>
		    </xsl:call-template>
		</xsl:if>
		<!--TEST valid attributes-->
		<xsl:for-each select="@*">
			<xsl:choose>
				<xsl:when test="name()='name'"/>
				<xsl:when test="name()='values'"/> <!--not used-->
				<xsl:when test="name()='price'"/> <!--not used-->
				<xsl:when test="name()='margin'"/>
				<xsl:when test="name()='entity'"/>
				<xsl:when test="name()='secure'"/>
				<xsl:otherwise>
					 <xsl:call-template name="Error">
						  <xsl:with-param name="msg" select="'Invalid WTINPUTOPTIONS Attribute'"/>
						  <xsl:with-param name="text" select="name()"/>
	 				</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
		<!-- ****************************************************-->

		<xsl:variable name="OName">
			<xsl:if test="@entity"><xsl:value-of select="@entity"/></xsl:if>
			<xsl:if test="not(@entity)"><xsl:value-of select="$entityname"/></xsl:if>
		</xsl:variable>
		<xsl:variable name="EName">
			<xsl:call-template name="CaseUpper">
				<xsl:with-param name="value" select="concat($appprefix,$OName)"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="OptionName">
			<xsl:call-template name="CaseUpper">
				<xsl:with-param name="value" select="@name"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="secure">
			<xsl:if test="not(@secure)">0</xsl:if>
			<xsl:if test="@secure"><xsl:value-of select="@secure"/></xsl:if>
		</xsl:variable>
		<xsl:variable name="margin">
			<xsl:if test="@margin"><xsl:value-of select="@margin"/></xsl:if>
			<xsl:if test="not(@margin)">0</xsl:if>
		</xsl:variable>

		<xsl:value-of select="concat($ind1, '&lt;xsl:for-each select=&quot;/DATA/TXN/', $EName, '/', $OptionName, 'S/', $OptionName, '&quot;&gt;', $cr )"/>
		<xsl:value-of select="concat($ind2, '&lt;xsl:call-template name=&quot;InputOptions&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($ind3, '&lt;xsl:with-param name=&quot;margin&quot; select=&quot;', $margin, '&quot;/&gt;', $cr)"/>
		<xsl:value-of select="concat($ind3, '&lt;xsl:with-param name=&quot;secure&quot; select=&quot;', $secure, '&quot;/&gt;', $cr)"/>
		<xsl:value-of select="concat($ind2, '&lt;/xsl:call-template&gt;', $cr)"/>
		<xsl:value-of select="concat($ind1, '&lt;/xsl:for-each&gt;', $cr, $cr )"/>
		
	</xsl:template>

  <!--==================================================================-->
  <xsl:template match="WTCUSTOMFIELDS">
    <!--==================================================================-->
    <xsl:param name="indent" select="1"/>
    <xsl:variable name="ind1">
      <xsl:call-template name="Indent">
        <xsl:with-param name="level" select="$indent"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="ind2" select="concat($ind1, $tab1)"/>
    <xsl:variable name="ind3" select="concat($ind2, $tab1)"/>
    <xsl:variable name="indent3" select="$indent+2"/>
    <xsl:variable name="indent4" select="$indent+3"/>

    <!-- ***************** Error Checking *******************-->
    <xsl:if test="not(@name)">
      <xsl:call-template name="Error">
        <xsl:with-param name="msg" select="'WTCUSTOMFIELDS Name Missing'"/>
        <xsl:with-param name="text" select="position()"/>
      </xsl:call-template>
    </xsl:if>
    <!--TEST valid attributes-->
    <xsl:for-each select="@*">
      <xsl:choose>
        <xsl:when test="name()='name'"/>
        <xsl:when test="name()='values'"/>
        <!--not used-->
        <xsl:when test="name()='price'"/>
        <!--not used-->
        <xsl:when test="name()='margin'"/>
        <xsl:when test="name()='entity'"/>
        <xsl:when test="name()='secure'"/>
        <xsl:when test="name()='display'"/>
        <xsl:otherwise>
          <xsl:call-template name="Error">
            <xsl:with-param name="msg" select="'Invalid WTCUSTOMFIELDS Attribute'"/>
            <xsl:with-param name="text" select="name()"/>
          </xsl:call-template>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>
    <!-- ****************************************************-->

    <xsl:variable name="OName">
      <xsl:if test="@entity">
        <xsl:value-of select="@entity"/>
      </xsl:if>
    </xsl:variable>
    <xsl:variable name="EName">
      <xsl:if test="@entity">
        <xsl:call-template name="CaseUpper">
          <xsl:with-param name="value" select="concat($appprefix,$OName)"/>
        </xsl:call-template>/
      </xsl:if>
    </xsl:variable>
    <xsl:variable name="OptionName">
      <xsl:call-template name="CaseUpper">
        <xsl:with-param name="value" select="@name"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="secure">
      <xsl:if test="not(@secure)">0</xsl:if>
      <xsl:if test="@secure">
        <xsl:value-of select="@secure"/>
      </xsl:if>
    </xsl:variable>
    <xsl:variable name="margin">
      <xsl:if test="@margin">
        <xsl:value-of select="@margin"/>
      </xsl:if>
      <xsl:if test="not(@margin)">0</xsl:if>
    </xsl:variable>

    <xsl:value-of select="concat($ind1, '&lt;xsl:for-each select=&quot;/DATA/TXN/', $EName, $OptionName, 'S/', $OptionName, '&quot;&gt;', $cr )"/>
    <xsl:value-of select="concat($ind2, '&lt;xsl:call-template name=&quot;CustomFields&quot;&gt;', $cr)"/>
    <xsl:value-of select="concat($ind3, '&lt;xsl:with-param name=&quot;margin&quot; select=&quot;', $margin, '&quot;/&gt;', $cr)"/>
    <xsl:value-of select="concat($ind3, '&lt;xsl:with-param name=&quot;secure&quot; select=&quot;', $secure, '&quot;/&gt;', $cr)"/>
    <xsl:if test="@display">
      <xsl:value-of select="concat($ind3, '&lt;xsl:with-param name=&quot;display&quot; select=&quot;1&quot;/&gt;', $cr)"/>
    </xsl:if>
    <xsl:value-of select="concat($ind2, '&lt;/xsl:call-template&gt;', $cr)"/>
    <xsl:value-of select="concat($ind1, '&lt;/xsl:for-each&gt;', $cr, $cr )"/>

  </xsl:template>

  <!--==================================================================-->
	<xsl:template match="WTCUSTOMREPORT">
	<!--==================================================================-->
		<xsl:param name="indent" select="1"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="ind2" select="concat($ind1, $tab1)"/>

		<!-- ***************** Error Checking *******************-->
		<!--TEST valid attributes-->
		<xsl:for-each select="@*">
			<xsl:choose>
				<xsl:when test="name()='parms'"/>
				<xsl:when test="name()='report'"/>
				<xsl:when test="name()='data'"/>
				<xsl:when test="name()='chart'"/>
				<xsl:otherwise>
					 <xsl:call-template name="Error">
						  <xsl:with-param name="msg" select="'Invalid WTCUSTOMREPORT Attribute'"/>
						  <xsl:with-param name="text" select="name()"/>
	 				</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
		<!-- ****************************************************-->

	 <xsl:if test="@parms">
		<xsl:value-of select="concat($ind1, '&lt;xsl:for-each select=&quot;', @parms, '&quot;&gt;', $cr )"/>
		<xsl:value-of select="concat($ind2, '&lt;xsl:call-template name=&quot;CustomReportParam&quot;/&gt;', $cr)"/>
		<xsl:value-of select="concat($ind1, '&lt;/xsl:for-each&gt;', $cr, $cr )"/>
	 </xsl:if>
	 <xsl:if test="@data">
		<xsl:value-of select="concat($ind1, '&lt;xsl:call-template name=&quot;CustomReportData&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($ind2, '&lt;xsl:with-param name=&quot;report&quot; select=&quot;', @report, '&quot;/&gt;', $cr )"/>
		<xsl:value-of select="concat($ind2, '&lt;xsl:with-param name=&quot;data&quot; select=&quot;', @data, '&quot;/&gt;', $cr )"/>
		<xsl:value-of select="concat($ind1, '&lt;/xsl:call-template&gt;', $cr, $cr )"/>
	 </xsl:if>
	 <xsl:if test="@chart">
		<xsl:value-of select="concat($ind1, '&lt;xsl:call-template name=&quot;CustomReportChart&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($ind2, '&lt;xsl:with-param name=&quot;report&quot; select=&quot;', @report, '&quot;/&gt;', $cr )"/>
		<xsl:value-of select="concat($ind2, '&lt;xsl:with-param name=&quot;chart&quot; select=&quot;', @chart, '&quot;/&gt;', $cr )"/>
		<xsl:value-of select="concat($ind1, '&lt;/xsl:call-template&gt;', $cr, $cr )"/>
	 </xsl:if>

	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTHEADER">
	<!--==================================================================-->
		<xsl:param name="indent" select="1"/>

	 <!-- ***************** Error Checking *******************-->
	 <!--Test valid attributes-->
	 <xsl:for-each select="@*">
			<xsl:choose>
		  	   <xsl:when test="name()=''"/>
				<xsl:otherwise>
					 <xsl:call-template name="Error">
						  <xsl:with-param name="msg" select="'WTHEADER Invalid Attribute'"/>
						  <xsl:with-param name="text" select="name()"/>
	 				</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
	 </xsl:for-each>
	 <!-- ****************************************************-->
		<xsl:call-template name="XSLComment">
			<xsl:with-param name="indent">5</xsl:with-param>
			<xsl:with-param name="value">HEADER TEXT</xsl:with-param>
		</xsl:call-template>
		<!--apply child elements (ROWS)-->
		<xsl:apply-templates select="WTROW">
			<xsl:with-param name="indent" select="$indent"/>
		</xsl:apply-templates>		
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTDIVIDER">
	<!--==================================================================-->
		<xsl:param name="indent" select="1"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="ind2" select="concat($ind1, $tab1)"/>
		<xsl:variable name="indent2" select="$indent+1"/>
		<xsl:variable name="ind3" select="concat($ind2, $tab1)"/>
		<xsl:variable name="hasconditions" select="(count(WTCONDITION) > 0)"/>

		<!-- ***************** Error Checking *******************-->
	 <xsl:if test="not(@col)">
	     <xsl:call-template name="Error">
	     	<xsl:with-param name="msg" select="'WTDIVIDER Column Missing'"/>
	     	<xsl:with-param name="text" select="position()"/>
	     </xsl:call-template>
	 </xsl:if>
	 <!--Test valid attributes-->
	 <xsl:for-each select="@*">
			<xsl:variable name="testcol">
				<xsl:call-template name="TestColAttr">
					<xsl:with-param name="attr" select="name()"/>
				</xsl:call-template>
			</xsl:variable>
		   <xsl:if test="$testcol='0'">
				<xsl:choose>
		  		   <xsl:when test="name()='color'"/>
					<xsl:otherwise>
						 <xsl:call-template name="Error">
							  <xsl:with-param name="msg" select="'WTDIVIDER Invalid Attribute'"/>
							  <xsl:with-param name="text" select="name()"/>
	 					</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose>
		   </xsl:if>
	 </xsl:for-each>
	 <!-- ****************************************************-->

		<xsl:variable name="width">
			<xsl:choose>
				<xsl:when test="@headerwidth"><xsl:value-of select="@headerwidth"/></xsl:when>
				<xsl:when test="@width"><xsl:value-of select="@width"/></xsl:when>
				<xsl:when test="(name()='WTTABLE')"><xsl:value-of select="sum(WTCOLUMN/@width)"/></xsl:when>
				<xsl:when test="ancestor::WTRECORDSET"></xsl:when>
				<xsl:when test="(ancestor::WTTABLE) and (@merge)">
					<xsl:value-of select="sum(ancestor::WTTABLE[1]/WTCOLUMN[(position() &gt;= (current()/@col)) and (position() &lt;= (current()/@col + current()/@merge - 1))]/@width)"/>
				</xsl:when>
				<xsl:when test="ancestor::WTTABLE"><xsl:value-of select="ancestor::WTTABLE[1]/WTCOLUMN[position()=current()/@col]/@width"/></xsl:when>
				<xsl:otherwise>			
					<xsl:choose>
						<xsl:when test="@merge"><xsl:value-of select="sum(ancestor::WTCONTENT/WTCOLUMN[(position() &gt;= (current()/@col)) and (position() &lt;= (current()/@col + current()/@merge - 1))]/@width)"/></xsl:when>
						<xsl:otherwise><xsl:value-of select="ancestor::WTCONTENT/WTCOLUMN[position()=current()/@col]/@width"/></xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
      <xsl:if test="$widthpercent='true'">%</xsl:if>
		</xsl:variable>

		<xsl:if test="($hasconditions)">
			<xsl:call-template name="XSLConditionStart">
				<xsl:with-param name="indent" select="$indent"/>
				<xsl:with-param name="conditions" select="WTCONDITION"/>
			</xsl:call-template>
		</xsl:if>

		<xsl:value-of select="concat($ind1, '&lt;xsl:element name=&quot;TD&quot;&gt;', $cr)"/>
			<xsl:value-of select="concat($ind2, '&lt;xsl:attribute name=&quot;width&quot;&gt;', $width, '&lt;/xsl:attribute&gt;', $cr)"/>
			<xsl:if test="(@merge)">
				<xsl:value-of select="concat($ind2, '&lt;xsl:attribute name=&quot;colspan&quot;&gt;', @merge, '&lt;/xsl:attribute&gt;', $cr)"/>
			</xsl:if>
		<xsl:value-of select="concat($ind2, '&lt;xsl:attribute name=&quot;height&quot;&gt;', @height, '&lt;/xsl:attribute&gt;',  $cr)"/>

		<!-- If using system colors, use the system divider color if provided, otherwise use divider color if provided -->
		<xsl:if test="/Data/WTENTITY/WTWEBPAGE/@system-colors or /Data/WTPAGE/@system-colors">
			<xsl:value-of select="concat($ind2, '&lt;xsl:if test=&quot;/DATA/SYSTEM/@colordivider!=', $apos, $apos,'&quot;&gt;', $cr)"/>
			<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;bgcolor&quot;&gt;#&lt;xsl:value-of select=&quot;/DATA/SYSTEM/@colordivider&quot;/&gt;&lt;/xsl:attribute&gt;', $cr)"/>
			<xsl:value-of select="concat($ind2, '&lt;/xsl:if&gt;', $cr)"/>
		</xsl:if>
		<xsl:if test="not(/Data/WTENTITY/WTWEBPAGE/@system-colors or /Data/WTPAGE/@system-colors)">
			<xsl:if test="(@color)">
	 			<xsl:variable name="color"><xsl:call-template name="GetColor"><xsl:with-param name="color" select="@color"/></xsl:call-template></xsl:variable>
				<xsl:value-of select="concat($ind2, '&lt;xsl:attribute name=&quot;bgcolor&quot;&gt;', $color, '&lt;/xsl:attribute&gt;', $cr)"/>
			</xsl:if>
		</xsl:if>

		<xsl:value-of select="concat($ind1, '&lt;/xsl:element&gt;', $cr)"/>

		<xsl:if test="($hasconditions)">
			<xsl:call-template name="XSLConditionEnd">
				<xsl:with-param name="indent" select="$indent"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTLINE">
	<!--==================================================================-->
		<xsl:param name="indent" select="1"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="ind2" select="concat($ind1, $tab1)"/>
		<xsl:variable name="ind3" select="concat($ind2, $tab1)"/>
		<xsl:variable name="indent2" select="$indent+1"/>

		<!-- ***************** Error Checking *******************-->
		<xsl:if test="not(ancestor::WTCODEGROUP)">
			<xsl:if test="not(@col)">
				<xsl:call-template name="Error">
					<xsl:with-param name="msg" select="'WTLINE Column Missing'"/>
					<xsl:with-param name="text" select="position()"/>
				</xsl:call-template>
			</xsl:if>
		</xsl:if>

		<!--Test valid attributes-->
		<xsl:for-each select="@*">
			<xsl:variable name="testcol">
				<xsl:call-template name="TestColAttr">
					<xsl:with-param name="attr" select="name()"/>
				</xsl:call-template>
			</xsl:variable>
		   <xsl:if test="$testcol='0'">
				<xsl:choose>
		  		   <xsl:when test="name()='color'"/>
					<xsl:when test="name()='size'"/>
					<xsl:when test="name()='width'"/>
					<xsl:when test="name()='height'"/>
					<xsl:when test="name()='line-width'"/>
					<xsl:otherwise>
						 <xsl:call-template name="Error">
							  <xsl:with-param name="msg" select="'WTLINE Invalid Attribute'"/>
							  <xsl:with-param name="text" select="name()"/>
	 					</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose>
		   </xsl:if>
	 </xsl:for-each>
	 <!-- ****************************************************-->

		<xsl:variable name="width">
			<xsl:choose>
				<xsl:when test="@merge"><xsl:value-of select="sum(ancestor::WTCONTENT/WTCOLUMN[(position() &gt;= (current()/@col)) and (position() &lt;= (current()/@col + current()/@merge - 1))]/@width)"/></xsl:when>
				<xsl:otherwise><xsl:value-of select="ancestor::WTCONTENT/WTCOLUMN[position() = current()/@col]/@width"/></xsl:otherwise>
			</xsl:choose>
      <xsl:if test="$widthpercent='true'">%</xsl:if>
    </xsl:variable>
		<xsl:variable name="height">
			<xsl:choose>
				<xsl:when test="@height"><xsl:value-of select="@height"/></xsl:when>
				<xsl:otherwise>1</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="size">
			<xsl:choose>
				<xsl:when test="@size"><xsl:value-of select="@size"/></xsl:when>
				<xsl:otherwise>1</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:value-of select="concat($ind1, '&lt;xsl:element name=&quot;TD&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($ind2, '&lt;xsl:attribute name=&quot;width&quot;&gt;', $width, '&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($ind2, '&lt;xsl:attribute name=&quot;height&quot;&gt;', $height, '&lt;/xsl:attribute&gt;',  $cr)"/>
			<xsl:if test="(@merge)">
				<xsl:value-of select="concat($ind2, '&lt;xsl:attribute name=&quot;colspan&quot;&gt;', @merge, '&lt;/xsl:attribute&gt;', $cr)"/>
			</xsl:if>
		<xsl:value-of select="concat($ind2, '&lt;xsl:element name=&quot;HR&quot;&gt;', $cr)"/>
	 	<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;size&quot;&gt;', $size, '&lt;/xsl:attribute&gt;',  $cr)"/>
		<xsl:if test="(@line-width)">
			<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;width&quot;&gt;', @line-width, '&lt;/xsl:attribute&gt;', $cr)"/>
		</xsl:if>

		<xsl:if test="(@color)">
	 		<xsl:variable name="color"><xsl:call-template name="GetColor"><xsl:with-param name="color" select="@color"/></xsl:call-template></xsl:variable>
			<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;color&quot;&gt;', $color, '&lt;/xsl:attribute&gt;', $cr)"/>
		</xsl:if>
		<xsl:value-of select="concat($ind2, '&lt;/xsl:element&gt;', $cr)"/>
		<xsl:value-of select="concat($ind1, '&lt;/xsl:element&gt;', $cr)"/>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTLINEX">
	<!--==================================================================-->
		<xsl:param name="indent" select="1"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="ind2" select="concat($ind1, $tab1)"/>
		<xsl:variable name="ind3" select="concat($ind2, $tab1)"/>
		<xsl:variable name="indent2" select="$indent+1"/>

	 <!-- ***************** Error Checking *******************-->
	 <!--Test valid attributes-->
	 <xsl:for-each select="@*">
		<xsl:choose>
			<xsl:when test="name()='color'"/>
			<xsl:when test="name()='size'"/>
			<xsl:otherwise>
					<xsl:call-template name="Error">
						<xsl:with-param name="msg" select="'WTLINE Invalid Attribute'"/>
						<xsl:with-param name="text" select="name()"/>
	 			</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	 </xsl:for-each>
	 <!-- ****************************************************-->

		<xsl:variable name="size">
			<xsl:choose>
				<xsl:when test="@size"><xsl:value-of select="@size"/></xsl:when>
				<xsl:otherwise>1</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:value-of select="concat($ind2, '&lt;xsl:element name=&quot;HR&quot;&gt;', $cr)"/>
	 	<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;size&quot;&gt;', $size, '&lt;/xsl:attribute&gt;',  $cr)"/>
		<xsl:if test="(@color)">
	 		<xsl:variable name="color"><xsl:call-template name="GetColor"><xsl:with-param name="color" select="@color"/></xsl:call-template></xsl:variable>
			<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;color&quot;&gt;', $color, '&lt;/xsl:attribute&gt;', $cr)"/>
		</xsl:if>
		<xsl:value-of select="concat($ind2, '&lt;/xsl:element&gt;', $cr)"/>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTFILE">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:param name="wrap" select="false()"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="ind2" select="concat($ind1, $tab1)"/>
		<xsl:variable name="indent2" select="$indent+1"/>
		<xsl:variable name="ind3" select="concat($ind2, $tab1)"/>
		<xsl:variable name="indent3" select="$indent2+1"/>
		  <xsl:variable name="valuetype"><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>
		  <xsl:variable name="valuetext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>
		  <xsl:variable name="valueentity"><xsl:call-template name="QualifiedPrefix"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>
		<xsl:variable name="attribute" select="/Data/WTENTITY/WTATTRIBUTE[@name=$valuetext]"/>

	 <!-- ***************** Error Checking *******************-->
	 <xsl:if test="not(@col)">
	     <xsl:call-template name="Error">
	     	<xsl:with-param name="msg" select="'WTFILE Column Missing'"/>
	     	<xsl:with-param name="text" select="position()"/>
	     </xsl:call-template>
	 </xsl:if>
	 <!--Test valid attributes-->
	 <xsl:for-each select="@*">
			<xsl:variable name="testcol">
				<xsl:call-template name="TestColAttr">
					<xsl:with-param name="attr" select="name()"/>
				</xsl:call-template>
			</xsl:variable>
		   <xsl:if test="$testcol='0'">
				<xsl:choose>
		  			<xsl:when test="name()='size'"/>
		  			<xsl:when test="name()='disabled'"/>
		  			<xsl:when test="name()='accept'"/>
					<xsl:otherwise>
						 <xsl:call-template name="Error">
							  <xsl:with-param name="msg" select="'WTFILE Invalid Attribute'"/>
							  <xsl:with-param name="text" select="name()"/>
	 					</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose>
		   </xsl:if>
	 </xsl:for-each>
	 <!-- ****************************************************-->

		<!--begin the column tag-->
		<xsl:apply-templates select="." mode="cell-begin">
			<xsl:with-param name="indent" select="$indent"/>
			<xsl:with-param name="wrap" select="$wrap"/>
			<xsl:with-param name="isfirst" select="position()=1"/>
		</xsl:apply-templates>

		<!--build the input control-->
		<xsl:value-of select="concat($ind2, '&lt;xsl:element name=&quot;INPUT&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;type&quot;&gt;file&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;name&quot;&gt;', $valuetext, '&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;id&quot;&gt;', $valuetext, '&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:variable name="size">
			<xsl:choose>
				<xsl:when test="@size"><xsl:value-of select="@size"/></xsl:when>
				<xsl:when test="($attribute/@length > 40)">40</xsl:when>
				<xsl:when test="($attribute/@length)"><xsl:value-of select="/Data/WTENTITY/WTATTRIBUTE[@name=$valuetext]/@length"/></xsl:when>
				<xsl:otherwise>20</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;size&quot;&gt;', $size, '&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;value&quot;&gt;')"/>
		<xsl:call-template name="XSLDataField">
			<xsl:with-param name="entity" select="$valueentity"/>
			<xsl:with-param name="name" select="$valuetext"/>
			<xsl:with-param name="newline" select="false()"/>
		</xsl:call-template>
		<xsl:value-of select="concat('&lt;/xsl:attribute&gt;', $cr)"/>
		
		  <!--disable the field if specified-->
		  <xsl:if test="@disabled">
				<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;DISABLED&quot;/&gt;', $cr)"/>
		  </xsl:if>
		  <xsl:if test="@accept">
				<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;accept&quot;&gt;', @accept, '&lt;/xsl:attribute&gt;', $cr)"/>
		  </xsl:if>
<!--
		<xsl:apply-templates select="." mode="read-only">
			<xsl:with-param name="indent" select="$indent3"/>
		</xsl:apply-templates>
-->
		<xsl:value-of select="concat($ind2, '&lt;/xsl:element&gt;', $cr)"/>

		<!--required field indicator-->
		<xsl:if test="not(@required='false') and (@required='true' or ($attribute/@required='true'))">
			<xsl:apply-templates select="." mode="require-mark">
				<xsl:with-param name="indent" select="$indent2"/>
			</xsl:apply-templates>
		</xsl:if>

		<!--end the column tag-->
		<xsl:apply-templates select="." mode="cell-end">
			<xsl:with-param name="indent" select="$indent"/>
			<xsl:with-param name="wrap" select="$wrap"/>
			<xsl:with-param name="islast" select="position()=last()"/>
		</xsl:apply-templates>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTLINK">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:param name="label"/>
		<xsl:param name="class"/>
		<xsl:param name="type"/>
		<xsl:param name="part">0</xsl:param> 

		<xsl:variable name="hasconditions" select="(count(WTCONDITION) > 0)"/>
		<xsl:variable name="isrepeat" select="(@repeat='true')"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="ind2">
			<xsl:choose>
			<xsl:when test="($isrepeat)">
				<xsl:choose><xsl:when test="($hasconditions)"><xsl:value-of select="concat($ind1, $tab2)"/></xsl:when><xsl:otherwise><xsl:value-of select="concat($ind1, $tab1)"/></xsl:otherwise></xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<xsl:choose><xsl:when test="($hasconditions)"><xsl:value-of select="concat($ind1, $tab1)"/></xsl:when><xsl:otherwise><xsl:value-of select="$ind1"/></xsl:otherwise></xsl:choose>
			</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="indent2">
			<xsl:choose>
			<xsl:when test="($isrepeat)">
				<xsl:choose><xsl:when test="($hasconditions)"><xsl:value-of select="$indent+2"/></xsl:when><xsl:otherwise><xsl:value-of select="$indent+1"/></xsl:otherwise></xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<xsl:choose><xsl:when test="($hasconditions)"><xsl:value-of select="$indent+1"/></xsl:when><xsl:otherwise><xsl:value-of select="$indent"/></xsl:otherwise></xsl:choose>
			</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="ind3" select="concat($ind2, $tab1)"/>
		<xsl:variable name="indent3" select="$indent2+1"/>
		<xsl:variable name="ind4" select="concat($ind3, $tab1)"/>
		<xsl:variable name="indent4" select="$indent3+1"/>
		<xsl:variable name="ind5" select="concat($ind4, $tab1)"/>
		<xsl:variable name="indent5" select="$indent4+1"/>

		<xsl:variable name="secure">
			<xsl:choose>
				<xsl:when test="@secure"><xsl:value-of select="@secure"/></xsl:when>
				<xsl:when test="/Data/WTENTITY/WTWEBPAGE/@secure"><xsl:value-of select="/Data/WTENTITY/WTWEBPAGE/@secure"/></xsl:when>
				<xsl:when test="/Data/WTPAGE/@secure"><xsl:value-of select="/Data/WTPAGE/@secure"/></xsl:when>
			</xsl:choose>
		</xsl:variable>

	 <!-- ***************** Error Checking *******************-->
	 <xsl:if test="not(@name)">
	     <xsl:call-template name="Error">
	     	<xsl:with-param name="msg" select="'WTLINK Name Missing'"/>
	     	<xsl:with-param name="text" select="position()"/>
	     </xsl:call-template>
	 </xsl:if>
	<!-- Links within Static text cannot have values, tags or labels -->
	 <xsl:if test="$part=1 and (@value or @tag or @label)">
	     <xsl:call-template name="Error">
	     	<xsl:with-param name="msg" select="'WTLINK WTSTATIC Invalid value, tag or label'"/>
	     	<xsl:with-param name="text" select="concat(@value, @tag, @label)"/>
	     </xsl:call-template>
	 </xsl:if>
	 <!--Test valid attributes-->
	 <xsl:for-each select="@*">
		  <xsl:choose>
				<xsl:when test="name()='name'"/>
				<xsl:when test="name()='value'"/>
				<xsl:when test="name()='tag'"/>
				<xsl:when test="name()='label'"/>
				<xsl:when test="name()='class'"/>
				<xsl:when test="name()='target'"/>
				<xsl:when test="name()='targetstyle'"/>
				<xsl:when test="name()='nodata'"/>
				<xsl:when test="name()='nolocaldata'"/>
				<xsl:when test="name()='skipreturn'"/>
				<xsl:when test="name()='return'"/>
				<xsl:when test="name()='enum'"/>
				<xsl:when test="name()='type'"/>
				<xsl:when test="name()='secure'"/>
				<xsl:when test="name()='embedhtml'"/>
				<xsl:when test="name()='click'"/>
				  <xsl:when test="name()='style'"/>
				  <xsl:when test="name()='divider'"/>
			  <xsl:otherwise>
					 <xsl:call-template name="Error">
						  <xsl:with-param name="msg" select="'WTLINK Invalid Attribute'"/>
						  <xsl:with-param name="text" select="name()"/>
	 				</xsl:call-template>
				</xsl:otherwise>
		  </xsl:choose>
	 </xsl:for-each>
	 <!-- ****************************************************-->

		<xsl:variable name="labeltype">
			<xsl:choose>
				<xsl:when test="($label)"><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="$label"/></xsl:call-template></xsl:when>
				<xsl:otherwise><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="@label"/></xsl:call-template></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="labeltext">
			<xsl:choose>
				<xsl:when test="($label)"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="$label"/></xsl:call-template></xsl:when>
				<xsl:otherwise><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@label"/></xsl:call-template></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="labelentity">
			<xsl:choose>
				<xsl:when test="($label)"><xsl:call-template name="QualifiedPrefix"><xsl:with-param name="value" select="$label"/></xsl:call-template></xsl:when>
				<xsl:otherwise><xsl:call-template name="QualifiedPrefix"><xsl:with-param name="value" select="@label"/></xsl:call-template></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="nametype"><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="@name"/></xsl:call-template></xsl:variable>
		<xsl:variable name="nametext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@name"/></xsl:call-template></xsl:variable>
		<xsl:variable name="nameentity"><xsl:call-template name="QualifiedPrefix"><xsl:with-param name="value" select="@name"/></xsl:call-template></xsl:variable>

		<!--generate IF statement for conditions if they exist-->
		<xsl:if test="$part = 0 or $part = 1">
			<xsl:if test="($hasconditions)">
				<xsl:call-template name="XSLConditionStart">
					<xsl:with-param name="indent" select="$indent"/>
					<xsl:with-param name="conditions" select="WTCONDITION"/>
				</xsl:call-template>
			</xsl:if>
		</xsl:if>

		<xsl:if test="$isrepeat">
			<xsl:value-of select="concat($ind1, '&lt;xsl:for-each select=&quot;')"/>
			<xsl:call-template name="XSLDataPath">
				<xsl:with-param name="entity" select="$labelentity"/>
				<xsl:with-param name="iscollection" select="true()"/>
			</xsl:call-template>
			<xsl:value-of select="concat($tab0, '&quot;&gt;', $cr)"/>

			<xsl:if test="not(@divider='false')">
				<xsl:value-of select="concat($ind2, '&lt;xsl:if test=&quot;(position() != 1)&quot;&gt;', $cr)"/>
				<xsl:value-of select="concat($ind3, '&lt;xsl:text disable-output-escaping=&quot;yes&quot;&gt;&amp;amp;#160;|&amp;amp;#160;&lt;/xsl:text&gt;', $cr)"/>
				<xsl:value-of select="concat($ind2, '&lt;/xsl:if&gt;', $cr)"/>
			</xsl:if>
		</xsl:if>


		<xsl:if test="$part = 0 or $part = 1">
			<!--create the anchor element-->
			<xsl:value-of select="concat($ind2, '&lt;xsl:element name=&quot;A&quot;&gt;', $cr)"/>
			<xsl:choose>
				<xsl:when test="@class"><xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;class&quot;&gt;',@class, '&lt;/xsl:attribute&gt;', $cr)"/></xsl:when>		
				<xsl:when test="$class"><xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;class&quot;&gt;',$class, '&lt;/xsl:attribute&gt;', $cr)"/></xsl:when>		
			</xsl:choose>
			<xsl:if test="@target">
				<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;onclick&quot;&gt;w=window.open(this.href,&quot;', @target, '&quot;,&quot;', @targetstyle, '&quot;);if (window.focus) {w.focus();};return false;&lt;/xsl:attribute&gt;', $cr)"/>
			</xsl:if>		
			<xsl:if test="@style"><xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;style&quot;&gt;',@style, '&lt;/xsl:attribute&gt;', $cr)"/></xsl:if>		

			<xsl:choose>
				<xsl:when test="@click">
					<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;href&quot;&gt;#_&lt;/xsl:attribute&gt;', $cr)"/>
					<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;onclick&quot;&gt;')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;href&quot;&gt;')"/>
				</xsl:otherwise>
			</xsl:choose>

			<xsl:choose>
				<xsl:when test="(@type='anchor' or @click)">
					<xsl:variable name="entity">
						<xsl:choose>
							<xsl:when test="$nameentity != ''"><xsl:value-of select="$nameentity"/></xsl:when>
							<xsl:otherwise><xsl:value-of select="$entityname"/></xsl:otherwise>
						</xsl:choose>
					</xsl:variable>
					<xsl:call-template name="GetValue">
						<xsl:with-param name="type" select="$nametype"/>
						<xsl:with-param name="text" select="$nametext"/>
						<xsl:with-param name="entity" select="$entity"/>
					</xsl:call-template>

					<!--add return URL parameters-->
					<xsl:if test="@return='true'">
						<xsl:if test="not(@target)">
							<xsl:text>&amp;amp;</xsl:text>
							<xsl:choose>
								<xsl:when test="@skipreturn">
									<xsl:value-of select="concat($tab0, 'ReturnURL=&lt;xsl:value-of select=&quot;/DATA/SYSTEM/@returnurl&quot;/&gt;')"/>
								</xsl:when>
								<xsl:when test="@nodata">
									<xsl:value-of select="concat($tab0, 'ReturnURL=&lt;xsl:value-of select=&quot;/DATA/SYSTEM/@pageURL&quot;/&gt;')"/>
								</xsl:when>
								<xsl:when test="not(@nodata)">
									<xsl:value-of select="concat($tab0, 'ReturnURL=&lt;xsl:value-of select=&quot;/DATA/SYSTEM/@pageURL&quot;/&gt;&amp;amp;ReturnData=&lt;xsl:value-of select=&quot;/DATA/SYSTEM/@pageData&quot;/&gt;')"/>
								</xsl:when>
							</xsl:choose>
						</xsl:if>
					</xsl:if>

				</xsl:when>
				<xsl:when test="(@type='mail')">
					<xsl:value-of select="'mailto:'"/>
					<xsl:choose>
						<xsl:when test="($nametype='CONST')">
							<xsl:value-of select="$nametext"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:variable name="entity">
								<xsl:choose>
									<xsl:when test="$nameentity != ''"><xsl:value-of select="$nameentity"/></xsl:when>
									<xsl:otherwise><xsl:value-of select="$entityname"/></xsl:otherwise>
								</xsl:choose>
							</xsl:variable>
							<xsl:call-template name="GetValue">
								<xsl:with-param name="type" select="$nametype"/>
								<xsl:with-param name="text" select="$nametext"/>
								<xsl:with-param name="entity" select="$entity"/>
							</xsl:call-template>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>

				<xsl:when test="($nametype='JAVA')">
					<xsl:value-of select="concat('javascript: ', $nametext)"/>
				</xsl:when>
				<xsl:when test="($nametype='CONST')">
					<xsl:value-of select="$nametext"/>
				</xsl:when>
				<xsl:when test="($nametype='SYS')">
					<xsl:call-template name="GetValue">
						<xsl:with-param name="type" select="'SYS'"/>
						<xsl:with-param name="text" select="$nametext"/>
					</xsl:call-template>
				</xsl:when>
				<xsl:when test="($nametype='DOC')">
					<xsl:variable name="datafield">
						<xsl:call-template name="XSLDataField">
							<xsl:with-param name="entity" select="$nameentity"/>
							<xsl:with-param name="name" select="$nametext"/>
							<xsl:with-param name="noselect" select="true()"/>
							<xsl:with-param name="newline" select="false()"/>
						</xsl:call-template>
					</xsl:variable>
					<xsl:value-of select="concat($tab0, '&lt;xsl:value-of select=&quot;concat(/DATA/CONFIG/@documentpath, ', $apos, '/', $apos, ', ', $datafield, ')&quot;/&gt;')"/>
				</xsl:when>
				<xsl:otherwise>

					<xsl:choose>
						<xsl:when test="$secure='true'">
							<xsl:value-of select="concat('&lt;xsl:if test=&quot;/DATA/SYSTEM/@servername!=', $apos, 'localhost', $apos, '&quot;&gt;')"/>
							<xsl:value-of select="concat('&lt;xsl:value-of select=&quot;concat(', $apos, 'https://', $apos, ', /DATA/SYSTEM/@servername, /DATA/SYSTEM/@serverpath)&quot;/&gt;')"/>
							<xsl:value-of select="'&lt;/xsl:if&gt;'"/>
						</xsl:when>
						<xsl:when test="$secure='false'">
							<xsl:value-of select="concat('&lt;xsl:value-of select=&quot;concat(', $apos, 'http://', $apos, ', /DATA/SYSTEM/@servername, /DATA/SYSTEM/@serverpath)&quot;/&gt;')"/>
						</xsl:when>
					</xsl:choose>
				
					<xsl:value-of select="concat(@name, '.asp')"/>
					<!--add the parameters to the link-->
					<xsl:apply-templates select="WTPARAM">
						<xsl:with-param name="isrepeat" select="$isrepeat"/>
					</xsl:apply-templates>

					<!--add return URL parameters-->
					<xsl:if test="not(@return='false')">
						<xsl:if test="not(@target)">
							<xsl:choose>
								<xsl:when test="(count(WTPARAM)=0)"><xsl:text>?</xsl:text></xsl:when>
								<xsl:otherwise><xsl:text>&amp;amp;</xsl:text></xsl:otherwise>
							</xsl:choose>
							<xsl:choose>
								<xsl:when test="@skipreturn">
									<xsl:value-of select="concat($tab0, 'ReturnURL=&lt;xsl:value-of select=&quot;/DATA/SYSTEM/@returnurl&quot;/&gt;')"/>
								</xsl:when>
								<xsl:when test="@nodata">
									<xsl:value-of select="concat($tab0, 'ReturnURL=&lt;xsl:value-of select=&quot;/DATA/SYSTEM/@pageURL&quot;/&gt;')"/>
								</xsl:when>
								<xsl:when test="not(@nodata)">
									<xsl:value-of select="concat($tab0, 'ReturnURL=&lt;xsl:value-of select=&quot;/DATA/SYSTEM/@pageURL&quot;/&gt;&amp;amp;ReturnData=&lt;xsl:value-of select=&quot;/DATA/SYSTEM/@pageData&quot;/&gt;')"/>
								</xsl:when>
							</xsl:choose>
						</xsl:if>
					</xsl:if>
				</xsl:otherwise>
			</xsl:choose>

			<xsl:value-of select="concat($tab0, '&lt;/xsl:attribute&gt;', $cr)"/>
		</xsl:if>

		<xsl:if test="$part = 0">
			<!--display the text for the link-->
			<xsl:if test="@tag">
				<xsl:call-template name="XSLLabelText">
					<xsl:with-param name="label" select="@tag"/>
					<xsl:with-param name="indent" select="$indent2+1"/>
					<xsl:with-param name="newline" select="true()"/>
				</xsl:call-template>
				<xsl:value-of select="concat($ind3, '&lt;xsl:text disable-output-escaping=&quot;yes&quot;&gt;:&amp;amp;#160;&lt;/xsl:text&gt;', $cr)"/>
			</xsl:if>

			<xsl:choose>
				<xsl:when test="($label='IMG')">
					<xsl:call-template name="XSLImage">
						<xsl:with-param name="indent" select="$indent2+1"/>
						<xsl:with-param name="image" select=".."/>
					</xsl:call-template>
				</xsl:when>

				<xsl:when test="($labeltype='NONE')">
					<xsl:call-template name="XSLLabelText">
						<xsl:with-param name="label" select="$labeltext"/>
						<xsl:with-param name="indent" select="$indent2+1"/>
						<xsl:with-param name="newline" select="true()"/>
					</xsl:call-template>
				</xsl:when>

				<!--Yes/No fields need condition for the correct label to display-->
				<xsl:when test="($labeltype='DATA') and ((/Data/WTENTITY/WTATTRIBUTE[@name=$labeltext]/@type='yesno') or ($type='yesno') or (@type='yesno'))">
					<xsl:variable name="fieldname">
						<xsl:call-template name="XSLDataField">
							<xsl:with-param name="name" select="$labeltext"/>
							<xsl:with-param name="newline" select="false()"/>
							<xsl:with-param name="noselect" select="true()"/>
						</xsl:call-template>
					</xsl:variable>
					<xsl:value-of select="concat($ind3, '&lt;xsl:choose&gt;', $cr)"/>
					<xsl:value-of select="concat($ind4, '&lt;xsl:when test=&quot;(', $fieldname, '=', $apos, '0', $apos, ')&quot;&gt;', $cr)"/>

					<xsl:call-template name="XSLLabelText">
						<xsl:with-param name="label" select="concat($labeltext,'False')"/>
						<xsl:with-param name="indent" select="$indent5"/>
						<xsl:with-param name="newline" select="true()"/>
					</xsl:call-template>
					<xsl:value-of select="concat($ind4, '&lt;/xsl:when&gt;', $cr)"/>
					<xsl:value-of select="concat($ind4, '&lt;xsl:otherwise&gt;', $cr)"/>
					<xsl:call-template name="XSLLabelText">
						<xsl:with-param name="label" select="concat($labeltext,'True')"/>
						<xsl:with-param name="indent" select="$indent5"/>
						<xsl:with-param name="newline" select="true()"/>
					</xsl:call-template>
					<xsl:value-of select="concat($ind4, '&lt;/xsl:otherwise&gt;', $cr)"/>
					<xsl:value-of select="concat($ind3, '&lt;/xsl:choose&gt;', $cr)"/>
				</xsl:when>

				<xsl:otherwise>
				
					<xsl:variable name="entity">
						<xsl:choose>
							<xsl:when test="$labelentity != ''"><xsl:value-of select="$labelentity"/></xsl:when>
							<xsl:otherwise><xsl:value-of select="$entityname"/></xsl:otherwise>
						</xsl:choose>
					</xsl:variable>
					<xsl:value-of select="$ind3"/>
					<xsl:call-template name="GetValue">
						<xsl:with-param name="type" select="$labeltype"/>
						<xsl:with-param name="text" select="$labeltext"/>
						<xsl:with-param name="entity" select="$entity"/>
						<xsl:with-param name="output" select="true()"/>
					</xsl:call-template>
					<xsl:value-of select="$cr"/>

				</xsl:otherwise>
				
			</xsl:choose>
		</xsl:if>

		<xsl:if test="$part = 0 or $part = 2">
			<xsl:value-of select="concat($ind2, '&lt;/xsl:element&gt;', $cr)"/>
		</xsl:if>

		<xsl:if test="$isrepeat">
			<xsl:value-of select="concat($ind1, '&lt;/xsl:for-each&gt;', $cr)"/>
			<xsl:value-of select="concat($ind1, '&lt;xsl:if test=&quot;(count(')"/>
			<xsl:call-template name="XSLDataPath">
				<xsl:with-param name="entity" select="$labelentity"/>
				<xsl:with-param name="iscollection" select="true()"/>
			</xsl:call-template>
			<xsl:value-of select="concat(') &amp;gt; 0)&quot;&gt;', $cr)"/>
			<xsl:if test="not(@divider='false')">
				<xsl:value-of select="concat($ind2, '&lt;xsl:text disable-output-escaping=&quot;yes&quot;&gt;&amp;amp;#160;|&amp;amp;#160;&lt;/xsl:text&gt;', $cr)"/>
			</xsl:if>
			<xsl:value-of select="concat($ind1, '&lt;/xsl:if&gt;', $cr)"/>
		</xsl:if>

		<xsl:if test="position() != last() and not($isrepeat)">
			<xsl:if test="not(@divider='false')">
				<xsl:value-of select="concat($ind1, '&lt;xsl:text disable-output-escaping=&quot;yes&quot;&gt;&amp;amp;#160;|&amp;amp;#160;&lt;/xsl:text&gt;', $cr)"/>
			</xsl:if>
		</xsl:if>

		<!--close IF statement for conditions if they exist-->
		<xsl:if test="$part = 0 or $part = 2">
			<xsl:if test="($hasconditions)">
				<xsl:call-template name="XSLConditionEnd">
					<xsl:with-param name="indent" select="$indent"/>			
				</xsl:call-template>
			</xsl:if>
		</xsl:if>

	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTMETA">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:variable name="hasconditions" select="(count(WTCONDITION) > 0)"/>
		<xsl:variable name="ind"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="ind1">
			<xsl:choose>
				<xsl:when test="($hasconditions)"><xsl:value-of select="concat($ind, $tab1)"/></xsl:when>
				<xsl:otherwise><xsl:value-of select="$ind"/></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="ind2"><xsl:value-of select="concat($ind1, $tab1)"/></xsl:variable>

	 <!-- ***************** Error Checking *******************-->
	 <!--Test valid attributes-->
	 <xsl:if test="not(@type)">
	     <xsl:call-template name="Error">
	     	<xsl:with-param name="msg" select="'WTMETA Type Missing'"/>
	     	<xsl:with-param name="text" select="position()"/>
	     </xsl:call-template>
	 </xsl:if>
	 <xsl:if test="not(@content)">
	     <xsl:call-template name="Error">
	     	<xsl:with-param name="msg" select="'WTMETA Content Missing'"/>
	     	<xsl:with-param name="text" select="@type"/>
	     </xsl:call-template>
	 </xsl:if>
	 <xsl:for-each select="@*">
		  <xsl:choose>
				<xsl:when test="name()='type'"/>
				<xsl:when test="name()='content'"/>
				<xsl:otherwise>
					 <xsl:call-template name="Error">
						  <xsl:with-param name="msg" select="'WTMETA Invalid Attribute'"/>
						  <xsl:with-param name="text" select="name()"/>
	 				</xsl:call-template>
				</xsl:otherwise>
		  </xsl:choose>
	 </xsl:for-each>
	 <!-- ****************************************************-->

		<!--generate IF statement for conditions if they exist-->
		<xsl:if test="($hasconditions)">
			<xsl:call-template name="XSLConditionStart">
				<xsl:with-param name="indent" select="$indent"/>
				<xsl:with-param name="conditions" select="WTCONDITION"/>
			</xsl:call-template>
		</xsl:if>

		<xsl:value-of select="concat($ind1, '&lt;xsl:element name=&quot;meta&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($ind2, '&lt;xsl:attribute name=&quot;http-equiv&quot;&gt;',@type, '&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($ind2, '&lt;xsl:attribute name=&quot;content&quot;&gt;',@content, '&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($ind1, '&lt;/xsl:element&gt;', $cr)"/>

		<!--close IF statement for conditions if they exist-->
		<xsl:if test="($hasconditions)">
			<xsl:call-template name="XSLConditionEnd">
				<xsl:with-param name="indent" select="$indent"/>			
			</xsl:call-template>
		</xsl:if>

	</xsl:template>


	 <!--==================================================================-->
	 <xsl:template match="WTLINK/WTPARAM">
	 <!--==================================================================-->
		  <xsl:param name="isrepeat"/>

	 <!-- ***************** Error Checking *******************-->
	 <xsl:if test="not(@name)">
	     <xsl:call-template name="Error">
	     	<xsl:with-param name="msg" select="'WTLINK/WTPARAM Name Missing'"/>
	     	<xsl:with-param name="text" select="position()"/>
	     </xsl:call-template>
	 </xsl:if>
	 <xsl:if test="not(@value)">
	     <xsl:call-template name="Error">
	     	<xsl:with-param name="msg" select="'WTLINK/WTPARAM Value Missing'"/>
	     	<xsl:with-param name="text" select="@name"/>
	     </xsl:call-template>
	 </xsl:if>
	 <!--Test valid attributes-->
	 <xsl:for-each select="@*">
		  <xsl:choose>
				<xsl:when test="name()='name'"/>
				<xsl:when test="name()='value'"/>
				<xsl:when test="name()='clean'"/>
				<xsl:otherwise>
					 <xsl:call-template name="Error">
						  <xsl:with-param name="msg" select="'WTLINK/WTPARAM Invalid Attribute'"/>
						  <xsl:with-param name="text" select="name()"/>
	 				</xsl:call-template>
				</xsl:otherwise>
		  </xsl:choose>
	 </xsl:for-each>
	 <!-- ****************************************************-->

		  <xsl:choose>
				<xsl:when test="(position() = '1')">?</xsl:when>
				<xsl:otherwise>&amp;amp;</xsl:otherwise>
		  </xsl:choose>
		  <xsl:value-of select="concat(@name, '=')"/>

		  <xsl:variable name="valuetype"><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>
		  <xsl:variable name="valuetext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>
		  <xsl:variable name="valueentity"><xsl:call-template name="QualifiedPrefix"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>

		  <xsl:variable name="entity">
				<xsl:choose>
					 <xsl:when test="$valueentity != ''"><xsl:value-of select="$valueentity"/></xsl:when>
					 <xsl:otherwise><xsl:value-of select="$entityname"/></xsl:otherwise>
				</xsl:choose>
		  </xsl:variable>
		
		  <xsl:if test="not(@clean)">
			<xsl:call-template name="GetValue">
					<xsl:with-param name="type" select="$valuetype"/>
					<xsl:with-param name="text" select="$valuetext"/>
					<xsl:with-param name="entity" select="$entity"/>
					<xsl:with-param name="hidden" select="true()"/>
			</xsl:call-template>
		  </xsl:if>

		  <xsl:if test="@clean">
			<xsl:value-of select="'&lt;xsl:value-of select=&quot;'"/>
			<xsl:value-of select="'translate('"/>

			<xsl:call-template name="GetValue">
					<xsl:with-param name="type" select="$valuetype"/>
					<xsl:with-param name="text" select="$valuetext"/>
					<xsl:with-param name="entity" select="$entity"/>
					<xsl:with-param name="noselect" select="true()"/>
					<xsl:with-param name="hidden" select="true()"/>
			</xsl:call-template>

			<xsl:value-of select="concat(',', $apos, '&amp;amp;', $apos, ',', $apos, ' ', $apos, ')')"/>
			<xsl:value-of select="'&quot;/&gt;'"/>
		  </xsl:if>

	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTLINKGROUP">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:param name="wrap" select="false()"/>
		<xsl:variable name="hasconditions" select="(count(WTCONDITION) > 0)"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="ind2"><xsl:choose><xsl:when test="$hasconditions"><xsl:value-of select="concat($ind1, $tab1)"/></xsl:when><xsl:otherwise><xsl:value-of select="$ind1"/></xsl:otherwise></xsl:choose></xsl:variable>
		<xsl:variable name="indent2"><xsl:choose><xsl:when test="$hasconditions"><xsl:value-of select="$indent+1"/></xsl:when><xsl:otherwise><xsl:value-of select="$indent"/></xsl:otherwise></xsl:choose></xsl:variable>
		<xsl:variable name="ind3" select="concat($ind2, $tab1)"/>
		<xsl:variable name="indent3" select="$indent2+1"/>

	 <!-- ***************** Error Checking *******************-->
	 <xsl:if test="not(@col)">
	     <xsl:call-template name="Error">
	     	<xsl:with-param name="msg" select="'WTLINKGROUP Column Missing'"/>
	     	<xsl:with-param name="text" select="position()"/>
	     </xsl:call-template>
	 </xsl:if>
	 <!--Test valid attributes-->
	 <xsl:for-each select="@*">
			<xsl:variable name="testcol">
				<xsl:call-template name="TestColAttr">
					<xsl:with-param name="attr" select="name()"/>
				</xsl:call-template>
			</xsl:variable>
		   <xsl:if test="$testcol='0'">
				<xsl:choose>
		  			<xsl:when test="1=0"/>
					<xsl:otherwise>
						 <xsl:call-template name="Error">
							  <xsl:with-param name="msg" select="'WTLINKGROUP Invalid Attribute'"/>
							  <xsl:with-param name="text" select="name()"/>
	 					</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose>
		   </xsl:if>
	 </xsl:for-each>
	 <!-- ****************************************************-->

		<!--begin the column tag-->
		<xsl:apply-templates select="." mode="cell-begin">
			<xsl:with-param name="indent" select="$indent"/>
			<xsl:with-param name="wrap" select="$wrap"/>
			<xsl:with-param name="isfirst" select="position()=1"/>
		</xsl:apply-templates>

		<!--generate IF statement for conditions if they exist-->
		<xsl:if test="($hasconditions)">
			<xsl:call-template name="XSLConditionStart">
				<xsl:with-param name="indent" select="$indent2"/>
				<xsl:with-param name="conditions" select="WTCONDITION"/>
			</xsl:call-template>
		</xsl:if>

		<!--generate tag-->
		<xsl:if test="@tag">
			<xsl:call-template name="XSLLabelText">
				<xsl:with-param name="label" select="@tag"/>
				<xsl:with-param name="indent" select="$indent3"/>
				<xsl:with-param name="newline" select="true()"/>
			</xsl:call-template>
			<xsl:value-of select="concat($ind2, '&lt;xsl:text disable-output-escaping=&quot;yes&quot;&gt;:&amp;amp;#160;&lt;/xsl:text&gt;', $cr)"/>
		</xsl:if>

		<!--generate links-->
		<xsl:apply-templates>
			<xsl:with-param name="indent" select="$indent3"/>
		</xsl:apply-templates>
		
		<!--close IF statement for conditions if they exist-->
		<xsl:if test="($hasconditions)">
			<xsl:call-template name="XSLConditionEnd">
				<xsl:with-param name="indent" select="$indent2"/>			
			</xsl:call-template>
		</xsl:if>

		<!--end the column tag-->
		<xsl:apply-templates select="." mode="cell-end">
			<xsl:with-param name="indent" select="$indent"/>
			<xsl:with-param name="wrap" select="$wrap"/>
			<xsl:with-param name="islast" select="position()=last()"/>
		</xsl:apply-templates>

	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTMEMO">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:param name="wrap" select="false()"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="ind2" select="concat($ind1, $tab1)"/>
		<xsl:variable name="indent2" select="$indent+1"/>
		<xsl:variable name="ind3" select="concat($ind2, $tab1)"/>
		<xsl:variable name="indent3" select="$indent2+1"/>
		<xsl:variable name="valuetype"><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>
		<xsl:variable name="valuetext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>
		<xsl:variable name="valueentity"><xsl:call-template name="QualifiedPrefix"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>
		<xsl:variable name="colstype"><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="@cols"/></xsl:call-template></xsl:variable>
		<xsl:variable name="colstext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@cols"/></xsl:call-template></xsl:variable>
		<xsl:variable name="colsentity"><xsl:call-template name="QualifiedPrefix"><xsl:with-param name="value" select="@cols"/></xsl:call-template></xsl:variable>
		<xsl:variable name="attribute" select="/Data/WTENTITY/WTATTRIBUTE[@name=$valuetext]"/>

	 <!-- ***************** Error Checking *******************-->
	<xsl:if test="not(ancestor::WTSTATIC)">
		<xsl:if test="not(@col)">
			<xsl:call-template name="Error">
	     		<xsl:with-param name="msg" select="'WTMEMO Column Missing'"/>
	     		<xsl:with-param name="text" select="$valuetext"/>
			</xsl:call-template>
		</xsl:if>
	 </xsl:if>
	 <xsl:if test="@htmleditor and (not(@embedhtml) and not($attribute/@embedhtml))">
	     <xsl:call-template name="Error">
	     	<xsl:with-param name="msg" select="'WTMEMO HTML Editor missing embedhtml'"/>
	     	<xsl:with-param name="text" select="$valuetext"/>
	     </xsl:call-template>
	 </xsl:if>
	 <!--Test valid attributes-->
	 <xsl:for-each select="@*">
			<xsl:variable name="testcol">
				<xsl:call-template name="TestColAttr">
					<xsl:with-param name="attr" select="name()"/>
				</xsl:call-template>
			</xsl:variable>
		   <xsl:if test="$testcol='0'">
				<xsl:choose>
          <xsl:when test="name()='name'"/>
          <xsl:when test="name()='rows'"/>
          <xsl:when test="name()='cols'"/>
          <xsl:when test="name()='disabled'"/>
          <xsl:when test="name()='maxlength'"/>
          <xsl:when test="name()='embedhtml'"/>
          <xsl:when test="name()='htmleditor'"/>
          <xsl:when test="name()='editorcolor'"/>
          <xsl:when test="name()='editortemplates'"/>
          <xsl:when test="name()='memoclass'"/>
          <xsl:when test="name()='wordcount'"/>
          <xsl:otherwise>
						 <xsl:call-template name="Error">
							  <xsl:with-param name="msg" select="'WTMEMO Invalid Attribute'"/>
							  <xsl:with-param name="text" select="name()"/>
	 					</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose>
		   </xsl:if>
	 </xsl:for-each>
	 <!-- ****************************************************-->

		<!--begin the column tag-->
		<xsl:if test="@col">
			<xsl:apply-templates select="." mode="cell-begin">
				<xsl:with-param name="indent" select="$indent"/>
				<xsl:with-param name="wrap" select="$wrap"/>
				<xsl:with-param name="isfirst" select="position()=1"/>
			</xsl:apply-templates>
		</xsl:if>

		  <xsl:variable name="cols">
				<xsl:choose>
					 <xsl:when test="@cols">
						<xsl:call-template name="GetValue">
							 <xsl:with-param name="type" select="$colstype"/>
							 <xsl:with-param name="text" select="$colstext"/>
							 <xsl:with-param name="entity" select="$colsentity"/>
						</xsl:call-template>
					 </xsl:when>
					 <xsl:when test="$attribute/@required='true' and ($attribute/@language='true' and not($attribute/WTJOIN))">47</xsl:when>
					 <xsl:when test="$attribute/@required='true' or ($attribute/@language='true' and not($attribute/WTJOIN))">49</xsl:when>
					 <xsl:otherwise>50</xsl:otherwise>
				</xsl:choose>
		  </xsl:variable>
		
		<!--build the input control-->
		<xsl:value-of select="concat($ind2, '&lt;xsl:element name=&quot;TEXTAREA&quot;&gt;', $cr)"/>

    <xsl:if test="@memoclass">
      <xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;class&quot;&gt;', @memoclass, '&lt;/xsl:attribute&gt;', $cr)"/>
    </xsl:if>
    <xsl:choose>
			<xsl:when test="@name">
				<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;name&quot;&gt;', @name, '&lt;/xsl:attribute&gt;', $cr)"/>
				<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;id&quot;&gt;', @name, '&lt;/xsl:attribute&gt;', $cr)"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;name&quot;&gt;', $valuetext, '&lt;/xsl:attribute&gt;', $cr)"/>
				<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;id&quot;&gt;', $valuetext, '&lt;/xsl:attribute&gt;', $cr)"/>
			</xsl:otherwise>
		</xsl:choose>

		<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;rows&quot;&gt;', @rows, '&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;cols&quot;&gt;', $cols, '&lt;/xsl:attribute&gt;', $cr)"/>
		
		<xsl:if test="not(@maxlength='false')">
			<xsl:variable name="maxlen">
				<xsl:choose>
					<xsl:when test="$attribute"><xsl:value-of select="$attribute/@length"/></xsl:when>
					<xsl:when test="@maxlength"><xsl:value-of select="@maxlength"/></xsl:when>
					<xsl:otherwise>0</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			<xsl:if test="$maxlen&gt;0">
				<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;onkeyup&quot;&gt;')"/>
				<xsl:value-of select="concat('&lt;xsl:text disable-output-escaping=&quot;yes&quot;&gt;&lt;![CDATA[if (value.length&gt;', $maxlen, ') {doMaxLenMsg(', $maxlen, '); value=value.substring(0,', $maxlen, ');}]]&gt;&lt;/xsl:text&gt;&lt;/xsl:attribute&gt;', $cr )"/>
			</xsl:if>
		</xsl:if>

		  <xsl:apply-templates select="WTENTER">
		  	<xsl:with-param name="indent" select="$indent3"/>
		  </xsl:apply-templates>

		  <xsl:apply-templates select="WTKEY">
		  	<xsl:with-param name="indent" select="$indent3"/>
		  </xsl:apply-templates>

		  <xsl:apply-templates select="WTCHANGE">
		  	<xsl:with-param name="indent" select="$indent3"/>
		  </xsl:apply-templates>

		  <xsl:apply-templates select="WTEXIT">
		  	<xsl:with-param name="indent" select="$indent3"/>
		  </xsl:apply-templates>

		  <!--disable the field if specified-->
		  <xsl:if test="@disabled">
				<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;DISABLED&quot;/&gt;', $cr)"/>
		  </xsl:if>

		<xsl:if test="$valuetext!=''">
			<xsl:choose>
				<xsl:when test="$valuetype='CONST'">
					<xsl:value-of select="concat($ind3, '&lt;xsl:value-of select=&quot;', $valuetext, '&quot;/&gt;', $cr)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$ind3"/>
		  			<xsl:call-template name="GetValue">
		  				 <xsl:with-param name="type" select="$valuetype"/>
		  				 <xsl:with-param name="text" select="$valuetext"/>
		  				 <xsl:with-param name="entity" select="$valueentity"/>
		  				 <xsl:with-param name="output" select="true()"/>
		  			</xsl:call-template>
		  			<xsl:value-of select="$cr"/>

<!--
					<xsl:call-template name="XSLDataField">
						<xsl:with-param name="indent" select="$indent3"/>
						<xsl:with-param name="entity" select="$valueentity"/>
						<xsl:with-param name="name" select="$valuetext"/>
						<xsl:with-param name="newline" select="true()"/>
					</xsl:call-template>
-->
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
		<xsl:if test="$valuetext=''">
			<xsl:value-of select="concat($ind3, '&lt;xsl:value-of select=&quot;', $apos, $apos, '&quot;/&gt;', $cr)"/>
		</xsl:if>
		
<!--
		<xsl:apply-templates select="." mode="read-only">
			<xsl:with-param name="indent" select="$indent3"/>
		</xsl:apply-templates>
-->
		<xsl:value-of select="concat($ind2, '&lt;/xsl:element&gt;', $cr)"/>

		<xsl:if test="@htmleditor">
			<xsl:value-of select="concat($ind2, '&lt;xsl:element name=&quot;SCRIPT&quot;&gt;', $cr)"/>
			<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;language&quot;&gt;JavaScript1.2&lt;/xsl:attribute&gt;', $cr)"/>

			<xsl:if test="/Data/WTPAGE/@htmleditor='ckeditor'">
				<xsl:value-of select="concat($ind3, '&lt;![CDATA[   CKEDITOR.replace(', $apos, $valuetext, $apos, ', { ')"/>

				<xsl:choose>
					<xsl:when test="@htmleditor='editor'"></xsl:when>
					<xsl:when test="@htmleditor='true'"></xsl:when>
					<xsl:when test="@htmleditor='editor_simple'">
						<xsl:value-of select="concat('toolbar:', $apos, 'simple', $apos, ', ')"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="concat('toolbar:', $apos, @htmleditor, $apos, ', ')"/>
					</xsl:otherwise>
				</xsl:choose>

        <xsl:if test="@editorcolor">
          <xsl:value-of select="concat('uiColor:', $apos, @editorcolor, $apos, ', ')"/>
        </xsl:if>

        <xsl:if test="@wordcount">
          <xsl:value-of select="concat('wordcount:{', @wordcount, '}, ')"/>
        </xsl:if>

        <xsl:if test="@editortemplates">
          <xsl:value-of select="concat('templates_files:[', $apos, @editortemplates, $apos, '], ')"/>
        </xsl:if>
        
        <xsl:value-of select="concat( 'height:', @rows * 20 )"/>
        <xsl:value-of select="concat( ' } );  ]]&gt;', $cr )"/>
      </xsl:if>
			<xsl:if test="/Data/WTPAGE/@htmleditor!='ckeditor'">
				<xsl:value-of select="concat($ind3, '&lt;![CDATA[   editor_generate(', $apos, $valuetext, $apos, ');  ]]&gt;', $cr)"/>
			</xsl:if>
			
			<xsl:value-of select="concat($ind2, '&lt;/xsl:element&gt;', $cr)"/>
		</xsl:if>

		<!--required field indicator-->
		<xsl:if test="not(@required='false') and (@required='true' or ($attribute/@required='true'))">
			<xsl:apply-templates select="." mode="require-mark">
				<xsl:with-param name="indent" select="$indent2"/>
			</xsl:apply-templates>
		</xsl:if>

		<!--language field indicator-->
		<xsl:if test="$attribute/@language='true' and not($attribute/WTJOIN)">
			<xsl:apply-templates select="." mode="language-mark">
				<xsl:with-param name="indent" select="$indent2"/>
			</xsl:apply-templates>
		</xsl:if>

		<!--end the column tag-->
		<xsl:if test="@col">
			<xsl:apply-templates select="." mode="cell-end">
				<xsl:with-param name="indent" select="$indent"/>
				<xsl:with-param name="wrap" select="$wrap"/>
				<xsl:with-param name="islast" select="position()=last()"/>
			</xsl:apply-templates>
		</xsl:if>
		
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTROW/child::*[name() != 'WTLINKGROUP']" mode="columnlabel">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="ind2" select="concat($ind1, $tab1)"/>
		<xsl:variable name="indent2" select="$indent+1"/>

		<xsl:variable name="width">
			<xsl:choose>
				<xsl:when test="@width"><xsl:value-of select="@width"/></xsl:when>
				<xsl:otherwise><xsl:value-of select="ancestor::WTCONTENT/WTCOLUMN[position() = current()/@col]/@width"/></xsl:otherwise>
			</xsl:choose>
      <xsl:if test="$widthpercent='true'">%</xsl:if>
    </xsl:variable>
		<xsl:variable name="align">
			<xsl:choose>
				<xsl:when test="@align"><xsl:value-of select="@align"/></xsl:when>
				<xsl:otherwise><xsl:value-of select="ancestor::WTCONTENT/WTCOLUMN[position() = current()/@col]/@align"/></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="class">
			<xsl:choose>
				<xsl:when test="@class"><xsl:value-of select="@class"/></xsl:when>
				<xsl:otherwise>InputHeading</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:value-of select="concat($ind1, '&lt;xsl:element name=&quot;TD&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($ind2, '&lt;xsl:attribute name=&quot;width&quot;&gt;', $width, '&lt;/xsl:attribute&gt;', $cr)"/>

		<xsl:if test="@label">
			<xsl:value-of select="concat($ind2, '&lt;xsl:attribute name=&quot;class&quot;&gt;', $class, '&lt;/xsl:attribute&gt;', $cr)"/>
			<xsl:value-of select="concat($ind2, '&lt;xsl:attribute name=&quot;align&quot;&gt;', $align, '&lt;/xsl:attribute&gt;', $cr)"/>
			<xsl:value-of select="concat($ind2, '&lt;xsl:attribute name=&quot;valign&quot;&gt;bottom&lt;/xsl:attribute&gt;', $cr)"/>

			<xsl:call-template name="XSLLabelText">
				<xsl:with-param name="indent" select="$indent2"/>
				<xsl:with-param name="label" select="@label"/>
				<xsl:with-param name="islabel" select="false"/>
			</xsl:call-template>
		</xsl:if>
		<xsl:value-of select="concat($ind1, '&lt;/xsl:element&gt;', $cr)"/>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTROW">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:variable name="hasconditions" select="(count(WTCONDITION) > 0)"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="ind2"><xsl:choose><xsl:when test="($hasconditions)"><xsl:value-of select="concat($ind1, $tab1)"/></xsl:when><xsl:otherwise><xsl:value-of select="$ind1"/></xsl:otherwise></xsl:choose></xsl:variable>
		<xsl:variable name="indent2"><xsl:choose><xsl:when test="($hasconditions)"><xsl:value-of select="$indent+1"/></xsl:when><xsl:otherwise><xsl:value-of select="$indent"/></xsl:otherwise></xsl:choose></xsl:variable>
		<xsl:variable name="ind3" select="concat($ind2, $tab1)"/>
		<xsl:variable name="indent3" select="$indent2+1"/>
		<xsl:variable name="ind4" select="concat($ind3, $tab1)"/>
		<xsl:variable name="indent4" select="$indent3+1"/>
		<xsl:variable name="ind5" select="concat($ind4, $tab1)"/>
		<xsl:variable name="indent5" select="$indent4+1"/>
		<xsl:variable name="ind6" select="concat($ind5, $tab1)"/>
		<xsl:variable name="indent6" select="$indent5+1"/>
		<xsl:variable name="ind7" select="concat($ind6, $tab1)"/>
		<xsl:variable name="indent7" select="$indent6+1"/>
		<xsl:variable name="ind8" select="concat($ind7, $tab1)"/>
		<xsl:variable name="indent8" select="$indent7+1"/>
		<xsl:variable name="splitcell" select="(count(*[@width])>0)"/>		<!--if any child element specifies a width then split the cell-->
		<xsl:variable name="tablecnt" select="count(ancestor::WTTABLE)"/>
<!--		<xsl:variable name="tablecols" select="ancestor::WTTABLE[$tablecnt]/WTCOLUMN"/>-->
		<xsl:variable name="tablecols" select="ancestor::WTTABLE[1]/WTCOLUMN"/>
		<xsl:variable name="defcols" select="ancestor::*/WTCOLUMN"/>
		<xsl:variable name="colcnt">
			<xsl:choose>
<!--				<xsl:when test="$tablecnt>0"><xsl:value-of select="count(ancestor::WTTABLE[$tablecnt]/WTCOLUMN)"/></xsl:when> -->
				<xsl:when test="$tablecnt>0"><xsl:value-of select="count(ancestor::WTTABLE[1]/WTCOLUMN)"/></xsl:when>
				<xsl:otherwise><xsl:value-of select="count(ancestor::*/WTCOLUMN)"/></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="colwidth">
			<xsl:choose>
<!--				<xsl:when test="$tablecnt>0"><xsl:value-of select="sum(ancestor::WTTABLE[$tablecnt]/WTCOLUMN/@width)"/></xsl:when> -->
				<xsl:when test="$tablecnt>0"><xsl:value-of select="sum(ancestor::WTTABLE[1]/WTCOLUMN/@width)"/></xsl:when>
				<xsl:otherwise><xsl:value-of select="sum(ancestor::*/WTCOLUMN/@width)"/></xsl:otherwise>
			</xsl:choose>
      <xsl:if test="$widthpercent='true'">%</xsl:if>
    </xsl:variable>
		<xsl:variable name="children" select="*"/>

	 <!-- ***************** Error Checking *******************-->
	 <!--Test valid attributes-->
	 <xsl:for-each select="@*">
		  <xsl:choose>
				<xsl:when test="name()='id'"/>
		  		<xsl:when test="name()='background'"/>
		  		<xsl:when test="name()='height'"/>
				<xsl:when test="name()='class'"/>
				<xsl:when test="name()='margin-top'"/>
				<xsl:when test="name()='margin-bottom'"/>
				<xsl:when test="name()='firstrow'"/>
				<xsl:when test="name()='graybar'"/>
		  		<xsl:when test="name()='style'"/>
				<xsl:otherwise>
					 <xsl:call-template name="Error">
						  <xsl:with-param name="msg" select="'WTROW Invalid Attribute'"/>
						  <xsl:with-param name="text" select="name()"/>
	 				</xsl:call-template>
				</xsl:otherwise>
		  </xsl:choose>
	 </xsl:for-each>
	 <!-- ****************************************************-->

		<!--generate IF statement for conditions if they exist-->
		<xsl:if test="($hasconditions)">
			<xsl:call-template name="XSLConditionStart">
				<xsl:with-param name="indent" select="$indent"/>
				<xsl:with-param name="conditions" select="WTCONDITION"/>
			</xsl:call-template>
		</xsl:if>

		<xsl:choose>
			<xsl:when test="WTHIDDEN">
				<xsl:apply-templates select="WTHIDDEN">
					<xsl:with-param name="indent" select="$indent"/>
				</xsl:apply-templates>	
			</xsl:when>
			
			<xsl:when test="$splitcell and not(WTTREE) and not(WTTREE2) and not(WTDIVIDER)">
				<xsl:value-of select="concat($ind2, '&lt;xsl:element name=&quot;TR&quot;&gt;', $cr)"/>
				<xsl:if test="@id">
					<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;id&quot;&gt;', @id, '&lt;/xsl:attribute&gt;', $cr)"/>
				</xsl:if>
				<xsl:if test="@class">
					<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;class&quot;&gt;', @class, '&lt;/xsl:attribute&gt;', $cr)"/>
				</xsl:if>
				<xsl:value-of select="concat($ind3, '&lt;xsl:element name=&quot;TD&quot;&gt;', $cr)"/>
				<xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;colspan&quot;&gt;', $colcnt, '&lt;/xsl:attribute&gt;', $cr)"/>

				<xsl:variable name="border">
					<xsl:choose>
						<xsl:when test="/Data/WTPAGE/@test">1</xsl:when>
						<xsl:when test="@border"><xsl:value-of select="@border"/></xsl:when>
						<xsl:otherwise>0</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>

				<xsl:value-of select="concat($ind4, '&lt;xsl:element name=&quot;TABLE&quot;&gt;', $cr)"/>
				<xsl:value-of select="concat($ind5, '&lt;xsl:attribute name=&quot;border&quot;&gt;', $border, '&lt;/xsl:attribute&gt;', $cr)"/>
				<xsl:value-of select="concat($ind5, '&lt;xsl:attribute name=&quot;cellpadding&quot;&gt;0&lt;/xsl:attribute&gt;', $cr)"/>
				<xsl:value-of select="concat($ind5, '&lt;xsl:attribute name=&quot;cellspacing&quot;&gt;0&lt;/xsl:attribute&gt;', $cr)"/>
				<xsl:value-of select="concat($ind5, '&lt;xsl:attribute name=&quot;width&quot;&gt;', $colwidth, '&lt;/xsl:attribute&gt;', $cr)"/>

				<xsl:if test="count(child::*[@label])>0">
					<xsl:value-of select="concat($ind5, '&lt;xsl:element name=&quot;TR&quot;&gt;', $cr)"/>
					<xsl:if test="@class">
						<xsl:value-of select="concat($ind6, '&lt;xsl:attribute name=&quot;class&quot;&gt;', @class, '&lt;/xsl:attribute&gt;', $cr)"/>
					</xsl:if>
					<xsl:if test="$tablecnt=0">
						<xsl:for-each select="$defcols">
							<xsl:variable name="colpos" select="position()"/>
							<xsl:apply-templates select="$children[@col=$colpos]" mode="columnlabel">
								<xsl:with-param name="indent" select="$indent6"/>
							</xsl:apply-templates>	
						</xsl:for-each>
					</xsl:if>
					<xsl:if test="$tablecnt>0">
						<xsl:for-each select="$tablecols">
							<xsl:variable name="colpos" select="position()"/>
							<xsl:apply-templates select="$children[@col=$colpos]" mode="columnlabel">
								<xsl:with-param name="indent" select="$indent6"/>
							</xsl:apply-templates>	
						</xsl:for-each>
					</xsl:if>
					<xsl:value-of select="concat($ind5, '&lt;/xsl:element&gt;', $cr)"/>
				</xsl:if>

				<xsl:value-of select="concat($ind5, '&lt;xsl:element name=&quot;TR&quot;&gt;', $cr)"/>
				<xsl:if test="@height">
					<xsl:value-of select="concat($ind6, '&lt;xsl:attribute name=&quot;height&quot;&gt;', @height, '&lt;/xsl:attribute&gt;', $cr)"/>
				</xsl:if>
				<xsl:if test="@class">
					<xsl:value-of select="concat($ind6, '&lt;xsl:attribute name=&quot;class&quot;&gt;', @class, '&lt;/xsl:attribute&gt;', $cr)"/>
				</xsl:if>

				<xsl:if test="$tablecnt=0">
					<xsl:for-each select="$defcols">
						<xsl:variable name="colpos" select="position()"/>
						<xsl:apply-templates select="$children[@col=$colpos]">
							<xsl:with-param name="indent" select="$indent6"/>
						</xsl:apply-templates>
					</xsl:for-each>
				</xsl:if>
				<xsl:if test="$tablecnt>0">
					<xsl:for-each select="$tablecols">
						<xsl:variable name="colpos" select="position()"/>
						<xsl:apply-templates select="$children[@col=$colpos]">
							<xsl:with-param name="indent" select="$indent6"/>
						</xsl:apply-templates>
					</xsl:for-each>
				</xsl:if>

				<xsl:value-of select="concat($ind5, '&lt;/xsl:element&gt;', $cr)"/>
				<xsl:value-of select="concat($ind4, '&lt;/xsl:element&gt;', $cr)"/>
				<xsl:value-of select="concat($ind3, '&lt;/xsl:element&gt;', $cr)"/>
				<xsl:value-of select="concat($ind2, '&lt;/xsl:element&gt;', $cr)"/>
			</xsl:when>

			<xsl:otherwise>
				<!--apply top margin-->
				<xsl:if test="(@margin-top)">
					<xsl:value-of select="concat($ind2, '&lt;xsl:element name=&quot;TR&quot;&gt;', $cr)"/>
					<xsl:value-of select="concat($ind3, '&lt;xsl:element name=&quot;TD&quot;&gt;', $cr)"/>
					<xsl:if test="$colcnt>0">
						<xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;colspan&quot;&gt;', $colcnt, '&lt;/xsl:attribute&gt;', $cr)"/>
					</xsl:if>
					<xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;height&quot;&gt;', @margin-top, '&lt;/xsl:attribute&gt;',  $cr)"/>
					<xsl:value-of select="concat($ind3, '&lt;/xsl:element&gt;', $cr)"/>
					<xsl:value-of select="concat($ind2, '&lt;/xsl:element&gt;', $cr)"/>
				</xsl:if>

				<xsl:value-of select="concat($ind2, '&lt;xsl:element name=&quot;TR&quot;&gt;', $cr)"/>
				<xsl:if test="@id">
					<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;id&quot;&gt;', @id, '&lt;/xsl:attribute&gt;', $cr)"/>
				</xsl:if>
				<xsl:if test="@class">
					<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;class&quot;&gt;', @class, '&lt;/xsl:attribute&gt;', $cr)"/>
				</xsl:if>
				<xsl:if test="@style">
					<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;style&quot;&gt;', @style, '&lt;/xsl:attribute&gt;', $cr)"/>
				</xsl:if>
				<xsl:if test="@height">
					<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;height&quot;&gt;', @height, '&lt;/xsl:attribute&gt;', $cr)"/>
				</xsl:if>

				<xsl:if test="WTCLICK">
					<xsl:apply-templates select="WTCLICK">
						<xsl:with-param name="indent" select="$indent3"/>
					</xsl:apply-templates>
				</xsl:if>

				<!--gray bar************************************************************************************-->
				<xsl:if test="@graybar='true'">
					<xsl:value-of select="concat($ind3, '&lt;xsl:if test=&quot;(position() mod 2)&quot;&gt;', $cr)"/>
					<xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;class&quot;&gt;GrayBar&lt;/xsl:attribute&gt;', $cr)"/>
					<xsl:value-of select="concat($ind3, '&lt;/xsl:if&gt;', $cr)"/>
				</xsl:if>

				<xsl:choose>
					<xsl:when test="WTREPEAT">
						<xsl:apply-templates select="WTREPEAT">
							<xsl:with-param name="indent" select="$indent3"/>
						</xsl:apply-templates>	
					</xsl:when>
					<xsl:otherwise>
						<xsl:if test="$tablecnt=0">
							<xsl:for-each select="$defcols">
								<xsl:variable name="colpos" select="position()"/>
								<xsl:apply-templates select="$children[@col=$colpos]">
									<xsl:with-param name="indent" select="$indent3"/>
									<xsl:with-param name="wrap" select="true()"/>
								</xsl:apply-templates>	
							</xsl:for-each>
						</xsl:if>
						<xsl:if test="$tablecnt>0">
							<xsl:for-each select="$tablecols">
								<xsl:variable name="colpos" select="position()"/>
								<xsl:apply-templates select="$children[@col=$colpos]">
									<xsl:with-param name="indent" select="$indent3"/>
									<xsl:with-param name="wrap" select="true()"/>
								</xsl:apply-templates>	
							</xsl:for-each>
						</xsl:if>
					</xsl:otherwise>
				</xsl:choose>

				<xsl:value-of select="concat($ind2, '&lt;/xsl:element&gt;', $cr)"/>

				<!--add previous/next line for recordsets-->
				<xsl:if test="(WTRECORDSET[@prevnext])">
					<xsl:value-of select="concat($ind2, '&lt;xsl:element name=&quot;TR&quot;&gt;', $cr)"/>
					<xsl:value-of select="concat($ind3, '&lt;xsl:element name=&quot;TD&quot;&gt;', $cr)"/>
					<xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;height&quot;&gt;2&lt;/xsl:attribute&gt;',  $cr)"/>
					<xsl:value-of select="concat($ind3, '&lt;/xsl:element&gt;', $cr)"/>
					<xsl:value-of select="concat($ind2, '&lt;/xsl:element&gt;', $cr)"/>

					<xsl:value-of select="concat($ind2, '&lt;xsl:element name=&quot;TR&quot;&gt;', $cr)"/>
					<xsl:if test="(WTRECORDSET[@margin])">
						<xsl:call-template name="XSLTD">
							<xsl:with-param name="cnt" select="WTRECORDSET/@margin"/>
							<xsl:with-param name="indent" select="$indent3"/>
						</xsl:call-template>
					</xsl:if>
					<xsl:value-of select="concat($ind3, '&lt;xsl:element name=&quot;TD&quot;&gt;', $cr)"/>

					<xsl:variable name="border">
						<xsl:choose>
							<xsl:when test="/Data/WTPAGE/@test">1</xsl:when>
							<xsl:when test="@border"><xsl:value-of select="@border"/></xsl:when>
							<xsl:otherwise>0</xsl:otherwise>
						</xsl:choose>
					</xsl:variable>

					<xsl:variable name="tablewidth">
						<xsl:choose>
							<xsl:when test="WTRECORDSET/@tablewidth"><xsl:value-of select="WTRECORDSET/@tablewidth"/></xsl:when>
							<xsl:otherwise><xsl:value-of select="$colwidth"/></xsl:otherwise>
						</xsl:choose>
					</xsl:variable>

					<xsl:value-of select="concat($ind4, '&lt;xsl:element name=&quot;TABLE&quot;&gt;', $cr)"/>
					<xsl:value-of select="concat($ind5, '&lt;xsl:attribute name=&quot;border&quot;&gt;', $border, '&lt;/xsl:attribute&gt;', $cr)"/>
					<xsl:value-of select="concat($ind5, '&lt;xsl:attribute name=&quot;cellpadding&quot;&gt;0&lt;/xsl:attribute&gt;', $cr)"/>
					<xsl:value-of select="concat($ind5, '&lt;xsl:attribute name=&quot;cellspacing&quot;&gt;0&lt;/xsl:attribute&gt;', $cr)"/>
					<xsl:value-of select="concat($ind5, '&lt;xsl:attribute name=&quot;width&quot;&gt;', $tablewidth, '&lt;/xsl:attribute&gt;', $cr)"/>

					<xsl:value-of select="concat($ind5, '&lt;xsl:element name=&quot;TR&quot;&gt;', $cr)"/>
					<xsl:value-of select="concat($ind6, '&lt;xsl:element name=&quot;TD&quot;&gt;', $cr)"/>
					<xsl:value-of select="concat($ind7, '&lt;xsl:attribute name=&quot;width&quot;&gt;25%&lt;/xsl:attribute&gt;',  $cr)"/>
					<xsl:value-of select="concat($ind7, '&lt;xsl:attribute name=&quot;align&quot;&gt;left&lt;/xsl:attribute&gt;',  $cr)"/>
					<xsl:value-of select="concat($ind7, '&lt;xsl:attribute name=&quot;class&quot;&gt;PrevNext&lt;/xsl:attribute&gt;',  $cr)"/>
					<xsl:value-of select="concat($ind7, '&lt;xsl:if test=&quot;/DATA/BOOKMARK/@next=', $apos, 'False', $apos, '&quot;&gt;',  $cr)"/>
					<xsl:call-template name="XSLLabelText">
						<xsl:with-param name="label">EndOfList</xsl:with-param>
						<xsl:with-param name="indent" select="$indent+7"/>
						<xsl:with-param name="newline" select="true()"/>
					</xsl:call-template>
					<xsl:value-of select="concat($ind7, '&lt;/xsl:if&gt;', $cr)"/>
					<xsl:value-of select="concat($ind6, '&lt;/xsl:element&gt;', $cr)"/>
					<xsl:value-of select="concat($ind6, '&lt;xsl:element name=&quot;TD&quot;&gt;', $cr)"/>
					<xsl:value-of select="concat($ind7, '&lt;xsl:attribute name=&quot;width&quot;&gt;75%&lt;/xsl:attribute&gt;',  $cr)"/>
					<xsl:value-of select="concat($ind7, '&lt;xsl:attribute name=&quot;align&quot;&gt;right&lt;/xsl:attribute&gt;',  $cr)"/>
					<xsl:value-of select="concat($ind7, '&lt;xsl:call-template name=&quot;PreviousNext&quot;/&gt;',  $cr)"/>
					<xsl:value-of select="concat($ind6, '&lt;/xsl:element&gt;', $cr)"/>
					<xsl:value-of select="concat($ind5, '&lt;/xsl:element&gt;', $cr)"/>
					<xsl:value-of select="concat($ind4, '&lt;/xsl:element&gt;', $cr)"/>
					<xsl:value-of select="concat($ind3, '&lt;/xsl:element&gt;', $cr)"/>
					<xsl:value-of select="concat($ind2, '&lt;/xsl:element&gt;', $cr)"/>

					<xsl:value-of select="concat($ind2, '&lt;xsl:element name=&quot;TR&quot;&gt;', $cr)"/>
					<xsl:value-of select="concat($ind3, '&lt;xsl:element name=&quot;TD&quot;&gt;', $cr)"/>
					<xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;height&quot;&gt;4&lt;/xsl:attribute&gt;',  $cr)"/>
					<xsl:value-of select="concat($ind3, '&lt;/xsl:element&gt;', $cr)"/>
					<xsl:value-of select="concat($ind2, '&lt;/xsl:element&gt;', $cr)"/>
				</xsl:if>

				<!--apply bottom margin-->
				<xsl:if test="(@margin-bottom)">
					<xsl:value-of select="concat($ind2, '&lt;xsl:element name=&quot;TR&quot;&gt;', $cr)"/>
					<xsl:value-of select="concat($ind3, '&lt;xsl:element name=&quot;TD&quot;&gt;', $cr)"/>
					<xsl:if test="$colcnt>0">
						<xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;colspan&quot;&gt;', $colcnt, '&lt;/xsl:attribute&gt;', $cr)"/>
					</xsl:if>
					<xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;height&quot;&gt;', @margin-bottom, '&lt;/xsl:attribute&gt;',  $cr)"/>
					<xsl:value-of select="concat($ind3, '&lt;/xsl:element&gt;', $cr)"/>
					<xsl:value-of select="concat($ind2, '&lt;/xsl:element&gt;', $cr)"/>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>

		<!--close IF statement for conditions if they exist-->
		<xsl:if test="($hasconditions)">
			<xsl:call-template name="XSLConditionEnd">
				<xsl:with-param name="indent" select="$indent"/>			
			</xsl:call-template>
		</xsl:if>
		<xsl:value-of select="$cr"/>
	</xsl:template>
	
	<!--==================================================================-->
	<xsl:template match="WTDIVISION">
	<!--==================================================================-->
		<xsl:param name="indent"/>

		<xsl:variable name="hasconditions" select="(count(WTCONDITION) > 0)"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="ind2"><xsl:choose><xsl:when test="$hasconditions"><xsl:value-of select="concat($ind1, $tab1)"/></xsl:when><xsl:otherwise><xsl:value-of select="$ind1"/></xsl:otherwise></xsl:choose></xsl:variable>
		<xsl:variable name="indent2"><xsl:choose><xsl:when test="$hasconditions"><xsl:value-of select="$indent+1"/></xsl:when><xsl:otherwise><xsl:value-of select="$indent"/></xsl:otherwise></xsl:choose></xsl:variable>
		<xsl:variable name="ind3" select="concat($ind2, $tab1)"/>
		<xsl:variable name="indent3" select="$indent2+1"/>

	 <!-- ***************** Error Checking *******************-->
	 <!--Test valid attributes-->
	 <xsl:for-each select="@*">
		  <xsl:choose>
		  		<xsl:when test="name()='id'"/>
			  <xsl:when test="name()='style'"/>
			  <xsl:when test="name()='class'"/>
			  <xsl:otherwise>
					 <xsl:call-template name="Error">
						  <xsl:with-param name="msg" select="'WTDIVISION Invalid Attribute'"/>
						  <xsl:with-param name="text" select="name()"/>
	 				</xsl:call-template>
				</xsl:otherwise>
		  </xsl:choose>
	 </xsl:for-each>
	 <!-- ****************************************************-->

		<!--generate IF statement for conditions if they exist-->
		<xsl:if test="($hasconditions)">
			<xsl:call-template name="XSLConditionStart">
				<xsl:with-param name="indent" select="$indent"/>
				<xsl:with-param name="conditions" select="WTCONDITION"/>
			</xsl:call-template>
		</xsl:if>

		<xsl:value-of select="concat($ind2, '&lt;xsl:element name=&quot;DIV&quot;&gt;', $cr)"/>
		<xsl:if test="@id">
			<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;id&quot;&gt;', @id, '&lt;/xsl:attribute&gt;', $cr)"/>
		</xsl:if>
		<xsl:if test="@style">
			<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;style&quot;&gt;', @style, '&lt;/xsl:attribute&gt;', $cr)"/>
		</xsl:if>
		<xsl:if test="@class">
			<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;class&quot;&gt;', @class, '&lt;/xsl:attribute&gt;', $cr)"/>
		</xsl:if>

		<!--apply child templates-->
		<xsl:apply-templates>
			<xsl:with-param name="indent" select="$indent2"/>
		</xsl:apply-templates>

		<xsl:value-of select="concat($ind2, '&lt;/xsl:element&gt;', $cr)"/>

		<!--close IF statement for conditions if they exist-->
		<xsl:if test="($hasconditions)">
			<xsl:call-template name="XSLConditionEnd">
				<xsl:with-param name="indent" select="$indent"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>
	
	<!--==================================================================-->
	<xsl:template match="WTTOOLTIP">
	<!--==================================================================-->
		<xsl:param name="indent"/>

		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="ind2"><xsl:value-of select="concat($ind1, $tab1)"/></xsl:variable>

		<xsl:value-of select="concat($ind1, '&lt;xsl:element name=&quot;A&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($ind2, '&lt;xsl:attribute name=&quot;href&quot;&gt;#&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($ind2, '&lt;xsl:attribute name=&quot;class&quot;&gt;tooltip&lt;/xsl:attribute&gt;', $cr)"/>

		<!--apply child templates-->
		<xsl:apply-templates>
			<xsl:with-param name="indent" select="$indent"/>
		</xsl:apply-templates>

		<xsl:value-of select="concat($ind1, '&lt;/xsl:element&gt;', $cr)"/>

	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTTIP">
	<!--==================================================================-->
		<xsl:param name="indent"/>

		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="ind2"><xsl:value-of select="concat($ind1, $tab1)"/></xsl:variable>
		<xsl:variable name="indent2" select="$indent+1"/>

		<xsl:value-of select="concat($ind2, '&lt;xsl:element name=&quot;SPAN&quot;&gt;', $cr)"/>

		<!--apply child templates-->
		<xsl:apply-templates>
			<xsl:with-param name="indent" select="$indent2"/>
		</xsl:apply-templates>

		<xsl:value-of select="concat($ind2, '&lt;/xsl:element&gt;', $cr)"/>

	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTCODEGROUP">
	<!--==================================================================-->
		<xsl:param name="indent"/>

		<xsl:variable name="hasconditions" select="(count(WTCONDITION) > 0)"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="ind2"><xsl:choose><xsl:when test="$hasconditions"><xsl:value-of select="concat($ind1, $tab1)"/></xsl:when><xsl:otherwise><xsl:value-of select="$ind1"/></xsl:otherwise></xsl:choose></xsl:variable>
		<xsl:variable name="indent2"><xsl:choose><xsl:when test="$hasconditions"><xsl:value-of select="$indent+1"/></xsl:when><xsl:otherwise><xsl:value-of select="$indent"/></xsl:otherwise></xsl:choose></xsl:variable>
		<xsl:variable name="ind3" select="concat($ind2, $tab1)"/>
		<xsl:variable name="indent3" select="$indent2+1"/>

	 <!-- ***************** Error Checking *******************-->
	 <!--Test valid attributes-->
	 <xsl:for-each select="@*">
		<xsl:choose>
	  		<xsl:when test="name()='division'"/>
			<xsl:when test="name()='align'"/>
			<xsl:when test="name()='class'"/>
		  	<xsl:when test="name()='style'"/>
			<xsl:otherwise>
				 <xsl:call-template name="Error">
					  <xsl:with-param name="msg" select="'WTCODEGROUP Invalid Attribute'"/>
					  <xsl:with-param name="text" select="name()"/>
	 			</xsl:call-template>
			</xsl:otherwise>
	  </xsl:choose>
	 </xsl:for-each>
	 <!-- ****************************************************-->

		<!--generate IF statement for conditions if they exist-->
		<xsl:if test="($hasconditions)">
			<xsl:call-template name="XSLConditionStart">
				<xsl:with-param name="indent" select="$indent"/>
				<xsl:with-param name="conditions" select="WTCONDITION"/>
			</xsl:call-template>
		</xsl:if>

		<xsl:if test="WTSPAN">
			<xsl:value-of select="concat($ind2, '&lt;xsl:element name=&quot;SPAN&quot;&gt;', $cr)"/>
			<xsl:if test="WTSPAN/@id">
				<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;id&quot;&gt;', WTSPAN/@id, '&lt;/xsl:attribute&gt;', $cr)"/>
			</xsl:if>
			<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;style&quot;&gt;', WTSPAN/@style, '&lt;/xsl:attribute&gt;', $cr)"/>
		</xsl:if>
		
		<xsl:if test="@division">
			<xsl:value-of select="concat($ind2, '&lt;xsl:element name=&quot;DIV&quot;&gt;', $cr)"/>
			<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;id&quot;&gt;', @division, '&lt;/xsl:attribute&gt;', $cr)"/>
			<xsl:if test="@class">
				<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;class&quot;&gt;', @class, '&lt;/xsl:attribute&gt;', $cr)"/>
			</xsl:if>
			<xsl:if test="@style">
				<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;style&quot;&gt;', @style, '&lt;/xsl:attribute&gt;', $cr)"/>
			</xsl:if>
			<xsl:if test="@align">
				<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;align&quot;&gt;', @align, '&lt;/xsl:attribute&gt;', $cr)"/>
			</xsl:if>
		</xsl:if>

		<!--apply child templates-->
		<xsl:apply-templates>
			<xsl:with-param name="indent" select="$indent2"/>
		</xsl:apply-templates>

		<xsl:if test="@division">
			<xsl:value-of select="concat($ind2, '&lt;/xsl:element&gt;', $cr)"/>
		</xsl:if>

		<xsl:if test="WTSPAN">
			<xsl:value-of select="concat($ind2, '&lt;/xsl:element&gt;', $cr)"/>
		</xsl:if>

		<!--close IF statement for conditions if they exist-->
		<xsl:if test="($hasconditions)">
			<xsl:call-template name="XSLConditionEnd">
				<xsl:with-param name="indent" select="$indent"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTCODEGROUP" mode="recordset">
	<!--==================================================================-->
		<xsl:param name="indent"/>

		<xsl:variable name="hasconditions" select="(count(WTCONDITION) > 0)"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="ind2"><xsl:choose><xsl:when test="$hasconditions"><xsl:value-of select="concat($ind1, $tab1)"/></xsl:when><xsl:otherwise><xsl:value-of select="$ind1"/></xsl:otherwise></xsl:choose></xsl:variable>
		<xsl:variable name="indent2"><xsl:choose><xsl:when test="$hasconditions"><xsl:value-of select="$indent+1"/></xsl:when><xsl:otherwise><xsl:value-of select="$indent"/></xsl:otherwise></xsl:choose></xsl:variable>
		<xsl:variable name="ind3" select="concat($ind2, $tab1)"/>

	 <!-- ***************** Error Checking *******************-->
	 <!--Test valid attributes-->
	 <xsl:for-each select="@*">
		  <xsl:choose>
		  		<xsl:when test="name()='division'"/>
		  		<xsl:when test="name()='align'"/>
		  		<xsl:when test="name()='class'"/>
				<xsl:otherwise>
					 <xsl:call-template name="Error">
						  <xsl:with-param name="msg" select="'WTCODEGROUP Invalid Attribute'"/>
						  <xsl:with-param name="text" select="name()"/>
	 				</xsl:call-template>
				</xsl:otherwise>
		  </xsl:choose>
	 </xsl:for-each>
	 <!-- ****************************************************-->

		<!--generate IF statement for conditions if they exist-->
		<xsl:if test="($hasconditions)">
			<xsl:call-template name="XSLConditionStart">
				<xsl:with-param name="indent" select="$indent"/>
				<xsl:with-param name="conditions" select="WTCONDITION"/>
			</xsl:call-template>
		</xsl:if>

		<xsl:if test="@division">
			<xsl:value-of select="concat($ind2, '&lt;xsl:element name=&quot;DIV&quot;&gt;', $cr)"/>
			<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;id&quot;&gt;', @division, '&lt;/xsl:attribute&gt;', $cr)"/>
			<xsl:if test="@class">
				<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;class&quot;&gt;', @class, '&lt;/xsl:attribute&gt;', $cr)"/>
			</xsl:if>
			<xsl:if test="@align">
				<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;align&quot;&gt;', @align, '&lt;/xsl:attribute&gt;', $cr)"/>
			</xsl:if>
		</xsl:if>

		<!--apply child templates-->
		<xsl:apply-templates select="*" mode="recordset">
			<xsl:with-param name="indent" select="$indent2"/>
		</xsl:apply-templates>

		<xsl:if test="@division">
			<xsl:value-of select="concat($ind2, '&lt;/xsl:element&gt;', $cr)"/>
		</xsl:if>

		<!--close IF statement for conditions if they exist-->
		<xsl:if test="($hasconditions)">
			<xsl:call-template name="XSLConditionEnd">
				<xsl:with-param name="indent" select="$indent"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTRECORDSET">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:param name="wrap" select="false()"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="ind2" select="concat($ind1, $tab1)"/>
		<xsl:variable name="indent2" select="$indent+1"/>
		<xsl:variable name="ind3" select="concat($ind2, $tab1)"/>
		<xsl:variable name="indent3" select="$indent2+1"/>
		<xsl:variable name="ind4" select="concat($ind3, $tab1)"/>
		<xsl:variable name="indent4" select="$indent3+1"/>
		<xsl:variable name="colcount" select="count(WTCOLUMN)"/>

	 <!-- ***************** Error Checking *******************-->
	 <xsl:if test="not(@col)">
	     <xsl:call-template name="Error">
	     	<xsl:with-param name="msg" select="'WTRECORDSET Column Missing'"/>
	     	<xsl:with-param name="text" select="position()"/>
	     </xsl:call-template>
	 </xsl:if>
	 <xsl:if test="not(@entity)">
	     <xsl:call-template name="Error">
	     	<xsl:with-param name="msg" select="'WTRECORDSET Entity Missing'"/>
	     	<xsl:with-param name="text" select="position()"/>
	     </xsl:call-template>
	 </xsl:if>
	 <!--Test valid attributes-->
	 <xsl:for-each select="@*">
			<xsl:variable name="testcol">
				<xsl:call-template name="TestColAttr">
					<xsl:with-param name="attr" select="name()"/>
				</xsl:call-template>
			</xsl:variable>
		   <xsl:if test="$testcol='0'">
				<xsl:choose>
					<xsl:when test="name()='graybar'"/>
					<xsl:when test="name()='graybaron'"/>
					<xsl:when test="name()='graybaroff'"/>
					<xsl:when test="name()='entity'"/>
					<xsl:when test="name()='prevnext'"/>
					<xsl:when test="name()='count'"/>
					<xsl:when test="name()='margin'"/>
					<xsl:when test="name()='tablewidth'"/>
          <xsl:when test="name()='noitems'"/>
          <xsl:when test="name()='border'"/>
          <xsl:otherwise>
						 <xsl:call-template name="Error">
							  <xsl:with-param name="msg" select="'WTRECORDSET Invalid Attribute'"/>
							  <xsl:with-param name="text" select="name()"/>
	 					</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose>
		   </xsl:if>
	 </xsl:for-each>
	 <!-- ****************************************************-->

		<xsl:variable name="width">
			<xsl:choose>
				<xsl:when test="@tablewidth"><xsl:value-of select="@tablewidth"/></xsl:when>
				<xsl:when test="@width"><xsl:value-of select="@width"/></xsl:when>
				<xsl:when test="@merge"><xsl:value-of select="sum(ancestor::WTCONTENT/WTCOLUMN[(position() &gt;= (current()/@col)) and (position() &lt;= (current()/@col + current()/@merge - 1))]/@width)"/></xsl:when>
				<xsl:otherwise><xsl:value-of select="ancestor::WTCONTENT/WTCOLUMN[position()=current()/@col]/@width"/></xsl:otherwise>
			</xsl:choose>
      <xsl:if test="$widthpercent='true'">%</xsl:if>
    </xsl:variable>

		<!--begin the column tag-->
		<xsl:apply-templates select="." mode="cell-begin">
			<xsl:with-param name="indent" select="$indent"/>
			<xsl:with-param name="wrap" select="$wrap"/>
			<xsl:with-param name="isfirst" select="position()=1"/>
		</xsl:apply-templates>

		<xsl:variable name="border">
			<xsl:choose>
				<xsl:when test="/Data/WTENTITY/WTWEBPAGE/@test or /Data/WTPAGE/@test">1</xsl:when>
        <xsl:when test="@border='false'">0</xsl:when>
				<xsl:when test="@border"><xsl:value-of select="@border"/></xsl:when>
        <xsl:otherwise>0</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:if test="@prevnext='top'">
			<xsl:if test="@margin">
				<xsl:call-template name="XSLTD">
					<xsl:with-param name="cnt" select="@margin"/>
					<xsl:with-param name="indent" select="$indent2"/>
				</xsl:call-template>
			</xsl:if>
			<xsl:value-of select="concat($ind2, '&lt;xsl:attribute name=&quot;align&quot;&gt;right&lt;/xsl:attribute&gt;',  $cr)"/>
			<xsl:value-of select="concat($ind2, '&lt;xsl:call-template name=&quot;PreviousNext&quot;/&gt;',  $cr)"/>
		</xsl:if>

		<!--create a table for the recordset-->
		<xsl:value-of select="concat($ind2, '&lt;xsl:element name=&quot;TABLE&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;border&quot;&gt;', $border, '&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;cellpadding&quot;&gt;0&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;cellspacing&quot;&gt;0&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;width&quot;&gt;', $width, '&lt;/xsl:attribute&gt;', $cr)"/>

		<!--add the column headers-->
		<xsl:value-of select="concat($ind3, '&lt;xsl:element name=&quot;TR&quot;&gt;', $cr)"/>
		<xsl:apply-templates select="WTCOLUMN" mode="heading">
			<xsl:with-param name="indent" select="$indent4"/>			
		</xsl:apply-templates>
		<xsl:value-of select="concat($ind3, '&lt;/xsl:element&gt;', $cr)"/>

		<!--gray line before the rows-->
		<xsl:if test="not(@border) or (@border = 'true')">
			<xsl:call-template name="XSLBlankLine">
				<xsl:with-param name="colspan" select="$colcount"/>
				<xsl:with-param name="color">#CCCCCC</xsl:with-param>
				<xsl:with-param name="height">2</xsl:with-param>
				<xsl:with-param name="indent" select="$indent3"/>
			</xsl:call-template>
		</xsl:if>

		<!--process each record-->
		<xsl:value-of select="concat($ind3, '&lt;xsl:for-each select=&quot;')"/>
		<xsl:call-template name="XSLDataPath">
			<xsl:with-param name="entity" select="@entity"/>
			<xsl:with-param name="iscollection" select="true()"/>
		</xsl:call-template>
		<!--filter-->
		<xsl:apply-templates select="WTFILTER"/>
		<xsl:value-of select="concat($tab0, '&quot;&gt;', $cr)"/>

		<xsl:apply-templates select="WTSORT">
				<xsl:with-param name="indent" select="$indent4"/>
		</xsl:apply-templates>

		<xsl:apply-templates select="WTROW | WTCODEGROUP" mode="recordset">
				<xsl:with-param name="indent" select="$indent4"/>
		</xsl:apply-templates>

		<xsl:value-of select="concat($ind3, '&lt;/xsl:for-each&gt;', $cr)"/>

		<!--no items-->
		<xsl:if test="not(@noitems='false') or (@noitems='true')">
			<xsl:if test="@margin">
				<xsl:call-template name="XSLTD">
					<xsl:with-param name="cnt" select="@margin"/>
					<xsl:with-param name="indent" select="$indent2"/>
				</xsl:call-template>
			</xsl:if>
			<xsl:call-template name="XSLNoItems">
				<xsl:with-param name="entity" select="@entity"/>
				<xsl:with-param name="colspan" select="$colcount"/>
				<xsl:with-param name="indent" select="$indent3"/>
			</xsl:call-template>
		</xsl:if>

		<!--gray line after the rows-->
		<xsl:if test="not(@border) or (@border = 'true')">
			<xsl:call-template name="XSLBlankLine">
				<xsl:with-param name="colspan" select="$colcount"/>
				<xsl:with-param name="color">#CCCCCC</xsl:with-param>
				<xsl:with-param name="height">2</xsl:with-param>
				<xsl:with-param name="indent" select="$indent3"/>
			</xsl:call-template>
		</xsl:if>

		<!--number of items-->
		<xsl:if test="@count">
			<xsl:if test="@margin">
				<xsl:call-template name="XSLTD">
					<xsl:with-param name="cnt" select="@margin"/>
					<xsl:with-param name="indent" select="$indent2"/>
				</xsl:call-template>
			</xsl:if>
			<xsl:call-template name="XSLItemCount">
				<xsl:with-param name="entity" select="@entity"/>
				<xsl:with-param name="colspan" select="$colcount"/>
				<xsl:with-param name="indent" select="$indent3"/>
			</xsl:call-template>
		</xsl:if>

		<!--closing tags-->
		<xsl:value-of select="concat($ind2, '&lt;/xsl:element&gt;', $cr)"/>

		<!--end the column tag-->
		<xsl:apply-templates select="." mode="cell-end">
			<xsl:with-param name="indent" select="$indent"/>
			<xsl:with-param name="wrap" select="$wrap"/>
			<xsl:with-param name="islast" select="position()=last()"/>
		</xsl:apply-templates>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTROW" mode="recordset">
	<!--==================================================================-->
		  <xsl:param name="indent"/>
		  <xsl:variable name="hasconditions" select="(count(WTCONDITION) > 0)"/>
		  <xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		  <xsl:variable name="ind2"><xsl:choose><xsl:when test="($hasconditions)"><xsl:value-of select="concat($ind1, $tab1)"/></xsl:when><xsl:otherwise><xsl:value-of select="$ind1"/></xsl:otherwise></xsl:choose></xsl:variable>
		  <xsl:variable name="indent2"><xsl:choose><xsl:when test="($hasconditions)"><xsl:value-of select="$indent+1"/></xsl:when><xsl:otherwise><xsl:value-of select="$indent"/></xsl:otherwise></xsl:choose></xsl:variable>
		  <xsl:variable name="ind3" select="concat($ind2, $tab1)"/>
		  <xsl:variable name="indent3" select="$indent2+1"/>
		  <xsl:variable name="ind4" select="concat($ind3, $tab1)"/>
		  <xsl:variable name="indent4" select="$indent3+1"/>
		  <xsl:variable name="ind5" select="concat($ind4, $tab1)"/>

	 <!-- ***************** Error Checking *******************-->
	 <!--Test valid attributes-->
	 <xsl:for-each select="@*">
		  <xsl:choose>
		  		<xsl:when test="name()='background'"/>
		  		<xsl:when test="name()='height'"/>
				<xsl:when test="name()='class'"/>
				<xsl:when test="name()='margin-top'"/>
				<xsl:when test="name()='margin-bottom'"/>
				<xsl:when test="name()='firstrow'"/>
				<xsl:otherwise>
					 <xsl:call-template name="Error">
						  <xsl:with-param name="msg" select="'WTROW Invalid Attribute'"/>
						  <xsl:with-param name="text" select="name()"/>
	 				</xsl:call-template>
				</xsl:otherwise>
		  </xsl:choose>
	 </xsl:for-each>
	 <!-- ****************************************************-->

			<!--generate IF statement for conditions if they exist-->
			<xsl:if test="($hasconditions)">
				<xsl:call-template name="XSLConditionStart">
					<xsl:with-param name="indent" select="$indent"/>
					<xsl:with-param name="conditions" select="WTCONDITION"/>
				</xsl:call-template>
			</xsl:if>

			<!--apply top margin-->
			<xsl:if test="(@margin-top)">
				<xsl:value-of select="concat($ind2, '&lt;xsl:element name=&quot;TR&quot;&gt;', $cr)"/>
				<xsl:value-of select="concat($ind3, '&lt;xsl:element name=&quot;TD&quot;&gt;', $cr)"/>

        <!--gray bar************************************************************************************-->
        <!-- If using system colors, use the system graybar on color if provided, otherwise use GrayBar -->
        <xsl:if test="/Data/WTENTITY/WTWEBPAGE/@system-colors or /Data/WTPAGE/@system-colors">
          <xsl:if test="(ancestor::WTRECORDSET/@graybar='true')">
            <!-- set the color of the odd number row -->
            <xsl:value-of select="concat($ind3, '&lt;xsl:if test=&quot;(position() mod 2)=1&quot;&gt;', $cr)"/>
            <xsl:value-of select="concat($ind4, '&lt;xsl:if test=&quot;/DATA/SYSTEM/@colorgraybaron!=', $apos, $apos,'&quot;&gt;', $cr)"/>
            <xsl:value-of select="concat($ind5, '&lt;xsl:attribute name=&quot;bgcolor&quot;&gt;#&lt;xsl:value-of select=&quot;/DATA/SYSTEM/@colorgraybaron&quot;/&gt;&lt;/xsl:attribute&gt;', $cr)"/>
            <xsl:value-of select="concat($ind4, '&lt;/xsl:if&gt;', $cr)"/>
            <xsl:value-of select="concat($ind3, '&lt;/xsl:if&gt;', $cr)"/>
            <!-- set the color of the even number row -->
            <xsl:value-of select="concat($ind3, '&lt;xsl:if test=&quot;(position() mod 2)=0&quot;&gt;', $cr)"/>
            <xsl:value-of select="concat($ind4, '&lt;xsl:if test=&quot;/DATA/SYSTEM/@colorgraybaroff!=', $apos, $apos,'&quot;&gt;', $cr)"/>
            <xsl:value-of select="concat($ind5, '&lt;xsl:attribute name=&quot;bgcolor&quot;&gt;#&lt;xsl:value-of select=&quot;/DATA/SYSTEM/@colorgraybaroff&quot;/&gt;&lt;/xsl:attribute&gt;', $cr)"/>
            <xsl:value-of select="concat($ind4, '&lt;/xsl:if&gt;', $cr)"/>
            <xsl:value-of select="concat($ind3, '&lt;/xsl:if&gt;', $cr)"/>
          </xsl:if>
        </xsl:if>
        <xsl:if test="not(/Data/WTENTITY/WTWEBPAGE/@system-colors or /Data/WTPAGE/@system-colors)">
          <!-- set the color of the odd number row only -->
          <xsl:if test="(ancestor::WTRECORDSET/@graybar='true')">
            <xsl:value-of select="concat($ind3, '&lt;xsl:if test=&quot;(position() mod 2)=1&quot;&gt;', $cr)"/>
            <xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;class&quot;&gt;GrayBar&lt;/xsl:attribute&gt;', $cr)"/>
            <xsl:value-of select="concat($ind3, '&lt;/xsl:if&gt;', $cr)"/>
            <xsl:value-of select="concat($ind3, '&lt;xsl:if test=&quot;(position() mod 2)=0&quot;&gt;', $cr)"/>
            <xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;class&quot;&gt;WhiteBar&lt;/xsl:attribute&gt;', $cr)"/>
            <xsl:value-of select="concat($ind3, '&lt;/xsl:if&gt;', $cr)"/>
          </xsl:if>
        </xsl:if>

        <xsl:if test="($colcount)>0">
					<xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;colspan&quot;&gt;', $colcount, '&lt;/xsl:attribute&gt;', $cr)"/>
				</xsl:if>
				<xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;height&quot;&gt;', @margin-top, '&lt;/xsl:attribute&gt;',  $cr)"/>
				<xsl:value-of select="concat($ind3, '&lt;/xsl:element&gt;', $cr)"/>
				<xsl:value-of select="concat($ind2, '&lt;/xsl:element&gt;', $cr)"/>
			</xsl:if>

			<xsl:value-of select="concat($ind2, '&lt;xsl:element name=&quot;TR&quot;&gt;', $cr)"/>
			<xsl:if test="@class">
				<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;class&quot;&gt;', @class, '&lt;/xsl:attribute&gt;', $cr)"/>
			</xsl:if>
			<xsl:if test="@height">
				<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;height&quot;&gt;', @height, '&lt;/xsl:attribute&gt;', $cr)"/>
			</xsl:if>

			<!--gray bar************************************************************************************-->
			<!-- If using system colors, use the system graybar on color if provided, otherwise use GrayBar -->
			<xsl:if test="/Data/WTENTITY/WTWEBPAGE/@system-colors or /Data/WTPAGE/@system-colors">
				<xsl:if test="(ancestor::WTRECORDSET/@graybar='true')">
					<!-- set the color of the odd number row -->
					<xsl:value-of select="concat($ind3, '&lt;xsl:if test=&quot;(position() mod 2)=1&quot;&gt;', $cr)"/>
					<xsl:value-of select="concat($ind4, '&lt;xsl:if test=&quot;/DATA/SYSTEM/@colorgraybaron!=', $apos, $apos,'&quot;&gt;', $cr)"/>
					<xsl:value-of select="concat($ind5, '&lt;xsl:attribute name=&quot;bgcolor&quot;&gt;#&lt;xsl:value-of select=&quot;/DATA/SYSTEM/@colorgraybaron&quot;/&gt;&lt;/xsl:attribute&gt;', $cr)"/>
					<xsl:value-of select="concat($ind4, '&lt;/xsl:if&gt;', $cr)"/>
					<xsl:value-of select="concat($ind3, '&lt;/xsl:if&gt;', $cr)"/>
					<!-- set the color of the even number row -->
					<xsl:value-of select="concat($ind3, '&lt;xsl:if test=&quot;(position() mod 2)=0&quot;&gt;', $cr)"/>
					<xsl:value-of select="concat($ind4, '&lt;xsl:if test=&quot;/DATA/SYSTEM/@colorgraybaroff!=', $apos, $apos,'&quot;&gt;', $cr)"/>
					<xsl:value-of select="concat($ind5, '&lt;xsl:attribute name=&quot;bgcolor&quot;&gt;#&lt;xsl:value-of select=&quot;/DATA/SYSTEM/@colorgraybaroff&quot;/&gt;&lt;/xsl:attribute&gt;', $cr)"/>
					<xsl:value-of select="concat($ind4, '&lt;/xsl:if&gt;', $cr)"/>
					<xsl:value-of select="concat($ind3, '&lt;/xsl:if&gt;', $cr)"/>
				</xsl:if>
			</xsl:if>
			<xsl:if test="not(/Data/WTENTITY/WTWEBPAGE/@system-colors or /Data/WTPAGE/@system-colors)">
				<!-- set the color of the odd number row only -->
				<xsl:if test="(ancestor::WTRECORDSET/@graybar='true')">
					<xsl:value-of select="concat($ind3, '&lt;xsl:if test=&quot;(position() mod 2)=1&quot;&gt;', $cr)"/>
					<xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;class&quot;&gt;GrayBar&lt;/xsl:attribute&gt;', $cr)"/>
					<xsl:value-of select="concat($ind3, '&lt;/xsl:if&gt;', $cr)"/>
					<xsl:value-of select="concat($ind3, '&lt;xsl:if test=&quot;(position() mod 2)=0&quot;&gt;', $cr)"/>
					<xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;class&quot;&gt;WhiteBar&lt;/xsl:attribute&gt;', $cr)"/>
					<xsl:value-of select="concat($ind3, '&lt;/xsl:if&gt;', $cr)"/>
				</xsl:if>
			</xsl:if>

		<!--add the column data-->
			<xsl:apply-templates>
				<xsl:with-param name="indent" select="$indent3"/>			
			</xsl:apply-templates>

			<xsl:value-of select="concat($ind2, '&lt;/xsl:element&gt;', $cr)"/>

		<!--apply bottom margin-->
			<xsl:if test="(@margin-bottom)">
				<xsl:value-of select="concat($ind2, '&lt;xsl:element name=&quot;TR&quot;&gt;', $cr)"/>
				<xsl:value-of select="concat($ind3, '&lt;xsl:element name=&quot;TD&quot;&gt;', $cr)"/>

        <!--gray bar************************************************************************************-->
        <!-- If using system colors, use the system graybar on color if provided, otherwise use GrayBar -->
        <xsl:if test="/Data/WTENTITY/WTWEBPAGE/@system-colors or /Data/WTPAGE/@system-colors">
          <xsl:if test="(ancestor::WTRECORDSET/@graybar='true')">
            <!-- set the color of the odd number row -->
            <xsl:value-of select="concat($ind3, '&lt;xsl:if test=&quot;(position() mod 2)=1&quot;&gt;', $cr)"/>
            <xsl:value-of select="concat($ind4, '&lt;xsl:if test=&quot;/DATA/SYSTEM/@colorgraybaron!=', $apos, $apos,'&quot;&gt;', $cr)"/>
            <xsl:value-of select="concat($ind5, '&lt;xsl:attribute name=&quot;bgcolor&quot;&gt;#&lt;xsl:value-of select=&quot;/DATA/SYSTEM/@colorgraybaron&quot;/&gt;&lt;/xsl:attribute&gt;', $cr)"/>
            <xsl:value-of select="concat($ind4, '&lt;/xsl:if&gt;', $cr)"/>
            <xsl:value-of select="concat($ind3, '&lt;/xsl:if&gt;', $cr)"/>
            <!-- set the color of the even number row -->
            <xsl:value-of select="concat($ind3, '&lt;xsl:if test=&quot;(position() mod 2)=0&quot;&gt;', $cr)"/>
            <xsl:value-of select="concat($ind4, '&lt;xsl:if test=&quot;/DATA/SYSTEM/@colorgraybaroff!=', $apos, $apos,'&quot;&gt;', $cr)"/>
            <xsl:value-of select="concat($ind5, '&lt;xsl:attribute name=&quot;bgcolor&quot;&gt;#&lt;xsl:value-of select=&quot;/DATA/SYSTEM/@colorgraybaroff&quot;/&gt;&lt;/xsl:attribute&gt;', $cr)"/>
            <xsl:value-of select="concat($ind4, '&lt;/xsl:if&gt;', $cr)"/>
            <xsl:value-of select="concat($ind3, '&lt;/xsl:if&gt;', $cr)"/>
          </xsl:if>
        </xsl:if>
        <xsl:if test="not(/Data/WTENTITY/WTWEBPAGE/@system-colors or /Data/WTPAGE/@system-colors)">
          <!-- set the color of the odd number row only -->
          <xsl:if test="(ancestor::WTRECORDSET/@graybar='true')">
            <xsl:value-of select="concat($ind3, '&lt;xsl:if test=&quot;(position() mod 2)=1&quot;&gt;', $cr)"/>
            <xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;class&quot;&gt;GrayBar&lt;/xsl:attribute&gt;', $cr)"/>
            <xsl:value-of select="concat($ind3, '&lt;/xsl:if&gt;', $cr)"/>
            <xsl:value-of select="concat($ind3, '&lt;xsl:if test=&quot;(position() mod 2)=0&quot;&gt;', $cr)"/>
            <xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;class&quot;&gt;WhiteBar&lt;/xsl:attribute&gt;', $cr)"/>
            <xsl:value-of select="concat($ind3, '&lt;/xsl:if&gt;', $cr)"/>
          </xsl:if>
        </xsl:if>

        <xsl:if test="($colcount)>0">
					<xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;colspan&quot;&gt;', $colcount, '&lt;/xsl:attribute&gt;', $cr)"/>
				</xsl:if>
				<xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;height&quot;&gt;', @margin-bottom, '&lt;/xsl:attribute&gt;',  $cr)"/>
				<xsl:value-of select="concat($ind3, '&lt;/xsl:element&gt;', $cr)"/>
				<xsl:value-of select="concat($ind2, '&lt;/xsl:element&gt;', $cr)"/>
			</xsl:if>

			<!--close IF statement for conditions if they exist-->
			<xsl:if test="($hasconditions)">
				<xsl:call-template name="XSLConditionEnd">
					<xsl:with-param name="indent" select="$indent"/>			
				</xsl:call-template>
		  </xsl:if>
	 </xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTRECORDSET" mode="find">
	<!-- ONLY USED BY FIND PAGE UNTIL IT CAN BE RE-WRITTEN -->
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:param name="width"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="ind2" select="concat($ind1, $tab1)"/>
		<xsl:variable name="ind3" select="concat($ind2, $tab1)"/>
		<xsl:variable name="ind4" select="concat($ind3, $tab1)"/>
		<xsl:variable name="ind5" select="concat($ind4, $tab1)"/>
		<xsl:variable name="colcount" select="count(WTATTRIBUTE)"/>

	 <!-- ***************** Error Checking *******************-->
	 <xsl:if test="not(@col)">
	     <xsl:call-template name="Error">
	     	<xsl:with-param name="msg" select="'WTRECORDSET Column Missing'"/>
	     	<xsl:with-param name="text" select="position()"/>
	     </xsl:call-template>
	 </xsl:if>
	 <xsl:if test="not(@entity)">
	     <xsl:call-template name="Error">
	     	<xsl:with-param name="msg" select="'WTRECORDSET Entity Missing'"/>
	     	<xsl:with-param name="text" select="position()"/>
	     </xsl:call-template>
	 </xsl:if>
	 <!--Test valid attributes-->
	 <xsl:for-each select="@*">
			<xsl:variable name="testcol">
				<xsl:call-template name="TestColAttr">
					<xsl:with-param name="attr" select="name()"/>
				</xsl:call-template>
			</xsl:variable>
		   <xsl:if test="$testcol='0'">
				<xsl:choose>
					<xsl:when test="name()='graybar'"/>
					<xsl:when test="name()='graybaron'"/>
					<xsl:when test="name()='graybaroff'"/>
					<xsl:when test="name()='entity'"/>
					<xsl:when test="name()='prevnext'"/>
					<xsl:when test="name()='margin'"/>
					<xsl:otherwise>
						 <xsl:call-template name="Error">
							  <xsl:with-param name="msg" select="'WTRECORDSET Invalid Attribute'"/>
							  <xsl:with-param name="text" select="name()"/>
	 					</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose>
		   </xsl:if>
	 </xsl:for-each>
	 <!-- ****************************************************-->

		<xsl:variable name="border">
			<xsl:choose>
				<xsl:when test="/Data/WTENTITY/WTWEBPAGE/@test or /Data/WTPAGE/@test">1</xsl:when>
				<xsl:when test="@border"><xsl:value-of select="@border"/></xsl:when>
				<xsl:otherwise>0</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<!--create a table for the recordset-->
		<xsl:value-of select="concat($ind1, '&lt;xsl:element name=&quot;TABLE&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($ind2, '&lt;xsl:attribute name=&quot;border&quot;&gt;', $border, '&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($ind2, '&lt;xsl:attribute name=&quot;cellpadding&quot;&gt;0&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($ind2, '&lt;xsl:attribute name=&quot;cellspacing&quot;&gt;0&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($ind2, '&lt;xsl:attribute name=&quot;width&quot;&gt;', $width, '&lt;/xsl:attribute&gt;', $cr)"/>

		<!--add the column headers-->
		<xsl:value-of select="concat($ind2, '&lt;xsl:element name=&quot;TR&quot;&gt;', $cr)"/>

		<xsl:apply-templates select="WTATTRIBUTE" mode="heading">
			<xsl:with-param name="indent" select="$indent+2"/>			
		</xsl:apply-templates>

		<xsl:value-of select="concat($ind2, '&lt;/xsl:element&gt;', $cr)"/>

		<!--gray line before the rows-->
		<xsl:call-template name="XSLBlankLine">
			<xsl:with-param name="colspan" select="$colcount"/>
			<xsl:with-param name="color">#CCCCCC</xsl:with-param>
			<xsl:with-param name="height">2</xsl:with-param>
			<xsl:with-param name="indent" select="$indent+1"/>
		</xsl:call-template>

		<!--process each record-->
		<xsl:value-of select="concat($ind2, '&lt;xsl:for-each select=&quot;')"/>
		<xsl:call-template name="XSLDataPath">
			<xsl:with-param name="iscollection" select="true()"/>
		</xsl:call-template>
		<xsl:value-of select="concat($tab0, '&quot;&gt;', $cr)"/>

		<xsl:value-of select="concat($ind3, '&lt;xsl:element name=&quot;TR&quot;&gt;', $cr)"/>

		<!--gray bar************************************************************************************-->
		<!-- If using system colors, use the system graybar on color if provided, otherwise use GrayBar -->
		<xsl:if test="/Data/WTENTITY/WTWEBPAGE/@system-colors or /Data/WTPAGE/@system-colors">
			<!-- set the color of the odd number row -->
			<xsl:value-of select="concat($ind3, '&lt;xsl:if test=&quot;(position() mod 2)=1&quot;&gt;', $cr)"/>
			<xsl:value-of select="concat($ind4, '&lt;xsl:if test=&quot;/DATA/SYSTEM/@colorgraybaron!=', $apos, $apos,'&quot;&gt;', $cr)"/>
			<xsl:value-of select="concat($ind5, '&lt;xsl:attribute name=&quot;bgcolor&quot;&gt;#&lt;xsl:value-of select=&quot;/DATA/SYSTEM/@colorgraybaron&quot;/&gt;&lt;/xsl:attribute&gt;', $cr)"/>
			<xsl:value-of select="concat($ind4, '&lt;/xsl:if&gt;', $cr)"/>
			<xsl:value-of select="concat($ind3, '&lt;/xsl:if&gt;', $cr)"/>
			<!-- set the color of the even number row -->
			<xsl:value-of select="concat($ind3, '&lt;xsl:if test=&quot;(position() mod 2)=0&quot;&gt;', $cr)"/>
			<xsl:value-of select="concat($ind4, '&lt;xsl:if test=&quot;/DATA/SYSTEM/@colorgraybaroff!=', $apos, $apos,'&quot;&gt;', $cr)"/>
			<xsl:value-of select="concat($ind5, '&lt;xsl:attribute name=&quot;bgcolor&quot;&gt;#&lt;xsl:value-of select=&quot;/DATA/SYSTEM/@colorgraybaroff&quot;/&gt;&lt;/xsl:attribute&gt;', $cr)"/>
			<xsl:value-of select="concat($ind4, '&lt;/xsl:if&gt;', $cr)"/>
			<xsl:value-of select="concat($ind3, '&lt;/xsl:if&gt;', $cr)"/>
		</xsl:if>
		<xsl:if test="not(/Data/WTENTITY/WTWEBPAGE/@system-colors or /Data/WTPAGE/@system-colors)">
			<!-- set the color of the odd number row only -->
			<xsl:if test="(ancestor::WTRECORDSET/@graybar='true')">
				<xsl:value-of select="concat($ind3, '&lt;xsl:if test=&quot;(position() mod 2)&quot;&gt;', $cr)"/>
				<xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;class&quot;&gt;GrayBar&lt;/xsl:attribute&gt;', $cr)"/>
				<xsl:value-of select="concat($ind3, '&lt;/xsl:if&gt;', $cr)"/>
			</xsl:if>
		</xsl:if>

		<!--add the column data-->
		<xsl:apply-templates select="WTATTRIBUTE" mode="data">
			<xsl:with-param name="indent" select="$indent+3"/>
		</xsl:apply-templates>

		<xsl:value-of select="concat($ind3, '&lt;/xsl:element&gt;', $cr)"/>
		<xsl:value-of select="concat($ind2, '&lt;/xsl:for-each&gt;', $cr)"/>

		<!--no items-->
		<xsl:call-template name="XSLNoItems">
			<xsl:with-param name="colspan" select="$colcount"/>
			<xsl:with-param name="indent" select="$indent + 1"/>
		</xsl:call-template>

		<!--gray line after the rows-->
		<xsl:call-template name="XSLBlankLine">
			<xsl:with-param name="colspan" select="$colcount"/>
			<xsl:with-param name="color">#CCCCCC</xsl:with-param>
			<xsl:with-param name="height">2</xsl:with-param>
			<xsl:with-param name="indent" select="$indent+1"/>
		</xsl:call-template>

		<!--number of items-->
		<xsl:if test="@count">
			<xsl:call-template name="XSLItemCount">
				<xsl:with-param name="colspan" select="$colcount"/>
				<xsl:with-param name="indent" select="$indent + 1"/>
			</xsl:call-template>
		</xsl:if>

		<!--closing tags-->
		<xsl:value-of select="concat($ind1, '&lt;/xsl:element&gt;', $cr)"/>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTRECORDSET/WTATTRIBUTE" mode="data">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:variable name="hasconditions" select="@hidden"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="ind2"><xsl:choose><xsl:when test="($hasconditions)"><xsl:value-of select="concat($ind1, $tab1)"/></xsl:when><xsl:otherwise><xsl:value-of select="$ind1"/></xsl:otherwise></xsl:choose></xsl:variable>
		<xsl:variable name="ind3" select="concat($ind2, $tab1)"/>
		<xsl:variable name="indent3"><xsl:choose><xsl:when test="($hasconditions)"><xsl:value-of select="$indent+2"/></xsl:when><xsl:otherwise><xsl:value-of select="$indent+1"/></xsl:otherwise></xsl:choose></xsl:variable>

	 <!-- ***************** Error Checking *******************-->
	 <!--Test valid attributes-->
	 <xsl:for-each select="@*">
		  <xsl:choose>
  			<xsl:when test="1=0"/>
		  	<xsl:otherwise>
		  		 <xsl:call-template name="Error">
		  			  <xsl:with-param name="msg" select="'WTRECORDSET/WTATTRIBUTE Invalid Attribute'"/>
		  			  <xsl:with-param name="text" select="name()"/>
	 	  		</xsl:call-template>
		  	</xsl:otherwise>
		  </xsl:choose>
	 </xsl:for-each>
	 <!-- ****************************************************-->

		<xsl:if test="($hasconditions)">
			<xsl:call-template name="XSLConditionStart">
				<xsl:with-param name="indent" select="$indent"/>
				<xsl:with-param name="hidden" select="@hidden"/>
			</xsl:call-template>
		</xsl:if>

		<xsl:value-of select="concat($ind2, '&lt;xsl:element name=&quot;TD&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;valign&quot;&gt;top&lt;/xsl:attribute&gt;', $cr)"/>

		<xsl:apply-templates select="../WTLINK">
			<xsl:with-param name="indent" select="$indent3"/>		
			<xsl:with-param name="label" select="concat('DATA(', @name, ')')"/>
			<xsl:with-param name="class" select="@class"/>
		</xsl:apply-templates>

		<xsl:value-of select="concat($ind2, '&lt;/xsl:element&gt;', $cr)"/>

		<xsl:if test="($hasconditions)">
			<xsl:call-template name="XSLConditionEnd">
				<xsl:with-param name="indent" select="$indent"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTRECORDSET/WTCOLUMN" mode="heading">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:variable name="hasconditions" select="@hidden"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="ind2"><xsl:choose><xsl:when test="($hasconditions)"><xsl:value-of select="concat($ind1, $tab1)"/></xsl:when><xsl:otherwise><xsl:value-of select="$ind1"/></xsl:otherwise></xsl:choose></xsl:variable>
		<xsl:variable name="ind3" select="concat($ind2, $tab1)"/>

	 <!-- ***************** Error Checking *******************-->
	 <xsl:if test="not(@width)">
	     <xsl:call-template name="Error">
	     	<xsl:with-param name="msg" select="'WTCOLUMN Width Missing'"/>
	     	<xsl:with-param name="text" select="position()"/>
	     </xsl:call-template>
	 </xsl:if>
	 <!--Test valid attributes-->
	 <xsl:for-each select="@*">
		  <xsl:choose>
		   <xsl:when test="name()='width'"/>
		   <xsl:when test="name()='align'"/>
		   <xsl:when test="name()='valign'"/>
		   <xsl:when test="name()='label'"/>
		  	<xsl:otherwise>
		  		 <xsl:call-template name="Error">
		  			  <xsl:with-param name="msg" select="'WTCOLUMN Invalid Attribute'"/>
		  			  <xsl:with-param name="text" select="name()"/>
	 	  		</xsl:call-template>
		  	</xsl:otherwise>
		  </xsl:choose>
	 </xsl:for-each>
	 <!-- ****************************************************-->

		<xsl:if test="($hasconditions)">
			<xsl:call-template name="XSLConditionStart">
				<xsl:with-param name="indent" select="$indent"/>			
				<xsl:with-param name="hidden" select="@hidden"/>			
			</xsl:call-template>
		</xsl:if>

		<xsl:value-of select="concat($ind2, '&lt;xsl:element name=&quot;TD&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;align&quot;&gt;', @align, '&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;width&quot;&gt;', @width, '%&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;class&quot;&gt;ColumnTitle&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;valign&quot;&gt;Bottom&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:call-template name="XSLLabelText">
			<xsl:with-param name="label" select="@label"/>
			<xsl:with-param name="indent" select="$indent+1"/>
			<xsl:with-param name="newline" select="true()"/>
		</xsl:call-template>
		<xsl:value-of select="concat($ind2, '&lt;/xsl:element&gt;', $cr)"/>

		<xsl:if test="($hasconditions)">
			<xsl:call-template name="XSLConditionEnd">
				<xsl:with-param name="indent" select="$indent"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTSTATIC">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:param name="wrap" select="false()"/>
		<xsl:variable name="hasconditions" select="(count(WTCONDITION) > 0)"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>

		<xsl:variable name="ind2" select="concat($ind1, $tab1)"/>
		<xsl:variable name="indent2" select="$indent+1"/>
		<xsl:variable name="ind3"><xsl:choose><xsl:when test="$hasconditions"><xsl:value-of select="concat($ind2, $tab1)"/></xsl:when><xsl:otherwise><xsl:value-of select="$ind2"/></xsl:otherwise></xsl:choose></xsl:variable>
		<xsl:variable name="indent3"><xsl:choose><xsl:when test="$hasconditions"><xsl:value-of select="$indent2 +1"/></xsl:when><xsl:otherwise><xsl:value-of select="$indent2"/></xsl:otherwise></xsl:choose></xsl:variable>
		<xsl:variable name="ind4" select="concat($ind3, $tab1)"/>
		<xsl:variable name="indent4" select="$indent3+1"/>
		<xsl:variable name="indent5" select="$indent4+1"/>

		<xsl:variable name="valuetype"><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>
		<xsl:variable name="valuetext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>
		<xsl:variable name="valueentity"><xsl:call-template name="QualifiedPrefix"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>

	 <!-- ***************** Error Checking *******************-->
	<xsl:if test="not(ancestor::WTSTATIC) and not(ancestor::WTBUTTON) and not(ancestor::WTTREE) and not(ancestor::WTTREE2) and not(ancestor::WTDIVISION) and not(ancestor::WTCODEGROUP) and (ancestor::WTROW)">
		<xsl:if test="not(@col)">
		    <xsl:call-template name="Error">
		    	<xsl:with-param name="msg" select="'WTSTATIC Column Missing'"/>
		    	<xsl:with-param name="text" select="position()"/>
		    </xsl:call-template>
		</xsl:if>
	 </xsl:if>
	 <!--Test valid attributes-->
	 <xsl:for-each select="@*">
			<xsl:variable name="testcol">
				<xsl:call-template name="TestColAttr">
					<xsl:with-param name="attr" select="name()"/>
				</xsl:call-template>
			</xsl:variable>
		   <xsl:if test="$testcol='0'">
				<xsl:choose>
					<xsl:when test="name()='id'"/>
					<xsl:when test="name()='style'"/>
					<xsl:when test="name()='label'"/>
					<xsl:when test="name()='tag'"/>
					<xsl:when test="name()='type'"/>
					<xsl:when test="name()='space'"/>
					<xsl:when test="name()='spacex'"/>
					<xsl:when test="name()='nospace'"/>
					<xsl:when test="name()='spaceafter'"/>
					<xsl:when test="name()='enum'"/>
					<xsl:when test="name()='newline'"/>
					<xsl:when test="name()='embedhtml'"/>
					<xsl:when test="name()='notranslate'"/>
					<xsl:when test="name()='translate'"/>
					<xsl:when test="name()='escape'"/>

					<xsl:when test="name()='heading'"/>
					<xsl:when test="name()='division'"/>
					<xsl:when test="name()='paragraph'"/>
					<xsl:when test="name()='bold'"/>
					<xsl:when test="name()='italic'"/>
					<xsl:when test="name()='underline'"/>
					<xsl:when test="name()='strike'"/>
					<xsl:when test="name()='super'"/>
					<xsl:when test="name()='sub'"/>
					<xsl:when test="name()='preformat'"/>
					<xsl:when test="name()='block'"/>
					<xsl:when test="name()='line'"/>
					<xsl:when test="name()='solid'"/>
					<xsl:when test="name()='list'"/>
					<xsl:when test="name()='bullet'"/>
					<xsl:when test="name()='bulletstart'"/>
					<xsl:when test="name()='fontsize'"/>
					<xsl:when test="name()='fontcolor'"/>
					<xsl:when test="name()='fontface'"/>
					<xsl:otherwise>
						 <xsl:call-template name="Error">
							  <xsl:with-param name="msg" select="'WTSTATIC Invalid Attribute'"/>
							  <xsl:with-param name="text" select="name()"/>
	 					</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose>
		   </xsl:if>
	 </xsl:for-each>
	 <!-- ****************************************************-->

		<!--begin the column tag-->
		<xsl:if test="@col">
			<xsl:apply-templates select="." mode="cell-begin">
				<xsl:with-param name="indent" select="$indent"/>
				<xsl:with-param name="wrap" select="$wrap"/>
				<xsl:with-param name="isfirst" select="position()=1"/>
			</xsl:apply-templates>
		</xsl:if>

		<!--generate IF statement for conditions if they exist-->
		<xsl:if test="($hasconditions)">
			<xsl:call-template name="XSLConditionStart">
				<xsl:with-param name="indent" select="$indent2"/>
				<xsl:with-param name="conditions" select="WTCONDITION"/>
			</xsl:call-template>
		</xsl:if>

		<xsl:variable name="linktype">
			<xsl:choose>
				<xsl:when test="@label"></xsl:when>
				<xsl:when test="@tag"></xsl:when>
				<xsl:otherwise><xsl:value-of select="@type"/></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:apply-templates select="WTLINK">
			<xsl:with-param name="indent" select="$indent3"/>
			<xsl:with-param name="type" select="$linktype"/>
			<xsl:with-param name="part">1</xsl:with-param>
		</xsl:apply-templates>

		<!--***** Start All Formatting *****************************************************************************-->
		<xsl:if test="@division">
			<xsl:value-of select="concat($ind3, '&lt;xsl:element name=&quot;div&quot;&gt;', $cr)"/>
			<xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;id&quot;&gt;', @division, '&lt;/xsl:attribute&gt;', $cr)"/>
			<xsl:if test="@align"><xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;align&quot;&gt;', @align, '&lt;/xsl:attribute&gt;', $cr)"/></xsl:if>
		</xsl:if>
		<xsl:if test="@paragraph">
			<xsl:value-of select="concat($ind3, '&lt;xsl:element name=&quot;p&quot;&gt;', $cr)"/>
			<xsl:if test="@align"><xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;align&quot;&gt;', @align, '&lt;/xsl:attribute&gt;', $cr)"/></xsl:if>
		</xsl:if>
		<xsl:if test="@preformat"><xsl:value-of select="concat($ind3, '&lt;xsl:element name=&quot;pre&quot;&gt;', $cr)"/></xsl:if>
		<xsl:if test="@block"><xsl:value-of select="concat($ind3, '&lt;xsl:element name=&quot;blockquote&quot;&gt;', $cr)"/></xsl:if>
		<xsl:if test="@heading"><xsl:value-of select="concat($ind3, '&lt;xsl:element name=&quot;h',@heading ,'&quot;&gt;', $cr)"/></xsl:if>
		<xsl:if test="@bold"><xsl:value-of select="concat($ind3, '&lt;xsl:element name=&quot;b&quot;&gt;', $cr)"/></xsl:if>
		<xsl:if test="@italic"><xsl:value-of select="concat($ind3, '&lt;xsl:element name=&quot;i&quot;&gt;', $cr)"/></xsl:if>
		<xsl:if test="@underline"><xsl:value-of select="concat($ind3, '&lt;xsl:element name=&quot;u&quot;&gt;', $cr)"/></xsl:if>
		<xsl:if test="@strike"><xsl:value-of select="concat($ind3, '&lt;xsl:element name=&quot;strike&quot;&gt;', $cr)"/></xsl:if>
		<xsl:if test="@super"><xsl:value-of select="concat($ind3, '&lt;xsl:element name=&quot;sup&quot;&gt;', $cr)"/></xsl:if>
		<xsl:if test="@sub"><xsl:value-of select="concat($ind3, '&lt;xsl:element name=&quot;sub&quot;&gt;', $cr)"/></xsl:if>
		<xsl:if test="@line">
			<xsl:if test="@line='true'"><xsl:value-of select="concat($ind3, '&lt;xsl:element name=&quot;hr&quot;&gt;', $cr)"/></xsl:if>
			<xsl:if test="not(@line='true')">
				<xsl:value-of select="concat($ind3, '&lt;xsl:element name=&quot;hr&quot;&gt;', $cr)"/>
				<xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;size&quot;&gt;', @line, '&lt;/xsl:attribute&gt;', $cr)"/>
			</xsl:if>
			<xsl:if test="@width"><xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;width&quot;&gt;', @width, '&lt;/xsl:attribute&gt;', $cr)"/></xsl:if>
			<xsl:if test="@align"><xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;align&quot;&gt;', @align, '&lt;/xsl:attribute&gt;', $cr)"/></xsl:if>
			<xsl:if test="@solid"><xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;noshade&quot;/&gt;', $cr)"/></xsl:if>
		</xsl:if>
		<xsl:if test="@list">
			<xsl:if test="position()=1">
				<xsl:choose>
					<xsl:when test="@list='ordered'"><xsl:value-of select="concat($ind3, '&lt;xsl:element name=&quot;ol&quot;&gt;', $cr)"/></xsl:when>
					<xsl:when test="@list='unordered'"><xsl:value-of select="concat($ind3, '&lt;xsl:element name=&quot;ul&quot;&gt;', $cr)"/></xsl:when>
					<xsl:when test="@list='defined'"><xsl:value-of select="concat($ind3, '&lt;xsl:element name=&quot;dl&quot;&gt;', $cr)"/></xsl:when>
					<xsl:when test="@list='definedtitle'"><xsl:value-of select="concat($ind3, '&lt;xsl:element name=&quot;dl&quot;&gt;', $cr)"/></xsl:when>
				</xsl:choose>
				<xsl:if test="(@list='ordered' or @list='unordered') and @bullet">
					<xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;type&quot;&gt;', @bullet, '&lt;/xsl:attribute&gt;', $cr)"/>
				</xsl:if>
				<xsl:if test="(@list='ordered') and @bulletstart">
					<xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;start&quot;&gt;', @bulletstart, '&lt;/xsl:attribute&gt;', $cr)"/>
				</xsl:if>
			</xsl:if>
			<xsl:choose>
				<xsl:when test="@list='ordered'"><xsl:value-of select="concat($ind3, '&lt;xsl:element name=&quot;li&quot;&gt;', $cr)"/></xsl:when>
				<xsl:when test="@list='unordered'"><xsl:value-of select="concat($ind3, '&lt;xsl:element name=&quot;li&quot;&gt;', $cr)"/></xsl:when>
				<xsl:when test="@list='defined'"><xsl:value-of select="concat($ind3, '&lt;xsl:element name=&quot;dd&quot;&gt;', $cr)"/></xsl:when>
				<xsl:when test="@list='definedtitle'"><xsl:value-of select="concat($ind3, '&lt;xsl:element name=&quot;dt&quot;&gt;', $cr)"/></xsl:when>
			</xsl:choose>
		</xsl:if>
		
		<xsl:if test="@class = 'prompt' or @class = 'Prompt'">
			<!-- If using system colors, use the system prompt color if provided -->
			<xsl:if test="/Data/WTENTITY/WTWEBPAGE/@system-colors or /Data/WTPAGE/@system-colors">
				<xsl:value-of select="concat($ind3, '&lt;xsl:element name=&quot;font&quot;&gt;', $cr)"/>
				<xsl:value-of select="concat($ind3, '&lt;xsl:if test=&quot;/DATA/SYSTEM/@colorprompt!=', $apos, $apos,'&quot;&gt;', $cr)"/>
				<xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;color&quot;&gt;#&lt;xsl:value-of select=&quot;/DATA/SYSTEM/@colorprompt&quot;/&gt;&lt;/xsl:attribute&gt;', $cr)"/>
				<xsl:value-of select="concat($ind3, '&lt;/xsl:if&gt;', $cr)"/>
			</xsl:if>
		</xsl:if>
		<xsl:if test="not(@class) or (@class != 'prompt' and @class != 'Prompt')">
			<xsl:if test="@fontsize or @fontcolor or @fontface">
				<xsl:value-of select="concat($ind3, '&lt;xsl:element name=&quot;font&quot;&gt;', $cr)"/>
				<xsl:if test="@fontsize">
					<xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;size&quot;&gt;', @fontsize, '&lt;/xsl:attribute&gt;', $cr)"/>
				</xsl:if>
				<xsl:if test="@fontcolor">
					<xsl:variable name="fontcolor"><xsl:call-template name="GetColor"><xsl:with-param name="color" select="@fontcolor"/></xsl:call-template></xsl:variable>
					<xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;color&quot;&gt;', $fontcolor, '&lt;/xsl:attribute&gt;', $cr)"/>
				</xsl:if>
				<xsl:if test="@fontface">
					<xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;face&quot;&gt;', @fontface, '&lt;/xsl:attribute&gt;', $cr)"/>
				</xsl:if>
			</xsl:if>
		</xsl:if>

		<xsl:if test="@id">
			<xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;id&quot;&gt;', @id, '&lt;/xsl:attribute&gt;', $cr)"/>
		</xsl:if>
		<xsl:if test="@style">
			<xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;style&quot;&gt;', @style, '&lt;/xsl:attribute&gt;', $cr)"/>
		</xsl:if>

		<!--********************************************************************************************************-->

		<!--build the text-->
		<xsl:if test="@tag">
			<xsl:variable name="tagtype"><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="@tag"/></xsl:call-template></xsl:variable>
			<xsl:variable name="tagtext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@tag"/></xsl:call-template></xsl:variable>

			<xsl:choose>
				<xsl:when test="($tagtype='DATA')">
					<xsl:call-template name="XSLDataField">
						<xsl:with-param name="indent" select="$indent3"/>
						<xsl:with-param name="name" select="$tagtext"/>
					</xsl:call-template>
					<xsl:value-of select="concat($ind3, '&lt;xsl:text&gt;:&lt;/xsl:text&gt;', $cr)"/>
					<xsl:call-template name="XSLDblSpace">
						<xsl:with-param name="indent" select="$indent3"/>
						<xsl:with-param name="space" select="@spaceafter"/>
					</xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="XSLLabelText">
						<xsl:with-param name="indent" select="$indent3"/>
						<xsl:with-param name="label" select="@tag"/>
						<xsl:with-param name="islabel" select="true()"/>
					</xsl:call-template>
					<xsl:call-template name="XSLDblSpace">
						<xsl:with-param name="indent" select="$indent3"/>
						<xsl:with-param name="space" select="@spaceafter"/>
					</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>

		<xsl:if test="(@label)">
			<xsl:variable name="label">
				<xsl:call-template name="XSLLabelText">
					<xsl:with-param name="indent" select="$indent3"/>
					<xsl:with-param name="label" select="@label"/>
					<xsl:with-param name="islabel" select="false()"/>
				</xsl:call-template>
			</xsl:variable>
			<xsl:value-of select="$label"/>
			<xsl:if test="(@value) and (not(@nospace))">
				<xsl:call-template name="XSLDblSpace">
					<xsl:with-param name="indent" select="$indent3"/>
					<xsl:with-param name="space" select="@spaceafter"/>
				</xsl:call-template>
			</xsl:if>
		</xsl:if>

		<xsl:if test="string-length($valuetext)&gt;0">

			<xsl:choose>
				<!--Yes/No fields need condition for the correct label to display-->
				<xsl:when test="($valuetype='DATA') and ((/Data/WTENTITY/WTATTRIBUTE[@name=$valuetext]/@type='yesno') or (@type='yesno'))">
					<xsl:variable name="fieldname">
						<xsl:call-template name="XSLDataField">
							<xsl:with-param name="name" select="$valuetext"/>
							<xsl:with-param name="newline" select="false()"/>
							<xsl:with-param name="noselect" select="true()"/>
						</xsl:call-template>
					</xsl:variable>
					<xsl:value-of select="concat($ind3, '&lt;xsl:choose&gt;', $cr)"/>
					<xsl:value-of select="concat($ind4, '&lt;xsl:when test=&quot;(', $fieldname, '=', $apos, '0', $apos, ')&quot;&gt;', $cr)"/>

					<xsl:call-template name="XSLLabelText">
						<xsl:with-param name="label" select="concat($valuetext,'False')"/>
						<xsl:with-param name="indent" select="$indent5"/>
						<xsl:with-param name="newline" select="true()"/>
					</xsl:call-template>
					<xsl:value-of select="concat($ind4, '&lt;/xsl:when&gt;', $cr)"/>
					<xsl:value-of select="concat($ind4, '&lt;xsl:otherwise&gt;', $cr)"/>
					<xsl:call-template name="XSLLabelText">
						<xsl:with-param name="label" select="concat($valuetext,'True')"/>
						<xsl:with-param name="indent" select="$indent5"/>
						<xsl:with-param name="newline" select="true()"/>
					</xsl:call-template>
					<xsl:value-of select="concat($ind4, '&lt;/xsl:otherwise&gt;', $cr)"/>
					<xsl:value-of select="concat($ind3, '&lt;/xsl:choose&gt;', $cr)"/>
				</xsl:when>
				
				<xsl:otherwise>
					<xsl:value-of select="$ind3"/>
		  			<xsl:call-template name="GetValue">
		  				 <xsl:with-param name="type" select="$valuetype"/>
		  				 <xsl:with-param name="text" select="$valuetext"/>
		  				 <xsl:with-param name="entity" select="$valueentity"/>
		  				 <xsl:with-param name="output" select="true()"/>
		  			</xsl:call-template>
		  			<xsl:value-of select="$cr"/>
				</xsl:otherwise>
			</xsl:choose>
			
		</xsl:if>
<!--
		<xsl:variable name="linkvalue">
			<xsl:choose>
				<xsl:when test="WTLINK/@value"><xsl:value-of select="WTLINK/@value"/></xsl:when>
				<xsl:when test="WTLINK/@label"><xsl:value-of select="WTLINK/@label"/></xsl:when>
				<xsl:when test="WTLINK/@tag"><xsl:value-of select="WTLINK/@tag"/></xsl:when>
				<xsl:when test="@value"><xsl:value-of select="@value"/></xsl:when>
				<xsl:when test="@label"><xsl:value-of select="@label"/></xsl:when>
				<xsl:when test="@tag"><xsl:value-of select="@tag"/></xsl:when>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="linktype">
			<xsl:choose>
				<xsl:when test="@label"></xsl:when>
				<xsl:when test="@tag"></xsl:when>
				<xsl:otherwise><xsl:value-of select="@type"/></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:apply-templates select="WTLINK">
			<xsl:with-param name="indent" select="$indent3"/>
			<xsl:with-param name="label" select="$linkvalue"/>
			<xsl:with-param name="type" select="$linktype"/>
		</xsl:apply-templates>
-->
		<xsl:apply-templates select="WTSTATIC | WTCODEGROUP | WTREPEAT">
			<xsl:with-param name="indent" select="$indent+1"/>
		</xsl:apply-templates>

		<!-- Close All Formatting **********************************************************************************-->
		<xsl:if test="@division"><xsl:value-of select="concat($ind3, '&lt;/xsl:element&gt;', $cr)"/></xsl:if>
		<xsl:if test="@paragraph"><xsl:value-of select="concat($ind3, '&lt;/xsl:element&gt;', $cr)"/></xsl:if>
		<xsl:if test="@preformat"><xsl:value-of select="concat($ind3, '&lt;/xsl:element&gt;', $cr)"/></xsl:if>
		<xsl:if test="@block"><xsl:value-of select="concat($ind3, '&lt;/xsl:element&gt;', $cr)"/></xsl:if>
		<xsl:if test="@heading"><xsl:value-of select="concat($ind3, '&lt;/xsl:element&gt;', $cr)"/></xsl:if>
		<xsl:if test="@bold"><xsl:value-of select="concat($ind3, '&lt;/xsl:element&gt;', $cr)"/></xsl:if>
		<xsl:if test="@italic"><xsl:value-of select="concat($ind3, '&lt;/xsl:element&gt;', $cr)"/></xsl:if>
		<xsl:if test="@underline"><xsl:value-of select="concat($ind3, '&lt;/xsl:element&gt;', $cr)"/></xsl:if>
		<xsl:if test="@strike"><xsl:value-of select="concat($ind3, '&lt;/xsl:element&gt;', $cr)"/></xsl:if>
		<xsl:if test="@super"><xsl:value-of select="concat($ind3, '&lt;/xsl:element&gt;', $cr)"/></xsl:if>
		<xsl:if test="@sub"><xsl:value-of select="concat($ind3, '&lt;/xsl:element&gt;', $cr)"/></xsl:if>
		<xsl:if test="@line"><xsl:value-of select="concat($ind3, '&lt;/xsl:element&gt;', $cr)"/></xsl:if>
		<xsl:if test="@list">
			<xsl:if test="position()=last()"><xsl:value-of select="concat($ind3, '&lt;/xsl:element&gt;', $cr)"/></xsl:if>
			<xsl:value-of select="concat($ind3, '&lt;/xsl:element&gt;', $cr)"/>
		</xsl:if>
		
		<xsl:if test="@class = 'prompt' or @class = 'Prompt'">
			<!-- If using system colors, use the system prompt color if provided -->
			<xsl:if test="/Data/WTENTITY/WTWEBPAGE/@system-colors or /Data/WTPAGE/@system-colors">
				<xsl:value-of select="concat($ind3, '&lt;/xsl:element&gt;', $cr)"/>
			</xsl:if>
		</xsl:if>
		<xsl:if test="not(@class) or (@class != 'prompt' and @class != 'Prompt')">
			<xsl:if test="@fontsize or @fontcolor or @fontface"><xsl:value-of select="concat($ind3, '&lt;/xsl:element&gt;', $cr)"/></xsl:if>
		</xsl:if>
		
		<!--********************************************************************************************************-->

		<xsl:if test="@space">
			<xsl:call-template name="XSLSpace">
				<xsl:with-param name="indent" select="$indent3"/>
				<xsl:with-param name="space" select="@space"/>
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="@spacex">
			<xsl:call-template name="XSLSpacex">
				<xsl:with-param name="indent" select="$indent3"/>
				<xsl:with-param name="space" select="@spacex"/>
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="@newline">
			<xsl:call-template name="XSLNewLine">
				<xsl:with-param name="indent" select="$indent3"/>
				<xsl:with-param name="line" select="@newline"/>
			</xsl:call-template>
		</xsl:if>

		<xsl:apply-templates select="WTLINK">
			<xsl:with-param name="indent" select="$indent3"/>
			<xsl:with-param name="type" select="$linktype"/>
			<xsl:with-param name="part">2</xsl:with-param>
		</xsl:apply-templates>

		<xsl:if test="($hasconditions)">
			<xsl:call-template name="XSLConditionEnd">
				<xsl:with-param name="indent" select="$indent2"/>			
			</xsl:call-template>
		</xsl:if>

		<!--end the column tag-->
		<xsl:if test="@col">
			<xsl:apply-templates select="." mode="cell-end">
				<xsl:with-param name="indent" select="$indent"/>
				<xsl:with-param name="wrap" select="$wrap"/>
				<xsl:with-param name="islast" select="position()=last()"/>
			</xsl:apply-templates>
		</xsl:if>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTIMAGE[WTLINK]">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:param name="wrap" select="false()"/>
		<xsl:variable name="hasconditions" select="(count(WTCONDITION) > 0)"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="ind2" select="concat($ind1, $tab1)"/>
		<xsl:variable name="indent2" select="$indent+1"/>
		<xsl:variable name="ind3"><xsl:choose><xsl:when test="$hasconditions"><xsl:value-of select="concat($ind2, $tab1)"/></xsl:when><xsl:otherwise><xsl:value-of select="$ind2"/></xsl:otherwise></xsl:choose></xsl:variable>
		<xsl:variable name="indent3"><xsl:choose><xsl:when test="$hasconditions"><xsl:value-of select="$indent2 +1"/></xsl:when><xsl:otherwise><xsl:value-of select="$indent2"/></xsl:otherwise></xsl:choose></xsl:variable>

	 <!-- ***************** Error Checking *******************-->
	 <xsl:if test="not(ancestor::WTSTATIC) and not(ancestor::WTTREE) and not(ancestor::WTTREE2) and not(ancestor::WTDIVISION)">
		<xsl:if test="not(@col)">
		    <xsl:call-template name="Error">
		    	<xsl:with-param name="msg" select="'WTIMAGE[WTLINK] Column Missing'"/>
		    	<xsl:with-param name="text" select="position()"/>
		    </xsl:call-template>
		</xsl:if>
	 </xsl:if>
	 <!--Test valid attributes-->
	 <xsl:for-each select="@*">
			<xsl:variable name="testcol">
				<xsl:call-template name="TestColAttr">
					<xsl:with-param name="attr" select="name()"/>
				</xsl:call-template>
			</xsl:variable>
		   <xsl:if test="$testcol='0'">
				<xsl:choose>
		  			<xsl:when test="name()='alt'"/>
		  			<xsl:when test="name()='altx'"/>
		  			<xsl:when test="name()='title'"/>
		  			<xsl:when test="name()='imgwidth'"/>
		  			<xsl:when test="name()='imgheight'"/>
		  			<xsl:when test="name()='background'"/>
		  			<xsl:when test="name()='border'"/>
		  			<xsl:when test="name()='id'"/>
		  			<xsl:when test="name()='imgclass'"/>
		  			<xsl:when test="name()='path'"/>
		  			<xsl:when test="name()='imgpath'"/>
		  			<xsl:when test="name()='imgalign'"/>
		  			<xsl:when test="name()='hspace'"/>
		  			<xsl:when test="name()='vspace'"/>
					<xsl:otherwise>
						 <xsl:call-template name="Error">
							  <xsl:with-param name="msg" select="'WTIMAGE[WTLINK] Invalid Attribute'"/>
							  <xsl:with-param name="text" select="name()"/>
	 					</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose>
		   </xsl:if>
	 </xsl:for-each>
	 <!-- ****************************************************-->

		<!--begin the column tag-->
		<xsl:if test="@col">
			<xsl:apply-templates select="." mode="cell-begin">
				<xsl:with-param name="indent" select="$indent"/>
				<xsl:with-param name="wrap" select="$wrap"/>
				<xsl:with-param name="isfirst" select="position()=1"/>
			</xsl:apply-templates>
		</xsl:if>

		<!--generate IF statement for conditions if they exist-->
		<xsl:if test="($hasconditions)">
			<xsl:call-template name="XSLConditionStart">
				<xsl:with-param name="indent" select="$indent2"/>
				<xsl:with-param name="conditions" select="WTCONDITION"/>
			</xsl:call-template>
		</xsl:if>

		<xsl:apply-templates select="WTLINK">
			<xsl:with-param name="indent" select="$indent3"/>
			<xsl:with-param name="label">IMG</xsl:with-param>
		</xsl:apply-templates>

		<xsl:if test="($hasconditions)">
			<xsl:call-template name="XSLConditionEnd">
				<xsl:with-param name="indent" select="$indent2"/>			
			</xsl:call-template>
		</xsl:if>

		<!--end the column tag-->
		<xsl:if test="@col">
			<xsl:apply-templates select="." mode="cell-end">
				<xsl:with-param name="indent" select="$indent"/>
				<xsl:with-param name="wrap" select="$wrap"/>
				<xsl:with-param name="islast" select="position()=last()"/>
			</xsl:apply-templates>
		</xsl:if>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTIMAGE">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:param name="wrap" select="false()"/>
		<xsl:variable name="hasconditions" select="(count(WTCONDITION) > 0)"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="ind2" select="concat($ind1, $tab1)"/>
		<xsl:variable name="indent2" select="$indent+1"/>
		<xsl:variable name="ind3"><xsl:choose><xsl:when test="$hasconditions"><xsl:value-of select="concat($ind2, $tab1)"/></xsl:when><xsl:otherwise><xsl:value-of select="$ind2"/></xsl:otherwise></xsl:choose></xsl:variable>
		<xsl:variable name="indent3"><xsl:choose><xsl:when test="$hasconditions"><xsl:value-of select="$indent2 +1"/></xsl:when><xsl:otherwise><xsl:value-of select="$indent2"/></xsl:otherwise></xsl:choose></xsl:variable>

	 <!-- ***************** Error Checking *******************-->
	<xsl:if test="not(ancestor::WTSTATIC) and not(ancestor::WTDIVISION) and not(ancestor::WTCODEGROUP)">
		<xsl:if test="not(@col)">
		    <xsl:call-template name="Error">
		    	<xsl:with-param name="msg" select="'WTIMAGE Column Missing'"/>
		    	<xsl:with-param name="text" select="position()"/>
		    </xsl:call-template>
		</xsl:if>
	 </xsl:if>
	 <!--Test valid attributes-->
	 <xsl:for-each select="@*">
			<xsl:variable name="testcol">
				<xsl:call-template name="TestColAttr">
					<xsl:with-param name="attr" select="name()"/>
				</xsl:call-template>
			</xsl:variable>
		   <xsl:if test="$testcol='0'">
				<xsl:choose>
		  			<xsl:when test="name()='alt'"/>
		  			<xsl:when test="name()='altx'"/>
            <xsl:when test="name()='title'"/>
            <xsl:when test="name()='titlex'"/>
            <xsl:when test="name()='imgwidth'"/>
		  			<xsl:when test="name()='imgheight'"/>
		  			<xsl:when test="name()='imgalign'"/>
		  			<xsl:when test="name()='background'"/>
		  			<xsl:when test="name()='border'"/>
		  			<xsl:when test="name()='id'"/>
		  			<xsl:when test="name()='name'"/>
		  			<xsl:when test="name()='imgclass'"/>
		  			<xsl:when test="name()='path'"/>
		  			<xsl:when test="name()='imgpath'"/>
		  			<xsl:when test="name()='usemap'"/>
		  			<xsl:when test="name()='hspace'"/>
					<xsl:when test="name()='vspace'"/>
          <xsl:when test="name()='style'"/>
          <xsl:otherwise>
						 <xsl:call-template name="Error">
							  <xsl:with-param name="msg" select="'WTIMAGE Invalid Attribute'"/>
							  <xsl:with-param name="text" select="name()"/>
	 					</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose>
		   </xsl:if>
	 </xsl:for-each>
	 <!-- ****************************************************-->

		<!--begin the column tag-->
		<xsl:if test="@col">
			<xsl:apply-templates select="." mode="cell-begin">
				<xsl:with-param name="indent" select="$indent"/>
				<xsl:with-param name="wrap" select="$wrap"/>
				<xsl:with-param name="isfirst" select="position()=1"/>
			</xsl:apply-templates>
		</xsl:if>

		<!--generate IF statement for conditions if they exist-->
		<xsl:if test="($hasconditions)">
			<xsl:call-template name="XSLConditionStart">
				<xsl:with-param name="indent" select="$indent2"/>
				<xsl:with-param name="conditions" select="WTCONDITION"/>
			</xsl:call-template>
		</xsl:if>

		<!--begin the image tag-->
		<xsl:call-template name="XSLImage">
			<xsl:with-param name="indent" select="$indent3"/>
			<xsl:with-param name="image" select="."/>
		</xsl:call-template>

		<xsl:if test="($hasconditions)">
			<xsl:call-template name="XSLConditionEnd">
				<xsl:with-param name="indent" select="$indent2"/>			
			</xsl:call-template>
		</xsl:if>

		<!--end the column tag-->
		<xsl:if test="@col">
			<xsl:apply-templates select="." mode="cell-end">
				<xsl:with-param name="indent" select="$indent"/>
				<xsl:with-param name="wrap" select="$wrap"/>
				<xsl:with-param name="islast" select="position()=last()"/>
			</xsl:apply-templates>
		</xsl:if>
	</xsl:template>

	 <!--==================================================================-->
	 <xsl:template name="XSLImage">
	 <!--==================================================================-->
		  <xsl:param name="indent"/>
		  <xsl:param name="image"/>
		  <xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		  <xsl:variable name="ind2" select="concat($ind1, $tab1)"/>
		  <xsl:variable name="indent2" select="$indent+1"/>
		  <xsl:variable name="valuetype"><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="$image/@value"/></xsl:call-template></xsl:variable>
		  <xsl:variable name="valuetext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="$image/@value"/></xsl:call-template></xsl:variable>
		  <xsl:variable name="valueentity"><xsl:call-template name="QualifiedPrefix"><xsl:with-param name="value" select="$image/@value"/></xsl:call-template></xsl:variable>
		  <xsl:variable name="pathtype"><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="$image/@path"/></xsl:call-template></xsl:variable>
		  <xsl:variable name="pathtext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="$image/@path"/></xsl:call-template></xsl:variable>
		  <xsl:variable name="pathentity"><xsl:call-template name="QualifiedPrefix"><xsl:with-param name="value" select="$image/@path"/></xsl:call-template></xsl:variable>

		  <xsl:value-of select="concat($ind1, '&lt;xsl:element name=&quot;IMG&quot;&gt;', $cr)"/>

			<xsl:if test="$image/@value">
				<xsl:if test="$image/@imgpath">
					<xsl:value-of select="concat($ind2, '&lt;xsl:attribute name=&quot;src&quot;&gt;',$image/@imgpath )"/>
				</xsl:if>
				<xsl:if test="not($image/@imgpath)">
					<xsl:value-of select="concat($ind2, '&lt;xsl:attribute name=&quot;src&quot;&gt;Images/')"/>
				</xsl:if>
				<xsl:if test="$image/@path">
					<xsl:call-template name="GetValue">
						<xsl:with-param name="type" select="$pathtype"/>
						<xsl:with-param name="text" select="$pathtext"/>
						<xsl:with-param name="entity" select="$pathentity"/>
					</xsl:call-template>
				  <xsl:value-of select="'/'"/>
				</xsl:if>

				<xsl:call-template name="GetValue">
				<xsl:with-param name="type" select="$valuetype"/>
				<xsl:with-param name="text" select="$valuetext"/>
				<xsl:with-param name="entity" select="$valueentity"/>
				<xsl:with-param name="hidden" select="true()"/>
				</xsl:call-template>
						  
				<xsl:value-of select="concat('&lt;/xsl:attribute&gt;', $cr)"/>
			</xsl:if>

		  <xsl:if test="$image/@imgwidth">
				<xsl:value-of select="concat($ind2, '&lt;xsl:attribute name=&quot;width&quot;&gt;', $image/@imgwidth, '&lt;/xsl:attribute&gt;', $cr)"/>
		  </xsl:if>
		  <xsl:if test="$image/@imgheight">
				<xsl:value-of select="concat($ind2, '&lt;xsl:attribute name=&quot;height&quot;&gt;', $image/@imgheight, '&lt;/xsl:attribute&gt;', $cr)"/>
		  </xsl:if>
		  <xsl:if test="$image/@hspace">
				<xsl:value-of select="concat($ind2, '&lt;xsl:attribute name=&quot;hspace&quot;&gt;', $image/@hspace, '&lt;/xsl:attribute&gt;', $cr)"/>
		  </xsl:if>
		  <xsl:if test="$image/@vhspace">
				<xsl:value-of select="concat($ind2, '&lt;xsl:attribute name=&quot;vspace&quot;&gt;', $image/@vspace, '&lt;/xsl:attribute&gt;', $cr)"/>
		  </xsl:if>
		  <xsl:if test="$image/@id">
				<xsl:value-of select="concat($ind2, '&lt;xsl:attribute name=&quot;id&quot;&gt;', $image/@id, '&lt;/xsl:attribute&gt;', $cr)"/>
		  </xsl:if>
		  <xsl:if test="$image/@name">
				<xsl:value-of select="concat($ind2, '&lt;xsl:attribute name=&quot;name&quot;&gt;', $image/@name, '&lt;/xsl:attribute&gt;', $cr)"/>
		  </xsl:if>
		  <xsl:if test="$image/@imgclass">
				<xsl:value-of select="concat($ind2, '&lt;xsl:attribute name=&quot;class&quot;&gt;', $image/@imgclass, '&lt;/xsl:attribute&gt;', $cr)"/>
		  </xsl:if>
		  <xsl:if test="$image/@imgalign">
				<xsl:value-of select="concat($ind2, '&lt;xsl:attribute name=&quot;align&quot;&gt;', $image/@imgalign, '&lt;/xsl:attribute&gt;', $cr)"/>
		  </xsl:if>
		 <xsl:if test="$image/@usemap">
			 <xsl:value-of select="concat($ind2, '&lt;xsl:attribute name=&quot;usemap&quot;&gt;', '#', $image/@usemap, '&lt;/xsl:attribute&gt;', $cr)"/>
		 </xsl:if>
     <xsl:if test="$image/@style">
       <xsl:value-of select="concat($ind2, '&lt;xsl:attribute name=&quot;style&quot;&gt;', '#', $image/@style, '&lt;/xsl:attribute&gt;', $cr)"/>
     </xsl:if>
     <xsl:choose>
				<xsl:when test="$image/@border"><xsl:value-of select="concat($ind2, '&lt;xsl:attribute name=&quot;border&quot;&gt;', $image/@border, '&lt;/xsl:attribute&gt;', $cr)"/></xsl:when>
				<xsl:otherwise><xsl:value-of select="concat($ind2, '&lt;xsl:attribute name=&quot;border&quot;&gt;0&lt;/xsl:attribute&gt;', $cr)"/></xsl:otherwise>
		  </xsl:choose>
		  
		<xsl:if test="$image/@alt">
			<xsl:value-of select="concat($ind2, '&lt;xsl:attribute name=&quot;alt&quot;&gt;')"/>
			<xsl:call-template name="XSLLabelText">
				<xsl:with-param name="label" select="$image/@alt"/>
				<xsl:with-param name="newline" select="false()"/>
			</xsl:call-template>
			<xsl:value-of select="concat('&lt;/xsl:attribute&gt;', $cr)"/>
			<xsl:if test="not($image/@title)">
				<xsl:value-of select="concat($ind2, '&lt;xsl:attribute name=&quot;title&quot;&gt;')"/>
				<xsl:call-template name="XSLLabelText">
					<xsl:with-param name="label" select="$image/@alt"/>
					<xsl:with-param name="newline" select="false()"/>
				</xsl:call-template>
				<xsl:value-of select="concat('&lt;/xsl:attribute&gt;', $cr)"/>
			</xsl:if>
		</xsl:if>
		<xsl:if test="$image/@altx">
			<xsl:value-of select="concat($ind2, '&lt;xsl:attribute name=&quot;alt&quot;&gt;', $image/@altx, '&lt;/xsl:attribute&gt;', $cr)"/>
			<xsl:if test="not($image/@title)">
				<xsl:value-of select="concat($ind2, '&lt;xsl:attribute name=&quot;title&quot;&gt;', $image/@altx, '&lt;/xsl:attribute&gt;', $cr)"/>
			</xsl:if>
		</xsl:if>
		<xsl:if test="$image/@title">
			<xsl:value-of select="concat($ind2, '&lt;xsl:attribute name=&quot;title&quot;&gt;')"/>
			<xsl:call-template name="XSLLabelText">
				<xsl:with-param name="label" select="$image/@title"/>
				<xsl:with-param name="newline" select="false()"/>
			</xsl:call-template>
			<xsl:value-of select="concat('&lt;/xsl:attribute&gt;', $cr)"/>
		</xsl:if>
     <xsl:if test="$image/@titlex">
       <xsl:value-of select="concat($ind2, '&lt;xsl:attribute name=&quot;title&quot;&gt;', $image/@titlex, '&lt;/xsl:attribute&gt;', $cr)"/>
     </xsl:if>

     <xsl:apply-templates select="$image/WTLOAD">
		  	<xsl:with-param name="indent" select="$indent2"/>
		  </xsl:apply-templates>

		  <xsl:apply-templates select="$image/WTCLICK">
		  	<xsl:with-param name="indent" select="$indent2"/>
		  </xsl:apply-templates>

		<xsl:value-of select="concat($ind1, '&lt;/xsl:element&gt;', $cr)"/>
	 </xsl:template>

  <!--==================================================================-->
  <xsl:template match="WTOSMAP">
    <!--==================================================================-->
    <xsl:param name="indent"/>
    <xsl:param name="wrap" select="false()"/>
    <xsl:variable name="ind1">
      <xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template>
    </xsl:variable>
    <xsl:variable name="ind2" select="concat($ind1, $tab1)"/>
    <xsl:variable name="indent2" select="$indent+1"/>

    <xsl:variable name="token">
      <xsl:choose>
        <xsl:when test="@token"><xsl:value-of select="@token"/></xsl:when>
        <xsl:otherwise>pk.eyJ1IjoibWFwYm94IiwiYSI6ImNpandmbXliNDBjZWd2M2x6bDk3c2ZtOTkifQ._QA7i5Mpkd_m30IGElHziw</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="zoom">
      <xsl:choose>
        <xsl:when test="@zoom"><xsl:value-of select="@zoom"/></xsl:when>
        <xsl:otherwise>13</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="maxzoom">
      <xsl:choose>
        <xsl:when test="@maxzoom"><xsl:value-of select="@maxzoom"/></xsl:when>
        <xsl:otherwise>18</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="attribution">
      <xsl:choose>
        <xsl:when test="@attribution"><xsl:value-of select="@attribution"/></xsl:when>
        <xsl:otherwise>OpenStreetMap Contributors</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="latitude">
      <xsl:choose>
        <xsl:when test="@latitude">
				  <xsl:variable name="valuetype"><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="@latitude"/></xsl:call-template></xsl:variable>
				  <xsl:variable name="valuetext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@latitude"/></xsl:call-template></xsl:variable>
				  <xsl:call-template name="GetValue">
					   <xsl:with-param name="type" select="$valuetype"/>
					   <xsl:with-param name="text" select="$valuetext"/>
					   <xsl:with-param name="hidden" select="true()"/>
				  </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>51.505</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="longitude">
      <xsl:choose>
        <xsl:when test="@longitude">
				  <xsl:variable name="valuetype"><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="@longitude"/></xsl:call-template></xsl:variable>
				  <xsl:variable name="valuetext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@longitude"/></xsl:call-template></xsl:variable>
				  <xsl:call-template name="GetValue">
					   <xsl:with-param name="type" select="$valuetype"/>
					   <xsl:with-param name="text" select="$valuetext"/>
					   <xsl:with-param name="hidden" select="true()"/>
				  </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>-0.09</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <!--Test valid attributes-->
    <xsl:for-each select="@*">
      <xsl:variable name="testcol">
        <xsl:call-template name="TestColAttr">
          <xsl:with-param name="attr" select="name()"/>
        </xsl:call-template>
      </xsl:variable>
      <xsl:if test="$testcol='0'">
        <xsl:choose>
          <xsl:when test="name()='id'"/>
          <xsl:when test="name()='style'"/>
          <xsl:when test="name()='latitude'"/>
          <xsl:when test="name()='longitude'"/>
          <xsl:when test="name()='token'"/>
          <xsl:when test="name()='zoom'"/>
          <xsl:when test="name()='maxzoom'"/>
          <xsl:when test="name()='marker'"/>
          <xsl:when test="name()='attribution'"/>
          <xsl:when test="name()='fullscreen'"/>
          <xsl:otherwise>
            <xsl:call-template name="Error">
              <xsl:with-param name="msg" select="'WTOSMAP Invalid Attribute'"/>
              <xsl:with-param name="text" select="name()"/>
            </xsl:call-template>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:if>
    </xsl:for-each>
    <!-- ****************************************************-->

    <xsl:value-of select="concat($ind1, '&lt;xsl:element name=&quot;DIV&quot;&gt;', $cr)"/>

    <xsl:if test="@id">
      <xsl:value-of select="concat($ind2, '&lt;xsl:attribute name=&quot;id&quot;&gt;', @id, '&lt;/xsl:attribute&gt;', $cr)"/>
    </xsl:if>
    <xsl:if test="@style">
      <xsl:value-of select="concat($ind2, '&lt;xsl:attribute name=&quot;style&quot;&gt;', @style, '&lt;/xsl:attribute&gt;', $cr)"/>
    </xsl:if>
    <xsl:value-of select="concat($ind1, '&lt;/xsl:element&gt;', $cr)"/>

    <xsl:value-of select="concat($ind1, '&lt;xsl:element name=&quot;script&quot;&gt;', $cr)"/>
    <xsl:value-of select="concat($ind2, 'var mymap = L.map(&quot;', @id, '&quot;).setView([', $latitude, ', ', $longitude, '], ', $zoom, ');', $cr)"/>
    <xsl:value-of select="concat($ind2, 'L.tileLayer(&quot;https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token=', $token, '&quot;, {', $cr)"/>
    <xsl:value-of select="concat($ind2, 'maxZoom: ', $maxzoom, ',', $cr)"/>
    <xsl:value-of select="concat($ind2, 'attribution: &quot;', $attribution, '&quot;,', $cr)"/>
    <xsl:value-of select="concat($ind2, 'id: &quot;mapbox.streets&quot;', $cr)"/>
    <xsl:value-of select="concat($ind2, '}).addTo(mymap);', $cr)"/>
    <xsl:value-of select="concat($ind2, 'mymap.attributionControl.setPrefix(false);', $cr)"/>
    <xsl:if test="@fullscreen">
      <xsl:value-of select="concat($ind2, 'var fsControl = new L.Control.FullScreen();', $cr)"/>
      <xsl:value-of select="concat($ind2, 'mymap.addControl(fsControl);', $cr)"/>
    </xsl:if>
    <xsl:if test="@marker">
      <xsl:value-of select="concat($ind2, 'L.marker([', $latitude, ', ', $longitude, ']).addTo(mymap);', $cr)"/>
    </xsl:if>
    <xsl:value-of select="concat($ind1, '&lt;/xsl:element&gt;', $cr)"/>

  </xsl:template>

  <!--==================================================================-->
	<xsl:template match="WTMAP">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:param name="wrap" select="false()"/>
		<xsl:variable name="hasconditions" select="(count(WTCONDITION) > 0)"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="ind2" select="concat($ind1, $tab1)"/>
		<xsl:variable name="indent2" select="$indent+1"/>
		<xsl:variable name="ind3"><xsl:choose><xsl:when test="$hasconditions"><xsl:value-of select="concat($ind2, $tab1)"/></xsl:when><xsl:otherwise><xsl:value-of select="$ind2"/></xsl:otherwise></xsl:choose></xsl:variable>
		<xsl:variable name="indent3"><xsl:choose><xsl:when test="$hasconditions"><xsl:value-of select="$indent2 +1"/></xsl:when><xsl:otherwise><xsl:value-of select="$indent2"/></xsl:otherwise></xsl:choose></xsl:variable>

	 <!-- ***************** Error Checking *******************-->
	<xsl:if test="not(@col)">
	    <xsl:call-template name="Error">
	    	<xsl:with-param name="msg" select="'WTMAP Column Missing'"/>
	    	<xsl:with-param name="text" select="position()"/>
	    </xsl:call-template>
	</xsl:if>

	 <!--Test valid attributes-->
	 <xsl:for-each select="@*">
			<xsl:variable name="testcol">
				<xsl:call-template name="TestColAttr">
					<xsl:with-param name="attr" select="name()"/>
				</xsl:call-template>
			</xsl:variable>
		   <xsl:if test="$testcol='0'">
				<xsl:choose>
		  			<xsl:when test="name()='areahtml'"/>
		  			<xsl:when test="name()='id'"/>
		  			<xsl:when test="name()='name'"/>
					<xsl:otherwise>
						 <xsl:call-template name="Error">
							  <xsl:with-param name="msg" select="'WTMAP Invalid Attribute'"/>
							  <xsl:with-param name="text" select="name()"/>
	 					</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose>
		   </xsl:if>
	 </xsl:for-each>
	 <!-- ****************************************************-->

		<!--begin the column tag-->
		<xsl:if test="@col">
			<xsl:apply-templates select="." mode="cell-begin">
				<xsl:with-param name="indent" select="$indent"/>
				<xsl:with-param name="wrap" select="$wrap"/>
				<xsl:with-param name="isfirst" select="position()=1"/>
			</xsl:apply-templates>
		</xsl:if>

		<!--generate IF statement for conditions if they exist-->
		<xsl:if test="($hasconditions)">
			<xsl:call-template name="XSLConditionStart">
				<xsl:with-param name="indent" select="$indent2"/>
				<xsl:with-param name="conditions" select="WTCONDITION"/>
			</xsl:call-template>
		</xsl:if>

		<!--begin the map tag-->
		<xsl:call-template name="XSLMap">
			<xsl:with-param name="indent" select="$indent3"/>
			<xsl:with-param name="map" select="."/>
		</xsl:call-template>

		<xsl:if test="($hasconditions)">
			<xsl:call-template name="XSLConditionEnd">
				<xsl:with-param name="indent" select="$indent2"/>			
			</xsl:call-template>
		</xsl:if>

		<!--end the column tag-->
		<xsl:if test="@col">
			<xsl:apply-templates select="." mode="cell-end">
				<xsl:with-param name="indent" select="$indent"/>
				<xsl:with-param name="wrap" select="$wrap"/>
				<xsl:with-param name="islast" select="position()=last()"/>
			</xsl:apply-templates>
		</xsl:if>
	</xsl:template>
	
	<!--==================================================================-->
	 <xsl:template name="XSLMap">
	 <!--==================================================================-->
		  <xsl:param name="indent"/>
		  <xsl:param name="map"/>
		  <xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		  <xsl:variable name="ind2" select="concat($ind1, $tab1)"/>
		  <xsl:variable name="indent2" select="$indent+1"/>
		  <xsl:variable name="areahtmltype"><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="$map/@areahtml"/></xsl:call-template></xsl:variable>
		  <xsl:variable name="areahtmltext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="$map/@areahtml"/></xsl:call-template></xsl:variable>
		  <xsl:variable name="areahtmlentity"><xsl:call-template name="QualifiedPrefix"><xsl:with-param name="value" select="$map/@areahtml"/></xsl:call-template></xsl:variable>

		  <xsl:value-of select="concat($ind1, '&lt;xsl:element name=&quot;MAP&quot;&gt;', $cr)"/>

		  <xsl:if test="$map/@id">
				<xsl:value-of select="concat($ind2, '&lt;xsl:attribute name=&quot;id&quot;&gt;', $map/@id, '&lt;/xsl:attribute&gt;', $cr)"/>
		  </xsl:if>
		  <xsl:if test="$map/@name">
				<xsl:value-of select="concat($ind2, '&lt;xsl:attribute name=&quot;name&quot;&gt;', $map/@name, '&lt;/xsl:attribute&gt;', $cr)"/>
		  </xsl:if>
		  <xsl:if test="$map/@areahtml">
				<xsl:call-template name="GetValue">
					<xsl:with-param name="type" select="$areahtmltype"/>
					<xsl:with-param name="text" select="$areahtmltext"/>
					<xsl:with-param name="entity" select="$areahtmlentity"/>
					<xsl:with-param name="output" select="true()"/>
				</xsl:call-template>
		  </xsl:if>
		  	
		  <xsl:apply-templates select="$map/WTCLICK">
		  	<xsl:with-param name="indent" select="$indent2"/>
		  </xsl:apply-templates>

		<xsl:value-of select="concat($ind1, '&lt;/xsl:element&gt;', $cr)"/>
	 </xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTTEXT">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:param name="wrap" select="false()"/>
		<xsl:variable name="hasconditions" select="(count(WTCONDITION) > 0)"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="ind2" select="concat($ind1, $tab1)"/>
		<xsl:variable name="indent2" select="$indent+1"/>
		<xsl:variable name="ind3"><xsl:choose><xsl:when test="$hasconditions"><xsl:value-of select="concat($ind2, $tab1)"/></xsl:when><xsl:otherwise><xsl:value-of select="$ind2"/></xsl:otherwise></xsl:choose></xsl:variable>
		<xsl:variable name="indent3"><xsl:choose><xsl:when test="$hasconditions"><xsl:value-of select="$indent2 +1"/></xsl:when><xsl:otherwise><xsl:value-of select="$indent2"/></xsl:otherwise></xsl:choose></xsl:variable>
		<xsl:variable name="valuetype"><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>
		<xsl:variable name="valuetext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>
		<xsl:variable name="valueentity"><xsl:call-template name="QualifiedPrefix"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>
		<xsl:variable name="attribute" select="/Data/WTENTITY/WTATTRIBUTE[@name=$valuetext]"/>

	 <!--***************** Error Checking *******************-->
	<xsl:if test="not(ancestor::WTSTATIC)">
		<xsl:if test="not(@col)">
		    <xsl:call-template name="Error">
		    	<xsl:with-param name="msg" select="'WTTEXT Column Missing'"/>
		    	<xsl:with-param name="text" select="position()"/>
		    </xsl:call-template>
		</xsl:if>
	 </xsl:if>

	 <!--Test valid attributes-->
	 <xsl:for-each select="@*">
			<xsl:variable name="testcol">
				<xsl:call-template name="TestColAttr">
					<xsl:with-param name="attr" select="name()"/>
				</xsl:call-template>
			</xsl:variable>
		   <xsl:if test="$testcol='0'">
				<xsl:choose>
		  			<xsl:when test="name()='name'"/>
		  			<xsl:when test="name()='size'"/>
		  			<xsl:when test="name()='width'"/>
		  			<xsl:when test="name()='type'"/>
		  			<xsl:when test="name()='height'"/>
		  			<xsl:when test="name()='label'"/>
		  			<xsl:when test="name()='required'"/>
		  			<xsl:when test="name()='disabled'"/>
		  			<xsl:when test="name()='readonly'"/>
		  			<xsl:when test="name()='secure'"/>
		  			<xsl:when test="name()='maxlength'"/>
		  			<xsl:when test="name()='datapath'"/>
		  			<xsl:when test="name()='style'"/>
		  			<xsl:when test="name()='textclass'"/>
		  			<xsl:when test="name()='data'"/>
					<xsl:otherwise>
						 <xsl:call-template name="Error">
							  <xsl:with-param name="msg" select="'WTTEXT Invalid Attribute'"/>
							  <xsl:with-param name="text" select="name()"/>
	 					</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose>
		   </xsl:if>
	 </xsl:for-each>
	 <!-- ****************************************************-->

		<!--begin the column tag-->
		<xsl:if test="@col">
			<xsl:apply-templates select="." mode="cell-begin">
				<xsl:with-param name="indent" select="$indent"/>
				<xsl:with-param name="wrap" select="$wrap"/>
				<xsl:with-param name="isfirst" select="position()=1"/>
			</xsl:apply-templates>
		</xsl:if>

		<!--generate IF statement for conditions if they exist-->
		<xsl:if test="($hasconditions)">
			<xsl:call-template name="XSLConditionStart">
				<xsl:with-param name="indent" select="$indent2"/>
				<xsl:with-param name="conditions" select="WTCONDITION"/>
			</xsl:call-template>
		</xsl:if>

		<xsl:variable name="maxlen">
			<xsl:if test="@maxlength"><xsl:value-of select="@maxlength"/></xsl:if>
			<xsl:if test="not(@maxlength) and $attribute/@type='text'">
				<xsl:choose>
					<xsl:when test="$attribute"><xsl:value-of select="$attribute/@length"/></xsl:when>
					<xsl:otherwise>0</xsl:otherwise>
				</xsl:choose>
			</xsl:if>
		</xsl:variable>

		<!--build the input control-->
		<xsl:value-of select="concat($ind2, '&lt;xsl:element name=&quot;INPUT&quot;&gt;', $cr)"/>
		<xsl:if test="@textclass">
			<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;class&quot;&gt;', @textclass, '&lt;/xsl:attribute&gt;', $cr)"/>
		</xsl:if>
		<xsl:choose>
			<xsl:when test="$valuetype='PARAM'">
				<xsl:variable name="type">
					<xsl:choose>
						<xsl:when test="@secure='true'">password</xsl:when>
						<xsl:otherwise>text</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>
				<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;type&quot;&gt;', $type, '&lt;/xsl:attribute&gt;', $cr)"/>
				<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;name&quot;&gt;', $valuetext, '&lt;/xsl:attribute&gt;', $cr)"/>
				<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;id&quot;&gt;', $valuetext, '&lt;/xsl:attribute&gt;', $cr)"/>
				<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;value&quot;&gt;')"/>
				<xsl:call-template name="GetValue">
					 <xsl:with-param name="type" select="$valuetype"/>
					 <xsl:with-param name="text" select="$valuetext"/>
					 <xsl:with-param name="entity" select="$valueentity"/>
				</xsl:call-template>
				<xsl:value-of select="concat('&lt;/xsl:attribute&gt;', $cr)"/>
				<xsl:if test="$maxlen&gt;0">
					<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;maxlength&quot;&gt;', $maxlen, '&lt;/xsl:attribute&gt;', $cr)"/>
				</xsl:if>
			</xsl:when>
			
			<xsl:when test="$valuetype='ATTR'">
				<xsl:variable name="type">
					<xsl:choose>
						<xsl:when test="($attribute/@type='password' or @secure='true') and not(@secure='false')">password</xsl:when>
						<xsl:otherwise>text</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>
				<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;type&quot;&gt;', $type, '&lt;/xsl:attribute&gt;', $cr)"/>
				<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;name&quot;&gt;', $valuetext, '&lt;/xsl:attribute&gt;', $cr)"/>
				<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;id&quot;&gt;', $valuetext, '&lt;/xsl:attribute&gt;', $cr)"/>
				<xsl:variable name="size">
					<xsl:choose>
						<xsl:when test="@size"><xsl:value-of select="@size"/></xsl:when>
						<xsl:when test="($attribute/@type='date')">10</xsl:when>
						<xsl:when test="($attribute/@type='small number')">4</xsl:when>
						<xsl:when test="($attribute/@type='number')">10</xsl:when>
            <xsl:when test="($attribute/@type='big number')">20</xsl:when>
            <xsl:when test="($attribute/@type='tiny number')">4</xsl:when>
						<xsl:when test="($attribute/@length > 40)">40</xsl:when>
						<xsl:when test="($attribute/@length)"><xsl:value-of select="/Data/WTENTITY/WTATTRIBUTE[@name=$valuetext]/@length"/></xsl:when>
						<xsl:otherwise>15</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>
				<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;size&quot;&gt;', $size, '&lt;/xsl:attribute&gt;', $cr)"/>
				<xsl:if test="$maxlen&gt;0">
					<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;maxlength&quot;&gt;', $maxlen, '&lt;/xsl:attribute&gt;', $cr)"/>
				</xsl:if>
				<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;value&quot;&gt;')"/>

				<xsl:if test="@datapath">
					<xsl:value-of select="concat('&lt;xsl:value-of select=&quot;', @datapath, '&quot;/&gt;')"/>
				</xsl:if>
				<xsl:if test="not(@datapath)">
					<xsl:call-template name="XSLDataField">
						<xsl:with-param name="entity" select="$valueentity"/>
						<xsl:with-param name="name" select="$valuetext"/>
						<xsl:with-param name="newline" select="false()"/>
					</xsl:call-template>
				</xsl:if>
				
				<xsl:value-of select="concat('&lt;/xsl:attribute&gt;', $cr)"/>
			</xsl:when>
			<xsl:when test="$valuetype='DATA'">
				<xsl:if test="@name">
					<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;type&quot;&gt;text&lt;/xsl:attribute&gt;', $cr)"/>
					<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;name&quot;&gt;', @name, '&lt;/xsl:attribute&gt;', $cr)"/>
					<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;id&quot;&gt;', @name, '&lt;/xsl:attribute&gt;', $cr)"/>
				</xsl:if>
				<xsl:if test="$maxlen&gt;0">
					<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;maxlength&quot;&gt;', $maxlen, '&lt;/xsl:attribute&gt;', $cr)"/>
				</xsl:if>
				<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;value&quot;&gt;&lt;xsl:value-of select=&quot;', $valuetext, '&quot;/&gt;&lt;/xsl:attribute&gt;', $cr)"/>
			</xsl:when>
			<xsl:when test="$valuetype='CONST'">
				<xsl:if test="@name">
          <xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;type&quot;&gt;text&lt;/xsl:attribute&gt;', $cr)"/>
          <xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;name&quot;&gt;', @name, '&lt;/xsl:attribute&gt;', $cr)"/>
					<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;id&quot;&gt;', @name, '&lt;/xsl:attribute&gt;', $cr)"/>
					<xsl:if test="@secure='true'">
						<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;type&quot;&gt;password&lt;/xsl:attribute&gt;', $cr)"/>
					</xsl:if>
				</xsl:if>
				<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;value&quot;&gt;', $valuetext, '&lt;/xsl:attribute&gt;', $cr)"/>
				<xsl:if test="@maxlength">
					<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;maxlength&quot;&gt;', @maxlength, '&lt;/xsl:attribute&gt;', $cr)"/>
				</xsl:if>
			</xsl:when>
			<xsl:when test="$valuetype='NONE'">
				<xsl:if test="@name">
          <xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;type&quot;&gt;text&lt;/xsl:attribute&gt;', $cr)"/>
          <xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;name&quot;&gt;', @name, '&lt;/xsl:attribute&gt;', $cr)"/>
					<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;id&quot;&gt;', @name, '&lt;/xsl:attribute&gt;', $cr)"/>
					<xsl:if test="@secure='true'">
						<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;type&quot;&gt;password&lt;/xsl:attribute&gt;', $cr)"/>
					</xsl:if>
				</xsl:if>
				<xsl:if test="not(@name)">
					<xsl:if test="$valuetext=''">
            <xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;type&quot;&gt;text&lt;/xsl:attribute&gt;', $cr)"/>
            <xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;name&quot;&gt;', $valuetext, '&lt;/xsl:attribute&gt;', $cr)"/>
						<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;id&quot;&gt;', $valuetext, '&lt;/xsl:attribute&gt;', $cr)"/>
						<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;value&quot;&gt;', $valuetext, '&lt;/xsl:attribute&gt;', $cr)"/>
					</xsl:if>
				</xsl:if>
        <xsl:if test="@maxlength">
          <xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;maxlength&quot;&gt;', @maxlength, '&lt;/xsl:attribute&gt;', $cr)"/>
        </xsl:if>
        <xsl:if test="@width">
          <xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;width&quot;&gt;', @width, '&lt;/xsl:attribute&gt;', $cr)"/>
        </xsl:if>
      </xsl:when>
		</xsl:choose>
		<xsl:if test="not($valuetype='ATTR')">
			<xsl:if test="@size">
				<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;size&quot;&gt;', @size, '&lt;/xsl:attribute&gt;', $cr)"/>
			</xsl:if>
		</xsl:if>
		<xsl:if test="@style">
			<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;style&quot;&gt;', @style, '&lt;/xsl:attribute&gt;', $cr)"/>
		</xsl:if>
		  <xsl:apply-templates select="WTENTER">
		  	<xsl:with-param name="indent" select="$indent3"/>
		  </xsl:apply-templates>

		  <xsl:apply-templates select="WTKEY">
		  	<xsl:with-param name="indent" select="$indent3"/>
		  </xsl:apply-templates>

		  <xsl:apply-templates select="WTCHANGE">
		  	<xsl:with-param name="indent" select="$indent3"/>
		  </xsl:apply-templates>

		  <xsl:apply-templates select="WTEXIT">
		  	<xsl:with-param name="indent" select="$indent3"/>
		  </xsl:apply-templates>

		  <!--disable the field if specified-->
		  <xsl:if test="@disabled">
				<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;DISABLED&quot;/&gt;', $cr)"/>
		  </xsl:if>

		  <xsl:if test="@readonly">
				<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;READONLY&quot;/&gt;', $cr)"/>
		  </xsl:if>
<!--
		<xsl:apply-templates select="." mode="read-only">
			<xsl:with-param name="indent" select="$indent3"/>
		</xsl:apply-templates>
-->
		<xsl:value-of select="concat($ind2, '&lt;/xsl:element&gt;', $cr)"/>

		<!--date popup for date fields-->
		<xsl:if test="($attribute/@type='date') or (@type='date')">
			<xsl:apply-templates select="." mode="calendar">
				<xsl:with-param name="indent" select="$indent2"/>
			</xsl:apply-templates>
		</xsl:if>

		<!--required field indicator-->
		<xsl:if test="not(@required='false') and (@required='true' or $attribute/@required='true')">
			<xsl:apply-templates select="." mode="require-mark">
				<xsl:with-param name="indent" select="$indent2"/>
			</xsl:apply-templates>
		</xsl:if>

		<!--language field indicator-->
		<xsl:if test="$attribute/@language='true' and not($attribute/WTJOIN)">
			<xsl:apply-templates select="." mode="language-mark">
				<xsl:with-param name="indent" select="$indent2"/>
			</xsl:apply-templates>
		</xsl:if>

		<xsl:if test="($hasconditions)">
			<xsl:call-template name="XSLConditionEnd">
				<xsl:with-param name="indent" select="$indent2"/>			
			</xsl:call-template>
		</xsl:if>

		<!--end the column tag-->
		<xsl:if test="@col">
			<xsl:apply-templates select="." mode="cell-end">
				<xsl:with-param name="indent" select="$indent"/>
				<xsl:with-param name="wrap" select="$wrap"/>
				<xsl:with-param name="islast" select="position()=last()"/>
			</xsl:apply-templates>
		</xsl:if>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTHIDDEN">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:param name="wrap" select="false()"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="ind2" select="concat($ind1, $tab1)"/>
		<xsl:variable name="indent2" select="$indent+1"/>
		<xsl:variable name="ind3" select="concat($ind2, $tab1)"/>
		<xsl:variable name="indent3" select="$indent2+1"/>
		<xsl:variable name="valuetype"><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>
		<xsl:variable name="valuetext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>
		<xsl:variable name="valueentity"><xsl:call-template name="QualifiedPrefix"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>
		<xsl:variable name="attribute" select="/Data/WTENTITY/WTATTRIBUTE[@name=$valuetext]"/>

	 <!-- ***************** Error Checking *******************-->
	 <!--Test valid attributes-->
	 <xsl:if test="not(@value)">
	     <xsl:call-template name="Error">
	     	<xsl:with-param name="msg" select="'WTHIDDEN Value Missing'"/>
	     	<xsl:with-param name="text" select="@name"/>
	     </xsl:call-template>
	 </xsl:if>
	 <xsl:for-each select="@*">
		  <xsl:choose>
		   <xsl:when test="name()='name'"/>
		   <xsl:when test="name()='value'"/>
		  	<xsl:otherwise>
		  		 <xsl:call-template name="Error">
		  			  <xsl:with-param name="msg" select="'WTHIDDEN Invalid Attribute'"/>
		  			  <xsl:with-param name="text" select="name()"/>
	 	  		</xsl:call-template>
		  	</xsl:otherwise>
		  </xsl:choose>
	 </xsl:for-each>
	 <!-- ****************************************************-->

		<!--build the input control-->
		<xsl:value-of select="concat($ind2, '&lt;xsl:element name=&quot;INPUT&quot;&gt;', $cr)"/>
		<xsl:choose>
			<xsl:when test="$valuetype='ATTR'">
				<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;type&quot;&gt;', 'hidden', '&lt;/xsl:attribute&gt;', $cr)"/>
				<xsl:if test="not(@name)">
					<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;name&quot;&gt;', $valuetext, '&lt;/xsl:attribute&gt;', $cr)"/>
					<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;id&quot;&gt;', $valuetext, '&lt;/xsl:attribute&gt;', $cr)"/>
				</xsl:if>
				<xsl:if test="@name">
					<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;name&quot;&gt;', @name, '&lt;/xsl:attribute&gt;', $cr)"/>
					<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;id&quot;&gt;', @name, '&lt;/xsl:attribute&gt;', $cr)"/>
				</xsl:if>
				<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;value&quot;&gt;')"/>
				<xsl:call-template name="XSLDataField">
					<xsl:with-param name="entity" select="$valueentity"/>
					<xsl:with-param name="name" select="$valuetext"/>
					<xsl:with-param name="newline" select="false()"/>
					<xsl:with-param name="hidden" select="true()"/>
				</xsl:call-template>
				<xsl:value-of select="concat('&lt;/xsl:attribute&gt;', $cr)"/>
			</xsl:when>
			<xsl:when test="$valuetype='PARAM'">
				<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;type&quot;&gt;', 'hidden', '&lt;/xsl:attribute&gt;', $cr)"/>
				<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;name&quot;&gt;', $valuetext, '&lt;/xsl:attribute&gt;', $cr)"/>
				<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;id&quot;&gt;', $valuetext, '&lt;/xsl:attribute&gt;', $cr)"/>
				<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;value&quot;&gt;')"/>
				<xsl:call-template name="GetValue">
					 <xsl:with-param name="type" select="$valuetype"/>
					 <xsl:with-param name="text" select="$valuetext"/>
					 <xsl:with-param name="entity" select="$valueentity"/>
				</xsl:call-template>
				<xsl:value-of select="concat('&lt;/xsl:attribute&gt;', $cr)"/>
			</xsl:when>
			<xsl:when test="$valuetype='CONST'">
				<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;type&quot;&gt;', 'hidden', '&lt;/xsl:attribute&gt;', $cr)"/>
				<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;name&quot;&gt;', @name, '&lt;/xsl:attribute&gt;', $cr)"/>
				<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;id&quot;&gt;', @name, '&lt;/xsl:attribute&gt;', $cr)"/>
				<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;value&quot;&gt;')"/>
				<xsl:value-of select="concat($valuetext, '&lt;/xsl:attribute&gt;', $cr)"/>
			</xsl:when>
		</xsl:choose>

		<xsl:value-of select="concat($ind2, '&lt;/xsl:element&gt;', $cr)"/>

	</xsl:template>

	 <!--==================================================================-->
	 <xsl:template match="WTVARIABLE">
	 <!--==================================================================-->
		  <xsl:param name="indent"/>
		  <xsl:variable name="hasconditions" select="(count(WTCONDITION) > 0)"/>
		  <xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		  <xsl:variable name="ind2"><xsl:choose><xsl:when test="($hasconditions)"><xsl:value-of select="concat($ind1, $tab1)"/></xsl:when><xsl:otherwise><xsl:value-of select="$ind1"/></xsl:otherwise></xsl:choose></xsl:variable>
		  <xsl:variable name="indent2"><xsl:choose><xsl:when test="($hasconditions)"><xsl:value-of select="$indent+1"/></xsl:when><xsl:otherwise><xsl:value-of select="$indent"/></xsl:otherwise></xsl:choose></xsl:variable>

	 <!-- ***************** Error Checking *******************-->
	 <xsl:if test="not(@name)">
	     <xsl:call-template name="Error">
	     	<xsl:with-param name="msg" select="'WTVARIABLE Name Missing'"/>
	     	<xsl:with-param name="text" select="position()"/>
	     </xsl:call-template>
	 </xsl:if>
	 <!--Test valid attributes-->
	 <xsl:for-each select="@*">
		  <xsl:choose>
		   <xsl:when test="name()='name'"/>
		   <xsl:when test="name()='value'"/>
		   <xsl:when test="name()='enum'"/>
		  	<xsl:otherwise>
		  		 <xsl:call-template name="Error">
		  			  <xsl:with-param name="msg" select="'WTVARIABLE Invalid Attribute'"/>
		  			  <xsl:with-param name="text" select="name()"/>
	 	  		</xsl:call-template>
		  	</xsl:otherwise>
		  </xsl:choose>
	 </xsl:for-each>
	 <!-- ****************************************************-->

		  <xsl:if test="($hasconditions)">
				<xsl:call-template name="XSLConditionStart">
				<xsl:with-param name="indent" select="$indent"/>
				<xsl:with-param name="conditions" select="WTCONDITION"/>
				</xsl:call-template>
		  </xsl:if>

		  <xsl:value-of select="concat($ind2, '&lt;xsl:variable name=&quot;', @name, '&quot;&gt;')"/>

		  <xsl:if test="@value">
				<xsl:variable name="valuetype"><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>
				<xsl:variable name="valuetext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>
				<xsl:call-template name="GetValue">
					 <xsl:with-param name="type" select="$valuetype"/>
					 <xsl:with-param name="text" select="$valuetext"/>
					 <xsl:with-param name="hidden" select="true()"/>
				</xsl:call-template>
		  </xsl:if>

		  <xsl:apply-templates select="WTVALUE"/>

		  <xsl:value-of select="concat('&lt;/xsl:variable&gt;', $cr, $cr)"/>

		  <xsl:if test="($hasconditions)">
				<xsl:call-template name="XSLConditionEnd">
					 <xsl:with-param name="indent" select="$indent"/>			
				</xsl:call-template>
		  </xsl:if>
	 </xsl:template>

	 <!--==================================================================-->
	 <xsl:template match="WTVALUE">
	 <!--==================================================================-->
		  <xsl:variable name="valuetype"><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>
		  <xsl:variable name="valuetext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>

	 <!-- ***************** Error Checking *******************-->
	 <xsl:if test="not(@value)">
	     <xsl:call-template name="Error">
	     	<xsl:with-param name="msg" select="'WTVALUE Value Missing'"/>
	     	<xsl:with-param name="text" select="position()"/>
	     </xsl:call-template>
	 </xsl:if>
	 <!--Test valid attributes-->
	 <xsl:for-each select="@*">
		  <xsl:choose>
		   <xsl:when test="name()='value'"/>
		  	<xsl:otherwise>
		  		 <xsl:call-template name="Error">
		  			  <xsl:with-param name="msg" select="'WTVALUE Invalid Attribute'"/>
		  			  <xsl:with-param name="text" select="name()"/>
	 	  		</xsl:call-template>
		  	</xsl:otherwise>
		  </xsl:choose>
	 </xsl:for-each>
	 <!-- ****************************************************-->

		  <xsl:call-template name="GetValue">
		  	 <xsl:with-param name="type" select="$valuetype"/>
		  	 <xsl:with-param name="text" select="$valuetext"/>
   		 <xsl:with-param name="hidden" select="true()"/>
		  </xsl:call-template>
	 </xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: XSL BLANK LINE -->
	<!-- returns the XSL for a blank line -->
	<!--==================================================================-->
	<xsl:template name="XSLBlankLine">
		<xsl:param name="colspan"/>
		<xsl:param name="height"/>
		<xsl:param name="color"/>
		<xsl:param name="indent"/>

		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="ind2" select="concat($ind1, $tab1)"/>
		<xsl:variable name="ind3" select="concat($ind2, $tab1)"/>

		<xsl:value-of select="concat($ind1, '&lt;xsl:element name=&quot;TR&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($ind2, '&lt;xsl:element name=&quot;TD&quot;&gt;', $cr)"/>
		<xsl:if test="($colspan) and ($colspan !='') and ($colspan !='1') and ($colspan !='0')">
			<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;colspan&quot;&gt;', $colspan, '&lt;/xsl:attribute&gt;', $cr)"/>
		</xsl:if>
		<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;height&quot;&gt;', $height, '&lt;/xsl:attribute&gt;',  $cr)"/>
		<xsl:if test="($color != '')">
			<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;bgcolor&quot;&gt;', $color, '&lt;/xsl:attribute&gt;', $cr)"/>
		</xsl:if>
		<xsl:value-of select="concat($ind2, '&lt;/xsl:element&gt;', $cr)"/>
		<xsl:value-of select="concat($ind1, '&lt;/xsl:element&gt;', $cr, $cr)"/>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: XSL BUTTON -->
	<!-- returns the XSL for a blank line -->
	<!--==================================================================-->
	<xsl:template name="XSLButton">
		<xsl:param name="name"/>
		<xsl:param name="type"/>
		<xsl:param name="actioncode"/>
		<xsl:param name="indent"/>
		<xsl:param name="hidden"/>
		<xsl:param name="confirmmsg">""</xsl:param>

		<xsl:variable name="hasconditions" select="(count(/Data/WTENTITY/WTWEBPAGE/WTACTION[@name=$name]/WTCONDITION) > 0) or ($hidden)"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="ind2"><xsl:choose><xsl:when test="($hasconditions)"><xsl:value-of select="concat($ind1, $tab1)"/></xsl:when><xsl:otherwise><xsl:value-of select="$ind1"/></xsl:otherwise></xsl:choose></xsl:variable>
		<xsl:variable name="ind3" select="concat($ind2, $tab1)"/>

		<!--==========generate IF statement for conditions if they exist==========-->
		<xsl:if test="($hasconditions)">
			<xsl:call-template name="XSLConditionStart">
				<xsl:with-param name="indent" select="$indent"/>
				<xsl:with-param name="hidden" select="$hidden"/>
				<xsl:with-param name="conditions" select="/Data/WTENTITY/WTWEBPAGE/WTACTION[@name=$name]/WTCONDITION"/>
			</xsl:call-template>
		</xsl:if>

		<!--==========generate input element for the button==========-->
		<xsl:value-of select="concat($ind2, '&lt;xsl:element name=&quot;INPUT&quot;&gt;' $cr)"/>
		<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;type&quot;&gt;button&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;value&quot;&gt;')"/>
		<xsl:call-template name="XSLLabelText">
			<xsl:with-param name="label" select="$name"/>
			<xsl:with-param name="newline" select="false()"/>
		</xsl:call-template>
		<xsl:value-of select="concat('&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:if test="not(/Data/WTENTITY/WTWEBPAGE/@action='false')">
			<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;onclick&quot;&gt;doSubmit(', $actioncode, ',', $confirmmsg, ')&lt;/xsl:attribute&gt;', $cr)"/>
		</xsl:if>
		<xsl:value-of select="concat($ind2, '&lt;/xsl:element&gt;', $cr)"/>

		<!--==========close IF statement for conditions if they exist==========-->
		<xsl:if test="($hasconditions)">
			<xsl:call-template name="XSLConditionEnd">
				<xsl:with-param name="indent" select="$indent"/>			
			</xsl:call-template>
		</xsl:if> 
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: XSL COMMENT -->
	<!-- returns the XSL for a comment -->
	<!--==================================================================-->
	<xsl:template name="XSLComment">
		<xsl:param name="value"/>
		<xsl:param name="indent"/>

		<xsl:call-template name="Indent">
			<xsl:with-param name="level" select="$indent"/>
		</xsl:call-template>
		<xsl:value-of select="concat('&lt;!--', $value, '--&gt;', $cr)"/>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: XSL CONDITION START-->
	<!-- returns the XSL for a conditional IF test -->
	<!--==================================================================-->
	<xsl:template name="XSLConditionStart">
		<xsl:param name="conditions"/>
		<xsl:param name="indent"/>
		<xsl:param name="hidden"/>
		<xsl:param name="protected"/>
		<xsl:param name="unprotected"/>

		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>

		<!--==========start the IF statement==========-->
		<xsl:value-of select="concat($ind1, '&lt;xsl:if test=&quot;')"/>

		<xsl:choose>
			<xsl:when test="($hidden)">
				<!--==========just build a single condition for the user group==========-->
				<xsl:call-template name="XSLConditionTest">
					<xsl:with-param name="expr">SYS(usergroup)</xsl:with-param>
					<xsl:with-param name="oper">less</xsl:with-param>
					<xsl:with-param name="value" select="concat('CONST(', $hidden, ')')"/>
				</xsl:call-template>
				<xsl:call-template name="XSLConditionTest">
					<xsl:with-param name="expr">SYS(userstatus)</xsl:with-param>
					<xsl:with-param name="oper">equal</xsl:with-param>
					<xsl:with-param name="value" select="('CONST(1)')"/>
					<xsl:with-param name="connector">and</xsl:with-param>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="($protected)">
				<!--==========just build a single condition for the user group==========-->
				<xsl:call-template name="XSLConditionTest">
					<xsl:with-param name="expr">SYS(usergroup)</xsl:with-param>
					<xsl:with-param name="oper">greater-equal</xsl:with-param>
					<xsl:with-param name="value" select="concat('CONST(', $protected, ')')"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="($unprotected)">
				<!--==========just build a single condition for the user group==========-->
				<xsl:call-template name="XSLConditionTest">
					<xsl:with-param name="expr">SYS(usergroup)</xsl:with-param>
					<xsl:with-param name="oper">less</xsl:with-param>
					<xsl:with-param name="value" select="concat('CONST(', $unprotected, ')')"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<!--==========build conditions from the WTCONDITION elements==========-->
				<xsl:for-each select="$conditions">
					<xsl:call-template name="XSLConditionTest">
						<xsl:with-param name="condition" select="."/>
					</xsl:call-template>
				</xsl:for-each>
			</xsl:otherwise>
		</xsl:choose>

		<!--==========end the IF statement==========-->
		<xsl:value-of select="concat('&quot;&gt;', $cr)"/>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: XSL CONDITION TEST-->
	<!-- returns the XSL for a single test within a condition -->
	<!--==================================================================-->
	<xsl:template name="XSLConditionTest">
		<xsl:param name="condition"/>
		<xsl:param name="expr"/>
		<xsl:param name="oper"/>
		<xsl:param name="value"/>
		<xsl:param name="connector"/>
		<xsl:param name="paren"/>

		<xsl:variable name="exprtype">
			<xsl:choose>
				<xsl:when test="$expr"><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="$expr"/></xsl:call-template></xsl:when>	
				<xsl:otherwise><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="$condition/@expr"/></xsl:call-template></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="exprtext">
			<xsl:choose>
				<xsl:when test="$expr"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="$expr"/></xsl:call-template></xsl:when>
				<xsl:otherwise><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="$condition/@expr"/></xsl:call-template></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="exprentity">
			<xsl:choose>
				<xsl:when test="$expr"><xsl:call-template name="QualifiedPrefix"><xsl:with-param name="value" select="$expr"/></xsl:call-template></xsl:when>
				<xsl:otherwise><xsl:call-template name="QualifiedPrefix"><xsl:with-param name="value" select="$condition/@expr"/></xsl:call-template></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="valuetype">
			<xsl:choose>
				<xsl:when test="$value"><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="$value"/></xsl:call-template></xsl:when>	
				<xsl:otherwise><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="$condition/@value"/></xsl:call-template></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="valuetext">
			<xsl:choose>
				<xsl:when test="$value"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="$value"/></xsl:call-template></xsl:when>
				<xsl:otherwise><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="$condition/@value"/></xsl:call-template></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="opertext">
			<xsl:choose>
				<xsl:when test="$oper"><xsl:value-of select="$oper"/></xsl:when>
				<xsl:otherwise><xsl:value-of select="$condition/@oper"/></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="connect">
			<xsl:choose>
				<xsl:when test="$connector"><xsl:value-of select="$connector"/></xsl:when>
				<xsl:when test="($condition) and ($condition/@connector)">
					<xsl:value-of select="$condition/@connector"/>
				</xsl:when>
				<xsl:otherwise></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="parenthesis">
			<xsl:choose>
				<xsl:when test="$paren"><xsl:value-of select="$paren"/></xsl:when>
				<xsl:when test="@paren"><xsl:value-of select="@paren"/></xsl:when>
				<xsl:when test="$condition/@paren"><xsl:value-of select="($condition/@paren)"/></xsl:when>
				<xsl:otherwise></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

	 <!-- ***************** Error Checking *******************-->
	<xsl:if test="$exprtype!='NONE'">
		<xsl:if test="string-length($exprtext)=0 and string-length($opertext)&gt;0">
			<xsl:call-template name="Error">
				<xsl:with-param name="msg" select="'WTCONDITION Expression Missing'"/>
				<xsl:with-param name="text" select="position()"/>
			</xsl:call-template>
		</xsl:if>
<!--    
    <xsl:if test="string-length($valuetext)=0 and $opertext!='exist' and $opertext!='not-exist'">
      <xsl:call-template name="Error">
        <xsl:with-param name="msg" select="'WTCONDITION Value Missing'"/>
        <xsl:with-param name="text" select="$exprtext"/>
      </xsl:call-template>
    </xsl:if>
-->
  </xsl:if>
	<!--*** Don't validate connector for nested Condition in Condition ***-->
	<xsl:if test="not($connector)">
		<xsl:if test="$connect='' and position()!=1">
			<xsl:call-template name="Error">
				<xsl:with-param name="msg" select="'WTCONDITION Connector Missing'"/>
				<xsl:with-param name="text" select="$exprtext"/>
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="$connect!='' and position()=1">
			<xsl:call-template name="Error">
				<xsl:with-param name="msg" select="'WTCONDITION Connector Not Allowed on first condition'"/>
				<xsl:with-param name="text" select="concat($exprtext, ' - [', $connect, ']')"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:if>
	<xsl:if test="not($connect='' or $connect='and' or $connect='or')">
	    <xsl:call-template name="Error">
	    	<xsl:with-param name="msg" select="'WTCONDITION Connector Invalid'"/>
	    	<xsl:with-param name="text" select="concat(string-length($connect), ' - [', $connect, ']')"/>
	    </xsl:call-template>
	</xsl:if>
	 <!--Test valid attributes-->
	 <xsl:for-each select="@*">
		  <xsl:choose>
				<xsl:when test="name()='expr'"/>
				<xsl:when test="name()='oper'"/>
				<xsl:when test="name()='value'"/>
				<xsl:when test="name()='connector'"/>
				<xsl:when test="name()='paren'"/>
				<xsl:otherwise>
					 <xsl:call-template name="Error">
						  <xsl:with-param name="msg" select="'WTCONDITION Invalid Attribute'"/>
						  <xsl:with-param name="text" select="name()"/>
	 				</xsl:call-template>
				</xsl:otherwise>
		  </xsl:choose>
	 </xsl:for-each>
	 <!-- ****************************************************-->

		<xsl:choose>
			<xsl:when test="($exprtype='NONE')">
				<!--==========the condition is a WTCONDITION node reference so call this routine recursively for each of its child conditions==========-->
				<xsl:variable name="test">
					 <!-- Check in the App conditions first --> 
					 <xsl:choose>
						  <xsl:when test="(/Data/WTCONDITIONS/WTCONDITION[@name=$exprtext]/WTCONDITION)">
								<xsl:for-each select="(/Data/WTCONDITIONS/WTCONDITION[@name=$exprtext]/WTCONDITION)">
									<xsl:variable name="con">
										<xsl:choose>
											<xsl:when test="$connect != ''"><xsl:value-of select="$connect"/></xsl:when>
											<xsl:otherwise><xsl:value-of select="@connector"/></xsl:otherwise>
										</xsl:choose>
									</xsl:variable>
									<xsl:variable name="par">
										<xsl:choose>
											<xsl:when test="$parenthesis != ''"><xsl:value-of select="$parenthesis"/></xsl:when>
											<xsl:otherwise><xsl:value-of select="@paren"/></xsl:otherwise>
										</xsl:choose>
									</xsl:variable>
									 <xsl:call-template name="XSLConditionTest">
										  <xsl:with-param name="condition" select="."/>
										  <xsl:with-param name="connector" select="$con"/>
										  <xsl:with-param name="paren" select="$par"/>
									 </xsl:call-template>
								</xsl:for-each>
						  </xsl:when>
						  <xsl:otherwise>
								<xsl:for-each select="(/Data/WTENTITY/WTCONDITIONS/WTCONDITION[@name=$exprtext]/WTCONDITION)">
									<xsl:variable name="con">
										<xsl:choose>
											<xsl:when test="$connect != ''"><xsl:value-of select="$connect"/></xsl:when>
											<xsl:otherwise><xsl:value-of select="@connector"/></xsl:otherwise>
										</xsl:choose>
									</xsl:variable>
									<xsl:variable name="par">
										<xsl:choose>
											<xsl:when test="$parenthesis != ''"><xsl:value-of select="$parenthesis"/></xsl:when>
											<xsl:otherwise><xsl:value-of select="@paren"/></xsl:otherwise>
										</xsl:choose>
									</xsl:variable>
									 <xsl:call-template name="XSLConditionTest">
										  <xsl:with-param name="condition" select="."/>
										  <xsl:with-param name="connector" select="$con"/>
										  <xsl:with-param name="paren" select="$par"/>
									 </xsl:call-template>
								</xsl:for-each>
						  </xsl:otherwise>
					 </xsl:choose>
				</xsl:variable>
				<xsl:value-of select="$test"/>

				<!-- ***************** Error Checking *******************-->
				<xsl:if test="string-length($test)=0">
				    <xsl:call-template name="Error">
				    	<xsl:with-param name="msg" select="'WTCONDITION Named Expression Missing'"/>
				    	<xsl:with-param name="text" select="$exprtext"/>
				    </xsl:call-template>
				</xsl:if>
				<!-- ****************************************************-->
				
			</xsl:when>
			<xsl:otherwise>

				<!--==========add the connector==========-->
				<xsl:if test="($connect != '')">
					<xsl:value-of select="concat(' ', $connect, ' ')"/>
				</xsl:if>

				<!--==========start opening parenthesis==========-->
				<xsl:if test="$parenthesis='start'">
					<xsl:value-of select="'('"/>
				</xsl:if>

				<!--==========enclose the test in parenthesis==========-->
				<xsl:value-of select="concat($tab0,'(')"/>

				<!--==========handle the expression==========-->
				<xsl:variable name="entity">
					<xsl:choose>
						 <xsl:when test="$exprentity != ''"><xsl:value-of select="$exprentity"/></xsl:when>
						 <xsl:otherwise><xsl:value-of select="$entityname"/></xsl:otherwise>
					</xsl:choose>
				</xsl:variable>

        <!--==========check for not-exist==========-->
        <xsl:if test="$opertext='not-exist'">
          <xsl:value-of select="'not('"/>
        </xsl:if>

        <!--==========check for not-contains==========-->
        <xsl:if test="$opertext='contains'">
          <xsl:value-of select="'contains('"/>
        </xsl:if>
        <!--==========check for not-contain==========-->
        <xsl:if test="$opertext='not-contains'">
          <xsl:value-of select="'not(contains('"/>
        </xsl:if>

        <xsl:call-template name="GetValue">
					<xsl:with-param name="type" select="$exprtype"/>
					<xsl:with-param name="text" select="$exprtext"/>
					<xsl:with-param name="entity" select="$entity"/>
					<xsl:with-param name="noselect" select="true()"/>
					<xsl:with-param name="hidden" select="true()"/>
				</xsl:call-template>

        <!--==========check for not-exist==========-->
        <xsl:if test="$opertext='not-exist'">
          <xsl:value-of select="')'"/>
        </xsl:if>

        <!--==========handle the operator==========-->
				<xsl:call-template name="GetOperator">
					<xsl:with-param name="oper" select="$opertext"/>
				</xsl:call-template>
				
				<!--==========handle the value==========-->
				<xsl:call-template name="GetValue">
					<xsl:with-param name="type" select="$valuetype"/>
					<xsl:with-param name="text" select="$valuetext"/>
					<xsl:with-param name="entity" select="$entityname"/>
					<xsl:with-param name="noselect" select="true()"/>
					<xsl:with-param name="hidden" select="true()"/>
				</xsl:call-template>

        <!--==========check for not-contains==========-->
        <xsl:if test="$opertext='contains'">
          <xsl:value-of select="')'"/>
        </xsl:if>
        <xsl:if test="$opertext='not-contains'">
          <xsl:value-of select="'))'"/>
        </xsl:if>

        <!--==========enclose the test in parenthesis==========-->
				<xsl:value-of select="concat($tab0,')')"/>

				<!--==========end closing parenthesis==========-->
				<xsl:if test="$parenthesis='end'">
					<xsl:value-of select="')'"/>
				</xsl:if>

			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: Get Expression Operator -->
	<!--==================================================================-->
	 <xsl:template name="GetOperator">
		  <xsl:param name="oper"/>
		  <xsl:choose>
				<xsl:when test="$oper='equal'"> = </xsl:when>
				<xsl:when test="$oper='greater'"> &amp;gt; </xsl:when>
				<xsl:when test="$oper='greater-equal'"> &amp;gt;= </xsl:when>
				<xsl:when test="$oper='less'"> &amp;lt; </xsl:when>
				<xsl:when test="$oper='less-equal'"> &amp;lt;= </xsl:when>
				<xsl:when test="$oper='not-equal'"> != </xsl:when>
				<xsl:when test="$oper='mod'"> mod </xsl:when>
        <xsl:when test="$oper='exist'"></xsl:when>
        <xsl:when test="$oper='not-exist'"></xsl:when>
        <xsl:when test="$oper='contains'">,</xsl:when>
        <xsl:when test="$oper='not-contains'">,</xsl:when>
        <xsl:otherwise>
					 <xsl:if test="string-length($oper)&gt;0">
						  <xsl:call-template name="Error">
						  	<xsl:with-param name="msg" select="'Invalid Expression Operator'"/>
						  	<xsl:with-param name="text" select="$oper"/>
						  </xsl:call-template>
					 </xsl:if>
				</xsl:otherwise>
		  </xsl:choose>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: XSL CONDITION END-->
	<!-- returns the XSL for a conditional END IF -->
	<!--==================================================================-->
	<xsl:template name="XSLConditionEnd">
		<xsl:param name="indent"/>

		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>

		<xsl:value-of select="concat($ind1, '&lt;/xsl:if&gt;', $cr)"/>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: JAVASCRIPT CONDITION START -->
	<!-- returns the JavaScript for a conditional IF test -->
	<!--==================================================================-->
	<xsl:template name="JavaScriptConditionStart">
		<xsl:param name="conditions"/>
		<xsl:param name="indent"/>

		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>

		<!--==========start the IF statement==========-->
		<xsl:value-of select="concat($ind1, 'if ( ')"/>

		<!--==========build conditions from the WTCONDITION elements==========-->
		<xsl:for-each select="$conditions">
			<xsl:call-template name="JavaScriptConditionTest">
				<xsl:with-param name="condition" select="."/>
			</xsl:call-template>
		</xsl:for-each>

		<!--==========end the IF statement==========-->
		<xsl:value-of select="concat(' ) {', $cr)"/>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: XSL CONDITION TEST-->
	<!-- returns the XSL for a single test within a condition -->
	<!--==================================================================-->
	<xsl:template name="JavaScriptConditionTest">
		<xsl:param name="condition"/>
		<xsl:param name="expr"/>
		<xsl:param name="oper"/>
		<xsl:param name="value"/>
		<xsl:param name="connector"/>
		<xsl:param name="paren"/>

		<xsl:variable name="exprtext">
			<xsl:choose>
				<xsl:when test="$expr"><xsl:value-of select="$expr"/></xsl:when>
				<xsl:otherwise><xsl:value-of select="$condition/@expr"/></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="valuetext">
			<xsl:choose>
				<xsl:when test="$value"><xsl:value-of select="$value"/></xsl:when>
				<xsl:otherwise><xsl:value-of select="$condition/@value"/></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="opertext">
			<xsl:choose>
				<xsl:when test="$oper"><xsl:value-of select="$oper"/></xsl:when>
				<xsl:otherwise><xsl:value-of select="$condition/@oper"/></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="connect">
			<xsl:choose>
				<xsl:when test="$connector"><xsl:value-of select="$connector"/></xsl:when>
				<xsl:when test="($condition) and ($condition/@connector)">
					<xsl:value-of select="$condition/@connector"/>
				</xsl:when>
				<xsl:otherwise></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="parenthesis">
			<xsl:choose>
				<xsl:when test="$paren"><xsl:value-of select="$paren"/></xsl:when>
				<xsl:when test="@paren"><xsl:value-of select="@paren"/></xsl:when>
				<xsl:when test="$condition/@paren"><xsl:value-of select="($condition/@paren)"/></xsl:when>
				<xsl:otherwise></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

	 <!-- ***************** Error Checking *******************-->
	<!--*** Don't validate connector for nested Condition in Condition ***-->
	<xsl:if test="not($connector)">
		<xsl:if test="$connect='' and position()!=1">
			<xsl:call-template name="Error">
				<xsl:with-param name="msg" select="'WTCONDITION Connector Missing'"/>
				<xsl:with-param name="text" select="$exprtext"/>
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="$connect!='' and position()=1">
			<xsl:call-template name="Error">
				<xsl:with-param name="msg" select="'WTCONDITION Connector Not Allowed on first condition'"/>
				<xsl:with-param name="text" select="concat($exprtext, ' - [', $connect, ']')"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:if>
	<xsl:if test="not($connect='' or $connect='and' or $connect='or')">
	    <xsl:call-template name="Error">
	    	<xsl:with-param name="msg" select="'WTCONDITION Connector Invalid'"/>
	    	<xsl:with-param name="text" select="concat(string-length($connect), ' - [', $connect, ']')"/>
	    </xsl:call-template>
	</xsl:if>
	 <!--Test valid attributes-->
	 <xsl:for-each select="@*">
		  <xsl:choose>
				<xsl:when test="name()='expr'"/>
				<xsl:when test="name()='oper'"/>
				<xsl:when test="name()='value'"/>
				<xsl:when test="name()='connector'"/>
				<xsl:when test="name()='paren'"/>
				<xsl:otherwise>
					 <xsl:call-template name="Error">
						  <xsl:with-param name="msg" select="'WTCONDITION Invalid Attribute'"/>
						  <xsl:with-param name="text" select="name()"/>
	 				</xsl:call-template>
				</xsl:otherwise>
		  </xsl:choose>
	 </xsl:for-each>
	 <!-- ****************************************************-->

	<!--==========add the connector==========-->
	<xsl:if test="($connect != '')">
		<xsl:value-of select="concat(' ', $connect, ' ')"/>
	</xsl:if>

	<!--==========start opening parenthesis==========-->
	<xsl:if test="$parenthesis='start'">
		<xsl:value-of select="'('"/>
	</xsl:if>

	<!--==========enclose the test in parenthesis==========-->
	<xsl:value-of select="concat($tab0,'(')"/>

	<!--==========handle the expression==========-->
	<xsl:value-of select="concat('document.getElementById(', $apos, $exprtext, $apos, ').value')"/>

	<!--==========handle the operator==========-->
	<xsl:call-template name="JavaScriptGetOperator">
		<xsl:with-param name="oper" select="$opertext"/>
	</xsl:call-template>
	
	<!--==========handle the value==========-->
	<xsl:value-of select="$valuetext"/>

	<!--==========enclose the test in parenthesis==========-->
	<xsl:value-of select="concat($tab0,')')"/>

	<!--==========end closing parenthesis==========-->
	<xsl:if test="$parenthesis='end'">
		<xsl:value-of select="')'"/>
	</xsl:if>

	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: JavaScript Get Expression Operator -->
	<!--==================================================================-->
	 <xsl:template name="JavaScriptGetOperator">
		  <xsl:param name="oper"/>
		  <xsl:choose>
				<xsl:when test="$oper='equal'"> == </xsl:when>
				<xsl:when test="$oper='greater'"> &gt; </xsl:when>
				<xsl:when test="$oper='greater-equal'"> &gt;= </xsl:when>
				<xsl:when test="$oper='less'"> &lt; </xsl:when>
				<xsl:when test="$oper='less-equal'"> &lt;= </xsl:when>
				<xsl:when test="$oper='not-equal'"> != </xsl:when>
				<xsl:otherwise>
					 <xsl:if test="string-length($oper)&gt;0">
						  <xsl:call-template name="Error">
						  	<xsl:with-param name="msg" select="'Invalid Expression Operator'"/>
						  	<xsl:with-param name="text" select="$oper"/>
						  </xsl:call-template>
					 </xsl:if>
				</xsl:otherwise>
		  </xsl:choose>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: JAVASCRIPT CONDITION END-->
	<!-- returns the JavaScript for a conditional END IF -->
	<!--==================================================================-->
	<xsl:template name="JavaScriptConditionEnd">
		<xsl:param name="indent"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:value-of select="concat($ind1, '}', $cr)"/>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: XSL DATA FIELD -->
	<!-- returns the XSL to fetch the value of a field from the data XML file -->
	<!--==================================================================-->
	<xsl:template name="XSLDataField">
		<xsl:param name="indent">0</xsl:param>
		<xsl:param name="entity"/>
		<xsl:param name="name"/>
		<xsl:param name="newline" select="true()"/>
		<xsl:param name="noselect" select="false()"/>
		<xsl:param name="hidden" select="false()"/>
		<xsl:param name="output" select="false()"/>

		<xsl:if test="($indent)">
			<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
			<xsl:value-of select="$ind1"/>
		</xsl:if>

  	   <!-- ***************** Error Checking *******************-->
	   <!--  Check if this is a valid Attribute for this Entity -->
	   <!-- ****************************************************-->
		<xsl:if test="$entity=$entityname">
		  <xsl:if test="count(/Data/WTENTITY/WTATTRIBUTE[@name=$name])=0">
				 <xsl:call-template name="Error">
					  <xsl:with-param name="msg" select="'WTENTITY/WTATTRIBUTE Invalid Name'"/>
					  <xsl:with-param name="text" select="$name"/>
	 			</xsl:call-template>
	 		</xsl:if>
		</xsl:if>
	   <!-- ****************************************************-->

		<xsl:if test="string-length($name)=0">
		  <xsl:call-template name="Error">
		  	<xsl:with-param name="msg" select="'Empty Data Field Name'"/>
		  	<xsl:with-param name="text" select="$entity"/>
		  </xsl:call-template>
		</xsl:if>

		<xsl:variable name="isenum" select="not(@enum='false') and ( @enum or count(/Data/WTENTITY/WTATTRIBUTE[@name=$name]/WTENUM)>0 )"/>
		<xsl:variable name="isembedhtml" select="not(@embedhtml='false') and ( @embedhtml='true' or (($entity='' or $entity=$entityname) and (count(/Data/WTENTITY/WTATTRIBUTE[@name=$name]/@embedhtml)>0)))"/>

		<xsl:choose>
			<xsl:when test="$isenum and not($hidden)">
				<xsl:choose>
					<xsl:when test="ancestor::WTRECORDSET or ancestor::WTREPEAT">
						<xsl:variable name="enumlabel">
							<xsl:value-of select="('../')"/>
							<xsl:call-template name="CaseUpper">
								<xsl:with-param name="value" select="concat($appprefix, $name, 's/ENUM')"/>
							</xsl:call-template>
							<xsl:value-of select="'[@id=current()/@'"/>
							<xsl:call-template name="CaseLower">
								<xsl:with-param name="value" select="$name"/>
							</xsl:call-template>
							<xsl:value-of select="']/@name'"/>
						</xsl:variable>
						<xsl:call-template name="XSLLabelText">
							<xsl:with-param name="label" select="$enumlabel"/>
							<xsl:with-param name="noquote" select="true()"/>
							<xsl:with-param name="newline" select="false()"/>
						</xsl:call-template>
					</xsl:when>
					<xsl:when test="count(WTOPTION)&gt;0">
						<xsl:call-template name="CaseUpper">
							<xsl:with-param name="value" select="concat('/DATA/TXN/', $appprefix, $entity, '/@')"/>
						</xsl:call-template>
						<xsl:call-template name="CaseLower">
							<xsl:with-param name="value" select="$name"/>
						</xsl:call-template>
					</xsl:when>
					<xsl:otherwise>
						<xsl:variable name="enumlabel">
							<xsl:call-template name="CaseUpper">
								<xsl:with-param name="value" select="concat('/DATA/TXN/', $appprefix, $entity, '/', $appprefix, $name, 's/ENUM')"/>
							</xsl:call-template>
							<xsl:value-of select="'[@id='"/>
							<xsl:call-template name="CaseUpper">
								<xsl:with-param name="value" select="concat('/DATA/TXN/', $appprefix, $entity, '/@')"/>
							</xsl:call-template>

							<xsl:call-template name="CaseLower">
								<xsl:with-param name="value" select="$name"/>
							</xsl:call-template>
							<xsl:value-of select="']/@name'"/>
						</xsl:variable>
						<xsl:call-template name="XSLLabelText">
							<xsl:with-param name="label" select="$enumlabel"/>
							<xsl:with-param name="noquote" select="true()"/>
							<xsl:with-param name="newline" select="false()"/>
						</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose>

			</xsl:when>
			<xsl:otherwise>
				<xsl:if test="not($noselect)">
					<xsl:value-of select="concat($tab0, '&lt;xsl:value-of select=&quot;')"/>
				</xsl:if>

				<xsl:choose>
					<xsl:when test="$entity='Bookmark'">
						<xsl:value-of select="('/DATA/BOOKMARK/')"/>
					</xsl:when>
					<xsl:when test="$entity">
						<xsl:call-template name="CaseUpper">
							<xsl:with-param name="value" select="concat('/DATA/TXN/', $appprefix, $entity, '/')"/>
						</xsl:call-template>
					</xsl:when>
				</xsl:choose>

				<xsl:choose>
					<xsl:when test="$isembedhtml">
						<xsl:call-template name="CaseUpper">
							<xsl:with-param name="value" select="$name"/>
						</xsl:call-template>
						<xsl:value-of select="'/comment()'"/>
						<xsl:if test="$output">
							<xsl:value-of select="'&quot; disable-output-escaping=&quot;yes'"/>
						</xsl:if>
					</xsl:when>
					<xsl:otherwise>
						<xsl:call-template name="CaseLower">
							<xsl:with-param name="value" select="concat('@', $name)"/>
						</xsl:call-template>
						<xsl:if test="$output and @escape='false'">
							<xsl:value-of select="'&quot; disable-output-escaping=&quot;yes'"/>
						</xsl:if>
					</xsl:otherwise>
				</xsl:choose>

				<xsl:if test="not($noselect)">
					<xsl:value-of select="concat($tab0,'&quot;/&gt;')"/>
				</xsl:if>

			</xsl:otherwise>
		</xsl:choose>

		<xsl:if test="($newline)"><xsl:value-of select="$cr"/></xsl:if>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: XSL DATA PATH -->
	<!-- returns the XSL for the path to a record from the data XML file -->
	<!--==================================================================-->
	<xsl:template name="XSLDataPath">
		<xsl:param name="entity"/>
		<xsl:param name="iscollection" select="false()"/>

		<xsl:choose>
			<xsl:when test="($entity) and ($iscollection)">
				<xsl:call-template name="CaseUpper">
					<xsl:with-param name="value" select="concat('/DATA/TXN/', $appprefix, $entity, 's/', $appprefix, $entity)"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="($entity) and not($iscollection)">
				<xsl:call-template name="CaseUpper">
					<xsl:with-param name="value" select="concat('/DATA/TXN/', $appprefix, $entity)"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="not($entity) and ($iscollection)">
				<xsl:call-template name="CaseUpper">
					<xsl:with-param name="value" select="concat('/DATA/TXN/', $appprefix, $entityname, 's/', $appprefix, $entityname)"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="not($entity) and not($iscollection)">
				<xsl:call-template name="CaseUpper">
					<xsl:with-param name="value" select="concat('/DATA/TXN/', $appprefix, $entityname)"/>
				</xsl:call-template>
			</xsl:when>
		</xsl:choose>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: XSL DATA ROW -->
	<!-- returns the XSL to display a content row on a page -->
	<!--==================================================================-->
	<xsl:template name="XSLDataRow">
		<xsl:param name="indent"/>
		<xsl:param name="width"/>
		<xsl:param name="colspan"/>

		<xsl:variable name="islinkgroup" select="count(WTLINKGROUP) > 0"/>
		<xsl:variable name="hasconditions" select="WTCONDITION"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="ind2"><xsl:choose><xsl:when test="($hasconditions)"><xsl:value-of select="concat($ind1, $tab1)"/></xsl:when><xsl:otherwise><xsl:value-of select="$ind1"/></xsl:otherwise></xsl:choose></xsl:variable>
		<xsl:variable name="ind3" select="concat($ind2, $tab1)"/>
		<xsl:variable name="ind4" select="concat($ind3, $tab1)"/>

		<!--generate IF statement for conditions if they exist-->
		<xsl:if test="($hasconditions)">
			<xsl:call-template name="XSLConditionStart">
				<xsl:with-param name="indent" select="$indent"/>			
				<xsl:with-param name="conditions" select="WTCONDITION"/>			
			</xsl:call-template>
		</xsl:if>

		<!--create a row for the divider-->
		<xsl:apply-templates select="WTDIVIDER">
			<xsl:with-param name="indent" select="$indent+2"/>
			<xsl:with-param name="colspan" select="$colspan"/>
		</xsl:apply-templates>

		<!--create a row for the data row-->
		<xsl:value-of select="concat($ind2, '&lt;xsl:element name=&quot;TR&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($ind3, '&lt;xsl:element name=&quot;TD&quot;&gt;', $cr)"/>
		<xsl:if test="$colspan"><xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;colspan&quot;&gt;', $colspan, '&lt;/xsl:attribute&gt;', $cr)"/></xsl:if>
		<xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;align&quot;&gt;left&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;valign&quot;&gt;top&lt;/xsl:attribute&gt;', $cr)"/>
<!--
		<xsl:if test="($islinkgroup)"><xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;class&quot;&gt;PrevNext&lt;/xsl:attribute&gt;', $cr)"/></xsl:if>
-->
		<xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;width&quot;&gt;', $width, '&lt;/xsl:attribute&gt;', $cr)"/>

		<xsl:apply-templates select="WTLINKGROUP">
			<xsl:with-param name="indent" select="$indent+3"/>
			<xsl:with-param name="width" select="$width"/>
		</xsl:apply-templates>

		<xsl:apply-templates select="WTRECORDSET" mode="find">
			<xsl:with-param name="indent" select="$indent+3"/>
			<xsl:with-param name="width" select="$width"/>
		</xsl:apply-templates>

		<!--closing tags for the row-->
		<xsl:value-of select="concat($ind3, '&lt;/xsl:element&gt;', $cr)"/>
		<xsl:value-of select="concat($ind2, '&lt;/xsl:element&gt;', $cr)"/>

		<!--close IF statement for conditions if they exist-->
		<xsl:if test="($hasconditions)">
			<xsl:call-template name="XSLConditionEnd">
				<xsl:with-param name="indent" select="$indent"/>			
			</xsl:call-template>
		</xsl:if> 

		<xsl:value-of select="concat($tab0, $cr)"/>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: XSL DOUBLE SPACE -->
	<!-- returns the XSL for two space characters on the web page -->
	<!--==================================================================-->
	<xsl:template name="XSLDblSpace">
		<xsl:param name="indent"/>
		<xsl:param name="space"/>

		<xsl:variable name="ind1">
			<xsl:if test="($indent)"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:if>
			<xsl:if test="not($indent)"></xsl:if>
		</xsl:variable>

		<xsl:choose>
			<xsl:when test="$space='0'"><xsl:value-of select="concat($ind1, '&lt;xsl:text disable-output-escaping=&quot;yes&quot;&gt;&amp;amp;#160;&lt;/xsl:text&gt;', $cr)"/></xsl:when>
			<xsl:when test="$space='1'"><xsl:value-of select="concat($ind1, '&lt;xsl:text disable-output-escaping=&quot;yes&quot;&gt;&amp;amp;#160;&amp;amp;#160;&lt;/xsl:text&gt;', $cr)"/></xsl:when>
			<xsl:when test="$space='2'"><xsl:value-of select="concat($ind1, '&lt;xsl:text disable-output-escaping=&quot;yes&quot;&gt;&amp;amp;#160;&amp;amp;#160;&amp;amp;#160;&amp;amp;#160;&lt;/xsl:text&gt;', $cr)"/></xsl:when>
			<xsl:when test="$space='3'"><xsl:value-of select="concat($ind1, '&lt;xsl:text disable-output-escaping=&quot;yes&quot;&gt;&amp;amp;#160;&amp;amp;#160;&amp;amp;#160;&amp;amp;#160;&amp;amp;#160;&amp;amp;#160;&lt;/xsl:text&gt;', $cr)"/></xsl:when>
			<xsl:when test="$space='4'"><xsl:value-of select="concat($ind1, '&lt;xsl:text disable-output-escaping=&quot;yes&quot;&gt;&amp;amp;#160;&amp;amp;#160;&amp;amp;#160;&amp;amp;#160;&amp;amp;#160;&amp;amp;#160;&amp;amp;#160;&amp;amp;#160;&lt;/xsl:text&gt;', $cr)"/></xsl:when>
			<xsl:when test="$space='5'"><xsl:value-of select="concat($ind1, '&lt;xsl:text disable-output-escaping=&quot;yes&quot;&gt;&amp;amp;#160;&amp;amp;#160;&amp;amp;#160;&amp;amp;#160;&amp;amp;#160;&amp;amp;#160;&amp;amp;#160;&amp;amp;#160;&amp;amp;#160;&amp;amp;#160;&lt;/xsl:text&gt;', $cr)"/></xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="concat($ind1, '&lt;xsl:text disable-output-escaping=&quot;yes&quot;&gt;&amp;amp;#160;&amp;amp;#160;&lt;/xsl:text&gt;', $cr)"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: XSL SPACE -->
	<!-- returns the XSL for space characters on the web page -->
	<!--==================================================================-->
	<xsl:template name="XSLSpace">
		<xsl:param name="indent"/>
		<xsl:param name="space"/>

		<xsl:variable name="ind1">
			<xsl:if test="($indent)"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:if>
			<xsl:if test="not($indent)"></xsl:if>
		</xsl:variable>

		<xsl:choose>
			<xsl:when test="$space='1'"><xsl:value-of select="concat($ind1, '&lt;xsl:text disable-output-escaping=&quot;yes&quot;&gt;&amp;amp;#160;&lt;/xsl:text&gt;', $cr)"/></xsl:when>
			<xsl:when test="$space='2'"><xsl:value-of select="concat($ind1, '&lt;xsl:text disable-output-escaping=&quot;yes&quot;&gt;&amp;amp;#160;&amp;amp;#160;&lt;/xsl:text&gt;', $cr)"/></xsl:when>
			<xsl:when test="$space='3'"><xsl:value-of select="concat($ind1, '&lt;xsl:text disable-output-escaping=&quot;yes&quot;&gt;&amp;amp;#160;&amp;amp;#160;&amp;amp;#160;&lt;/xsl:text&gt;', $cr)"/></xsl:when>
			<xsl:when test="$space='4'"><xsl:value-of select="concat($ind1, '&lt;xsl:text disable-output-escaping=&quot;yes&quot;&gt;&amp;amp;#160;&amp;amp;#160;&amp;amp;#160;&amp;amp;#160;&lt;/xsl:text&gt;', $cr)"/></xsl:when>
			<xsl:when test="$space='5'"><xsl:value-of select="concat($ind1, '&lt;xsl:text disable-output-escaping=&quot;yes&quot;&gt;&amp;amp;#160;&amp;amp;#160;&amp;amp;#160;&amp;amp;#160;&amp;amp;#160;&lt;/xsl:text&gt;', $cr)"/></xsl:when>
		</xsl:choose>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: XSL SPACE -->
	<!-- returns the XSL for space characters on the web page -->
	<!--==================================================================-->
	<xsl:template name="XSLSpacex">
		<xsl:param name="indent"/>
		<xsl:param name="space"/>

		<xsl:variable name="ind1">
			<xsl:if test="($indent)"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:if>
			<xsl:if test="not($indent)"></xsl:if>
		</xsl:variable>

		<xsl:choose>
			<xsl:when test="$space='1'"><xsl:value-of select="concat($ind1, '&lt;xsl:text disable-output-escaping=&quot;yes&quot;&gt; &lt;/xsl:text&gt;', $cr)"/></xsl:when>
			<xsl:when test="$space='2'"><xsl:value-of select="concat($ind1, '&lt;xsl:text disable-output-escaping=&quot;yes&quot;&gt;  &lt;/xsl:text&gt;', $cr)"/></xsl:when>
			<xsl:when test="$space='3'"><xsl:value-of select="concat($ind1, '&lt;xsl:text disable-output-escaping=&quot;yes&quot;&gt;   &lt;/xsl:text&gt;', $cr)"/></xsl:when>
			<xsl:when test="$space='4'"><xsl:value-of select="concat($ind1, '&lt;xsl:text disable-output-escaping=&quot;yes&quot;&gt;    &lt;/xsl:text&gt;', $cr)"/></xsl:when>
			<xsl:when test="$space='5'"><xsl:value-of select="concat($ind1, '&lt;xsl:text disable-output-escaping=&quot;yes&quot;&gt;     &lt;/xsl:text&gt;', $cr)"/></xsl:when>
		</xsl:choose>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: XSL NEWLINE -->
	<!-- returns the XSL for newline characters on the web page -->
	<!--==================================================================-->
	<xsl:template name="XSLNewLine">
		<xsl:param name="indent"/>
		<xsl:param name="line"/>

		<xsl:variable name="ind1">
			<xsl:if test="($indent)"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:if>
			<xsl:if test="not($indent)"></xsl:if>
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="$line='2'"><xsl:value-of select="concat($ind1, '&lt;xsl:element name=&quot;BR&quot;/&gt;&lt;xsl:element name=&quot;BR&quot;/&gt;', $cr)"/></xsl:when>
			<xsl:when test="$line='3'"><xsl:value-of select="concat($ind1, '&lt;xsl:element name=&quot;BR&quot;/&gt;&lt;xsl:element name=&quot;BR&quot;/&gt;&lt;xsl:element name=&quot;BR&quot;/&gt;', $cr)"/></xsl:when>
			<xsl:when test="$line='4'"><xsl:value-of select="concat($ind1, '&lt;xsl:element name=&quot;BR&quot;/&gt;&lt;xsl:element name=&quot;BR&quot;/&gt;&lt;xsl:element name=&quot;BR&quot;/&gt;&lt;xsl:element name=&quot;BR&quot;/&gt;', $cr)"/></xsl:when>
			<xsl:when test="$line='5'"><xsl:value-of select="concat($ind1, '&lt;xsl:element name=&quot;BR&quot;/&gt;&lt;xsl:element name=&quot;BR&quot;/&gt;&lt;xsl:element name=&quot;BR&quot;/&gt;&lt;xsl:element name=&quot;BR&quot;/&gt;&lt;xsl:element name=&quot;BR&quot;/&gt;', $cr)"/></xsl:when>
			<xsl:otherwise><xsl:value-of select="concat($ind1, '&lt;xsl:element name=&quot;BR&quot;/&gt;', $cr)"/></xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: XSL TD -->
	<!-- returns the XSL for new table column (cell) web page -->
	<!--==================================================================-->
	<xsl:template name="XSLTD">
		<xsl:param name="indent"/>
		<xsl:param name="cnt"/>

		<xsl:variable name="ind1">
			<xsl:if test="($indent)"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:if>
			<xsl:if test="not($indent)"></xsl:if>
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="$cnt='2'"><xsl:value-of select="concat($ind1, '&lt;xsl:element name=&quot;TD&quot;/&gt;&lt;xsl:element name=&quot;TD&quot;/&gt;', $cr)"/></xsl:when>
			<xsl:when test="$cnt='1'"><xsl:value-of select="concat($ind1, '&lt;xsl:element name=&quot;TD&quot;/&gt;', $cr)"/></xsl:when>
		</xsl:choose>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: XSL END OF LIST -->
	<!-- returns the XSL to display End of List at the end of the list and find pages -->
	<!--==================================================================-->
	<xsl:template name="XSLEndOfList">
		<xsl:param name="colspan"/>
		<xsl:param name="indent"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="ind2" select="concat($ind1, $tab1)"/>
		<xsl:variable name="ind3" select="concat($ind2, $tab1)"/>
		<xsl:variable name="ind4" select="concat($ind3, $tab1)"/>
		<xsl:variable name="ind5" select="concat($ind4, $tab1)"/>
		
		<xsl:call-template name="XSLComment">
			<xsl:with-param name="indent" select="$indent"/>
			<xsl:with-param name="value">END OF LIST</xsl:with-param>
		</xsl:call-template>
		<xsl:value-of select="concat($ind1, '&lt;xsl:element name=&quot;TR&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($ind2, '&lt;xsl:element name=&quot;TD&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;colspan&quot;&gt;,$colspan,&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;align&quot;&gt;left&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;class&quot;&gt;EndList&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="$ind3"/>
		<xsl:call-template name="XSLLabelText">
			<xsl:with-param name="label">EndOfList</xsl:with-param>
			<xsl:with-param name="indent" select="$indent+2"/>
			<xsl:with-param name="newline" select="true()"/>
		</xsl:call-template>
		<xsl:value-of select="concat($ind2, '&lt;/xsl:element&gt;', $cr)"/>
		<xsl:value-of select="concat($ind1, '&lt;/xsl:element&gt;', $cr, $cr)"/>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: XSL FOOTER ROW -->
	<!-- returns the XSL for the common page footer -->
	<!--==================================================================-->
	<xsl:template name="XSLFooterRow">
		<xsl:param name="name">PageFooter</xsl:param>
		<xsl:param name="indent">5</xsl:param>
		<xsl:param name="colspan">3</xsl:param>

		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="ind2" select="concat($ind1, $tab1)"/>
		<xsl:variable name="ind3" select="concat($ind2, $tab1)"/>
		<xsl:variable name="ind4" select="concat($ind3, $tab1)"/>
		
		<xsl:value-of select="concat($ind1, '&lt;xsl:element name=&quot;TR&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($ind2, '&lt;xsl:element name=&quot;TD&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;colspan&quot;&gt;', $colspan, '&lt;/xsl:attribute&gt;', $cr)"/>

		<xsl:if test="/Data/WTENTITY/WTWEBPAGE/@contentpage">
			<xsl:value-of select="concat($ind3, '&lt;xsl:if test=&quot;/DATA/PARAM/@contentpage!=1 and /DATA/PARAM/@contentpage!=3&quot;&gt;', $cr)"/>
				<xsl:value-of select="concat($ind4, '&lt;xsl:call-template name=&quot;', $name, '&quot;/&gt;', $cr)"/>
			<xsl:value-of select="concat($ind3, '&lt;/xsl:if&gt;', $cr)"/>
		</xsl:if>
		<xsl:if test="not(/Data/WTENTITY/WTWEBPAGE/@contentpage)">
			<xsl:value-of select="concat($ind3, '&lt;xsl:call-template name=&quot;', $name, '&quot;/&gt;', $cr)"/>
		</xsl:if>

		<xsl:value-of select="concat($ind2, '&lt;/xsl:element&gt;', $cr)"/>
		<xsl:value-of select="concat($ind1, '&lt;/xsl:element&gt;', $cr, $cr)"/>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: XSL FORM BEGIN -->
	<!-- returns the XSL to begin the HTML form -->
	<!--==================================================================-->
	<xsl:template name="XSLFormBegin">
		<xsl:param name="name" select="$entityname"/>
	  	<xsl:param name="content"/>
	  	<xsl:param name="submit"/>
	  	<xsl:param name="type"/>

		<xsl:call-template name="XSLComment">
			<xsl:with-param name="indent">4</xsl:with-param>
			<xsl:with-param name="value">BEGIN FORM</xsl:with-param>
		</xsl:call-template>
		<xsl:value-of select="concat($tab4, '&lt;xsl:element name=&quot;FORM&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($tab5, '&lt;xsl:attribute name=&quot;name&quot;&gt;', $name, '&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($tab5, '&lt;xsl:attribute name=&quot;method&quot;&gt;post&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:if test="$submit">
			<xsl:value-of select="concat($tab5, '&lt;xsl:attribute name=&quot;action&quot;&gt;', $submit, '&lt;/xsl:attribute&gt;', $cr)"/>
		</xsl:if>
		<xsl:if test="$type='multi'">
			<xsl:value-of select="concat($tab5, '&lt;xsl:attribute name=&quot;enctype&quot;&gt;multipart/form-data&lt;/xsl:attribute&gt;', $cr)"/>
		</xsl:if>
		<xsl:value-of select="$cr"/>
		<xsl:if test="$content">
		  <xsl:apply-templates select="$content/WTSUBMIT">
		  	<xsl:with-param name="indent">5</xsl:with-param>
		  </xsl:apply-templates>
		</xsl:if>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: XSL FORM END -->
	<!-- returns the XSL to end the HTML form -->
	<!--==================================================================-->
	<xsl:template name="XSLFormEnd">
		<xsl:value-of select="concat($tab4, '&lt;/xsl:element&gt;', $cr)"/>
		<xsl:call-template name="XSLComment">
			<xsl:with-param name="indent">4</xsl:with-param>
			<xsl:with-param name="value">END FORM</xsl:with-param>
		</xsl:call-template>
		<xsl:value-of select="$cr"/>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: XSL HEADER ROW -->
	<!-- returns the XSL for the common header for each page -->
	<!--==================================================================-->
	<xsl:template name="XSLHeaderRow">
		<xsl:param name="name">PageHeader</xsl:param>
		<xsl:param name="indent">5</xsl:param>
		<xsl:param name="colspan">3</xsl:param>

		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="ind2" select="concat($ind1, $tab1)"/>
		<xsl:variable name="ind3" select="concat($ind2, $tab1)"/>
		<xsl:variable name="ind4" select="concat($ind3, $tab1)"/>

		<xsl:call-template name="XSLComment">
			<xsl:with-param name="indent">5</xsl:with-param>
			<xsl:with-param name="value">HEADER ROW</xsl:with-param>
		</xsl:call-template>
		<xsl:value-of select="concat($ind1, '&lt;xsl:element name=&quot;TR&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($ind2, '&lt;xsl:element name=&quot;TD&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;colspan&quot;&gt;', $colspan, '&lt;/xsl:attribute&gt;', $cr)"/>

		<xsl:if test="/Data/WTENTITY/WTWEBPAGE/@contentpage">
			<xsl:value-of select="concat($ind3, '&lt;xsl:if test=&quot;/DATA/PARAM/@contentpage!=1 and /DATA/PARAM/@contentpage!=3&quot;&gt;', $cr)"/>
				<xsl:value-of select="concat($ind4, '&lt;xsl:call-template name=&quot;', $name, '&quot;/&gt;', $cr)"/>
			<xsl:value-of select="concat($ind3, '&lt;/xsl:if&gt;', $cr)"/>
		</xsl:if>
		<xsl:if test="not(/Data/WTENTITY/WTWEBPAGE/@contentpage)">
			<xsl:value-of select="concat($ind3, '&lt;xsl:call-template name=&quot;', $name, '&quot;/&gt;', $cr)"/>
		</xsl:if>

		<xsl:value-of select="concat($ind2, '&lt;/xsl:element&gt;', $cr)"/>
		<xsl:value-of select="concat($ind1, '&lt;/xsl:element&gt;', $cr, $cr)"/>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: XSL HIDDEN INPUT -->
	<!-- returns the XSL for a hidden input field on a form -->
	<!--==================================================================-->
	<xsl:template name="XSLHiddenInput">
		<xsl:param name="name"/>
		<xsl:param name="value"/>
		<xsl:param name="indent"/>

		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="ind2" select="concat($ind1, $tab1)"/>

		<xsl:value-of select="concat($ind1, '&lt;xsl:element name=&quot;INPUT&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($ind2, '&lt;xsl:attribute name=&quot;type&quot;&gt;hidden&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($ind2, '&lt;xsl:attribute name=&quot;name&quot;&gt;', $name, '&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($ind2, '&lt;xsl:attribute name=&quot;id&quot;&gt;', $name, '&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($ind2, '&lt;xsl:attribute name=&quot;value&quot;&gt;')"/>
		<xsl:if test="($value != '')">
			<xsl:value-of select="concat($tab0, '&lt;xsl:value-of select=&quot;', $value, '&quot;/&gt;')"/>
		</xsl:if>
		<xsl:value-of select="concat($tab0, '&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($ind1, '&lt;/xsl:element&gt;', $cr)"/>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: XSL INCLUDE -->
	<!-- returns the XSL to include a referenced XSL file -->
	<!--==================================================================-->
	<xsl:template name="XSLInclude">
		<xsl:param name="filename"/>
		<xsl:value-of select="concat($tab1, '&lt;xsl:include href=&quot;', $filename, '.xsl&quot;/&gt;', $cr)"/>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template name="XSLLabelText">
	<!--==================================================================-->
		<xsl:param name="label"/>
		<xsl:param name="noquote" select="false()"/>
		<xsl:param name="islabel" select="false()"/>
		<xsl:param name="newline" select="true()"/>
		<xsl:param name="indent">0</xsl:param>

		<xsl:variable name="labeltype"><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="$label"/></xsl:call-template></xsl:variable>
		<xsl:variable name="labeltext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="$label"/></xsl:call-template></xsl:variable>
		<xsl:variable name="labelentity"><xsl:call-template name="QualifiedPrefix"><xsl:with-param name="value" select="$label"/></xsl:call-template></xsl:variable>

		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="name">
			<xsl:choose>
				<xsl:when test="($noquote)">
					<xsl:value-of select="concat('&lt;xsl:value-of select=&quot;', $label, '&quot;/&gt;')"/>
				</xsl:when>
				<xsl:when test="($labeltype='PARAM')">
					<xsl:value-of select="('&lt;xsl:value-of select=&quot;/DATA/PARAM/@')"/>
					<xsl:call-template name="CaseLower">
						<xsl:with-param name="value" select="$labeltext"/>
					</xsl:call-template>
					<xsl:value-of select="('&quot;/&gt;')"/>
				</xsl:when>
				<xsl:when test="($labeltype='DATA')">
					<xsl:value-of select="('&lt;xsl:value-of select=&quot;@')"/>
					<xsl:call-template name="CaseLower">
						<xsl:with-param name="value" select="$labeltext"/>
					</xsl:call-template>
					<xsl:value-of select="('&quot;/&gt;')"/>
				</xsl:when>
				<xsl:otherwise><xsl:value-of select="$label"/></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<!--don't translate labels that are numbers-->
		<xsl:choose>
			<xsl:when test="@translate!='true' and (string(number($label)) != 'NaN')"><xsl:value-of select="concat($ind1, '&lt;xsl:text&gt;', $label, '&lt;/xsl:text&gt;')"/></xsl:when>
			<xsl:otherwise>

			<xsl:choose>
				<xsl:when test="@notranslate">
					<xsl:value-of select="concat($ind1, $name)"/>
				</xsl:when>
				<xsl:when test="$noquote or $labeltype='PARAM' or $labeltype='DATA'">
					<xsl:value-of select="concat($ind1, '&lt;xsl:variable name=&quot;tmp', position(), '&quot;&gt;', $name, '&lt;/xsl:variable&gt;')"/>
					<xsl:value-of select="concat($tab0, '&lt;xsl:value-of select=&quot;/DATA/LANGUAGE/LABEL[@name=$tmp', position(), ']&quot;/&gt;' )"/>
<!--					<xsl:value-of select="concat($ind1, '&lt;xsl:value-of select=&quot;/DATA/LANGUAGE/LABEL[@name=', $labeltext, ']&quot;/&gt;' )"/>-->
				</xsl:when>
				<xsl:when test="not($name='')">
					<xsl:value-of select="concat($ind1, '&lt;xsl:value-of select=&quot;/DATA/LANGUAGE/LABEL[@name=', $apos, $name, $apos, ']&quot;/&gt;')"/>
				</xsl:when>
			</xsl:choose>
<!--
				<xsl:value-of select="concat($ind1, '&lt;xsl:call-template name=&quot;LabelText&quot;&gt;')"/>
				<xsl:value-of select="concat('&lt;xsl:with-param name=&quot;name&quot;&gt;', $name, '&lt;/xsl:with-param&gt;')"/>
				<xsl:value-of select="('&lt;/xsl:call-template&gt;')"/>
-->
				<xsl:if test="($islabel)"><xsl:value-of select="concat($cr, $ind1, '&lt;xsl:text&gt;:&lt;/xsl:text&gt;')"/></xsl:if>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:if test="($newline and not($name=''))"><xsl:value-of select="$cr"/></xsl:if>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: XSL NO ITEMS -->
	<!-- returns the XSL to display No Items for an empty list or find page -->
	<!--==================================================================-->
	<xsl:template name="XSLNoItems">
		<xsl:param name="entity" select="$entityname"/>
		<xsl:param name="colspan"/>
		<xsl:param name="indent"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="ind2" select="concat($ind1, $tab1)"/>
		<xsl:variable name="ind3" select="concat($ind2, $tab1)"/>
		<xsl:variable name="ind4" select="concat($ind3, $tab1)"/>
		<xsl:variable name="ind5" select="concat($ind4, $tab1)"/>
		<xsl:variable name="ind6" select="concat($ind5, $tab1)"/>
		
		<xsl:value-of select="concat($ind1, '&lt;xsl:choose&gt;', $cr)"/>
		<xsl:value-of select="concat($ind2, '&lt;xsl:when test=&quot;(count(')"/>
		<xsl:call-template name="CaseUpper">
			<xsl:with-param name="value" select="concat('/DATA/TXN/', $appprefix, $entity, 's/', $appprefix, $entity)"/>
		</xsl:call-template>
		<!--filter-->
		<xsl:apply-templates select="WTFILTER"/>

		<xsl:value-of select="concat($tab0, ') = 0)&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($ind3, '&lt;xsl:element name=&quot;TR&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($ind4, '&lt;xsl:element name=&quot;TD&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($ind5, '&lt;xsl:attribute name=&quot;colspan&quot;&gt;', $colspan, '&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($ind5, '&lt;xsl:attribute name=&quot;align&quot;&gt;left&lt;/xsl:attribute&gt;', $cr)"/>

		<!-- If using system colors, use the system graybar on color for the background color if provided, otherwise use GrayBar -->
		<xsl:if test="/Data/WTENTITY/WTWEBPAGE/@system-colors or /Data/WTPAGE/@system-colors">
			<xsl:value-of select="concat($ind5, '&lt;xsl:attribute name=&quot;class&quot;&gt;NoItemsSys&lt;/xsl:attribute&gt;', $cr)"/>
			<xsl:value-of select="concat($ind5, '&lt;xsl:if test=&quot;/DATA/SYSTEM/@colorgraybaron!=', $apos, $apos,'&quot;&gt;', $cr)"/>
			<xsl:value-of select="concat($ind6, '&lt;xsl:attribute name=&quot;bgcolor&quot;&gt;#&lt;xsl:value-of select=&quot;/DATA/SYSTEM/@colorgraybaron&quot;/&gt;&lt;/xsl:attribute&gt;', $cr)"/>
			<xsl:value-of select="concat($ind5, '&lt;/xsl:if&gt;', $cr)"/>
		</xsl:if>
		<xsl:if test="not(/Data/WTENTITY/WTWEBPAGE/@system-colors or /Data/WTPAGE/@system-colors)">
			<xsl:value-of select="concat($ind5, '&lt;xsl:attribute name=&quot;class&quot;&gt;NoItems&lt;/xsl:attribute&gt;', $cr)"/>
		</xsl:if>

		<xsl:variable name="noitems">
			<xsl:choose>
				<xsl:when test="@noitems"><xsl:value-of select="@noitems"/></xsl:when>
				<xsl:otherwise>NoItems</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:call-template name="XSLLabelText">
			<xsl:with-param name="label" select="$noitems"/>
			<xsl:with-param name="indent" select="$indent+4"/>
			<xsl:with-param name="newline" select="true()"/>
		</xsl:call-template>
		<xsl:value-of select="concat($ind4, '&lt;/xsl:element&gt;', $cr)"/>
		<xsl:value-of select="concat($ind3, '&lt;/xsl:element&gt;', $cr)"/>
		<xsl:value-of select="concat($ind2, '&lt;/xsl:when&gt;', $cr)"/>
		<xsl:value-of select="concat($ind1, '&lt;/xsl:choose&gt;', $cr, $cr)"/>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: XSL ITEM COUNT -->
	<!-- returns the XSL to display No Items for an empty list or find page -->
	<!--==================================================================-->
	<xsl:template name="XSLItemCount">
		<xsl:param name="entity" select="$entityname"/>
		<xsl:param name="colspan"/>
		<xsl:param name="indent"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="ind2" select="concat($ind1, $tab1)"/>
		<xsl:variable name="ind3" select="concat($ind2, $tab1)"/>
		<xsl:variable name="ind4" select="concat($ind3, $tab1)"/>
		<xsl:variable name="ind5" select="concat($ind4, $tab1)"/>
		
		<xsl:value-of select="concat($ind1, '&lt;xsl:choose&gt;', $cr)"/>
		<xsl:value-of select="concat($ind2, '&lt;xsl:when test=&quot;count(')"/>
		<xsl:call-template name="CaseUpper">
			<xsl:with-param name="value" select="concat('/DATA/TXN/', $appprefix, $entity, 's/', $appprefix, $entity)"/>
		</xsl:call-template>
		<xsl:value-of select="concat($tab0, ') > 0&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($ind3, '&lt;xsl:element name=&quot;TR&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($ind4, '&lt;xsl:element name=&quot;TD&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($ind5, '&lt;xsl:attribute name=&quot;colspan&quot;&gt;', $colspan, '&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($ind5, '&lt;xsl:attribute name=&quot;align&quot;&gt;left&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($ind5, '&lt;xsl:attribute name=&quot;class&quot;&gt;ItemCount&lt;/xsl:attribute&gt;', $cr)"/>

		<xsl:value-of select="concat($ind5, '&lt;xsl:value-of select=&quot;count(')"/>
		<xsl:call-template name="CaseUpper">
			<xsl:with-param name="value" select="concat('/DATA/TXN/', $appprefix, $entity, 's/', $appprefix, $entity)"/>
		</xsl:call-template>
		<xsl:value-of select="concat($tab0, ')&quot;/&gt;', $cr)"/>
		
		  <xsl:call-template name="XSLDblSpace">
				<xsl:with-param name="indent" select="$indent+4"/>
				<xsl:with-param name="space" select="@space"/>
		  </xsl:call-template>

		<xsl:call-template name="XSLLabelText">
			<xsl:with-param name="label">ItemCount</xsl:with-param>
			<xsl:with-param name="indent" select="$indent+4"/>
			<xsl:with-param name="newline" select="true()"/>
		</xsl:call-template>
		<xsl:value-of select="concat($ind4, '&lt;/xsl:element&gt;', $cr)"/>
		<xsl:value-of select="concat($ind3, '&lt;/xsl:element&gt;', $cr)"/>
		<xsl:value-of select="concat($ind2, '&lt;/xsl:when&gt;', $cr)"/>
		<xsl:value-of select="concat($ind1, '&lt;/xsl:choose&gt;', $cr, $cr)"/>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: XSL PAGE BEGIN -->
	<!-- returns the XSL for the beginning of each HTML page -->
	<!--==================================================================-->
	<xsl:template name="XSLPageBegin">
		<xsl:param name="name" select="$entityname"/>
		<xsl:param name="includecalendar" select="false()"/>
		<xsl:param name="htmleditor"/>
	  	<xsl:param name="pagewidth">750</xsl:param>
	  	<xsl:param name="errorhandling" select="true()"/>
	  	<xsl:param name="email" select="false()"/>
	  	<xsl:param name="content"/>

		<xsl:if test="not(/Data/WTENTITY/WTWEBPAGE/@stylesheet='false') and not(/Data/WTPAGE/@stylesheet='false')">
			<xsl:variable name="StyleSheet">
				<xsl:if test="not(/Data/WTENTITY/WTWEBPAGE/@type='mail')">
					<xsl:choose>
						<xsl:when test="/Data/WTPAGE/@stylesheet"><xsl:value-of select="/Data/WTPAGE/@stylesheet"/></xsl:when>
						<xsl:when test="/Data/WTENTITY/WTWEBPAGE/@stylesheet"><xsl:value-of select="/Data/WTENTITY/WTWEBPAGE/@stylesheet"/></xsl:when>
						<xsl:otherwise>StyleSheet.css</xsl:otherwise>
					</xsl:choose>
				</xsl:if>
				<xsl:if test="/Data/WTENTITY/WTWEBPAGE/@type='mail'">
					<xsl:choose>
						<xsl:when test="/Data/WTPAGE/@stylesheet"><xsl:value-of select="/Data/WTPAGE/@stylesheet"/></xsl:when>
						<xsl:when test="/Data/WTENTITY/WTWEBPAGE/@stylemail"><xsl:value-of select="/Data/WTENTITY/WTWEBPAGE/@stylemail"/></xsl:when>
						<xsl:otherwise>StyleMail.css</xsl:otherwise>
					</xsl:choose>
				</xsl:if>
			</xsl:variable>
			<xsl:value-of select="concat($tab2, '&lt;xsl:element name=&quot;link&quot;&gt;', $cr)"/>
			<xsl:value-of select="concat($tab3, '&lt;xsl:attribute name=&quot;rel&quot;&gt;stylesheet&lt;/xsl:attribute&gt;', $cr)"/>
			<xsl:value-of select="concat($tab3, '&lt;xsl:attribute name=&quot;type&quot;&gt;text/css&lt;/xsl:attribute&gt;', $cr)"/>
			<xsl:value-of select="concat($tab3, '&lt;xsl:attribute name=&quot;href&quot;&gt;include/', $StyleSheet, '&lt;/xsl:attribute&gt;', $cr)"/>
			<xsl:value-of select="concat($tab2, '&lt;/xsl:element&gt;', $cr, $cr)"/>
		</xsl:if>

		<xsl:if test="count(/Data/WTENTITY/WTWEBPAGE/WTCONTENT/descendant::*[name()='WTTREE'])&gt;0">
			<xsl:variable name="css" select="/Data/WTENTITY/WTWEBPAGE/WTCONTENT/descendant::*[name()='WTTREE']/@css"/>
			<xsl:value-of select="concat($tab2, '&lt;xsl:element name=&quot;link&quot;&gt;', $cr)"/>
			<xsl:value-of select="concat($tab3, '&lt;xsl:attribute name=&quot;rel&quot;&gt;stylesheet&lt;/xsl:attribute&gt;', $cr)"/>
			<xsl:value-of select="concat($tab3, '&lt;xsl:attribute name=&quot;type&quot;&gt;text/css&lt;/xsl:attribute&gt;', $cr)"/>
			<xsl:if test="string-length($css)=0">
				<xsl:value-of select="concat($tab3, '&lt;xsl:attribute name=&quot;href&quot;&gt;include/TreeStyle.css&lt;/xsl:attribute&gt;', $cr)"/>
			</xsl:if>
			<xsl:if test="string-length($css)&gt;0">
				<xsl:value-of select="concat($tab3, '&lt;xsl:attribute name=&quot;href&quot;&gt;include/', $css, '&lt;/xsl:attribute&gt;', $cr)"/>
			</xsl:if>
			<xsl:value-of select="concat($tab2, '&lt;/xsl:element&gt;', $cr, $cr)"/>
		</xsl:if>

		<xsl:choose>
			<xsl:when test="$email">
				<xsl:value-of select="concat($tab2, '&lt;xsl:call-template name=&quot;HTMLEmail&quot;&gt;', $cr)"/>
				<xsl:value-of select="concat($tab3, '&lt;xsl:with-param name=&quot;pagename&quot; select=&quot;', $apos, $entityname, $apos, '&quot;/&gt;', $cr)"/>
				<xsl:value-of select="concat($tab2, '&lt;/xsl:call-template&gt;', $cr, $cr)"/>
			</xsl:when>
			<xsl:otherwise>

				<xsl:if test="/Data/WTENTITY/WTWEBPAGE/@heading">
					<xsl:value-of select="concat($tab2, '&lt;xsl:call-template name=&quot;', /Data/WTENTITY/WTWEBPAGE/@heading, '&quot;/&gt;', $cr)"/>
				</xsl:if>
				<xsl:if test="not(/Data/WTENTITY/WTWEBPAGE/@heading)">
					<xsl:value-of select="concat($tab2, '&lt;xsl:call-template name=&quot;HTMLHeading&quot;&gt;', $cr)"/>
					<xsl:value-of select="concat($tab3, '&lt;xsl:with-param name=&quot;pagename&quot; select=&quot;', $name, '&quot;/&gt;', $cr)"/>
					<xsl:value-of select="concat($tab3, '&lt;xsl:with-param name=&quot;includecalendar&quot; select=&quot;', $includecalendar, '()&quot;/&gt;', $cr)"/>
					<xsl:value-of select="concat($tab3, '&lt;xsl:with-param name=&quot;htmleditor&quot;&gt;', $htmleditor, '&lt;/xsl:with-param&gt;', $cr)"/>
					<xsl:if test="/Data/WTENTITY/WTWEBPAGE/@pageenter">
						<xsl:value-of select="concat($tab3, '&lt;xsl:with-param name=&quot;pageenter&quot; select=&quot;', $apos, /Data/WTENTITY/WTWEBPAGE/@pageenter, $apos, '&quot;/&gt;', $cr)"/>
					</xsl:if>
					<xsl:if test="/Data/WTENTITY/WTWEBPAGE/@description">
						<xsl:value-of select="concat($tab3, '&lt;xsl:with-param name=&quot;description&quot; select=&quot;/DATA/LANGUAGE/LABEL[@name=', $apos, /Data/WTENTITY/WTWEBPAGE/@description, $apos, ']&quot;/&gt;', $cr)"/>
					</xsl:if>
					<xsl:if test="/Data/WTENTITY/WTWEBPAGE/@content">
						<xsl:value-of select="concat($tab3, '&lt;xsl:with-param name=&quot;content&quot; select=&quot;/DATA/LANGUAGE/LABEL[@name=', $apos, /Data/WTENTITY/WTWEBPAGE/@content, $apos, ']&quot;/&gt;', $cr)"/>
					</xsl:if>
					<xsl:if test="/Data/WTENTITY/WTWEBPAGE/@keywords">
						<xsl:value-of select="concat($tab3, '&lt;xsl:with-param name=&quot;keywords&quot; select=&quot;/DATA/LANGUAGE/LABEL[@name=', $apos, /Data/WTENTITY/WTWEBPAGE/@keywords, $apos, ']&quot;/&gt;', $cr)"/>
					</xsl:if>
					<xsl:if test="/Data/WTENTITY/WTWEBPAGE/@viewport">
						<xsl:value-of select="concat($tab3, '&lt;xsl:with-param name=&quot;viewport&quot;&gt;', /Data/WTENTITY/WTWEBPAGE/@viewport, '&lt;/xsl:with-param&gt;', $cr)"/>
					</xsl:if>
					<xsl:if test="/Data/WTENTITY/WTWEBPAGE/@meta">
						<xsl:value-of select="concat($tab3, '&lt;xsl:with-param name=&quot;meta&quot;&gt;1&lt;/xsl:with-param&gt;', $cr)"/>
					</xsl:if>

					<xsl:if test="$translate='true'">
						<xsl:if test="/Data/WTENTITY/WTWEBPAGE/@translate">
							<xsl:value-of select="concat($tab3, '&lt;xsl:with-param name=&quot;translate&quot;&gt;', /Data/WTENTITY/WTWEBPAGE/@translate, '&lt;/xsl:with-param&gt;', $cr)"/>
						</xsl:if>
						<xsl:if test="not(/Data/WTENTITY/WTWEBPAGE/@translate)">
							<xsl:if test="/Data/WTPAGE/@translate">
								<xsl:value-of select="concat($tab3, '&lt;xsl:with-param name=&quot;translate&quot;&gt;', /Data/WTPAGE/@translate, '&lt;/xsl:with-param&gt;', $cr)"/>
							</xsl:if>
						</xsl:if>
					</xsl:if>

					<xsl:if test="/Data/WTENTITY/WTWEBPAGE/@og">
						<xsl:if test="/Data/WTENTITY/WTWEBPAGE/WTPARAM/@name='ogtitle'">
							<xsl:value-of select="concat($tab3, '&lt;xsl:with-param name=&quot;ogtitle&quot;&gt;', '&lt;xsl:value-of select=&quot;/DATA/PARAM/@ogtitle&quot;/&gt;', '&lt;/xsl:with-param&gt;', $cr)"/>
						</xsl:if>
						<xsl:if test="/Data/WTENTITY/WTWEBPAGE/WTPARAM/@name='ogimage'">
							<xsl:value-of select="concat($tab3, '&lt;xsl:with-param name=&quot;ogimage&quot;&gt;', '&lt;xsl:value-of select=&quot;/DATA/PARAM/@ogimage&quot;/&gt;', '&lt;/xsl:with-param&gt;', $cr)"/>
						</xsl:if>
					</xsl:if>
					<xsl:if test="/Data/WTENTITY/WTWEBPAGE/WTCONTENT/WTINCLUDE">
						<xsl:value-of select="concat($tab3, '&lt;xsl:with-param name=&quot;include&quot; select=&quot;', $apos, /Data/WTENTITY/WTWEBPAGE/WTCONTENT/WTINCLUDE/@name, $apos, '&quot;/&gt;', $cr)"/>
					</xsl:if>
					<xsl:value-of select="concat($tab2, '&lt;/xsl:call-template&gt;', $cr, $cr)"/>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>

		<!-- Include the Flash Loader JavaScript -->
		<xsl:if test="count(/Data/WTENTITY/WTWEBPAGE/WTCONTENT//WTFLASH)&gt;0">
			<xsl:value-of select="concat($tab2, '&lt;xsl:element name=&quot;SCRIPT&quot;&gt;', $cr)"/>
			<xsl:value-of select="concat($tab3, '&lt;xsl:attribute name=&quot;language&quot;&gt;JavaScript&lt;/xsl:attribute&gt;', $cr)"/>
			<xsl:value-of select="concat($tab3, '&lt;xsl:attribute name=&quot;src&quot;&gt;Include/swfobject.js&lt;/xsl:attribute&gt;', $cr)"/>
			<xsl:value-of select="concat($tab3, '&lt;xsl:text&gt; &lt;/xsl:text&gt;', $cr)"/>
			<xsl:value-of select="concat($tab2, '&lt;/xsl:element&gt;', $cr, $cr)"/>
		</xsl:if>
		<xsl:if test="$IsJQuery='true'">
			<xsl:value-of select="concat($tab2, '&lt;xsl:element name=&quot;SCRIPT&quot;&gt;', $cr)"/>
			<xsl:value-of select="concat($tab3, '&lt;xsl:attribute name=&quot;type&quot;&gt;text/javascript&lt;/xsl:attribute&gt;', $cr)"/>
			<xsl:value-of select="concat($tab3, '&lt;xsl:attribute name=&quot;src&quot;&gt;https://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js&lt;/xsl:attribute&gt;', $cr)"/>
			<xsl:value-of select="concat($tab3, '&lt;xsl:text&gt; &lt;/xsl:text&gt;', $cr)"/>
			<xsl:value-of select="concat($tab2, '&lt;/xsl:element&gt;', $cr, $cr)"/>
		</xsl:if>
		<!--==========WTSCROLL==========-->
		<xsl:if test="$IsScroll='true'">
			<xsl:value-of select="concat($tab2, '&lt;xsl:element name=&quot;SCRIPT&quot;&gt;', $cr)"/>
			<xsl:value-of select="concat($tab3, '&lt;xsl:attribute name=&quot;type&quot;&gt;text/javascript&lt;/xsl:attribute&gt;', $cr)"/>
			<xsl:value-of select="concat($tab3, '&lt;xsl:attribute name=&quot;src&quot;&gt;include/simplyscroll/jquery.simplyscroll.min.js&lt;/xsl:attribute&gt;', $cr)"/>
			<xsl:value-of select="concat($tab3, '&lt;xsl:text&gt; &lt;/xsl:text&gt;', $cr)"/>
			<xsl:value-of select="concat($tab2, '&lt;/xsl:element&gt;', $cr, $cr)"/>

			<xsl:value-of select="concat($tab2, '&lt;xsl:element name=&quot;LINK&quot;&gt;', $cr)"/>
			<xsl:value-of select="concat($tab3, '&lt;xsl:attribute name=&quot;rel&quot;&gt;stylesheet&lt;/xsl:attribute&gt;', $cr)"/>
			<xsl:value-of select="concat($tab3, '&lt;xsl:attribute name=&quot;type&quot;&gt;text/css&lt;/xsl:attribute&gt;', $cr)"/>
			<xsl:value-of select="concat($tab3, '&lt;xsl:attribute name=&quot;href&quot;&gt;include/simplyscroll/jquery.simplyscroll.css&lt;/xsl:attribute&gt;', $cr)"/>
			<xsl:value-of select="concat($tab3, '&lt;xsl:attribute name=&quot;media&quot;&gt;all&lt;/xsl:attribute&gt;', $cr)"/>
			<xsl:value-of select="concat($tab2, '&lt;/xsl:element&gt;', $cr, $cr)"/>

			<xsl:for-each select="/Data/WTENTITY/WTWEBPAGE/WTCONTENT/descendant::*[name()='WTSCROLL']">
				<xsl:call-template name="ScrollHeader">
					<xsl:with-param name="indent">2</xsl:with-param>
				</xsl:call-template>
			</xsl:for-each>
		</xsl:if>
		<!--==========WTSCROLL2==========-->
		<xsl:if test="$IsScroll2='true'">
			<xsl:value-of select="concat($tab2, '&lt;xsl:element name=&quot;SCRIPT&quot;&gt;', $cr)"/>
			<xsl:value-of select="concat($tab3, '&lt;xsl:attribute name=&quot;type&quot;&gt;text/javascript&lt;/xsl:attribute&gt;', $cr)"/>
			<xsl:value-of select="concat($tab3, '&lt;xsl:attribute name=&quot;src&quot;&gt;include/jcarousel/jquery.jcarousel.min.js&lt;/xsl:attribute&gt;', $cr)"/>
			<xsl:value-of select="concat($tab3, '&lt;xsl:text&gt; &lt;/xsl:text&gt;', $cr)"/>
			<xsl:value-of select="concat($tab2, '&lt;/xsl:element&gt;', $cr, $cr)"/>

			<xsl:for-each select="/Data/WTENTITY/WTWEBPAGE/WTCONTENT/descendant::*[name()='WTSCROLL2']">
				<xsl:call-template name="Scroll2Header">
					<xsl:with-param name="indent">2</xsl:with-param>
				</xsl:call-template>
			</xsl:for-each>
		</xsl:if>
		<!--==========WTSLIDE==========-->
		<xsl:if test="$IsSlide='true'">
			<xsl:value-of select="concat($tab2, '&lt;xsl:element name=&quot;SCRIPT&quot;&gt;', $cr)"/>
			<xsl:value-of select="concat($tab3, '&lt;xsl:attribute name=&quot;type&quot;&gt;text/javascript&lt;/xsl:attribute&gt;', $cr)"/>
			<xsl:value-of select="concat($tab3, '&lt;xsl:attribute name=&quot;src&quot;&gt;include/refineslide/jquery.refineslide.min.js&lt;/xsl:attribute&gt;', $cr)"/>
			<xsl:value-of select="concat($tab3, '&lt;xsl:text&gt; &lt;/xsl:text&gt;', $cr)"/>
			<xsl:value-of select="concat($tab2, '&lt;/xsl:element&gt;', $cr, $cr)"/>

			<xsl:value-of select="concat($tab2, '&lt;xsl:element name=&quot;LINK&quot;&gt;', $cr)"/>
			<xsl:value-of select="concat($tab3, '&lt;xsl:attribute name=&quot;rel&quot;&gt;stylesheet&lt;/xsl:attribute&gt;', $cr)"/>
			<xsl:value-of select="concat($tab3, '&lt;xsl:attribute name=&quot;type&quot;&gt;text/css&lt;/xsl:attribute&gt;', $cr)"/>
			<xsl:value-of select="concat($tab3, '&lt;xsl:attribute name=&quot;href&quot;&gt;include/refineslide/refineslide.css&lt;/xsl:attribute&gt;', $cr)"/>
			<xsl:value-of select="concat($tab3, '&lt;xsl:attribute name=&quot;media&quot;&gt;all&lt;/xsl:attribute&gt;', $cr)"/>
			<xsl:value-of select="concat($tab2, '&lt;/xsl:element&gt;', $cr, $cr)"/>

			<xsl:for-each select="/Data/WTENTITY/WTWEBPAGE/WTCONTENT/descendant::*[name()='WTSLIDE']">
				<xsl:call-template name="SlideHeader">
					<xsl:with-param name="indent">2</xsl:with-param>
				</xsl:call-template>
			</xsl:for-each>
		</xsl:if>
		<!--==========WTSLIDE2==========-->
		<xsl:if test="$IsSlide2='true'">
			<xsl:value-of select="concat($tab2, '&lt;xsl:element name=&quot;SCRIPT&quot;&gt;', $cr)"/>
			<xsl:value-of select="concat($tab3, '&lt;xsl:attribute name=&quot;type&quot;&gt;text/javascript&lt;/xsl:attribute&gt;', $cr)"/>
			<xsl:value-of select="concat($tab3, '&lt;xsl:attribute name=&quot;src&quot;&gt;include/basicslide/bjqs-1.3.min.js&lt;/xsl:attribute&gt;', $cr)"/>
			<xsl:value-of select="concat($tab3, '&lt;xsl:text&gt; &lt;/xsl:text&gt;', $cr)"/>
			<xsl:value-of select="concat($tab2, '&lt;/xsl:element&gt;', $cr, $cr)"/>

			<xsl:value-of select="concat($tab2, '&lt;xsl:element name=&quot;LINK&quot;&gt;', $cr)"/>
			<xsl:value-of select="concat($tab3, '&lt;xsl:attribute name=&quot;rel&quot;&gt;stylesheet&lt;/xsl:attribute&gt;', $cr)"/>
			<xsl:value-of select="concat($tab3, '&lt;xsl:attribute name=&quot;type&quot;&gt;text/css&lt;/xsl:attribute&gt;', $cr)"/>
			<xsl:value-of select="concat($tab3, '&lt;xsl:attribute name=&quot;href&quot;&gt;include/basicslide/bjqs.css&lt;/xsl:attribute&gt;', $cr)"/>
			<xsl:value-of select="concat($tab3, '&lt;xsl:attribute name=&quot;media&quot;&gt;all&lt;/xsl:attribute&gt;', $cr)"/>
			<xsl:value-of select="concat($tab2, '&lt;/xsl:element&gt;', $cr, $cr)"/>

			<xsl:for-each select="/Data/WTENTITY/WTWEBPAGE/WTCONTENT/descendant::*[name()='WTSLIDE2']">
				<xsl:call-template name="Slide2Header">
					<xsl:with-param name="indent">2</xsl:with-param>
				</xsl:call-template>
			</xsl:for-each>
		</xsl:if>

    <!--==========WTOSMAP==========-->
    <xsl:if test="$IsOSMap='true'">
      <xsl:value-of select="concat($tab2, '&lt;xsl:element name=&quot;SCRIPT&quot;&gt;', $cr)"/>
      <xsl:value-of select="concat($tab3, '&lt;xsl:attribute name=&quot;type&quot;&gt;text/javascript&lt;/xsl:attribute&gt;', $cr)"/>
      <xsl:value-of select="concat($tab3, '&lt;xsl:attribute name=&quot;src&quot;&gt;include/leaflet.js&lt;/xsl:attribute&gt;', $cr)"/>
      <xsl:value-of select="concat($tab3, '&lt;xsl:text&gt; &lt;/xsl:text&gt;', $cr)"/>
      <xsl:value-of select="concat($tab2, '&lt;/xsl:element&gt;', $cr, $cr)"/>

      <xsl:value-of select="concat($tab2, '&lt;xsl:element name=&quot;LINK&quot;&gt;', $cr)"/>
      <xsl:value-of select="concat($tab3, '&lt;xsl:attribute name=&quot;rel&quot;&gt;stylesheet&lt;/xsl:attribute&gt;', $cr)"/>
      <xsl:value-of select="concat($tab3, '&lt;xsl:attribute name=&quot;type&quot;&gt;text/css&lt;/xsl:attribute&gt;', $cr)"/>
      <xsl:value-of select="concat($tab3, '&lt;xsl:attribute name=&quot;href&quot;&gt;include/leaflet.css&lt;/xsl:attribute&gt;', $cr)"/>
      <xsl:value-of select="concat($tab2, '&lt;/xsl:element&gt;', $cr, $cr)"/>

      <xsl:if test="$IsOSMapFullScreen='true'">
        <xsl:value-of select="concat($tab2, '&lt;xsl:element name=&quot;SCRIPT&quot;&gt;', $cr)"/>
        <xsl:value-of select="concat($tab3, '&lt;xsl:attribute name=&quot;type&quot;&gt;text/javascript&lt;/xsl:attribute&gt;', $cr)"/>
        <xsl:value-of select="concat($tab3, '&lt;xsl:attribute name=&quot;src&quot;&gt;include/control.FullScreen.js&lt;/xsl:attribute&gt;', $cr)"/>
        <xsl:value-of select="concat($tab3, '&lt;xsl:text&gt; &lt;/xsl:text&gt;', $cr)"/>
        <xsl:value-of select="concat($tab2, '&lt;/xsl:element&gt;', $cr, $cr)"/>

        <xsl:value-of select="concat($tab2, '&lt;xsl:element name=&quot;LINK&quot;&gt;', $cr)"/>
        <xsl:value-of select="concat($tab3, '&lt;xsl:attribute name=&quot;rel&quot;&gt;stylesheet&lt;/xsl:attribute&gt;', $cr)"/>
        <xsl:value-of select="concat($tab3, '&lt;xsl:attribute name=&quot;type&quot;&gt;text/css&lt;/xsl:attribute&gt;', $cr)"/>
        <xsl:value-of select="concat($tab3, '&lt;xsl:attribute name=&quot;href&quot;&gt;include/control.FullScreen.css&lt;/xsl:attribute&gt;', $cr)"/>
        <xsl:value-of select="concat($tab2, '&lt;/xsl:element&gt;', $cr, $cr)"/>
      </xsl:if>
    </xsl:if>


    <xsl:if test="$MenuBar!='' or $IsTree2='true' or $IsMenuTree='true' or $IsMenu='true' or $IsTab='true'">
			<xsl:value-of select="concat($tab2, '&lt;xsl:element name=&quot;SCRIPT&quot;&gt;', $cr)"/>
			<xsl:value-of select="concat($tab3, '&lt;xsl:attribute name=&quot;language&quot;&gt;JavaScript&lt;/xsl:attribute&gt;', $cr)"/>
			<xsl:value-of select="concat($tab3, '&lt;xsl:attribute name=&quot;src&quot;&gt;Include/codethatsdk.js&lt;/xsl:attribute&gt;', $cr)"/>
			<xsl:value-of select="concat($tab3, '&lt;xsl:text&gt; &lt;/xsl:text&gt;', $cr)"/>
			<xsl:value-of select="concat($tab2, '&lt;/xsl:element&gt;', $cr, $cr)"/>
		</xsl:if>

		<xsl:if test="$MenuBar!=''">
			<xsl:value-of select="concat($tab2, '&lt;xsl:element name=&quot;SCRIPT&quot;&gt;', $cr)"/>
			<xsl:value-of select="concat($tab3, '&lt;xsl:attribute name=&quot;language&quot;&gt;JavaScript&lt;/xsl:attribute&gt;', $cr)"/>
			<xsl:value-of select="concat($tab3, '&lt;xsl:attribute name=&quot;src&quot;&gt;Include/codethatxpbarpro.js&lt;/xsl:attribute&gt;', $cr)"/>
			<xsl:value-of select="concat($tab3, '&lt;xsl:text&gt; &lt;/xsl:text&gt;', $cr)"/>
			<xsl:value-of select="concat($tab2, '&lt;/xsl:element&gt;', $cr, $cr)"/>
		</xsl:if>

		<xsl:if test="$IsMenu='true'">
			<xsl:value-of select="concat($tab2, '&lt;xsl:element name=&quot;SCRIPT&quot;&gt;', $cr)"/>
			<xsl:value-of select="concat($tab3, '&lt;xsl:attribute name=&quot;language&quot;&gt;JavaScript&lt;/xsl:attribute&gt;', $cr)"/>
			<xsl:value-of select="concat($tab3, '&lt;xsl:attribute name=&quot;src&quot;&gt;Include/codethatmenupro.js&lt;/xsl:attribute&gt;', $cr)"/>
			<xsl:value-of select="concat($tab3, '&lt;xsl:text&gt; &lt;/xsl:text&gt;', $cr)"/>
			<xsl:value-of select="concat($tab2, '&lt;/xsl:element&gt;', $cr, $cr)"/>
		</xsl:if>

		<xsl:if test="$IsTab='true'">
			<xsl:value-of select="concat($tab2, '&lt;xsl:element name=&quot;SCRIPT&quot;&gt;', $cr)"/>
			<xsl:value-of select="concat($tab3, '&lt;xsl:attribute name=&quot;language&quot;&gt;JavaScript&lt;/xsl:attribute&gt;', $cr)"/>
			<xsl:value-of select="concat($tab3, '&lt;xsl:attribute name=&quot;src&quot;&gt;Include/codethattabpro.js&lt;/xsl:attribute&gt;', $cr)"/>
			<xsl:value-of select="concat($tab3, '&lt;xsl:text&gt; &lt;/xsl:text&gt;', $cr)"/>
			<xsl:value-of select="concat($tab2, '&lt;/xsl:element&gt;', $cr, $cr)"/>
		</xsl:if>

		<xsl:if test="$IsTree2='true' or $IsMenuTree='true'">
			<xsl:value-of select="concat($tab2, '&lt;xsl:element name=&quot;SCRIPT&quot;&gt;', $cr)"/>
			<xsl:value-of select="concat($tab3, '&lt;xsl:attribute name=&quot;language&quot;&gt;JavaScript&lt;/xsl:attribute&gt;', $cr)"/>
			<xsl:value-of select="concat($tab3, '&lt;xsl:attribute name=&quot;src&quot;&gt;Include/codethattreepro.js&lt;/xsl:attribute&gt;', $cr)"/>
			<xsl:value-of select="concat($tab3, '&lt;xsl:text&gt; &lt;/xsl:text&gt;', $cr)"/>
			<xsl:value-of select="concat($tab2, '&lt;/xsl:element&gt;', $cr, $cr)"/>
		</xsl:if>
		<!--
		<xsl:if test="count(/Data/WTENTITY/WTWEBPAGE/WTTRACK) &gt; 0">
			<xsl:value-of select="concat($tab2, '&lt;xsl:element name=&quot;SCRIPT&quot;&gt;', $cr)"/>
			<xsl:value-of select="concat($tab3, '&lt;xsl:attribute name=&quot;language&quot;&gt;JavaScript&lt;/xsl:attribute&gt;', $cr)"/>
			<xsl:value-of select="concat($tab3, '&lt;xsl:attribute name=&quot;src&quot;&gt;Include/GATrack.js&lt;/xsl:attribute&gt;', $cr)"/>
			<xsl:value-of select="concat($tab3, '&lt;xsl:text&gt; &lt;/xsl:text&gt;', $cr)"/>
			<xsl:value-of select="concat($tab2, '&lt;/xsl:element&gt;', $cr, $cr)"/>
		</xsl:if>
		-->
		<xsl:for-each select="/Data/WTENTITY/WTWEBPAGE/WTSTYLESHEET">
			<xsl:value-of select="concat($tab2, '&lt;xsl:element name=&quot;link&quot;&gt;', $cr)"/>
			<xsl:value-of select="concat($tab3, '&lt;xsl:attribute name=&quot;rel&quot;&gt;stylesheet&lt;/xsl:attribute&gt;', $cr)"/>
			<xsl:value-of select="concat($tab3, '&lt;xsl:attribute name=&quot;type&quot;&gt;text/css&lt;/xsl:attribute&gt;', $cr)"/>
			<xsl:value-of select="concat($tab3, '&lt;xsl:attribute name=&quot;href&quot;&gt;include/', @name, '&lt;/xsl:attribute&gt;', $cr)"/>
			<xsl:value-of select="concat($tab2, '&lt;/xsl:element&gt;', $cr, $cr)"/>
		</xsl:for-each>

		<xsl:for-each select="/Data/WTENTITY/WTWEBPAGE/WTJAVASCRIPT">
			<xsl:value-of select="concat($tab2, '&lt;xsl:element name=&quot;SCRIPT&quot;&gt;', $cr)"/>
			<xsl:value-of select="concat($tab3, '&lt;xsl:attribute name=&quot;language&quot;&gt;JavaScript&lt;/xsl:attribute&gt;', $cr)"/>
			<xsl:value-of select="concat($tab3, '&lt;xsl:attribute name=&quot;src&quot;&gt;Include/', @name, '&lt;/xsl:attribute&gt;', $cr)"/>
			<xsl:value-of select="concat($tab3, '&lt;xsl:text&gt; &lt;/xsl:text&gt;', $cr)"/>
			<xsl:value-of select="concat($tab2, '&lt;/xsl:element&gt;', $cr, $cr)"/>
		</xsl:for-each>

		<xsl:if test="$MenuBar!='' or count(/Data/WTENTITY/WTWEBPAGE/WTCONTENT/WTMENU)&gt;0">
			<xsl:value-of select="concat($tab2, '&lt;xsl:call-template name=&quot;DefineMenu&quot;/&gt;', $cr, $cr)"/>
<!--
			<xsl:if test="/Data/WTENTITY/WTWEBPAGE/@contentpage">
				<xsl:value-of select="concat($tab2, '&lt;xsl:if test=&quot;/DATA/PARAM/@contentpage=0&quot;&gt;', $cr)"/>
					<xsl:value-of select="concat($tab3, '&lt;xsl:call-template name=&quot;DefineMenu&quot;/&gt;', $cr)"/>
				<xsl:value-of select="concat($tab2, '&lt;/xsl:if&gt;', $cr, $cr)"/>
			</xsl:if>
			<xsl:if test="not(/Data/WTENTITY/WTWEBPAGE/@contentpage)">
				<xsl:value-of select="concat($tab2, '&lt;xsl:call-template name=&quot;DefineMenu&quot;/&gt;', $cr, $cr)"/>
			</xsl:if>
-->
		</xsl:if>

		<xsl:if test="count(/Data/WTENTITY/WTWEBPAGE/WTCONTENT/WTTAB)&gt;0">
			<xsl:value-of select="concat($tab2, '&lt;xsl:call-template name=&quot;DefineTab&quot;/&gt;', $cr, $cr)"/>
		</xsl:if>
<!--
			<xsl:if test="$MenuBar!=''">
				<xsl:value-of select="concat($tab2, '&lt;xsl:element name=&quot;SCRIPT&quot;&gt;', $cr)"/>
				<xsl:value-of select="concat($tab3, '&lt;xsl:attribute name=&quot;language&quot;&gt;JavaScript&lt;/xsl:attribute&gt;', $cr)"/>
				<xsl:value-of select="concat($tab3, 'var ', $MenuBar, ' = new CMenu(', $MenuBar, 'Def, ', $apos, $MenuBar, $apos, '); ', $MenuBar, '.create(); ', $MenuBar, '.run();', $cr)"/>
				<xsl:value-of select="concat($tab2, '&lt;/xsl:element&gt;', $cr, $cr)"/>
			</xsl:if>
-->

		<xsl:variable name="color">
			<xsl:choose>
				<xsl:when test="/Data/WTENTITY/WTWEBPAGE/@page-color"><xsl:value-of select="/Data/WTENTITY/WTWEBPAGE/@page-color"/></xsl:when>
				<xsl:when test="/Data/WTPAGE/@page-color"><xsl:value-of select="/Data/WTPAGE/@page-color"/></xsl:when>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="background">
			<xsl:choose>
				<xsl:when test="/Data/WTENTITY/WTWEBPAGE/@page-image"><xsl:value-of select="/Data/WTENTITY/WTWEBPAGE/@page-image"/></xsl:when>
				<xsl:when test="/Data/WTPAGE/@page-image"><xsl:value-of select="/Data/WTPAGE/@page-image"/></xsl:when>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="topmargin">
			<xsl:choose>
				<xsl:when test="/Data/WTENTITY/WTWEBPAGE/@page-top"><xsl:value-of select="/Data/WTENTITY/WTWEBPAGE/@page-top"/></xsl:when>
				<xsl:when test="/Data/WTPAGE/@page-top"><xsl:value-of select="/Data/WTPAGE/@page-top"/></xsl:when>
				<xsl:otherwise>0</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="leftmargin">
			<xsl:choose>
				<xsl:when test="/Data/WTENTITY/WTWEBPAGE/@page-left"><xsl:value-of select="/Data/WTENTITY/WTWEBPAGE/@page-left"/></xsl:when>
				<xsl:when test="/Data/WTPAGE/@page-left"><xsl:value-of select="/Data/WTPAGE/@page-left"/></xsl:when>
				<xsl:otherwise>0</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:if test="/Data/WTENTITY/WTWEBPAGE/@css">
			<xsl:value-of select="concat($tab2, '&lt;xsl:call-template name=&quot;', /Data/WTENTITY/WTWEBPAGE/@css, '&quot;/&gt;', $cr, $cr)"/>
		</xsl:if>
		
		<xsl:variable name="printtype"><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="/Data/WTENTITY/WTWEBPAGE/@print"/></xsl:call-template></xsl:variable>
		<xsl:variable name="printtext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="/Data/WTENTITY/WTWEBPAGE/@print"/></xsl:call-template></xsl:variable>
		<xsl:variable name="printentity"><xsl:call-template name="QualifiedPrefix"><xsl:with-param name="value" select="/Data/WTENTITY/WTWEBPAGE/@print"/></xsl:call-template></xsl:variable>

		<xsl:if test="/Data/WTENTITY/WTWEBPAGE/@print">
			<xsl:value-of select="concat($tab2, '&lt;xsl:element name=&quot;link&quot;&gt;', $cr)"/>
			<xsl:value-of select="concat($tab3, '&lt;xsl:attribute name=&quot;rel&quot;&gt;alternate&lt;/xsl:attribute&gt;', $cr)"/>
			<xsl:value-of select="concat($tab3, '&lt;xsl:attribute name=&quot;media&quot;&gt;print&lt;/xsl:attribute&gt;', $cr)"/>
			
			<xsl:value-of select="concat($tab3, '&lt;xsl:attribute name=&quot;href&quot;&gt;')"/>
			<xsl:call-template name="GetValue">
		  		 <xsl:with-param name="type" select="$printtype"/>
		  		 <xsl:with-param name="text" select="$printtext"/>
		  		 <xsl:with-param name="entity" select="$printentity"/>
		  		 <xsl:with-param name="output" select="true()"/>
		  	</xsl:call-template>
			<xsl:value-of select="concat('&lt;/xsl:attribute&gt;', $cr)"/>
	<!--		<xsl:value-of select="concat($tab3, '&lt;xsl:attribute name=&quot;href&quot;&gt;', /Data/WTENTITY/WTWEBPAGE/@print, '&lt;/xsl:attribute&gt;', $cr)"/> -->
			<xsl:value-of select="concat($tab2, '&lt;/xsl:element&gt;', $cr, $cr)"/>
		</xsl:if>

		<xsl:call-template name="XSLComment">
			<xsl:with-param name="indent">2</xsl:with-param>
			<xsl:with-param name="value">BEGIN BODY</xsl:with-param>
		</xsl:call-template>

		<xsl:value-of select="concat($tab2, '&lt;xsl:element name=&quot;BODY&quot;&gt;', $cr)"/>

		<xsl:if test="/Data/WTENTITY/WTWEBPAGE/@contentpage">
			<xsl:value-of select="concat($tab3, '&lt;xsl:if test=&quot;/DATA/PARAM/@contentpage=1 or /DATA/PARAM/@contentpage=3&quot;&gt;', $cr)"/>
				<xsl:value-of select="concat($tab4, '&lt;xsl:attribute name=&quot;topmargin&quot;&gt;', 0, '&lt;/xsl:attribute&gt;', $cr)"/>
				<xsl:value-of select="concat($tab4, '&lt;xsl:attribute name=&quot;leftmargin&quot;&gt;', 0, '&lt;/xsl:attribute&gt;', $cr)"/>
			<xsl:value-of select="concat($tab3, '&lt;/xsl:if&gt;', $cr)"/>
			<xsl:value-of select="concat($tab3, '&lt;xsl:if test=&quot;/DATA/PARAM/@contentpage!=1 and /DATA/PARAM/@contentpage!=3&quot;&gt;', $cr)"/>
				<xsl:value-of select="concat($tab4, '&lt;xsl:attribute name=&quot;topmargin&quot;&gt;', $topmargin, '&lt;/xsl:attribute&gt;', $cr)"/>
				<xsl:value-of select="concat($tab4, '&lt;xsl:attribute name=&quot;leftmargin&quot;&gt;', $leftmargin, '&lt;/xsl:attribute&gt;', $cr)"/>
			<xsl:value-of select="concat($tab3, '&lt;/xsl:if&gt;', $cr)"/>
		</xsl:if>
		<xsl:if test="not(/Data/WTENTITY/WTWEBPAGE/@contentpage)">
			<xsl:value-of select="concat($tab3, '&lt;xsl:attribute name=&quot;topmargin&quot;&gt;', $topmargin, '&lt;/xsl:attribute&gt;', $cr)"/>
			<xsl:value-of select="concat($tab3, '&lt;xsl:attribute name=&quot;leftmargin&quot;&gt;', $leftmargin, '&lt;/xsl:attribute&gt;', $cr)"/>
		</xsl:if>

		<!-- If using system colors, use the system page color if provided, otherwise use page color if provided -->
		<xsl:if test="/Data/WTENTITY/WTWEBPAGE/@system-colors or /Data/WTPAGE/@system-colors">
			<xsl:value-of select="concat($tab3, '&lt;xsl:if test=&quot;/DATA/SYSTEM/@pagecolor!=', $apos, $apos,'&quot;&gt;', $cr)"/>
			<xsl:value-of select="concat($tab4, '&lt;xsl:attribute name=&quot;bgcolor&quot;&gt;#&lt;xsl:value-of select=&quot;/DATA/SYSTEM/@pagecolor&quot;/&gt;&lt;/xsl:attribute&gt;', $cr)"/>
			<xsl:value-of select="concat($tab3, '&lt;/xsl:if&gt;', $cr)"/>
			<xsl:value-of select="concat($tab3, '&lt;xsl:if test=&quot;/DATA/SYSTEM/@linkcolor!=', $apos, $apos,'&quot;&gt;', $cr)"/>
			<xsl:value-of select="concat($tab4, '&lt;xsl:attribute name=&quot;link&quot;&gt;#&lt;xsl:value-of select=&quot;/DATA/SYSTEM/@linkcolor&quot;/&gt;&lt;/xsl:attribute&gt;', $cr)"/>
			<xsl:value-of select="concat($tab4, '&lt;xsl:attribute name=&quot;alink&quot;&gt;#&lt;xsl:value-of select=&quot;/DATA/SYSTEM/@linkcolor&quot;/&gt;&lt;/xsl:attribute&gt;', $cr)"/>
			<xsl:value-of select="concat($tab4, '&lt;xsl:attribute name=&quot;vlink&quot;&gt;#&lt;xsl:value-of select=&quot;/DATA/SYSTEM/@linkcolor&quot;/&gt;&lt;/xsl:attribute&gt;', $cr)"/>
			<xsl:value-of select="concat($tab3, '&lt;/xsl:if&gt;', $cr)"/>
		</xsl:if>
		<xsl:if test="not(/Data/WTENTITY/WTWEBPAGE/@system-colors or /Data/WTPAGE/@system-colors)">
			<xsl:if test="$color!=''">
		 		<xsl:variable name="bgcolor"><xsl:call-template name="GetColor"><xsl:with-param name="color" select="$color"/></xsl:call-template></xsl:variable>
				<xsl:value-of select="concat($tab3, '&lt;xsl:attribute name=&quot;bgcolor&quot;&gt;', $bgcolor, '&lt;/xsl:attribute&gt;', $cr)"/>
			</xsl:if>
		</xsl:if>

		<!-- If using system colors, use the system page image if provided, otherwise use page image if provided -->
		<xsl:if test="/Data/WTENTITY/WTWEBPAGE/@system-colors or /Data/WTPAGE/@system-colors">
			<xsl:value-of select="concat($tab3, '&lt;xsl:variable name=&quot;pageimagefolder&quot;&gt;', $cr)"/>
			<xsl:value-of select="concat($tab4, '&lt;xsl:if test=&quot;/DATA/SYSTEM/@pageimagefolder!=', $apos, $apos,'&quot;&gt;', $cr)"/>
			<xsl:value-of select="concat($tab5, '&lt;xsl:value-of select=&quot;/DATA/SYSTEM/@pageimagefolder&quot;/&gt;&lt;xsl:text&gt;\&lt;/xsl:text&gt;', $cr)"/>
			<xsl:value-of select="concat($tab4, '&lt;/xsl:if&gt;', $cr)"/>
			<xsl:value-of select="concat($tab3, '&lt;/xsl:variable&gt;', $cr)"/>

			<xsl:value-of select="concat($tab3, '&lt;xsl:if test=&quot;/DATA/SYSTEM/@pageimage!=', $apos, $apos,'&quot;&gt;', $cr)"/>
			<xsl:value-of select="concat($tab4, '&lt;xsl:attribute name=&quot;background&quot;&gt;Images/&lt;xsl:value-of select=&quot;$pageimagefolder&quot;/&gt;&lt;xsl:value-of select=&quot;/DATA/SYSTEM/@pageimage&quot;/&gt;&lt;/xsl:attribute&gt;', $cr)"/>
			<xsl:value-of select="concat($tab3, '&lt;/xsl:if&gt;', $cr)"/>
			<xsl:value-of select="concat($tab3, '&lt;xsl:if test=&quot;/DATA/SYSTEM/@pageimagefixed!=', $apos, $apos,'&quot;&gt;', $cr)"/>
			<xsl:value-of select="concat($tab4, '&lt;xsl:attribute name=&quot;bgproperties&quot;&gt;fixed&lt;/xsl:attribute&gt;', $cr)"/>
			<xsl:value-of select="concat($tab3, '&lt;/xsl:if&gt;', $cr)"/>
		</xsl:if>
		<xsl:if test="not(/Data/WTENTITY/WTWEBPAGE/@system-colors or /Data/WTPAGE/@system-colors)">
			<xsl:if test="$background!=''">
				<xsl:if test="count(/Data/WTENTITY/WTWEBPAGE/WTPARAM[@name='PageImage'])!=0">
					<xsl:value-of select="concat($tab3, '&lt;xsl:variable name=&quot;background&quot;&gt;', $cr)"/>
					<xsl:value-of select="concat($tab4, '&lt;xsl:choose&gt;', $cr)"/>
					<xsl:value-of select="concat($tab5, '&lt;xsl:when test=&quot;string-length(/DATA/PARAM/@pageimage)!=0&quot;&gt;', $cr)"/>
					<xsl:value-of select="concat($tab6, '&lt;xsl:value-of select=&quot;/DATA/PARAM/@pageimage&quot;/&gt;', $cr)"/>
					<xsl:value-of select="concat($tab5, '&lt;/xsl:when&gt;', $cr)"/>
					<xsl:value-of select="concat($tab5, '&lt;xsl:otherwise&gt;', $background, '&lt;/xsl:otherwise&gt;', $cr)"/>
					<xsl:value-of select="concat($tab4, '&lt;/xsl:choose&gt;', $cr)"/>
					<xsl:value-of select="concat($tab3, '&lt;/xsl:variable&gt;', $cr)"/>
					<xsl:value-of select="concat($tab3, '&lt;xsl:attribute name=&quot;background&quot;&gt;Images/&lt;xsl:value-of select=&quot;$background&quot;/&gt;', '&lt;/xsl:attribute&gt;', $cr)"/>
				</xsl:if>

				<xsl:if test="count(/Data/WTENTITY/WTWEBPAGE/WTPARAM[@name='PageImage'])=0">
					<xsl:value-of select="concat($tab3, '&lt;xsl:attribute name=&quot;background&quot;&gt;Images/', $background, '&lt;/xsl:attribute&gt;', $cr)"/>
				</xsl:if>
			</xsl:if>
		</xsl:if>

		<!-- If using system colors, use the system text color if provided -->
		<xsl:if test="/Data/WTENTITY/WTWEBPAGE/@system-colors or /Data/WTPAGE/@system-colors">
			<xsl:value-of select="concat($tab3, '&lt;xsl:if test=&quot;/DATA/SYSTEM/@colortext!=', $apos, $apos,'&quot;&gt;', $cr)"/>
			<xsl:value-of select="concat($tab4, '&lt;xsl:attribute name=&quot;text&quot;&gt;#&lt;xsl:value-of select=&quot;/DATA/SYSTEM/@colortext&quot;/&gt;&lt;/xsl:attribute&gt;', $cr)"/>
			<xsl:value-of select="concat($tab3, '&lt;/xsl:if&gt;', $cr)"/>
		</xsl:if>

		<!-- If Specified, place a wrapper division around the entire page -->
		
		<xsl:if test="$errorhandling">
			<xsl:call-template name="ErrorHandler">
				<xsl:with-param name="content" select="$content"/>
			</xsl:call-template>
		</xsl:if>

		<!-- apply Division tags -->
		<xsl:apply-templates select="/Data/WTENTITY/WTWEBPAGE/WTCONTENT/WTDIVISION">
			<xsl:with-param name="indent">3</xsl:with-param>
		</xsl:apply-templates>

		<!--==========WTTREE==========-->
		<xsl:for-each select="/Data/WTENTITY/WTWEBPAGE/WTCONTENT/descendant::*[name()='WTTREE']">
			<xsl:call-template name="TreeJavaScript">
				<xsl:with-param name="indent">3</xsl:with-param>
			</xsl:call-template>
		</xsl:for-each>

		<!--==========WTTREE2==========-->
		<xsl:for-each select="/Data/WTENTITY/WTWEBPAGE/WTCONTENT/descendant::*[name()='WTTREE2']">
			<xsl:value-of select="concat($tab3, '&lt;xsl:call-template name=&quot;DefineTree', @entity, '&quot;/&gt;', $cr, $cr)"/>
		</xsl:for-each>

		<!-- Test for enabled JavaScript -->
		<xsl:if test="/Data/WTENTITY/WTWEBPAGE/@test-javascript or /Data/WTPAGE/@test-javascript">
			<xsl:value-of select="concat($tab3, '&lt;xsl:element name=&quot;NOSCRIPT&quot;&gt;', $cr)"/>
			<xsl:value-of select="concat($tab4, '&lt;xsl:element name=&quot;MARQUEE&quot;&gt;', $cr)"/>
			<xsl:value-of select="concat($tab5, '&lt;xsl:element name=&quot;FONT&quot;&gt;', $cr)"/>
			<xsl:value-of select="concat($tab6, '&lt;xsl:attribute name=&quot;size&quot;&gt;7&lt;/xsl:attribute&gt;', $cr)"/>
			<xsl:value-of select="concat($tab6, '&lt;xsl:attribute name=&quot;color&quot;&gt;red&lt;/xsl:attribute&gt;', $cr)"/>
			<xsl:value-of select="concat($tab6, '&lt;xsl:value-of select=&quot;/DATA/LANGUAGE/LABEL[@name=', $apos ,'NoScript', $apos ,']&quot;/&gt;', $cr)"/>
			<xsl:value-of select="concat($tab5, '&lt;/xsl:element&gt;', $cr)"/>
			<xsl:value-of select="concat($tab4, '&lt;/xsl:element&gt;', $cr)"/>
			<xsl:value-of select="concat($tab3, '&lt;/xsl:element&gt;', $cr, $cr)"/>
		</xsl:if>

		<xsl:call-template name="XSLComment">
			<xsl:with-param name="indent">3</xsl:with-param>
			<xsl:with-param name="value">BEGIN PAGE</xsl:with-param>
		</xsl:call-template>

		<xsl:variable name="border">
			<xsl:choose>
				<xsl:when test="/Data/WTENTITY/WTWEBPAGE/@test or /Data/WTPAGE/@test">1</xsl:when>
				<xsl:when test="@border"><xsl:value-of select="@border"/></xsl:when>
				<xsl:otherwise>0</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="align">
			<xsl:choose>
				<xsl:when test="/Data/WTPAGE/@align"><xsl:value-of select="/Data/WTPAGE/@align"/></xsl:when>
				<xsl:when test="/Data/WTENTITY/WTWEBPAGE/@align"><xsl:value-of select="/Data/WTENTITY/WTWEBPAGE/@align"/></xsl:when>
				<xsl:otherwise>left</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="inside-color">
			<xsl:choose>
				<xsl:when test="/Data/WTPAGE/@inside-color"><xsl:value-of select="/Data/WTPAGE/@inside-color"/></xsl:when>
				<xsl:when test="/Data/WTENTITY/WTWEBPAGE/@inside-color"><xsl:value-of select="/Data/WTENTITY/WTWEBPAGE/@inside-color"/></xsl:when>
				<xsl:otherwise></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:if test="$wrapper!=''">
			<xsl:value-of select="concat($tab2, '&lt;xsl:element name=&quot;DIV&quot;&gt;', $cr)"/>
			<xsl:value-of select="concat($tab3, '&lt;xsl:attribute name=&quot;id&quot;&gt;', $wrapper, '&lt;/xsl:attribute&gt;', $cr)"/>
			<xsl:if test="/Data/WTENTITY/WTWEBPAGE/@wrapper-style">
				<xsl:value-of select="concat($tab3, '&lt;xsl:attribute name=&quot;style&quot;&gt;', /Data/WTENTITY/WTWEBPAGE/@wrapper-style, '&lt;/xsl:attribute&gt;', $cr)"/>
			</xsl:if>
		</xsl:if>

		<xsl:value-of select="concat($tab3, '&lt;xsl:element name=&quot;A&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($tab4, '&lt;xsl:attribute name=&quot;name&quot;&gt;top&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($tab3, '&lt;/xsl:element&gt;', $cr)"/>

		<xsl:value-of select="concat($tab3, '&lt;xsl:element name=&quot;TABLE&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($tab4, '&lt;xsl:attribute name=&quot;border&quot;&gt;', $border, '&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($tab4, '&lt;xsl:attribute name=&quot;cellpadding&quot;&gt;0&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($tab4, '&lt;xsl:attribute name=&quot;cellspacing&quot;&gt;0&lt;/xsl:attribute&gt;', $cr)"/>

		<xsl:if test="/Data/WTENTITY/WTWEBPAGE/@contentpage">
			<xsl:value-of select="concat($tab4, '&lt;xsl:if test=&quot;/DATA/PARAM/@contentpage=0&quot;&gt;', $cr)"/>
				<xsl:value-of select="concat($tab5, '&lt;xsl:attribute name=&quot;width&quot;&gt;', $pagewidth, '&lt;/xsl:attribute&gt;', $cr)"/>
			<xsl:value-of select="concat($tab4, '&lt;/xsl:if&gt;', $cr)"/>
			<xsl:value-of select="concat($tab4, '&lt;xsl:if test=&quot;/DATA/PARAM/@contentpage=1&quot;&gt;', $cr)"/>
				<xsl:value-of select="concat($tab5, '&lt;xsl:attribute name=&quot;width&quot;&gt;', $pagewidth - 150, '&lt;/xsl:attribute&gt;', $cr)"/>
			<xsl:value-of select="concat($tab4, '&lt;/xsl:if&gt;', $cr)"/>
			<xsl:value-of select="concat($tab4, '&lt;xsl:if test=&quot;/DATA/PARAM/@contentpage=2 or /DATA/PARAM/@contentpage=3&quot;&gt;', $cr)"/>
				<xsl:value-of select="concat($tab5, '&lt;xsl:attribute name=&quot;width&quot;&gt;', $pagewidth - 140, '&lt;/xsl:attribute&gt;', $cr)"/>
			<xsl:value-of select="concat($tab4, '&lt;/xsl:if&gt;', $cr)"/>
		</xsl:if>
		<xsl:if test="not(/Data/WTENTITY/WTWEBPAGE/@contentpage)">
			<xsl:value-of select="concat($tab4, '&lt;xsl:attribute name=&quot;width&quot;&gt;', $pagewidth, '&lt;/xsl:attribute&gt;', $cr)"/>
		</xsl:if>
		<xsl:if test="$inside-color!=''">
			<xsl:value-of select="concat($tab4, '&lt;xsl:attribute name=&quot;bgcolor&quot;&gt;', $inside-color, '&lt;/xsl:attribute&gt;', $cr)"/>
		</xsl:if>
		<xsl:value-of select="concat($tab4, '&lt;xsl:attribute name=&quot;align&quot;&gt;', $align, '&lt;/xsl:attribute&gt;', $cr, $cr)"/>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: XSL PAGE BEGIN -->
	<!-- returns the XSL for the beginning of each HTML page -->
	<!--==================================================================-->
	<xsl:template name="ErrorHandler">
	  	<xsl:param name="content"/>

		<xsl:value-of select="concat($tab3, '&lt;xsl:choose&gt;', $cr)"/>
		<xsl:value-of select="concat($tab4, '&lt;xsl:when test=&quot;(/DATA/ERROR)&quot;&gt;', $cr)"/>

		<xsl:value-of select="concat($tab5, '&lt;xsl:variable name=&quot;errnum&quot; select=&quot;/DATA/ERROR/@number&quot;/&gt;', $cr)"/>
		<xsl:value-of select="concat($tab5, '&lt;xsl:variable name=&quot;errmsg&quot; select=&quot;/DATA/LANGUAGE/LABEL[@name=$errnum]&quot;/&gt;', $cr)"/>

		<xsl:value-of select="concat($tab5, '&lt;xsl:choose&gt;', $cr)"/>
		<xsl:value-of select="concat($tab6, '&lt;xsl:when test=&quot;string-length($errmsg)&amp;gt;0&quot;&gt;', $cr)"/>

		<xsl:value-of select="concat($tab7, '&lt;xsl:variable name=&quot;msgval&quot; select=&quot;/DATA/ERROR/@msgval&quot;/&gt;', $cr)"/>
		<xsl:value-of select="concat($tab7, '&lt;xsl:variable name=&quot;msgfld&quot; select=&quot;/DATA/ERROR/@msgfld&quot;/&gt;', $cr)"/>
		<xsl:value-of select="concat($tab7, '&lt;xsl:variable name=&quot;errfld&quot; select=&quot;/DATA/LANGUAGE[*]/LABEL[@name=$msgfld]&quot;/&gt;', $cr)"/>
		<xsl:value-of select="concat($tab7, '&lt;xsl:variable name=&quot;errmsgfld&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($tab8, '&lt;xsl:choose&gt;', $cr)"/>
		<xsl:value-of select="concat($tab9, '&lt;xsl:when test=&quot;string-length($errfld)&amp;gt;0&quot;&gt;&lt;xsl:value-of select=&quot;$errfld&quot;/&gt;&lt;/xsl:when&gt;', $cr)"/>
		<xsl:value-of select="concat($tab9, '&lt;xsl:otherwise&gt;&lt;xsl:value-of select=&quot;$msgfld&quot;/&gt;&lt;/xsl:otherwise&gt;', $cr)"/>
		<xsl:value-of select="concat($tab8, '&lt;/xsl:choose&gt;', $cr)"/>
		<xsl:value-of select="concat($tab8, '&lt;xsl:if test=&quot;string-length($msgval)&amp;gt;0&quot;&gt;&lt;xsl:value-of select=&quot;concat(', $apos, ' (', $apos, ', $msgval, ', $apos, ')', $apos, ')&quot;/&gt;&lt;/xsl:if&gt;', $cr)"/>
		<xsl:value-of select="concat($tab7, '&lt;/xsl:variable&gt;', $cr)"/>

		<xsl:value-of select="concat($tab7, '&lt;xsl:attribute name=&quot;onLoad&quot;&gt;')"/>
		<xsl:if test="$content/WTLOAD">
		  <xsl:if test="not($content/WTLOAD/@escape)">
  			  <xsl:value-of select="concat('&lt;xsl:text disable-output-escaping=&quot;yes&quot;&gt;&lt;![CDATA[', $content/WTLOAD, ']]&gt;&lt;/xsl:text&gt;;')"/>
		  </xsl:if>
		  <xsl:if test="$content/WTLOAD/@escape">
  			  <xsl:value-of select="concat( $content/WTLOAD, ';')"/>
		  </xsl:if>
		</xsl:if>
		<xsl:if test="/Data/WTENTITY/WTWEBPAGE/@top">
			<xsl:value-of select="concat('location.hash=',$apos,'#top',$apos,';')"/>
		</xsl:if>
		<xsl:value-of select="concat('doErrorMsg(', $apos, '&lt;xsl:value-of select=&quot;concat($errmsg, $errmsgfld)&quot;/&gt;', $apos, ')&lt;/xsl:attribute&gt;', $cr)"/>

		<xsl:value-of select="concat($tab6, '&lt;/xsl:when&gt;', $cr)"/>
		<xsl:value-of select="concat($tab6, '&lt;xsl:otherwise&gt;', $cr)"/>

		<xsl:value-of select="concat($tab7, '&lt;xsl:attribute name=&quot;onLoad&quot;&gt;')"/>
		<xsl:if test="$content/WTLOAD">
		  <xsl:if test="not($content/WTLOAD/@escape)">
  			  <xsl:value-of select="concat('&lt;xsl:text disable-output-escaping=&quot;yes&quot;&gt;&lt;![CDATA[', $content/WTLOAD, ']]&gt;&lt;/xsl:text&gt;;')"/>
		  </xsl:if>
		  <xsl:if test="$content/WTLOAD/@escape">
  			  <xsl:value-of select="concat( $content/WTLOAD, ';')"/>
		  </xsl:if>
		</xsl:if>
		<xsl:if test="/Data/WTENTITY/WTWEBPAGE/@top">
			<xsl:value-of select="concat('location.hash=',$apos,'#top',$apos,';')"/>
		</xsl:if>
		<xsl:value-of select="concat('doErrorMsg(', $apos, '&lt;xsl:value-of select=&quot;/DATA/ERROR&quot;/&gt;', $apos, ')&lt;/xsl:attribute&gt;', $cr)"/>

		<xsl:value-of select="concat($tab6, '&lt;/xsl:otherwise&gt;', $cr)"/>
		<xsl:value-of select="concat($tab5, '&lt;/xsl:choose&gt;', $cr)"/>

		<xsl:value-of select="concat($tab4, '&lt;/xsl:when&gt;', $cr)"/>
	
		<xsl:value-of select="concat($tab4, '&lt;xsl:otherwise&gt;', $cr)"/>
	
		<xsl:if test="$content">
	
			<xsl:if test="not($content/WTLOAD)">
				<xsl:variable name="focus">
					<xsl:if test="not(/Data/WTENTITY/WTWEBPAGE/@focus='false')">
						<xsl:call-template name="GetFocus"/>
					</xsl:if>
				</xsl:variable>
				<xsl:if test="string-length($focus)&gt;0 or /Data/WTENTITY/WTWEBPAGE/@top">
					<xsl:value-of select="concat($tab5, '&lt;xsl:attribute name=&quot;onload&quot;&gt;')"/>
					<xsl:if test="/Data/WTENTITY/WTWEBPAGE/@top">
							<xsl:value-of select="concat('location.hash=',$apos,'#top',$apos,';')"/>
					</xsl:if>
					<xsl:if test="string-length($focus)&gt;0">
							<xsl:value-of select="concat('document.getElementById(', $apos, $focus, $apos, ').focus()')"/>
					</xsl:if>
						<xsl:value-of select="concat('&lt;/xsl:attribute&gt;', $cr)"/>
				</xsl:if>
			</xsl:if>

			<xsl:apply-templates select="$content/WTLOAD">
			<xsl:with-param name="indent">5</xsl:with-param>
			</xsl:apply-templates>
			
			<xsl:apply-templates select="$content/WTUNLOAD">
			<xsl:with-param name="indent">5</xsl:with-param>
			</xsl:apply-templates>
			
		</xsl:if>

		<xsl:value-of select="concat($tab4, '&lt;/xsl:otherwise&gt;', $cr)"/>
	
		<xsl:value-of select="concat($tab3, '&lt;/xsl:choose&gt;', $cr, $cr)"/>

	</xsl:template>

	<!--==================================================================-->
	<xsl:template name="GetFocus">
	<!--==================================================================-->
		<xsl:variable name="focus" select="/Data/WTENTITY/WTWEBPAGE/WTCONTENT/descendant::*[@focus]"/>
		<xsl:variable name="focus1" select="/Data/WTENTITY/WTWEBPAGE/WTCONTENT/descendant::*[(name()='WTTEXT') or (name()='WTCHECK') or (name()='WTCOMBO') or (name()='WTMEMO') or (name()='WTFILE')]"/>

		<xsl:if test="$focus">
			<xsl:choose>
				<xsl:when test="$focus/@name">
					<xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="$focus/@name"/></xsl:call-template>
				</xsl:when>
				<xsl:when test="$focus/@value">
					<xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="$focus/@value"/></xsl:call-template>
				</xsl:when>
			</xsl:choose>
		</xsl:if>
		<xsl:if test="not($focus)">
			<xsl:choose>
				<xsl:when test="$focus1/@name">
					<xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="$focus1/@name"/></xsl:call-template>
				</xsl:when>
				<xsl:when test="$focus1/@value">
					<xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="$focus1/@value"/></xsl:call-template>
				</xsl:when>
			</xsl:choose>
		</xsl:if>
		
	 </xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: XSL PAGE END -->
	<!-- returns the XSL for the end of each HTML page -->
	<!--==================================================================-->
	<xsl:template name="XSLPageEnd">
		<xsl:value-of select="concat($tab3, '&lt;/xsl:element&gt;', $cr)"/>
		<xsl:call-template name="XSLComment">
			<xsl:with-param name="indent">3</xsl:with-param>
			<xsl:with-param name="value">END PAGE</xsl:with-param>
		</xsl:call-template>
		<xsl:value-of select="$cr"/>

		<xsl:if test="$IsMenu='true'">
			<xsl:value-of select="concat($tab0, '&lt;xsl:element name=&quot;SCRIPT&quot;&gt;', $cr)"/>
			<xsl:value-of select="concat($tab1, '&lt;xsl:attribute name=&quot;language&quot;&gt;JavaScript&lt;/xsl:attribute&gt;', $cr)"/>
			<xsl:value-of select="concat($tab1, '&lt;xsl:text disable-output-escaping=&quot;yes&quot;&gt;&lt;![CDATA[', $cr)"/>
			<!-- Start Navbar Menu -->
			<xsl:if test="$MenuBar!=''">
				<xsl:if test="/Data/WTENTITY/WTWEBPAGE/@contentpage">
					<xsl:value-of select="concat($tab1, 'var contentpage = document.getElementById(', $apos, 'ContentPage', $apos, ').value;', $cr)"/>
					<xsl:value-of select="concat($tab1, 'if( contentpage == 0 ) {', $cr)"/>
				</xsl:if>
				<xsl:value-of select="concat($tab1, $MenuBar, '.run();', $cr)"/>
				<xsl:value-of select="concat($tab1, 'var MenuBarState = document.getElementById(', $apos, 'MenuBarState', $apos, ').value;', $cr)"/>
				<xsl:value-of select="concat($tab1, 'for(x=0; x&lt;10; x++) {', $cr)"/>
				<xsl:value-of select="concat($tab2, 'if ( MenuBarState.indexOf(x) &gt;= 0) {', $cr)"/>
				<xsl:value-of select="concat($tab3, 'if (', $MenuBar, '.menu.items[x])', $cr)"/>
				<xsl:value-of select="concat($tab4, $MenuBar, '.menu.items[x].toggle();', $cr)"/>
				<xsl:value-of select="concat($tab2, '}', $cr)"/>
				<xsl:value-of select="concat($tab1, '}', $cr)"/>
				<xsl:value-of select="concat($tab1, $MenuBar, '.click();', $cr)"/>
				<xsl:if test="/Data/WTENTITY/WTWEBPAGE/@contentpage">
					<xsl:value-of select="concat($tab1, '}', $cr, $cr)"/>
				</xsl:if>
			</xsl:if>
			<!-- Start All Webpage Menus -->
			<xsl:for-each select="/Data/WTENTITY/WTWEBPAGE/WTCONTENT/WTMENU[@type='bar']">
				<xsl:value-of select="concat($tab1, @name, '.run();', $cr)"/>
			</xsl:for-each>

			<xsl:value-of select="concat($tab1, ']]&gt;&lt;/xsl:text&gt;', $cr)"/>
			<xsl:value-of select="concat($tab0, '&lt;/xsl:element&gt;', $cr, $cr)"/>
		</xsl:if>

		<xsl:if test="$translate='true'">
			<xsl:call-template name="DoTranslate"/>
		</xsl:if>

		<!-- Process page tracking -->
<!--		
		<xsl:for-each select="/Data/WTENTITY/WTWEBPAGE/WTTRACK[not(@action) or @action &gt;= 0]">
			<xsl:variable name="tracktext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@acct"/></xsl:call-template></xsl:variable>
			<xsl:value-of select="concat($tab0, '&lt;xsl:element name=&quot;SCRIPT&quot;&gt;', $cr)"/>
			<xsl:value-of select="concat($tab1, '&lt;xsl:attribute name=&quot;language&quot;&gt;JavaScript&lt;/xsl:attribute&gt;', $cr)"/>
			<xsl:value-of select="concat($tab1, '&lt;xsl:text disable-output-escaping=&quot;yes&quot;&gt;&lt;![CDATA[', $cr)"/>

			<xsl:if test="WTCONDITION">
				<xsl:call-template name="JavaScriptConditionStart">
					<xsl:with-param name="indent">1</xsl:with-param>			
					<xsl:with-param name="conditions" select="WTCONDITION"/>			
				</xsl:call-template>
			</xsl:if>
			<xsl:if test="@action">
				<xsl:value-of select="concat($tab1, 'if ( document.getElementById(', $apos, 'ActionCode', $apos, ').value == ', @action, ' ) {', $cr)"/>
			</xsl:if>
			<xsl:if test="not(@order)">
				<xsl:value-of select="concat($tab2, 'var ga = document.getElementById(', $apos, $tracktext, $apos, ').value', $cr)"/>
				<xsl:value-of select="concat($tab2, 'GATrack(ga, &quot;&quot;);', $cr)"/>
			</xsl:if>
			<xsl:if test="@order">
				<xsl:variable name="ordertext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@order"/></xsl:call-template></xsl:variable>
				<xsl:value-of select="concat($tab2, 'var ga = document.getElementById(', $apos, $tracktext, $apos, ').value', $cr)"/>
				<xsl:value-of select="concat($tab2, 'var order = document.getElementById(', $apos, $ordertext, $apos, ').value', $cr)"/>
				<xsl:value-of select="concat($tab2, 'GATrack(ga, order);', $cr)"/>
			</xsl:if>
			<xsl:if test="@action">
				<xsl:value-of select="concat($tab1, '}', $cr)"/>
			</xsl:if>
			<xsl:if test="WTCONDITION">
				<xsl:call-template name="JavaScriptConditionEnd">
					<xsl:with-param name="indent">1</xsl:with-param>			
				</xsl:call-template>
			</xsl:if>

			<xsl:value-of select="concat($tab1, ']]&gt;&lt;/xsl:text&gt;', $cr)"/>
			<xsl:value-of select="concat($tab0, '&lt;/xsl:element&gt;', $cr, $cr)"/>
		</xsl:for-each>
-->
		<!-- If Specified, end a wrapper division around the entire page -->
		<xsl:if test="$wrapper!=''">
			<xsl:value-of select="concat($tab2, '&lt;/xsl:element&gt;', $cr)"/>
		</xsl:if>

		<xsl:value-of select="concat($tab2, '&lt;/xsl:element&gt;', $cr)"/>
		<xsl:call-template name="XSLComment">
			<xsl:with-param name="indent">2</xsl:with-param>
			<xsl:with-param name="value">END BODY</xsl:with-param>
		</xsl:call-template>
		<xsl:value-of select="$cr"/>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: XSL PAGE ROW -->
	<!-- returns the XSL for the main page table row -->
	<!--==================================================================-->
	<xsl:template name="XSLPageRow">
		<xsl:call-template name="XSLComment">
			<xsl:with-param name="indent">5</xsl:with-param>
			<xsl:with-param name="value">BEGIN PAGE LAYOUT ROW</xsl:with-param>
		</xsl:call-template>

		<xsl:variable name="NavBar">
			<xsl:choose>
				<xsl:when test="/Data/WTENTITY/WTWEBPAGE/@navbar='false'"/>
				<xsl:when test="/Data/WTENTITY/WTWEBPAGE/@navbar='true'">NavBar</xsl:when>
				<xsl:when test="/Data/WTENTITY/WTWEBPAGE/@navbar"><xsl:value-of select="/Data/WTENTITY/WTWEBPAGE/@navbar"/></xsl:when>
				<xsl:when test="/Data/WTPAGE/@navbar='false'"/>
				<xsl:otherwise>NavBar</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="margin">
			<xsl:choose>
				<xsl:when test="/Data/WTENTITY/WTWEBPAGE/@margin='true'">true</xsl:when>
				<xsl:when test="/Data/WTENTITY/WTWEBPAGE/@margin='false'">false</xsl:when>
				<xsl:when test="/Data/WTPAGE/@margin='false'">false</xsl:when>
				<xsl:otherwise>true</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
	  	<xsl:variable name="pagewidth">
	  		<xsl:choose>
	  			<xsl:when test="/Data/WTENTITY/WTWEBPAGE/@page-width"><xsl:value-of select="/Data/WTENTITY/WTWEBPAGE/@page-width"/></xsl:when>
	  			<xsl:when test="/Data/WTPAGE/@page-width"><xsl:value-of select="/Data/WTPAGE/@page-width"/></xsl:when>
	  			<xsl:otherwise>750</xsl:otherwise>
	  		</xsl:choose>
	  	</xsl:variable>
	  	<xsl:variable name="navbarwidth">
	  		<xsl:choose>
	  			<xsl:when test="/Data/WTENTITY/WTWEBPAGE/@navbar-width"><xsl:value-of select="/Data/WTENTITY/WTWEBPAGE/@navbar-width"/></xsl:when>
	  			<xsl:when test="/Data/WTPAGE/@navbar-width"><xsl:value-of select="/Data/WTPAGE/@navbar-width"/></xsl:when>
	  			<xsl:otherwise>140</xsl:otherwise>
	  		</xsl:choose>
	  	</xsl:variable>
	  	<xsl:variable name="marginwidth">
	  		<xsl:choose>
	  			<xsl:when test="/Data/WTENTITY/WTWEBPAGE/@margin-width"><xsl:value-of select="/Data/WTENTITY/WTWEBPAGE/@margin-width"/></xsl:when>
	  			<xsl:when test="/Data/WTPAGE/@margin-width"><xsl:value-of select="/Data/WTPAGE/@margin-width"/></xsl:when>
	  			<xsl:otherwise>10</xsl:otherwise>
	  		</xsl:choose>
	  	</xsl:variable>
	  	<xsl:variable name="contentwidth">
	  		<xsl:choose>
	  			<xsl:when test="/Data/WTENTITY/WTWEBPAGE/@content-width"><xsl:value-of select="/Data/WTENTITY/WTWEBPAGE/@content-width"/></xsl:when>
	  			<xsl:when test="/Data/WTPAGE/@content-width"><xsl:value-of select="/Data/WTPAGE/@content-width"/></xsl:when>
				<xsl:when test="$NavBar!='' and $margin='true'">600</xsl:when>
				<xsl:when test="$NavBar='' and $margin='false'"><xsl:value-of select="$pagewidth"/></xsl:when>
				<xsl:when test="$NavBar!=''"><xsl:value-of select="$pagewidth - $navbarwidth"/></xsl:when>
				<xsl:when test="$margin='true'"><xsl:value-of select="$pagewidth - $marginwidth"/></xsl:when>
	  		</xsl:choose>
	  	</xsl:variable>

		<xsl:value-of select="concat($tab5, '&lt;xsl:element name=&quot;TR&quot;&gt;', $cr)"/>
		<xsl:if test="$NavBar!=''">
			<xsl:if test="/Data/WTENTITY/WTWEBPAGE/@contentpage">
				<xsl:value-of select="concat($tab6, '&lt;xsl:if test=&quot;/DATA/PARAM/@contentpage=0&quot;&gt;', $cr)"/>
					<xsl:value-of select="concat($tab7, '&lt;xsl:element name=&quot;TD&quot;&gt;', $cr)"/>
					<xsl:value-of select="concat($tab8, '&lt;xsl:attribute name=&quot;width&quot;&gt;', $navbarwidth, '&lt;/xsl:attribute&gt;', $cr)"/>
					<xsl:value-of select="concat($tab7, '&lt;/xsl:element&gt;', $cr)"/>
				<xsl:value-of select="concat($tab6, '&lt;/xsl:if&gt;', $cr)"/>
			</xsl:if>
			<xsl:if test="not(/Data/WTENTITY/WTWEBPAGE/@contentpage)">
				<xsl:value-of select="concat($tab6, '&lt;xsl:element name=&quot;TD&quot;&gt;', $cr)"/>
				<xsl:value-of select="concat($tab7, '&lt;xsl:attribute name=&quot;width&quot;&gt;', $navbarwidth, '&lt;/xsl:attribute&gt;', $cr)"/>
				<xsl:value-of select="concat($tab6, '&lt;/xsl:element&gt;', $cr)"/>
			</xsl:if>
		</xsl:if>
		<xsl:if test="$margin='true'">
			<xsl:if test="/Data/WTENTITY/WTWEBPAGE/@contentpage">
				<xsl:value-of select="concat($tab6, '&lt;xsl:if test=&quot;/DATA/PARAM/@contentpage!=1&quot;&gt;', $cr)"/>
					<xsl:value-of select="concat($tab7, '&lt;xsl:element name=&quot;TD&quot;&gt;', $cr)"/>
					<xsl:value-of select="concat($tab8, '&lt;xsl:attribute name=&quot;width&quot;&gt;', $marginwidth, '&lt;/xsl:attribute&gt;', $cr)"/>
					<xsl:value-of select="concat($tab7, '&lt;/xsl:element&gt;', $cr)"/>
				<xsl:value-of select="concat($tab6, '&lt;/xsl:if&gt;', $cr)"/>
			</xsl:if>
			<xsl:if test="not(/Data/WTENTITY/WTWEBPAGE/@contentpage)">
				<xsl:value-of select="concat($tab6, '&lt;xsl:element name=&quot;TD&quot;&gt;', $cr)"/>
				<xsl:value-of select="concat($tab7, '&lt;xsl:attribute name=&quot;width&quot;&gt;', $marginwidth, '&lt;/xsl:attribute&gt;', $cr)"/>
				<xsl:value-of select="concat($tab6, '&lt;/xsl:element&gt;', $cr)"/>
			</xsl:if>
		</xsl:if>
		<xsl:value-of select="concat($tab6, '&lt;xsl:element name=&quot;TD&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($tab7, '&lt;xsl:attribute name=&quot;width&quot;&gt;', $contentwidth, '&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($tab6, '&lt;/xsl:element&gt;', $cr)"/>
		<xsl:value-of select="concat($tab5, '&lt;/xsl:element&gt;', $cr, $cr)"/>
	</xsl:template>
	
	 <!--==================================================================-->
	 <!-- Get a value of various types                                     -->
	 <!-- returns value in a value-of expression by default                -->
	 <!-- if a value is hidden only its raw data is returned               -->
	 <!-- non-displayed data is usually hidden - expressions, filters      -->
	 <!--==================================================================-->
	 <xsl:template name="GetValue">
	 <!--==================================================================-->
		  <xsl:param name="type"/>
		  <xsl:param name="text"/>
		  <xsl:param name="entity"/>
		  <xsl:param name="noselect" select="false()"/>
		  <xsl:param name="hidden" select="false()"/>
		  <xsl:param name="output" select="false()"/>
		  
		  <xsl:choose>
		  <xsl:when test="$type='ATTR'">
				<xsl:call-template name="XSLDataField">
					 <xsl:with-param name="entity" select="$entity"/>
					 <xsl:with-param name="name" select="$text"/>
					 <xsl:with-param name="newline" select="false()"/>
					 <xsl:with-param name="noselect" select="$noselect"/>
					 <xsl:with-param name="hidden" select="$hidden"/>
					 <xsl:with-param name="output" select="$output"/>
				</xsl:call-template>
				<xsl:if test="$entity=$entityname">
					<xsl:if test="count(/Data/WTENTITY/WTATTRIBUTE[@name=$text])=0">
						<xsl:call-template name="Error">
							<xsl:with-param name="msg" select="'Invalid ATTR() Name'"/>
							<xsl:with-param name="text" select="$text"/>
						</xsl:call-template>
					</xsl:if>
				</xsl:if>
		  </xsl:when>
		  <xsl:when test="$type='DATA'">
				<xsl:call-template name="XSLDataField">
					 <xsl:with-param name="name" select="$text"/>
					 <xsl:with-param name="newline" select="false()"/>
					 <xsl:with-param name="noselect" select="$noselect"/>
					 <xsl:with-param name="hidden" select="$hidden"/>
					 <xsl:with-param name="output" select="$output"/>
				</xsl:call-template>
		  </xsl:when>
		  <xsl:when test="$type='PARAM'">
				<xsl:if test="not($noselect)">&lt;xsl:value-of select=&quot;</xsl:if>
				<xsl:value-of select="'/DATA/PARAM/@'"/>
				<xsl:call-template name="CaseLower"><xsl:with-param name="value" select="$text"/></xsl:call-template>
				<xsl:if test="$output">
					<xsl:value-of select="'&quot; disable-output-escaping=&quot;yes'"/>
				</xsl:if>
				<xsl:if test="not($noselect)">&quot;/&gt;</xsl:if>
				
				<xsl:if test="count(/Data/WTENTITY/WTWEBPAGE/WTPARAM[@name=$text])=0">
					<xsl:call-template name="Error">
						<xsl:with-param name="msg" select="'Invalid PARAM() Name'"/>
						<xsl:with-param name="text" select="$text"/>
					</xsl:call-template>
				</xsl:if>
		  </xsl:when>
			<xsl:when test="$type='ENTITY'">
				<xsl:variable name="ent"><xsl:value-of select="/Data/ENTITIES/ENTITY[@name=$text]/@number"/></xsl:variable>
				<xsl:value-of select="$ent"/>
				<xsl:if test="string-length($ent)=0">
					<xsl:call-template name="Error">
					 	<xsl:with-param name="msg" select="'Invalid ENTITY() Name'"/>
					 	<xsl:with-param name="text" select="$text"/>
					</xsl:call-template>
				</xsl:if>
		  </xsl:when>
			<xsl:when test="$type='ATTRIBUTE'">
				<xsl:variable name="ent"><xsl:value-of select="/Data/WTENTITY/WTATTRIBUTE[@name=$text]/@id"/></xsl:variable>
				<xsl:value-of select="$ent"/>
				<xsl:if test="string-length($ent)=0">
					<xsl:call-template name="Error">
					 	<xsl:with-param name="msg" select="'Invalid ATTRIBUTE() Name'"/>
					 	<xsl:with-param name="text" select="$text"/>
					</xsl:call-template>
				</xsl:if>
		  </xsl:when>
			<xsl:when test="$type='SYSCON'">
				<xsl:variable name="syscon"><xsl:value-of select="/Data/WTENTITY/WTSYSCONS/WTSYSCON[@name=$text]/@value"/></xsl:variable>
				<xsl:value-of select="$syscon"/>
				<xsl:if test="string-length($syscon)=0">
					<xsl:variable name="syscon1"><xsl:value-of select="/Data/WTSYSCONS/WTSYSCON[@name=$text]/@value"/></xsl:variable>
					<xsl:value-of select="$syscon1"/>
					<xsl:if test="string-length($syscon1)=0">
						<xsl:call-template name="Error">
					 		<xsl:with-param name="msg" select="'Invalid SYSCON() Name'"/>
					 		<xsl:with-param name="text" select="$text"/>
						</xsl:call-template>
					</xsl:if>
				</xsl:if>
		  </xsl:when>
		  <xsl:when test="$type='SYS'">
				<xsl:variable name="ltext">
					<xsl:call-template name="CaseLower">
						<xsl:with-param name="value" select="$text"/>
					</xsl:call-template>
				</xsl:variable>
				<xsl:if test="not($noselect)">&lt;xsl:value-of select=&quot;</xsl:if>
				<xsl:choose>
				<xsl:when test="$ltext='headerimage'">/DATA/SYSTEM/@headerimage</xsl:when>
				<xsl:when test="$ltext='footerimage'">/DATA/SYSTEM/@footerimage</xsl:when>
				<xsl:when test="$ltext='returnimage'">/DATA/SYSTEM/@returnimage</xsl:when>
				<xsl:when test="$ltext='headerurl'">/DATA/SYSTEM/@headerurl</xsl:when>
				<xsl:when test="$ltext='returnurl'">/DATA/SYSTEM/@returnurl</xsl:when>
				<xsl:when test="$ltext='language'">/DATA/SYSTEM/@language</xsl:when>
				<xsl:when test="$ltext='langdialect'">/DATA/SYSTEM/@langdialect</xsl:when>
				<xsl:when test="$ltext='langcountry'">/DATA/SYSTEM/@langcountry</xsl:when>
				<xsl:when test="$ltext='langdefault'">/DATA/SYSTEM/@langdefault</xsl:when>
				<xsl:when test="$ltext='userid'">/DATA/SYSTEM/@userid</xsl:when>
				<xsl:when test="$ltext='usergroup'">/DATA/SYSTEM/@usergroup</xsl:when>
				<xsl:when test="$ltext='userstatus'">/DATA/SYSTEM/@userstatus</xsl:when>
				<xsl:when test="$ltext='username'">/DATA/SYSTEM/@username</xsl:when>
				<xsl:when test="$ltext='employeeid'">/DATA/SYSTEM/@employeeid</xsl:when>
				<xsl:when test="$ltext='actioncode'">/DATA/SYSTEM/@actioncode</xsl:when>
				<xsl:when test="$ltext='menubarstate'">/DATA/SYSTEM/@menubarstate</xsl:when>
				<xsl:when test="$ltext='customerid'">/DATA/SYSTEM/@customerid</xsl:when>
				<xsl:when test="$ltext='affiliateid'">/DATA/SYSTEM/@affiliateid</xsl:when>
				<xsl:when test="$ltext='affiliatetype'">/DATA/SYSTEM/@affiliatetype</xsl:when>
				<xsl:when test="$ltext='planid'">/DATA/SYSTEM/@planid</xsl:when>
				<xsl:when test="$ltext='cartid'">/DATA/SYSTEM/@cartid</xsl:when>
				<xsl:when test="$ltext='storeid'">/DATA/SYSTEM/@storeid</xsl:when>
				<xsl:when test="$ltext='brduserid'">/DATA/SYSTEM/@brduserid</xsl:when>
				<xsl:when test="$ltext='brdusergroup'">/DATA/SYSTEM/@brdusergroup</xsl:when>
				<xsl:when test="$ltext='pagecolor'">/DATA/SYSTEM/@pagecolor</xsl:when>
				<xsl:when test="$ltext='linkcolor'">/DATA/SYSTEM/@linkcolor</xsl:when>
				<xsl:when test="$ltext='pageimage'">/DATA/SYSTEM/@pageimage</xsl:when>
				<xsl:when test="$ltext='pageimagefixed'">/DATA/SYSTEM/@pageimagefixed</xsl:when>
				<xsl:when test="$ltext='pageimagefolder'">/DATA/SYSTEM/@pageimagefolder</xsl:when>
				<xsl:when test="$ltext='colorgraybaron'">/DATA/SYSTEM/@colorgraybaron</xsl:when>
				<xsl:when test="$ltext='colorgraybaroff'">/DATA/SYSTEM/@colorgraybaroff</xsl:when>
				<xsl:when test="$ltext='colordivider'">/DATA/SYSTEM/@colordivider</xsl:when>
				<xsl:when test="$ltext='colortext'">/DATA/SYSTEM/@colortext</xsl:when>
				<xsl:when test="$ltext='colorprompt'">/DATA/SYSTEM/@colorprompt</xsl:when>
				<xsl:when test="$ltext='pageurl'">/DATA/SYSTEM/@pageURL</xsl:when>
				<xsl:when test="$ltext='date'">/DATA/SYSTEM/@currdate</xsl:when>
				<xsl:when test="$ltext='time'">/DATA/SYSTEM/@currtime</xsl:when>
				<xsl:when test="$ltext='timeno'">/DATA/SYSTEM/@currtimeno</xsl:when>
				<xsl:when test="$ltext='searchtype'">/DATA/BOOKMARK/@searchtype</xsl:when>
				<xsl:when test="$ltext='listtype'">/DATA/TXN/LISTTYPES/ENUM[@selected='True']/@id</xsl:when>
				<xsl:when test="$ltext='owner'">/DATA/OWNER/@entity</xsl:when>
				<xsl:when test="$ltext='ownerid'">/DATA/OWNER/@id</xsl:when>
				<xsl:when test="$ltext='ownertitle'">/DATA/OWNER/@title</xsl:when>
				<xsl:when test="$ltext='servername'">/DATA/SYSTEM/@servername</xsl:when>
				<xsl:when test="$ltext='serverpath'">/DATA/SYSTEM/@serverpath</xsl:when>
				<xsl:when test="$ltext='webdirectory'">/DATA/SYSTEM/@webdirectory</xsl:when>
				<xsl:when test="$ltext='options'">/DATA/SYSTEM/@options</xsl:when>
				<xsl:otherwise>
					<!-- check for an application defined variable -->
				  	<xsl:variable name="GetVal">
						<xsl:for-each select="/Data/WTPAGE/WTSYSVAR">
						  	<xsl:variable name="lvar">
						  		<xsl:call-template name="CaseLower">
						  			<xsl:with-param name="value" select="@name"/>
						  		</xsl:call-template>
						  	</xsl:variable>
							<xsl:if test="$ltext=$lvar">
								<xsl:value-of select="concat('/DATA/SYSTEM/@', $lvar)"/>
							</xsl:if>
						</xsl:for-each>
				  	</xsl:variable>

					<xsl:choose>
					<xsl:when test="string-length($GetVal)!=0"><xsl:value-of select="$GetVal"/></xsl:when>
					<xsl:otherwise>
						<xsl:call-template name="Error">
							<xsl:with-param name="msg" select="'Invalid SYS() Name'"/>
							<xsl:with-param name="text" select="$text"/>
						</xsl:call-template>
					</xsl:otherwise>
					</xsl:choose>
					
				</xsl:otherwise>
				</xsl:choose>
				<xsl:if test="not($noselect)">&quot;/&gt;</xsl:if>
		   </xsl:when>
		  <xsl:when test="$type='CONFIG'">
				<xsl:if test="not($noselect)">&lt;xsl:value-of select=&quot;</xsl:if>
				<xsl:choose>
				<xsl:when test="$text='isdocuments'">/DATA/CONFIG/@isdocuments</xsl:when>
				<xsl:when test="$text='documentpath'">/DATA/CONFIG/@documentpath</xsl:when>
				<xsl:otherwise>
					 <xsl:call-template name="Error">
					 	<xsl:with-param name="msg" select="'Invalid CONFIG() Name'"/>
					 	<xsl:with-param name="text" select="$text"/>
					 </xsl:call-template>
				</xsl:otherwise>
				</xsl:choose>
				<xsl:if test="not($noselect)">&quot;/&gt;</xsl:if>
		  </xsl:when>
		  <xsl:when test="$type='FINDID'">
				<xsl:if test="not($noselect)">&lt;xsl:value-of select=&quot;</xsl:if>
				<xsl:call-template name="CaseUpper">
	 				<xsl:with-param name="value" select="concat('/DATA/TXN/', $appprefix, $entityname, 's/', $appprefix, 'FINDTYPEIDS/ENUM')"/>
				</xsl:call-template>
				<xsl:value-of select="concat('[@name=', $apos, $text, $apos, ']/@id')"/>
				<xsl:if test="not($noselect)">&quot;/&gt;</xsl:if>
		   </xsl:when>
		  <xsl:when test="$type='LISTID'">
				<xsl:if test="not($noselect)">&lt;xsl:value-of select=&quot;</xsl:if>
				<xsl:value-of select="concat('/DATA/TXN/LISTTYPES/ENUM[@name=', $apos, $text, $apos, ']/@id')"/>
				<xsl:if test="not($noselect)">&quot;/&gt;</xsl:if>
		  </xsl:when>
		  <xsl:when test="$type='VALUE'">
				<xsl:value-of select="concat('&lt;xsl:value-of select=&quot;', $text, '&quot;/&gt;')"/>
		  </xsl:when>
		  <xsl:when test="$type='NONE'">
				<xsl:if test="string-length($text)&gt;0">
					 <xsl:choose>
					 <xsl:when test="$text='true'">'1'</xsl:when>
					 <xsl:when test="$text='false'">'0'</xsl:when>
					 <xsl:otherwise><xsl:value-of select="$text"/></xsl:otherwise>
					 </xsl:choose>
				</xsl:if>
		  </xsl:when>
		  <xsl:otherwise>
				<xsl:if test="string-length($text)&gt;0"><xsl:value-of select="$text"/></xsl:if>
		  </xsl:otherwise>
		  </xsl:choose>
	 </xsl:template>

	 <!--==================================================================-->
	 <xsl:template name="GetColor">
	 <!--==================================================================-->
		  <xsl:param name="color"/>
		  <xsl:variable name="type"><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="$color"/></xsl:call-template></xsl:variable>
		  <xsl:variable name="text"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="$color"/></xsl:call-template></xsl:variable>
		  
		  <xsl:choose>
			  <xsl:when test="$type='SYS'">
				  <xsl:variable name="syscolor">
					  <xsl:value-of select="/Data/WTCOLORS/WTCOLOR[@name=$text]/@value"/>
				  </xsl:variable>
				  <xsl:value-of select="concat('#',$syscolor)"/>
				  <xsl:if test="string-length($syscolor)=0">
					  <xsl:call-template name="Error">
						  <xsl:with-param name="msg" select="'Invalid System Color'"/>
						  <xsl:with-param name="text" select="$text"/>
					  </xsl:call-template>
				  </xsl:if>
			  </xsl:when>
			  <xsl:when test="$type='PARAM'">
				  <xsl:call-template name="GetValue">
					  <xsl:with-param name="type" select="$type"/>
					  <xsl:with-param name="text" select="$text"/>
				  </xsl:call-template>
			  </xsl:when>
			  <xsl:otherwise>
				<xsl:value-of select="$text"/>
				<xsl:if test="string-length($text)=0">
					 <xsl:call-template name="Error">
					 	<xsl:with-param name="msg" select="'Invalid Color'"/>
					 	<xsl:with-param name="text" select="$color"/>
					 </xsl:call-template>
				</xsl:if>
		  </xsl:otherwise>
		  </xsl:choose>
	 </xsl:template>

	 <!--==================================================================-->
	 <xsl:template match="WTSTARTMENU">
	 <!--==================================================================-->
			<xsl:value-of select="concat($tab0, '&lt;xsl:element name=&quot;SCRIPT&quot;&gt;', $cr)"/>
			<xsl:value-of select="concat($tab1, '&lt;xsl:attribute name=&quot;language&quot;&gt;JavaScript&lt;/xsl:attribute&gt;', $cr)"/>
			<xsl:if test="@type='xpbar'">
				<xsl:value-of select="concat($tab1, 'var ', @name, ' = new CXPBar(', @name, 'Def, ', $apos, @name, $apos, '); ', @name, '.create();')"/>
			</xsl:if>
		 <xsl:if test="@type='bar'">
			 <xsl:value-of select="concat($tab1, 'var ', @name, ' = new CMenu(', @name, 'Def, ', $apos, @name, $apos, '); ', @name, '.create();')"/>
		 </xsl:if>
		 <xsl:if test="@type='tree'">
			 <xsl:value-of select="concat($tab1, 'var ', @name, ' = new CTree(', @name, 'Def, ', $apos, @name, $apos, '); ', @name, '.create(); ', @name, '.draw();')"/>
		 </xsl:if>
		 <xsl:if test="@run='true'">
				<xsl:value-of select="concat(' ', @name, '.run();')"/>
			</xsl:if>
			<xsl:value-of select="$cr"/>
			<xsl:value-of select="concat($tab0, '&lt;/xsl:element&gt;', $cr, $cr)"/>
	 </xsl:template>

	 <!--==================================================================-->
	 <xsl:template match="WTRUNMENU">
	 <!--==================================================================-->
			<xsl:value-of select="concat($tab0, '&lt;xsl:element name=&quot;SCRIPT&quot;&gt;', $cr)"/>
			<xsl:value-of select="concat($tab1, '&lt;xsl:attribute name=&quot;language&quot;&gt;JavaScript&lt;/xsl:attribute&gt;', $cr)"/>
			<xsl:value-of select="concat($tab1, @name, '.run();', $cr)"/>
			<xsl:value-of select="concat($tab0, '&lt;/xsl:element&gt;', $cr, $cr)"/>
	 </xsl:template>

	 <!--==================================================================-->
	 <xsl:template match="WTSTARTTAB">
	 <!--==================================================================-->
			<xsl:value-of select="concat($tab0, '&lt;xsl:element name=&quot;SCRIPT&quot;&gt;', $cr)"/>
			<xsl:value-of select="concat($tab1, '&lt;xsl:attribute name=&quot;language&quot;&gt;JavaScript&lt;/xsl:attribute&gt;', $cr)"/>
			<xsl:value-of select="concat($tab1, 'var ', @name, ' = new CTabSet(&quot;', @name, '&quot;); ', @name, '.create(', @name, 'Def);', $cr)"/>
			<xsl:value-of select="concat($tab0, '&lt;/xsl:element&gt;', $cr, $cr)"/>
	 </xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTCUSTOM">
		<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:value-of select="concat($ind1, ., $cr)"/>
		<xsl:if test="@newline"><xsl:value-of select="$cr"/></xsl:if>
	</xsl:template>
</xsl:stylesheet>
