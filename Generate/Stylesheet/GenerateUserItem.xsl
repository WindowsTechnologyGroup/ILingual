<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:include href="GenerateIncludeVB.xsl"/>
<!--===============================================================================
	Auth: Bob Wood
	Date: December 2007
	Desc: Transforms an ILingual Entity Definition to a VB Item Class
	Copyright 2001 WinTech, Inc.
===================================================================================-->
	<xsl:template match="/">
		<VB><xsl:apply-templates/></VB>
	</xsl:template>

	<xsl:template match="WTENTITY">

		<xsl:variable name="userproj" select="concat($appprefix, /Data/@project, 'User.')"/>
		<xsl:variable name="busnproj" select="concat($appprefix, /Data/@project, 'Busn.')"/>
		<xsl:variable name="defaultlanguage" select="/Data/@defaultlanguage"/>
		<xsl:variable name="itemclass" select="concat('C', @name)"/>
		<xsl:variable name="identityfield" select="WTATTRIBUTE[@identity]/@name"/>
		<xsl:variable name="constprefix" select="concat($appprefix, $entityname)"/>

		<xsl:variable name="islanguage" select="not(@language='false')"/>
		<xsl:variable name="labels" select="WTATTRIBUTE[@language='true']"/>
		<xsl:variable name="entitylabels" select="WTATTRIBUTE[@language='true' and not(WTJOIN)]"/>
		<xsl:variable name="joinlabels" select="WTATTRIBUTE[@language='true' and WTJOIN]"/>
		<xsl:variable name="embeds" select="WTATTRIBUTE[@embed]"/>

		<xsl:call-template name="VBHeaderClassModule">
			<xsl:with-param name="name" select="@name"/>
			<xsl:with-param name="mtsmode">0</xsl:with-param>
			<xsl:with-param name="createable" select="true()"/>
			<xsl:with-param name="exposed" select="true()"/>
		</xsl:call-template>

		<xsl:call-template name="VBComment">
			<xsl:with-param name="value">constants</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="VBConstant">
			<xsl:with-param name="name">ModName</xsl:with-param>
			<xsl:with-param name="type">text</xsl:with-param>
			<xsl:with-param name="value" select="$itemclass"/>
		</xsl:call-template>

		  <xsl:call-template name="VBConstant">
		  	<xsl:with-param name="name">EntityID</xsl:with-param>
		  	<xsl:with-param name="type">number</xsl:with-param>
		  	<xsl:with-param name="value" select="@id"/>
		  </xsl:call-template>
		  <xsl:call-template name="VBConstant">
		  	<xsl:with-param name="name">DefaultLanguage</xsl:with-param>
		  	<xsl:with-param name="type">text</xsl:with-param>
		  	<xsl:with-param name="value" select="$defaultlanguage"/>
		  </xsl:call-template>

		<xsl:call-template name="VBComment">
			<xsl:with-param name="value">properties</xsl:with-param>
		</xsl:call-template>
		
		<xsl:call-template name="VBVariable">
			<xsl:with-param name="name">mDataRec</xsl:with-param>
			<xsl:with-param name="type">busnrecord</xsl:with-param>
		</xsl:call-template>
		
		<xsl:call-template name="VBVariable">
			<xsl:with-param name="name">mSecurityToken</xsl:with-param>
			<xsl:with-param name="type">number</xsl:with-param>
		</xsl:call-template>

		  <xsl:call-template name="VBVariable">
		  	<xsl:with-param name="name">mCurrentLanguage</xsl:with-param>
		  	<xsl:with-param name="type">text</xsl:with-param>
		  </xsl:call-template>

		  <xsl:if test="$embeds">
				<xsl:call-template name="VBComment">
					 <xsl:with-param name="value">Embed Variables</xsl:with-param>
				</xsl:call-template>
				<xsl:for-each select="$embeds">
					 <xsl:value-of select="concat('Private emb', @name, ' As String', $cr)"/>
				</xsl:for-each>
		  </xsl:if>

		<!--==================================================================-->
		<!-- ENUM ITEM TYPE CONSTANTS -->
		<!--==================================================================-->
		<xsl:if test="($hasenum)">
			<xsl:call-template name="VBComment">
				<xsl:with-param name="value">enumerators</xsl:with-param>
			</xsl:call-template>
			<xsl:value-of select="concat('Public Enum ', $constprefix, 'EnumConstants', $cr)"/>
			<xsl:for-each select="WTATTRIBUTE[WTENUM]">
				<xsl:call-template name="VBEnum">
					<xsl:with-param name="prefix" select="$constprefix"/>
					<xsl:with-param name="name" select="concat('Enum', @name)"/>
				</xsl:call-template>
			</xsl:for-each>
			<xsl:value-of select="concat('End Enum', $cr)"/>
			<xsl:for-each select="WTATTRIBUTE[WTENUM]">
				<xsl:variable name="enumprefix" select="concat($constprefix, @name)"/>
				<xsl:value-of select="concat($cr, 'Public Enum ', $enumprefix, 'Constants', $cr)"/>
				<xsl:for-each select="WTENUM">
					<xsl:call-template name="VBEnum">
						<xsl:with-param name="prefix" select="$enumprefix"/>
						<xsl:with-param name="name" select="@name"/>
					</xsl:call-template>
				</xsl:for-each>
				<xsl:value-of select="concat('End Enum', $cr)"/>
			</xsl:for-each>
		</xsl:if>

		<!--==================================================================-->
		<!-- METHOD: SysClientProject -->
		<!--==================================================================-->
		<xsl:if test="/Data/WTPAGE/@multi-instance">
			<xsl:value-of select="concat('Private mClient As String', $cr)"/>
			<xsl:value-of select="concat('Private mProject As String', $cr, $cr)"/>
			<xsl:value-of select="concat('Public Sub SysClientProject(ByVal bvClient As String, ByVal bvProject As String)', $cr)"/>
			<xsl:value-of select="concat($tab1, 'mClient = bvClient', $cr)"/>
			<xsl:value-of select="concat($tab1, 'mProject = bvProject', $cr)"/>
			<xsl:value-of select="concat('End Sub', $cr)"/>
		</xsl:if>

		<!--==================================================================-->
		<!-- METHOD: EmbedText -->
		<!--==================================================================-->
		  <xsl:if test="$embeds">
		  		<xsl:value-of select="$cr"/>
				<xsl:call-template name="VBMethodStart">
					 <xsl:with-param name="scope">Public</xsl:with-param>
					 <xsl:with-param name="type">Sub</xsl:with-param>
					 <xsl:with-param name="name">EmbedText</xsl:with-param>
					 <xsl:with-param name="noparams" select="false()"/>
				</xsl:call-template>
				<xsl:value-of select="concat($tab1, 'ByVal bvAttributeID As Long, _', $cr)"/>
				<xsl:value-of select="concat($tab1, 'ByVal bvValue As String)', $cr)"/>

				<xsl:call-template name="VBFunctionBox">
					 <xsl:with-param name="name">EmbedText</xsl:with-param>
					 <xsl:with-param name="desc">Sets a token for embedded text.</xsl:with-param>
					 <xsl:with-param name="ismts" select="false()"/>
					 <xsl:with-param name="isado" select="false()"/>
				</xsl:call-template>
				<xsl:call-template name="VBStartErrorHandler"/>

				<xsl:value-of select="concat($tab1, 'Select Case bvAttributeID', $cr)"/>
				<xsl:for-each select="$embeds">
					 <xsl:value-of select="concat($tab2, 'Case ', @id, ': emb', @name, ' = bvValue', $cr)"/>
				</xsl:for-each>
	 			<xsl:value-of select="concat($tab2, 'Case Else: Err.Raise 10999, &quot;EmbedText&quot;, &quot;Invalid Embed Attribute ID&quot;', $cr)"/>
				<xsl:value-of select="concat($tab1, 'End Select', $cr, $cr)"/>

				<xsl:call-template name="VBMethodEnd">
					 <xsl:with-param name="type">Sub</xsl:with-param>
					 <xsl:with-param name="isado" select="false()"/>
					 <xsl:with-param name="ismts" select="false()"/>
				</xsl:call-template>
		  </xsl:if>

		<!--==================================================================-->
		<!-- METHOD: ADD -->
		<!--==================================================================-->
		<xsl:if test="WTPROCEDURES/WTPROCEDURE[@type='Add']">
			<xsl:value-of select="$cr"/>
			<xsl:call-template name="VBMethodStart">
				<xsl:with-param name="scope">Public</xsl:with-param>
				<xsl:with-param name="type">Function</xsl:with-param>
				<xsl:with-param name="name">Add</xsl:with-param>
				<xsl:with-param name="noparams" select="false()"/>
			</xsl:call-template>

			<xsl:call-template name="VBParamParent">
				<xsl:with-param name="continue" select="true()"/>
			</xsl:call-template>
			<xsl:call-template name="VBSecurityParam">
				<xsl:with-param name="continue" select="false()"/>
			</xsl:call-template>
			<xsl:value-of select="(')')"/>
			<xsl:call-template name="VBDataType">
				<xsl:with-param name="datatype">number</xsl:with-param>
			</xsl:call-template>
			<xsl:value-of select="$cr"/>

			<xsl:call-template name="VBFunctionBox">
				<xsl:with-param name="name">Add</xsl:with-param>
				<xsl:with-param name="desc">Adds a new record.</xsl:with-param>
				<xsl:with-param name="ismts" select="false()"/>
				<xsl:with-param name="isado" select="false()"/>
			</xsl:call-template>

			<xsl:call-template name="VBStartErrorHandler"/>
			<xsl:call-template name="VBSecuritySet"/>
			<xsl:call-template name="VBParentSetItem"/>

			<xsl:value-of select="concat($tab1, 'BusnService.Add mDataRec, mSecurityToken', $cr, $cr)"/>

			<xsl:call-template name="VBComment">
				<xsl:with-param name="value">return the new item</xsl:with-param>
				<xsl:with-param name="indent">1</xsl:with-param>
			</xsl:call-template>
			<xsl:value-of select="concat($tab1, 'Add = mDataRec.', $identityfield, $cr, $cr)"/>

			<xsl:call-template name="VBMethodEnd">
				<xsl:with-param name="type">Function</xsl:with-param>
				<xsl:with-param name="isado" select="false()"/>
				<xsl:with-param name="ismts" select="false()"/>
			</xsl:call-template>
		</xsl:if>

		<!--==================================================================-->
		<!-- METHOD: BUSNSERVICE -->
		<!--==================================================================-->
		<xsl:value-of select="$cr"/>
		<xsl:call-template name="VBMethodStart">
			<xsl:with-param name="scope">Private</xsl:with-param>
			<xsl:with-param name="type">Function</xsl:with-param>
			<xsl:with-param name="name">BusnService</xsl:with-param>
			<xsl:with-param name="noparams" select="true()"/>
		</xsl:call-template>

		<xsl:if test="/Data/@userbusn">
			<xsl:call-template name="VBDataType">
				<xsl:with-param name="datatype" select="concat($itemclass, 'B')"/>
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="not(/Data/@userbusn)">
			<xsl:call-template name="VBDataType">
				<xsl:with-param name="datatype" select="concat($busnproj, $itemclass)"/>
			</xsl:call-template>
		</xsl:if>

		<xsl:value-of select="$cr"/>

		<xsl:call-template name="VBFunctionBox">
			<xsl:with-param name="name">BusnService</xsl:with-param>
			<xsl:with-param name="desc">Returns a reference to the object's business service object.</xsl:with-param>
			<xsl:with-param name="ismts" select="false()"/>
			<xsl:with-param name="isado" select="false()"/>
		</xsl:call-template>

		<xsl:call-template name="VBStartErrorHandler"/>

		<xsl:if test="/Data/@userbusn">
			<xsl:value-of select="concat($tab1, 'Set BusnService = New ', $itemclass, 'B', $cr)"/>
		</xsl:if>
		<xsl:if test="not(/Data/@userbusn)">
			<xsl:value-of select="concat($tab1, 'Set BusnService = New ', $busnproj, $itemclass, $cr)"/>
		</xsl:if>

		<xsl:if test="/Data/WTPAGE/@multi-instance">
			<xsl:value-of select="concat($tab1, 'BusnService.SysClientProject mClient, mProject', $cr)"/>
		</xsl:if>
		<xsl:value-of select="$cr"/>

		<xsl:call-template name="VBMethodEnd">
			<xsl:with-param name="type">Function</xsl:with-param>
			<xsl:with-param name="isado" select="false()"/>
			<xsl:with-param name="ismts" select="false()"/>
		</xsl:call-template>

		<!--==================================================================-->
		<!-- METHOD: COPY -->
		<!--==================================================================-->
		<xsl:if test="WTPROCEDURES/WTPROCEDURE[@type='Copy' and not(@template='new')]">

		  <xsl:value-of select="$cr"/>
		  <xsl:call-template name="VBMethodStart">
		  	<xsl:with-param name="scope">Public</xsl:with-param>
		  	<xsl:with-param name="type">Function</xsl:with-param>
		  	<xsl:with-param name="name">Copy</xsl:with-param>
		  	<xsl:with-param name="noparams" select="false()"/>
		  </xsl:call-template>

		  <xsl:call-template name="VBSecurityParam">
		  	<xsl:with-param name="continue" select="false()"/>
		  </xsl:call-template>
		  <xsl:value-of select="(')')"/>
		  <xsl:call-template name="VBDataType">
		  	<xsl:with-param name="datatype">number</xsl:with-param>
		  </xsl:call-template>
		  <xsl:value-of select="$cr"/>

		  <xsl:call-template name="VBFunctionBox">
		  	<xsl:with-param name="name">Copy</xsl:with-param>
		  	<xsl:with-param name="desc">Copies an existing record.</xsl:with-param>
		  	<xsl:with-param name="ismts" select="false()"/>
		  	<xsl:with-param name="isado" select="false()"/>
		  </xsl:call-template>

		  <xsl:call-template name="VBStartErrorHandler"/>
		  <xsl:call-template name="VBSecuritySet"/>

		  <xsl:value-of select="concat($tab1, 'BusnService.Copy mDataRec, mSecurityToken', $cr, $cr)"/>

		  <xsl:call-template name="VBComment">
		  	<xsl:with-param name="value">return the new item</xsl:with-param>
		  	<xsl:with-param name="indent">1</xsl:with-param>
		  </xsl:call-template>
		  <xsl:value-of select="concat($tab1, 'Copy = mDataRec.', $identityfield, $cr, $cr)"/>

		  <xsl:call-template name="VBMethodEnd">
		  	<xsl:with-param name="type">Function</xsl:with-param>
		  	<xsl:with-param name="isado" select="false()"/>
		  	<xsl:with-param name="ismts" select="false()"/>
		  </xsl:call-template>

		</xsl:if>

		<!--==================================================================-->
		<!-- METHOD: DELETE -->
		<!--==================================================================-->
		<xsl:if test="WTPROCEDURES/WTPROCEDURE[@type='Delete']">
			<xsl:value-of select="$cr"/>

			<xsl:call-template name="VBMethodStart">
				<xsl:with-param name="scope">Public</xsl:with-param>
				<xsl:with-param name="type">Sub</xsl:with-param>
				<xsl:with-param name="name">Delete</xsl:with-param>
			</xsl:call-template>

			<xsl:for-each select="WTATTRIBUTE[@identity]">
				<xsl:call-template name="VBParam">
					<xsl:with-param name="name" select="@name"/>
					<xsl:with-param name="type" select="@type"/>
					<xsl:with-param name="optional" select="true()"/>
					<xsl:with-param name="default">0</xsl:with-param>
					<xsl:with-param name="continue" select="true()"/>
				</xsl:call-template>
			</xsl:for-each>
			<xsl:call-template name="VBSecurityParam">
				<xsl:with-param name="continue" select="false()"/>
			</xsl:call-template>
			<xsl:value-of select="concat(')', $cr)"/>

			<xsl:call-template name="VBFunctionBox">
				<xsl:with-param name="name">Delete</xsl:with-param>
				<xsl:with-param name="desc">Deletes the record.</xsl:with-param>
				<xsl:with-param name="ismts" select="false()"/>
				<xsl:with-param name="isado" select="false()"/>
			</xsl:call-template>

			<xsl:call-template name="VBStartErrorHandler"/>
			<xsl:call-template name="VBSecuritySet"/>

			<xsl:call-template name="VBComment">
				<xsl:with-param name="value">initialize the ID if provided</xsl:with-param>
				<xsl:with-param name="indent">1</xsl:with-param>
			</xsl:call-template>
			<xsl:value-of select="concat($tab1, 'If bv', $identityfield, ' &gt; 0 Then ', $identityfield, ' = bv', $identityfield, $cr, $cr)"/>

			<xsl:value-of select="concat($tab1, 'BusnService.Delete mDataRec, mSecurityToken', $cr, $cr)"/>

			<xsl:call-template name="VBMethodEnd">
				<xsl:with-param name="type">Sub</xsl:with-param>
				<xsl:with-param name="isado" select="false()"/>
				<xsl:with-param name="ismts" select="false()"/>
			</xsl:call-template>
		</xsl:if>

		<!--==================================================================-->
		<!-- METHOD: ENUMITEMS -->
		<!--==================================================================-->
		<xsl:if test="($hasenum)">
			<xsl:value-of select="$cr"/>
			<xsl:call-template name="VBMethodStart">
				<xsl:with-param name="type">Property Get</xsl:with-param>
				<xsl:with-param name="name">EnumItems</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="VBParam">
				<xsl:with-param name="name">Type</xsl:with-param>
				<xsl:with-param name="type" select="concat($constprefix, 'EnumConstants')"/>
				<xsl:with-param name="continue" select="false()"/>
			</xsl:call-template>
			<xsl:value-of select="concat($tab0, ')')"/>
			<xsl:call-template name="VBDataType">
				<xsl:with-param name="datatype">wtSystem.CEnumItems</xsl:with-param>
			</xsl:call-template>
			<xsl:value-of select="$cr"/>

			<xsl:call-template name="VBFunctionBox">
				<xsl:with-param name="name">EnumItems</xsl:with-param>
				<xsl:with-param name="desc">Returns an enumerated list of items.</xsl:with-param>
				<xsl:with-param name="ismts" select="false()"/>
				<xsl:with-param name="isado" select="false()"/>
			</xsl:call-template>

			<xsl:call-template name="VBVariable">
				<xsl:with-param name="indent">1</xsl:with-param>
				<xsl:with-param name="scope">Dim</xsl:with-param>
				<xsl:with-param name="name">oEnums</xsl:with-param>
				<xsl:with-param name="type">wtSystem.CEnumItems</xsl:with-param>
			</xsl:call-template>
			<xsl:value-of select="$cr"/>

			<xsl:call-template name="VBStartErrorHandler"/>
		
			<xsl:value-of select="concat($tab1, 'Set oEnums = New wtSystem.CEnumItems', $cr, $cr)"/>
			<xsl:value-of select="concat($tab1, 'Select Case bvType', $cr)"/>
			<xsl:for-each select="/Data/WTENTITY/WTATTRIBUTE[WTENUM]">
				<xsl:variable name="enumprefix" select="concat($constprefix, @name)"/>
				<xsl:value-of select="concat($tab2, 'Case c', $constprefix, 'Enum', @name, '', $cr)"/>
				<xsl:for-each select="WTENUM">
					<xsl:value-of select="concat($tab3, 'oEnums.Add c', $enumprefix, @name, ', &quot;', @name, '&quot;', $cr)"/>
				</xsl:for-each>
			</xsl:for-each>
			<xsl:value-of select="concat($tab1, 'End Select', $cr, $cr)"/>
			<xsl:value-of select="concat($tab1, 'Set EnumItems = oEnums', $cr)"/>
			<xsl:value-of select="concat($tab1, 'Set oEnums = Nothing', $cr, $cr)"/>

			<xsl:call-template name="VBMethodEnd">
				<xsl:with-param name="type">Property Get</xsl:with-param>
				<xsl:with-param name="isado" select="false()"/>
				<xsl:with-param name="ismts" select="false()"/>
			</xsl:call-template>
		</xsl:if>

		<!--==================================================================-->
		<!-- METHOD: INIT -->
		<!--==================================================================-->
		<xsl:if test="WTPROCEDURES/WTPROCEDURE[@type='Init']">
			<xsl:value-of select="$cr"/>
			<xsl:call-template name="VBMethodStart">
				<xsl:with-param name="type">Sub</xsl:with-param>
				<xsl:with-param name="name">Init</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="VBParamParent"/>
			<xsl:call-template name="VBSecurityParam"/>
			<xsl:value-of select="concat(')', $cr)"/>

			<xsl:call-template name="VBFunctionBox">
				<xsl:with-param name="name">Init</xsl:with-param>
				<xsl:with-param name="desc">Initializes the object from the parent.</xsl:with-param>
				<xsl:with-param name="ismts" select="false()"/>
				<xsl:with-param name="isado" select="false()"/>
			</xsl:call-template>

			<xsl:call-template name="VBStartErrorHandler"/>
			<xsl:call-template name="VBSecuritySet"/>
			<xsl:call-template name="VBParentSetItem"/>

			<xsl:call-template name="VBMethodEnd">
				<xsl:with-param name="type">Sub</xsl:with-param>
				<xsl:with-param name="isado" select="false()"/>
				<xsl:with-param name="ismts" select="false()"/>
			</xsl:call-template>
		</xsl:if>

		<!--==================================================================-->
		<!-- METHOD: LOAD -->
		<!--==================================================================-->
		<xsl:if test="WTPROCEDURES/WTPROCEDURE[@type='Fetch' and not(@template='new')]">
			<xsl:value-of select="$cr"/>
			<xsl:call-template name="VBMethodStart">
				<xsl:with-param name="type">Sub</xsl:with-param>
				<xsl:with-param name="name">Load</xsl:with-param>
			</xsl:call-template>
			<xsl:for-each select="WTATTRIBUTE[@identity]">
				<xsl:call-template name="VBParam">
					<xsl:with-param name="name" select="@name"/>
					<xsl:with-param name="type" select="@type"/>
					<xsl:with-param name="optional" select="true()"/>
					<xsl:with-param name="default">0</xsl:with-param>
				</xsl:call-template>
			</xsl:for-each>
			<xsl:call-template name="VBSecurityParam"/>
			<xsl:value-of select="concat(')', $cr)"/>

			<xsl:call-template name="VBFunctionBox">
				<xsl:with-param name="name">Load</xsl:with-param>
				<xsl:with-param name="desc">Retrieves the record.</xsl:with-param>
				<xsl:with-param name="ismts" select="false()"/>
				<xsl:with-param name="isado" select="false()"/>
			</xsl:call-template>

			<xsl:call-template name="VBStartErrorHandler"/>
			<xsl:call-template name="VBSecuritySet"/>

			<xsl:call-template name="VBComment">
				<xsl:with-param name="value">initialize the ID if provided</xsl:with-param>
				<xsl:with-param name="indent">1</xsl:with-param>
			</xsl:call-template>
			<xsl:value-of select="concat($tab1, 'If bv', $identityfield, ' &gt; 0 Then ', $identityfield, ' = bv', $identityfield, $cr, $cr)"/>
			<xsl:value-of select="concat($tab1, 'BusnService.Fetch mDataRec, mSecurityToken', $cr, $cr)"/>

			<xsl:call-template name="VBMethodEnd">
				<xsl:with-param name="type">Sub</xsl:with-param>
				<xsl:with-param name="isado" select="false()"/>
				<xsl:with-param name="ismts" select="false()"/>
			</xsl:call-template>
		</xsl:if>

		<!--==================================================================-->
		<!-- METHOD: FETCH (CUSTOM) -->
		<!--==================================================================-->
