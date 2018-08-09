<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<!--===============================================================================
	Auth: Bob Wood	
	Date: April 2006
	Desc: Creates an ASP Tab definition
	Copyright 2006 WinTech, Inc.
===================================================================================-->

	<xsl:variable name="TabChr" select="'&#009;'"/>
<!--	<xsl:variable name="tab" select="''"/>-->
	<xsl:variable name="TabStr" select="'s=s+'"/>

	<!--==================================================================-->
	<xsl:template match="WTTAB">
	<!--==================================================================-->
		<xsl:variable name="ind0" select="''"/>
		<xsl:variable name="ind1" select="$TabChr"/>
		<xsl:variable name="ind2" select="concat($ind1, $TabChr)"/>
		<xsl:variable name="hasconditions" select="(count(WTCONDITION) > 0)"/>

		<!--generate IF statement for conditions if they exist-->
		<xsl:if test="($hasconditions)">
			<xsl:call-template name="ASPConditionStart">
				<xsl:with-param name="indent" select="0"/>
				<xsl:with-param name="conditions" select="WTCONDITION"/>
			</xsl:call-template>
		</xsl:if>

		<xsl:variable name="persist">
			<xsl:choose>
			<xsl:when test="@persist or ancestor::WTTEMPLATE"><xsl:value-of select="'true'"/></xsl:when>
			<xsl:otherwise><xsl:value-of select="'false'"/></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:if test="$persist='true'">
			<xsl:value-of select="concat($ind0, '&lt;%', $cr)"/>
			<xsl:value-of select="concat($ind0, 'Function Get', @name, '()', $cr)"/>
		</xsl:if>

		<xsl:value-of select="concat($ind0, 's = &quot;&lt;TAB')"/>
		<!-- Get All Attributes -->
		<xsl:for-each select="@*">
			<xsl:variable name="valuetype"><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="."/></xsl:call-template></xsl:variable>
			<xsl:variable name="valuetext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="."/></xsl:call-template></xsl:variable>

			<xsl:if test="$valuetype!='NONE'">
				<xsl:variable name="value">
					<xsl:value-of select="'&quot; &amp; '"/>
					<xsl:call-template name="GetValue">
		  				<xsl:with-param name="type" select="$valuetype"/>
		  				<xsl:with-param name="text" select="$valuetext"/>
   					<xsl:with-param name="hidden" select="true()"/>
					</xsl:call-template>
					<xsl:value-of select="' &amp; &quot;'"/>
				</xsl:variable>

				<xsl:value-of select="concat(' ', name(), '=&quot;&quot;', $value, '&quot;&quot;')"/>
			</xsl:if>
			<xsl:if test="$valuetype='NONE'">
				<xsl:value-of select="concat(' ', name(), '=&quot;&quot;', ., '&quot;&quot;')"/>
			</xsl:if>
		</xsl:for-each>
		<xsl:value-of select="concat('&gt;&quot;', $cr)"/>

		<xsl:apply-templates>
			<xsl:with-param name="indent" select="$ind1"/>
		</xsl:apply-templates>

		<xsl:value-of select="concat($ind0, $TabStr, '&quot;&lt;/TAB&gt;&quot;', $cr)"/>
		<xsl:if test="$persist='true'">
			<xsl:value-of select="concat($ind0, 'Get', @name, ' = s', $cr)"/>
			<xsl:value-of select="concat($ind0, 'End Function', $cr)"/>
			<xsl:value-of select="concat($ind0, '%&gt;', $cr)"/>
		</xsl:if>
		<xsl:if test="$persist='false'">
			<xsl:value-of select="concat($ind0, 'xml', @name, ' = s', $cr, $cr)"/>
		</xsl:if>

		<!--close IF statement for conditions if they exist-->
		<xsl:if test="($hasconditions)">
			<xsl:call-template name="ASPConditionEnd">
				<xsl:with-param name="indent" select="0"/>
			</xsl:call-template>
		</xsl:if>

	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTITEM">
	<!--==================================================================-->
		<xsl:param name="indent"/>

		<xsl:variable name="hasconditions" select="(count(WTCONDITION) > 0)"/>
		<xsl:variable name="ind0" select="$indent"/>
		<xsl:variable name="ind1" select="concat($ind0, $TabChr)"/>

		<!--generate IF statement for conditions if they exist-->
		<xsl:if test="($hasconditions)">
			<xsl:call-template name="ASPConditionStart">
				<xsl:with-param name="indent" select="string-length($indent) + 1"/>
				<xsl:with-param name="conditions" select="WTCONDITION"/>
			</xsl:call-template>
		</xsl:if>

		<xsl:value-of select="concat($TabStr, $ind0, '&quot;&lt;ITEM')"/>
		<!-- Get All Attributes -->
		<xsl:for-each select="@*">
			<xsl:variable name="valuetype"><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="."/></xsl:call-template></xsl:variable>
			<xsl:variable name="valuetext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="."/></xsl:call-template></xsl:variable>

			<xsl:if test="$valuetype!='NONE'">
				<xsl:variable name="value">
					<xsl:value-of select="'&quot; &amp; '"/>
					<xsl:call-template name="GetValue">
		  				<xsl:with-param name="type" select="$valuetype"/>
		  				<xsl:with-param name="text" select="$valuetext"/>
   					<xsl:with-param name="hidden" select="true()"/>
					</xsl:call-template>
					<xsl:value-of select="' &amp; &quot;'"/>
				</xsl:variable>

				<xsl:value-of select="concat(' ', name(), '=&quot;&quot;', $value, '&quot;&quot;')"/>
			</xsl:if>
			<xsl:if test="$valuetype='NONE'">
				<xsl:value-of select="concat(' ', name(), '=&quot;&quot;', ., '&quot;&quot;')"/>
			</xsl:if>
		</xsl:for-each>

		<xsl:if test="not(WTITEM) and not(WTLINK) and not(WTCODEGROUP)">
			<xsl:value-of select="concat('/&gt;&quot;', $cr)"/>
		</xsl:if>

		<xsl:if test="WTITEM or WTLINK or WTCODEGROUP">
			<xsl:value-of select="concat('&gt;&quot;', $cr)"/>

			<xsl:apply-templates>
				<xsl:with-param name="indent" select="$ind1"/>
			</xsl:apply-templates>

			<xsl:value-of select="concat($TabStr, $ind0, '&quot;&lt;/ITEM&gt;&quot;', $cr)"/>
		</xsl:if>

		<!--close IF statement for conditions if they exist-->
		<xsl:if test="($hasconditions)">
			<xsl:call-template name="ASPConditionEnd">
				<xsl:with-param name="indent" select="string-length($indent) + 1"/>
			</xsl:call-template>
		</xsl:if>

	</xsl:template>

	<!--=================================================================-->
	<xsl:template match="WTITEM/WTLINK">
	<!--==================================================================-->
		<xsl:param name="indent"/>

		<xsl:variable name="ind0" select="$indent"/>
		<xsl:variable name="ind1" select="concat($ind0, $TabChr)"/>

		<xsl:value-of select="concat($TabStr, $ind0, '&quot;&lt;LINK')"/>
		<!-- Get All Attributes -->
		<xsl:for-each select="@*">
				<xsl:value-of select="concat(' ', name(), '=&quot;&quot;', ., '&quot;&quot;')"/>
		</xsl:for-each>

		<xsl:if test="not(WTPARAM)">
			<xsl:value-of select="concat('/&gt;&quot;', $cr)"/>
		</xsl:if>

		<xsl:if test="WTPARAM">
			<xsl:value-of select="concat('&gt;&quot;', $cr)"/>

			<xsl:apply-templates mode="menu">
				<xsl:with-param name="indent" select="$ind1"/>
			</xsl:apply-templates>

			<xsl:value-of select="concat($TabStr, $ind0, '&quot;&lt;/LINK&gt;&quot;', $cr)"/>
		</xsl:if>

	</xsl:template>

	<!--=================================================================-->
	<xsl:template match="WTPARAM" mode="menu">
	<!--==================================================================-->
		<xsl:param name="indent"/>

		<xsl:variable name="ind0" select="$indent"/>
		<xsl:variable name="ind1" select="concat($ind0, $TabChr)"/>
		<xsl:variable name="valuetype"><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>
		<xsl:variable name="valuetext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>

		<xsl:value-of select="concat($TabStr, $ind0, '&quot;&lt;PARAM')"/>

		<xsl:variable name="value">
			<xsl:value-of select="'&quot; &amp; '"/>
			<xsl:call-template name="GetValue">
		  		<xsl:with-param name="type" select="$valuetype"/>
		  		<xsl:with-param name="text" select="$valuetext"/>
   			<xsl:with-param name="hidden" select="true()"/>
			</xsl:call-template>
			<xsl:value-of select="' &amp; &quot;'"/>
		</xsl:variable>

		<xsl:value-of select="concat(' name=&quot;&quot;', @name, '&quot;&quot;')"/>

		<xsl:if test="$valuetype='NONE' or $valuetype='CONST'">
			<xsl:value-of select="concat(' value=&quot;&quot;', $valuetext, '&quot;&quot;')"/>
		</xsl:if>
		<xsl:if test="$valuetype!='NONE' and $valuetype!='CONST'">
			<xsl:value-of select="concat(' value=&quot;&quot;', $value, '&quot;&quot;')"/>
		</xsl:if>

		<xsl:value-of select="concat('/&gt;&quot;', $cr)"/>

	</xsl:template>

	<!--=================================================================-->
	<xsl:template match="WTITEM/WTCODEGROUP">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:variable name="ind0" select="$indent"/>
		<xsl:variable name="hasconditions" select="(count(WTCONDITION) > 0)"/>

		<!--generate IF statement for conditions if they exist-->
		<xsl:if test="($hasconditions)">
			<xsl:call-template name="ASPConditionStart">
				<xsl:with-param name="indent" select="string-length($indent) + 1"/>
				<xsl:with-param name="conditions" select="WTCONDITION"/>
			</xsl:call-template>
		</xsl:if>

		<xsl:apply-templates>
			<xsl:with-param name="indent" select="$ind0"/>
		</xsl:apply-templates>

		<!--close IF statement for conditions if they exist-->
		<xsl:if test="($hasconditions)">
			<xsl:call-template name="ASPConditionEnd">
				<xsl:with-param name="indent" select="string-length($indent) + 1"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>

	<!--=================================================================-->
	<xsl:template match="WTTAB/WTCODEGROUP">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:variable name="ind0" select="$indent"/>
		<xsl:variable name="hasconditions" select="(count(WTCONDITION) > 0)"/>

		<!--generate IF statement for conditions if they exist-->
		<xsl:if test="($hasconditions)">
			<xsl:call-template name="ASPConditionStart">
				<xsl:with-param name="indent" select="string-length($indent) + 1"/>
				<xsl:with-param name="conditions" select="WTCONDITION"/>
			</xsl:call-template>
		</xsl:if>

		<xsl:apply-templates>
			<xsl:with-param name="indent" select="$ind0"/>
		</xsl:apply-templates>

		<!--close IF statement for conditions if they exist-->
		<xsl:if test="($hasconditions)">
			<xsl:call-template name="ASPConditionEnd">
				<xsl:with-param name="indent" select="string-length($indent) + 1"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>

</xsl:stylesheet>
