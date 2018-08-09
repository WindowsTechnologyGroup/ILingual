<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:include href="GenerateIncludeVB.xsl"/>
<!--===============================================================================
	Auth: Mike Wisniewski
	Date: October 2001
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
			<xsl:with-param name="name" select="concat(@name, 's')"/>
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
			<xsl:with-param name="value" select="concat($itemclass, 's')"/>
		</xsl:call-template>
		<xsl:call-template name="VBConstant">
			<xsl:with-param name="name">DefaultLanguage</xsl:with-param>
			<xsl:with-param name="type">text</xsl:with-param>
			<xsl:with-param name="value" select="$defaultlanguage"/>
		</xsl:call-template>

		<xsl:call-template name="VBComment">
			<xsl:with-param name="value">variables</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="VBVariable">
			<xsl:with-param name="name">mSecurityToken</xsl:with-param>
			<xsl:with-param name="type">number</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="VBVariable">
			<xsl:with-param name="name">mCurrentLanguage</xsl:with-param>
			<xsl:with-param name="type">text</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="VBParentDeclare"/>
		<xsl:if test="($hasfind)">
			<xsl:call-template name="VBVariable">
				<xsl:with-param name="name">mFindTypeID</xsl:with-param>
				<xsl:with-param name="type">number</xsl:with-param>
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="($haslist)">
			<xsl:call-template name="VBVariable">
				<xsl:with-param name="name">mListTypeID</xsl:with-param>
				<xsl:with-param name="type">number</xsl:with-param>
			</xsl:call-template>
		</xsl:if>
		
		  <xsl:if test="$embeds">
				<xsl:call-template name="VBComment">
					 <xsl:with-param name="value">Embed Variables</xsl:with-param>
				</xsl:call-template>
				<xsl:for-each select="$embeds">
					 <xsl:value-of select="concat('Private emb', @name, ' As String', $cr)"/>
				</xsl:for-each>
		  </xsl:if>

		<xsl:call-template name="VBComment">
			<xsl:with-param name="value">child classes</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="VBVariable">
			<xsl:with-param name="name">moItems</xsl:with-param>
			<xsl:with-param name="type">Collection</xsl:with-param>
		</xsl:call-template>

		<!--==================================================================-->
		<!-- ENUM ITEM TYPE CONSTANTS -->
		<!--==================================================================-->
		<xsl:if test="($hasfind) or ($haslist)">

			<xsl:call-template name="VBComment">
				<xsl:with-param name="value">enumerators</xsl:with-param>
			</xsl:call-template>
			<xsl:value-of select="concat('Public Enum ', $constprefix, 'sEnumConstants', $cr)"/>
			<xsl:if test="($hasfind)">
				<xsl:call-template name="VBEnum">
					<xsl:with-param name="prefix" select="$constprefix"/>
					<xsl:with-param name="name">EnumFindType</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<xsl:if test="($haslist)">
				<xsl:call-template name="VBEnum">
					<xsl:with-param name="prefix" select="$constprefix"/>
					<xsl:with-param name="name">EnumListType</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<xsl:value-of select="concat('End Enum', $cr, $cr)"/>

			<xsl:if test="($hasfind)">
				<xsl:value-of select="concat('Public Enum ', $constprefix, 'FindTypeConstants', $cr)"/>
				<xsl:for-each select="/Data/WTENTITY/WTENUM[@type='find' and @id=1]/WTATTRIBUTE">
					<xsl:variable name="aname" select="@name"/>
					<xsl:for-each select="/Data/WTENTITY/WTATTRIBUTE[@name=$aname]">
						<xsl:call-template name="VBEnum">
							<xsl:with-param name="prefix" select="$constprefix"/>
							<xsl:with-param name="name" select="concat('Find', @name)"/>
						</xsl:call-template>
					</xsl:for-each>
				</xsl:for-each>
				<xsl:value-of select="concat('End Enum', $cr, $cr)"/>
			</xsl:if>

			<xsl:if test="($haslist)">
				<xsl:value-of select="concat('Public Enum ', $constprefix, 'ListTypeConstants', $cr)"/>
				<xsl:choose>
					<xsl:when test="($multilist)">
						<xsl:for-each select="/Data/WTENTITY/WTENUM[@type='list']/WTATTRIBUTE">
							<xsl:choose>	
								<xsl:when test="@id">
									<xsl:call-template name="VBEnum">
										<xsl:with-param name="prefix" select="$constprefix"/>
										<xsl:with-param name="name" select="concat('List', @name)"/>
									</xsl:call-template>
								</xsl:when>
								<xsl:otherwise>
									<xsl:variable name="aname" select="@name"/>
									<xsl:for-each select="/Data/WTENTITY/WTATTRIBUTE[@name=$aname]">
										<xsl:call-template name="VBEnum">
											<xsl:with-param name="prefix" select="$constprefix"/>
											<xsl:with-param name="name" select="concat('List', @name)"/>
										</xsl:call-template>
									</xsl:for-each>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:for-each>
					</xsl:when>
					<xsl:otherwise>
						<xsl:call-template name="VBEnum">
							<xsl:with-param name="prefix" select="$constprefix"/>
							<xsl:with-param name="name">ListAll</xsl:with-param>
						</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:value-of select="concat('End Enum', $cr, $cr)"/>
			</xsl:if>
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
		<!-- METHOD: COUNT -->
		<!--==================================================================-->
		<xsl:if test="WTPROCEDURES/WTPROCEDURE[@type='Count' and not(@template='new')]">

			<xsl:value-of select="$cr"/>
			<xsl:call-template name="VBMethodStart">
				<xsl:with-param name="type">Property Get</xsl:with-param>
				<xsl:with-param name="name">Count</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="VBParamParent"/>
			<xsl:call-template name="VBSecurityParam"/>
			<xsl:value-of select="concat($tab0, ')')"/>
			<xsl:call-template name="VBDataType">
				<xsl:with-param name="datatype">number</xsl:with-param>
			</xsl:call-template>
			<xsl:value-of select="$cr"/>

			<xsl:call-template name="VBFunctionBox">
				<xsl:with-param name="name">Count_Get</xsl:with-param>
				<xsl:with-param name="desc">Returns the number of items in the collection.</xsl:with-param>
				<xsl:with-param name="ismts" select="false()"/>
				<xsl:with-param name="isado" select="false()"/>
			</xsl:call-template>

			<xsl:call-template name="VBStartErrorHandler"/>
			<xsl:if test="WTPROCEDURES/WTPROCEDURE[@type='Count' and not(@nodata)]">
				<xsl:call-template name="VBSecuritySet"/>
			</xsl:if>
			<xsl:call-template name="VBParentSetColl"/>

			<xsl:value-of select="concat($tab1, 'If Not (moItems Is Nothing) Then', $cr)"/>
			 <xsl:call-template name="VBComment">
				<xsl:with-param name="value">if the collection is loaded then return the count from the collection</xsl:with-param>
				<xsl:with-param name="indent">2</xsl:with-param>
			 </xsl:call-template>
			 <xsl:value-of select="concat($tab2, 'Count = moItems.Count', $cr)"/>
			<xsl:value-of select="concat($tab1, 'Else', $cr)"/>

			<xsl:if test="WTPROCEDURES/WTPROCEDURE[@type='Count' and @nodata]">
				<xsl:value-of select="concat($tab2, 'Count = 0', $cr)"/>
			</xsl:if>
			<xsl:if test="WTPROCEDURES/WTPROCEDURE[@type='Count' and not(@nodata)]">
				<xsl:call-template name="VBComment">
					<xsl:with-param name="value">return the count from the database</xsl:with-param>
					<xsl:with-param name="indent">2</xsl:with-param>
				</xsl:call-template>
				<xsl:value-of select="concat($tab2, 'Count = BusnService.Count(')"/>
				<xsl:call-template name="VBParentCall"/>
				<xsl:value-of select="concat('mSecurityToken)', $cr)"/>
			</xsl:if>

			<xsl:value-of select="concat($tab1, 'End If', $cr, $cr)"/>

			<xsl:call-template name="VBMethodEnd">
				<xsl:with-param name="type">Function</xsl:with-param>
				<xsl:with-param name="isado" select="false()"/>
				<xsl:with-param name="ismts" select="false()"/>
			</xsl:call-template>
		</xsl:if>

		<!--==================================================================-->
		<!-- METHOD: ENUMERATE -->
		<!--==================================================================-->
		<xsl:if test="count(/Data/WTENTITY/WTPROCEDURES/WTPROCEDURE[@type='Enum' and not(@template='new')]) > 0">

	 		<xsl:variable name="column" select="/Data/WTENTITY/WTPROCEDURES/WTPROCEDURE[@name='Enum']/@column"/>
	 		<xsl:variable name="enumlabel" select="/Data/WTENTITY/WTATTRIBUTE[@name=$column and @language='true']"/>
	 		<xsl:variable name="columnid" select="/Data/WTENTITY/WTATTRIBUTE[@name=$column and @language='true']/@id"/>

			<xsl:value-of select="$cr"/>
			<xsl:call-template name="VBMethodStart">
				<xsl:with-param name="type">Function</xsl:with-param>
				<xsl:with-param name="name">Enumerate</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="VBParamParent"/>
			<xsl:call-template name="VBSecurityParam"/>
			<xsl:value-of select="concat($tab0, ')')"/>
			<xsl:call-template name="VBDataType">
				<xsl:with-param name="datatype">wtSystem.CEnumItems</xsl:with-param>
			</xsl:call-template>
			<xsl:value-of select="$cr"/>

			<xsl:call-template name="VBFunctionBox">
				<xsl:with-param name="name">Enumerate</xsl:with-param>
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

			<xsl:call-template name="VBVariable">
				<xsl:with-param name="indent">1</xsl:with-param>
				<xsl:with-param name="scope">Dim</xsl:with-param>
				<xsl:with-param name="name">vEnums()</xsl:with-param>
				<xsl:with-param name="type">busnrecord</xsl:with-param>
			</xsl:call-template>
			
			<xsl:call-template name="VBVariable">
				<xsl:with-param name="indent">1</xsl:with-param>
				<xsl:with-param name="scope">Dim</xsl:with-param>
				<xsl:with-param name="name">idxEnum</xsl:with-param>
				<xsl:with-param name="type">small number</xsl:with-param>
			</xsl:call-template>

		  <xsl:if test="$enumlabel">
				<xsl:value-of select="concat($tab1, 'Dim oLabels As ', $appprefix, 'LabelUser.CLabels', $cr)"/>
				<xsl:value-of select="concat($tab1, 'Dim oLabel As ', $appprefix, 'LabelUser.CLabel', $cr)"/>
		  </xsl:if>

			<xsl:value-of select="$cr"/>

			<xsl:call-template name="VBStartErrorHandler"/>
			<xsl:call-template name="VBSecuritySet"/>
			<xsl:call-template name="VBParentSetColl"/>
		
			<xsl:value-of select="concat($tab1, 'Set oEnums = New wtSystem.CEnumItems', $cr, $cr)"/>

			<xsl:value-of select="concat($tab1, 'vEnums = BusnService.Enumerate(')"/>
			<xsl:call-template name="VBParentCall"/>
			<xsl:value-of select="concat('mSecurityToken)', $cr, $cr)"/>

		  <xsl:if test="$enumlabel">
				<xsl:value-of select="concat($tab1, 'If cDefaultLanguage &lt;&gt; mCurrentLanguage Then', $cr)"/>
				<xsl:value-of select="concat($tab2, 'Set oLabels = New ', $appprefix, 'LabelUser.CLabels', $cr)"/>
				<xsl:if test="/Data/WTPAGE/@multi-instance">
					<xsl:value-of select="concat($tab2, 'oLabels.SysClientProject mClient, mProject', $cr)"/>
				</xsl:if>
				<xsl:value-of select="concat($tab2, 'oLabels.ListItems ', $entityid, ', ', $columnid, ', mCurrentLanguage', $cr)"/>
				<xsl:value-of select="concat($tab1, 'End If', $cr, $cr)"/>
				<xsl:value-of select="concat($tab1, 'For idxEnum = 1 To UBound(vEnums)', $cr)"/>
				<xsl:value-of select="concat($tab2, 'With vEnums(idxEnum)', $cr)"/>
				<xsl:value-of select="concat($tab3, 'If cDefaultLanguage = mCurrentLanguage Then', $cr)"/>
				<xsl:value-of select="concat($tab4, 'oEnums.Add .', $identityfield, ', .', $column, $cr)"/>
				<xsl:value-of select="concat($tab3, 'Else', $cr)"/>
				<xsl:value-of select="concat($tab4, 'Set oLabel = oLabels.SearchItemID(.', $identityfield, ')', $cr)"/>
				<xsl:value-of select="concat($tab4, 'If oLabel Is Nothing Then', $cr)"/>
				<xsl:value-of select="concat($tab5, 'oEnums.Add .', $identityfield, ', .', $column, $cr)"/>
				<xsl:value-of select="concat($tab4, 'Else', $cr)"/>
				<xsl:value-of select="concat($tab5, 'oEnums.Add .', $identityfield, ', oLabel.Text', $cr)"/>
				<xsl:value-of select="concat($tab4, 'End If', $cr)"/>
				<xsl:value-of select="concat($tab4, 'Set oLabel = Nothing', $cr)"/>
				<xsl:value-of select="concat($tab3, 'End If', $cr)"/>
				<xsl:value-of select="concat($tab2, 'End With', $cr)"/>
				<xsl:value-of select="concat($tab1, 'Next idxEnum', $cr, $cr)"/>
				<xsl:value-of select="concat($tab1, 'Set Enumerate = oEnums', $cr)"/>
				<xsl:value-of select="concat($tab1, 'Set oEnums = Nothing', $cr)"/>
				<xsl:value-of select="concat($tab1, 'Set oLabels = Nothing', $cr, $cr)"/>
		  </xsl:if>

		  <xsl:if test="not($enumlabel)">
				<xsl:value-of select="concat($tab1, 'For idxEnum = 1 To UBound(vEnums)', $cr)"/>
				<xsl:value-of select="concat($tab2, 'With vEnums(idxEnum)', $cr)"/>
				<xsl:value-of select="concat($tab3, 'oEnums.Add .', $identityfield, ', .', $column, '', $cr)"/>
				<xsl:value-of select="concat($tab2, 'End With', $cr)"/>
				<xsl:value-of select="concat($tab1, 'Next idxEnum', $cr, $cr)"/>
				<xsl:value-of select="concat($tab1, 'Set Enumerate = oEnums', $cr)"/>
				<xsl:value-of select="concat($tab1, 'Set oEnums = Nothing', $cr, $cr)"/>
		  </xsl:if>

			<xsl:call-template name="VBMethodEnd">
				<xsl:with-param name="type">Function</xsl:with-param>
				<xsl:with-param name="isado" select="false()"/>
				<xsl:with-param name="ismts" select="false()"/>
			</xsl:call-template>
		</xsl:if>

		<!--==================================================================-->
		<!-- METHOD: ENUMERATE (CUSTOM) -->
		<!--==================================================================-->
		<xsl:for-each select="WTPROCEDURES/WTPROCEDURE[(@type='Enum') and (@template='new') and (@passthru='true')]">

	 		<xsl:variable name="column" select="@column"/>
	 		<xsl:variable name="enumlabel" select="/Data/WTENTITY/WTATTRIBUTE[@name=$column and @language='true']"/>
	 		<xsl:variable name="columnid" select="/Data/WTENTITY/WTATTRIBUTE[@name=$column and @language='true']/@id"/>

			<xsl:value-of select="$cr"/>
			<xsl:call-template name="VBMethodStart">
				<xsl:with-param name="type">Function</xsl:with-param>
				<xsl:with-param name="name" select="@name"/>
			</xsl:call-template>

			<!--input parameters-->
			<xsl:apply-templates select="WTPARAM[@direction='input']" mode="inputparam">
				<xsl:with-param name="indent">1</xsl:with-param>
				<xsl:with-param name="functype">function</xsl:with-param>
			</xsl:apply-templates>
