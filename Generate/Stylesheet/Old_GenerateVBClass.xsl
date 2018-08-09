<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:include href="GenerateIncludeVB.xsl"/>

	<!--==================================================================-->
	<xsl:template match="/">
	<!--==================================================================-->
		<VB><xsl:apply-templates/></VB>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="/Data">
	<!--==================================================================-->
		<xsl:apply-templates select="WTENTITY/WTCLASS">
			<xsl:with-param name="indent">0</xsl:with-param>
		</xsl:apply-templates>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTCLASS">
	<!--==================================================================-->
		<xsl:param name="indent"/>

		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="ind2"><xsl:value-of select="concat($ind1, $tab1)"/></xsl:variable>
		<xsl:variable name="indent2"><xsl:value-of select="($indent+1)"/></xsl:variable>

		<xsl:value-of select="concat($ind1, 'VERSION 1.0 CLASS', $cr)"/>
		<xsl:value-of select="concat($ind1, 'BEGIN', $cr)"/>
		<xsl:value-of select="concat($ind2, 'MultiUse = -1  ', $apos, 'True', $cr)"/>
		<xsl:value-of select="concat($ind2, 'Persistable = 0  ', $apos, 'NotPersistable', $cr)"/>
		<xsl:value-of select="concat($ind2, 'DataBindingBehavior = 0  ', $apos, 'vbNone', $cr)"/>
		<xsl:value-of select="concat($ind2, 'DataSourceBehavior  = 0  ', $apos, 'vbNone', $cr)"/>
		<xsl:value-of select="concat($ind2, 'MTSTransactionMode  = 0  ', $apos, 'NotAnMTSObject', $cr)"/>
		<xsl:value-of select="concat($ind1, 'END', $cr)"/>
		<xsl:value-of select="concat($ind1, 'Attribute VB_Name = &quot;', @name, '&quot;', $cr)"/>
		<xsl:value-of select="concat($ind1, 'Attribute VB_GlobalNameSpace = False', $cr)"/>
		<xsl:value-of select="concat($ind1, 'Attribute VB_Creatable = True', $cr)"/>
		<xsl:value-of select="concat($ind1, 'Attribute VB_PredeclaredId = False', $cr)"/>
		<xsl:value-of select="concat($ind1, 'Attribute VB_Exposed = True', $cr)"/>
		<xsl:value-of select="concat($ind1, 'Option Explicit', $cr)"/>

		<!--constants-->
		<xsl:call-template name="VBComment">
			<xsl:with-param name="value">constants</xsl:with-param>
			<xsl:with-param name="indent" select="$indent"/>
		</xsl:call-template>
		<xsl:value-of select="concat($ind1, 'Private Const cModName As String = &quot;', @name, '&quot;', $cr)"/>

		<!--properties-->
		<xsl:call-template name="VBComment">
			<xsl:with-param name="value">properties</xsl:with-param>
			<xsl:with-param name="indent" select="$indent"/>
		</xsl:call-template>
		<xsl:apply-templates select="WTDECLARE">
			<xsl:with-param name="indent" select="$indent"/>
		</xsl:apply-templates>

		<!--enumerators-->
		<xsl:apply-templates select="." mode="enums">
			<xsl:with-param name="indent" select="$indent"/>
		</xsl:apply-templates>
		<xsl:value-of select="$cr"/>

		<!--methods-->
		<xsl:apply-templates select="WTMETHOD">
			<xsl:with-param name="indent" select="$indent"/>
		</xsl:apply-templates>

		<xsl:value-of select="$cr"/>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTCLASS" mode="enums">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="ind2"><xsl:value-of select="concat($ind1, $tab1)"/></xsl:variable>
		<xsl:variable name="indent2"><xsl:value-of select="($indent+1)"/></xsl:variable>

		<xsl:if test="count($attrenums) > 0">
			<xsl:call-template name="VBComment">
				<xsl:with-param name="value">enumerators</xsl:with-param>
				<xsl:with-param name="indent" select="$indent"/>
			</xsl:call-template>

			<xsl:value-of select="concat($ind1, 'Public Enum ', $appprefix, $entityname, 'EnumConstants', $cr)"/>
			<xsl:for-each select="$attrenums">	
				<xsl:value-of select="concat($ind2, $appprefix, $entityname, 'Enum', @name, ' = c', $appprefix, $entityname, 'Enum', @name, $cr)"/>
			</xsl:for-each>
			<xsl:value-of select="concat($ind1, 'End Enum', $cr, $cr)"/>

			<xsl:apply-templates select="$attrenums" mode="enumdeclare">
				<xsl:with-param name="indent" select="$indent"/>
			</xsl:apply-templates>
		</xsl:if>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTATTRIBUTE" mode="enumdeclare">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="ind2"><xsl:value-of select="concat($ind1, $tab1)"/></xsl:variable>
		<xsl:variable name="indent2"><xsl:value-of select="($indent+1)"/></xsl:variable>

		<xsl:value-of select="$ind1"/>

		<xsl:value-of select="concat($ind1, 'Public Enum ', $appprefix, $entityname, @name, 'Constants', $cr)"/>
		<xsl:for-each select="WTENUM">
			<xsl:value-of select="concat($ind2, $appprefix, $entityname, ../@name, @name, ' = c', $appprefix, $entityname, ../@name, @name, $cr)"/>
		</xsl:for-each>
		<xsl:value-of select="concat($ind1, 'End Enum', $cr, $cr)"/>
		<xsl:value-of select="$cr"/>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTDECLARE" mode="declare">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>

		<xsl:value-of select="$ind1"/>

		<xsl:choose>
			<xsl:when test="(@scope='private')"><xsl:value-of select="('Private m')"/></xsl:when>
			<xsl:when test="(@scope='public')"><xsl:value-of select="('Public p')"/></xsl:when>
			<xsl:when test="(@scope='friend')"><xsl:value-of select="('Friend m')"/></xsl:when>
			<xsl:otherwise><xsl:value-of select="('Dim ')"/></xsl:otherwise>
		</xsl:choose>
		<xsl:value-of select="@name"/>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTDECLARE" mode="datatype">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="valuetype"><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="@datatype"/></xsl:call-template></xsl:variable>
		<xsl:variable name="valuetext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@datatype"/></xsl:call-template></xsl:variable>
		<xsl:variable name="valueentity"><xsl:call-template name="QualifiedPrefix"><xsl:with-param name="value" select="@datatype"/></xsl:call-template></xsl:variable>

		<xsl:value-of select="concat($ind1, ' As ')"/>
		<xsl:choose>
			<xsl:when test="($valuetype='PROPERTY')"><xsl:value-of select="concat($appprefix, $valueentity, '.', $valuetext)"/></xsl:when>
			<xsl:when test="($valuetype='NONE') and ($valuetext='char')"><xsl:value-of select="('String')"/></xsl:when>
			<xsl:when test="($valuetype='NONE') and ($valuetext='text')"><xsl:value-of select="('String')"/></xsl:when>
			<xsl:when test="($valuetype='NONE') and ($valuetext='big number')"><xsl:value-of select="('String')"/></xsl:when>
			<xsl:when test="($valuetype='NONE') and ($valuetext='number')"><xsl:value-of select="('Long')"/></xsl:when>
			<xsl:when test="($valuetype='NONE') and ($valuetext='small number')"><xsl:value-of select="('Integer')"/></xsl:when>
			<xsl:when test="($valuetype='NONE') and ($valuetext='tiny number')"><xsl:value-of select="('Byte')"/></xsl:when>
			<xsl:when test="($valuetype='NONE') and ($valuetext='decimal')"><xsl:value-of select="('Double')"/></xsl:when>
			<xsl:when test="($valuetype='NONE') and ($valuetext='date')"><xsl:value-of select="('Date')"/></xsl:when>
			<xsl:when test="($valuetype='NONE') and ($valuetext='currency')"><xsl:value-of select="('Currency')"/></xsl:when>
			<xsl:when test="($valuetype='NONE') and ($valuetext='yesno')"><xsl:value-of select="('Integer')"/></xsl:when>
			<xsl:when test="($valuetype='NONE') and ($valuetext='password')"><xsl:value-of select="('String')"/></xsl:when>
			<xsl:otherwise><xsl:value-of select="$valuetext"/></xsl:otherwise>