<!--		<xsl:for-each select="WTPROCEDURES/WTPROCEDURE[(@type='Fetch') and (@template='new') and (@passthru='true')]">-->
		<xsl:for-each select="WTPROCEDURES/WTPROCEDURE[(@type='Fetch') and (@template='new')]">
			<xsl:value-of select="$cr"/>
			<xsl:call-template name="VBMethodStart">
				<xsl:with-param name="type">Sub</xsl:with-param>
				<xsl:with-param name="name" select="@name"/>
			</xsl:call-template>

			<!--input parameters-->
			<xsl:apply-templates select="WTPARAM[@direction='input' or @direction='inputoutput']" mode="inputparam">
				<xsl:with-param name="indent">1</xsl:with-param>
				<xsl:with-param name="functype">sub</xsl:with-param>
			</xsl:apply-templates>

			<xsl:call-template name="VBFunctionBox">
				<xsl:with-param name="name" select="@name"/>
				<xsl:with-param name="desc">Retrieves the record.</xsl:with-param>
				<xsl:with-param name="ismts" select="false()"/>
				<xsl:with-param name="isado" select="false()"/>
			</xsl:call-template>

			<xsl:call-template name="VBStartErrorHandler"/>

			<!--initialize data rec with inputs-->
			<xsl:apply-templates select="WTPARAM[@direction='input' or @direction='inputoutput']" mode="setparam">
				<xsl:with-param name="indent">1</xsl:with-param>
			</xsl:apply-templates>

			<xsl:value-of select="concat($tab1, 'BusnService.', @name, ' mDataRec, mSecurityToken', $cr, $cr)"/>

			<xsl:call-template name="VBMethodEnd">
				<xsl:with-param name="type">Sub</xsl:with-param>
				<xsl:with-param name="isado" select="false()"/>
				<xsl:with-param name="ismts" select="false()"/>
			</xsl:call-template>
		</xsl:for-each>

		<!--==================================================================-->
		<!-- METHOD: Check (CUSTOM) -->
		<!--==================================================================-->
		<xsl:for-each select="WTPROCEDURES/WTPROCEDURE[(@type='Check') and (@template='new') and (@passthru='true')]">
			<xsl:value-of select="$cr"/>

			<xsl:if test="count(WTPARAM[@direction='input']) = 0">
				<xsl:call-template name="VBMethodStart">
					<xsl:with-param name="type">Function</xsl:with-param>
					<xsl:with-param name="name" select="@name"/>
	 				<xsl:with-param name="noparams" select="true()"/>
				</xsl:call-template>
			</xsl:if>
			<xsl:if test="count(WTPARAM[@direction='input' or @direction='inputoutput']) > 0">
				<xsl:call-template name="VBMethodStart">
					<xsl:with-param name="type">Function</xsl:with-param>
					<xsl:with-param name="name" select="@name"/>
				</xsl:call-template>
			</xsl:if>

			<!--input parameters-->
			<xsl:apply-templates select="WTPARAM[@direction='input' or @direction='inputoutput']" mode="inputparam">
				<xsl:with-param name="indent">1</xsl:with-param>
				<xsl:with-param name="functype">function</xsl:with-param>
			</xsl:apply-templates>

			<xsl:call-template name="VBFunctionReturn">
				<xsl:with-param name="name" select="WTPARAM[@direction='output' or @direction='inputoutput']/@name"/>
				<xsl:with-param name="type" select="WTPARAM[@direction='output' or @direction='inputoutput']/@datatype"/>
			</xsl:call-template>
			<xsl:value-of select="$cr"/>

			<xsl:call-template name="VBFunctionBox">
				<xsl:with-param name="name" select="@name"/>
				<xsl:with-param name="desc">Checks a condition. </xsl:with-param>
				<xsl:with-param name="ismts" select="false()"/>
				<xsl:with-param name="isado" select="false()"/>
			</xsl:call-template>

			<xsl:call-template name="VBStartErrorHandler"/>

			<!--initialize data rec with inputs-->
			<xsl:apply-templates select="WTPARAM[@direction='input' or @direction='inputoutput']" mode="setparam">
				<xsl:with-param name="indent">1</xsl:with-param>
			</xsl:apply-templates>

			<xsl:value-of select="concat($tab1, @name, ' = BusnService.', @name, '(mDataRec, mSecurityToken)', $cr, $cr)"/>

			<xsl:call-template name="VBMethodEnd">
				<xsl:with-param name="type">Function</xsl:with-param>
				<xsl:with-param name="isado" select="false()"/>
				<xsl:with-param name="ismts" select="false()"/>
			</xsl:call-template>
		</xsl:for-each>

		<!--==================================================================-->
		<!-- METHOD: Command (CUSTOM) -->
		<!--==================================================================-->
		<xsl:for-each select="WTPROCEDURES/WTPROCEDURE[(@type='Command') and (@template='new') and (@passthru='true')]">
			<xsl:value-of select="$cr"/>

			<xsl:if test="count(WTPARAM[@direction='input']) = 0">
				<xsl:call-template name="VBMethodStart">
					<xsl:with-param name="type">Sub</xsl:with-param>
					<xsl:with-param name="name" select="@name"/>
	 				<xsl:with-param name="noparams" select="true()"/>
				</xsl:call-template>
			</xsl:if>
			<xsl:if test="count(WTPARAM[@direction='input']) > 0">
				<xsl:call-template name="VBMethodStart">
					<xsl:with-param name="type">Sub</xsl:with-param>
					<xsl:with-param name="name" select="@name"/>
				</xsl:call-template>
			</xsl:if>

			<!--input parameters-->
			<xsl:apply-templates select="WTPARAM[@direction='input']" mode="inputparam">
				<xsl:with-param name="indent">1</xsl:with-param>
				<xsl:with-param name="functype">sub</xsl:with-param>
			</xsl:apply-templates>

			<xsl:call-template name="VBFunctionBox">
				<xsl:with-param name="name" select="@name"/>
				<xsl:with-param name="desc">Executes a Command. </xsl:with-param>
				<xsl:with-param name="ismts" select="false()"/>
				<xsl:with-param name="isado" select="false()"/>
			</xsl:call-template>

			<xsl:call-template name="VBStartErrorHandler"/>

			<!--initialize data rec with inputs-->
			<xsl:apply-templates select="WTPARAM[@direction='input']" mode="setparam">
				<xsl:with-param name="indent">1</xsl:with-param>
			</xsl:apply-templates>

			<xsl:value-of select="concat($tab1, 'BusnService.', @name, ' mDataRec, mSecurityToken', $cr, $cr)"/>

			<xsl:call-template name="VBMethodEnd">				<xsl:with-param name="type">Sub</xsl:with-param>
				<xsl:with-param name="isado" select="false()"/>
				<xsl:with-param name="ismts" select="false()"/>
			</xsl:call-template>
		</xsl:for-each>

		<!--==================================================================-->
		<!-- METHOD: SAVE -->
		<!--==================================================================-->
		<xsl:if test="WTPROCEDURES/WTPROCEDURE[(@type='Update') and not(@passthru='true')]">
			<xsl:value-of select="$cr"/>
			<xsl:call-template name="VBMethodStart">
				<xsl:with-param name="type">Sub</xsl:with-param>
				<xsl:with-param name="name">Save</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="VBSecurityParam"/>
			<xsl:value-of select="concat(')', $cr)"/>

			<xsl:call-template name="VBFunctionBox">
				<xsl:with-param name="name">Save</xsl:with-param>
				<xsl:with-param name="desc">Adds or updates the record.</xsl:with-param>
				<xsl:with-param name="ismts" select="false()"/>
				<xsl:with-param name="isado" select="false()"/>
			</xsl:call-template>

			<xsl:call-template name="VBStartErrorHandler"/>
			<xsl:call-template name="VBSecuritySet"/>

			<xsl:value-of select="concat($tab1, 'BusnService.Update mDataRec, mSecurityToken', $cr, $cr)"/>
			
			<xsl:call-template name="VBMethodEnd">
				<xsl:with-param name="type">Sub</xsl:with-param>
				<xsl:with-param name="isado" select="false()"/>
				<xsl:with-param name="ismts" select="false()"/>
			</xsl:call-template>
		</xsl:if>

	 <!--==================================================================-->
	 <!-- METHOD: SAVE (CUSTOM)                                            -->
	 <!--==================================================================-->
	 <xsl:for-each select="WTPROCEDURES/WTPROCEDURE[(@type='Update') and (@template='new') and (@passthru='true')]">

		  <xsl:value-of select="$cr"/>
		  <xsl:call-template name="VBMethodStart">
				<xsl:with-param name="type">Sub</xsl:with-param>
				<xsl:with-param name="name" select="@name"/>
		  </xsl:call-template>
		  <xsl:call-template name="VBSecurityParam"/>
		  <xsl:value-of select="concat(')', $cr)"/>

		  <xsl:call-template name="VBFunctionBox">
				<xsl:with-param name="name" select="@name"/>
				<xsl:with-param name="desc">Adds or updates the record.</xsl:with-param>
				<xsl:with-param name="ismts" select="false()"/>
				<xsl:with-param name="isado" select="false()"/>
		  </xsl:call-template>

		  <xsl:call-template name="VBStartErrorHandler"/>
		  <xsl:call-template name="VBSecuritySet"/>

		  <xsl:value-of select="concat($tab1, 'BusnService.', @name, ' mDataRec, mSecurityToken', $cr, $cr)"/>
		  	 		  		
		  <xsl:call-template name="VBMethodEnd">
				<xsl:with-param name="type">Sub</xsl:with-param>
				<xsl:with-param name="isado" select="false()"/>
				<xsl:with-param name="ismts" select="false()"/>
		  </xsl:call-template>

	 </xsl:for-each>

		<!--==================================================================-->
		<!-- METHOD: Validate -->
		<!--==================================================================-->
		<xsl:value-of select="$cr"/>
		<xsl:call-template name="VBMethodStart">
			<xsl:with-param name="type">Sub</xsl:with-param>
			<xsl:with-param name="name">Validate</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="VBParam">
			<xsl:with-param name="name">New</xsl:with-param>
			<xsl:with-param name="type">yesno</xsl:with-param>
			<xsl:with-param name="optional" select="true()"/>
			<xsl:with-param name="default">0</xsl:with-param>
			<xsl:with-param name="continue" select="true()"/>
		</xsl:call-template>
		<xsl:call-template name="VBSecurityParam"/>
		<xsl:value-of select="concat(')', $cr)"/>

		<xsl:call-template name="VBFunctionBox">
			<xsl:with-param name="name">Validate</xsl:with-param>
			<xsl:with-param name="desc">Validates the record.</xsl:with-param>
			<xsl:with-param name="ismts" select="false()"/>
			<xsl:with-param name="isado" select="false()"/>
		</xsl:call-template>

		<xsl:call-template name="VBStartErrorHandler"/>
		<xsl:call-template name="VBSecuritySet"/>

		<xsl:value-of select="concat($tab1, 'BusnService.Validate mDataRec, mSecurityToken, bvNew', $cr, $cr)"/>
		
		<xsl:call-template name="VBMethodEnd">
			<xsl:with-param name="type">Sub</xsl:with-param>
			<xsl:with-param name="isado" select="false()"/>
			<xsl:with-param name="ismts" select="false()"/>
		</xsl:call-template>

		<!--==================================================================-->
		<!-- METHOD: XML -->
		<!--==================================================================-->
		<xsl:value-of select="$cr"/>
		<xsl:call-template name="VBMethodStart">
			<xsl:with-param name="type">Function</xsl:with-param>
			<xsl:with-param name="name">XML</xsl:with-param>
			<xsl:with-param name="noparams" select="false()"/>
		</xsl:call-template>

		<xsl:value-of select="concat('   Optional ByVal bvOption As Integer = 1000, _', $cr)"/>
		<xsl:value-of select="concat('   Optional ByVal bvElementName As String = &quot;', $entityname, '&quot;)')"/>

		<xsl:call-template name="VBDataType">
			<xsl:with-param name="datatype">text</xsl:with-param>
		</xsl:call-template>
		<xsl:value-of select="$cr"/>

		<xsl:call-template name="VBFunctionBox">
			<xsl:with-param name="name">XML</xsl:with-param>
			<xsl:with-param name="desc">Returns the XML for the item.</xsl:with-param>
			<xsl:with-param name="ismts" select="false()"/>
			<xsl:with-param name="isado" select="false()"/>
		</xsl:call-template>

		<xsl:if test="count($labels)&gt;0">
	 	  <xsl:value-of select="concat($tab1, 'Dim oLabels As ', $appprefix, 'LabelUser.CLabels', $cr)"/>
		</xsl:if>

		<xsl:for-each select="$attrlookups">
			<xsl:apply-templates select="WTLOOKUP" mode="declare">
				<xsl:with-param name="indent">1</xsl:with-param>
			</xsl:apply-templates>
		</xsl:for-each>

		<xsl:if test="count($labels)&gt;0">
	 		<xsl:value-of select="concat($tab1, 'Dim oLabel As ', $appprefix, 'LabelUser.CLabel', $cr)"/>
		</xsl:if>

		<xsl:if test="count($attrInputOptions)&gt;0">
	 		<xsl:value-of select="concat($tab1, 'Dim oInputOptions As wtSystem.CInputOptions', $cr)"/>
		</xsl:if>

		<xsl:call-template name="VBVariable">
			<xsl:with-param name="indent">1</xsl:with-param>
			<xsl:with-param name="scope">Dim</xsl:with-param>
			<xsl:with-param name="name">sChildren</xsl:with-param>
			<xsl:with-param name="type">text</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="VBVariable">
			<xsl:with-param name="indent">1</xsl:with-param>
			<xsl:with-param name="scope">Dim</xsl:with-param>
			<xsl:with-param name="name">sAttributes</xsl:with-param>
			<xsl:with-param name="type">text</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="VBVariable">
			<xsl:with-param name="indent">1</xsl:with-param>
			<xsl:with-param name="scope">Dim</xsl:with-param>
			<xsl:with-param name="name">sValue</xsl:with-param>
			<xsl:with-param name="type">text</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="VBVariable">
			<xsl:with-param name="indent">1</xsl:with-param>
			<xsl:with-param name="scope">Dim</xsl:with-param>
			<xsl:with-param name="name">sOption</xsl:with-param>
			<xsl:with-param name="type">text</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="VBVariable">
			<xsl:with-param name="indent">1</xsl:with-param>
			<xsl:with-param name="scope">Dim</xsl:with-param>
			<xsl:with-param name="name">bLookup</xsl:with-param>
			<xsl:with-param name="type">yesno</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="VBVariable">
			<xsl:with-param name="indent">1</xsl:with-param>
			<xsl:with-param name="scope">Dim</xsl:with-param>
			<xsl:with-param name="name">bFilter</xsl:with-param>
			<xsl:with-param name="type">yesno</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="VBVariable">
			<xsl:with-param name="indent">1</xsl:with-param>
			<xsl:with-param name="scope">Dim</xsl:with-param>
			<xsl:with-param name="name">bStatic</xsl:with-param>
			<xsl:with-param name="type">yesno</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="VBVariable">
			<xsl:with-param name="indent">1</xsl:with-param>
			<xsl:with-param name="scope">Dim</xsl:with-param>
			<xsl:with-param name="name">bAttrib</xsl:with-param>
			<xsl:with-param name="type">yesno</xsl:with-param>
		</xsl:call-template>
		<xsl:value-of select="$cr"/>

		<xsl:call-template name="VBStartErrorHandler"/>

		<xsl:value-of select="concat($tab1, $apos, 'Handle Common Options for item classes', $cr)"/>
		<xsl:value-of select="concat($tab1, 'Select Case bvOption', $cr)"/>
		<xsl:value-of select="concat($tab2, 'Case 2: bvOption = 1111    ', $apos, ' attributes with all enums', $cr)"/>
		<xsl:value-of select="concat($tab2, 'Case 3: bvOption = 1001    ', $apos, ' attributes with static enums only', $cr)"/>
		<xsl:value-of select="concat($tab1, 'End Select', $cr)"/>
		<xsl:value-of select="concat($tab1, 'sOption = Format(bvOption, &quot;0000&quot;)', $cr)"/>
		<xsl:value-of select="concat($tab1, 'bAttrib = (Mid(sOption, 1, 1) = &quot;1&quot;)', $cr)"/>
		<xsl:value-of select="concat($tab1, 'bFilter = (Mid(sOption, 2, 1) = &quot;1&quot;)', $cr)"/>
		<xsl:value-of select="concat($tab1, 'bLookup = (Mid(sOption, 3, 1) = &quot;1&quot;)', $cr)"/>
		<xsl:value-of select="concat($tab1, 'bStatic = (Mid(sOption, 4, 1) = &quot;1&quot;)', $cr, $cr)"/>

		<xsl:call-template name="VBComment">
			<xsl:with-param name="value">create the XML for the children</xsl:with-param>
			<xsl:with-param name="indent">1</xsl:with-param>
		</xsl:call-template>
		<xsl:value-of select="concat($tab1, 'sChildren = &quot;&quot;', $cr)"/>

		<!-- Get all the lookup lists that are not filtered (i.e. the same for every record) -->
		<xsl:if test="$attrlookupsNotFiltered">
			<xsl:value-of select="concat($tab1, 'If bLookup Then')"/>
			<xsl:for-each select="$attrlookupsNotFiltered">
				<xsl:value-of select="$cr"/>
				<xsl:apply-templates select="WTLOOKUP" mode="create">
					<xsl:with-param name="indent">2</xsl:with-param>
				</xsl:apply-templates>
				
				<xsl:value-of select="concat($tab2, 'With o', @name, $cr)"/>
				<xsl:value-of select="concat($tab3, '.SysCurrentLanguage = mCurrentLanguage', $cr)"/>
				<xsl:if test="/Data/WTPAGE/@multi-instance">
					<xsl:value-of select="concat($tab3, '.SysClientProject mClient, mProject', $cr)"/>
				</xsl:if>
				<xsl:apply-templates select="WTLOOKUP" mode="enumerate">
					<xsl:with-param name="indent">3</xsl:with-param>
				</xsl:apply-templates>
				<xsl:value-of select="concat($tab2, 'End With', $cr)"/>
				
				<xsl:apply-templates select="WTLOOKUP" mode="destroy">
					<xsl:with-param name="indent">2</xsl:with-param>
				</xsl:apply-templates>
			</xsl:for-each>
			<xsl:value-of select="concat($cr, $tab1, 'End If', $cr)"/>
		</xsl:if>

		<!-- Get all the ENUM lookup lists (they are the same for every record) -->
		<xsl:value-of select="concat($tab1, 'If bStatic Then')"/>
		<xsl:for-each select="$attrenums">
			<xsl:value-of select="$cr"/>
			<xsl:apply-templates select="." mode="enumerate">
				<xsl:with-param name="indent">2</xsl:with-param>
			</xsl:apply-templates>
		</xsl:for-each>
		<xsl:value-of select="concat($cr, $tab1, 'End If', $cr)"/>

		<!-- Get all the lookup lists that are filtered (i.e. have more than 1 WTPARAM) -->
		<xsl:if test="$attrlookupsFiltered">
			<xsl:value-of select="concat($tab1, 'If bFilter Then', $cr)"/>
			<xsl:for-each select="$attrlookupsFiltered">
				<xsl:value-of select="$cr"/>
				<xsl:apply-templates select="WTLOOKUP" mode="create">
					<xsl:with-param name="indent">2</xsl:with-param>
				</xsl:apply-templates>
				
				<xsl:value-of select="concat($tab2, 'With o', @name, $cr)"/>
				<xsl:value-of select="concat($tab3, '.SysCurrentLanguage = mCurrentLanguage', $cr)"/>
				<xsl:if test="/Data/WTPAGE/@multi-instance">
					<xsl:value-of select="concat($tab3, '.SysClientProject mClient, mProject', $cr)"/>
				</xsl:if>
				<xsl:apply-templates select="WTLOOKUP" mode="enumerate">
					<xsl:with-param name="indent">3</xsl:with-param>
				</xsl:apply-templates>
				<xsl:value-of select="concat($tab2, 'End With', $cr)"/>
				
				<xsl:apply-templates select="WTLOOKUP" mode="destroy">
					<xsl:with-param name="indent">2</xsl:with-param>
				</xsl:apply-templates>
			</xsl:for-each>
			<xsl:value-of select="concat($cr, $tab1, 'End If', $cr)"/>
		</xsl:if>

		<!-- Get InputOptions list -->
		<xsl:if test="$attrInputOptions">
			<xsl:value-of select="concat($tab1, 'If bFilter Then', $cr)"/>
			<xsl:for-each select="$attrInputOptions">
				<xsl:value-of select="concat($tab2, 'Set oInputOptions = New wtSystem.CInputOptions', $cr)"/>
				<xsl:value-of select="concat($tab2, 'oInputOptions.Load ', @name, ', ', WTINPUTOPTIONS/@values, $cr)"/>
				<xsl:value-of select="concat($tab2, 'sChildren = sChildren + oInputOptions.XML(&quot;', @name, '&quot;)', $cr)"/>
				<xsl:value-of select="concat($tab2, 'Set oInputOptions = Nothing', $cr)"/>
			</xsl:for-each>
			<xsl:value-of select="concat($tab1, 'End If', $cr)"/>
		</xsl:if>

		<xsl:if test="count($labels)&gt;0">
		  <xsl:value-of select="$cr"/>
		  <xsl:value-of select="concat($tab1, 'If cDefaultLanguage &lt;&gt; mCurrentLanguage Then', $cr)"/>
		  <xsl:value-of select="concat($tab2, 'Set oLabels = New ', $appprefix, 'LabelUser.CLabels', $cr)"/>
		  <xsl:value-of select="concat($tab2, 'With oLabels', $cr)"/>
			<xsl:if test="/Data/WTPAGE/@multi-instance">
				<xsl:value-of select="concat($tab3, '.SysClientProject mClient, mProject', $cr)"/>
			</xsl:if>
		  
	 		<xsl:if test="$entitylabels">
				<xsl:value-of select="concat($tab3, '.ListAttribute cEntityID, ', $identity, ' , mCurrentLanguage', $cr)"/>
	 			<xsl:for-each select="$entitylabels">
					 <xsl:value-of select="concat($tab3, 'Set oLabel = .SearchAttributeID(', @id, ')', $cr)"/>
					 <xsl:value-of select="concat($tab3, 'If Not (oLabel Is Nothing) Then', $cr)"/>
					 <xsl:value-of select="concat($tab4, @name, ' = oLabel.Text', $cr)"/>
					 <xsl:value-of select="concat($tab3, 'End If', $cr)"/>
					 <xsl:value-of select="concat($tab3, 'Set oLabel = Nothing', $cr)"/>
	 			</xsl:for-each>
	 		</xsl:if>
	 		
	 		<xsl:for-each select="$joinlabels">
	 			<xsl:variable name="join"><xsl:call-template name="GetJoinLabel"/></xsl:variable>
				<xsl:value-of select="concat($tab3, '.ListLabel ', $join, ', ', @language, ' , mCurrentLanguage', $cr)"/>
				<xsl:value-of select="concat($tab3, 'If .Count > 0 Then', $cr)"/>
				<xsl:value-of select="concat($tab4, 'Set oLabel = .Item(1)', $cr)"/>
				<xsl:value-of select="concat($tab4, 'If Not (oLabel Is Nothing) Then', $cr)"/>
				<xsl:value-of select="concat($tab5, @name, ' = oLabel.Text', $cr)"/>
				<xsl:value-of select="concat($tab4, 'End If', $cr)"/>
				<xsl:value-of select="concat($tab4, 'Set oLabel = Nothing', $cr)"/>
				<xsl:value-of select="concat($tab3, 'End If', $cr)"/>
	 		</xsl:for-each>
		  
		  <xsl:value-of select="concat($tab2, 'End With', $cr)"/>
		  <xsl:value-of select="concat($tab2, 'Set oLabels = Nothing', $cr)"/>
		  <xsl:value-of select="concat($tab1, 'End If', $cr, $cr)"/>
		</xsl:if>

		<xsl:call-template name="VBComment">
			<xsl:with-param name="value">create the XML for the attributes</xsl:with-param>
			<xsl:with-param name="indent">1</xsl:with-param>
		</xsl:call-template>
		<xsl:value-of select="concat($tab1, 'sAttributes = &quot;&quot;', $cr, $cr)"/>

		<xsl:value-of select="concat($tab1, 'If bAttrib Then', $cr)"/>

		<xsl:for-each select="WTATTRIBUTE[not(@xml='false')]">

			<xsl:variable name="name">
				<xsl:choose>
					<xsl:when test="@name"><xsl:value-of select="@name"/></xsl:when>
					<xsl:otherwise><xsl:value-of select="@value"/></xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			<xsl:variable name="aname">
				<xsl:choose>
					<xsl:when test="@alias"><xsl:value-of select="@alias"/></xsl:when>
					<xsl:when test="@name"><xsl:value-of select="@name"/></xsl:when>
					<xsl:otherwise><xsl:value-of select="@value"/></xsl:otherwise>
				</xsl:choose>
			</xsl:variable>

			<xsl:variable name="fmt">
				<xsl:choose>
					<xsl:when test="WTFORMAT/@round">
						<xsl:value-of select="concat('Round(IIf(IsNumeric(', @name, '),', @name, ',0)*', WTFORMAT/@round, ',0)/', WTFORMAT/@round)"/>
					</xsl:when>
					<xsl:when test="WTFORMAT">
	 					<xsl:if test="WTFORMAT/@zero">
	 						<xsl:value-of select="concat('IIf( ', @name, '=&quot;0&quot;,')"/>
							<xsl:value-of select="concat('Format$(', @name, ', &quot;', WTFORMAT/@zero, '&quot;)')"/>
	 						<xsl:value-of select="','"/>
	 					</xsl:if>

            <xsl:if test="WTFORMAT/@value">
              <xsl:value-of select="concat('Format$(', @name )"/>
              <xsl:if test="WTFORMAT/@convert">
                <xsl:value-of select="WTFORMAT/@convert"/>
              </xsl:if>
              <xsl:value-of select="concat(', &quot;', WTFORMAT/@value, '&quot;)')"/>
              <xsl:if test="WTFORMAT/@zero">
                <xsl:value-of select="')'"/>
              </xsl:if>
            </xsl:if>
            <xsl:if test="not(WTFORMAT/@value)">
              <xsl:if test="WTFORMAT/@convert">
                <xsl:value-of select="@name"/>
                <xsl:value-of select="WTFORMAT/@convert"/>
              </xsl:if>
            </xsl:if>
          </xsl:when>
					<xsl:when test="@type='date'"><xsl:value-of select="concat('Format$(', @name, ', &quot;m/d/yyyy&quot;)')"/></xsl:when>
					<xsl:when test="@type='currency'"><xsl:value-of select="concat('Format$(', @name, ', &quot;currency&quot;)')"/></xsl:when>
					<xsl:otherwise><xsl:value-of select="@name"/></xsl:otherwise>
				</xsl:choose>
			</xsl:variable>

			<!--==========handle date properties differently (check for no date)==========-->
			<xsl:choose>
				<xsl:when test="@embedhtml">
					<xsl:value-of select="concat($tab2, 'If (Len(', $name, ') &gt; 0) Then sChildren = sChildren + XMLElement(&quot;', $aname, '&quot;, &quot;&quot;, &quot;&lt;!-- &quot; + Replace(' @name, ', &quot;--&quot;, &quot;- &quot;) + &quot; --&gt;&quot;, &quot;&quot;)', $cr)"/>
				</xsl:when>
				<xsl:when test="@type='date'">
					<xsl:value-of select="concat($tab2, 'If (Len(', $name, ') &gt; 0) And (', $name, ' &lt;&gt; &quot;0&quot;) Then sAttributes = sAttributes + XMLAttribute(&quot;', $aname, '&quot;, ', $fmt, ', False)', $cr)"/>
				</xsl:when>