<!--
			<xsl:call-template name="VBSecurityParam"/>
			<xsl:value-of select="concat($tab0, ')')"/>
-->
			<xsl:call-template name="VBDataType">
				<xsl:with-param name="datatype">wtSystem.CEnumItems</xsl:with-param>
			</xsl:call-template>
			<xsl:value-of select="$cr"/>

			<xsl:call-template name="VBFunctionBox">
				<xsl:with-param name="name" select="@name"/>
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
			
			<xsl:call-template name="VBVariable">
				<xsl:with-param name="indent">1</xsl:with-param>
				<xsl:with-param name="scope">Dim</xsl:with-param>
				<xsl:with-param name="name">vEnums()</xsl:with-param>
				<xsl:with-param name="type">busnrecord</xsl:with-param>
			</xsl:call-template>
			
			<xsl:call-template name="VBVariable">
				<xsl:with-param name="indent">1</xsl:with-param>
				<xsl:with-param name="scope">Dim</xsl:with-param>
				<xsl:with-param name="name">idxEnum</xsl:with-param>
				<xsl:with-param name="type">small number</xsl:with-param>
			</xsl:call-template>

		  <xsl:if test="$enumlabel">
				<xsl:value-of select="concat($tab1, 'Dim oLabels As ', $appprefix, 'LabelUser.CLabels', $cr)"/>
				<xsl:value-of select="concat($tab1, 'Dim oLabel As ', $appprefix, 'LabelUser.CLabel', $cr)"/>
		  </xsl:if>

			<xsl:value-of select="$cr"/>

			<xsl:call-template name="VBStartErrorHandler"/>
			<xsl:call-template name="VBSecuritySet"/>

			<xsl:value-of select="concat($tab1, 'Set oEnums = New wtSystem.CEnumItems', $cr, $cr)"/>

			<xsl:apply-templates select="WTPARAM[@direction='input']" mode="callbusn">
				<xsl:with-param name="indent">1</xsl:with-param>
				<xsl:with-param name="functype">function</xsl:with-param>
				<xsl:with-param name="funcret">vEnums</xsl:with-param>
			</xsl:apply-templates>

		   <xsl:variable name="id">
				<xsl:if test="@id"><xsl:value-of select="@id"/></xsl:if>
				<xsl:if test="not(@id)"><xsl:value-of select="$identityfield"/></xsl:if>
		   </xsl:variable>
		   
		  <xsl:if test="$enumlabel">
				<xsl:value-of select="concat($tab1, 'If cDefaultLanguage &lt;&gt; mCurrentLanguage Then', $cr)"/>
				<xsl:value-of select="concat($tab2, 'Set oLabels = New ', $appprefix, 'LabelUser.CLabels', $cr)"/>
				<xsl:if test="/Data/WTPAGE/@multi-instance">
					<xsl:value-of select="concat($tab2, 'oLabels.SysClientProject mClient, mProject', $cr)"/>
				</xsl:if>
				<xsl:value-of select="concat($tab2, 'oLabels.ListItems ', $entityid, ', ', $columnid, ', mCurrentLanguage', $cr)"/>
				<xsl:value-of select="concat($tab1, 'End If', $cr, $cr)"/>
				<xsl:value-of select="concat($tab1, 'For idxEnum = 1 To UBound(vEnums)', $cr)"/>
				<xsl:value-of select="concat($tab2, 'With vEnums(idxEnum)', $cr)"/>
				<xsl:value-of select="concat($tab3, 'If cDefaultLanguage = mCurrentLanguage Then', $cr)"/>
				<xsl:value-of select="concat($tab4, 'oEnums.Add .', $id, ', .', $column, $cr)"/>
				<xsl:value-of select="concat($tab3, 'Else', $cr)"/>
				<xsl:value-of select="concat($tab4, 'Set oLabel = oLabels.SearchItemID(.', $id, ')', $cr)"/>
				<xsl:value-of select="concat($tab4, 'If oLabel Is Nothing Then', $cr)"/>
				<xsl:value-of select="concat($tab5, 'oEnums.Add .', $id, ', .', $column, $cr)"/>
				<xsl:value-of select="concat($tab4, 'Else', $cr)"/>
				<xsl:value-of select="concat($tab5, 'oEnums.Add .', $id, ', oLabel.Text', $cr)"/>
				<xsl:value-of select="concat($tab4, 'End If', $cr)"/>
				<xsl:value-of select="concat($tab4, 'Set oLabel = Nothing', $cr)"/>
				<xsl:value-of select="concat($tab3, 'End If', $cr)"/>
				<xsl:value-of select="concat($tab2, 'End With', $cr)"/>
				<xsl:value-of select="concat($tab1, 'Next idxEnum', $cr, $cr)"/>
	 			<xsl:value-of select="concat($tab1, 'Set ', @name, ' = oEnums', $cr)"/>
				<xsl:value-of select="concat($tab1, 'Set oEnums = Nothing', $cr)"/>
				<xsl:value-of select="concat($tab1, 'Set oLabels = Nothing', $cr, $cr)"/>
		  </xsl:if>

		  <xsl:if test="not($enumlabel)">
				<xsl:value-of select="concat($tab1, 'For idxEnum = 1 To UBound(vEnums)', $cr)"/>
				<xsl:value-of select="concat($tab2, 'With vEnums(idxEnum)', $cr)"/>
				<xsl:value-of select="concat($tab3, 'oEnums.Add .', $id, ', .', $column, '', $cr)"/>
				<xsl:value-of select="concat($tab2, 'End With', $cr)"/>
				<xsl:value-of select="concat($tab1, 'Next idxEnum', $cr, $cr)"/>
	 			<xsl:value-of select="concat($tab1, 'Set ', @name, ' = oEnums', $cr)"/>
				<xsl:value-of select="concat($tab1, 'Set oEnums = Nothing', $cr, $cr)"/>
		  </xsl:if>

			<xsl:call-template name="VBMethodEnd">
				<xsl:with-param name="type">Function</xsl:with-param>
				<xsl:with-param name="isado" select="false()"/>
				<xsl:with-param name="ismts" select="false()"/>
			</xsl:call-template>

		</xsl:for-each>

		<!--==================================================================-->
		<!-- METHOD: ENUMXML -->
		<!--==================================================================-->
		<xsl:for-each select="/Data/WTENTITY/WTPROCEDURES/WTPROCEDURE[@type='EnumXML']">

			<xsl:value-of select="$cr"/>
			<xsl:call-template name="VBMethodStart">
				<xsl:with-param name="type">Function</xsl:with-param>
				<xsl:with-param name="name" select="@name"/>
			</xsl:call-template>

			<xsl:if test="WTPARAM">
				<xsl:apply-templates select="WTPARAM[@direction='input']" mode="inputparam">
					<xsl:with-param name="indent">1</xsl:with-param>
					<xsl:with-param name="functype">function</xsl:with-param>
					<xsl:with-param name="close">no</xsl:with-param>
				</xsl:apply-templates>
				<xsl:value-of select="concat(', _', $cr)"/>
			</xsl:if>

			<!--input parameters-->
			<xsl:value-of select="concat('   Optional ByVal bvItemID As Long = 0, _', $cr)"/>
			<xsl:value-of select="concat('   Optional ByVal bvElementName As String = &quot;', $entityname, '&quot;, _', $cr)"/>
			<xsl:value-of select="concat('   Optional ByVal bvSecurityToken As Long = 0) As String', $cr)"/>

			<xsl:call-template name="VBFunctionBox">
				<xsl:with-param name="name" select="@name"/>
				<xsl:with-param name="desc">Returns an XML enumerated list of items.</xsl:with-param>
				<xsl:with-param name="ismts" select="false()"/>
				<xsl:with-param name="isado" select="false()"/>
			</xsl:call-template>

			<xsl:call-template name="VBStartErrorHandler"/>
			<xsl:call-template name="VBSecuritySet"/>

		   <xsl:variable name="EnumName">
				<xsl:choose>
					 <xsl:when test="@enumname"><xsl:value-of select="@enumname"/></xsl:when>
					 <xsl:otherwise>Enumerate</xsl:otherwise>
				</xsl:choose>
		   </xsl:variable>
			<xsl:variable name="blankrow">
				<xsl:choose>
					<xsl:when test="@blankrow='false'">False</xsl:when>
					<xsl:otherwise>True</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
		   
			<xsl:value-of select="concat($tab1, @name, ' = ', $EnumName, '(')"/>

			<xsl:if test="WTPARAM">
				<xsl:apply-templates select="WTPARAM[@direction='input']" mode="listparam"/>
				<xsl:value-of select="', '"/>
			</xsl:if>

			<xsl:value-of select="concat('mSecurityToken).XML(&quot;', $appprefix, '&quot; + bvElementName + &quot;s&quot;, bvItemID, ', $blankrow, ')', $cr, $cr)"/>

			<xsl:call-template name="VBMethodEnd">
				<xsl:with-param name="type">Function</xsl:with-param>
				<xsl:with-param name="isado" select="false()"/>
				<xsl:with-param name="ismts" select="false()"/>
			</xsl:call-template>

		</xsl:for-each>

		<!--==================================================================-->
		<!-- METHOD: ENUMITEMS -->
		<!--==================================================================-->
		<xsl:if test="($hasfind) or ($haslist)">
 			<xsl:value-of select="$cr"/>
			<xsl:call-template name="VBMethodStart">
				<xsl:with-param name="type">Property Get</xsl:with-param>
				<xsl:with-param name="name">EnumItems</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="VBParam">
				<xsl:with-param name="name">Type</xsl:with-param>
				<xsl:with-param name="type" select="concat($constprefix, 'sEnumConstants')"/>
				<xsl:with-param name="continue" select="true()"/>
			</xsl:call-template>
			<xsl:call-template name="VBParam">
				<xsl:with-param name="name">SecurityToken</xsl:with-param>
				<xsl:with-param name="type">number</xsl:with-param>
				<xsl:with-param name="optional" select="true()"/>
				<xsl:with-param name="default">0</xsl:with-param>
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

			<!--enumerate the find types if there are any-->
			<xsl:if test="($hasfind)">
				<xsl:value-of select="concat($tab2, 'Case c', $constprefix, 'EnumFindType', $cr)"/>
				<xsl:for-each select="/Data/WTENTITY/WTENUM[@type='find' and @id=1]/WTATTRIBUTE">
					<xsl:variable name="aname" select="@name"/>
					<xsl:variable name="hidden" select="@hidden"/>
					<xsl:for-each select="/Data/WTENTITY/WTATTRIBUTE[@name=$aname]">
						<xsl:value-of select="$tab3"/>
						<xsl:if test="$hidden">	
							<xsl:value-of select="concat($tab0, 'If (bvSecurityToken &lt; ', $hidden, ') Then ')"/>
						</xsl:if>	
						<xsl:value-of select="concat($tab0, 'oEnums.Add c', $constprefix, 'Find', @name, ', &quot;', @name, '&quot;', $cr)"/>
					</xsl:for-each>
				</xsl:for-each>
			</xsl:if>

			<!--enumerate the list types if there are any-->
			<xsl:if test="($haslist)">
				<xsl:value-of select="concat($tab2, 'Case c', $constprefix, 'EnumListType', $cr)"/>
				<xsl:choose>
					<xsl:when test="($multilist)">
						<xsl:for-each select="/Data/WTENTITY/WTENUM[@type='list']/WTATTRIBUTE">
							<xsl:variable name="aname" select="@name"/>
							<xsl:variable name="hidden" select="@hidden"/>
							<xsl:for-each select="/Data/WTENTITY/WTATTRIBUTE[@name=$aname]">
								<xsl:value-of select="$tab3"/>
								<xsl:if test="$hidden">	
									<xsl:value-of select="concat($tab0, 'If (bvSecurityToken &lt; ', $hidden, ') Then ')"/>
								</xsl:if>	
								<xsl:value-of select="concat($tab0, 'oEnums.Add c', $constprefix, 'List', @name, ', &quot;', @name, '&quot;', $cr)"/>
							</xsl:for-each>
						</xsl:for-each>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="concat($tab3, 'oEnums.Add c', $constprefix, 'ListAll, &quot;All&quot;', $cr)"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:if>

			<xsl:value-of select="concat($tab1, 'End Select', $cr, $cr)"/>

			<xsl:value-of select="concat($tab1, 'Set EnumItems = oEnums', $cr)"/>
			<xsl:value-of select="concat($tab1, 'Set oEnums = Nothing', $cr)"/>

			<xsl:call-template name="VBMethodEnd">
				<xsl:with-param name="type">Function</xsl:with-param>
				<xsl:with-param name="isado" select="false()"/>
				<xsl:with-param name="ismts" select="false()"/>
			</xsl:call-template>
		</xsl:if>

		<!--==================================================================-->
		<!-- METHOD: FIND -->
		<!--==================================================================-->
		<xsl:if test="($hasfind)">

			<!--generate one find method for each Find procedure-->
			<xsl:for-each select="/Data/WTENTITY/WTPROCEDURES/WTPROCEDURE[@type='Find' and not(@template='new')]">
			
				<xsl:value-of select="$cr"/>
				<xsl:call-template name="VBMethodStart">
					<xsl:with-param name="type">Function</xsl:with-param>
					<xsl:with-param name="name" select="@name"/>
				</xsl:call-template>
				<xsl:call-template name="VBParam">
					<xsl:with-param name="name">FindType</xsl:with-param>
					<xsl:with-param name="type" select="concat($userproj, $appprefix, /Data/WTENTITY/@name, 'FindTypeConstants')"/>
				</xsl:call-template>
				<xsl:if test="WTBOOKMARK">
					<xsl:call-template name="VBParam">
						<xsl:with-param name="name">BookMark</xsl:with-param>
						<xsl:with-param name="type">text</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<xsl:call-template name="VBParam">
					<xsl:with-param name="name">SearchText</xsl:with-param>
					<xsl:with-param name="type">text</xsl:with-param>
				</xsl:call-template>
				<xsl:if test="WTBOOKMARK">
					<xsl:call-template name="VBParam">
						<xsl:with-param name="name">Direction</xsl:with-param>
						<xsl:with-param name="type">wtSystem.WTBookmarkConstants</xsl:with-param>
					</xsl:call-template>
				</xsl:if>

				<xsl:for-each select="WTPARAM">
					<xsl:call-template name="VBParam">
						<xsl:with-param name="parameter" select="."/>
						<xsl:with-param name="continue" select="not(position()=last())"/>
					</xsl:call-template>
				</xsl:for-each>

				<xsl:value-of select="concat($tab0, ')')"/>
				<xsl:call-template name="VBDataType">
					<xsl:with-param name="datatype">text</xsl:with-param>
				</xsl:call-template>
				<xsl:value-of select="$cr"/>

				<xsl:call-template name="VBFunctionBox">
					<xsl:with-param name="name" select="@name"/>
					<xsl:with-param name="desc">Returns a list of records which match the specified search criteria.</xsl:with-param>
					<xsl:with-param name="ismts" select="false()"/>
					<xsl:with-param name="isado" select="false()"/>
				</xsl:call-template>

				<xsl:call-template name="VBVariable">
					<xsl:with-param name="indent">1</xsl:with-param>
					<xsl:with-param name="scope">Dim</xsl:with-param>
					<xsl:with-param name="name">oItem</xsl:with-param>
					<xsl:with-param name="type">useritem</xsl:with-param>
				</xsl:call-template>

				<xsl:call-template name="VBVariable">
					<xsl:with-param name="indent">1</xsl:with-param>
					<xsl:with-param name="scope">Dim</xsl:with-param>
					<xsl:with-param name="name">tRecs()</xsl:with-param>
					<xsl:with-param name="type">busnrecord</xsl:with-param>
				</xsl:call-template>

				<xsl:call-template name="VBVariable">
					<xsl:with-param name="indent">1</xsl:with-param>
					<xsl:with-param name="scope">Dim</xsl:with-param>
					<xsl:with-param name="name">idxRec</xsl:with-param>
					<xsl:with-param name="type">number</xsl:with-param>
				</xsl:call-template>

				<xsl:if test="WTBOOKMARK">
					<xsl:call-template name="VBVariable">
						<xsl:with-param name="indent">1</xsl:with-param>
						<xsl:with-param name="scope">Dim</xsl:with-param>
						<xsl:with-param name="name">sBookMark</xsl:with-param>
						<xsl:with-param name="type">text</xsl:with-param>
					</xsl:call-template>
				</xsl:if>

				<xsl:value-of select="$cr"/>

				<xsl:call-template name="VBStartErrorHandler"/>
				<xsl:call-template name="VBSecuritySet"/>

				<!--set the find type id-->
				<xsl:call-template name="VBComment">
					<xsl:with-param name="value">set the find type ID</xsl:with-param>
					<xsl:with-param name="indent">1</xsl:with-param>
				</xsl:call-template>
				<xsl:value-of select="concat($tab1, 'FindTypeID = bvFindType', $cr)"/>
				<xsl:if test="($haslist)">
					<xsl:value-of select="concat($tab1, 'ListTypeID = 0', $cr)"/>
				</xsl:if>
				<xsl:value-of select="$cr"/>

				<xsl:value-of select="concat($tab1, 'Set moItems = Nothing', $cr)"/>
				<xsl:value-of select="concat($tab1, 'Set moItems = New Collection', $cr, $cr)"/>

				<xsl:if test="WTBOOKMARK">
					<xsl:value-of select="concat($tab1, 'sBookMark = bvBookMark', $cr)"/>
					<xsl:value-of select="concat($tab1, 'tRecs = BusnService.', @name, '(bvFindType, sBookMark, bvSearchText, bvDirection')"/>
				</xsl:if>
				<xsl:if test="WTSEARCH">
					<xsl:value-of select="concat($tab1, 'tRecs = BusnService.', @name, '(bvFindType, bvSearchText')"/>
				</xsl:if>

				<!--==========add additional params==========-->
				<xsl:for-each select="WTPARAM">
					<xsl:variable name="nametype"><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="@name"/></xsl:call-template></xsl:variable>
					<xsl:variable name="nametext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@name"/></xsl:call-template></xsl:variable>
					<xsl:choose>
						<xsl:when test="($nametype='ATTR')"><xsl:value-of select="concat(', bv', /Data/WTENTITY/WTATTRIBUTE[@name=$nametext]/@name)"/></xsl:when>
						<xsl:when test="($nametype='SYS') and ($nametext='userid')"><xsl:value-of select="(', bvSecurityToken')"/></xsl:when>
					</xsl:choose>
				</xsl:for-each>

				<xsl:value-of select="concat(')', $cr, $cr)"/>

				<xsl:value-of select="concat($tab1, 'For idxRec = 1 To UBound(tRecs)', $cr)"/>
				<xsl:value-of select="concat($tab2, 'Set oItem = New ', $userproj, $itemclass, '', $cr)"/>
				<xsl:if test="/Data/WTPAGE/@multi-instance">
					<xsl:value-of select="concat($tab2, 'oItem.SysClientProject mClient, mProject', $cr)"/>
				</xsl:if>
				<xsl:value-of select="concat($tab2, 'oItem.DataRec = tRecs(idxRec)', $cr)"/>
				<xsl:call-template name="VBItemInit">
					<xsl:with-param name="indent">2</xsl:with-param>
					<xsl:with-param name="objname">oItem</xsl:with-param>
				</xsl:call-template>
				<xsl:value-of select="concat($tab2, 'moItems.Add oItem, CStr(oItem.', $identityfield, ')', $cr)"/>
				<xsl:value-of select="concat($tab1, 'Next idxRec', $cr, $cr)"/>

				<xsl:if test="WTBOOKMARK">
					<xsl:call-template name="VBComment">
						<xsl:with-param name="value">return the new bookmark</xsl:with-param>
						<xsl:with-param name="indent">1</xsl:with-param>
					</xsl:call-template>
					<xsl:value-of select="concat($tab1, @name, ' = sBookMark', $cr, $cr)"/>
				</xsl:if>
				<xsl:if test="WTSEARCH">
					<xsl:call-template name="VBComment">
						<xsl:with-param name="value">return list count</xsl:with-param>
						<xsl:with-param name="indent">1</xsl:with-param>
					</xsl:call-template>
					<xsl:value-of select="concat($tab1, @name, ' = CStr(UBound(tRecs))', $cr, $cr)"/>
				</xsl:if>

				<xsl:call-template name="VBMethodEnd">
					<xsl:with-param name="type">Function</xsl:with-param>
					<xsl:with-param name="isado" select="false()"/>
					<xsl:with-param name="ismts" select="false()"/>
				</xsl:call-template>
			</xsl:for-each>
		</xsl:if>

		<!--==================================================================-->
		<!-- METHOD: FIND (CUSTOM) -->
		<!--==================================================================-->
		<xsl:for-each select="/Data/WTENTITY/WTPROCEDURES/WTPROCEDURE[@type='Find' and @template='new']">
			
			<xsl:value-of select="$cr"/>
			<xsl:call-template name="VBMethodStart">
				<xsl:with-param name="type">Function</xsl:with-param>
				<xsl:with-param name="name" select="@name"/>
			</xsl:call-template>
			<xsl:if test="WTBOOKMARK">
				<xsl:call-template name="VBParam">
					<xsl:with-param name="name">BookMark</xsl:with-param>
					<xsl:with-param name="type">text</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<xsl:call-template name="VBParam">
				<xsl:with-param name="name">SearchText</xsl:with-param>
				<xsl:with-param name="type">text</xsl:with-param>
			</xsl:call-template>
			<xsl:if test="WTBOOKMARK">
				<xsl:call-template name="VBParam">
					<xsl:with-param name="name">Direction</xsl:with-param>
					<xsl:with-param name="type">wtSystem.WTBookmarkConstants</xsl:with-param>
					<xsl:with-param name="continue" select="count(WTPARAM)&gt;0"/>
				</xsl:call-template>
			</xsl:if>

			<xsl:for-each select="WTPARAM">
				<xsl:call-template name="VBParam">
					<xsl:with-param name="parameter" select="."/>
					<xsl:with-param name="continue" select="not(position()=last())"/>
				</xsl:call-template>
			</xsl:for-each>

			<xsl:value-of select="concat($tab0, ')')"/>
			<xsl:call-template name="VBDataType">
				<xsl:with-param name="datatype">text</xsl:with-param>
			</xsl:call-template>
			<xsl:value-of select="$cr"/>

			<xsl:call-template name="VBFunctionBox">
				<xsl:with-param name="name" select="@name"/>
				<xsl:with-param name="desc">Returns a list of records which match the specified search criteria.</xsl:with-param>
				<xsl:with-param name="ismts" select="false()"/>
				<xsl:with-param name="isado" select="false()"/>
			</xsl:call-template>

			<xsl:call-template name="VBVariable">
				<xsl:with-param name="indent">1</xsl:with-param>
				<xsl:with-param name="scope">Dim</xsl:with-param>
				<xsl:with-param name="name">oItem</xsl:with-param>
				<xsl:with-param name="type">useritem</xsl:with-param>
			</xsl:call-template>

			<xsl:call-template name="VBVariable">
				<xsl:with-param name="indent">1</xsl:with-param>
				<xsl:with-param name="scope">Dim</xsl:with-param>
				<xsl:with-param name="name">tRecs()</xsl:with-param>
				<xsl:with-param name="type">busnrecord</xsl:with-param>
			</xsl:call-template>

			<xsl:call-template name="VBVariable">
				<xsl:with-param name="indent">1</xsl:with-param>
				<xsl:with-param name="scope">Dim</xsl:with-param>
				<xsl:with-param name="name">idxRec</xsl:with-param>
				<xsl:with-param name="type">number</xsl:with-param>
			</xsl:call-template>
			<xsl:if test="WTBOOKMARK">
				<xsl:call-template name="VBVariable">
					<xsl:with-param name="indent">1</xsl:with-param>
					<xsl:with-param name="scope">Dim</xsl:with-param>
					<xsl:with-param name="name">sBookMark</xsl:with-param>
					<xsl:with-param name="type">text</xsl:with-param>
				</xsl:call-template>
			</xsl:if>

			<xsl:value-of select="$cr"/>

			<xsl:call-template name="VBStartErrorHandler"/>

			<xsl:value-of select="concat($tab1, 'Set moItems = Nothing', $cr)"/>
			<xsl:value-of select="concat($tab1, 'Set moItems = New Collection', $cr, $cr)"/>

			<xsl:if test="WTBOOKMARK">
				<xsl:value-of select="concat($tab1, 'sBookMark = bvBookMark', $cr)"/>
				<xsl:value-of select="concat($tab1, 'tRecs = BusnService.', @name, '(sBookMark, bvSearchText, bvDirection')"/>
			</xsl:if>
			<xsl:if test="WTSEARCH">
				<xsl:value-of select="concat($tab1, 'tRecs = BusnService.', @name, '( bvSearchText, bvDirection')"/>
			</xsl:if>

			<!--==========add additional params==========-->
			<xsl:for-each select="WTPARAM">
				<xsl:variable name="nametype"><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="@name"/></xsl:call-template></xsl:variable>
				<xsl:variable name="nametext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@name"/></xsl:call-template></xsl:variable>
				<xsl:choose>
					<xsl:when test="($nametype='ATTR')"><xsl:value-of select="concat(', bv', /Data/WTENTITY/WTATTRIBUTE[@name=$nametext]/@name)"/></xsl:when>
					<xsl:when test="($nametype='SYS') and ($nametext='userid')"><xsl:value-of select="(', bvSecurityToken')"/></xsl:when>
				</xsl:choose>
			</xsl:for-each>

			<xsl:value-of select="concat(')', $cr, $cr)"/>

			<xsl:value-of select="concat($tab1, 'For idxRec = 1 To UBound(tRecs)', $cr)"/>
			<xsl:value-of select="concat($tab2, 'Set oItem = New ', $userproj, $itemclass, '', $cr)"/>
			<xsl:if test="/Data/WTPAGE/@multi-instance">
				<xsl:value-of select="concat($tab2, 'oItem.SysClientProject mClient, mProject', $cr)"/>
			</xsl:if>
			<xsl:value-of select="concat($tab2, 'oItem.DataRec = tRecs(idxRec)', $cr)"/>
			<xsl:value-of select="concat($tab2, 'moItems.Add oItem, CStr(oItem.', $identityfield, ')', $cr)"/>
			<xsl:value-of select="concat($tab1, 'Next idxRec', $cr, $cr)"/>

			<xsl:if test="WTBOOKMARK">
				<xsl:call-template name="VBComment">
					<xsl:with-param name="value">return the new bookmark</xsl:with-param>
					<xsl:with-param name="indent">1</xsl:with-param>
				</xsl:call-template>
				<xsl:value-of select="concat($tab1, @name, ' = sBookMark', $cr, $cr)"/>
			</xsl:if>
			<xsl:if test="WTSEARCH">
				<xsl:call-template name="VBComment">
					<xsl:with-param name="value">return list count</xsl:with-param>
					<xsl:with-param name="indent">1</xsl:with-param>
				</xsl:call-template>
				<xsl:value-of select="concat($tab1, @name, ' = CStr(UBound(tRecs))', $cr, $cr)"/>
			</xsl:if>

			<xsl:call-template name="VBMethodEnd">
				<xsl:with-param name="type">Function</xsl:with-param>
				<xsl:with-param name="isado" select="false()"/>
				<xsl:with-param name="ismts" select="false()"/>
			</xsl:call-template>
		</xsl:for-each>

		<!--==================================================================-->
		<!-- PROPERTY: FINDTYPEID -->
		<!--==================================================================-->
		<xsl:if test="($hasfind)">
			<xsl:call-template name="VBProperty">
				<xsl:with-param name="name">FindTypeID</xsl:with-param>
				<xsl:with-param name="type">text</xsl:with-param>
				<xsl:with-param name="isdatarec" select="false()"/>
			</xsl:call-template>
		</xsl:if>

		<!--==================================================================-->
		<!-- METHOD: INIT -->
		<!--==================================================================-->
		<xsl:if test="WTPROCEDURES/WTPROCEDURE[@type='Init' and not(@template='new')]">
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
			<xsl:call-template name="VBParentSetColl"/>

			<xsl:call-template name="VBMethodEnd">
				<xsl:with-param name="type">Sub</xsl:with-param>
				<xsl:with-param name="isado" select="false()"/>
				<xsl:with-param name="ismts" select="false()"/>
			</xsl:call-template>
		</xsl:if>

		<!--==================================================================-->
		<!-- METHOD: ITEM -->
		<!--==================================================================-->
		<xsl:if test="count(/Data/WTENTITY/WTPROCEDURES/WTPROCEDURE[@type='Fetch' and not(@template='new')]) > 0">
			<xsl:value-of select="$cr"/>
			<xsl:call-template name="VBMethodStart">
				<xsl:with-param name="type">Function</xsl:with-param>
				<xsl:with-param name="name">Item</xsl:with-param>
			</xsl:call-template>
			
			<xsl:call-template name="VBParam">
		  			<xsl:with-param name="name" select="'Pos'"/>
		  			<xsl:with-param name="type" select="'number'"/>
		  			<xsl:with-param name="optional" select="true()"/>
		  			<xsl:with-param name="default" select="'0'"/>
			</xsl:call-template>
			<xsl:call-template name="VBParam">
		  			<xsl:with-param name="name" select="'Key'"/>
		  			<xsl:with-param name="type" select="'text'"/>
		  			<xsl:with-param name="optional" select="true()"/>
		  			<xsl:with-param name="default" select="'&quot;&quot;'"/>
			</xsl:call-template>
			  
			<xsl:call-template name="VBSecurityParam"/>
			<xsl:value-of select="concat($tab0, ')')"/>
			<xsl:call-template name="VBDataType">
				<xsl:with-param name="datatype">useritem</xsl:with-param>
			</xsl:call-template>
			<xsl:value-of select="$cr"/>

			<xsl:call-template name="VBFunctionBox">
				<xsl:with-param name="name">Item</xsl:with-param>
				<xsl:with-param name="desc">Retrieves an item from the collection.</xsl:with-param>
				<xsl:with-param name="ismts" select="false()"/>
				<xsl:with-param name="isado" select="false()"/>
			</xsl:call-template>

			<xsl:call-template name="VBVariable">
				<xsl:with-param name="indent">1</xsl:with-param>
				<xsl:with-param name="scope">Dim</xsl:with-param>
				<xsl:with-param name="name">oItem</xsl:with-param>
				<xsl:with-param name="type">useritem</xsl:with-param>
			</xsl:call-template>

			<xsl:call-template name="VBStartErrorHandler"/>
			<xsl:call-template name="VBSecuritySet"/>

			<xsl:value-of select="concat($tab1, 'If Not (moItems Is Nothing) Then', $cr)"/>
			<xsl:call-template name="VBComment">
				<xsl:with-param name="value">if the collection has been loaded then return the item from the collection</xsl:with-param>
				<xsl:with-param name="indent">2</xsl:with-param>
			</xsl:call-template>
			<xsl:value-of select="concat($tab2, 'If bvPos &gt; 0 Then', $cr)"/>
			<xsl:value-of select="concat($tab3, 'Set oItem = moItems.Item(bvPos)', $cr)"/>
			<xsl:value-of select="concat($tab2, 'Else', $cr)"/>
			<xsl:value-of select="concat($tab3, 'If bvKey &lt;&gt; &quot;&quot; Then', $cr)"/>
			<xsl:value-of select="concat($tab4, 'Set oItem = moItems.Item(bvKey)', $cr)"/>
			<xsl:value-of select="concat($tab3, 'End If', $cr)"/>
			<xsl:value-of select="concat($tab2, 'End If', $cr)"/>
			
			<xsl:value-of select="concat($tab1, 'Else', $cr)"/>
			<xsl:value-of select="concat($tab2, 'If bvKey &lt;&gt; &quot;&quot; Then', $cr)"/>
			<xsl:call-template name="VBComment">
				<xsl:with-param name="value">if the collection has not been loaded then create a new item and return it</xsl:with-param>
				<xsl:with-param name="indent">3</xsl:with-param>
			</xsl:call-template>
			<xsl:value-of select="concat($tab3, 'Set oItem = New ', $userproj, $itemclass, '', $cr)"/>
			<xsl:value-of select="concat($tab3, 'With oItem', $cr)"/>
			<xsl:if test="/Data/WTPAGE/@multi-instance">
				<xsl:value-of select="concat($tab4, '.SysClientProject mClient, mProject', $cr)"/>
			</xsl:if>
			<xsl:call-template name="VBItemInit">
				<xsl:with-param name="indent">4</xsl:with-param>
			</xsl:call-template>
			<xsl:value-of select="concat($tab4, '.Load bvKey, mSecurityToken', $cr)"/>
			<xsl:value-of select="concat($tab3, 'End With', $cr)"/>
			<xsl:value-of select="concat($tab2, 'End If', $cr)"/>
			<xsl:value-of select="concat($tab1, 'End If', $cr, $cr)"/>
	  
			<xsl:call-template name="VBComment">
				<xsl:with-param name="value">return the item</xsl:with-param>
				<xsl:with-param name="indent">1</xsl:with-param>
			</xsl:call-template>
			<xsl:value-of select="concat($tab1, 'Set Item = oItem', $cr, $cr)"/>

			<xsl:value-of select="concat($tab1, 'Exit Function', $cr, $cr, 'ErrorHandler:', $cr)"/>
			<xsl:value-of select="concat($tab1, 'Select Case Err.Number', $cr)"/>
			<xsl:value-of select="concat($tab2, 'Case 5, 9, 91:', $cr)"/>
			<xsl:value-of select="concat($tab3, 'Err.Clear', $cr)"/>
			<xsl:value-of select="concat($tab3, 'Set Item = Nothing', $cr)"/>
			<xsl:value-of select="concat($tab3, 'Exit Function', $cr)"/>
			<xsl:value-of select="concat($tab2, 'Case Else:', $cr)"/>
			<xsl:value-of select="concat($tab3, 'CatchError ErrNo, ErrSrc, ErrDesc, cModName, cProcName', $cr)"/>
			<xsl:value-of select="concat($tab3, 'If Err.Number = 0 Then Resume Next', $cr)"/>
			<xsl:value-of select="concat($tab3, 'Err.Raise ErrNo, ErrSrc, ErrDesc', $cr)"/>
			<xsl:value-of select="concat($tab1, 'End Select', $cr)"/>
			<xsl:value-of select="concat($tab0, 'End Function', $cr)"/>
		  </xsl:if>

		<!--==================================================================-->
		<!-- METHOD: LIST (CUSTOM) -->
		<!--==================================================================-->
		<xsl:for-each select="WTPROCEDURES/WTPROCEDURE[(@type='List') and (@template='new') and (@passthru='true')]">
			<xsl:value-of select="$cr"/>
			<xsl:call-template name="VBMethodStart">
				<xsl:with-param name="type">Sub</xsl:with-param>
				<xsl:with-param name="name" select="@name"/>
				<xsl:with-param name="noparams" select="count(WTPARAM[@direction='input'])=0"/>
			</xsl:call-template>

			<!--input parameters-->
			<xsl:apply-templates select="WTPARAM[@direction='input']" mode="inputparam">
				<xsl:with-param name="indent">1</xsl:with-param>
				<xsl:with-param name="functype">sub</xsl:with-param>
			</xsl:apply-templates>
			<xsl:if test="not(WTPARAM[@direction='input'])">
				<xsl:value-of select="$cr"/>
			</xsl:if>

			<xsl:call-template name="VBFunctionBox">
				<xsl:with-param name="name" select="@name"/>
				<xsl:with-param name="desc">Initializes the collection.</xsl:with-param>
				<xsl:with-param name="ismts" select="false()"/>
				<xsl:with-param name="isado" select="false()"/>
			</xsl:call-template>

			<xsl:call-template name="VBVariable">
				<xsl:with-param name="indent">1</xsl:with-param>
				<xsl:with-param name="scope">Dim</xsl:with-param>
				<xsl:with-param name="name">oItem</xsl:with-param>
				<xsl:with-param name="type">useritem</xsl:with-param>
			</xsl:call-template>

			<xsl:call-template name="VBVariable">
				<xsl:with-param name="indent">1</xsl:with-param>
				<xsl:with-param name="scope">Dim</xsl:with-param>
				<xsl:with-param name="name">tRecs()</xsl:with-param>
				<xsl:with-param name="type">busnrecord</xsl:with-param>
			</xsl:call-template>

			<xsl:call-template name="VBVariable">
				<xsl:with-param name="indent">1</xsl:with-param>
				<xsl:with-param name="scope">Dim</xsl:with-param>
				<xsl:with-param name="name">idxRec</xsl:with-param>
				<xsl:with-param name="type">number</xsl:with-param>
			</xsl:call-template>
			<xsl:value-of select="$cr"/>

			<xsl:call-template name="VBStartErrorHandler"/>

			<!--set security param-->
			<xsl:apply-templates select="WTPARAM[(@direction='input') and (@name='SYS(userid)')]" mode="setparam">
				<xsl:with-param name="indent">1</xsl:with-param>
			</xsl:apply-templates>

			<xsl:value-of select="concat($tab1, 'Set moItems = Nothing', $cr)"/>
			<xsl:value-of select="concat($tab1, 'Set moItems = New Collection', $cr, $cr)"/>

			<!--call business service function-->
			<xsl:apply-templates select="WTPARAM[(@direction='input')]" mode="callbusn">
				<xsl:with-param name="indent">1</xsl:with-param>
				<xsl:with-param name="functype">function</xsl:with-param>
			</xsl:apply-templates>

			<xsl:if test="not(WTPARAM[@direction='input'])">
				<xsl:value-of select="concat($tab1, 'tRecs = BusnService.', @name, '()', $cr, $cr)"/>
			</xsl:if>

			<xsl:value-of select="concat($tab1, 'For idxRec = 1 To UBound(tRecs)', $cr)"/>
			<xsl:value-of select="concat($tab2, 'Set oItem = New ', $userproj, $itemclass, '', $cr)"/>
			<xsl:if test="/Data/WTPAGE/@multi-instance">
				<xsl:value-of select="concat($tab2, 'oItem.SysClientProject mClient, mProject', $cr)"/>
			</xsl:if>

			<!--initialize the new child object-->
			<xsl:if test="/Data/WTENTITY/WTPROCEDURES/WTPROCEDURE[(@type='Init')]">
				<xsl:value-of select="concat($tab2, 'oItem.Init ')"/>
				<xsl:for-each select="$parentfields">
					<xsl:value-of select="concat('m', @name, ', ')"/>
				</xsl:for-each>
				<xsl:value-of select="concat('mSecurityToken', $cr)"/>
			</xsl:if>

			<xsl:value-of select="concat($tab2, 'oItem.DataRec = tRecs(idxRec)', $cr)"/>
			<xsl:value-of select="concat($tab2, 'moItems.Add oItem, CStr(oItem.', $identityfield, ')', $cr)"/>
			<xsl:value-of select="concat($tab1, 'Next idxRec', $cr, $cr)"/>

			<xsl:call-template name="VBMethodEnd">
				<xsl:with-param name="type">Sub</xsl:with-param>
				<xsl:with-param name="isado" select="false()"/>
				<xsl:with-param name="ismts" select="false()"/>
			</xsl:call-template>
		</xsl:for-each>

		<!--==================================================================-->
		<!-- METHOD: LOAD -->
		<!--==================================================================-->
		<xsl:choose>
			<xsl:when test="($haslist)">

				<!--generate one load method for each List procedure-->
				<xsl:for-each select="/Data/WTENTITY/WTPROCEDURES/WTPROCEDURE[(@type='List') and not(@template)]">
					<xsl:variable name="listname">
						<xsl:call-template name="StripText">
							<xsl:with-param name="value" select="@name"/>
						</xsl:call-template>
					</xsl:variable>
					<xsl:variable name="loadname" select="concat(substring-before($listname,'List'), 'Load', substring-after($listname, 'List'))"/>
					<xsl:variable name="listparams" select="(WTPARAM[@name!='#'])"/>

					<xsl:value-of select="$cr"/>
					<xsl:call-template name="VBMethodStart">
						<xsl:with-param name="type">Sub</xsl:with-param>
						<xsl:with-param name="name" select="$loadname"/>
					</xsl:call-template>

					<xsl:call-template name="VBParam">
						<xsl:with-param name="name">ListType</xsl:with-param>
						<xsl:with-param name="type" select="concat($userproj, $appprefix, $entityname, 'ListTypeConstants')"/>
					</xsl:call-template>

					<xsl:if test="$multilist">
						<xsl:call-template name="VBParam">
							<xsl:with-param name="name">ParentID</xsl:with-param>
							<xsl:with-param name="type">number</xsl:with-param>
							<xsl:with-param name="optional" select="true()"/>
							<xsl:with-param name="default">0</xsl:with-param>
						</xsl:call-template>
					</xsl:if>

					<xsl:call-template name="VBSecurityParam"/>
					<xsl:value-of select="concat(')', $cr)"/>

					<xsl:call-template name="VBFunctionBox">
						<xsl:with-param name="name" select="$loadname"/>
						<xsl:with-param name="desc">Initializes the collection.</xsl:with-param>
						<xsl:with-param name="ismts" select="false()"/>
						<xsl:with-param name="isado" select="false()"/>
					</xsl:call-template>

					<xsl:call-template name="VBVariable">
						<xsl:with-param name="indent">1</xsl:with-param>
						<xsl:with-param name="scope">Dim</xsl:with-param>
						<xsl:with-param name="name">oItem</xsl:with-param>
						<xsl:with-param name="type">useritem</xsl:with-param>
					</xsl:call-template>
					
					<xsl:call-template name="VBVariable">
						<xsl:with-param name="indent">1</xsl:with-param>
						<xsl:with-param name="scope">Dim</xsl:with-param>
						<xsl:with-param name="name">tRecs()</xsl:with-param>
						<xsl:with-param name="type">busnrecord</xsl:with-param>
					</xsl:call-template>
					
					<xsl:call-template name="VBVariable">
						<xsl:with-param name="indent">1</xsl:with-param>
						<xsl:with-param name="scope">Dim</xsl:with-param>
						<xsl:with-param name="name">idxRec</xsl:with-param>
						<xsl:with-param name="type">number</xsl:with-param>
					</xsl:call-template>
					<xsl:value-of select="$cr"/>

					<xsl:call-template name="VBStartErrorHandler"/>
					<xsl:call-template name="VBSecuritySet"/>

					<!--set the list type id-->
					<xsl:call-template name="VBComment">
						<xsl:with-param name="value">set the list type ID</xsl:with-param>
						<xsl:with-param name="indent">1</xsl:with-param>
					</xsl:call-template>
					<xsl:value-of select="concat($tab1, 'ListTypeID = bvListType', $cr)"/>
					<xsl:if test="($hasfind)">
						<xsl:value-of select="concat($tab1, 'FindTypeID = 0', $cr)"/>
					</xsl:if>
					<xsl:value-of select="$cr"/>

					<xsl:value-of select="concat($tab1, 'Set moItems = Nothing', $cr)"/>
					<xsl:value-of select="concat($tab1, 'Set moItems = New Collection', $cr, $cr)"/>

					<!--populate the collection with child items-->
					<xsl:value-of select="concat($tab1, 'tRecs = BusnService.', $listname, '(bvListType, ')"/>
					<xsl:if test="($multilist)">
							<xsl:value-of select="concat($tab0, 'bvParentID, ')"/>
					</xsl:if>
					<xsl:value-of select="concat($tab0, 'mSecurityToken)', $cr, $cr)"/>

					<xsl:value-of select="concat($tab1, 'For idxRec = 1 To UBound(tRecs)', $cr)"/>
					<xsl:value-of select="concat($tab2, 'Set oItem = New ', $userproj, $itemclass, '', $cr)"/>
					<xsl:if test="/Data/WTPAGE/@multi-instance">
						<xsl:value-of select="concat($tab2, 'oItem.SysClientProject mClient, mProject', $cr)"/>
					</xsl:if>
					<xsl:value-of select="concat($tab2, 'oItem.DataRec = tRecs(idxRec)', $cr)"/>

					<!--set my real parent ID from the recordset, since I might not have it from the method call-->
					<xsl:if test="($ischild)">
						<xsl:for-each select="$parentfields">
							<xsl:value-of select="concat($tab2, 'm', @name, ' = oItem.', @name, '', $cr)"/>
						</xsl:for-each>
					</xsl:if>		

					<xsl:call-template name="VBItemInit">
						<xsl:with-param name="indent">2</xsl:with-param>
						<xsl:with-param name="objname">oItem</xsl:with-param>
					</xsl:call-template>

					<xsl:value-of select="concat($tab2, 'moItems.Add oItem, CStr(oItem.', $identityfield, ')', $cr)"/>
					<xsl:value-of select="concat($tab1, 'Next idxRec', $cr, $cr)"/>

					<xsl:call-template name="VBMethodEnd">
						<xsl:with-param name="type">Sub</xsl:with-param>
						<xsl:with-param name="isado" select="false()"/>
						<xsl:with-param name="ismts" select="false()"/>
					</xsl:call-template>
				</xsl:for-each>
			</xsl:when>

			<xsl:otherwise>
				<!--generate a default Load method for the object if it has no list procedures-->
				<xsl:value-of select="$cr"/>
				<xsl:call-template name="VBMethodStart">
					<xsl:with-param name="type">Sub</xsl:with-param>
					<xsl:with-param name="name">Load</xsl:with-param>
				</xsl:call-template>
			
				<xsl:call-template name="VBSecurityParam"/>
				<xsl:value-of select="concat(')', $cr)"/>

				<xsl:call-template name="VBFunctionBox">
					<xsl:with-param name="name">Load</xsl:with-param>
					<xsl:with-param name="desc">Initializes the collection.</xsl:with-param>
					<xsl:with-param name="ismts" select="false()"/>
					<xsl:with-param name="isado" select="false()"/>
				</xsl:call-template>

				<xsl:call-template name="VBVariable">
					<xsl:with-param name="indent">1</xsl:with-param>
					<xsl:with-param name="scope">Dim</xsl:with-param>
					<xsl:with-param name="name">oItem</xsl:with-param>
					<xsl:with-param name="type">useritem</xsl:with-param>
				</xsl:call-template>

				<xsl:call-template name="VBVariable">
					<xsl:with-param name="indent">1</xsl:with-param>
					<xsl:with-param name="scope">Dim</xsl:with-param>
					<xsl:with-param name="name">tRecs()</xsl:with-param>
					<xsl:with-param name="type">busnrecord</xsl:with-param>
				</xsl:call-template>

				<xsl:call-template name="VBVariable">
					<xsl:with-param name="indent">1</xsl:with-param>
					<xsl:with-param name="scope">Dim</xsl:with-param>
					<xsl:with-param name="name">idxRec</xsl:with-param>
					<xsl:with-param name="type">number</xsl:with-param>
				</xsl:call-template>
				<xsl:value-of select="$cr"/>

				<xsl:call-template name="VBStartErrorHandler"/>
				<xsl:call-template name="VBSecuritySet"/>

				<xsl:value-of select="concat($tab1, 'Set moItems = Nothing', $cr)"/>
				<xsl:value-of select="concat($tab1, 'Set moItems = New Collection', $cr, $cr)"/>

				<xsl:call-template name="VBMethodEnd">
					<xsl:with-param name="type">Sub</xsl:with-param>
					<xsl:with-param name="isado" select="false()"/>
					<xsl:with-param name="ismts" select="false()"/>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>

		<!--==================================================================-->
		<!-- PROPERTY: LISTTYPEID -->
		<!--==================================================================-->
		<xsl:if test="($haslist)">
			<xsl:call-template name="VBProperty">
				<xsl:with-param name="name">ListTypeID</xsl:with-param>
				<xsl:with-param name="type">text</xsl:with-param>
				<xsl:with-param name="isdatarec" select="false()"/>
			</xsl:call-template>
		</xsl:if>

		<!--==================================================================-->
		<!-- METHOD: NEWENUM -->
		<!--==================================================================-->
		<xsl:value-of select="$cr"/>
		<xsl:call-template name="VBMethodStart">
			<xsl:with-param name="type">Function</xsl:with-param>
			<xsl:with-param name="name">NewEnum</xsl:with-param>
			<xsl:with-param name="noparams" select="true()"/>
		</xsl:call-template>
		<xsl:call-template name="VBDataType">
			<xsl:with-param name="datatype">IUnknown</xsl:with-param>
		</xsl:call-template>
		<xsl:value-of select="$cr"/>

		<xsl:value-of select="concat('Attribute NewEnum.VB_UserMemId = -4', $cr)"/>
		<xsl:value-of select="concat('Attribute NewEnum.VB_MemberFlags = &quot;40&quot;', $cr)"/>

		<xsl:call-template name="VBFunctionBox">
			<xsl:with-param name="name">NewEnum</xsl:with-param>
			<xsl:with-param name="desc">Enables For...Next iteration on the collection.</xsl:with-param>
			<xsl:with-param name="ismts" select="false()"/>
			<xsl:with-param name="isado" select="false()"/>
		</xsl:call-template>

		<xsl:call-template name="VBStartErrorHandler"/>

		<xsl:value-of select="concat($tab1, 'If Not (moItems Is Nothing) Then', $cr)"/>
		<xsl:value-of select="concat($tab2, 'Set NewEnum = moItems.[_NewEnum]', $cr)"/>
		<xsl:value-of select="concat($tab1, 'End If', $cr, $cr)"/>

		<xsl:call-template name="VBMethodEnd">
			<xsl:with-param name="type">Function</xsl:with-param>
			<xsl:with-param name="isado" select="false()"/>
			<xsl:with-param name="ismts" select="false()"/>
		</xsl:call-template>

		<!--==================================================================-->
		<!-- METHOD: PURGE -->
		<!--==================================================================-->
		<xsl:if test="count(/Data/WTENTITY/WTPROCEDURES/WTPROCEDURE[@type='Delete' and @name='Purge']) > 0">
			<xsl:value-of select="$cr"/>
			<xsl:call-template name="VBMethodStart">
				<xsl:with-param name="type">Sub</xsl:with-param>
				<xsl:with-param name="name">Purge</xsl:with-param>
			</xsl:call-template>

			<xsl:call-template name="VBParamParent"/>
			<xsl:call-template name="VBSecurityParam">
				<xsl:with-param name="continue" select="false()"/>
			</xsl:call-template>

			<xsl:value-of select="concat(')', $cr)"/>

			<xsl:call-template name="VBFunctionBox">
				<xsl:with-param name="name">Purge</xsl:with-param>
				<xsl:with-param name="desc">Purges all but the most current child record.</xsl:with-param>
				<xsl:with-param name="ismts" select="false()"/>
				<xsl:with-param name="isado" select="false()"/>
			</xsl:call-template>

			<xsl:call-template name="VBStartErrorHandler"/>
			<xsl:call-template name="VBSecuritySet"/>
			<xsl:call-template name="VBParentSetColl"/>

			<xsl:value-of select="concat($tab1, 'BusnService.Purge ')"/>
			<xsl:call-template name="VBParentCall"/>
			<xsl:value-of select="concat('mSecurityToken', $cr, $cr)"/>

			<xsl:call-template name="VBMethodEnd">
				<xsl:with-param name="type">Sub</xsl:with-param>
				<xsl:with-param name="isado" select="false()"/>
				<xsl:with-param name="ismts" select="false()"/>
			</xsl:call-template>
		</xsl:if>

	 <!--==================================================================-->
	 <!-- METHOD: Search -->
	 <!--==================================================================-->
	 <xsl:for-each select="/Data/WTENTITY/WTPROCEDURES/WTPROCEDURE[@type='Search']">
		  <xsl:value-of select="$cr"/>
		  <xsl:call-template name="VBMethodStart">
				<xsl:with-param name="type">Function</xsl:with-param>
				<xsl:with-param name="name" select="@name"/>
				<xsl:with-param name="noparams" select="false()"/>
		  </xsl:call-template>

		  <xsl:value-of select="'ByVal bvSearch As String )'"/>

		  <xsl:call-template name="VBDataType">
				<xsl:with-param name="datatype">useritem</xsl:with-param>
		  </xsl:call-template>
		  <xsl:value-of select="$cr"/>

		  <xsl:call-template name="VBFunctionBox">
				<xsl:with-param name="name" select="@name"/>
				<xsl:with-param name="desc">Search for an item in a collection.</xsl:with-param>
				<xsl:with-param name="ismts" select="false()"/>
				<xsl:with-param name="isado" select="false()"/>
		  </xsl:call-template>

		  <xsl:call-template name="VBVariable">
				<xsl:with-param name="indent">1</xsl:with-param>
				<xsl:with-param name="scope">Dim</xsl:with-param>
				<xsl:with-param name="name">oItem</xsl:with-param>
				<xsl:with-param name="type">useritem</xsl:with-param>
		  </xsl:call-template>

		  <xsl:call-template name="VBStartErrorHandler"/>
		  		
		  <xsl:value-of select="concat($tab1, 'If Not (moItems Is Nothing) Then', $cr)"/>
		  <xsl:value-of select="concat($tab2, 'If moItems.Count > 0 Then', $cr)"/>
		  <xsl:value-of select="concat($tab3, 'For Each oItem In moItems', $cr)"/>
		  <xsl:value-of select="concat($tab4, 'If oItem.', @search, ' = bvSearch Then', $cr)"/>
		  <xsl:value-of select="concat($tab5, 'Set ', @name, ' = oItem', $cr)"/>
		  <xsl:value-of select="concat($tab5, 'Exit For', $cr)"/>
		  <xsl:value-of select="concat($tab4, 'End If', $cr)"/>
		  <xsl:value-of select="concat($tab3, 'Next oItem', $cr)"/>
		  <xsl:value-of select="concat($tab2, 'End If', $cr)"/>
		  <xsl:value-of select="concat($tab1, 'End If', $cr, $cr)"/>

		  <xsl:call-template name="VBMethodEnd">
				<xsl:with-param name="type">Function</xsl:with-param>
				<xsl:with-param name="isado" select="false()"/>
				<xsl:with-param name="ismts" select="false()"/>
		  </xsl:call-template>
	 			
	 </xsl:for-each>

		<!--==================================================================-->
		<!-- METHOD: Sum -->
		<!--==================================================================-->
		<xsl:if test="count(/Data/WTENTITY/WTATTRIBUTE[@sum]) > 0">
			<xsl:value-of select="$cr"/>
			<xsl:call-template name="VBMethodStart">
				<xsl:with-param name="type">Function</xsl:with-param>
				<xsl:with-param name="name">Sum</xsl:with-param>
				<xsl:with-param name="noparams" select="false()"/>
			</xsl:call-template>

			<xsl:value-of select="concat('   ByVal bvAttr As String, _', $cr)"/>
			<xsl:value-of select="concat('   Optional ByVal bvFormat As Boolean = ', 'True)')"/>

			<xsl:call-template name="VBDataType">
				<xsl:with-param name="datatype">text</xsl:with-param>
			</xsl:call-template>
			<xsl:value-of select="$cr"/>

			<xsl:call-template name="VBFunctionBox">
				<xsl:with-param name="name">Sum</xsl:with-param>
				<xsl:with-param name="desc">Returns the Sum of the specified Attribute.</xsl:with-param>
				<xsl:with-param name="ismts" select="false()"/>
				<xsl:with-param name="isado" select="false()"/>
			</xsl:call-template>

			<xsl:call-template name="VBVariable">
				<xsl:with-param name="indent">1</xsl:with-param>
				<xsl:with-param name="scope">Dim</xsl:with-param>
				<xsl:with-param name="name">oItem</xsl:with-param>
				<xsl:with-param name="type">useritem</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="VBVariable">
				<xsl:with-param name="indent">1</xsl:with-param>
				<xsl:with-param name="scope">Dim</xsl:with-param>
				<xsl:with-param name="name">AttrID</xsl:with-param>
				<xsl:with-param name="type">number</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="VBVariable">
				<xsl:with-param name="indent">1</xsl:with-param>
				<xsl:with-param name="scope">Dim</xsl:with-param>
				<xsl:with-param name="name">lSum</xsl:with-param>
				<xsl:with-param name="type">number</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="VBVariable">
				<xsl:with-param name="indent">1</xsl:with-param>
				<xsl:with-param name="scope">Dim</xsl:with-param>
				<xsl:with-param name="name">dSum</xsl:with-param>
				<xsl:with-param name="type">decimal</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="VBVariable">
				<xsl:with-param name="indent">1</xsl:with-param>
				<xsl:with-param name="scope">Dim</xsl:with-param>
				<xsl:with-param name="name">cSum</xsl:with-param>
				<xsl:with-param name="type">currency</xsl:with-param>
			</xsl:call-template>
			<xsl:value-of select="$cr"/>
	
			<xsl:call-template name="VBStartErrorHandler"/>

			<!-- translate the attribute name to it's id -->
			<xsl:value-of select="concat($tab1, 'Select Case bvAttr', $cr)"/>
			<xsl:for-each select="/Data/WTENTITY/WTATTRIBUTE[@sum]">
				<xsl:value-of select="concat($tab2, 'Case &quot;', @name, '&quot;: AttrID = ', @id, $cr)"/>
			</xsl:for-each>
			<xsl:value-of select="concat($tab1, 'End Select', $cr, $cr)"/>

			<xsl:value-of select="concat($tab1, 'If Not (moItems Is Nothing) Then', $cr)"/>
			<xsl:value-of select="concat($tab2, 'If moItems.Count > 0 Then', $cr)"/>
			<xsl:value-of select="concat($tab3, 'For Each oItem In moItems', $cr)"/>
		
			<!-- accumuate the value -->
			<xsl:value-of select="concat($tab4, 'Select Case AttrID', $cr)"/>
			<xsl:for-each select="/Data/WTENTITY/WTATTRIBUTE[@sum]">
				<xsl:value-of select="concat($tab5, 'Case ', @id, ': If oItem.', @name, '&lt;&gt;&quot;&quot; Then ')"/>
				<xsl:choose>
					<xsl:when test="@type='currency'">
						<xsl:value-of select="concat('cSum = cSum + CCur(oItem.', @name, ')', $cr)"/>
					</xsl:when>
					<xsl:when test="@type='number'">
						<xsl:value-of select="concat('lSum = lSum + CLng(oItem.', @name, ')', $cr)"/>
					</xsl:when>
					<xsl:when test="@type='decimal'">
						<xsl:value-of select="concat('dSum = dSum + CDbl(oItem.', @name, ')', $cr)"/>
					</xsl:when>
				</xsl:choose>
			</xsl:for-each>
			<xsl:value-of select="concat($tab4, 'End Select', $cr)"/>
		
			<xsl:value-of select="concat($tab3, 'Next oItem', $cr)"/>
			<xsl:value-of select="concat($tab2, 'End If', $cr)"/>
			<xsl:value-of select="concat($tab1, 'End If', $cr, $cr)"/>

			<!-- get the return value -->
			<xsl:value-of select="concat($tab1, 'Select Case AttrID', $cr)"/>
			<xsl:for-each select="/Data/WTENTITY/WTATTRIBUTE[@sum]">
				<xsl:value-of select="concat($tab2, 'Case ', @id, ': If bvFormat Then Sum = ' )"/>
				<xsl:choose>
					<xsl:when test="@type='currency'">
						<xsl:value-of select="concat('Format$(cSum, &quot;currency&quot;) Else Sum = CStr(cSum)', $cr)"/>
					</xsl:when>
					<xsl:when test="@type='number'">
						<xsl:value-of select="concat('CStr(lSum) Else Sum = CStr(lSum)', $cr)"/>
					</xsl:when>
					<xsl:when test="@type='decimal'">
						<xsl:value-of select="concat('CStr(dSum) Else Sum = CStr(dSum)', $cr)"/>
					</xsl:when>
				</xsl:choose>
			</xsl:for-each>
			<xsl:value-of select="concat($tab1, 'End Select', $cr)"/>

			<xsl:call-template name="VBMethodEnd">
				<xsl:with-param name="type">Function</xsl:with-param>
				<xsl:with-param name="isado" select="false()"/>
				<xsl:with-param name="ismts" select="false()"/>
			</xsl:call-template>
		</xsl:if>

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
			<xsl:with-param name="desc">Returns the XML for the collection.</xsl:with-param>
			<xsl:with-param name="ismts" select="false()"/>
			<xsl:with-param name="isado" select="false()"/>
		</xsl:call-template>

		<xsl:call-template name="VBVariable">
			<xsl:with-param name="indent">1</xsl:with-param>
			<xsl:with-param name="scope">Dim</xsl:with-param>
			<xsl:with-param name="name">oItem</xsl:with-param>
			<xsl:with-param name="type">useritem</xsl:with-param>
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
		<xsl:call-template name="VBVariable">
			<xsl:with-param name="indent">1</xsl:with-param>
			<xsl:with-param name="scope">Dim</xsl:with-param>
			<xsl:with-param name="name">sXML</xsl:with-param>
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
			<xsl:with-param name="name">bFind</xsl:with-param>
			<xsl:with-param name="type">yesno</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="VBVariable">
			<xsl:with-param name="indent">1</xsl:with-param>
			<xsl:with-param name="scope">Dim</xsl:with-param>
			<xsl:with-param name="name">lEnum</xsl:with-param>
			<xsl:with-param name="type">number</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="VBVariable">
			<xsl:with-param name="indent">1</xsl:with-param>
			<xsl:with-param name="scope">Dim</xsl:with-param>
			<xsl:with-param name="name">lAttr</xsl:with-param>
			<xsl:with-param name="type">number</xsl:with-param>
		</xsl:call-template>
		<xsl:value-of select="$cr"/>
	
		<xsl:call-template name="VBStartErrorHandler"/>

		<xsl:value-of select="concat($tab1, $apos, 'Handle Common Options for collection classes', $cr)"/>
		<xsl:value-of select="concat($tab1, 'Select Case bvOption', $cr)"/>
		<xsl:value-of select="concat($tab2, 'Case 12: bvOption = 1111   ', $apos, ' attributes with all enums', $cr)"/>
		<xsl:value-of select="concat($tab2, 'Case 13: bvOption = 1001   ', $apos, ' attributes with static enums', $cr)"/>
		<xsl:value-of select="concat($tab2, 'Case 14: bvOption = 11000  ', $apos, ' find enums, attributes with no item enums', $cr)"/>
		<xsl:value-of select="concat($tab2, 'Case 15: bvOption = 11001  ', $apos, ' find enums, attributes with static enums', $cr)"/>
		<xsl:value-of select="concat($tab1, 'End Select', $cr)"/>

		<xsl:value-of select="concat($tab1, 'sOption = Format(bvOption, &quot;00000&quot;)', $cr)"/>
		<xsl:value-of select="concat($tab1, 'bFind = (Mid(sOption, 1, 1) = &quot;1&quot;)', $cr)"/>
		<xsl:value-of select="concat($tab1, 'lEnum = Val(Mid(sOption, 4, 2))', $cr)"/>
		<xsl:value-of select="concat($tab1, 'lAttr = Val(Mid(sOption, 2, 2) + &quot;00&quot;)', $cr, $cr)"/>

		<xsl:call-template name="VBComment">
			<xsl:with-param name="value">create the XML for the children</xsl:with-param>
			<xsl:with-param name="indent">1</xsl:with-param>
		</xsl:call-template>
		<xsl:value-of select="concat($tab1, 'sChildren = &quot;&quot;', $cr, $cr)"/>

		<xsl:value-of select="concat($tab1, 'If bFind Then', $cr)"/>

		<xsl:if test="($hasfind)">
	 		<xsl:value-of select="concat($tab2, 'sChildren = sChildren + EnumItems(', $appprefix, $entityname, 'EnumFindType, mSecurityToken).XML(&quot;', $appprefix, 'FindTypeIDs&quot;, FindTypeID, False)', $cr)"/>
		</xsl:if>
   
		<xsl:call-template name="VBComment">
			<xsl:with-param name="value">create the XML for the attributes</xsl:with-param>
			<xsl:with-param name="indent">2</xsl:with-param>
		</xsl:call-template>
		<xsl:value-of select="concat($tab2, 'sAttributes = &quot;&quot;', $cr, $cr)"/>

		<xsl:if test="($hasfind)">
			<xsl:value-of select="concat($tab2, 'sAttributes = sAttributes + XMLAttribute(&quot;FindTypeID&quot;, FindTypeID, False)', $cr)"/>
		</xsl:if>
		<xsl:value-of select="concat($tab1, 'End If', $cr)"/>
		
		<xsl:value-of select="$cr"/>
		<xsl:call-template name="VBComment">
			<xsl:with-param name="value">create the XML for the collection</xsl:with-param>
			<xsl:with-param name="indent">1</xsl:with-param>
		</xsl:call-template>

		<xsl:call-template name="VBComment">
			<xsl:with-param name="value">don't return XML unless the collection is loaded</xsl:with-param>
			<xsl:with-param name="indent">1</xsl:with-param>
		</xsl:call-template>

		<xsl:value-of select="concat($tab1, 'sXML = &quot;&quot;', $cr)"/>
		<xsl:value-of select="concat($tab1, 'If Not (moItems Is Nothing) Then', $cr)"/>
		<xsl:value-of select="concat($tab2, 'If moItems.Count > 0 Then', $cr)"/>
		
		<xsl:value-of select="concat($tab3, 'If lEnum &gt; 0 Then   ', $apos, ' lookup and/or static Enums Included', $cr)"/>
		<xsl:value-of select="concat($tab4, 'sChildren = sChildren + moItems.Item(1).XML(lEnum, bvElementName)', $cr)"/>
		<xsl:value-of select="concat($tab3, 'End If', $cr)"/>
		<xsl:value-of select="concat($tab3, 'If lAttr &gt; 0 Then   ', $apos, ' attributes and/or filtered enums Included', $cr)"/>

		<xsl:value-of select="concat($tab4, 'For Each oItem In moItems', $cr)"/>

		  <xsl:for-each select="$embeds">
		  		<xsl:value-of select="concat($tab5, 'oItem.EmbedText ', @id, ', emb', @name, $cr)"/>
		  </xsl:for-each>

		<xsl:value-of select="concat($tab5, 'sXML = sXML + oItem.XML(lAttr, bvElementName)', $cr)"/>
		<xsl:value-of select="concat($tab4, 'Next oItem', $cr)"/>
		<xsl:value-of select="concat($tab3, 'End If', $cr)"/>
		<xsl:value-of select="concat($tab2, 'End If', $cr)"/>
		<xsl:value-of select="concat($tab1, 'End If', $cr, $cr)"/>

		<xsl:value-of select="concat($tab1, 'XML = XMLElement(&quot;',  $appprefix, '&quot; + bvElementName + &quot;s&quot;, sAttributes, , sChildren + sXML)', $cr, $cr)"/>

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

		<xsl:value-of select="$cr"/>
		<xsl:value-of select="concat($tab0, 'Public Property Let SysCurrentLanguage(ByVal bvLanguage As String)', $cr)"/>
		<xsl:value-of select="concat($tab1, 'mCurrentLanguage = bvLanguage', $cr)"/>
		<xsl:value-of select="concat($tab0, 'End Property', $cr, $cr)"/>

	</xsl:template>

	<xsl:template name="CustomXMLOptions">
		<!--==================================================================-->
		<!-- METHOD: CUSTOM XML with XML Options-->
		<!--==================================================================-->
		<xsl:variable name="embeds" select="/Data/WTENTITY/WTATTRIBUTE[@embed]"/>
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
		  	<xsl:with-param name="desc">Returns the XML for the collection.</xsl:with-param>
		  	<xsl:with-param name="ismts" select="false()"/>
		  	<xsl:with-param name="isado" select="false()"/>
		  </xsl:call-template>

		<xsl:call-template name="VBVariable">
			<xsl:with-param name="indent">1</xsl:with-param>
			<xsl:with-param name="scope">Dim</xsl:with-param>
			<xsl:with-param name="name">oItem</xsl:with-param>
			<xsl:with-param name="type">useritem</xsl:with-param>
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
		  <xsl:call-template name="VBVariable">
		  	<xsl:with-param name="indent">1</xsl:with-param>
		  	<xsl:with-param name="scope">Dim</xsl:with-param>
		  	<xsl:with-param name="name">sXML</xsl:with-param>
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
				<xsl:with-param name="name">bFind</xsl:with-param>
				<xsl:with-param name="type">yesno</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="VBVariable">
				<xsl:with-param name="indent">1</xsl:with-param>
				<xsl:with-param name="scope">Dim</xsl:with-param>
				<xsl:with-param name="name">lEnum</xsl:with-param>
				<xsl:with-param name="type">number</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="VBVariable">
				<xsl:with-param name="indent">1</xsl:with-param>
				<xsl:with-param name="scope">Dim</xsl:with-param>
				<xsl:with-param name="name">lAttr</xsl:with-param>
				<xsl:with-param name="type">number</xsl:with-param>
			</xsl:call-template>
		  <xsl:value-of select="$cr"/>
	
		  <xsl:call-template name="VBStartErrorHandler"/>

			<xsl:value-of select="concat($tab1, $apos, 'Handle Common Options for collection classes', $cr)"/>
			<xsl:value-of select="concat($tab1, 'Select Case bvOption', $cr)"/>
			<xsl:value-of select="concat($tab2, 'Case 12: bvOption = 1111   ', $apos, ' attributes with all enums', $cr)"/>
			<xsl:value-of select="concat($tab2, 'Case 13: bvOption = 1001   ', $apos, ' attributes with static enums', $cr)"/>
			<xsl:value-of select="concat($tab2, 'Case 14: bvOption = 11000  ', $apos, ' find enums, attributes with no item enums', $cr)"/>
			<xsl:value-of select="concat($tab2, 'Case 15: bvOption = 11001  ', $apos, ' find enums, attributes with static enums', $cr)"/>
			<xsl:value-of select="concat($tab1, 'End Select', $cr)"/>

			<xsl:value-of select="concat($tab1, 'sOption = Format(bvOption, &quot;00000&quot;)', $cr)"/>
			<xsl:value-of select="concat($tab1, 'bFind = (Mid(sOption, 1, 1) = &quot;1&quot;)', $cr)"/>
			<xsl:value-of select="concat($tab1, 'lEnum = Val(Mid(sOption, 4, 2))', $cr)"/>
			<xsl:value-of select="concat($tab1, 'lAttr = Val(Mid(sOption, 2, 2) + &quot;00&quot;)', $cr, $cr)"/>

		  <xsl:call-template name="VBComment">
		  	<xsl:with-param name="value">create the XML for the children</xsl:with-param>
		  	<xsl:with-param name="indent">1</xsl:with-param>
		  </xsl:call-template>
		  <xsl:value-of select="concat($tab1, 'sChildren = &quot;&quot;', $cr, $cr)"/>

			<xsl:value-of select="concat($tab1, 'If bFind Then', $cr)"/>
			<xsl:if test="($hasfind)">
	 			<xsl:value-of select="concat($tab2, 'sChildren = sChildren + EnumItems(', $appprefix, $entityname, 'EnumFindType, mSecurityToken).XML(&quot;', $appprefix, 'FindTypeIDs&quot;, FindTypeID)', $cr)"/>
			</xsl:if>
			<xsl:call-template name="VBComment">
				<xsl:with-param name="value">create the XML for the attributes</xsl:with-param>
				<xsl:with-param name="indent">2</xsl:with-param>
			</xsl:call-template>
			<xsl:value-of select="concat($tab2, 'sAttributes = &quot;&quot;', $cr, $cr)"/>
			<xsl:if test="($hasfind)">
				<xsl:value-of select="concat($tab2, 'sAttributes = sAttributes + XMLAttribute(&quot;FindTypeID&quot;, FindTypeID, False)', $cr)"/>
			</xsl:if>
			<xsl:value-of select="concat($tab1, 'End If', $cr)"/>

		  <xsl:call-template name="VBComment">
		  	<xsl:with-param name="value">create the XML for the collection</xsl:with-param>
		  	<xsl:with-param name="indent">1</xsl:with-param>
		  </xsl:call-template>

		  <xsl:variable name="ChildElement">
				<xsl:choose>
					 <xsl:when test="@element"><xsl:value-of select="@element"/></xsl:when>
					 <xsl:otherwise><xsl:value-of select="'bvElementName'"/></xsl:otherwise>
				</xsl:choose>
		  </xsl:variable>

			<xsl:value-of select="concat($tab1, 'sXML = &quot;&quot;', $cr)"/>
			<xsl:value-of select="concat($tab1, 'If Not (moItems Is Nothing) Then', $cr)"/>
			<xsl:value-of select="concat($tab2, 'If moItems.Count > 0 Then', $cr)"/>
			<xsl:value-of select="concat($tab3, 'If lEnum &gt; 0 Then   ', $apos, ' lookup and/or static Enums Included', $cr)"/>
			<xsl:value-of select="concat($tab4, 'sChildren = sChildren + moItems.Item(1).', @name, '(lEnum, ', $ChildElement, ')', $cr)"/>
			<xsl:value-of select="concat($tab3, 'End If', $cr)"/>
			<xsl:value-of select="concat($tab3, 'If lAttr &gt; 0 Then   ', $apos, ' attributes and/or filtered enums Included', $cr)"/>
			<xsl:value-of select="concat($tab4, 'For Each oItem In moItems', $cr)"/>

		  <xsl:for-each select="$embeds">
		  		<xsl:value-of select="concat($tab5, 'oItem.EmbedText ', @id, ', emb', @name, $cr)"/>
		  </xsl:for-each>

			<xsl:value-of select="concat($tab5, 'sXML = sXML + oItem.', @name, '(lAttr, ', $ChildElement, ')', $cr)"/>
			<xsl:value-of select="concat($tab4, 'Next oItem', $cr)"/>
			<xsl:value-of select="concat($tab3, 'End If', $cr)"/>
			<xsl:value-of select="concat($tab2, 'End If', $cr)"/>
			<xsl:value-of select="concat($tab1, 'End If', $cr, $cr)"/>

		  <xsl:variable name="element">
				<xsl:choose>
					 <xsl:when test="@element"><xsl:value-of select="@element"/></xsl:when>
					 <xsl:otherwise><xsl:value-of select="concat($appprefix, '&quot; + bvElementName + &quot;')"/></xsl:otherwise>
				</xsl:choose>
		  </xsl:variable>

		  <xsl:value-of select="concat($tab1, @name, ' = XMLElement(&quot;',  $element, 's&quot;, sAttributes, , sChildren + sXML)', $cr, $cr)"/>

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
		<xsl:variable name="embeds" select="/Data/WTENTITY/WTATTRIBUTE[@embed]"/>
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
		  	<xsl:with-param name="desc">Returns the XML for the collection.</xsl:with-param>
		  	<xsl:with-param name="ismts" select="false()"/>
		  	<xsl:with-param name="isado" select="false()"/>
		  </xsl:call-template>

			<xsl:call-template name="VBVariable">
				<xsl:with-param name="indent">1</xsl:with-param>
				<xsl:with-param name="scope">Dim</xsl:with-param>
				<xsl:with-param name="name">oItem</xsl:with-param>
				<xsl:with-param name="type">useritem</xsl:with-param>
			</xsl:call-template>
		  <xsl:call-template name="VBVariable">
		  	<xsl:with-param name="indent">1</xsl:with-param>
		  	<xsl:with-param name="scope">Dim</xsl:with-param>
		  	<xsl:with-param name="name">sXML</xsl:with-param>
		  	<xsl:with-param name="type">text</xsl:with-param>
		  </xsl:call-template>
		  <xsl:value-of select="$cr"/>
	
		  <xsl:call-template name="VBStartErrorHandler"/>

		  <xsl:call-template name="VBComment">
		  	<xsl:with-param name="value">create the XML for the collection</xsl:with-param>
		  	<xsl:with-param name="indent">1</xsl:with-param>
		  </xsl:call-template>

		  <xsl:value-of select="concat($tab1, 'sXML = &quot;&quot;', $cr)"/>
		  <xsl:value-of select="concat($tab1, 'If Not (moItems Is Nothing) Then', $cr)"/>
		  <xsl:value-of select="concat($tab2, 'For Each oItem In moItems', $cr)"/>

		  <xsl:for-each select="$embeds">
		  		<xsl:value-of select="concat($tab3, 'oItem.EmbedText ', @id, ', emb', @name, $cr)"/>
		  </xsl:for-each>

		  <xsl:value-of select="concat($tab3, 'sXML = sXML + oItem.', @name, $cr)"/>
		  <xsl:value-of select="concat($tab2, 'Next oItem', $cr)"/>
		  <xsl:value-of select="concat($tab1, 'End If', $cr, $cr)"/>

		  <xsl:variable name="element">
				<xsl:choose>
					 <xsl:when test="@element"><xsl:value-of select="@element"/></xsl:when>
					 <xsl:otherwise><xsl:value-of select="concat($appprefix, $entityname)"/></xsl:otherwise>
				</xsl:choose>
		  </xsl:variable>

		  <xsl:value-of select="concat($tab1, @name, ' = XMLElement(&quot;',  $element, 's&quot;, , , sXML)', $cr, $cr)"/>

		  <xsl:call-template name="VBMethodEnd">
		  	<xsl:with-param name="type">Function</xsl:with-param>
		  	<xsl:with-param name="isado" select="false()"/>
		  	<xsl:with-param name="ismts" select="false()"/>
		  </xsl:call-template>

	</xsl:template>

</xsl:stylesheet>
