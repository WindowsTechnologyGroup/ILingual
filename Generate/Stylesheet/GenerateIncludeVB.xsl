<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:include href="GenerateInclude.xsl"/>

	<!--==================================================================-->
	<xsl:template match="WTATTRIBUTE" mode="getadorecords">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="ind2" select="concat($ind1, $tab1)"/>
		<xsl:variable name="indent2" select="($indent+1)"/>
		<xsl:variable name="ind3" select="concat($ind2, $tab1)"/>
		<xsl:variable name="indent3" select="($indent2+1)"/>
		<xsl:variable name="ind4" select="concat($ind3, $tab1)"/>
		<xsl:variable name="indent4" select="($indent3+1)"/>
		<xsl:variable name="nametype"><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>
		<xsl:variable name="nametext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>
		<xsl:variable name="nameentity"><xsl:call-template name="QualifiedPrefix"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>
		<xsl:variable name="nametxt">
			<xsl:if test="not(@alias)"><xsl:value-of select="$nametext"/></xsl:if>
			<xsl:if test="@alias"><xsl:value-of select="@alias"/></xsl:if>
		</xsl:variable>

		<xsl:if test="position()=1">
			<xsl:call-template name="VBComment">
				<xsl:with-param name="indent" select="$indent"/>
				<xsl:with-param name="value">populate the record from the recordset</xsl:with-param>
			</xsl:call-template>
			<xsl:value-of select="concat($ind1, 'With oRecs', $cr)"/>
			<xsl:value-of select="concat($ind2, 'If oRecs.EOF = True Then', $cr)"/>
			<xsl:value-of select="concat($ind3, 'ReDim vRecs(0 To 0)', $cr)"/>
			<xsl:value-of select="concat($ind2, 'Else', $cr)"/>
			<xsl:value-of select="concat($ind3, '.MoveFirst', $cr)"/>
			<xsl:value-of select="concat($ind3, 'idxRec = 0', $cr)"/>
			<xsl:value-of select="concat($ind3, 'Do While .EOF = False', $cr)"/>
		</xsl:if>

		<xsl:choose>
			<xsl:when test="($nametype='ATTR')">
				<xsl:call-template name="VBRecordsetFetch">
					<xsl:with-param name="indent" select="$indent2"/>
					<xsl:with-param name="name" select="$nametxt"/>
<!--
					<xsl:with-param name="assignto" select="concat('vRec.', $nametxt)"/>
-->
					<xsl:with-param name="assignto" select="concat('vRec.', $nametext)"/>
<!--
					<xsl:with-param name="type" select="/Data/WTENTITY/WTATTRIBUTE[@name=$nametxt]/@type"/>