<!--				
				<xsl:when test="@type='date'">
					<xsl:value-of select="concat($tab2, 'If (', @name, ' = &quot;0&quot;) Then', $cr)"/>
					<xsl:value-of select="concat($tab3, 'sAttributes = sAttributes + XMLAttribute(&quot;', @name, '&quot;, &quot;&quot;, True)', $cr)"/>
					<xsl:value-of select="concat($tab2, 'Else', $cr)"/>
					<xsl:value-of select="concat($tab3, 'sAttributes = sAttributes + XMLAttribute(&quot;', @name, '&quot;, ', $fmt, ', True)', $cr)"/>
					<xsl:value-of select="concat($tab2, 'End If', $cr)"/>
				</xsl:when>
-->				
				<xsl:otherwise>
					<xsl:value-of select="concat($tab2, 'If (Len(', $name, ') &gt; 0) Then sAttributes = sAttributes + XMLAttribute(&quot;', $aname, '&quot;, ', $fmt, ', False)', $cr)"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>

		<xsl:value-of select="concat($tab1, 'End If', $cr)"/>

		<xsl:call-template name="VBComment">
			<xsl:with-param name="value">create the XML for the value</xsl:with-param>
			<xsl:with-param name="indent">1</xsl:with-param>
		</xsl:call-template>
		<xsl:value-of select="concat($tab1, 'sValue = &quot;&quot;', $cr, $cr)"/>

		<xsl:call-template name="VBComment">
			<xsl:with-param name="value">create the XML for the object</xsl:with-param>
			<xsl:with-param name="indent">1</xsl:with-param>
		</xsl:call-template>

		<xsl:value-of select="concat($tab1, 'If bAttrib Then', $cr)"/>
		<xsl:value-of select="concat($tab2, 'XML = XMLElement(&quot;',  $appprefix, '&quot; + bvElementName, sAttributes, sValue, sChildren)', $cr)"/>
		<xsl:value-of select="concat($tab1, 'Else', $cr)"/>
		<xsl:value-of select="concat($tab2, 'XML = sChildren', $cr)"/>
		<xsl:value-of select="concat($tab1, 'End If', $cr, $cr)"/>

		<xsl:call-template name="VBMethodEnd">
			<xsl:with-param name="type">Function</xsl:with-param>
			<xsl:with-param name="isado" select="false()"/>
			<xsl:with-param name="ismts" select="false()"/>
		</xsl:call-template>

		<!--==================================================================-->
		<!-- METHOD: CUSTOM XML -->
		<!--==================================================================-->
		<xsl:for-each select="/Data/WTENTITY/WTPROCEDURES/WTPROCEDURE[@type='XML']">
			<xsl:choose>
				<xsl:when test="@options"><xsl:call-template name="CustomXMLOptions"/></xsl:when>
				<xsl:otherwise><xsl:call-template name="CustomXML"/></xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>

		<!--==================================================================-->
		<!-- PROPERTY: GET DATAREC -->
		<!--==================================================================-->
		<xsl:value-of select="$cr"/>
		<xsl:call-template name="VBMethodStart">
			<xsl:with-param name="scope">Friend</xsl:with-param>
			<xsl:with-param name="type">Property Get</xsl:with-param>
			<xsl:with-param name="name">DataRec</xsl:with-param>
			<xsl:with-param name="noparams" select="true()"/>
		</xsl:call-template>

		<xsl:call-template name="VBDataType">
			<xsl:with-param name="datatype">busnrecord</xsl:with-param>
		</xsl:call-template>

		<xsl:value-of select="$cr"/>

		<xsl:call-template name="VBFunctionBox">
			<xsl:with-param name="name">DataRec_Get</xsl:with-param>
			<xsl:with-param name="desc">Returns the value of the attribute.</xsl:with-param>
			<xsl:with-param name="ismts" select="false()"/>
			<xsl:with-param name="isado" select="false()"/>
		</xsl:call-template>

		<xsl:call-template name="VBStartErrorHandler"/>
			
		<xsl:value-of select="concat($tab1, 'DataRec = mDataRec', $cr, $cr)"/>

		<xsl:call-template name="VBMethodEnd">
			<xsl:with-param name="type">Property Get</xsl:with-param>
			<xsl:with-param name="isado" select="false()"/>
			<xsl:with-param name="ismts" select="false()"/>
		</xsl:call-template>

		<!--==================================================================-->
		<!-- PROPERTY: LET DATAREC -->
		<!--==================================================================-->
		<xsl:value-of select="$cr"/>
		<xsl:call-template name="VBMethodStart">
			<xsl:with-param name="scope">Friend</xsl:with-param>
			<xsl:with-param name="type">Property Let</xsl:with-param>
			<xsl:with-param name="name">DataRec</xsl:with-param>
		</xsl:call-template>

		<xsl:call-template name="VBParam">
			<xsl:with-param name="name">DataRec</xsl:with-param>
			<xsl:with-param name="type">busnrecord</xsl:with-param>
			<xsl:with-param name="continue" select="false()"/>
		</xsl:call-template>

		<xsl:value-of select="concat(')', $cr)"/>

		<xsl:call-template name="VBFunctionBox">
			<xsl:with-param name="name">DataRec_Let</xsl:with-param>
			<xsl:with-param name="desc">Sets the value of the attribute.</xsl:with-param>
			<xsl:with-param name="ismts" select="false()"/>
			<xsl:with-param name="isado" select="false()"/>
		</xsl:call-template>

		<xsl:call-template name="VBStartErrorHandler"/>
			
		<xsl:value-of select="concat($tab1, 'mDataRec = brDataRec', $cr, $cr)"/>

		<xsl:call-template name="VBMethodEnd">
			<xsl:with-param name="type">Property Let</xsl:with-param>
			<xsl:with-param name="isado" select="false()"/>
			<xsl:with-param name="ismts" select="false()"/>
		</xsl:call-template>

			<xsl:value-of select="$cr"/>
			<xsl:value-of select="concat($tab0, 'Public Property Let SysCurrentLanguage(ByVal bvLanguage As String)', $cr)"/>
			<xsl:value-of select="concat($tab1, 'mCurrentLanguage = bvLanguage', $cr)"/>
			<xsl:value-of select="concat($tab0, 'End Property', $cr, $cr)"/>

		<!--==================================================================-->
		<!-- PROPERTY: EACH OBJECT ATTRIBUTE GET/LET -->
		<!--==================================================================-->
		<xsl:for-each select="WTATTRIBUTE">
			<xsl:call-template name="VBProperty">
				<xsl:with-param name="name" select="@name"/>
				<xsl:with-param name="type">text</xsl:with-param>
				<xsl:with-param name="islet" select="not(WTCOMPUTE)"/>
				<xsl:with-param name="isdate" select="(@type='date')"/>
			</xsl:call-template>
		</xsl:for-each>

		  <xsl:value-of select="$cr"/>
		  <xsl:value-of select="concat($tab0, 'Private Sub Class_Initialize()', $cr)"/>
		  <xsl:value-of select="concat($tab1, 'mCurrentLanguage = cDefaultLanguage', $cr)"/>
		  <xsl:value-of select="concat($tab0, 'End Sub', $cr)"/>

	 </xsl:template>
	 	
		<!--===============================================================================================-->
	 <xsl:template name="GetJoinLabel">

		  <xsl:variable name="entity" select="WTJOIN/@entity"/> 
		  <xsl:variable name="attribute" select="WTJOIN/@name"/>
		  <xsl:variable name="entityid" select="/Data/WTLABELS/LABEL[@entity=$entity and @attribute=$attribute]/@entityid"/> 
		  <xsl:variable name="attributeid" select="/Data/WTLABELS/LABEL[@entity=$entity and @attribute=$attribute]/@attributeid"/> 
	 
		  <!-- ***************** Error Checking *******************-->
		  <xsl:if test="not($entityid)">
		      <xsl:call-template name="Error">
		      	<xsl:with-param name="msg" select="'Dynamic Label Entity Missing'"/>
		      	<xsl:with-param name="text" select="$entity"/>
		      </xsl:call-template>
		  </xsl:if>
		  <xsl:if test="not($attributeid)">
		      <xsl:call-template name="Error">
		      	<xsl:with-param name="msg" select="'Dynamic Label Attribute Missing'"/>
		      	<xsl:with-param name="text" select="$attribute"/>
		      </xsl:call-template>
		  </xsl:if>
		  <!-- ****************************************************-->

		<xsl:value-of select="concat($entityid, ', ', $attributeid)"/>

	</xsl:template>
	
	<xsl:template name="CustomXMLOptions">
		<!--==================================================================-->
		<!-- METHOD: CUSTOM XML with XML Options-->
		<!--==================================================================-->
		<xsl:value-of select="$cr"/>

		<xsl:call-template name="VBMethodStart">
			<xsl:with-param name="type">Function</xsl:with-param>
			<xsl:with-param name="name" select="@name"/>
			<xsl:with-param name="noparams" select="false()"/>
		</xsl:call-template>

		<xsl:value-of select="concat('   Optional ByVal bvOption As Integer = 1000, _', $cr)"/>
		<xsl:value-of select="concat('   Optional ByVal bvElementName As String = &quot;', $entityname, '&quot;)')"/>

		<xsl:call-template name="VBDataType">
			<xsl:with-param name="datatype">text</xsl:with-param>
		</xsl:call-template>
		<xsl:value-of select="$cr"/>

		<xsl:call-template name="VBFunctionBox">
			<xsl:with-param name="name" select="@name"/>
			<xsl:with-param name="desc">Returns the XML for the item.</xsl:with-param>
			<xsl:with-param name="ismts" select="false()"/>
			<xsl:with-param name="isado" select="false()"/>
		</xsl:call-template>

		<xsl:for-each select="WTATTRIBUTE">
			<xsl:variable name="name">
				<xsl:choose>
					 <xsl:when test="@name"><xsl:value-of select="@name"/></xsl:when>
					 <xsl:otherwise><xsl:value-of select="@value"/></xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			<xsl:for-each select="/Data/WTENTITY/WTATTRIBUTE[@name=$name and WTLOOKUP]">
				<xsl:apply-templates select="WTLOOKUP" mode="declare">
					<xsl:with-param name="indent">1</xsl:with-param>
				</xsl:apply-templates>
			</xsl:for-each>
		</xsl:for-each>

		<xsl:if test="WTINPUTOPTIONS">
	 		<xsl:value-of select="concat($tab1, 'Dim oInputOptions As wtSystem.CInputOptions', $cr)"/>
		</xsl:if>

		<xsl:call-template name="VBVariable">
			<xsl:with-param name="indent">1</xsl:with-param>
			<xsl:with-param name="scope">Dim</xsl:with-param>
			<xsl:with-param name="name">sChildren</xsl:with-param>
			<xsl:with-param name="type">text</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="VBVariable">
			<xsl:with-param name="indent">1</xsl:with-param>
			<xsl:with-param name="scope">Dim</xsl:with-param>
			<xsl:with-param name="name">sAttributes</xsl:with-param>
			<xsl:with-param name="type">text</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="VBVariable">
			<xsl:with-param name="indent">1</xsl:with-param>
			<xsl:with-param name="scope">Dim</xsl:with-param>
			<xsl:with-param name="name">sValue</xsl:with-param>
			<xsl:with-param name="type">text</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="VBVariable">
			<xsl:with-param name="indent">1</xsl:with-param>
			<xsl:with-param name="scope">Dim</xsl:with-param>
			<xsl:with-param name="name">sOption</xsl:with-param>
			<xsl:with-param name="type">text</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="VBVariable">
			<xsl:with-param name="indent">1</xsl:with-param>
			<xsl:with-param name="scope">Dim</xsl:with-param>
			<xsl:with-param name="name">bLookup</xsl:with-param>
			<xsl:with-param name="type">yesno</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="VBVariable">
			<xsl:with-param name="indent">1</xsl:with-param>
			<xsl:with-param name="scope">Dim</xsl:with-param>
			<xsl:with-param name="name">bFilter</xsl:with-param>
			<xsl:with-param name="type">yesno</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="VBVariable">
			<xsl:with-param name="indent">1</xsl:with-param>
			<xsl:with-param name="scope">Dim</xsl:with-param>
			<xsl:with-param name="name">bStatic</xsl:with-param>
			<xsl:with-param name="type">yesno</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="VBVariable">
			<xsl:with-param name="indent">1</xsl:with-param>
			<xsl:with-param name="scope">Dim</xsl:with-param>
			<xsl:with-param name="name">bAttrib</xsl:with-param>
			<xsl:with-param name="type">yesno</xsl:with-param>
		</xsl:call-template>
		  
		<xsl:value-of select="$cr"/>

		<xsl:call-template name="VBStartErrorHandler"/>

		<xsl:value-of select="concat($tab1, $apos, 'Handle Common Options for item classes', $cr)"/>
		<xsl:value-of select="concat($tab1, 'Select Case bvOption', $cr)"/>
		<xsl:value-of select="concat($tab2, 'Case 2: bvOption = 1111    ', $apos, ' attributes with all enums', $cr)"/>
		<xsl:value-of select="concat($tab2, 'Case 3: bvOption = 1001    ', $apos, ' attributes with static enums only', $cr)"/>
		<xsl:value-of select="concat($tab1, 'End Select', $cr)"/>
		<xsl:value-of select="concat($tab1, 'sOption = Format(bvOption, &quot;0000&quot;)', $cr)"/>
		<xsl:value-of select="concat($tab1, 'bAttrib = (Mid(sOption, 1, 1) = &quot;1&quot;)', $cr)"/>
		<xsl:value-of select="concat($tab1, 'bFilter = (Mid(sOption, 2, 1) = &quot;1&quot;)', $cr)"/>
		<xsl:value-of select="concat($tab1, 'bLookup = (Mid(sOption, 3, 1) = &quot;1&quot;)', $cr)"/>
		<xsl:value-of select="concat($tab1, 'bStatic = (Mid(sOption, 4, 1) = &quot;1&quot;)', $cr, $cr)"/>

		<xsl:call-template name="VBComment">
			<xsl:with-param name="value">create the XML for the children</xsl:with-param>
			<xsl:with-param name="indent">1</xsl:with-param>
		</xsl:call-template>
		<xsl:value-of select="concat($tab1, 'sChildren = &quot;&quot;', $cr)"/>

		<!-- Get all the lookup lists that are not filtered (i.e. the same for every record) -->
		<xsl:value-of select="concat($tab1, 'If bLookup Then')"/>
				
		<xsl:for-each select="WTATTRIBUTE">
			<xsl:variable name="name">
				<xsl:choose>
					<xsl:when test="@name"><xsl:value-of select="@name"/></xsl:when>
					<xsl:otherwise><xsl:value-of select="@value"/></xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			<xsl:for-each select="/Data/WTENTITY/WTATTRIBUTE[@name=$name and WTLOOKUP][count(WTLOOKUP/WTPARAM)&lt;=1]">
				<xsl:value-of select="$cr"/>
				<xsl:apply-templates select="WTLOOKUP" mode="create">
					<xsl:with-param name="indent">2</xsl:with-param>
				</xsl:apply-templates>
									
				<xsl:value-of select="concat($tab2, 'With o', @name, $cr)"/>
				<xsl:value-of select="concat($tab3, '.SysCurrentLanguage = mCurrentLanguage', $cr)"/>
				<xsl:if test="/Data/WTPAGE/@multi-instance">
					<xsl:value-of select="concat($tab3, '.SysClientProject mClient, mProject', $cr)"/>
				</xsl:if>
				<xsl:apply-templates select="WTLOOKUP" mode="enumerate">
					<xsl:with-param name="indent">3</xsl:with-param>
				</xsl:apply-templates>
				<xsl:value-of select="concat($tab2, 'End With', $cr)"/>
									
				<xsl:apply-templates select="WTLOOKUP" mode="destroy">
					<xsl:with-param name="indent">2</xsl:with-param>
				</xsl:apply-templates>
			</xsl:for-each>
		</xsl:for-each>

		<!-- Get all the ENUM lookup lists (they are the same for every record) -->
		<xsl:value-of select="concat($cr, $tab1, 'End If', $cr)"/>
		<xsl:value-of select="concat($tab1, 'If bStatic Then')"/>
		<xsl:for-each select="WTATTRIBUTE">
			<xsl:variable name="name">
				<xsl:choose>
					 <xsl:when test="@name"><xsl:value-of select="@name"/></xsl:when>
					 <xsl:otherwise><xsl:value-of select="@value"/></xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			<xsl:for-each select="/Data/WTENTITY/WTATTRIBUTE[@name=$name and WTENUM]">
				<xsl:value-of select="$cr"/>
				<xsl:apply-templates select="." mode="enumerate">
					<xsl:with-param name="indent">2</xsl:with-param>
				</xsl:apply-templates>
			</xsl:for-each>
		</xsl:for-each>
		<xsl:value-of select="concat($cr, $tab1, 'End If', $cr)"/>

		<!-- Get all the lookup lists that are filtered (i.e. have more than 1 WTPARAM) -->
		<xsl:value-of select="concat($tab1, 'If bFilter Then', $cr)"/>
		<xsl:for-each select="WTATTRIBUTE">
			<xsl:variable name="name">
				<xsl:choose>
					 <xsl:when test="@name"><xsl:value-of select="@name"/></xsl:when>
					 <xsl:otherwise><xsl:value-of select="@value"/></xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			<xsl:for-each select="/Data/WTENTITY/WTATTRIBUTE[@name=$name and WTLOOKUP][count(WTLOOKUP/WTPARAM)&gt;1]">
				<xsl:value-of select="$cr"/>
				<xsl:apply-templates select="WTLOOKUP" mode="create">
					<xsl:with-param name="indent">2</xsl:with-param>
				</xsl:apply-templates>
					
				<xsl:value-of select="concat($tab2, 'With o', @name, $cr)"/>
				<xsl:value-of select="concat($tab3, '.SysCurrentLanguage = mCurrentLanguage', $cr)"/>
				<xsl:if test="/Data/WTPAGE/@multi-instance">
					<xsl:value-of select="concat($tab3, '.SysClientProject mClient, mProject', $cr)"/>
				</xsl:if>
				<xsl:apply-templates select="WTLOOKUP" mode="enumerate">
					<xsl:with-param name="indent">3</xsl:with-param>
				</xsl:apply-templates>
				<xsl:value-of select="concat($tab2, 'End With', $cr)"/>
					
				<xsl:apply-templates select="WTLOOKUP" mode="destroy">
					<xsl:with-param name="indent">2</xsl:with-param>
				</xsl:apply-templates>
			</xsl:for-each>
		</xsl:for-each>

		<!-- Get InputOptions list -->
		<xsl:if test="WTINPUTOPTIONS">
			<xsl:for-each select="WTINPUTOPTIONS">
				<xsl:value-of select="concat($tab2, 'Set oInputOptions = New wtSystem.CInputOptions', $cr)"/>
				<xsl:value-of select="concat($tab2, 'oInputOptions.Load ', @name, ', ', @values, $cr)"/>
				<xsl:value-of select="concat($tab2, 'sChildren = sChildren + oInputOptions.XML(&quot;', @name, '&quot;)', $cr)"/>
				<xsl:value-of select="concat($tab2, 'Set oInputOptions = Nothing', $cr)"/>
			</xsl:for-each>
		</xsl:if>

		<xsl:value-of select="concat($tab1, 'End If', $cr, $cr)"/>

		<xsl:call-template name="CustomLabels"/>

		<xsl:call-template name="VBComment">
		  	<xsl:with-param name="value">create the XML for the attributes</xsl:with-param>
		  	<xsl:with-param name="indent">1</xsl:with-param>
		</xsl:call-template>
		<xsl:value-of select="concat($tab1, 'sAttributes = &quot;&quot;', $cr)"/>

		<xsl:value-of select="concat($tab1, 'If bAttrib Then', $cr)"/>
		<xsl:for-each select="WTATTRIBUTE">
			<xsl:variable name="name">
				<xsl:choose>
					<xsl:when test="@name"><xsl:value-of select="@name"/></xsl:when>
					<xsl:otherwise><xsl:value-of select="@value"/></xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			<xsl:variable name="aname">
				<xsl:choose>
					<xsl:when test="@alias"><xsl:value-of select="@alias"/></xsl:when>
					<xsl:when test="@name"><xsl:value-of select="@name"/></xsl:when>
					<xsl:otherwise><xsl:value-of select="@value"/></xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			<xsl:variable name="datatype" select="/Data/WTENTITY/WTATTRIBUTE[@name=$name]/@type"/>
			<xsl:variable name="embedhtml" select="/Data/WTENTITY/WTATTRIBUTE[@name=$name]/@embedhtml"/>
