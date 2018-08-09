<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:include href="GenerateIncludeASP.xsl"/>
<!--===============================================================================
	Auth: Mike Wisniewski
	Date: November 2001
	Desc: Creates a List Page for an Entity
	Copyright 2001 WinTech, Inc.
===================================================================================-->

	<xsl:template match="/">
		<WEB><xsl:apply-templates/></WEB>
	</xsl:template>

	<xsl:template match="WTENTITY">

		<!--==========variable to identify old and new versions of the XML file==========-->
		<xsl:variable name="IsNewCode" select="count(/Data/WTENTITY/WTWEBPAGE/WTACTION/WTOBJECT) > 0"/>

		<xsl:variable name="itemname" select="$entityname"/>
		<xsl:variable name="itemobj" select="concat('o', $itemname)"/>
		<xsl:variable name="collname" select="concat($itemname, 's')"/>
		<xsl:variable name="collobj" select="concat('o', $collname)"/>
		<xsl:variable name="column" select="/Data/WTENTITY/WTWEBPAGE/@column"/>

		<!--====================INCLUDES====================-->
		<xsl:call-template name="ASPInclude">
			<xsl:with-param name="filename">Include\System.asp</xsl:with-param>
		</xsl:call-template>
		<xsl:value-of select="concat($tab0, '&lt;% Response.Buffer=true', $cr)"/>

		<!--====================ACTION CODES====================-->
		<xsl:call-template name="ASPComment">
			<xsl:with-param name="value">action code constants</xsl:with-param>
		</xsl:call-template>


		<xsl:choose>
			<xsl:when test="($IsNewCode)">
				<xsl:for-each select="/Data/WTENTITY/WTWEBPAGE/WTACTION">
					<xsl:call-template name="ASPActionCodeDeclare">
						<xsl:with-param name="name" select="@type"/>
					</xsl:call-template>
				</xsl:for-each>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="ASPActionCodeDeclare">
					<xsl:with-param name="name">New</xsl:with-param>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>


		<!--====================DECLARES====================-->
		<xsl:call-template name="ASPPageDeclares"/>
		<xsl:call-template name="ASPSystemDeclares">
			<xsl:with-param name="pagetype">list</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ASPLanguageDeclares"/>

		<xsl:call-template name="ASPComment">
			<xsl:with-param name="value">object variables</xsl:with-param>
		</xsl:call-template>

		<xsl:call-template name="ASPObjectDeclares">
			<xsl:with-param name="name" select="$itemname"/>
		</xsl:call-template>

		<xsl:call-template name="ASPObjectDeclares">
			<xsl:with-param name="name" select="$collname"/>
		</xsl:call-template>

		<xsl:if test="($IsNewCode)">
			<xsl:call-template name="ASPObjectDeclares">
				<xsl:with-param name="name">Enums</xsl:with-param>
			</xsl:call-template>
		</xsl:if>


		<!--==========create request variables for parameters==========-->
		<xsl:for-each select="/Data/WTENTITY/WTWEBPAGE/WTPARAM">
			<xsl:value-of select="concat($tab0, 'Dim req', @name, $cr)"/>
		</xsl:for-each>

		<!--==========create request variables for the list type==========-->
			<xsl:value-of select="concat($tab0, 'Dim reqListType', $cr, $cr)"/>

		<!--==========ERROR HANDLER==========-->
		<xsl:call-template name="ASPErrorStart"/>
		<xsl:value-of select="$cr"/>

		<!--==========GET REQUEST VALUES==========-->
		<xsl:call-template name="ASPReturnURLSet">
			<xsl:with-param name="pageno" select="/Data/WTENTITY/WTWEBPAGE/@name"/>
		</xsl:call-template>
		<xsl:call-template name="ASPSystemRequestItems">
			<xsl:with-param name="pagetype">list</xsl:with-param>
		</xsl:call-template>

		<!--==========GET PARAMETERS==========-->
		<!--==========set value of reqListType==========-->
		<xsl:choose>
			<xsl:when test="($multilist)">
				<!--==========add a case for each list type defined for the entity==========-->
				<xsl:value-of select="concat($tab0, 'Select Case reqOwner', $cr)"/>

				<xsl:for-each select="/Data/WTENTITY/WTENUM[@type='list']/WTATTRIBUTE">
					<xsl:variable name="aname" select="@name"/>
					<xsl:value-of select="concat($tab1, 'Case &quot;', @entity, '&quot;: reqListType = CLng(', /Data/WTENTITY/WTATTRIBUTE[@name=$aname]/@id, ')',$cr)"/>
				</xsl:for-each> 

				<xsl:value-of select="concat($tab0, 'End Select', $cr)"/>
			</xsl:when>
			<xsl:otherwise>
				<!--==========set list type to ListAll==========-->
				<xsl:value-of select="concat($tab0, 'reqListType = CLng(0)', $cr)"/>
			</xsl:otherwise>	
		</xsl:choose>

		<!--==========get value of any page parameters==========-->
		<xsl:for-each select="/Data/WTENTITY/WTWEBPAGE/WTPARAM">
			<xsl:choose>
				<xsl:when test="(@datatype='big number')"><xsl:value-of select="concat('req', @name, ' =  CStr(GetInput(&quot;', @name, '&quot;, reqPageData))', $cr)"/></xsl:when>
				<xsl:when test="(@datatype='number')"><xsl:value-of select="concat('req', @name, ' =  CLng(GetInput(&quot;', @name, '&quot;, reqPageData))', $cr)"/></xsl:when>
				<xsl:when test="(@datatype='small number')"><xsl:value-of select="concat('req', @name, ' =  CInt(GetInput(&quot;', @name, '&quot;, reqPageData))', $cr)"/></xsl:when>
				<xsl:when test="(@datatype='tiny number')"><xsl:value-of select="concat('req', @name, ' =  CByte(GetInput(&quot;', @name, '&quot;, reqPageData))', $cr)"/></xsl:when>
				<xsl:when test="(@datatype='decimal')"><xsl:value-of select="concat('req', @name, ' =  CDbl(GetInput(&quot;', @name, '&quot;, reqPageData))', $cr)"/></xsl:when>
				<xsl:when test="(@datatype='date')"><xsl:value-of select="concat('req', @name, ' =  CDate(GetInput(&quot;', @name, '&quot;, reqPageData))', $cr)"/></xsl:when>
				<xsl:when test="(@datatype='currency')"><xsl:value-of select="concat('req', @name, ' =  CCurr(GetInput(&quot;', @name, '&quot;, reqPageData))', $cr)"/></xsl:when>
				<xsl:when test="(@datatype='yesno')"><xsl:value-of select="concat('req', @name, ' =  CBool(GetInput(&quot;', @name, '&quot;, reqPageData))', $cr)"/></xsl:when>
				<xsl:otherwise><xsl:value-of select="concat('req', @name, ' =  GetInput(&quot;', @name, '&quot;, reqPageData)', $cr)"/></xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
		<xsl:value-of select="$cr"/>

		<!--==========CREATE RETURN URL AND DATA==========-->
		<xsl:call-template name="ASPReturnURLCreate"/>

		<!--==========COMMON PAGE STARTUP==========-->
		<xsl:call-template name="ASPErrorFunction"/>
		<xsl:value-of select="$cr"/>
		<xsl:call-template name="ASPErrorInit"/>
		<xsl:value-of select="$cr"/>
		<xsl:call-template name="ASPSecurityCheck">
			<xsl:with-param name="pagetype">list</xsl:with-param>
		</xsl:call-template>
		<xsl:value-of select="$cr"/>
		<xsl:call-template name="ASPLanguageCheck"/>
		<xsl:value-of select="$cr"/>

		<xsl:if test="$IsNewCode">
			<xsl:call-template name="ASPParamData"/>
			<xsl:value-of select="$cr"/>
		</xsl:if>


		<!--==========CREATE BUSINESS OBJECTS==========-->
		<xsl:call-template name="ASPComment">
			<xsl:with-param name="value">create business objects</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="ASPCreateObject">
			<xsl:with-param name="name" select="$itemobj"/>
			<xsl:with-param name="project" select="concat($appprefix, $itemname, 'User')"/>
			<xsl:with-param name="class" select="concat('C', $itemname)"/>
		</xsl:call-template>
		<xsl:call-template name="ASPCreateObject">
			<xsl:with-param name="name" select="$collobj"/>
			<xsl:with-param name="project" select="concat($appprefix, $itemname, 'User')"/>
			<xsl:with-param name="class" select="concat('C', $collname)"/>
		</xsl:call-template>
		<xsl:value-of select="$cr"/>


		<xsl:choose>
			<xsl:when test="($IsNewCode)">
				<!--==========HANDLE ACTION CODES==========-->
				<xsl:call-template name="ASPComment">
					<xsl:with-param name="value">do the appropriate action based on the action code</xsl:with-param>
				</xsl:call-template>

				<xsl:value-of select="concat($tab0, 'Select Case CLng(reqActionCode)', $cr)"/>

				<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level">1</xsl:with-param></xsl:call-template></xsl:variable>
				<xsl:variable name="ind2" select="concat($ind1, $tab1)"/>
				<xsl:variable name="ind3" select="concat($ind2, $tab1)"/>

				<!--handle each action code for the page-->
				<xsl:for-each select="/Data/WTENTITY/WTWEBPAGE/WTACTION">
					<xsl:call-template name="ASPActionCodeCase">
						<xsl:with-param name="name" select="@name"/>
						<xsl:with-param name="indent">1</xsl:with-param>
					</xsl:call-template>

					<!--handle each object-->
					<xsl:for-each select="WTOBJECT">
						<xsl:value-of select="concat($tab2, 'With o', @name, $cr)"/>
					
						<!--handle each method call for the action-->
						<xsl:for-each select="WTMETHOD">
							<xsl:variable name="hasconditions" select="(count(WTCONDITION) > 0)"/>
							<xsl:variable name="returnparam" select="WTPARAM[@direction='return']"/>
							<xsl:variable name="ind4"><xsl:choose><xsl:when test="($hasconditions)"><xsl:value-of select="concat($ind3, $tab1)"/></xsl:when><xsl:otherwise><xsl:value-of select="$ind3"/></xsl:otherwise></xsl:choose></xsl:variable>

							<!--==========generate IF statement for conditions if they exist==========-->
							<xsl:if test="($hasconditions)">
								<xsl:call-template name="ASPConditionStart">
									<xsl:with-param name="indent">3</xsl:with-param>
									<xsl:with-param name="conditions" select="WTCONDITION"/>			
								</xsl:call-template>
							</xsl:if>

							<!--==========execute the method==========-->
							<xsl:choose>
								<xsl:when test="($returnparam/@datatype='object')"><xsl:value-of select="concat($ind4, 'Set o', $returnparam/@name, ' = .', @name, '(')"/></xsl:when>
								<xsl:when test="($returnparam/@concat='true')"><xsl:value-of select="concat($ind4, $returnparam/@name, ' = ', $returnparam/@name, ' + .', @name, '(')"/></xsl:when>
								<xsl:when test="($returnparam/@datatype='big number')"><xsl:value-of select="concat($ind4, $returnparam/@name, ' = CStr(.', @name, '(')"/></xsl:when>
								<xsl:when test="($returnparam/@datatype='number')"><xsl:value-of select="concat($ind4, $returnparam/@name, ' = CLng(.', @name, '(')"/></xsl:when>
								<xsl:when test="($returnparam/@datatype='small number')"><xsl:value-of select="concat($ind4, $returnparam/@name, ' = CInt(.', @name, '(')"/></xsl:when>
								<xsl:when test="($returnparam/@datatype='tiny number')"><xsl:value-of select="concat($ind4, $returnparam/@name, ' = CByte(.', @name, '(')"/></xsl:when>
								<xsl:when test="($returnparam/@datatype='decimal')"><xsl:value-of select="concat($ind4, $returnparam/@name, ' = CDbl(.', @name, '(')"/></xsl:when>
								<xsl:when test="($returnparam/@datatype='date')"><xsl:value-of select="concat($ind4, $returnparam/@name, ' = CDate(.', @name, '(')"/></xsl:when>
								<xsl:when test="($returnparam/@datatype='currency')"><xsl:value-of select="concat($ind4, $returnparam/@name, ' = CCurr(.', @name, '(')"/></xsl:when>
								<xsl:when test="($returnparam/@datatype='yesno')"><xsl:value-of select="concat($ind4, $returnparam/@name, ' = CBool(.', @name, '(')"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="concat($ind4, '.', @name, ' ')"/></xsl:otherwise>
							</xsl:choose>

							<xsl:for-each select="WTPARAM[@direction = 'input']">
								<xsl:call-template name="ASPParam">
									<xsl:with-param name="parameter" select="."/>
									<xsl:with-param name="continue" select="position() != last()"/>
								</xsl:call-template>
							</xsl:for-each>

							<xsl:choose>
								<xsl:when test="($returnparam/@datatype='object')"><xsl:value-of select="concat(')', $cr)"/></xsl:when>
								<xsl:when test="($returnparam/@concat='true')"><xsl:value-of select="concat(')', $cr)"/></xsl:when>
								<xsl:when test="($returnparam)"><xsl:value-of select="concat('))', $cr)"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="$cr"/></xsl:otherwise>
							</xsl:choose>

							<xsl:choose>
								<xsl:when test="($hasconditions)">
									<xsl:call-template name="ASPErrorCheck">
										<xsl:with-param name="indent">4</xsl:with-param>
									</xsl:call-template>
								</xsl:when>
								<xsl:otherwise>
									<xsl:call-template name="ASPErrorCheck">
										<xsl:with-param name="indent">3</xsl:with-param>
									</xsl:call-template>
								</xsl:otherwise>
							</xsl:choose>

							<!--==========close IF statement for conditions if they exist==========-->
							<xsl:if test="($hasconditions)">
								<xsl:call-template name="ASPConditionEnd">
									<xsl:with-param name="indent">3</xsl:with-param>
								</xsl:call-template>
							</xsl:if> 
						</xsl:for-each>

						<xsl:value-of select="concat($tab2, 'End With', $cr)"/>
					</xsl:for-each>
				</xsl:for-each>
				<xsl:value-of select="concat($tab0, 'End Select', $cr, $cr)"/>
			</xsl:when>
			<xsl:otherwise>
				<!--==========GET BUSINESS OBJECT XML==========-->
				<xsl:call-template name="ASPComment">
					<xsl:with-param name="value">get the business object XML</xsl:with-param>
				</xsl:call-template>

				<xsl:value-of select="concat($tab0, 'With ', $collobj, $cr)"/>
				<xsl:value-of select="concat($tab1, '.Load CLng(reqListType), CLng(reqOwnerID), CLng(reqSysUserID)', $cr)"/>

				<xsl:call-template name="ASPErrorCheck">
					<xsl:with-param name="indent">1</xsl:with-param>
				</xsl:call-template>

				<xsl:value-of select="concat($tab1, 'xml', $collname, ' = xml', $collname, ' + .XML', $cr)"/>
				<xsl:value-of select="concat($tab1, 'xml', $collname, ' = xml', $collname, ' + ')"/>
				<xsl:value-of select="concat($tab0, '.EnumItems(', /Data/WTENTITY/WTENUM[@type='list']/@id, ', CLng(reqSysUserGroup)).XML(&quot;LISTTYPES&quot;,CLng(reqListType))', $cr)"/>

				<xsl:value-of select="concat($tab0, 'End With', $cr, $cr)"/>
			</xsl:otherwise>
		</xsl:choose>

		<!--==========GET SYSTEM XML==========-->
		<xsl:call-template name="ASPSystemData">
			<xsl:with-param name="pagetype">list</xsl:with-param>
		</xsl:call-template>
		<xsl:value-of select="$cr"/>

		<!--==========GET TRANSACTION XML==========-->
		<xsl:call-template name="ASPComment">
			<xsl:with-param name="value">get the transaction XML</xsl:with-param>
		</xsl:call-template>

		<xsl:value-of select="concat($tab0, 'xmlTransaction = xmlTransaction + &quot;&lt;TXN&gt;&quot;', $cr)"/>
		<xsl:value-of select="concat($tab0, 'xmlTransaction = xmlTransaction +  xml', $collname, $cr)"/>
		<xsl:value-of select="concat($tab0, 'xmlTransaction = xmlTransaction + &quot;&lt;/TXN&gt;&quot;', $cr, $cr)"/>

		<!--==========HANDLE CONFIRMATION MESSAGE==========-->
		<xsl:call-template name="ASPCheckConfirm"/>
		<xsl:value-of select="$cr"/>

		<!--==========GET LANGUAGE XML==========-->
		<xsl:call-template name="ASPLanguageData"/>
		<xsl:value-of select="$cr"/>

		<!--==========GET DATA XML==========-->
		<xsl:call-template name="ASPComment">
			<xsl:with-param name="value">get the data XML</xsl:with-param>
		</xsl:call-template>

		<xsl:value-of select="concat($tab0, 'xmlData = xmlData + &quot;&lt;DATA&gt;&quot;', $cr)"/>
		<xsl:value-of select="concat($tab0, 'xmlData = xmlData +  xmlTransaction', $cr)"/>
		<xsl:value-of select="concat($tab0, 'xmlData = xmlData +  xmlSystem', $cr)"/>
		<xsl:value-of select="concat($tab0, 'xmlData = xmlData +  xmlConfig', $cr)"/>
		<xsl:value-of select="concat($tab0, 'xmlData = xmlData +  xmlOwner', $cr)"/>
		<xsl:if test="($IsNewCode)">
			<xsl:value-of select="concat($tab0, 'xmlData = xmlData +  xmlParam', $cr)"/>
		</xsl:if>
		<xsl:value-of select="concat($tab0, 'xmlData = xmlData +  xmlLanguage', $cr)"/>
		<xsl:value-of select="concat($tab0, 'xmlData = xmlData +  xmlError', $cr)"/>
		<xsl:value-of select="concat($tab0, 'xmlData = xmlData + &quot;&lt;/DATA&gt;&quot;', $cr, $cr)"/>

		<!--==========GET STYLESHEET XSL==========-->
		<xsl:call-template name="ASPStyleSheet"/>
		<xsl:value-of select="$cr"/>

		<!--==========TRANSFORM PAGE==========-->
		<xsl:call-template name="ASPTransform"/>
		<xsl:value-of select="$cr"/>

		<!--==========END PAGE==========-->
		<!--item and collection objects-->
		<xsl:value-of select="concat('Set ', $itemobj, ' = Nothing', $cr)"/>
		<xsl:value-of select="concat('Set ', $collobj, ' = Nothing', $cr)"/>

		<xsl:if test="$IsNewCode">
			<xsl:value-of select="concat('Set oEnums = Nothing', $cr)"/>
		</xsl:if>

		<!--common page objects-->
		<xsl:call-template name="ASPPageEnd"/>
		<xsl:value-of select="$cr"/>

	</xsl:template>
</xsl:stylesheet>