-->
					<xsl:with-param name="type" select="/Data/WTENTITY/WTATTRIBUTE[@name=$nametext]/@type"/>
				</xsl:call-template>
			</xsl:when>
		</xsl:choose>

		<xsl:if test="position()=last()">
			<xsl:value-of select="concat($ind4, 'idxRec = idxRec + 1', $cr)"/>
			<xsl:value-of select="concat($ind4, 'ReDim Preserve vRecs(0 To idxRec)', $cr)"/>
			<xsl:value-of select="concat($ind4, 'vRecs(idxRec) = vRec', $cr)"/>
			<xsl:value-of select="concat($ind4, '.MoveNext', $cr)"/>
			<xsl:value-of select="concat($ind3, 'Loop', $cr)"/>
			<xsl:value-of select="concat($ind2, 'End If', $cr)"/>
			<xsl:value-of select="concat($ind1, 'End With', $cr, $cr)"/>
		</xsl:if>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTPARAM" mode="callbusn">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:param name="functype">sub</xsl:param>
		<xsl:param name="funcret">tRecs</xsl:param>
		
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="ind2" select="concat($ind1, $tab1)"/>
		<xsl:variable name="indent2" select="($indent+1)"/>
		<xsl:variable name="nametype"><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="@name"/></xsl:call-template></xsl:variable>
		<xsl:variable name="nametext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@name"/></xsl:call-template></xsl:variable>
		<xsl:variable name="nameentity"><xsl:call-template name="QualifiedPrefix"><xsl:with-param name="value" select="@name"/></xsl:call-template></xsl:variable>

		<xsl:if test="position() = 1">
			<xsl:value-of select="concat($ind1, $funcret, ' = BusnService.', ../@name, '(')"/>
		</xsl:if>

		<xsl:choose>
			<xsl:when test="($nametype='ATTR')"><xsl:value-of select="concat('bv', $nametext)"/></xsl:when>
			<xsl:when test="($nametype='CONST')"><xsl:value-of select="concat('bv', $nametext)"/></xsl:when>
			<xsl:when test="($nametype='SYS') and ($nametext='userid')"><xsl:value-of select="('mSecurityToken')"/></xsl:when>
			<xsl:when test="($nametype='SYS') and ($nametext='security')"><xsl:value-of select="('mSecurityToken')"/></xsl:when>
		</xsl:choose>

		<xsl:choose>
			<xsl:when test="position() = last()"><xsl:value-of select="concat(')', $cr, $cr)"/></xsl:when>
			<xsl:otherwise><xsl:value-of select="(', ')"/></xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTPARAM" mode="listparam">
	<!--==================================================================-->
		
		<xsl:variable name="nametype"><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="@name"/></xsl:call-template></xsl:variable>
		<xsl:variable name="nametext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@name"/></xsl:call-template></xsl:variable>
		<xsl:variable name="nameentity"><xsl:call-template name="QualifiedPrefix"><xsl:with-param name="value" select="@name"/></xsl:call-template></xsl:variable>

		<xsl:choose>
			<xsl:when test="($nametype='ATTR')"><xsl:value-of select="concat('bv', $nametext)"/></xsl:when>
			<xsl:when test="($nametype='CONST')"><xsl:value-of select="concat('bv', $nametext)"/></xsl:when>
			<xsl:when test="($nametype='SYS') and ($nametext='userid')"><xsl:value-of select="('mSecurityToken')"/></xsl:when>
			<xsl:when test="($nametype='SYS') and ($nametext='security')"><xsl:value-of select="('mSecurityToken')"/></xsl:when>
		</xsl:choose>

		<xsl:if test="position() != last()"><xsl:value-of select="', '"/></xsl:if>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTPARAM" mode="inputparam">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:param name="functype">sub</xsl:param>
		<xsl:param name="close">yes</xsl:param>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="ind2" select="concat($ind1, $tab1)"/>
		<xsl:variable name="indent2" select="($indent+1)"/>
		<xsl:variable name="nametype"><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="@name"/></xsl:call-template></xsl:variable>
		<xsl:variable name="nametext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@name"/></xsl:call-template></xsl:variable>
		<xsl:variable name="nameentity"><xsl:call-template name="QualifiedPrefix"><xsl:with-param name="value" select="@name"/></xsl:call-template></xsl:variable>

		<xsl:choose>
			<xsl:when test="($nametype='ATTR')">
				<xsl:call-template name="VBParam">
					<xsl:with-param name="name" select="@name"/>
					<xsl:with-param name="type" select="/Data/WTENTITY/WTATTRIBUTE[@name=$nametext]/@type"/>
					<xsl:with-param name="optional" select="false"/>
					<xsl:with-param name="continue" select="position() != last()"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="($nametype='CONST')">
				<xsl:call-template name="VBParam">
					<xsl:with-param name="name" select="@name"/>
					<xsl:with-param name="type" select="@datatype"/>
					<xsl:with-param name="optional" select="false"/>
					<xsl:with-param name="continue" select="position() != last()"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="($nametype='SYS') and ($nametext='userid')">
				<xsl:call-template name="VBParam">
					<xsl:with-param name="name">UserID</xsl:with-param>
					<xsl:with-param name="type">number</xsl:with-param>
					<xsl:with-param name="optional" select="false"/>
					<xsl:with-param name="continue" select="position() != last()"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="($nametype='SYS') and ($nametext='security')">
				<xsl:call-template name="VBParam">
					<xsl:with-param name="name">SecurityToken</xsl:with-param>
					<xsl:with-param name="type">number</xsl:with-param>
					<xsl:with-param name="optional" select="false"/>
					<xsl:with-param name="continue" select="position() != last()"/>
				</xsl:call-template>
			</xsl:when>
		</xsl:choose>

		<xsl:if test="$close = 'yes'">
			<xsl:if test="position() = last()">
				<xsl:value-of select="(')')"/>
				<xsl:if test="($functype='sub')">
					<xsl:value-of select="$cr"/>
				</xsl:if>
			</xsl:if>
		</xsl:if>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTPARAM" mode="setparam">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="ind2" select="concat($ind1, $tab1)"/>
		<xsl:variable name="indent2" select="($indent+1)"/>
		<xsl:variable name="nametype"><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="@name"/></xsl:call-template></xsl:variable>
		<xsl:variable name="nametext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@name"/></xsl:call-template></xsl:variable>
		<xsl:variable name="nameentity"><xsl:call-template name="QualifiedPrefix"><xsl:with-param name="value" select="@name"/></xsl:call-template></xsl:variable>

		<xsl:if test="position()=1">
			<xsl:call-template name="VBComment">
				<xsl:with-param name="indent" select="$indent"/>
				<xsl:with-param name="value">set parameter properties</xsl:with-param>
			</xsl:call-template>
		</xsl:if>

		<xsl:variable name="type">
			<xsl:choose>
			<xsl:when test="$nametype='ATTR'"><xsl:value-of select="/Data/WTENTITY/WTATTRIBUTE[@name=$nametext]/@type"/></xsl:when>
			<xsl:when test="$nametype='CONST'"><xsl:value-of select="@datatype"/></xsl:when>
			</xsl:choose>
		</xsl:variable>

		<xsl:choose>
			<xsl:when test="$type='text'">
				<xsl:value-of select="concat($ind1, 'If bv', $nametext, ' &lt;&gt; &quot;&quot; Then ', $nametext, ' = bv', $nametext, $cr)"/>
			</xsl:when>
			<xsl:when test="$type='char'">
				<xsl:value-of select="concat($ind1, 'If bv', $nametext, ' &lt;&gt;  &quot;&quot; Then ', $nametext, ' = bv', $nametext, $cr)"/>
			</xsl:when>
			<xsl:when test="($nametype='SYS') and ($nametext='userid')">
				<xsl:value-of select="concat($ind1, 'If bvUserID &lt;&gt; 0 Then mSecurityToken = bvUserID', $cr)"/>
			</xsl:when>
			<xsl:when test="($nametype='SYS') and ($nametext='security')">
				<xsl:value-of select="concat($ind1, 'If bvSecurityToken &lt;&gt; 0 Then mSecurityToken = bvSecurityToken', $cr)"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:if test="@passthru">
					<xsl:value-of select="concat($ind1, $nametext, ' = bv', $nametext, $cr)"/>
				</xsl:if>
				<xsl:if test="not(@zero) and not(@passthru)">
					<xsl:value-of select="concat($ind1, 'If bv', $nametext, ' &lt;&gt; 0 Then ', $nametext, ' = bv', $nametext, $cr)"/>
				</xsl:if>
				<xsl:if test="@zero">
					<xsl:value-of select="concat($ind1, 'If bv', $nametext, ' = 0 Then ', $nametext, ' = bv', $nametext, $cr)"/>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>

		<xsl:if test="position()=last()">
			<xsl:value-of select="$cr"/>
		</xsl:if>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTPARAM" mode="getado">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="ind2" select="concat($ind1, $tab1)"/>
		<xsl:variable name="indent2" select="($indent+1)"/>
		<xsl:variable name="nametype"><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="@name"/></xsl:call-template></xsl:variable>
		<xsl:variable name="nametext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@name"/></xsl:call-template></xsl:variable>
		<xsl:variable name="nameentity"><xsl:call-template name="QualifiedPrefix"><xsl:with-param name="value" select="@name"/></xsl:call-template></xsl:variable>

		<xsl:if test="position()=1">
			<xsl:call-template name="VBComment">
				<xsl:with-param name="indent" select="$indent"/>
				<xsl:with-param name="value">get return values</xsl:with-param>
			</xsl:call-template>
			<xsl:value-of select="concat($ind1, 'With brRec', $cr)"/>
		</xsl:if>

		<xsl:choose>
			<xsl:when test="($nametype='ATTR')">
				<xsl:call-template name="VBADOGetParam">
					<xsl:with-param name="indent" select="$indent2"/>
					<xsl:with-param name="name" select="$nametext"/>
					<xsl:with-param name="type" select="/Data/WTENTITY/WTATTRIBUTE[@name=$nametext]/@type"/>
					<xsl:with-param name="assignto" select="concat('.', $nametext)"/>
				</xsl:call-template>
			</xsl:when>
		</xsl:choose>

		<xsl:if test="position()=last()">
			<xsl:value-of select="concat($ind1, 'End With', $cr, $cr)"/>
		</xsl:if>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTPARAM" mode="setado">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:param name="functype">sub</xsl:param>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="ind2" select="concat($ind1, $tab1)"/>
		<xsl:variable name="indent2" select="($indent+1)"/>
		<xsl:variable name="nametype"><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="@name"/></xsl:call-template></xsl:variable>
		<xsl:variable name="nametext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@name"/></xsl:call-template></xsl:variable>
		<xsl:variable name="nameentity"><xsl:call-template name="QualifiedPrefix"><xsl:with-param name="value" select="@name"/></xsl:call-template></xsl:variable>

		<xsl:if test="position()=1">
			<xsl:value-of select="$cr"/>
			<xsl:call-template name="VBComment">
				<xsl:with-param name="indent" select="$indent"/>
				<xsl:with-param name="value">populate the parameters for the procedure call</xsl:with-param>
			</xsl:call-template>
			<xsl:value-of select="concat($ind1, 'With oCmd', $cr)"/>
		</xsl:if>

		<xsl:choose>
			<xsl:when test="($nametype='ATTR') and ($functype='sub')">
				<xsl:call-template name="VBADOSetParam">
					<xsl:with-param name="indent" select="$indent2"/>
					<xsl:with-param name="name" select="$nametext"/>
					<xsl:with-param name="direction" select="@direction"/>
					<xsl:with-param name="value" select="concat('brRec.', $nametext)"/>
					<xsl:with-param name="type" select="/Data/WTENTITY/WTATTRIBUTE[@name=$nametext]/@type"/>
					<xsl:with-param name="length" select="/Data/WTENTITY/WTATTRIBUTE[@name=$nametext]/@length"/>
					<xsl:with-param name="precision" select="/Data/WTENTITY/WTATTRIBUTE[@name=$nametext]/@precision"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="($nametype='ATTR') and ($functype='function')">
				<xsl:call-template name="VBADOSetParam">
					<xsl:with-param name="indent" select="$indent2"/>
					<xsl:with-param name="name" select="$nametext"/>
					<xsl:with-param name="direction" select="@direction"/>
					<xsl:with-param name="value" select="concat('bv', $nametext)"/>
					<xsl:with-param name="type" select="/Data/WTENTITY/WTATTRIBUTE[@name=$nametext]/@type"/>
					<xsl:with-param name="length" select="/Data/WTENTITY/WTATTRIBUTE[@name=$nametext]/@length"/>
					<xsl:with-param name="precision" select="/Data/WTENTITY/WTATTRIBUTE[@name=$nametext]/@precision"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="($nametype='CONST')">
				<xsl:call-template name="VBADOSetParam">
					<xsl:with-param name="indent" select="$indent2"/>
					<xsl:with-param name="name" select="$nametext"/>
					<xsl:with-param name="direction" select="@direction"/>
					<xsl:with-param name="value" select="concat('bv', $nametext)"/>
					<xsl:with-param name="type" select="@datatype"/>
					<xsl:with-param name="length" select="@length"/>
					<xsl:with-param name="precision" select="@precision"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="($nametype='SYS') and ($nametext='userid')">
				<xsl:call-template name="VBADOSetParam">
					<xsl:with-param name="indent" select="$indent2"/>
					<xsl:with-param name="name">UserID</xsl:with-param>
					<xsl:with-param name="value">bvUserID</xsl:with-param>
					<xsl:with-param name="type">number</xsl:with-param>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="($nametype='SYS') and ($nametext='security')">
				<xsl:call-template name="VBADOSetParam">
					<xsl:with-param name="indent" select="$indent2"/>
					<xsl:with-param name="name">UserID</xsl:with-param>
					<xsl:with-param name="value">bvSecurityToken</xsl:with-param>
					<xsl:with-param name="type">number</xsl:with-param>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="VBADOSetParam">
					<xsl:with-param name="indent" select="$indent2"/>
					<xsl:with-param name="name" select="$nametext"/>
					<xsl:with-param name="direction" select="@direction"/>
					<xsl:with-param name="value" select="concat('brRec.', $nametext)"/>
					<xsl:with-param name="type" select="@datatype"/>
					<xsl:with-param name="length" select="@length"/>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>

		<xsl:if test="position()=last()">
			<xsl:value-of select="concat($ind1, 'End With', $cr, $cr)"/>
		</xsl:if>

	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTPARAM" mode="editinput">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:param name="functype" select="('sub')"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="ind2" select="concat($ind1, $tab1)"/>
		<xsl:variable name="indent2" select="($indent+1)"/>
		<xsl:variable name="nametype"><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="@name"/></xsl:call-template></xsl:variable>
		<xsl:variable name="nametext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@name"/></xsl:call-template></xsl:variable>
		<xsl:variable name="nameentity"><xsl:call-template name="QualifiedPrefix"><xsl:with-param name="value" select="@name"/></xsl:call-template></xsl:variable>

		<xsl:if test="(position()=1)">
			<xsl:call-template name="VBComment">
				<xsl:with-param name="indent" select="$indent"/>
				<xsl:with-param name="value">edit the input parameters</xsl:with-param>
			</xsl:call-template>
			<xsl:if test="($functype='sub')">
				<xsl:value-of select="concat($ind1, 'With brRec', $cr)"/>
			</xsl:if>
		</xsl:if>

		<xsl:variable name="required">
			<xsl:choose>
				<xsl:when test="@required='false'"><xsl:value-of select="''"/></xsl:when>
				<xsl:otherwise><xsl:value-of select="true()"/></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="type"><xsl:value-of select="/Data/WTENTITY/WTATTRIBUTE[@name=$nametext]/@type"/></xsl:variable>

		<xsl:variable name="default">
			<xsl:choose>
				<xsl:when test="($type='char')">""</xsl:when>
				<xsl:when test="($type='text')">""</xsl:when>
				<xsl:when test="($type='password')">""</xsl:when>
				<xsl:otherwise>0</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:choose>
			<xsl:when test="($nametype='ATTR') and ($functype='sub')">
				<xsl:call-template name="VBFieldEdit">
					<xsl:with-param name="indent" select="$indent2"/>
					<xsl:with-param name="assignto" select="concat('.', $nametext)"/>
					<xsl:with-param name="name" select="concat('.', $nametext)"/>
					<xsl:with-param name="label" select="$nametext"/>
					<xsl:with-param name="type" select="$type"/>
					<xsl:with-param name="default" select="$default"/>
					<xsl:with-param name="minval" select="/Data/WTENTITY/WTATTRIBUTE[@name=$nametext]/@min"/>
					<xsl:with-param name="maxval" select="/Data/WTENTITY/WTATTRIBUTE[@name=$nametext]/@max"/>
					<xsl:with-param name="required" select="$required"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="($nametype='ATTR') and ($functype='function')">
				<xsl:call-template name="VBFieldEdit">
					<xsl:with-param name="indent" select="$indent2"/>
					<xsl:with-param name="assignto" select="concat('bv', $nametext)"/>
					<xsl:with-param name="name" select="concat('bv', $nametext)"/>
					<xsl:with-param name="label" select="$nametext"/>
					<xsl:with-param name="type" select="$type"/>
					<xsl:with-param name="default" select="$default"/>
					<xsl:with-param name="minval" select="/Data/WTENTITY/WTATTRIBUTE[@name=$nametext]/@min"/>
					<xsl:with-param name="maxval" select="/Data/WTENTITY/WTATTRIBUTE[@name=$nametext]/@max"/>
					<xsl:with-param name="required" select="$required"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="($nametype='SYS') and ($nametext='userid')">
				<xsl:call-template name="VBFieldEdit">
					<xsl:with-param name="indent" select="$indent2"/>
					<xsl:with-param name="assignto">bvUserID</xsl:with-param>
					<xsl:with-param name="name">bvUserID</xsl:with-param>
					<xsl:with-param name="label">User ID</xsl:with-param>
					<xsl:with-param name="type">number</xsl:with-param>
					<xsl:with-param name="minval">1</xsl:with-param>
					<xsl:with-param name="required" select="true()"/>
				</xsl:call-template>
			</xsl:when>
		</xsl:choose>

		<xsl:if test="(position()=last()) and ($functype='sub')">
			<xsl:value-of select="concat($ind1, 'End With', $cr, $cr)"/>
		</xsl:if>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTATTRIBUTE/WTLOOKUP" mode="create">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>

		<xsl:choose>
			<xsl:when test="(@template='new')">
				<xsl:value-of select="concat($ind1, 'Set o', ../@name, ' = New ', $appprefix, @entity, '.C', @class, $cr)"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="concat($ind1, 'Set o', ../@name, ' = New ', $appprefix, @entity, 'User.C', @class, $cr)"/>
			</xsl:otherwise>
		</xsl:choose>

	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTATTRIBUTE/WTLOOKUP" mode="declare">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>

		<xsl:choose>
			<xsl:when test="(@template='new')">
				<xsl:value-of select="concat($ind1, 'Dim o', ../@name, ' As ', $appprefix, @entity, '.C', @class, $cr)"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="concat($ind1, 'Dim o', ../@name, ' As ', $appprefix, @entity, 'User.C', @class, $cr)"/>
			</xsl:otherwise>
		</xsl:choose>

	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTATTRIBUTE/WTLOOKUP" mode="destroy">
	<!--==================================================================-->
		<xsl:param name="indent"/>

		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>

		<xsl:value-of select="concat($ind1, 'Set o', ../@name, ' = Nothing', $cr)"/>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTATTRIBUTE/WTLOOKUP" mode="enumerate">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="ind2"><xsl:value-of select="concat($ind1, $tab1)"/></xsl:variable>

		<xsl:value-of select="concat($ind1, 'sChildren = sChildren + .', @method, '(')"/>

		<xsl:for-each select="WTPARAM">
			<!--interpret the parameters-->
			<xsl:variable name="valuetype"><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>
			<xsl:variable name="valuetext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>
			<xsl:variable name="valueentity"><xsl:call-template name="QualifiedPrefix"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>
			<xsl:choose>
				<xsl:when test="($valuetype = 'SYS') and ($valuetext='userid')"><xsl:value-of select="('mSecurityToken')"/></xsl:when>
				<xsl:when test="($valuetype = 'ATTR')"><xsl:value-of select="$valuetext"/></xsl:when>
				<xsl:when test="($valuetype = 'CONST')"><xsl:value-of select="$valuetext"/></xsl:when>
			</xsl:choose>

			<!--comma between parameters-->
			<xsl:if test="position() != last()">
				<xsl:value-of select="(', ')"/>
			</xsl:if>
		</xsl:for-each>
		<xsl:variable name="blankrow">
			<xsl:choose>
				<xsl:when test="@blankrow='false'">False</xsl:when>
				<xsl:otherwise>True</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:value-of select="concat(').XML(&quot;', $appprefix, ../@name, 's&quot;, ', ../@name, ', ', $blankrow, ')', $cr)"/>
		
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTATTRIBUTE" mode="enumerate">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="ind2" select="concat($ind1, $tab1)"/>

		<xsl:value-of select="concat($ind1, 'If IsNumeric(', @name, ') Then', $cr)"/>
		<xsl:value-of select="concat($ind2, 'sChildren = sChildren + EnumItems(', @id)"/>

		<xsl:if test="@blankrow='false'">
			<xsl:value-of select="concat(').XML(&quot;', $appprefix, @name, 's&quot;, ', @name, ', 0)', $cr)"/>
		</xsl:if>
		<xsl:if test="not(@blankrow='false')">
			<xsl:value-of select="concat(').XML(&quot;', $appprefix, @name, 's&quot;, ', @name, ')', $cr)"/>
		</xsl:if>
		
		<xsl:value-of select="concat($ind1, 'Else', $cr)"/>
		<xsl:value-of select="concat($ind2, 'sChildren = sChildren + EnumItems (', @id)"/>

		<xsl:if test="@blankrow='false'">
			<xsl:value-of select="concat(').XML(&quot;', $appprefix, @name, 's&quot;, , 0)', $cr)"/>
		</xsl:if>
		<xsl:if test="not(@blankrow='false')">
			<xsl:value-of select="concat(').XML(&quot;', $appprefix, @name, 's&quot;)', $cr)"/>
		</xsl:if>

		<xsl:value-of select="concat($ind1, 'End If', $cr)"/>
	</xsl:template>



	<!--==================================================================-->
	<!-- TEMPLATE: VB ADO TYPE -->
	<!-- returns the ADO type declaration for a stored procedure call -->
	<!-- {adVarWChar} -->
	<!--==================================================================-->
	<xsl:template name="VBADOType">
		<xsl:param name="datatype"/>

		<xsl:choose>
			<xsl:when test="($datatype='char')">adWChar</xsl:when>
			<xsl:when test="($datatype='text')">adVarWChar</xsl:when>
      <xsl:when test="($datatype='big number')">adBigInt</xsl:when>
      <xsl:when test="($datatype='number')">adInteger</xsl:when>
			<xsl:when test="($datatype='small number')">adSmallInt</xsl:when>
			<xsl:when test="($datatype='tiny number')">adUnsignedTinyInt</xsl:when>
			<xsl:when test="($datatype='decimal')">adNumeric</xsl:when>
			<xsl:when test="($datatype='date')">adDate</xsl:when>
			<xsl:when test="($datatype='time')">adSmallInt</xsl:when>
			<xsl:when test="($datatype='currency')">adCurrency</xsl:when>
			<xsl:when test="($datatype='yesno')">adSmallInt</xsl:when>
			<xsl:when test="($datatype='password')">adVarWChar</xsl:when>
		</xsl:choose>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: VB ADO GET PARAMETER -->
	<!-- returns the code to fetch the value of an ADO return parameter -->
	<!-- {oCmd.Parameters.Item("@CustomerID").Value} -->
	<!--==================================================================-->
	<xsl:template name="VBADOGetParam">
		<xsl:param name="name"/>
		<xsl:param name="type"/>
		<xsl:param name="assignto"/>
		<xsl:param name="indent"/>

		<xsl:variable name="fld">
			<xsl:choose>
				<xsl:when test="($name='Return')"><xsl:value-of select="concat('oCmd.Parameters.Item(&quot;', $name, '&quot;).Value')"/></xsl:when>
				<xsl:otherwise><xsl:value-of select="concat('oCmd.Parameters.Item(&quot;@', $name, '&quot;).Value')"/></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template>
		<xsl:value-of select="concat($assignto, ' = ')"/>
		<xsl:call-template name="VBFieldFetch">
			<xsl:with-param name="name" select="$fld"/>
			<xsl:with-param name="type" select="$type"/>
			<xsl:with-param name="field" select="concat('.', $name)"/>
		</xsl:call-template>
		<xsl:value-of select="$cr"/>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: VB ADO SET PARAMETER -->
	<!-- returns the code to set an ADO parameter -->
	<!-- {.Parameters.Append .CreateParameter(@CustID, adInteger, adParamInput, vbNull, CLng(brRec.CustID))} -->
	<!--==================================================================-->
	<xsl:template name="VBADOSetParam">
		<xsl:param name="name"/>
		<xsl:param name="type"/>
		<xsl:param name="length"/>
		<xsl:param name="direction">input</xsl:param>
		<xsl:param name="value"/>
		<xsl:param name="indent"/>
		<xsl:param name="precision"/>
		<xsl:param name="noquote" select="false()"/>

		<xsl:variable name="fld">
			<xsl:choose>
				<xsl:when test="($name = 'Return')"><xsl:value-of select="concat('&quot;',$name,'&quot;')"/></xsl:when>
				<xsl:when test="not($noquote)"><xsl:value-of select="concat('&quot;@',$name,'&quot;')"/></xsl:when>
				<xsl:otherwise><xsl:value-of select="$name"/></xsl:otherwise>			
			</xsl:choose>
		</xsl:variable>
		
		<xsl:variable name="createstmt">
			<xsl:value-of select="concat('.CreateParameter(', $fld, ', ')"/>
			<xsl:call-template name="VBADOType">
				<xsl:with-param name="datatype" select="$type"/>
			</xsl:call-template>
			<xsl:text>, </xsl:text>
			<xsl:choose>
				<xsl:when test="($direction='inputoutput')">adParamOutput</xsl:when>
				<xsl:when test="($direction='output')">adParamOutput</xsl:when>
				<xsl:when test="($direction='return')">adParamReturnValue</xsl:when>
				<xsl:otherwise>adParamInput</xsl:otherwise>
			</xsl:choose>
			<xsl:text>, </xsl:text>
			<xsl:choose>
				<xsl:when test="($length != '')"><xsl:value-of select="$length"/></xsl:when>
				<xsl:otherwise>vbNull</xsl:otherwise>
			</xsl:choose>
			<xsl:text>, </xsl:text>
			<xsl:choose>
				<xsl:when test="$direction='input' or $direction='inputoutput'">
					<xsl:choose>
						<xsl:when test="($type='char')"><xsl:value-of select="$value"/></xsl:when>
						<xsl:when test="($type='text')"><xsl:value-of select="$value"/></xsl:when>
						<xsl:when test="($type='big number')"><xsl:value-of select="concat('CStr(', $value, ')')"/></xsl:when>
						<xsl:when test="($type='number')"><xsl:value-of select="concat('CLng(', $value, ')')"/></xsl:when>
						<xsl:when test="($type='small number')"><xsl:value-of select="concat('CInt(', $value, ')')"/></xsl:when>
						<xsl:when test="($type='tiny number')"><xsl:value-of select="concat('CByte(', $value, ')')"/></xsl:when>
						<xsl:when test="($type='decimal')"><xsl:value-of select="concat('CDbl(', $value, ')')"/></xsl:when>
						<xsl:when test="($type='date')"><xsl:value-of select="concat('CDate(', $value, ')')"/></xsl:when>
						<xsl:when test="($type='time')"><xsl:value-of select="concat('CInt(', $value, ')')"/></xsl:when>
						<xsl:when test="($type='currency')"><xsl:value-of select="concat('CCur(', $value, ')')"/></xsl:when>
						<xsl:when test="($type='yesno')"><xsl:value-of select="concat('CInt(', $value, ')')"/></xsl:when>
						<xsl:when test="($type='password')"><xsl:value-of select="$value"/></xsl:when>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>vbNull</xsl:otherwise>
			</xsl:choose>
			<xsl:text>)</xsl:text>
		</xsl:variable>
		
		<!-- if its a decimal field, the precision and scale must be set -->
		<xsl:choose>
			<xsl:when test="($type='decimal')">
				<xsl:variable name="tmpname">
					<xsl:value-of select="concat('tmpParam', $name)"/>
				</xsl:variable>
				
				<xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template>
				<xsl:value-of select="concat('Dim ', $tmpname, ' As ADODB.Parameter', $cr)"/>
				<xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template>
				<xsl:value-of select="concat('Set ', $tmpname, ' = ', $createstmt, $cr)"/>
				<xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template>
				<xsl:value-of select="concat($tmpname, '.Precision = ')"/>
				<xsl:choose>
					<xsl:when test="not($length)">
						<xsl:text>8</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$length"/>
					</xsl:otherwise>
				</xsl:choose>
				
				<xsl:value-of select="$cr"/>
				<xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template>
				<xsl:value-of select="concat($tmpname, '.NumericScale = ')"/>
				<xsl:choose>
					<xsl:when test="not($precision)">
						<xsl:text>2</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$precision"/>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:value-of select="$cr"/>
				<xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template>
				<xsl:value-of select="concat('.Parameters.Append ', $tmpname)"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template>
				<xsl:value-of select="concat('.Parameters.Append ', $createstmt)"/>
			</xsl:otherwise>
		</xsl:choose>
		
		
		
		<xsl:value-of select="$cr"/>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: VB CHILD COLLECTION -->
	<!-- outputs the Property Get procedure for a child object -->
	<!-- {Public Property Get Parts() As xyzPartUser.CParts...End Property} -->
	<!--==================================================================-->
	<xsl:template name="VBChildCollection">
		<xsl:param name="name"/>

		<xsl:variable name="childobj" select = "concat($appprefix, $name, 'User.C', $name, 's')"/>

		<xsl:call-template name="VBMethodStart">
			<xsl:with-param name="type">Property Get</xsl:with-param>
			<xsl:with-param name="name" select = "concat($name, 's')"/>
			<xsl:with-param name="noparams" select="true()"/>
		</xsl:call-template>
		<xsl:call-template name="VBDataType">
			<xsl:with-param name="datatype" select = "$childobj"/>
		</xsl:call-template>
		<xsl:value-of select="$cr"/>
		<xsl:call-template name="VBFunctionBox">
			<xsl:with-param name="name" select = "concat($name, '_Get')"/>
			<xsl:with-param name="desc">Returns a reference to the child collection.</xsl:with-param>
			<xsl:with-param name="ismts" select="false()"/>
			<xsl:with-param name="isado" select="false()"/>
		</xsl:call-template>
		<xsl:call-template name="VBVariable">
			<xsl:with-param name="indent">1</xsl:with-param>
			<xsl:with-param name="scope">Dim</xsl:with-param>
			<xsl:with-param name="name">oItems</xsl:with-param>
			<xsl:with-param name="type" select="$childobj"/>
		</xsl:call-template>
		<xsl:call-template name="VBStartErrorHandler"/>

		<xsl:value-of select="concat($tab1, 'Set oItems = New ', $childobj, $cr)"/>
		<xsl:value-of select="concat($tab1, 'With oItems', $cr)"/>
		<xsl:value-of select="concat($tab2, '.Init mDataRec.', /Data/WTENTITY/WTATTRIBUTE[@identity]/@name, ', mSecurityToken', $cr)"/>
		<xsl:value-of select="concat($tab1, 'End With', $cr)"/>
		<xsl:value-of select="$cr"/>
		<xsl:call-template name="VBComment">
			<xsl:with-param name="value">return the reference</xsl:with-param>
			<xsl:with-param name="indent">1</xsl:with-param>
		</xsl:call-template>
		<xsl:value-of select="concat($tab1, 'Set ', $name, 's = oItems', $cr)"/>
		<xsl:value-of select="concat($tab1, 'Set oItems = Nothing', $cr)"/>
		<xsl:value-of select="$cr"/>

		<xsl:call-template name="VBMethodEnd">
			<xsl:with-param name="type">Property Get</xsl:with-param>
			<xsl:with-param name="isado" select="false()"/>
			<xsl:with-param name="ismts" select="false()"/>
		</xsl:call-template>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: VB COMMENT -->
	<!-- outputs a comment line -->
	<!-- {- - - - - this is a comment} -->
	<!--==================================================================-->
	<xsl:template name="VBComment">
		<xsl:param name="value"/>
		<xsl:param name="indent"/>
	
		<xsl:variable name="dashes"><xsl:text>'-----</xsl:text></xsl:variable>
		<xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template>
		<xsl:value-of select="concat($dashes, $value, $cr)"/>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: VB CONSTANT -->
	<!-- outputs a constant variable declaration -->
	<!-- {Private Const cMyConst = 34} -->
	<!--==================================================================-->
	<xsl:template name="VBConstant">
		<xsl:param name="scope">Private</xsl:param>
		<xsl:param name="name"/>
		<xsl:param name="type"/>
		<xsl:param name="value"/>

		<xsl:value-of select="concat($scope, ' Const c', $name)"/>
		<xsl:call-template name="VBDataType">
			<xsl:with-param name="datatype" select="$type"/>
		</xsl:call-template>
		<xsl:text> = </xsl:text>
		<xsl:call-template name="VBValue">
			<xsl:with-param name="type" select="$type"/>
			<xsl:with-param name="value" select="$value"/>
		</xsl:call-template>
		<xsl:value-of select="$cr"/>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: VB DATA TYPE -->
	<!-- returns the data type declaration for a variable -->
	<!-- {As String} -->
	<!--==================================================================-->
	<xsl:template name="VBDataType">
		<xsl:param name="datatype"/>

		<xsl:text> As </xsl:text>
		<xsl:choose>
			<xsl:when test="($datatype='busnitem')"><xsl:value-of select="concat($appprefix, /Data/@project, 'Busn.C', $entityname)"/></xsl:when>
			<xsl:when test="($datatype='busnrecord')">
				<xsl:if test="/Data/@userbusn">
					<xsl:value-of select="concat('C', $entityname, 'B.t', $entityname, 'Type')"/>
				</xsl:if>
				<xsl:if test="not(/Data/@userbusn)">
					<xsl:value-of select="concat($appprefix, /Data/@project, 'Busn.t', $entityname, 'Type')"/>
				</xsl:if>
			</xsl:when>
			<xsl:when test="($datatype='useritem')"><xsl:value-of select="concat($appprefix, /Data/@project, 'User.C', $entityname)"/></xsl:when>
			<xsl:when test="($datatype='record')"><xsl:value-of select="concat('t', $entityname, 'Type')"/></xsl:when>
			<xsl:when test="($datatype='records')"><xsl:value-of select="concat('t', $entityname, 'Type()')"/></xsl:when>
			<xsl:when test="($datatype='char')"><xsl:text>String</xsl:text></xsl:when>
			<xsl:when test="($datatype='text')"><xsl:text>String</xsl:text></xsl:when>
			<xsl:when test="($datatype='big number')"><xsl:text>String</xsl:text></xsl:when>
			<xsl:when test="($datatype='number')"><xsl:text>Long</xsl:text></xsl:when>
			<xsl:when test="($datatype='small number')"><xsl:text>Integer</xsl:text></xsl:when>
			<xsl:when test="($datatype='tiny number')"><xsl:text>Byte</xsl:text></xsl:when>
			<xsl:when test="($datatype='decimal')"><xsl:text>Double</xsl:text></xsl:when>
			<xsl:when test="($datatype='date')"><xsl:text>Date</xsl:text></xsl:when>
			<xsl:when test="($datatype='time')"><xsl:text>Integer</xsl:text></xsl:when>
			<xsl:when test="($datatype='currency')"><xsl:text>Currency</xsl:text></xsl:when>
			<xsl:when test="($datatype='yesno')"><xsl:text>Integer</xsl:text></xsl:when>
			<xsl:when test="($datatype='password')"><xsl:text>String</xsl:text></xsl:when>
			<xsl:otherwise><xsl:value-of select="$datatype"/></xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: VB Function Return -->
	<!-- returns the return value for a function -->
	<!--==================================================================-->
	<xsl:template name="VBFunctionReturn">
		<xsl:param name="name"/>
		<xsl:param name="type"/>

		<xsl:variable name="nametype">
			<xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="$name"/></xsl:call-template>	
		</xsl:variable>
		<xsl:variable name="nametext">
			<xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="$name"/></xsl:call-template>
		</xsl:variable>
		<xsl:variable name="datatype">
			<xsl:choose>
				<xsl:when test="($nametype = 'ATTR')"><xsl:value-of select="$name"/><xsl:value-of select="$nametext"/><xsl:value-of select="/Data/WTENTITY/WTATTRIBUTE[$name=$nametext]/@type"/></xsl:when>
				<xsl:when test="($nametype = 'CONST')"><xsl:value-of select="$type"/></xsl:when>
				<xsl:otherwise><xsl:value-of select="$type"/></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:call-template name="VBDataType">
			<xsl:with-param name="datatype" select="$datatype"/>
		</xsl:call-template>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: VB ENUM -->
	<!-- returns the variable assignment for an enumerated constant -->
	<!-- {xyzStatusType = cxyzStatusType} -->
	<!--==================================================================-->
	<xsl:template name="VBEnum">
		<xsl:param name="prefix"/>
		<xsl:param name="name"/>

		<xsl:value-of select="concat($tab1, $prefix, $name, ' = c', $prefix, $name)"/>
		<xsl:value-of select="$cr"/>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: VB FIELD EDIT -->
	<!-- outputs the code to edit an input parameter -->
	<!-- {bvCustID = moUtil.EditLong(bvCustID, "CustID", True, 1, 1000)} -->
	<!--==================================================================-->
	<xsl:template name="VBFieldEdit">
		<xsl:param name="name"/>
		<xsl:param name="assignto"/>
		<xsl:param name="label"/>
		<xsl:param name="type"/>
		<xsl:param name="default"/>
		<xsl:param name="minval"/>
		<xsl:param name="maxval"/>
		<xsl:param name="required"/>
		<xsl:param name="indent"/>
				
		<xsl:variable name="reqd">
			<xsl:choose>
				<xsl:when test="$required!=''">True</xsl:when>
				<xsl:otherwise>False</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="func">
			<xsl:choose>
				<xsl:when test="($type='char')">EditString</xsl:when>
				<xsl:when test="($type='text')">EditString</xsl:when>
        <xsl:when test="($type='big number')">EditString</xsl:when>
        <xsl:when test="($type='number')">EditLong</xsl:when>
        <xsl:when test="($type='small number')">EditInteger</xsl:when>
        <xsl:when test="($type='tiny number')">EditByte</xsl:when>
				<xsl:when test="($type='decimal')">EditDouble</xsl:when>
				<xsl:when test="($type='date')">EditDate</xsl:when>
				<xsl:when test="($type='time')">EditInteger</xsl:when>
				<xsl:when test="($type='currency')">EditCurrency</xsl:when>
				<xsl:when test="($type='yesno')">EditInteger</xsl:when>
				<xsl:when test="($type='password')">EditString</xsl:when>
			</xsl:choose>
		</xsl:variable>

    <xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template>
		<xsl:value-of select="concat($assignto, ' = moUtil.', $func, '(', $name, ', &quot;', $label, '&quot;')"/>
		<xsl:if test="($func != 'EditBoolean')">
			<xsl:value-of select="concat(', ', $reqd)"/>
			<xsl:if test="(($default != '') or ($minval != '') or ($maxval != ''))">
				<xsl:value-of select="concat(', ', $default)"/>
				<xsl:if test="(($minval != '') or ($maxval != ''))">
					<xsl:value-of select="concat(', ', $minval)"/>
					<xsl:if test="($maxval != '')">
						<xsl:value-of select="concat(', ', $maxval)"/>
					</xsl:if>
				</xsl:if>
			</xsl:if>
		</xsl:if>
		<xsl:value-of select="concat(') ', $cr)"/>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: VB FIELD FETCH -->
	<!-- outputs the code to fetch a variable -->
	<!-- {moUtil.FetchLong(bvCustID)} -->
	<!--==================================================================-->
	<xsl:template name="VBFieldFetch">
		<xsl:param name="name"/>
		<xsl:param name="type"/>
		<xsl:param name="field"/>
				
		<xsl:variable name="func">
			<xsl:choose>
				<xsl:when test="($type='char')">FetchString</xsl:when>
				<xsl:when test="($type='text')">FetchString</xsl:when>
        <xsl:when test="($type='big number')">FetchString</xsl:when>
        <xsl:when test="($type='number')">FetchLong</xsl:when>
				<xsl:when test="($type='small number')">FetchInteger</xsl:when>
				<xsl:when test="($type='tiny number')">FetchByte</xsl:when>
				<xsl:when test="($type='decimal')">FetchDouble</xsl:when>
				<xsl:when test="($type='date')">FetchDate</xsl:when>
				<xsl:when test="($type='time')">FetchInteger</xsl:when>
				<xsl:when test="($type='currency')">FetchCurrency</xsl:when>
				<xsl:when test="($type='yesno')">FetchInteger</xsl:when>
				<xsl:when test="($type='password')">FetchString</xsl:when>
			</xsl:choose>
		</xsl:variable>

		<xsl:value-of select="concat('moUtil.', $func, '(', $name, ')')"/>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: VB FUNCTION BOX -->
	<!-- outputs the code for the procedure function box and standard variable declarations -->
	<!-- {Dim oCmd As New ADODB.Command} -->
	<!-- {Dim oCtx As ObjectContext} -->
	<!-- {Dim oCmd As New ADODB.Command} -->
	<!-- {Dim oRecs As ADODB.Recordset} -->
	<!-- {Dim vRecs() As ...} -->
	<!-- {Dim Dim vRec As ...} -->
	<!--==================================================================-->
	<xsl:template name="VBFunctionBox">
		<xsl:param name="name"/>
		<xsl:param name="ismts" select="true()"/>
		<xsl:param name="isrecordset" select="false()"/>
		<xsl:param name="isado" select="true()"/>
		<xsl:param name="desc"/>

		<xsl:variable name="dashes"><xsl:text>'------------------------------------------------------------------------------------------------------------------------&#010;</xsl:text></xsl:variable>
		<xsl:variable name="cmnt" select="$apos"/>

		<xsl:value-of select="concat($tab1, $dashes)"/>
		<xsl:value-of select="concat($tab1, $cmnt, $tab1, $desc, $cr)"/>
		<xsl:value-of select="concat($tab1, $dashes)"/>
		<xsl:value-of select="concat($tab1, 'Dim ErrNo As Long, ErrSrc As String, ErrDesc As String', $cr)"/>
		<xsl:value-of select="concat($tab1, 'Const cProcName As String = &quot;', $name, '&quot;', $cr)"/>
		<xsl:value-of select="concat($tab1, $dashes)"/>
		<xsl:if test="($isado)"><xsl:value-of select="concat($tab1, 'Dim oCmd As New ADODB.Command', $cr)"/></xsl:if>
		<xsl:if test="($ismts)"><xsl:value-of select="concat($tab1, 'Dim oCtx As ObjectContext', $cr)"/></xsl:if>
		<xsl:if test="($isrecordset)">
			<xsl:value-of select="concat($tab1, 'Dim oRecs As ADODB.Recordset', $cr)"/>
			<xsl:value-of select="concat($tab1, 'Dim vRecs()')"/>
			<xsl:call-template name="VBDataType">
				<xsl:with-param name="datatype">record</xsl:with-param>
			</xsl:call-template>
			<xsl:value-of select="$cr"/>
			<xsl:value-of select="concat($tab1, 'Dim vRec')"/>
			<xsl:call-template name="VBDataType">
				<xsl:with-param name="datatype">record</xsl:with-param>
			</xsl:call-template>
			<xsl:value-of select="$cr"/>
			<xsl:value-of select="concat($tab1, 'Dim idxRec')"/>
			<xsl:call-template name="VBDataType">
				<xsl:with-param name="datatype">small number</xsl:with-param>
			</xsl:call-template>
			<xsl:value-of select="$cr"/>
		</xsl:if>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: VB HEADER BAS MODULE -->
	<!-- outputs the code for the beginning of a BAS module file-->
	<!--==================================================================-->
	<xsl:template name="VBHeaderBasModule">
		<xsl:param name="name"/>

		<xsl:value-of select="concat('Attribute VB_Name = &quot;', $name, 'Mod&quot;', $cr)"/>
		<xsl:value-of select="concat('Option Explicit', $cr)"/>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: VB HEADER CLASS MODULE -->
	<!-- outputs the code for the beginning of a CLASS module file-->
	<!--==================================================================-->
	<xsl:template name="VBHeaderClassModule">
		<xsl:param name="name"/>
		<xsl:param name="mtsmode"/>
		<xsl:param name="createable"/>
		<xsl:param name="exposed"/>

		<xsl:value-of select="concat('VERSION 1.0 CLASS', $cr)"/>
		<xsl:value-of select="concat('BEGIN', $cr)"/>
		<xsl:value-of select="concat($tab1, 'MultiUse = -1', $cr)"/>
		<xsl:value-of select="concat($tab1, 'Persistable = 0', $cr)"/>
		<xsl:value-of select="concat($tab1, 'DataBindingBehavior = 0', $cr)"/>
		<xsl:value-of select="concat($tab1, 'DataSourceBehavior = 0', $cr)"/>
		<xsl:value-of select="concat($tab1, 'MTSTransactionMode = ', $mtsmode, $cr)"/>
		<xsl:value-of select="concat($tab0, 'END', $cr)"/>
		<xsl:value-of select="concat('Attribute VB_Name = &quot;C', $name, '&quot;', $cr)"/>
		<xsl:value-of select="concat('Attribute VB_GlobalNameSpace = False', $cr)"/>
		<xsl:if test="$createable">
			<xsl:value-of select="concat('Attribute VB_Creatable = True', $cr)"/>
		</xsl:if>
		<xsl:value-of select="concat('Attribute VB_PredeclaredId = False', $cr)"/>
		<xsl:if test="$exposed">
			<xsl:value-of select="concat('Attribute VB_Exposed = True', $cr)"/>
		</xsl:if>
		<xsl:value-of select="concat('Option Explicit', $cr)"/>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: VB ITEM INIT -->
	<!-- outputs the code for the call to the Init procedure for an item class-->
	<!-- {.Init mCustomerID, mLocationID, mSecurityToken} -->
	<!--==================================================================-->
	<xsl:template name="VBItemInit">
		<xsl:param name="objname"/>
		<xsl:param name="indent"/>

		<xsl:if test="/Data/WTENTITY/WTPROCEDURES/WTPROCEDURE[(@name='Init')]">
			<xsl:call-template name="Indent">
				<xsl:with-param name="level" select="$indent"/>
			</xsl:call-template>
			<xsl:if test="($objname != '')"><xsl:value-of select="$objname"/></xsl:if>
			<xsl:text>.Init </xsl:text>
			<xsl:for-each select="($parentfields)">
				<xsl:variable name="attname" select="@name"/>
				<xsl:for-each select = "/Data/WTENTITY/WTATTRIBUTE[@name=$attname]">
					<xsl:value-of select="concat('m', @name, ', ')"/>
				</xsl:for-each>
			</xsl:for-each>
			<xsl:value-of select="concat('mSecurityToken', $cr)"/>
		</xsl:if>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: VB METHOD START -->
	<!-- outputs the code for the signature line of a procedure-->
	<!-- {Public Property Get CustID( _ } -->
	<!--==================================================================-->
	<xsl:template name="VBMethodStart">
		<xsl:param name="scope">Public</xsl:param>
		<xsl:param name="name"/>
		<xsl:param name="type"/>
		<xsl:param name="noparams" select="false()"/>
	
		<xsl:value-of select="concat( $scope, ' ', $type, ' ', $name, '(' )"/>
		<xsl:choose>
			<xsl:when test="($noparams)">
				<xsl:text>)</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="concat(' _ ', $cr)"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: VB METHOD END -->
	<!-- outputs the common code at the end of each procedure-->
	<!--==================================================================-->
	<xsl:template name="VBMethodEnd">
		<xsl:param name="type"/>
		<xsl:param name="isado" select="true()"/>
		<xsl:param name="ismts" select="true()"/>
		<xsl:param name="isrecordset" select="false()"/>

		<xsl:if test="(($ismts) or ($isado) or ($isrecordset))">
			<xsl:call-template name="VBComment">
				<xsl:with-param name="indent">1</xsl:with-param>
				<xsl:with-param name="value">clean up</xsl:with-param>
			</xsl:call-template>
			<xsl:if test="($ismts)">
				<xsl:value-of select="concat($tab1, 'If moSys.IsMTS Then oCtx.SetComplete', $cr)"/>
				<xsl:value-of select="concat($tab1, 'Set oCtx = Nothing', $cr)"/>
			</xsl:if>
			<xsl:if test="($isrecordset)"><xsl:value-of select="concat($tab1, 'Set oRecs = Nothing', $cr)"/></xsl:if>
			<xsl:if test="($isado)"><xsl:value-of select="concat($tab1, 'Set oCmd = Nothing', $cr)"/></xsl:if>
			<xsl:value-of select="$cr"/>
		</xsl:if>
		<xsl:choose>
			<xsl:when test="($type='Sub')"><xsl:value-of select="concat($tab1, 'Exit Sub', $cr)"/></xsl:when>
			<xsl:when test="($type='Function')"><xsl:value-of select="concat($tab1, 'Exit Function', $cr)"/></xsl:when>
			<xsl:when test="($type='Property Get')"><xsl:value-of select="concat($tab1, 'Exit Property', $cr)"/></xsl:when>
			<xsl:when test="($type='Property Let')"><xsl:value-of select="concat($tab1, 'Exit Property', $cr)"/></xsl:when>
		</xsl:choose>
		<xsl:value-of select="$cr"/>
		<xsl:value-of select="concat('ErrorHandler:', $cr)"/>
		<xsl:value-of select="concat($tab1, 'CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName')"/>
		<xsl:if test="($isado)"><xsl:text>, , oCmd</xsl:text></xsl:if>
		<xsl:value-of select="$cr"/>
		<xsl:value-of select="concat($tab1, 'If Err.Number = 0 Then Resume Next', $cr)"/>
		<xsl:if test="($ismts)">
			<xsl:value-of select="concat($tab1, 'If moSys.IsMTS Then oCtx.SetAbort', $cr)"/>
			<xsl:value-of select="concat($tab1, 'Set oCtx = Nothing', $cr)"/>
		</xsl:if>
		<xsl:if test="($isrecordset)"><xsl:value-of select="concat($tab1, 'Set oRecs = Nothing', $cr)"/></xsl:if>
		<xsl:if test="($isado)"><xsl:value-of select="concat($tab1, 'Set oCmd = Nothing', $cr)"/></xsl:if>
		<xsl:value-of select="concat($tab1, 'Err.Raise ErrNo, ErrSrc, ErrDesc', $cr)"/>
		<xsl:choose>
			<xsl:when test="($type='Sub')"><xsl:value-of select="concat('End Sub', $cr)"/></xsl:when>
			<xsl:when test="($type='Function')"><xsl:value-of select="concat('End Function', $cr)"/></xsl:when>
			<xsl:when test="($type='Property Get')"><xsl:value-of select="concat('End Property', $cr)"/></xsl:when>
			<xsl:when test="($type='Property Let')"><xsl:value-of select="concat('End Property', $cr)"/></xsl:when>
		</xsl:choose>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: VB MTS CONTEXT -->
	<!-- outputs the code to set the MTS object context-->
	<!-- {If moSys.IsMTS Then Set oCtx = GetObjectContext()} -->
	<!--==================================================================-->
	<xsl:template name="VBMTSContext">
		<xsl:call-template name="VBComment">
			<xsl:with-param name="indent">1</xsl:with-param>
			<xsl:with-param name="value">get the object context for this transaction</xsl:with-param>
		</xsl:call-template>
		<xsl:value-of select="concat($tab1, 'If moSys.IsMTS Then Set oCtx = GetObjectContext()', $cr)"/>
		<xsl:value-of select="$cr"/>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: VB MTS CONTEXT -->
	<!-- outputs the declaration of an object variable-->
	<!-- {Private moCustomer As xyzCustomerUser.CCustomer} -->
	<!--==================================================================-->
	<xsl:template name="VBObject">
		<xsl:param name="scope">Private</xsl:param>
		<xsl:param name="name"/>
		<xsl:param name="type"/>

		<xsl:value-of select="concat($scope, ' ', $name, ' As ', $type, $cr)"/>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: VB PARENT DECLARE -->
	<!-- outputs the declaration of each parent variable-->
	<!-- {Public mCustomerID As Long} -->
	<!-- {Public mLocationID As Long} -->
	<!--==================================================================-->
	<xsl:template name="VBParentDeclare">
		<xsl:for-each select="$parentfields">
			<xsl:variable name="attname" select="@name"/>
			<xsl:for-each select = "/Data/WTENTITY/WTATTRIBUTE[@name=$attname]">
				<xsl:call-template name="VBVariable">
					<xsl:with-param name="name" select="concat('m', @name)"/>
					<xsl:with-param name="type" select="@type"/>
				</xsl:call-template>
			</xsl:for-each>
		</xsl:for-each>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: VB PARENT CALL -->
	<!-- outputs the parameters for the parent variable of an item-->
	<!-- {mCustomerID, mLocationID } -->
	<!--==================================================================-->
	<xsl:template name="VBParentCall">
		<xsl:for-each select="$parentfields">
			<xsl:variable name="attname" select="@name"/>
			<xsl:for-each select = "/Data/WTENTITY/WTATTRIBUTE[@name=$attname]">
				<xsl:value-of select="concat('m', @name, ', ')"/>
			</xsl:for-each>
		</xsl:for-each>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: VB PARENT SET COLL-->
	<!-- outputs the code to set the parent variable in a collection class from the procedure parameters -->
	<!-- {If bvCustomerID <> 0 Then mCustomerID = bvCustomerID } -->
	<!--==================================================================-->
	<xsl:template name="VBParentSetColl">

		<xsl:if test="($ischild)">
			<xsl:call-template name="VBComment">
				<xsl:with-param name="value">set the parent ID</xsl:with-param>
				<xsl:with-param name="indent">1</xsl:with-param>
			</xsl:call-template>
			<xsl:for-each select="($parentfields)">
				<xsl:variable name="attname" select="@name"/>
				<xsl:for-each select = "/Data/WTENTITY/WTATTRIBUTE[@name=$attname]">
					<xsl:value-of select="concat($tab1, 'If bv', $attname, ' &lt;&gt; 0 Then m', $attname, ' = bv', $attname, $cr)"/>
				</xsl:for-each>
			</xsl:for-each>
			<xsl:value-of select="$cr"/>
		</xsl:if>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: VB PARENT SET ITEM-->
	<!-- outputs the code to set the parent variable in an item class from the procedure parameters -->
	<!-- {If bvCustomerID <> 0 Then mDataRec.CustomerID = bvCustomerID } -->
	<!--==================================================================-->
	<xsl:template name="VBParentSetItem">
		<xsl:if test="($ischild)">
			<xsl:call-template name="VBComment">
				<xsl:with-param name="value">set the parent ID</xsl:with-param>
				<xsl:with-param name="indent">1</xsl:with-param>
			</xsl:call-template>
			<xsl:for-each select="($parentfields)">
				<xsl:variable name="attname" select="@name"/>
				<xsl:for-each select = "/Data/WTENTITY/WTATTRIBUTE[@name=$attname]">
					<xsl:value-of select="concat($tab1, 'If bv', $attname, ' &lt;&gt; 0 Then mDataRec.', $attname, ' = bv', $attname, $cr)"/>
				</xsl:for-each>
			</xsl:for-each>
			<xsl:value-of select="$cr"/>
		</xsl:if>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: VB PARAM PARENT-->
	<!-- outputs the code to for each parent parameter in the signature line of a procedure -->
	<!-- {Optional ByVal bvCustomerID As Long = 0, _ } -->
	<!--==================================================================-->
	<xsl:template name="VBParamParent">
		<xsl:param name="continue" select="true()"/>

		<xsl:for-each select="($parentfields)">
			<xsl:variable name="moreitems">
				<xsl:choose>
					<xsl:when test="(position() = last())"><xsl:value-of select="$continue"/></xsl:when>
					<xsl:otherwise><xsl:value-of select="true()"/></xsl:otherwise>
				</xsl:choose>
			</xsl:variable>

			<xsl:variable name="attname" select="@name"/>
			<xsl:for-each select = "/Data/WTENTITY/WTATTRIBUTE[@name=$attname]">
				<xsl:call-template name="VBParam">
					<xsl:with-param name="name" select="@name"/>
					<xsl:with-param name="type" select="@type"/>
					<xsl:with-param name="optional" select="true()"/>
					<xsl:with-param name="default">0</xsl:with-param>
					<xsl:with-param name="continue" select="($moreitems='true')"/>
				</xsl:call-template>
			</xsl:for-each>
		</xsl:for-each>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: VB PARAM -->
	<!-- outputs the code to for a parameter in the signature line of a procedure -->
	<!-- {ByVal bvFindType As Long = 603, _ } -->
	<!--==================================================================-->
	<xsl:template name="VBParam">
		<xsl:param name="parameter"/>
		<xsl:param name="name"/>
		<xsl:param name="type"/>
		<xsl:param name="optional" select="false()"/>
		<xsl:param name="byref" select="false()"/>
		<xsl:param name="default"/>
		<xsl:param name="continue" select="true()"/>

		<xsl:variable name="nametype">
			<xsl:choose>
				<xsl:when test="$name"><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="$name"/></xsl:call-template></xsl:when>	
				<xsl:otherwise><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="@name"/></xsl:call-template></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="nametext">
			<xsl:choose>
				<xsl:when test="$name"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="$name"/></xsl:call-template></xsl:when>
				<xsl:otherwise><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@name"/></xsl:call-template></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="datatype">
			<xsl:choose>
				<xsl:when test="$type"><xsl:value-of select="$type"/></xsl:when>
				<xsl:when test="($nametype = 'ATTR')"><xsl:value-of select="/Data/WTENTITY/WTATTRIBUTE[@name=$nametext]/@type"/></xsl:when>
				<xsl:when test="($nametype = 'CONST')"><xsl:value-of select="@datatype"/></xsl:when>
				<xsl:otherwise><xsl:value-of select="@datatype"/></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		
		<xsl:choose>
			<xsl:when test="($nametype = 'SYS') and ($nametext='userid')">
				<xsl:value-of select="concat($tab1, 'Optional ByVal bvSecurityToken As Long = 0')"/>
				<xsl:if test="$continue"><xsl:value-of select="concat(', _ ', $cr)"/></xsl:if>
			</xsl:when>
			<xsl:when test="($nametype != 'SYS')">
				<xsl:value-of select="$tab1"/>
				<xsl:if test="($optional)"><xsl:text>Optional </xsl:text></xsl:if>
				<xsl:choose>
					<xsl:when test="($type = 'record')"><xsl:value-of select="concat('ByRef br', $nametext)"/></xsl:when>
					<xsl:when test="($type = 'busnrecord')"><xsl:value-of select="concat('ByRef br', $nametext)"/></xsl:when>
					<xsl:when test="($byref)"><xsl:value-of select="concat('ByRef br', $nametext)"/></xsl:when>
					<xsl:otherwise><xsl:value-of select="concat('ByVal bv', $nametext)"/></xsl:otherwise>
				</xsl:choose>
				<xsl:call-template name="VBDataType">
					<xsl:with-param name="datatype" select="$datatype"/>
				</xsl:call-template>
				<xsl:if test="($default != '')"><xsl:value-of select="concat(' = ', $default)"/></xsl:if>
				<xsl:if test="$continue"><xsl:value-of select="concat(', _ ', $cr)"/></xsl:if>
			</xsl:when>
		</xsl:choose>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: VB PROPERTY -->
	<!-- outputs the code to for the Property Get and Property Let procedures -->
	<!-- {Public Property Get CustomerID() As Long...End Property } -->
	<!-- {Public Property Let CustomerID( ByVal bvCustomerID As Long)...End Property } -->
	<!--==================================================================-->
	<xsl:template name="VBProperty">
		<xsl:param name="scope">Public</xsl:param>
		<xsl:param name="name"/>
		<xsl:param name="type"/>
		<xsl:param name="isget" select="true()"/>
		<xsl:param name="islet" select="true()"/>
		<xsl:param name="isdate" select="false()"/>
		<xsl:param name="isdatarec" select="true()"/>

		<xsl:if test="($isget)">
			<xsl:value-of select="$cr"/>
			<xsl:call-template name="VBMethodStart">
				<xsl:with-param name="scope" select = "$scope"/>
				<xsl:with-param name="type">Property Get</xsl:with-param>
				<xsl:with-param name="name" select = "$name"/>
				<xsl:with-param name="noparams" select="true()"/>
			</xsl:call-template>
			<xsl:call-template name="VBDataType">
				<xsl:with-param name="datatype" select = "$type"/>
			</xsl:call-template>
			<xsl:value-of select="$cr"/>
			<xsl:call-template name="VBFunctionBox">
				<xsl:with-param name="name" select = "concat($name, '_Get')"/>
				<xsl:with-param name="desc">Returns the value of the attribute.</xsl:with-param>
				<xsl:with-param name="ismts" select="false()"/>
				<xsl:with-param name="isado" select="false()"/>
			</xsl:call-template>

			<xsl:call-template name="VBStartErrorHandler"/>

			<xsl:if test="@embed">
	 			<xsl:value-of select="concat($tab1, 'If emb', $name, ' = &quot;&quot; Then ', $cr)"/>
			</xsl:if>

			<xsl:choose>
				<xsl:when test="($isdate) and ($isdatarec)">
					<xsl:value-of select="concat($tab1, 'If IsDate(mDataRec.', $name, ') Then ', $name, ' = mDataRec.', $name, ' Else ', $name, ' = 0', $cr)"/>
					<xsl:value-of select="concat($tab1, 'If mDataRec.', $name, ' = &quot;1/1/1900&quot; Then ', $name, ' = 0', $cr)"/>
				</xsl:when>
				<xsl:when test="($isdate) and not($isdatarec)">
					<xsl:value-of select="concat($tab1, 'If IsDate(m', $name, ') Then ', $name, ' = m', $name, ' Else ', $name, ' = 0', $cr)"/>
					<xsl:value-of select="concat($tab1, 'If m', $name, ' = &quot;1/1/1900&quot; Then ', $name, ' = 0', $cr)"/>
				</xsl:when>
				<xsl:when test="not($isdatarec)">
					<xsl:value-of select="concat($tab1, $name, ' = m', $name, $cr)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="concat($tab1, $name, ' = mDataRec.', $name, $cr)"/>
				</xsl:otherwise>
			</xsl:choose>

			<xsl:if test="@embed">
	 			<xsl:value-of select="concat($tab1, 'Else', $cr)"/>
	 			<xsl:value-of select="concat($tab2, @name, '= EmbeddedText(mDataRec.', $name, ', emb', $name, ')', $cr)"/>
	 			<xsl:value-of select="concat($tab1, 'End If', $cr)"/>
			</xsl:if>

			<xsl:value-of select="$cr"/>

			<xsl:call-template name="VBMethodEnd">
				<xsl:with-param name="type">Property Get</xsl:with-param>
				<xsl:with-param name="isado" select="false()"/>
				<xsl:with-param name="ismts" select="false()"/>
			</xsl:call-template>
		</xsl:if>

		<xsl:if test="($islet)">
			<xsl:value-of select="$cr"/>
			<xsl:call-template name="VBMethodStart">
				<xsl:with-param name="scope" select = "$scope"/>
				<xsl:with-param name="type">Property Let</xsl:with-param>
				<xsl:with-param name="name" select = "$name"/>
			</xsl:call-template>
			<xsl:call-template name="VBParam">
				<xsl:with-param name="name" select="$name"/>
				<xsl:with-param name="type" select="$type"/>
				<xsl:with-param name="continue" select="false()"/>
			</xsl:call-template>
			<xsl:text>)</xsl:text>
			<xsl:value-of select="$cr"/>
			<xsl:call-template name="VBFunctionBox">
				<xsl:with-param name="name" select = "concat($name, '_Let')"/>
				<xsl:with-param name="desc">Sets the value of the attribute.</xsl:with-param>
				<xsl:with-param name="ismts" select="false()"/>
				<xsl:with-param name="isado" select="false()"/>
			</xsl:call-template>
			<xsl:call-template name="VBStartErrorHandler"/>

			<xsl:choose>
				<xsl:when test="not($isdatarec)">
					<xsl:value-of select="concat($tab1, 'm', $name, ' = bv', $name, $cr)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="concat($tab1, 'mDataRec.', $name, ' = bv', $name, $cr)"/>
				</xsl:otherwise>
			</xsl:choose>

			<xsl:value-of select="$cr"/>
			<xsl:call-template name="VBMethodEnd">
				<xsl:with-param name="type">Property Let</xsl:with-param>
				<xsl:with-param name="isado" select="false()"/>
				<xsl:with-param name="ismts" select="false()"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: VB RECORDSET START -->
	<!-- outputs the code to navigate a recordset prior to fetching each parameter -->
	<!-- {With oRecs...Do While .EOF = False } -->
	<!--==================================================================-->
	<xsl:template name="VBRecordsetStart">
		<xsl:param name="limit"/>
		<xsl:param name="indent"/>

		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="ind2" select="concat($ind1, $tab1)"/>
		<xsl:variable name="ind3" select="concat($ind2, $tab1)"/>
		<xsl:variable name="ind4" select="concat($ind3, $tab1)"/>

		<xsl:call-template name="VBComment">
			<xsl:with-param name="indent" select="$indent"/>
			<xsl:with-param name="value">populate the record from the recordset</xsl:with-param>
		</xsl:call-template>

		<xsl:value-of select="concat($ind1, 'With oRecs', $cr)"/>
		<xsl:value-of select="concat($ind2, 'If oRecs.EOF = True Then', $cr)"/>
		<xsl:value-of select="concat($ind3, 'ReDim vRecs(0 To 0)', $cr)"/>
		<xsl:value-of select="concat($ind2, 'Else', $cr)"/>
		<xsl:value-of select="concat($ind3, '.MoveFirst', $cr)"/>
		<xsl:value-of select="concat($ind3, 'idxRec = 0', $cr)"/>
		<xsl:value-of select="concat($ind3, 'Do While .EOF = False', $cr)"/>
		<xsl:if test="($limit != '')"><xsl:value-of select="concat($ind4, 'If idxRec &lt; ', $limit, ' Then', $cr)"/></xsl:if>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: VB RECORDSET END -->
	<!-- outputs the code to navigate a recordset prior after all parameters have been fetched -->
	<!-- {idxRec = idxRec + 1...Loop...End With } -->
	<!--==================================================================-->
	<xsl:template name="VBRecordsetEnd">
		<xsl:param name="limit"/>
		<xsl:param name="indent"/>

		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="ind2" select="concat($ind1, $tab1)"/>
		<xsl:variable name="ind3" select="concat($ind2, $tab1)"/>
		<xsl:variable name="ind4" select="concat($ind3, $tab1)"/>
		<xsl:variable name="ind5">
			<xsl:choose>
				<xsl:when test="($limit != '')"><xsl:value-of select="concat($ind4, $tab1)"/></xsl:when>
				<xsl:otherwise><xsl:value-of select="$ind4"/></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:value-of select="concat($ind5, 'idxRec = idxRec + 1', $cr)"/>
		<xsl:value-of select="concat($ind5, 'ReDim Preserve vRecs(0 To idxRec)', $cr)"/>
		<xsl:value-of select="concat($ind5, 'vRecs(idxRec) = vRec', $cr)"/>
		<xsl:if test="($limit != '')"><xsl:value-of select="concat($ind4, 'End If', $cr)"/></xsl:if>
		<xsl:value-of select="concat($ind4, '.MoveNext', $cr)"/>
		<xsl:value-of select="concat($ind3, 'Loop', $cr)"/>
		<xsl:if test="($limit != '')"><xsl:value-of select="concat($ind3, '.MoveFirst', $cr)"/></xsl:if>
		<xsl:value-of select="concat($ind2, 'End If', $cr)"/>
		<xsl:value-of select="concat($ind1, 'End With', $cr)"/>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: VB RECORDSET FETCH -->
	<!-- outputs the code fetch a parameter from within a recordset -->
	<!-- { vRec.CustomerID = moUtil.FetchLong(.Fields.Item("CustomerID").Value) } -->
	<!--==================================================================-->
	<xsl:template name="VBRecordsetFetch">
		<xsl:param name="name"/>
		<xsl:param name="type"/>
		<xsl:param name="assignto"/>
		<xsl:param name="indent"/>

		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="ind2" select="concat($ind1, $tab1)"/>
		<xsl:variable name="ind3" select="concat($ind2, $tab1)"/>

		<xsl:value-of select="concat($ind3, $assignto, ' = ')"/>
		<xsl:call-template name="VBFieldFetch">
			<xsl:with-param name="name" select="concat('.Fields.Item(&quot;', $name, '&quot;).Value')"/>
			<xsl:with-param name="type" select="$type"/>
			<xsl:with-param name="field" select="concat('vRec.', $name)"/>
		</xsl:call-template>
		<xsl:value-of select="$cr"/>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: VB RUN SP -->
	<!-- outputs the code to call the RunSP function -->
	<!-- { RunSP oCmd, moSys.ConnectString, "xyz_Customer_Fetch" } -->
	<!--==================================================================-->
	<xsl:template name="VBRunSP">
		<xsl:param name="name"/>
		<xsl:param name="indent"/>

		<xsl:call-template name="VBComment">
			<xsl:with-param name="indent" select="$indent"/>
			<xsl:with-param name="value">execute the command</xsl:with-param>
		</xsl:call-template>
		<xsl:if test="WTSQL">
			<xsl:value-of select="concat($tab1, 'sSQL = ', WTSQL/@name, $cr)"/>
		</xsl:if>
		<xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template>
		<xsl:variable name="proc">
			<xsl:if test="WTSQL">sSQL</xsl:if>
			<xsl:if test="not(WTSQL)"><xsl:value-of select="concat( '&quot;', $appprefix, '_', $entityname, '_', $name, '&quot;')"/></xsl:if>
		</xsl:variable>
		
		<xsl:if test="/Data/WTPAGE/@multi-instance">
			<xsl:value-of select="concat('RunSP oCmd, moSys.ConnectString(mClient, mProject), ', $proc)"/>
		</xsl:if>
		<xsl:if test="not(/Data/WTPAGE/@multi-instance)">
			<xsl:value-of select="concat('RunSP oCmd, moSys.ConnectString(&quot;', $systemname, '&quot;, &quot;', $appprefix, '&quot;), ', $proc)"/>
		</xsl:if>
		<xsl:if test="WTSQL"><xsl:value-of select="', 0'"/></xsl:if>
		<xsl:value-of select="$cr"/>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: VB RUN SP RECORDSET -->
	<!-- outputs the code to call the RunSPRecordset function -->
	<!-- { Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString, "xyz_Customer_List") } -->
	<!--==================================================================-->
	<xsl:template name="VBRunSPRecordset">
		<xsl:param name="name"/>
		<xsl:param name="noprefix" select="false()"/>
		<xsl:param name="indent"/>

		<xsl:call-template name="VBComment">
			<xsl:with-param name="indent" select="$indent"/>
			<xsl:with-param name="value">execute the command</xsl:with-param>
		</xsl:call-template>
		<xsl:if test="WTSQL">
			<xsl:value-of select="concat($tab1, 'sSQL = ', WTSQL/@name, $cr)"/>
		</xsl:if>
		
		<xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template>
		<xsl:variable name="proc">
			<xsl:if test="WTSQL">sSQL</xsl:if>
			<xsl:if test="not(WTSQL)">
				<xsl:if test="not($noprefix)"><xsl:value-of select="concat('&quot;', $appprefix, '_', $entityname, '_')"/></xsl:if>
				<xsl:value-of select="$name"/>
				<xsl:if test="not($noprefix)"><xsl:text>"</xsl:text></xsl:if>
			</xsl:if>
		</xsl:variable>
		<xsl:if test="/Data/WTPAGE/@multi-instance">
			<xsl:value-of select="concat('Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString(mClient, mProject), ', $proc)"/>
		</xsl:if>
		<xsl:if test="not(/Data/WTPAGE/@multi-instance)">
			<xsl:value-of select="concat('Set oRecs = RunSPRecordset(oCmd, moSys.ConnectString(&quot;', $systemname, '&quot;, &quot;', $appprefix, '&quot;), ', $proc)"/>
		</xsl:if>
		<xsl:if test="(WTSQL)"><xsl:value-of select="', 0'"/></xsl:if>
		<xsl:value-of select="concat(')', $cr)"/>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: VB SECURITY PARAM -->
	<!-- outputs the declaration of the security token parameter for a procedure signature -->
	<!-- { Optional ByVal bvSecurityToken As Long = 0 } -->
	<!--==================================================================-->
	<xsl:template name="VBSecurityParam">
		<xsl:param name="continue" select="false()"/>
		<xsl:call-template name="VBParam">
			<xsl:with-param name="name">SecurityToken</xsl:with-param>
			<xsl:with-param name="type">number</xsl:with-param>
			<xsl:with-param name="optional" select="true()"/>
			<xsl:with-param name="default">0</xsl:with-param>
			<xsl:with-param name="continue" select="$continue"/>
		</xsl:call-template>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: VB SECURITY SET -->
	<!-- outputs the code to set the Security Token from the parameter if supplied -->
	<!-- { If bvSecurityToken <> 0 Then mSecurityToken = bvSecurityToken } -->
	<!--==================================================================-->
	<xsl:template name="VBSecuritySet">
		<xsl:call-template name="VBComment">
			<xsl:with-param name="value">set the security token</xsl:with-param>
			<xsl:with-param name="indent">1</xsl:with-param>
		</xsl:call-template>
		<xsl:value-of select="concat($tab1, 'If bvSecurityToken &lt;&gt; 0 Then mSecurityToken = bvSecurityToken', $cr)"/>
		<xsl:value-of select="$cr"/>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: VB START ERROR HANDLER -->
	<!-- outputs the code for the On Error statement -->
	<!-- { On Error GoTo ErrorHandler } -->
	<!--==================================================================-->
	<xsl:template name="VBStartErrorHandler">
		<xsl:value-of select="concat($tab1, 'On Error GoTo ErrorHandler', $cr)"/>
		<xsl:value-of select="$cr"/>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: VB TYPE RECORD -->
	<!-- outputs the type record declaration for an class -->
	<!-- { Public Type tCustomerType...End Type } -->
	<!--==================================================================-->
	<xsl:template name="VBTypeRecord">
		<xsl:value-of select="concat('Public Type t', @name, 'Type', $cr)"/>

		<xsl:for-each select="WTATTRIBUTE">
			<xsl:value-of select="concat($tab1, @name, ' As String', $cr)"/>
		</xsl:for-each>

		<xsl:value-of select="concat('End Type', $cr)"/>
	</xsl:template>

	<!--==========VB Value==========-->
	<xsl:template name="VBValue">
		<xsl:param name="type"/>
		<xsl:param name="value"/>
	
		<xsl:variable name="datatype">
			<xsl:call-template name="VBDataType">
				<xsl:with-param name="datatype" select="$type"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="($datatype = ' As String')"><xsl:value-of select="concat('&quot;', $value, '&quot;')"/></xsl:when>
			<xsl:otherwise><xsl:value-of select="$value"/></xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: VB VARIABLE -->
	<!-- outputs a VB variable declaration -->
	<!-- { Dim x As Integer } -->
	<!--==================================================================-->
	<xsl:template name="VBVariable">
		<xsl:param name="scope">Private</xsl:param>
		<xsl:param name="name"/>
		<xsl:param name="type"/>
		<xsl:param name="indent"/>

		<xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template>
		<xsl:value-of select="concat($scope, ' ', $name)"/>
		<xsl:call-template name="VBDataType">
			<xsl:with-param name="datatype" select="$type"/>
		</xsl:call-template>
		<xsl:value-of select="$cr"/>
	</xsl:template>
	
	<!--==================================================================-->
	<!-- TEMPLATE: VB CONDITION START-->
	<!-- returns the VB for a conditional IF test -->
	<!--==================================================================-->
	<xsl:template name="VBConditionStart">
		<xsl:param name="conditions"/>
		<xsl:param name="indent"/>

		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>

		<!--==========start the IF statement==========-->
		<xsl:value-of select="concat($ind1, 'If ')"/>

		<!--==========build conditions from the WTCONDITION elements==========-->
		<xsl:for-each select="$conditions">
			<xsl:call-template name="VBConditionTest">
				<xsl:with-param name="condition" select="."/>
			</xsl:call-template>
		</xsl:for-each>

		<!--==========end the IF statement==========-->
		<xsl:value-of select="concat(' Then', $cr)"/>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: VB CONDITION TEST-->
	<!-- returns the VB Script for a single test within a condition -->
	<!--==================================================================-->
	<xsl:template name="VBConditionTest">
		<xsl:param name="condition"/>
		<xsl:param name="isfirst"/>
		<xsl:param name="expr"/>
		<xsl:param name="oper"/>
		<xsl:param name="value"/>
		<xsl:param name="connector"/>

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
				<xsl:when test="$expr"></xsl:when>
				<xsl:when test="$condition/@connector">
					<xsl:value-of select="($condition/@connector)"/>
				</xsl:when>
				<xsl:otherwise></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="parenthesis">
			<xsl:choose>
				<xsl:when test="@paren"><xsl:value-of select="@paren"/></xsl:when>
				<xsl:when test="$condition/@paren"><xsl:value-of select="($condition/@paren)"/></xsl:when>
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
		  <xsl:if test="string-length($valuetext)=0">
		      <xsl:call-template name="Error">
		      	<xsl:with-param name="msg" select="'WTCONDITION Value Missing'"/>
		      	<xsl:with-param name="text" select="$exprtext"/>
		      </xsl:call-template>
		  </xsl:if>
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
				<xsl:with-param name="msg" select="'WTCONDITION Connector Not Allowed'"/>
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
									 <xsl:call-template name="VBConditionTest">
										  <xsl:with-param name="condition" select="."/>
										  <xsl:with-param name="isfirst" select="$isfirst"/>
										  <xsl:with-param name="connector" select="$connect"/>
									 </xsl:call-template>
								</xsl:for-each>
						  </xsl:when>
						  <xsl:otherwise>
								<xsl:for-each select="(/Data/WTENTITY/WTCONDITIONS/WTCONDITION[@name=$exprtext]/WTCONDITION)">
									 <xsl:call-template name="VBConditionTest">
										  <xsl:with-param name="condition" select="."/>
										  <xsl:with-param name="isfirst" select="$isfirst"/>
										  <xsl:with-param name="connector" select="$connect"/>
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
				<xsl:if test="not($isfirst)">
					<xsl:choose>
						<xsl:when test="($connect='and')"><xsl:value-of select="(' And ')"/></xsl:when>
						<xsl:when test="($connect='or')"><xsl:value-of select="(' Or ')"/></xsl:when>
					</xsl:choose>
				</xsl:if>

				<!--==========start opening parenthesis==========-->
				<xsl:if test="$parenthesis='start'">
					<xsl:value-of select="'('"/>
				</xsl:if>

				<!--==========enclose the test in parenthesis==========-->
				<xsl:value-of select="concat($tab0,'(')"/>

				<!--==========handle the expression==========-->
				<xsl:call-template name="GetValue">
					<xsl:with-param name="type" select="$exprtype"/>
					<xsl:with-param name="text" select="$exprtext"/>
				</xsl:call-template>

				<!--==========handle the operator==========-->
				<xsl:call-template name="GetOperator">
					<xsl:with-param name="oper" select="$opertext"/>
				</xsl:call-template>

				<!--==========handle the value==========-->
				<xsl:call-template name="GetValue">
					<xsl:with-param name="type" select="$valuetype"/>
					<xsl:with-param name="text" select="$valuetext"/>
				</xsl:call-template>

				<!--==========enclose the test in parenthesis==========-->
				<xsl:value-of select="')'"/>

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
				<xsl:when test="$oper='greater'"> &gt; </xsl:when>
				<xsl:when test="$oper='greater-equal'"> &gt;= </xsl:when>
				<xsl:when test="$oper='less'"> &lt; </xsl:when>
				<xsl:when test="$oper='less-equal'"> &lt;= </xsl:when>
				<xsl:when test="$oper='not-equal'"> &lt;&gt; </xsl:when>
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
	<!-- TEMPLATE: VB CONDITION END-->
	<!-- returns the VB Script for a conditional END IF -->
	<!--==================================================================-->
	<xsl:template name="VBConditionEnd">
		<xsl:param name="indent"/>

		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>

		<xsl:value-of select="concat($ind1, 'End If', $cr)"/>
	</xsl:template>
	
	 <!--==================================================================-->
	 <xsl:template name="GetValue">
	 <!--==================================================================-->
		  <xsl:param name="type"/>
		  <xsl:param name="text"/>
		  <xsl:param name="entity"/>
		  
		  <xsl:choose>
		  <xsl:when test="$type='ATTR'">
			<xsl:value-of select="concat('.', $text)"/>
			<xsl:if test="$entity=$entityname">
				<xsl:if test="count(/Data/WTENTITY/WTATTRIBUTE[@name=$text])=0">
					<xsl:call-template name="Error">
						<xsl:with-param name="msg" select="'Invalid ATTR() Name'"/>
						<xsl:with-param name="text" select="$text"/>
					</xsl:call-template>
				</xsl:if>
			</xsl:if>
		  </xsl:when>
		  <xsl:when test="$type='CONST'"><xsl:value-of select="$text"/></xsl:when>

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

		  <xsl:when test="$type='NONE'">
				<xsl:choose>
					 <xsl:when test="$text='true'">True</xsl:when>
					 <xsl:when test="$text='false'">False</xsl:when>
					 <xsl:otherwise><xsl:value-of select="$text"/></xsl:otherwise>
				</xsl:choose>
		  </xsl:when>
			<xsl:otherwise>
				 <xsl:call-template name="Error">
				 	<xsl:with-param name="msg" select="'Invalid Data Name'"/>
				 	<xsl:with-param name="text" select="$text"/>
				 </xsl:call-template>
			</xsl:otherwise>
		  </xsl:choose>
	 </xsl:template>

</xsl:stylesheet>