<!--
      <xsl:variable name="fmt">            
				<xsl:choose>
          <xsl:when test="WTFORMAT/@round">
            <xsl:value-of select="concat('Round(IIf(IsNumeric(', @value, '),', @value, ',0)*', WTFORMAT/@round, ',0)/', WTFORMAT/@round)"/>
          </xsl:when>
					<xsl:when test="WTFORMAT">
            <xsl:value-of select="concat('Format$(', @value, ', &quot;', WTFORMAT/@value, '&quot;)')"/>
          </xsl:when>
					<xsl:when test="$datatype='date'"><xsl:value-of select="concat('Format$(', @value, ', &quot;m/d/yyyy&quot;)')"/></xsl:when>
					<xsl:when test="$datatype='currency'"><xsl:value-of select="concat('Format$(', @value, ', &quot;currency&quot;)')"/></xsl:when>
					<xsl:otherwise><xsl:value-of select="@value"/></xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
-->
      
      <xsl:variable name="fmt">
        <xsl:choose>
          <xsl:when test="WTFORMAT/@round">
            <xsl:value-of select="concat('Round(IIf(IsNumeric(', @value, '),', @value, ',0)*', WTFORMAT/@round, ',0)/', WTFORMAT/@round)"/>
          </xsl:when>
          <xsl:when test="WTFORMAT">
            <xsl:if test="WTFORMAT/@zero">
              <xsl:value-of select="concat('IIf( ', @value, '=&quot;0&quot;,')"/>
              <xsl:value-of select="concat('Format$(', @value, ', &quot;', WTFORMAT/@zero, '&quot;)')"/>
              <xsl:value-of select="','"/>
            </xsl:if>

            <xsl:if test="WTFORMAT/@value">
              <xsl:value-of select="concat('Format$(', @value )"/>
              <xsl:if test="WTFORMAT/@convert">
                <xsl:value-of select="WTFORMAT/@convert"/>
              </xsl:if>
              <xsl:value-of select="concat(', &quot;', WTFORMAT/@value, '&quot;)')"/>
              <xsl:if test="WTFORMAT/@zero">
                <xsl:value-of select="')'"/>
              </xsl:if>
            </xsl:if>
            <xsl:if test="not(WTFORMAT/@value)">
              <xsl:if test="WTFORMAT/@convert">
                <xsl:value-of select="@value"/>
                <xsl:value-of select="WTFORMAT/@convert"/>
              </xsl:if>
            </xsl:if>
          </xsl:when>
          <xsl:when test="@type='date'">
            <xsl:value-of select="concat('Format$(', @value, ', &quot;m/d/yyyy&quot;)')"/>
          </xsl:when>
          <xsl:when test="@type='currency'">
            <xsl:value-of select="concat('Format$(', @value, ', &quot;currency&quot;)')"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="@value"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:variable>

      <!--==========handle date properties differently (check for no date)==========-->
			<xsl:choose>
				<xsl:when test="$embedhtml='true'">
					<xsl:value-of select="concat($tab2, 'If (Len(', $name, ') &gt; 0) Then sChildren = sChildren + XMLElement(&quot;', $aname, '&quot;, &quot;&quot;, &quot;&lt;!-- &quot; + Replace(' $name, ', &quot;--&quot;, &quot;- &quot;) + &quot; --&gt;&quot;, &quot;&quot;)', $cr)"/>
				</xsl:when>
				<xsl:when test="$datatype='date'">
					<xsl:value-of select="concat($tab2, 'If (Len(', $name, ') &gt; 0) And (', $name, ' &lt;&gt; &quot;0&quot;) Then sAttributes = sAttributes + XMLAttribute(&quot;', $aname, '&quot;, ', $fmt, ', False)', $cr)"/>
				</xsl:when>