<!--old still needed???
			<xsl:when test="($datatype='busnitem')"><xsl:value-of select="concat($appprefix, /Data/@project, 'Busn.C', $entityname)"/></xsl:when>
			<xsl:when test="($datatype='busnrecord')"><xsl:value-of select="concat($appprefix, /Data/@project, 'Busn.t', $entityname, 'Type')"/></xsl:when>
			<xsl:when test="($datatype='useritem')"><xsl:value-of select="concat($appprefix, /Data/@project, 'User.C', $entityname)"/></xsl:when>
			<xsl:when test="($datatype='record')"><xsl:value-of select="concat('t', $entityname, 'Type')"/></xsl:when>
			<xsl:when test="($datatype='records')"><xsl:value-of select="concat('t', $entityname, 'Type()')"/></xsl:when>
-->
		</xsl:choose>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTDECLARE">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>

		<xsl:value-of select="$ind1"/>

		<xsl:apply-templates select="." mode="declare">
			<xsl:with-param name="indent">0</xsl:with-param>
		</xsl:apply-templates>

		<xsl:apply-templates select="." mode="datatype">
			<xsl:with-param name="indent">0</xsl:with-param>
		</xsl:apply-templates>

		<xsl:value-of select="$cr"/>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTMETHOD">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>

		<xsl:choose>
			<xsl:when test="(substring(@passthru, 1, 6) = 'OBJECT')">
				<xsl:apply-templates select="." mode="passthru">
					<xsl:with-param name="indent" select="$indent"/>
				</xsl:apply-templates>
			</xsl:when>
			<xsl:when test="(substring(@passthru, 1, 4) = 'PROC')">
				<xsl:apply-templates select="/Data/WTENTITY/WTPROCEDURES/WTPROCEDURE[@name=current()/@passthru]" mode="passthru">
					<xsl:with-param name="indent" select="$indent"/>
					<xsl:with-param name="method" select="."/>
				</xsl:apply-templates>
			</xsl:when>
			<xsl:otherwise>		
				<xsl:choose>
					<xsl:when test="(@scope='private')"><xsl:value-of select="concat($ind1, 'Private ')"/></xsl:when>
					<xsl:when test="(@scope='friend')"><xsl:value-of select="concat($ind1, 'Friend ')"/></xsl:when>
					<xsl:otherwise><xsl:value-of select="concat($ind1, 'Public ')"/></xsl:otherwise>
				</xsl:choose>

			</xsl:otherwise>		
		</xsl:choose>

				<WTMETHOD name="ChangeLogon" passthru="OBJECT(CSQL.ChangePswd)"/>
				<WTMETHOD name="ChangePswd" passthru="OBJECT(CSQL.ChangePswd)"/>
				<WTMETHOD name="Load" passthru="OBJECT(CSQL.Fetch)"/>
				<WTMETHOD name="ResetLogon" passthru="OBJECT(CSQL.ResetLogon)"/>
				<WTMETHOD name="ResetPswd" passthru="OBJECT(CSQL.ResetPswd)"/>
				<WTMETHOD name="SignIn" passthru="OBJECT(CSQL.SignIn)"/>

		<xsl:value-of select="$cr"/>

	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTMETHOD" mode="passthru">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="ind2"><xsl:value-of select="concat($ind1, $tab1)"/></xsl:variable>
		<xsl:variable name="indent2"><xsl:value-of select="($indent+1)"/></xsl:variable>
		<xsl:variable name="valuetype"><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="@passthru"/></xsl:call-template></xsl:variable>
		<xsl:variable name="valuetext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@passthru"/></xsl:call-template></xsl:variable>
		<xsl:variable name="valueentity"><xsl:call-template name="QualifiedPrefix"><xsl:with-param name="value" select="@passthru"/></xsl:call-template></xsl:variable>

		<xsl:choose>
			<xsl:when test="(@scope='private')"><xsl:value-of select="concat($ind1, 'Private Sub ', @name, '(')"/></xsl:when>
			<xsl:when test="(@scope='friend')"><xsl:value-of select="concat($ind1, 'Friend Sub ', @name, '(')"/></xsl:when>
			<xsl:otherwise><xsl:value-of select="concat($ind1, 'Public Sub ', @name, '(')"/></xsl:otherwise>
		</xsl:choose>

		<xsl:choose>
			<xsl:when test="(@secure)"><xsl:value-of select="concat(' _', $cr, $ind2, 'ByVal bvSecurityToken As Long)', $cr)"/></xsl:when>
			<xsl:otherwise><xsl:value-of select="concat(')', $cr)"/></xsl:otherwise>
		</xsl:choose>

		<xsl:value-of select="concat($ind2, $apos, '--------------------------------------------------------------------------------', $cr)"/>
		<xsl:value-of select="concat($ind2, 'Dim ErrNo As Long, ErrSrc As String, ErrDesc As String', $cr)"/>
		<xsl:value-of select="concat($ind2, 'Const cProcName As String = &quot;', @name, '&quot;', $cr)"/>
		<xsl:value-of select="concat($ind2, $apos, '--------------------------------------------------------------------------------', $cr)"/>
		<xsl:value-of select="concat($ind2, 'On Error GoTo ErrorHandler', $cr, $cr)"/>

		<xsl:choose>
			<xsl:when test="(@secure)"><xsl:value-of select="concat($ind2, $valueentity, '.', $valuetext, ' mDataRec, bvSecurityToken', $cr, $cr)"/></xsl:when>
			<xsl:otherwise><xsl:value-of select="concat($ind2, $valueentity, '.', $valuetext, ' mDataRec', $cr, $cr)"/></xsl:otherwise>
		</xsl:choose>

		<xsl:value-of select="concat($ind2, 'Exit Sub', $cr, $cr)"/>

		<xsl:value-of select="concat($ind1, 'ErrorHandler:', $cr)"/>
		<xsl:value-of select="concat($ind2, 'Catch Error ErrNo, ErrSrc, ErrDesc, cModName, cProcName', $cr)"/>
		<xsl:value-of select="concat($ind2, 'If Err.Number = 0 Then Resume Next', $cr)"/>
		<xsl:value-of select="concat($ind2, 'Err.Raise ErrNo, ErrSrc, ErrDesc', $cr)"/>
		<xsl:value-of select="concat($ind1, 'End Sub', $cr, $cr)"/>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTPROCEDURE" mode="passthru">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:param name="method"/>

		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="ind2"><xsl:value-of select="concat($ind1, $tab1)"/></xsl:variable>
		<xsl:variable name="indent2"><xsl:value-of select="($indent+1)"/></xsl:variable>

		<xsl:choose>
			<xsl:when test="(@scope='private')"><xsl:value-of select="concat($ind1, 'Private ')"/></xsl:when>
			<xsl:when test="(@scope='friend')"><xsl:value-of select="concat($ind1, 'Friend ')"/></xsl:when>
			<xsl:otherwise><xsl:value-of select="concat($ind1, 'Public ')"/></xsl:otherwise>
		</xsl:choose>

		<xsl:value-of select="$method/@name"/>
		<xsl:value-of select="$cr"/>
	</xsl:template>

</xsl:stylesheet>
