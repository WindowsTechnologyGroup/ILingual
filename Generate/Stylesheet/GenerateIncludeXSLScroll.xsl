<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
	<!--==================================================================-->
	<xsl:template name="ScrollHeader">
	<!--==================================================================-->
		<xsl:param name="indent"/>

		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="ind2" select="concat($ind1, $tab1)"/>
		<xsl:variable name="ind3" select="concat($ind2, $tab1)"/>
		<xsl:variable name="ind4" select="concat($ind3, $tab1)"/>
		<xsl:variable name="ind5" select="concat($ind4, $tab1)"/>
		<xsl:variable name="ind6" select="concat($ind5, $tab1)"/>

		<xsl:value-of select="concat($ind1, '&lt;xsl:element name=&quot;STYLE&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($ind2, '&lt;xsl:attribute name=&quot;type&quot;&gt;text/css&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($ind2, '&lt;xsl:text disable-output-escaping=&quot;yes&quot;&gt;&lt;![CDATA[', $cr)"/>

		<xsl:value-of select="concat($ind3, '.', @name, 'Scroll {', $cr)"/>
		<xsl:value-of select="concat($ind4, 'width:', @width, 'px;', $cr)"/>
		<xsl:value-of select="concat($ind4, 'height:', @height, 'px;', $cr)"/>
		<xsl:value-of select="concat($ind4, 'margin-bottom:1em;', $cr)"/>
		<xsl:value-of select="concat($ind3, '}', $cr)"/>

		<xsl:value-of select="concat($ind3, '.', @name, 'Scroll .simply-scroll-clip {', $cr)"/>
		<xsl:value-of select="concat($ind4, 'width:', @width, 'px;', $cr)"/>
		<xsl:value-of select="concat($ind4, 'height:', @height, 'px;', $cr)"/>
		<xsl:value-of select="concat($ind3, '}', $cr)"/>

		<xsl:value-of select="concat($ind3, '.', @name, 'Scroll .simply-scroll-list li {', $cr)"/>
		<xsl:value-of select="concat($ind4, 'float:left;', $cr)"/>
		<xsl:value-of select="concat($ind4, 'width:', @itemwidth, 'px;', $cr)"/>
		<xsl:value-of select="concat($ind4, 'height:', @itemheight, 'px;', $cr)"/>
		<xsl:value-of select="concat($ind3, '}', $cr)"/>

		<xsl:if test="@hover">
			<xsl:value-of select="concat($ind3, '.', @name, 'Scroll .simply-scroll-list li:hover {', $cr)"/>
			<xsl:value-of select="concat($ind4, @hover, $cr)"/>
			<xsl:value-of select="concat($ind3, '}', $cr)"/>
		</xsl:if>

		<xsl:if test="not(@orientation='vertical')">
			<xsl:value-of select="concat($ind3, '.', @name, 'Scroll .simply-scroll-btn-left {', $cr)"/>
			<xsl:value-of select="concat($ind4, 'left:0;', $cr)"/>
			<xsl:value-of select="concat($ind4, 'top:', (@height div 2)-22, 'px;', $cr)"/>
			<xsl:value-of select="concat($ind3, '}', $cr)"/>

			<xsl:value-of select="concat($ind3, '.', @name, 'Scroll .simply-scroll-btn-right {', $cr)"/>
			<xsl:value-of select="concat($ind4, 'right:0;', $cr)"/>
			<xsl:value-of select="concat($ind4, 'top:', (@height div 2)-22, 'px;', $cr)"/>
			<xsl:value-of select="concat($ind3, '}', $cr)"/>
		</xsl:if>
		<xsl:if test="@orientation='vertical'">
			<xsl:value-of select="concat($ind3, '.', @name, 'Scroll .simply-scroll-btn-up {', $cr)"/>
			<xsl:value-of select="concat($ind4, 'top:0;', $cr)"/>
			<xsl:value-of select="concat($ind4, 'left:', (@width div 2)-21, 'px;', $cr)"/>
			<xsl:value-of select="concat($ind3, '}', $cr)"/>

			<xsl:value-of select="concat($ind3, '.', @name, 'Scroll .simply-scroll-btn-down {', $cr)"/>
			<xsl:value-of select="concat($ind4, 'bottom:0;', $cr)"/>
			<xsl:value-of select="concat($ind4, 'left:', (@width div 2)-21, 'px;', $cr)"/>
			<xsl:value-of select="concat($ind3, '}', $cr)"/>
		</xsl:if>

		<xsl:value-of select="concat($ind2, ']]&gt;&lt;/xsl:text&gt;', $cr)"/>
		<xsl:value-of select="concat($ind1, '&lt;/xsl:element&gt;', $cr, $cr)"/>
		
		<xsl:value-of select="concat($ind1, '&lt;xsl:element name=&quot;SCRIPT&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($ind2, '&lt;xsl:attribute name=&quot;language&quot;&gt;JavaScript&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($ind2, '&lt;xsl:text disable-output-escaping=&quot;yes&quot;&gt;&lt;![CDATA[', $cr)"/>

		<xsl:value-of select="concat($ind3, '(function($) {', $cr)"/>
		<xsl:value-of select="concat($ind4, '$(function() {', $cr)"/>
		<xsl:value-of select="concat($ind5, '$(&quot;#', @name, '&quot;).simplyScroll({', $cr)"/>
		<xsl:value-of select="concat($ind6, 'customClass:&quot;', @name, 'Scroll&quot;')"/>
		<xsl:if test="@framerate">
			<xsl:value-of select="concat(',', $cr, $ind6, 'frameRate:', @framerate)"/>
		</xsl:if>
		<xsl:if test="@speed">
			<xsl:value-of select="concat(',', $cr, $ind6, 'speed:', @speed)"/>
		</xsl:if>
		<xsl:if test="@orientation='vertical'">
			<xsl:value-of select="concat(',', $cr, $ind6, 'orientation:&quot;', @orientation, '&quot;')"/>
		</xsl:if>
		<xsl:if test="@direction='backwards'">
			<xsl:value-of select="concat(',', $cr, $ind6, 'direction:&quot;', @direction, '&quot;')"/>
		</xsl:if>
		<xsl:if test="@auto='false'">
			<xsl:value-of select="concat(',', $cr, $ind6, 'auto:', @auto)"/>
		</xsl:if>
		<xsl:if test="@automode='bounce'">
			<xsl:value-of select="concat(',', $cr, $ind6, 'autoMode:&quot;', @automode, '&quot;')"/>
		</xsl:if>
		<xsl:if test="@manualmode='loop'">
			<xsl:value-of select="concat(',', $cr, $ind6, 'manualMode:&quot;', @manualmode, '&quot;')"/>
		</xsl:if>
		<xsl:if test="@pauseonhover='false'">
			<xsl:value-of select="concat(',', $cr, $ind6, 'pauseOnHover:', @pauseonhover)"/>
		</xsl:if>
		<xsl:if test="@pauseontouch='false'">
			<xsl:value-of select="concat(',', $cr, $ind6, 'pauseOnTouch:', @pauseontouch)"/>
		</xsl:if>
		<xsl:if test="@pausebutton='true'">
			<xsl:value-of select="concat(',', $cr, $ind6, 'pauseButton:', @pausebutton)"/>
		</xsl:if>
		<xsl:if test="@startonload='true'">
			<xsl:value-of select="concat(',', $cr, $ind6, 'startOnLoad:', @startonload)"/>
		</xsl:if>
		
		<xsl:value-of select="$cr"/>
		<xsl:value-of select="concat($ind5, '});', $cr)"/>
		<xsl:value-of select="concat($ind4, '});', $cr)"/>
		<xsl:value-of select="concat($ind3, '})(jQuery);', $cr)"/>
		
		<xsl:value-of select="concat($ind2, ']]&gt;&lt;/xsl:text&gt;', $cr)"/>
		<xsl:value-of select="concat($ind1, '&lt;/xsl:element&gt;', $cr, $cr)"/>
		
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTSCROLL">
		<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="ind2" select="concat($ind1, $tab1)"/>
		<xsl:variable name="ind3" select="concat($ind2, $tab1)"/>

		<!-- ***************** Error Checking *******************-->
		<xsl:if test="not(@entity) and not(@datapath)">
			<xsl:call-template name="Error">
				<xsl:with-param name="msg" select="'WTSCROLL entity or datapath Missing'"/>
				<xsl:with-param name="text" select="'WTSCROLL'"/>
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="not(@name)">
			<xsl:call-template name="Error">
				<xsl:with-param name="msg" select="'WTSCROLL name Missing'"/>
				<xsl:with-param name="text" select="'WTSCROLL'"/>
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="not(@width)">
			<xsl:call-template name="Error">
				<xsl:with-param name="msg" select="'WTSCROLL width Missing'"/>
				<xsl:with-param name="text" select="'WTSCROLL'"/>
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="not(@height)">
			<xsl:call-template name="Error">
				<xsl:with-param name="msg" select="'WTSCROLL height Missing'"/>
				<xsl:with-param name="text" select="'WTSCROLL'"/>
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="not(@itemwidth)">
			<xsl:call-template name="Error">
				<xsl:with-param name="msg" select="'WTSCROLL itemwidth Missing'"/>
				<xsl:with-param name="text" select="'WTSCROLL'"/>
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="not(@itemheight)">
			<xsl:call-template name="Error">
				<xsl:with-param name="msg" select="'WTSCROLL itemheight Missing'"/>
				<xsl:with-param name="text" select="'WTSCROLL'"/>
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
					<xsl:when test="name()='entity'"/>
					<xsl:when test="name()='datapath'"/>
					<xsl:when test="name()='width'"/>
					<xsl:when test="name()='height'"/>
					<xsl:when test="name()='itemwidth'"/>
					<xsl:when test="name()='itemheight'"/>
					<xsl:when test="name()='framerate'"/>
					<xsl:when test="name()='speed'"/>
					<xsl:when test="name()='orientation'"/>
					<xsl:when test="name()='direction'"/>
					<xsl:when test="name()='auto'"/>
					<xsl:when test="name()='automode'"/>
					<xsl:when test="name()='manualmode'"/>
					<xsl:when test="name()='pauseonhover'"/>
					<xsl:when test="name()='pauseontouch'"/>
					<xsl:when test="name()='pausebutton'"/>
					<xsl:when test="name()='startonload'"/>
					<xsl:when test="name()='hover'"/>
					<xsl:otherwise>
						<xsl:call-template name="Error">
							<xsl:with-param name="msg" select="'WTSCROLL Invalid Attribute'"/>
							<xsl:with-param name="text" select="name()"/>
						</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:if>
		</xsl:for-each>

		<xsl:value-of select="concat($ind1, '&lt;xsl:element name=&quot;ul&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($ind2, '&lt;xsl:attribute name=&quot;id&quot;&gt;', @name, '&lt;/xsl:attribute&gt;', $cr)"/>

		<!--for-each-->
		<xsl:value-of select="concat($ind2, '&lt;xsl:for-each select=&quot;')"/>
		<xsl:choose>
			<xsl:when test="@datapath">
				<xsl:value-of select="@datapath"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="XSLDataPath">
					<xsl:with-param name="entity" select="@entity"/>
					<xsl:with-param name="iscollection" select="true()"/>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:value-of select="concat($tab0, '&quot;&gt;', $cr)"/>

		<xsl:value-of select="concat($ind3, '&lt;xsl:element name=&quot;li&quot;&gt;', $cr)"/>
		<!--apply child templates-->
		<xsl:apply-templates>
			<xsl:with-param name="indent" select="$indent+4"/>
		</xsl:apply-templates>
		<xsl:value-of select="concat($ind3, '&lt;/xsl:element&gt;', $cr)"/>

		<!--end for-each-->
		<xsl:value-of select="concat($ind2, '&lt;/xsl:for-each&gt;', $cr)"/>
		
		<xsl:value-of select="concat($ind1, '&lt;/xsl:element&gt;', $cr, $cr)"/>

	</xsl:template>

	<!--==================================================================-->
	<xsl:template name="Scroll2Header">
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
		<xsl:variable name="ind6" select="concat($ind5, $tab1)"/>

		<xsl:value-of select="concat($ind1, '&lt;xsl:element name=&quot;LINK&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($ind2, '&lt;xsl:attribute name=&quot;rel&quot;&gt;stylesheet&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($ind2, '&lt;xsl:attribute name=&quot;type&quot;&gt;text/css&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($ind2, '&lt;xsl:attribute name=&quot;href&quot;&gt;include/jcarousel/', @skin, '.css&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($ind2, '&lt;xsl:attribute name=&quot;media&quot;&gt;all&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($ind1, '&lt;/xsl:element&gt;', $cr, $cr)"/>

		<xsl:value-of select="concat($ind1, '&lt;xsl:element name=&quot;SCRIPT&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($ind2, '&lt;xsl:attribute name=&quot;language&quot;&gt;JavaScript&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($ind2, '&lt;xsl:text disable-output-escaping=&quot;yes&quot;&gt;&lt;![CDATA[', $cr)"/>

		<xsl:if test="@hover='pause'">
			<xsl:value-of select="concat($ind3, 'function ', @name, '_initCallback(carousel) {', $cr)"/>
			<xsl:value-of select="concat($ind4, 'carousel.clip.hover(function() {', $cr)"/>
			<xsl:value-of select="concat($ind5, 'carousel.stopAuto();', $cr)"/>
			<xsl:value-of select="concat($ind5, '}, function() {', $cr)"/>
			<xsl:value-of select="concat($ind5, 'carousel.startAuto();', $cr)"/>
			<xsl:value-of select="concat($ind4, '});', $cr)"/>
			<xsl:value-of select="concat($ind3, '};', $cr)"/>
		</xsl:if>

		<xsl:variable name="vertical">
			<xsl:choose>
				<xsl:when test="@vertical">true</xsl:when>
				<xsl:otherwise>false</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:value-of select="concat($ind3, 'jQuery(document).ready(function() {', $cr)"/>
		<xsl:value-of select="concat($ind4, 'jQuery(&quot;#', @name, '&quot;).jcarousel({', $cr)"/>
		<xsl:value-of select="concat($ind5, 'vertical:', $vertical)"/>
		<xsl:if test="@rtl">
			<xsl:value-of select="concat(',', $cr, $ind5, 'rtl:', @rtl)"/>
		</xsl:if>
		<xsl:if test="@start">
			<xsl:value-of select="concat(',', $cr, $ind5, 'start:', @start)"/>
		</xsl:if>
		<xsl:if test="@offset">
			<xsl:value-of select="concat(',', $cr, $ind5, 'offset:', @offset)"/>
		</xsl:if>
		<xsl:if test="@size">
			<xsl:value-of select="concat(',', $cr, $ind5, 'size:', @size)"/>
		</xsl:if>
		<xsl:if test="@scroll">
			<xsl:value-of select="concat(',', $cr, $ind5, 'scroll:', @scroll)"/>
		</xsl:if>
		<xsl:if test="@visible">
			<xsl:value-of select="concat(',', $cr, $ind5, 'visible:', @visible)"/>
		</xsl:if>
		<xsl:if test="@animation">
			<xsl:value-of select="concat(',', $cr, $ind5, 'animation:&quot;', @animation, '&quot;')"/>
		</xsl:if>
		<xsl:if test="@auto">
			<xsl:value-of select="concat(',', $cr, $ind5, 'auto:', @auto)"/>
		</xsl:if>
		<xsl:if test="@wrap">
			<xsl:value-of select="concat(',', $cr, $ind5, 'wrap:&quot;', @wrap, '&quot;')"/>
		</xsl:if>
		<xsl:if test="@buttonNextHTML">
			<xsl:value-of select="concat(',', $cr, $ind5, 'buttonNextHTML:&quot;', @buttonNextHTML, '&quot;')"/>
		</xsl:if>
		<xsl:if test="@buttonPrevHTML">
			<xsl:value-of select="concat(',', $cr, $ind5, 'buttonPrevHTML:&quot;', @buttonPrevHTML, '&quot;')"/>
		</xsl:if>
		<xsl:if test="@buttonNextEvent">
			<xsl:value-of select="concat(',', $cr, $ind5, 'buttonNextEvent:&quot;', @buttonNextEvent, '&quot;')"/>
		</xsl:if>
		<xsl:if test="@buttonPrevEvent">
			<xsl:value-of select="concat(',', $cr, $ind5, 'buttonPrevEvent:&quot;', @buttonPrevEvent, '&quot;')"/>
		</xsl:if>
		<xsl:if test="$vertical = false and @width">
			<xsl:value-of select="concat(',', $cr, $ind5, 'itemFallbackDimension:', @width)"/>
		</xsl:if>
		<xsl:if test="$vertical = true and @height">
			<xsl:value-of select="concat(',', $cr, $ind5, 'itemFallbackDimension:', @height)"/>
		</xsl:if>
		<xsl:if test="@hover='pause'">
			<xsl:value-of select="concat(',', $cr, $ind5, 'initCallback: ', @name, '_initCallback')"/>
		</xsl:if>

		<xsl:value-of select="$cr"/>
		<xsl:value-of select="concat($ind4, '});', $cr)"/>
		<xsl:value-of select="concat($ind3, '});', $cr)"/>

		<xsl:value-of select="concat($ind2, ']]&gt;&lt;/xsl:text&gt;', $cr)"/>
		<xsl:value-of select="concat($ind1, '&lt;/xsl:element&gt;', $cr, $cr)"/>

	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTSCROLL2">
		<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:variable name="ind1">
			<xsl:call-template name="Indent">
				<xsl:with-param name="level" select="$indent"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="ind2" select="concat($ind1, $tab1)"/>
		<xsl:variable name="ind3" select="concat($ind2, $tab1)"/>

		<!-- ***************** Error Checking *******************-->
		<xsl:if test="not(@entity) and not(@datapath)">
			<xsl:call-template name="Error">
				<xsl:with-param name="msg" select="'WTSCROLL2 entity or datapath Missing'"/>
				<xsl:with-param name="text" select="'WTSCROLL2'"/>
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="not(@name)">
			<xsl:call-template name="Error">
				<xsl:with-param name="msg" select="'WTSCROLL2 name Missing'"/>
				<xsl:with-param name="text" select="'WTSCROLL2'"/>
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="not(@skin)">
			<xsl:call-template name="Error">
				<xsl:with-param name="msg" select="'WTSCROLL2 skin Missing'"/>
				<xsl:with-param name="text" select="'WTSCROLL2'"/>
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
					<xsl:when test="name()='entity'"/>
					<xsl:when test="name()='datapath'"/>
					<xsl:when test="name()='skin'"/>
					<xsl:when test="name()='width'"/>
					<xsl:when test="name()='height'"/>
					<xsl:when test="name()='vertical'"/>
					<xsl:when test="name()='rtl'"/>
					<xsl:when test="name()='start'"/>
					<xsl:when test="name()='offset'"/>
					<xsl:when test="name()='size'"/>
					<xsl:when test="name()='scroll'"/>
					<xsl:when test="name()='visible'"/>
					<xsl:when test="name()='auto'"/>
					<xsl:when test="name()='animation'"/>
					<xsl:when test="name()='wrap'"/>
					<xsl:when test="name()='buttonNextHTML'"/>
					<xsl:when test="name()='buttonPrevHTML'"/>
					<xsl:when test="name()='buttonNextEvent'"/>
					<xsl:when test="name()='buttonPrevEvent'"/>
					<xsl:when test="name()='itemFallbackDimension'"/>
					<xsl:when test="name()='hover'"/>
					<xsl:otherwise>
						<xsl:call-template name="Error">
							<xsl:with-param name="msg" select="'WTSCROLL2 Invalid Attribute'"/>
							<xsl:with-param name="text" select="name()"/>
						</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:if>
		</xsl:for-each>

		<xsl:value-of select="concat($ind1, '&lt;xsl:element name=&quot;ul&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($ind2, '&lt;xsl:attribute name=&quot;id&quot;&gt;', @name, '&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($ind2, '&lt;xsl:attribute name=&quot;class&quot;&gt;jcarousel-skin-', @skin, '&lt;/xsl:attribute&gt;', $cr)"/>

		<!--for-each-->
		<xsl:value-of select="concat($ind2, '&lt;xsl:for-each select=&quot;')"/>
		<xsl:choose>
			<xsl:when test="@datapath">
				<xsl:value-of select="@datapath"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="XSLDataPath">
					<xsl:with-param name="entity" select="@entity"/>
					<xsl:with-param name="iscollection" select="true()"/>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:value-of select="concat($tab0, '&quot;&gt;', $cr)"/>

		<xsl:value-of select="concat($ind3, '&lt;xsl:element name=&quot;li&quot;&gt;', $cr)"/>
		<!--apply child templates-->
		<xsl:apply-templates>
			<xsl:with-param name="indent" select="$indent+4"/>
		</xsl:apply-templates>
		<xsl:value-of select="concat($ind3, '&lt;/xsl:element&gt;', $cr)"/>

		<!--end for-each-->
		<xsl:value-of select="concat($ind2, '&lt;/xsl:for-each&gt;', $cr)"/>

		<xsl:value-of select="concat($ind1, '&lt;/xsl:element&gt;', $cr, $cr)"/>

	</xsl:template>

	<!--==================================================================-->
	<xsl:template name="SlideHeader">
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
		<xsl:variable name="ind6" select="concat($ind5, $tab1)"/>

		<xsl:variable name="maxwidth">
			<xsl:choose>
				<xsl:when test="@width"><xsl:value-of select="@width"/></xsl:when>
				<xsl:otherwise>800</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:value-of select="concat($ind1, '&lt;xsl:element name=&quot;SCRIPT&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($ind2, '&lt;xsl:attribute name=&quot;language&quot;&gt;JavaScript&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($ind2, '&lt;xsl:text disable-output-escaping=&quot;yes&quot;&gt;&lt;![CDATA[', $cr)"/>

		<xsl:value-of select="concat($ind3, '$(function() {', $cr)"/>
		<xsl:value-of select="concat($ind4, '$(&quot;#', @name, '&quot;).refineSlide({', $cr)"/>

		<xsl:value-of select="concat($ind5, 'maxWidth:&quot;', $maxwidth, '&quot;')"/>
		<xsl:if test="@transition">
			<xsl:value-of select="concat(',', $cr, $ind5, 'transition:&quot;', @transition, '&quot;')"/>
		</xsl:if>
		<xsl:if test="@fallback3d">
			<xsl:value-of select="concat(',', $cr, $ind5, 'fallback3d:&quot;', @fallback3d, '&quot;')"/>
		</xsl:if>
		<xsl:if test="@autoplay">
			<xsl:value-of select="concat(',', $cr, $ind5, 'autoPlay:', @autoplay)"/>
		</xsl:if>
		<xsl:if test="@delay">
			<xsl:value-of select="concat(',', $cr, $ind5, 'delay:', @delay)"/>
		</xsl:if>
		<xsl:if test="@perspective">
			<xsl:value-of select="concat(',', $cr, $ind5, 'perspective:', @perspective)"/>
		</xsl:if>
		<xsl:if test="@usethumbs">
			<xsl:value-of select="concat(',', $cr, $ind5, 'useThumbs:', @usethumbs)"/>
		</xsl:if>
		<xsl:if test="@usearrows">
			<xsl:value-of select="concat(',', $cr, $ind5, 'useArrows:', @usearrows)"/>
		</xsl:if>
		<xsl:if test="@thumbmargin">
			<xsl:value-of select="concat(',', $cr, $ind5, 'thumbMargin:', @thumbmargin)"/>
		</xsl:if>
		<xsl:if test="@autoplay">
			<xsl:value-of select="concat(',', $cr, $ind5, 'autoPlay:', @autoplay)"/>
		</xsl:if>
		<xsl:if test="@delay">
			<xsl:value-of select="concat(',', $cr, $ind5, 'delay:', @delay)"/>
		</xsl:if>
		<xsl:if test="@transitionduration">
			<xsl:value-of select="concat(',', $cr, $ind5, 'transitionDuration:', @transitionduration)"/>
		</xsl:if>
		<xsl:if test="@startslide">
			<xsl:value-of select="concat(',', $cr, $ind5, 'startSlide:', @startslide)"/>
		</xsl:if>
		<xsl:if test="@keynav">
			<xsl:value-of select="concat(',', $cr, $ind5, 'keyNav:', @keynav)"/>
		</xsl:if>
		<xsl:if test="@captionwidth">
			<xsl:value-of select="concat(',', $cr, $ind5, 'captionWidth:', @captionwidth)"/>
		</xsl:if>
		<xsl:if test="@arrowtemplate">
			<xsl:value-of select="concat(',', $cr, $ind5, 'arrowTemplate:&quot;', @arrowtemplate, '&quot;')"/>
		</xsl:if>
		<xsl:value-of select="$cr"/>
		<xsl:value-of select="concat($ind4, '});', $cr)"/>
		<xsl:value-of select="concat($ind3, '});', $cr)"/>

		<xsl:value-of select="concat($ind2, ']]&gt;&lt;/xsl:text&gt;', $cr)"/>
		<xsl:value-of select="concat($ind1, '&lt;/xsl:element&gt;', $cr, $cr)"/>

	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTSLIDE">
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

		<!-- ***************** Error Checking *******************-->
		<xsl:if test="not(@entity) and not(@datapath)">
			<xsl:call-template name="Error">
				<xsl:with-param name="msg" select="'WTSLIDE entity or datapath Missing'"/>
				<xsl:with-param name="text" select="'WTSLIDE'"/>
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="not(@name)">
			<xsl:call-template name="Error">
				<xsl:with-param name="msg" select="'WTSLIDE name Missing'"/>
				<xsl:with-param name="text" select="'WTSLIDE'"/>
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="not(@width)">
			<xsl:call-template name="Error">
				<xsl:with-param name="msg" select="'WTSLIDE width Missing'"/>
				<xsl:with-param name="text" select="'WTSLIDE'"/>
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
					<xsl:when test="name()='entity'"/>
					<xsl:when test="name()='datapath'"/>
					<xsl:when test="name()='width'"/>
					<xsl:when test="name()='transition'"/>
					<xsl:when test="name()='fallback3d'"/>
					<xsl:when test="name()='autoplay'"/>
					<xsl:when test="name()='delay'"/>
					<xsl:when test="name()='perspective'"/>
					<xsl:when test="name()='usethumbs'"/>
					<xsl:when test="name()='usearrows'"/>
					<xsl:when test="name()='thumbmargin'"/>
					<xsl:when test="name()='autoplay'"/>
					<xsl:when test="name()='delay'"/>
					<xsl:when test="name()='transitionduration'"/>
					<xsl:when test="name()='startslide'"/>
					<xsl:when test="name()='keynav'"/>
					<xsl:when test="name()='captionwidth'"/>
					<xsl:when test="name()='arrowtemplate'"/>
					<xsl:when test="name()='customclass'"/>
					<xsl:when test="name()='itemclass'"/>
					<xsl:otherwise>
						<xsl:call-template name="Error">
							<xsl:with-param name="msg" select="'WTSLIDE Invalid Attribute'"/>
							<xsl:with-param name="text" select="name()"/>
						</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:if>
		</xsl:for-each>

		<xsl:variable name="customclass">
			<xsl:choose>
				<xsl:when test="@customclass"><xsl:value-of select="@customclass"/></xsl:when>
				<xsl:otherwise>rs-slider</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="itemclass">
			<xsl:choose>
				<xsl:when test="@itemclass"><xsl:value-of select="@itemclass"/></xsl:when>
				<xsl:otherwise>group</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:value-of select="concat($ind1, '&lt;xsl:element name=&quot;ul&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($ind2, '&lt;xsl:attribute name=&quot;id&quot;&gt;', @name, '&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($ind2, '&lt;xsl:attribute name=&quot;class&quot;&gt;', $customclass, '&lt;/xsl:attribute&gt;', $cr)"/>

		<!--for-each-->
		<xsl:value-of select="concat($ind2, '&lt;xsl:for-each select=&quot;')"/>
		<xsl:choose>
			<xsl:when test="@datapath">
				<xsl:value-of select="@datapath"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="XSLDataPath">
					<xsl:with-param name="entity" select="@entity"/>
					<xsl:with-param name="iscollection" select="true()"/>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:value-of select="concat($tab0, '&quot;&gt;', $cr)"/>

		<xsl:value-of select="concat($ind3, '&lt;xsl:element name=&quot;li&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;class&quot;&gt;', $itemclass, '&lt;/xsl:attribute&gt;', $cr)"/>

		<!--apply child templates-->
		<xsl:apply-templates>
			<xsl:with-param name="indent" select="$indent+2"/>
		</xsl:apply-templates>
		
		<xsl:value-of select="concat($ind3, '&lt;/xsl:element&gt;', $cr)"/>

		<!--end for-each-->
		<xsl:value-of select="concat($ind2, '&lt;/xsl:for-each&gt;', $cr)"/>

		<xsl:value-of select="concat($ind1, '&lt;/xsl:element&gt;', $cr, $cr)"/>

	</xsl:template>

	<!--==================================================================-->
	<xsl:template name="Slide2Header">
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
		<xsl:variable name="ind6" select="concat($ind5, $tab1)"/>

		<xsl:variable name="width">
			<xsl:choose>
				<xsl:when test="@width">
					<xsl:value-of select="@width"/>
				</xsl:when>
				<xsl:otherwise>800</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:value-of select="concat($ind1, '&lt;xsl:element name=&quot;SCRIPT&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($ind2, '&lt;xsl:attribute name=&quot;language&quot;&gt;JavaScript&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($ind2, '&lt;xsl:text disable-output-escaping=&quot;yes&quot;&gt;&lt;![CDATA[', $cr)"/>

		<xsl:value-of select="concat($ind3, '$(function() {', $cr)"/>
		<xsl:value-of select="concat($ind4, '$(&quot;#', @name, '&quot;).bjqs({', $cr)"/>

		<xsl:value-of select="concat($ind5, 'width:', $width)"/>
		<xsl:if test="@height">
			<xsl:value-of select="concat(',', $cr, $ind5, 'height:', @height)"/>
		</xsl:if>
		<xsl:if test="@animtype">
			<xsl:value-of select="concat(',', $cr, $ind5, 'animtype:&quot;', @animtype, '&quot;')"/>
		</xsl:if>
		<xsl:if test="@animduration">
			<xsl:value-of select="concat(',', $cr, $ind5, 'animduration:', @animduration)"/>
		</xsl:if>
		<xsl:if test="@animspeed">
			<xsl:value-of select="concat(',', $cr, $ind5, 'animspeed:', @animspeed)"/>
		</xsl:if>
		<xsl:if test="@automatic">
			<xsl:value-of select="concat(',', $cr, $ind5, 'automatic:', @automatic)"/>
		</xsl:if>
		<xsl:if test="@showcontrols">
			<xsl:value-of select="concat(',', $cr, $ind5, 'showcontrols:', @showcontrols)"/>
		</xsl:if>
		<xsl:if test="@centercontrols">
			<xsl:value-of select="concat(',', $cr, $ind5, 'centercontrols:', @centercontrols)"/>
		</xsl:if>
		<xsl:if test="@nexttext">
			<xsl:value-of select="concat(',', $cr, $ind5, 'nexttext:&quot;', @nexttext, '&quot;')"/>
		</xsl:if>
		<xsl:if test="@prevtext">
			<xsl:value-of select="concat(',', $cr, $ind5, 'prevtext:&quot;', @prevtext, '&quot;')"/>
		</xsl:if>
		<xsl:if test="@showmarkers">
			<xsl:value-of select="concat(',', $cr, $ind5, 'showmarkers:', @showmarkers)"/>
		</xsl:if>
		<xsl:if test="@centermarkers">
			<xsl:value-of select="concat(',', $cr, $ind5, 'centermarkers:', @centermarkers)"/>
		</xsl:if>
		<xsl:if test="@keyboardnav">
			<xsl:value-of select="concat(',', $cr, $ind5, 'keyboardnav:', @keyboardnav)"/>
		</xsl:if>
		<xsl:if test="@hoverpause">
			<xsl:value-of select="concat(',', $cr, $ind5, 'hoverpause:', @hoverpause)"/>
		</xsl:if>
		<xsl:if test="@usecaptions">
			<xsl:value-of select="concat(',', $cr, $ind5, 'usecaptions:', @usecaptions)"/>
		</xsl:if>
		<xsl:if test="@randomstart">
			<xsl:value-of select="concat(',', $cr, $ind5, 'randomstart:', @randomstart)"/>
		</xsl:if>
		<xsl:if test="@responsive">
			<xsl:value-of select="concat(',', $cr, $ind5, 'responsive:', @responsive)"/>
		</xsl:if>
		<xsl:value-of select="$cr"/>
		<xsl:value-of select="concat($ind4, '});', $cr)"/>
		<xsl:value-of select="concat($ind3, '});', $cr)"/>

		<xsl:value-of select="concat($ind2, ']]&gt;&lt;/xsl:text&gt;', $cr)"/>
		<xsl:value-of select="concat($ind1, '&lt;/xsl:element&gt;', $cr, $cr)"/>

	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTSLIDE2">
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

		<!-- ***************** Error Checking *******************-->
		<xsl:if test="not(@entity) and not(@datapath)">
			<xsl:call-template name="Error">
				<xsl:with-param name="msg" select="'WTSLIDE2 entity or datapath Missing'"/>
				<xsl:with-param name="text" select="'WTSLIDE2'"/>
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="not(@name)">
			<xsl:call-template name="Error">
				<xsl:with-param name="msg" select="'WTSLIDE2 name Missing'"/>
				<xsl:with-param name="text" select="'WTSLIDE2'"/>
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="not(@width)">
			<xsl:call-template name="Error">
				<xsl:with-param name="msg" select="'WTSLIDE2 width Missing'"/>
				<xsl:with-param name="text" select="'WTSLIDE2'"/>
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="not(@height)">
			<xsl:call-template name="Error">
				<xsl:with-param name="msg" select="'WTSLIDE2 height Missing'"/>
				<xsl:with-param name="text" select="'WTSLIDE2'"/>
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
					<xsl:when test="name()='entity'"/>
					<xsl:when test="name()='datapath'"/>
					<xsl:when test="name()='width'"/>
					<xsl:when test="name()='height'"/>
					<xsl:when test="name()='animtype'"/>
					<xsl:when test="name()='animduration'"/>
					<xsl:when test="name()='animspeed'"/>
					<xsl:when test="name()='automatic'"/>
					<xsl:when test="name()='showcontrols'"/>
					<xsl:when test="name()='centercontrols'"/>
					<xsl:when test="name()='nexttext'"/>
					<xsl:when test="name()='prevtext'"/>
					<xsl:when test="name()='showmarkers'"/>
					<xsl:when test="name()='centermarkers'"/>
					<xsl:when test="name()='keyboardnav'"/>
					<xsl:when test="name()='hoverpause'"/>
					<xsl:when test="name()='usecaptions'"/>
					<xsl:when test="name()='randomstart'"/>
					<xsl:when test="name()='responsive'"/>
					<xsl:otherwise>
						<xsl:call-template name="Error">
							<xsl:with-param name="msg" select="'WTSLIDE2 Invalid Attribute'"/>
							<xsl:with-param name="text" select="name()"/>
						</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:if>
		</xsl:for-each>

		<xsl:value-of select="concat($ind1, '&lt;xsl:element name=&quot;div&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($ind2, '&lt;xsl:attribute name=&quot;id&quot;&gt;', @name, '&lt;/xsl:attribute&gt;', $cr)"/>

		<xsl:value-of select="concat($ind2, '&lt;xsl:element name=&quot;ul&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;class&quot;&gt;bjqs&lt;/xsl:attribute&gt;', $cr)"/>

		<!--for-each-->
		<xsl:value-of select="concat($ind3, '&lt;xsl:for-each select=&quot;')"/>
		<xsl:choose>
			<xsl:when test="@datapath">
				<xsl:value-of select="@datapath"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="XSLDataPath">
					<xsl:with-param name="entity" select="@entity"/>
					<xsl:with-param name="iscollection" select="true()"/>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:value-of select="concat($tab0, '&quot;&gt;', $cr)"/>

		<xsl:value-of select="concat($ind4, '&lt;xsl:element name=&quot;li&quot;&gt;', $cr)"/>

		<!--apply child templates-->
		<xsl:apply-templates>
			<xsl:with-param name="indent" select="$indent+2"/>
		</xsl:apply-templates>

		<xsl:value-of select="concat($ind4, '&lt;/xsl:element&gt;', $cr)"/>

		<!--end for-each-->
		<xsl:value-of select="concat($ind3, '&lt;/xsl:for-each&gt;', $cr)"/>

		<xsl:value-of select="concat($ind2, '&lt;/xsl:element&gt;', $cr)"/>
		<xsl:value-of select="concat($ind1, '&lt;/xsl:element&gt;', $cr, $cr)"/>

	</xsl:template>

</xsl:stylesheet>