<!--
				<xsl:when test="$datatype='date'">
					<xsl:value-of select="concat($tab2, 'If (', $name, ' = &quot;0&quot;) Then', $cr)"/>
					<xsl:value-of select="concat($tab3, 'sAttributes = sAttributes + XMLAttribute(&quot;', $aname, '&quot;, &quot;&quot;, True)', $cr)"/>
					<xsl:value-of select="concat($tab2, 'Else', $cr)"/>
					<xsl:value-of select="concat($tab3, 'sAttributes = sAttributes + XMLAttribute(&quot;', $aname, '&quot;, ', $fmt, ', True)', $cr)"/>
					<xsl:value-of select="concat($tab2, 'End If', $cr)"/>
				</xsl:when>
-->				
				<xsl:otherwise>
					<xsl:value-of select="concat($tab2, 'If (Len(', $name, ') &gt; 0) Then sAttributes = sAttributes + XMLAttribute(&quot;', $aname, '&quot;, ', $fmt, ', False)', $cr)"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>

		<xsl:value-of select="concat($tab1, 'End If', $cr)"/>

		<xsl:value-of select="$cr"/>
		<xsl:call-template name="VBComment">
			<xsl:with-param name="value">create the XML for the value</xsl:with-param>
			<xsl:with-param name="indent">1</xsl:with-param>
		</xsl:call-template>
		<xsl:value-of select="concat($tab1, 'sValue = &quot;&quot;', $cr)"/>

		<xsl:for-each select="WTVALUE">
			<xsl:value-of select="concat($tab1, 'sValue = sValue + ', @value, $cr)"/>
		</xsl:for-each>

		<xsl:value-of select="$cr"/>
		<xsl:call-template name="VBComment">
			<xsl:with-param name="value">create the XML for the object</xsl:with-param>
			<xsl:with-param name="indent">1</xsl:with-param>
		</xsl:call-template>

		<xsl:variable name="element">
		  	<xsl:choose>
		  		 <xsl:when test="@element"><xsl:value-of select="@element"/></xsl:when>
		  		 <xsl:otherwise><xsl:value-of select="concat($appprefix, '&quot; + bvElementName + &quot;')"/></xsl:otherwise>
		  	</xsl:choose>
		</xsl:variable>

		<xsl:value-of select="concat($tab1, 'If bAttrib Then', $cr)"/>
		<xsl:value-of select="concat($tab2, @name, ' = XMLElement(&quot;',  $element, '&quot;, sAttributes, sValue, sChildren)', $cr)"/>
		<xsl:value-of select="concat($tab1, 'Else', $cr)"/>
		<xsl:value-of select="concat($tab2, @name, ' = sChildren', $cr)"/>
		<xsl:value-of select="concat($tab1, 'End If', $cr)"/>

		<xsl:value-of select="$cr"/>

		  <xsl:call-template name="VBMethodEnd">
		  	<xsl:with-param name="type">Function</xsl:with-param>
		  	<xsl:with-param name="isado" select="false()"/>
		  	<xsl:with-param name="ismts" select="false()"/>
		  </xsl:call-template>
	</xsl:template>
	
	<xsl:template name="CustomXML">
		<!--==================================================================-->
		<!-- METHOD: CUSTOM XML without XML Options-->
		<!--==================================================================-->
		<xsl:value-of select="$cr"/>

		<xsl:call-template name="VBMethodStart">
			<xsl:with-param name="type">Function</xsl:with-param>
			<xsl:with-param name="name" select="@name"/>
			<xsl:with-param name="noparams" select="true()"/>
		</xsl:call-template>

		<xsl:call-template name="VBDataType">
			<xsl:with-param name="datatype">text</xsl:with-param>
		</xsl:call-template>
		<xsl:value-of select="$cr"/>

		<xsl:call-template name="VBFunctionBox">
			<xsl:with-param name="name" select="@name"/>
			<xsl:with-param name="desc">Returns the XML for the item.</xsl:with-param>
			<xsl:with-param name="ismts" select="false()"/>
			<xsl:with-param name="isado" select="false()"/>
		</xsl:call-template>

		<xsl:call-template name="VBVariable">
			<xsl:with-param name="indent">1</xsl:with-param>
			<xsl:with-param name="scope">Dim</xsl:with-param>
			<xsl:with-param name="name">sChildren</xsl:with-param>
			<xsl:with-param name="type">text</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="VBVariable">
			<xsl:with-param name="indent">1</xsl:with-param>
			<xsl:with-param name="scope">Dim</xsl:with-param>
			<xsl:with-param name="name">sAttributes</xsl:with-param>
			<xsl:with-param name="type">text</xsl:with-param>
		</xsl:call-template>

		<xsl:if test="WTVALUE">
			<xsl:call-template name="VBVariable">
				<xsl:with-param name="indent">1</xsl:with-param>
				<xsl:with-param name="scope">Dim</xsl:with-param>
				<xsl:with-param name="name">sValue</xsl:with-param>
				<xsl:with-param name="type">text</xsl:with-param>
			</xsl:call-template>
		</xsl:if>
		<xsl:value-of select="$cr"/>

		<xsl:call-template name="VBStartErrorHandler"/>

		<xsl:call-template name="CustomLabels"/>

		<xsl:call-template name="VBComment">
		  	<xsl:with-param name="value">create the XML for the attributes</xsl:with-param>
		  	<xsl:with-param name="indent">1</xsl:with-param>
		</xsl:call-template>
		<xsl:value-of select="concat($tab1, 'sAttributes = &quot;&quot;', $cr)"/>

		<xsl:for-each select="WTATTRIBUTE">
			<xsl:variable name="name">
				<xsl:choose>
					<xsl:when test="@name"><xsl:value-of select="@name"/></xsl:when>
					<xsl:otherwise><xsl:value-of select="@value"/></xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			<xsl:variable name="aname">
				<xsl:choose>
					<xsl:when test="@alias"><xsl:value-of select="@alias"/></xsl:when>
					<xsl:when test="@name"><xsl:value-of select="@name"/></xsl:when>
					<xsl:otherwise><xsl:value-of select="@value"/></xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			<xsl:variable name="datatype" select="/Data/WTENTITY/WTATTRIBUTE[@name=$name]/@type"/>
			<xsl:variable name="embedhtml" select="/Data/WTENTITY/WTATTRIBUTE[@name=$name]/@embedhtml"/>
			<xsl:variable name="fmt">            
				<xsl:choose>
					<xsl:when test="WTFORMAT"><xsl:value-of select="concat('Format$(', @value, ', &quot;', WTFORMAT/@value, '&quot;)')"/></xsl:when>
					<xsl:when test="$datatype='date'"><xsl:value-of select="concat('Format$(', @value, ', &quot;m/d/yyyy&quot;)')"/></xsl:when>
					<xsl:when test="$datatype='currency'"><xsl:value-of select="concat('Format$(', @value, ', &quot;currency&quot;)')"/></xsl:when>
					<xsl:otherwise><xsl:value-of select="@value"/></xsl:otherwise>
				</xsl:choose>
			</xsl:variable>

		  	<!--==========handle date properties differently (check for no date)==========-->
			<xsl:choose>
				<xsl:when test="$embedhtml='true'">
					<xsl:value-of select="concat($tab1, 'If (Len(', $name, ') &gt; 0) Then sChildren = sChildren + XMLElement(&quot;', $aname, '&quot;, &quot;&quot;, &quot;&lt;!-- &quot; + Replace(' $name, ', &quot;--&quot;, &quot;- &quot;) + &quot; --&gt;&quot;, &quot;&quot;)', $cr)"/>
				</xsl:when>
				<xsl:when test="$datatype='date'">
					<xsl:value-of select="concat($tab1, 'If (Len(', $name, ') &gt; 0) And (', $name, ' &lt;&gt; &quot;0&quot;) Then sAttributes = sAttributes + XMLAttribute(&quot;', $aname, '&quot;, ', $fmt, ', False)', $cr)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="concat($tab1, 'If (Len(', $name, ') &gt; 0) Then sAttributes = sAttributes + XMLAttribute(&quot;', $aname, '&quot;, ', $fmt, ', False)', $cr)"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>

		<xsl:if test="WTVALUE">
			<xsl:value-of select="$cr"/>
			<xsl:call-template name="VBComment">
				<xsl:with-param name="value">create the XML for the value</xsl:with-param>
				<xsl:with-param name="indent">1</xsl:with-param>
			</xsl:call-template>
			<xsl:value-of select="concat($tab1, 'sValue = &quot;&quot;', $cr)"/>

			<xsl:for-each select="WTVALUE">
				<xsl:value-of select="concat($tab1, 'sValue = sValue + ', @value, $cr)"/>
			</xsl:for-each>
		</xsl:if>

		<xsl:value-of select="$cr"/>
		<xsl:call-template name="VBComment">
			<xsl:with-param name="value">create the XML for the object</xsl:with-param>
			<xsl:with-param name="indent">1</xsl:with-param>
		</xsl:call-template>

		<xsl:variable name="element">
			<xsl:choose>
				<xsl:when test="@element"><xsl:value-of select="@element"/></xsl:when>
				<xsl:otherwise><xsl:value-of select="concat($appprefix, $entityname)"/></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:if test="WTVALUE">
			<xsl:value-of select="concat($tab1, @name, ' = XMLElement(&quot;',  $element, '&quot;, sAttributes, sValue, sChildren)', $cr)"/>
		</xsl:if>
		<xsl:if test="not(WTVALUE)">
			<xsl:value-of select="concat($tab1, @name, ' = XMLElement(&quot;',  $element, '&quot;, sAttributes, , sChildren)', $cr)"/>
		</xsl:if>

		<xsl:value-of select="$cr"/>

		<xsl:call-template name="VBMethodEnd">
			<xsl:with-param name="type">Function</xsl:with-param>
			<xsl:with-param name="isado" select="false()"/>
			<xsl:with-param name="ismts" select="false()"/>
		</xsl:call-template>
	</xsl:template>

	<!--===============================================================================================-->
	<xsl:template name="IsCustomLabels">
		<xsl:for-each select="WTATTRIBUTE">
			<!-- test for Entity language attributes -->
			<xsl:if test="/Data/WTENTITY/WTATTRIBUTE[@name=current()/@value and @language='true' and not(WTJOIN)]">E</xsl:if>
			<!-- test for Joined language attributes -->
			<xsl:if test="/Data/WTENTITY/WTATTRIBUTE[@name=current()/@value and @language='true' and WTJOIN]">J</xsl:if>
		</xsl:for-each>
	</xsl:template>

	<!--===============================================================================================-->
	<xsl:template name="CustomLabels">
		<xsl:variable name="islanguage" select="not(/Data/WTENTITY/@language='false')"/>
		<xsl:variable name="entitylabels" select="/Data/WTENTITY/WTATTRIBUTE[@language='true' and not(WTJOIN)]"/>
		<xsl:variable name="joinlabels" select="/Data/WTENTITY/WTATTRIBUTE[@language='true' and WTJOIN]"/>
		<xsl:variable name="customlabels"><xsl:call-template name="IsCustomLabels"/></xsl:variable>
		<xsl:variable name="customentitylabels"><xsl:value-of select="translate($customlabels, 'J', '')"/></xsl:variable>

		<xsl:if test="string-length($customlabels)&gt;0">
		  <xsl:call-template name="VBComment">
				<xsl:with-param name="value">check for non-default language labels</xsl:with-param>
				<xsl:with-param name="indent">1</xsl:with-param>
		  </xsl:call-template>
		  <xsl:value-of select="concat($tab1, 'If cDefaultLanguage &lt;&gt; mCurrentLanguage Then', $cr)"/>
		  <xsl:value-of select="concat($tab2, 'Dim oLabels As ', $appprefix, 'LabelUser.CLabels', $cr)"/>
		  <xsl:value-of select="concat($tab2, 'Dim oLabel As ', $appprefix, 'LabelUser.CLabel', $cr)"/>
		  <xsl:value-of select="concat($tab2, 'Set oLabels = New ', $appprefix, 'LabelUser.CLabels', $cr)"/>
		  <xsl:value-of select="concat($tab2, 'With oLabels', $cr)"/>
			<xsl:if test="/Data/WTPAGE/@multi-instance">
				<xsl:value-of select="concat($tab3, '.SysClientProject mClient, mProject', $cr)"/>
			</xsl:if>
		  
	 		<xsl:if test="string-length($customentitylabels)&gt;0">
				<xsl:value-of select="concat($tab3, '.ListAttribute cEntityID, ', $identity, ' , mCurrentLanguage', $cr)"/>
	 	 		<xsl:for-each select="WTATTRIBUTE">
		  			<xsl:if test="/Data/WTENTITY/WTATTRIBUTE[@name=current()/@value and @language='true' and not(WTJOIN)]">
						  <xsl:variable name="id" select="/Data/WTENTITY/WTATTRIBUTE[@name=current()/@value]/@id"/>
						  <xsl:value-of select="concat($tab3, 'Set oLabel = .SearchAttributeID(', $id, ')', $cr)"/>
						  <xsl:value-of select="concat($tab3, 'If Not (oLabel Is Nothing) Then', $cr)"/>
						  <xsl:value-of select="concat($tab4, @value, ' = oLabel.Text', $cr)"/>
						  <xsl:value-of select="concat($tab3, 'End If', $cr)"/>
						  <xsl:value-of select="concat($tab3, 'Set oLabel = Nothing', $cr)"/>
		  	 		</xsl:if>
	 			</xsl:for-each>
	 		</xsl:if>
	 		
	 		<xsl:for-each select="WTATTRIBUTE">
	  			<xsl:if test="/Data/WTENTITY/WTATTRIBUTE[@name=current()/@value and @language='true' and WTJOIN]">
	 				 <xsl:variable name="join"><xsl:call-template name="GetJoinLabel"/></xsl:variable>
					 <xsl:value-of select="concat($tab3, '.ListLabel ', $join, ', ', @language, ' , mCurrentLanguage', $cr)"/>
					 <xsl:value-of select="concat($tab3, 'If .Count > 0 Then', $cr)"/>
					 <xsl:value-of select="concat($tab4, 'Set oLabel = .Item(1)', $cr)"/>
					 <xsl:value-of select="concat($tab4, 'If Not (oLabel Is Nothing) Then', $cr)"/>
					 <xsl:value-of select="concat($tab5, @value, ' = oLabel.Text', $cr)"/>
					 <xsl:value-of select="concat($tab4, 'End If', $cr)"/>
					 <xsl:value-of select="concat($tab4, 'Set oLabel = Nothing', $cr)"/>
					 <xsl:value-of select="concat($tab3, 'End If', $cr)"/>
	  	 		</xsl:if>
	 		</xsl:for-each>
		  
		  <xsl:value-of select="concat($tab2, 'End With', $cr)"/>
		  <xsl:value-of select="concat($tab2, 'Set oLabels = Nothing', $cr)"/>
		  <xsl:value-of select="concat($tab1, 'End If', $cr, $cr)"/>
		</xsl:if>

	</xsl:template>

</xsl:stylesheet>

