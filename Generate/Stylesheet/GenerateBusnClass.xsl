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
		<xsl:variable name="identityfield" select="WTATTRIBUTE[@identity]/@name"/>

		<xsl:variable name="classname">
			<xsl:value-of select="@name"/>
			<xsl:if test="/Data/@userbusn">
				<xsl:value-of select="'B'"/>
			</xsl:if>
		</xsl:variable>

		<xsl:call-template name="VBHeaderClassModule">
			<xsl:with-param name="name" select="$classname"/>
			<xsl:with-param name="mtsmode">2</xsl:with-param>
			<xsl:with-param name="createable" select="true()"/>
			<xsl:with-param name="exposed" select="true()"/>
		</xsl:call-template>

		<xsl:call-template name="VBComment">
			<xsl:with-param name="value">constants</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="VBConstant">
			<xsl:with-param name="name">ModName</xsl:with-param>
			<xsl:with-param name="type">text</xsl:with-param>
			<xsl:with-param name="value" select="concat('C', @name)"/>
		</xsl:call-template>

		<xsl:call-template name="VBComment">
			<xsl:with-param name="value">objects</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="VBObject">
			<xsl:with-param name="name">moSys</xsl:with-param>
			<xsl:with-param name="type">wtSystem.CSystem</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="VBObject">
			<xsl:with-param name="name">moUtil</xsl:with-param>
			<xsl:with-param name="type">wtSystem.CUtility</xsl:with-param>
		</xsl:call-template>

		<xsl:call-template name="VBComment">
			<xsl:with-param name="value">properties</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="VBTypeRecord"/>

		<xsl:if test="/Data/WTPAGE/@multi-instance">
			<xsl:value-of select="$cr"/>
			<xsl:value-of select="concat('Private mClient As String', $cr)"/>
			<xsl:value-of select="concat('Private mProject As String', $cr, $cr)"/>
			<xsl:value-of select="concat('Public Sub SysClientProject(ByVal bvClient As String, ByVal bvProject As String)', $cr)"/>
			<xsl:value-of select="concat($tab1, 'mClient = bvClient', $cr)"/>
			<xsl:value-of select="concat($tab1, 'mProject = bvProject', $cr)"/>
			<xsl:value-of select="concat('End Sub', $cr)"/>
		</xsl:if>

		<!--==================================================================-->
		<!-- METHOD: ADD -->
		<!--==================================================================-->
		<xsl:if test="WTPROCEDURES/WTPROCEDURE[@type='Add']">
			<xsl:value-of select="$cr"/>
			<xsl:call-template name="VBMethodStart">
				<xsl:with-param name="type">Sub</xsl:with-param>
				<xsl:with-param name="name">Add</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="VBParam">
				<xsl:with-param name="name">Rec</xsl:with-param>
				<xsl:with-param name="type">record</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="VBParam">
				<xsl:with-param name="name">UserID</xsl:with-param>
				<xsl:with-param name="type">number</xsl:with-param>
				<xsl:with-param name="continue" select="false()"/>
			</xsl:call-template>
			<xsl:value-of select="concat(')', $cr)"/>

			<xsl:call-template name="VBFunctionBox">
				<xsl:with-param name="name">Add</xsl:with-param>
				<xsl:with-param name="desc">Add the record.</xsl:with-param>
			</xsl:call-template>
			<xsl:value-of select="$cr"/>

			<xsl:call-template name="VBStartErrorHandler"/>
			<xsl:call-template name="VBMTSContext"/>

			<!--==========EDIT INPUT PARAMETERS==========-->

			<xsl:call-template name="VBComment">
				<xsl:with-param name="indent">1</xsl:with-param>
				<xsl:with-param name="value">edit the input parameters</xsl:with-param>
			</xsl:call-template>

			<xsl:value-of select="concat($tab1, 'Validate brRec, bvUserID, 1', $cr, $cr)"/>

			<!--==========SET ADO PARAMETERS==========-->

			<xsl:call-template name="VBComment">
				<xsl:with-param name="indent">1</xsl:with-param>
				<xsl:with-param name="value">populate the parameters for the procedure call</xsl:with-param>
			</xsl:call-template>

			<xsl:value-of select="concat($tab1, 'With oCmd', $cr)"/>

			<xsl:for-each select="WTATTRIBUTE[@passthru or (@source='entity' and not(WTCOMPUTE) and not(@persist))]">
<!--				<xsl:for-each select="WTATTRIBUTE[@source='entity' and not(WTCOMPUTE) and not(@persist)]">-->
					<xsl:variable name="dir">
					<xsl:choose>
						<xsl:when test="@identity">output</xsl:when>
						<xsl:when test="WTINIT">output</xsl:when>
						<xsl:otherwise>input</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>

				<xsl:call-template name="VBADOSetParam">
					<xsl:with-param name="indent">2</xsl:with-param>
					<xsl:with-param name="name" select="@name"/>
					<xsl:with-param name="value" select="concat('brRec.', @name)"/>
					<xsl:with-param name="direction" select="$dir"/>
					<xsl:with-param name="type" select="@type"/>
					<xsl:with-param name="length" select="@length"/>
					<xsl:with-param name="precision" select="@precision"/>
				</xsl:call-template>
			</xsl:for-each>

			<xsl:call-template name="VBADOSetParam">
				<xsl:with-param name="indent">2</xsl:with-param>
				<xsl:with-param name="name">UserID</xsl:with-param>
				<xsl:with-param name="value">bvUserID</xsl:with-param>
				<xsl:with-param name="type">number</xsl:with-param>
			</xsl:call-template>

			<xsl:value-of select="concat($tab1, 'End With', $cr, $cr)"/>

			<!--==========EXECUTE COMMAND==========-->

			<xsl:call-template name="VBRunSP">
				<xsl:with-param name="name">Add</xsl:with-param>
				<xsl:with-param name="indent">1</xsl:with-param>
			</xsl:call-template>
			<xsl:value-of select="$cr"/>

			<!--==========GET RETURN VALUES==========-->

			<xsl:call-template name="VBComment">
				<xsl:with-param name="indent">1</xsl:with-param>
				<xsl:with-param name="value">get return values</xsl:with-param>
			</xsl:call-template>

			<xsl:value-of select="concat($tab1, 'With brRec', $cr)"/>

			<xsl:for-each select="WTATTRIBUTE[(@identity) or (WTINIT)]">
				<xsl:call-template name="VBADOGetParam">
					<xsl:with-param name="indent">2</xsl:with-param>
					<xsl:with-param name="name" select="@name"/>
					<xsl:with-param name="type" select="@type"/>
					<xsl:with-param name="assignto" select="concat('.', @name)"/>
				</xsl:call-template>
			</xsl:for-each>

			<xsl:value-of select="concat($tab1, 'End With', $cr, $cr)"/>

			<xsl:call-template name="VBMethodEnd">
				<xsl:with-param name="type">Sub</xsl:with-param>
			</xsl:call-template>
		</xsl:if>

	 <!--==================================================================-->
	 <!-- METHOD: COPY -->
	 <!--==================================================================-->
	<xsl:if test="WTPROCEDURES/WTPROCEDURE[@type='Copy' and not(@template='new')]">

		  <xsl:value-of select="$cr"/>
		  <xsl:call-template name="VBMethodStart">
		  	<xsl:with-param name="type">Sub</xsl:with-param>
		  	<xsl:with-param name="name">Copy</xsl:with-param>
		  </xsl:call-template>
		  <xsl:call-template name="VBParam">
		  	<xsl:with-param name="name">Rec</xsl:with-param>
		  	<xsl:with-param name="type">record</xsl:with-param>
		  </xsl:call-template>
		  <xsl:call-template name="VBParam">
		  	<xsl:with-param name="name">UserID</xsl:with-param>
		  	<xsl:with-param name="type">number</xsl:with-param>
		  	<xsl:with-param name="continue" select="false()"/>
		  </xsl:call-template>
		  <xsl:value-of select="concat(')', $cr)"/>

		  <xsl:call-template name="VBFunctionBox">
		  	<xsl:with-param name="name">Copy</xsl:with-param>
		  	<xsl:with-param name="desc">Copy the record.</xsl:with-param>
		  </xsl:call-template>
		  <xsl:value-of select="$cr"/>

		  <xsl:call-template name="VBStartErrorHandler"/>
		  <xsl:call-template name="VBMTSContext"/>

		  <!--==========EDIT INPUT PARAMETERS==========-->

		  <xsl:call-template name="VBComment">
		  	<xsl:with-param name="indent">1</xsl:with-param>
		  	<xsl:with-param name="value">edit the input parameters</xsl:with-param>
		  </xsl:call-template>

		  <xsl:value-of select="concat($tab1, 'Validate brRec, bvUserID, 1', $cr, $cr)"/>

		  <!--==========SET ADO PARAMETERS==========-->

		  <xsl:call-template name="VBComment">
		  	<xsl:with-param name="indent">1</xsl:with-param>
		  	<xsl:with-param name="value">populate the parameters for the procedure call</xsl:with-param>
		  </xsl:call-template>

		  <xsl:value-of select="concat($tab1, 'With oCmd', $cr)"/>

		  	<xsl:call-template name="VBADOSetParam">
		  		<xsl:with-param name="indent">2</xsl:with-param>
		  		<xsl:with-param name="name" select="$identity"/>
		  		<xsl:with-param name="value" select="concat('brRec.', $identity)"/>
		  		<xsl:with-param name="direction" select="'output'"/>
		  		<xsl:with-param name="type" select="'number'"/>
		  	</xsl:call-template>

		  <xsl:call-template name="VBADOSetParam">
		  	<xsl:with-param name="indent">2</xsl:with-param>
		  		<xsl:with-param name="name" select="concat('Copy', $identity)"/>
		  		<xsl:with-param name="value" select="concat('brRec.', $identity)"/>
		  	<xsl:with-param name="type">number</xsl:with-param>
		  </xsl:call-template>

		  <xsl:call-template name="VBADOSetParam">
		  	<xsl:with-param name="indent">2</xsl:with-param>
		  	<xsl:with-param name="name">UserID</xsl:with-param>
		  	<xsl:with-param name="value">bvUserID</xsl:with-param>
		  	<xsl:with-param name="type">number</xsl:with-param>
		  </xsl:call-template>

		  <xsl:value-of select="concat($tab1, 'End With', $cr, $cr)"/>

		  <!--==========EXECUTE COMMAND==========-->

		  <xsl:call-template name="VBRunSP">
		  	<xsl:with-param name="name">Copy</xsl:with-param>
		  	<xsl:with-param name="indent">1</xsl:with-param>
		  </xsl:call-template>
		  <xsl:value-of select="$cr"/>

		  <!--==========GET RETURN VALUES==========-->

		  <xsl:call-template name="VBComment">
		  	<xsl:with-param name="indent">1</xsl:with-param>
		  	<xsl:with-param name="value">get return values</xsl:with-param>
		  </xsl:call-template>

		  <xsl:value-of select="concat($tab1, 'With brRec', $cr)"/>

		  	<xsl:call-template name="VBADOGetParam">
		  		<xsl:with-param name="indent">2</xsl:with-param>
		  		<xsl:with-param name="name" select="$identity"/>
		  		<xsl:with-param name="type" select="'number'"/>
		  		<xsl:with-param name="assignto" select="concat('.', $identity)"/>
		  	</xsl:call-template>

		  <xsl:value-of select="concat($tab1, 'End With', $cr, $cr)"/>

		  <xsl:call-template name="VBMethodEnd">
		  	<xsl:with-param name="type">Sub</xsl:with-param>
		  </xsl:call-template>

	 </xsl:if>
	 
		<!--==================================================================-->
		<!-- METHOD: Check (CUSTOM) -->
		<!--==================================================================-->
		<xsl:for-each select="WTPROCEDURES/WTPROCEDURE[(@type='Check') and (@template='new') and (@passthru='true')]">

			<xsl:value-of select="$cr"/>
			<xsl:call-template name="VBMethodStart">
				<xsl:with-param name="type">Function</xsl:with-param>
				<xsl:with-param name="name" select="@name"/>
			</xsl:call-template>
			<xsl:call-template name="VBParam">
				<xsl:with-param name="name">Rec</xsl:with-param>
				<xsl:with-param name="type">record</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="VBParam">
				<xsl:with-param name="name">UserID</xsl:with-param>
				<xsl:with-param name="type">number</xsl:with-param>
				<xsl:with-param name="continue" select="false()"/>
			</xsl:call-template>
			<xsl:value-of select="')'"/>

			<xsl:call-template name="VBFunctionReturn">
				<xsl:with-param name="name" select="WTPARAM[@direction='output']/@name"/>
				<xsl:with-param name="type" select="WTPARAM[@direction='output']/@datatype"/>
			</xsl:call-template>
			<xsl:value-of select="$cr"/>

			<xsl:call-template name="VBFunctionBox">
				<xsl:with-param name="name" select="@name"/>
				<xsl:with-param name="desc">Checks a condition</xsl:with-param>
				<xsl:with-param name="ismts" select="false()"/>
			</xsl:call-template>
			<xsl:value-of select="$cr"/>
			
			<xsl:call-template name="VBStartErrorHandler"/>

			<!--edit input parameters-->
		  <xsl:if test="not(@novalidate or @noedit)">
				<xsl:apply-templates select="WTPARAM[@direction='input']" mode="editinput">
					<xsl:with-param name="indent">1</xsl:with-param>
					<xsl:with-param name="functype">sub</xsl:with-param>
				</xsl:apply-templates>
		  </xsl:if>

			<!--set ado parameters-->
			<xsl:apply-templates select="WTPARAM" mode="setado">
				<xsl:with-param name="indent">1</xsl:with-param>
			</xsl:apply-templates>

			<!--execute the command-->
 			<xsl:call-template name="VBRunSP">
				<xsl:with-param name="name" select="@name"/>
				<xsl:with-param name="indent">1</xsl:with-param>
			</xsl:call-template>
			<xsl:value-of select="$cr"/>

			<!--==========GET RETURN VALUES==========-->

			<xsl:call-template name="VBComment">
				<xsl:with-param name="indent">1</xsl:with-param>
				<xsl:with-param name="value">get return values</xsl:with-param>
			</xsl:call-template>

			<xsl:call-template name="VBADOGetParam">
				<xsl:with-param name="indent">1</xsl:with-param>
				<xsl:with-param name="name" select="WTPARAM[@direction='output']/@name"/>
				<xsl:with-param name="type" select="WTPARAM[@direction='output']/@datatype"/>
				<xsl:with-param name="assignto" select="@name"/>
			</xsl:call-template>
			<xsl:value-of select="$cr"/>

			<xsl:call-template name="VBMethodEnd">
				<xsl:with-param name="type">Function</xsl:with-param>
				<xsl:with-param name="ismts" select="false()"/>
				<xsl:with-param name="isrecordset" select="false()"/>
			</xsl:call-template>

		</xsl:for-each>

		<!--==================================================================-->
		<!-- METHOD: Command (CUSTOM) -->
		<!--==================================================================-->
		<xsl:for-each select="WTPROCEDURES/WTPROCEDURE[(@type='Command') and (@template='new') and (@passthru='true')]">

			<xsl:value-of select="$cr"/>
			<xsl:call-template name="VBMethodStart">
				<xsl:with-param name="type">Sub</xsl:with-param>
				<xsl:with-param name="name" select="@name"/>
			</xsl:call-template>
			<xsl:call-template name="VBParam">
				<xsl:with-param name="name">Rec</xsl:with-param>
				<xsl:with-param name="type">record</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="VBParam">
				<xsl:with-param name="name">UserID</xsl:with-param>
				<xsl:with-param name="type">number</xsl:with-param>
				<xsl:with-param name="continue" select="false()"/>
			</xsl:call-template>
			<xsl:value-of select="')'"/>
			<xsl:value-of select="$cr"/>

			<xsl:call-template name="VBFunctionBox">
				<xsl:with-param name="name" select="@name"/>
				<xsl:with-param name="desc">Execute a Command</xsl:with-param>
				<xsl:with-param name="ismts" select="false()"/>
			</xsl:call-template>
			<xsl:value-of select="$cr"/>
			
			<xsl:call-template name="VBStartErrorHandler"/>

			<!--edit input parameters-->
		  <xsl:if test="not(@novalidate or @noedit)">
				<xsl:apply-templates select="WTPARAM[@direction='input']" mode="editinput">
					<xsl:with-param name="indent">1</xsl:with-param>
					<xsl:with-param name="functype">sub</xsl:with-param>
				</xsl:apply-templates>
		  </xsl:if>

			<!--set ado parameters-->
			<xsl:apply-templates select="WTPARAM" mode="setado">
				<xsl:with-param name="indent">1</xsl:with-param>
			</xsl:apply-templates>

			<!--execute the command-->
 			<xsl:call-template name="VBRunSP">
				<xsl:with-param name="name" select="@name"/>
				<xsl:with-param name="indent">1</xsl:with-param>
			</xsl:call-template>
			<xsl:value-of select="$cr"/>

			<xsl:call-template name="VBMethodEnd">
				<xsl:with-param name="type">Sub</xsl:with-param>
				<xsl:with-param name="ismts" select="false()"/>
				<xsl:with-param name="isrecordset" select="false()"/>
			</xsl:call-template>

		</xsl:for-each>

		<!--==================================================================-->
		<!-- METHOD: COUNT -->
		<!--==================================================================-->
		<xsl:if test="WTPROCEDURES/WTPROCEDURE[@type='Count']">
			<xsl:value-of select="$cr"/>
			<xsl:call-template name="VBMethodStart">
				<xsl:with-param name="type">Function</xsl:with-param>
				<xsl:with-param name="name">Count</xsl:with-param>
				<xsl:with-param name="ismts" select="false()"/>
			</xsl:call-template>

			<xsl:if test="($ischild)">
				<xsl:for-each select="($parentfields)">
					<xsl:variable name="aname" select="@name"/>
					<xsl:for-each select = "/Data/WTENTITY/WTATTRIBUTE[@name=$aname]">
						<xsl:call-template name="VBParam">
							<xsl:with-param name="name" select="@name"/>
							<xsl:with-param name="type" select="@type"/>
						</xsl:call-template>
					</xsl:for-each>
				</xsl:for-each>
			</xsl:if>

			<xsl:call-template name="VBParam">
				<xsl:with-param name="name">UserID</xsl:with-param>
				<xsl:with-param name="type">number</xsl:with-param>
				<xsl:with-param name="continue" select="false()"/>
			</xsl:call-template>
			<xsl:value-of select="concat($tab0, ')')"/>

			<xsl:call-template name="VBDataType">
				<xsl:with-param name="datatype">number</xsl:with-param>
			</xsl:call-template>
			<xsl:value-of select="$cr"/>

			<xsl:call-template name="VBFunctionBox">
				<xsl:with-param name="name">Count</xsl:with-param>
				<xsl:with-param name="desc">Returns the number of records.</xsl:with-param>
				<xsl:with-param name="ismts" select="false()"/>
			</xsl:call-template>
			<xsl:value-of select="$cr"/>

			<xsl:call-template name="VBStartErrorHandler"/>

			<!--==========EDIT INPUT PARAMETERS==========-->

			<xsl:call-template name="VBComment">
				<xsl:with-param name="indent">1</xsl:with-param>
				<xsl:with-param name="value">edit the input parameters</xsl:with-param>
			</xsl:call-template>

			<xsl:if test="($ischild)">
				<xsl:for-each select="($parentfields)">
					<xsl:variable name="aname" select="@name"/>
					<xsl:for-each select = "/Data/WTENTITY/WTATTRIBUTE[@name=$aname]">
						<xsl:call-template name="VBFieldEdit">
							<xsl:with-param name="indent">1</xsl:with-param>
							<xsl:with-param name="assignto" select="concat('bv', @name)"/>
							<xsl:with-param name="name" select="concat('bv', @name)"/>
							<xsl:with-param name="label" select="@name"/>
							<xsl:with-param name="type" select="@type"/>
							<xsl:with-param name="default" select="@default"/>
							<xsl:with-param name="minval" select="@min"/>
							<xsl:with-param name="maxval" select="@max"/>
							<xsl:with-param name="required" select="@required"/>
						</xsl:call-template>
					</xsl:for-each>
				</xsl:for-each>
			</xsl:if>

			<xsl:call-template name="VBFieldEdit">
				<xsl:with-param name="indent">1</xsl:with-param>
				<xsl:with-param name="assignto">bvUserID</xsl:with-param>
				<xsl:with-param name="name">bvUserID</xsl:with-param>
				<xsl:with-param name="label">User ID</xsl:with-param>
				<xsl:with-param name="type">number</xsl:with-param>
				<xsl:with-param name="required" select="true()"/>
				<xsl:with-param name="minval">1</xsl:with-param>
			</xsl:call-template>
			<xsl:value-of select="$cr"/>

			<!--==========SET ADO PARAMETERS==========-->

			<xsl:call-template name="VBComment">
				<xsl:with-param name="indent">1</xsl:with-param>
				<xsl:with-param name="value">populate the parameters for the procedure call</xsl:with-param>
			</xsl:call-template>

			<xsl:value-of select="concat($tab1, 'With oCmd', $cr)"/>

			<xsl:call-template name="VBADOSetParam">
				<xsl:with-param name="indent">2</xsl:with-param>
				<xsl:with-param name="name">Return</xsl:with-param>
				<xsl:with-param name="type">number</xsl:with-param>
				<xsl:with-param name="direction">return</xsl:with-param>
			</xsl:call-template>

			<xsl:if test="($ischild)">
				<xsl:for-each select="($parentfields)">
					<xsl:variable name="aname" select="@name"/>
					<xsl:for-each select = "/Data/WTENTITY/WTATTRIBUTE[@name=$aname]">
						<xsl:call-template name="VBADOSetParam">
							<xsl:with-param name="indent">2</xsl:with-param>
							<xsl:with-param name="name" select="@name"/>
							<xsl:with-param name="type" select="@type"/>
							<xsl:with-param name="value" select="concat('bv', @name)"/>
						</xsl:call-template>
					</xsl:for-each>
				</xsl:for-each>
			</xsl:if>

			<xsl:call-template name="VBADOSetParam">
				<xsl:with-param name="indent">2</xsl:with-param>
				<xsl:with-param name="name">UserID</xsl:with-param>
				<xsl:with-param name="value">bvUserID</xsl:with-param>
				<xsl:with-param name="type">number</xsl:with-param>
			</xsl:call-template>

			<xsl:value-of select="concat($tab1, 'End With', $cr)"/>

			<!--==========EXECUTE COMMAND==========-->

			<xsl:call-template name="VBRunSP">
				<xsl:with-param name="name">Count</xsl:with-param>
				<xsl:with-param name="indent">1</xsl:with-param>
			</xsl:call-template>
			<xsl:value-of select="$cr"/>

			<!--==========GET RETURN VALUES==========-->

			<xsl:call-template name="VBComment">
				<xsl:with-param name="indent">1</xsl:with-param>
				<xsl:with-param name="value">get return values</xsl:with-param>
			</xsl:call-template>

   			<xsl:for-each select="WTATTRIBUTE[@identity]">
				<xsl:call-template name="VBADOGetParam">
					<xsl:with-param name="indent">1</xsl:with-param>
					<xsl:with-param name="name">Return</xsl:with-param>
					<xsl:with-param name="type">number</xsl:with-param>
					<xsl:with-param name="assignto">Count</xsl:with-param>
				</xsl:call-template>
			</xsl:for-each>
			<xsl:value-of select="$cr"/>

			<xsl:call-template name="VBMethodEnd">
				<xsl:with-param name="type">Function</xsl:with-param>
				<xsl:with-param name="ismts" select="false()"/>
			</xsl:call-template>
		</xsl:if>

		<!--==================================================================-->
		<!-- METHOD: DELETE -->
		<!--==================================================================-->
		<xsl:if test="WTPROCEDURES/WTPROCEDURE[@type='Delete']">
			<xsl:value-of select="$cr"/>
			<xsl:call-template name="VBMethodStart">
				<xsl:with-param name="type">Sub</xsl:with-param>
				<xsl:with-param name="name">Delete</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="VBParam">
				<xsl:with-param name="name">Rec</xsl:with-param>
				<xsl:with-param name="type">record</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="VBParam">
				<xsl:with-param name="name">UserID</xsl:with-param>
				<xsl:with-param name="type">number</xsl:with-param>
				<xsl:with-param name="continue" select="false()"/>
			</xsl:call-template>
			<xsl:value-of select="concat(')', $cr)"/>

			<xsl:call-template name="VBFunctionBox">
				<xsl:with-param name="name">Delete</xsl:with-param>
				<xsl:with-param name="desc">Delete the record.</xsl:with-param>
			</xsl:call-template>
			<xsl:value-of select="$cr"/>

			<xsl:call-template name="VBStartErrorHandler"/>
			<xsl:call-template name="VBMTSContext"/>

			<!--==========EDIT INPUT PARAMETERS==========-->

			<xsl:call-template name="VBComment">
				<xsl:with-param name="indent">1</xsl:with-param>
				<xsl:with-param name="value">edit the input parameters</xsl:with-param>
			</xsl:call-template>

			<xsl:value-of select="concat($tab1, 'With brRec', $cr)"/>

			<xsl:for-each select="WTATTRIBUTE[@identity]">
				<xsl:call-template name="VBFieldEdit">
					<xsl:with-param name="indent">2</xsl:with-param>
					<xsl:with-param name="assignto" select="concat('.', @name)"/>
					<xsl:with-param name="name" select="concat('.', @name)"/>
					<xsl:with-param name="label" select="@name"/>
					<xsl:with-param name="type" select="@type"/>
					<xsl:with-param name="default" select="@default"/>
					<xsl:with-param name="minval" select="@min"/>
					<xsl:with-param name="maxval" select="@max"/>
					<xsl:with-param name="required" select="@required"/>
				</xsl:call-template>
			</xsl:for-each>

			<xsl:call-template name="VBFieldEdit">
				<xsl:with-param name="indent">2</xsl:with-param>
				<xsl:with-param name="assignto">bvUserID</xsl:with-param>
				<xsl:with-param name="name">bvUserID</xsl:with-param>
				<xsl:with-param name="label">User ID</xsl:with-param>
				<xsl:with-param name="type">number</xsl:with-param>
				<xsl:with-param name="required" select="true()"/>
				<xsl:with-param name="minval">1</xsl:with-param>
			</xsl:call-template>

			<xsl:value-of select="concat($tab1, 'End With', $cr, $cr)"/>

			<!--==========SET ADO PARAMETERS==========-->

			<xsl:call-template name="VBComment">
				<xsl:with-param name="indent">1</xsl:with-param>
				<xsl:with-param name="value">populate the parameters for the procedure call</xsl:with-param>
			</xsl:call-template>

			<xsl:value-of select="concat($tab1, 'With oCmd', $cr)"/>

			<xsl:for-each select="WTATTRIBUTE[@identity]">
				<xsl:call-template name="VBADOSetParam">
					<xsl:with-param name="indent">2</xsl:with-param>
					<xsl:with-param name="name" select="@name"/>
					<xsl:with-param name="value" select="concat('brRec.', @name)"/>
					<xsl:with-param name="type" select="@type"/>
					<xsl:with-param name="length" select="@length"/>
					<xsl:with-param name="precision" select="@precision"/>
				</xsl:call-template>
			</xsl:for-each>

			<xsl:call-template name="VBADOSetParam">
				<xsl:with-param name="indent">2</xsl:with-param>
				<xsl:with-param name="name">UserID</xsl:with-param>
				<xsl:with-param name="value">bvUserID</xsl:with-param>
				<xsl:with-param name="type">number</xsl:with-param>
			</xsl:call-template>

			<xsl:value-of select="concat($tab1, 'End With', $cr, $cr)"/>

			<!--==========EXECUTE COMMAND==========-->

			<xsl:call-template name="VBRunSP">
				<xsl:with-param name="name">Delete</xsl:with-param>
				<xsl:with-param name="indent">1</xsl:with-param>
			</xsl:call-template>
			<xsl:value-of select="$cr"/>

			<xsl:call-template name="VBMethodEnd">
				<xsl:with-param name="type">Sub</xsl:with-param>
			</xsl:call-template>
		</xsl:if>
   
		<!--==================================================================-->
		<!-- METHOD: ENUMERATE -->
		<!--==================================================================-->
		<xsl:if test="count(/Data/WTENTITY/WTPROCEDURES/WTPROCEDURE[@type='Enum' and not(@template='new')]) > 0">

			<xsl:value-of select="$cr"/>
			<xsl:call-template name="VBMethodStart">
				<xsl:with-param name="type">Function</xsl:with-param>
				<xsl:with-param name="name">Enumerate</xsl:with-param>
			</xsl:call-template>

			<xsl:if test="($ischild)">
				<xsl:for-each select="($parentfields)">
					<xsl:variable name="aname" select="@name"/>
					<xsl:for-each select = "/Data/WTENTITY/WTATTRIBUTE[@name=$aname]">
						<xsl:call-template name="VBParam">
							<xsl:with-param name="name" select="@name"/>
							<xsl:with-param name="type" select="@type"/>
						</xsl:call-template>
					</xsl:for-each>
				</xsl:for-each>
			</xsl:if>

			<xsl:call-template name="VBParam">
				<xsl:with-param name="name">UserID</xsl:with-param>
				<xsl:with-param name="type">number</xsl:with-param>
				<xsl:with-param name="continue" select="false()"/>
			</xsl:call-template>
			<xsl:value-of select="concat($tab0, ')')"/>

			<xsl:call-template name="VBDataType">
				<xsl:with-param name="datatype">records</xsl:with-param>
			</xsl:call-template>
			<xsl:value-of select="$cr"/>

			<xsl:call-template name="VBFunctionBox">
				<xsl:with-param name="name">Enumerate</xsl:with-param>
				<xsl:with-param name="desc">Returns an enumerated list of items.</xsl:with-param>
				<xsl:with-param name="ismts" select="false()"/>
				<xsl:with-param name="isrecordset" select="true()"/>
			</xsl:call-template>
			<xsl:value-of select="$cr"/>

			<xsl:call-template name="VBStartErrorHandler"/>

			<!--==========EDIT INPUT PARAMETERS==========-->

			<xsl:call-template name="VBComment">
				<xsl:with-param name="indent">1</xsl:with-param>
				<xsl:with-param name="value">edit the input parameters</xsl:with-param>
			</xsl:call-template>

			<xsl:if test="($ischild)">
				<xsl:for-each select="($parentfields)">
					<xsl:variable name="aname" select="@name"/>
					<xsl:for-each select = "/Data/WTENTITY/WTATTRIBUTE[@name=$aname]">
						<xsl:call-template name="VBFieldEdit">
							<xsl:with-param name="indent">1</xsl:with-param>
							<xsl:with-param name="assignto" select="concat('bv', @name)"/>
							<xsl:with-param name="name" select="concat('bv', @name)"/>
							<xsl:with-param name="label" select="@name"/>
							<xsl:with-param name="type" select="@type"/>
							<xsl:with-param name="default" select="@default"/>
							<xsl:with-param name="minval" select="@min"/>
							<xsl:with-param name="maxval" select="@max"/>
							<xsl:with-param name="required" select="@required"/>
						</xsl:call-template>
					</xsl:for-each>
				</xsl:for-each>
			</xsl:if>

			<xsl:call-template name="VBFieldEdit">
				<xsl:with-param name="indent">1</xsl:with-param>
				<xsl:with-param name="assignto">bvUserID</xsl:with-param>
				<xsl:with-param name="name">bvUserID</xsl:with-param>
				<xsl:with-param name="label">User ID</xsl:with-param>
				<xsl:with-param name="type">number</xsl:with-param>
				<xsl:with-param name="required" select="true()"/>
				<xsl:with-param name="minval">1</xsl:with-param>
			</xsl:call-template>
			<xsl:value-of select="$cr"/>

			<!--==========SET ADO PARAMETERS==========-->

			<xsl:call-template name="VBComment">
				<xsl:with-param name="indent">1</xsl:with-param>
				<xsl:with-param name="value">populate the parameters for the procedure call</xsl:with-param>
			</xsl:call-template>

			<xsl:value-of select="concat($tab1, 'With oCmd', $cr)"/>

			<xsl:if test="($ischild)">
				<xsl:for-each select="($parentfields)">
					<xsl:variable name="aname" select="@name"/>
					<xsl:for-each select = "/Data/WTENTITY/WTATTRIBUTE[@name=$aname]">
						<xsl:call-template name="VBADOSetParam">
							<xsl:with-param name="indent">2</xsl:with-param>
							<xsl:with-param name="name" select="@name"/>
							<xsl:with-param name="type" select="@type"/>
							<xsl:with-param name="value" select="concat('bv', @name)"/>
						</xsl:call-template>
					</xsl:for-each>
				</xsl:for-each>
			</xsl:if>

			<xsl:call-template name="VBADOSetParam">
				<xsl:with-param name="indent">2</xsl:with-param>
				<xsl:with-param name="name">UserID</xsl:with-param>
				<xsl:with-param name="value">bvUserID</xsl:with-param>
				<xsl:with-param name="type">number</xsl:with-param>
			</xsl:call-template>

			<xsl:value-of select="concat($tab1, 'End With', $cr, $cr)"/>

			<!--==========EXECUTE COMMAND==========-->

 			<xsl:call-template name="VBRunSPRecordset">
				<xsl:with-param name="name">Enum</xsl:with-param>
				<xsl:with-param name="indent">1</xsl:with-param>
			</xsl:call-template>
			<xsl:value-of select="$cr"/>

			<!--==========GET RETURN VALUES==========-->

			<xsl:call-template name="VBRecordsetStart">
				<xsl:with-param name="indent">1</xsl:with-param>
			</xsl:call-template>

			<xsl:for-each select = "/Data/WTENTITY/WTATTRIBUTE[@identity or @name=$enumcolumn]">
				<xsl:variable name="rname">
					<xsl:choose>
						<xsl:when test="@identity"><xsl:text>ID</xsl:text></xsl:when>
						<xsl:otherwise><xsl:text>Name</xsl:text></xsl:otherwise>
					</xsl:choose>
				</xsl:variable>

				<xsl:call-template name="VBRecordsetFetch">
					<xsl:with-param name="indent">2</xsl:with-param>
					<xsl:with-param name="name" select="$rname"/>
					<xsl:with-param name="assignto" select="concat('vRec.', @name)"/>
					<xsl:with-param name="type" select="@type"/>
				</xsl:call-template>
			</xsl:for-each>

			<xsl:call-template name="VBRecordsetEnd">
				<xsl:with-param name="indent">1</xsl:with-param>
			</xsl:call-template>
			<xsl:value-of select="$cr"/>

			<xsl:call-template name="VBComment">
				<xsl:with-param name="indent">1</xsl:with-param>
				<xsl:with-param name="value">return the results</xsl:with-param>
			</xsl:call-template>
			<xsl:value-of select="concat($tab1, 'Enumerate = vRecs', $cr, $cr)"/>

			<xsl:call-template name="VBMethodEnd">
				<xsl:with-param name="type">Function</xsl:with-param>
				<xsl:with-param name="ismts" select="false()"/>
				<xsl:with-param name="isrecordset" select="true()"/>
			</xsl:call-template>
		</xsl:if>
   
		<!--==================================================================-->
		<!-- METHOD: ENUMERATE (CUSTOM) -->
		<!--==================================================================-->
		<xsl:for-each select="WTPROCEDURES/WTPROCEDURE[(@type='Enum') and (@template='new') and (@passthru='true')]">

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

			<xsl:call-template name="VBDataType">
				<xsl:with-param name="datatype">records</xsl:with-param>
			</xsl:call-template>
			<xsl:value-of select="$cr"/>

			<xsl:call-template name="VBFunctionBox">
				<xsl:with-param name="name" select="@name"/>
				<xsl:with-param name="desc">Returns an enumerated list of items.</xsl:with-param>
				<xsl:with-param name="ismts" select="false()"/>
				<xsl:with-param name="isrecordset" select="true()"/>
			</xsl:call-template>
			<xsl:value-of select="$cr"/>

			<xsl:call-template name="VBStartErrorHandler"/>

			<!--==========SET ADO PARAMETERS==========-->
			<xsl:apply-templates select="WTPARAM[@direction='input']" mode="setado">
				<xsl:with-param name="indent">1</xsl:with-param>
				<xsl:with-param name="functype">function</xsl:with-param>
			</xsl:apply-templates>

			<!--==========EXECUTE COMMAND==========-->
 			<xsl:call-template name="VBRunSPRecordset">
				<xsl:with-param name="name" select="@name"/>
				<xsl:with-param name="indent">1</xsl:with-param>
			</xsl:call-template>
			<xsl:value-of select="$cr"/>

			<!--==========GET RETURN VALUES==========-->
			<xsl:call-template name="VBRecordsetStart">
				<xsl:with-param name="indent">1</xsl:with-param>
			</xsl:call-template>

		   <xsl:variable name="id">
				<xsl:if test="@id"><xsl:value-of select="@id"/></xsl:if>
				<xsl:if test="not(@id)"><xsl:value-of select="$identityfield"/></xsl:if>
		   </xsl:variable>
		   <xsl:variable name="name" select="@column"/>
		   <xsl:variable name="idtype" select="/Data/WTENTITY/WTATTRIBUTE[@name=$id]/@type"/>
		   <xsl:variable name="nametype" select="/Data/WTENTITY/WTATTRIBUTE[@name=$name]/@type"/>

				<!-- ***************** Error Checking *******************-->
				<xsl:if test="string-length($id)=0">
				    <xsl:call-template name="Error">
				    	<xsl:with-param name="msg" select="'Enum ID Missing'"/>
				    	<xsl:with-param name="text" select="@name"/>
				    </xsl:call-template>
				</xsl:if>
				<xsl:if test="string-length($name)=0">
				    <xsl:call-template name="Error">
				    	<xsl:with-param name="msg" select="'Enum Name Missing'"/>
				    	<xsl:with-param name="text" select="@name"/>
				    </xsl:call-template>
				</xsl:if>
				<xsl:if test="string-length($idtype)=0">
				    <xsl:call-template name="Error">
				    	<xsl:with-param name="msg" select="'Enum ID Attribute Type Missing'"/>
				    	<xsl:with-param name="text" select="@name"/>
				    </xsl:call-template>
				</xsl:if>
				<xsl:if test="string-length($nametype)=0">
				    <xsl:call-template name="Error">
				    	<xsl:with-param name="msg" select="'Enum Name Attribute Type Missing'"/>
				    	<xsl:with-param name="text" select="@name"/>
				    </xsl:call-template>
				</xsl:if>
				<!-- ****************************************************-->

				<xsl:call-template name="VBRecordsetFetch">
					<xsl:with-param name="indent">2</xsl:with-param>
					<xsl:with-param name="name" select="'ID'"/>
					<xsl:with-param name="assignto" select="concat('vRec.', $id)"/>
					<xsl:with-param name="type" select="$idtype"/>
				</xsl:call-template>
				
				<xsl:call-template name="VBRecordsetFetch">
					<xsl:with-param name="indent">2</xsl:with-param>
					<xsl:with-param name="name" select="'Name'"/>
					<xsl:with-param name="assignto" select="concat('vRec.', $name)"/>
					<xsl:with-param name="type" select="$nametype"/>
				</xsl:call-template>

			<xsl:call-template name="VBRecordsetEnd">
				<xsl:with-param name="indent">1</xsl:with-param>
			</xsl:call-template>
			<xsl:value-of select="$cr"/>

			<xsl:call-template name="VBComment">
				<xsl:with-param name="indent">1</xsl:with-param>
				<xsl:with-param name="value">return the results</xsl:with-param>
			</xsl:call-template>
			<xsl:value-of select="concat($tab1, @name, ' = vRecs', $cr, $cr)"/>

			<xsl:call-template name="VBMethodEnd">
				<xsl:with-param name="type">Function</xsl:with-param>
				<xsl:with-param name="ismts" select="false()"/>
				<xsl:with-param name="isrecordset" select="true()"/>
			</xsl:call-template>
			
		</xsl:for-each>

		<!--==================================================================-->
		<!-- METHOD: FETCH -->
		<!--==================================================================-->
		<xsl:if test="WTPROCEDURES/WTPROCEDURE[@type='Fetch' and not(@template='new')]">
			<xsl:value-of select="$cr"/>
			<xsl:call-template name="VBMethodStart">
				<xsl:with-param name="type">Sub</xsl:with-param>
				<xsl:with-param name="name">Fetch</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="VBParam">
				<xsl:with-param name="name">Rec</xsl:with-param>
				<xsl:with-param name="type">record</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="VBParam">
				<xsl:with-param name="name">UserID</xsl:with-param>
				<xsl:with-param name="type">number</xsl:with-param>
				<xsl:with-param name="continue" select="false()"/>
			</xsl:call-template>
			<xsl:value-of select="concat(')', $cr)"/>

			<xsl:call-template name="VBFunctionBox">
				<xsl:with-param name="name">Fetch</xsl:with-param>
				<xsl:with-param name="desc">Retrieves the record.</xsl:with-param>
				<xsl:with-param name="ismts" select="false()"/>
			</xsl:call-template>
			<xsl:value-of select="$cr"/>

			<xsl:call-template name="VBStartErrorHandler"/>

			<!--==========EDIT INPUT PARAMETERS==========-->

			<xsl:call-template name="VBComment">
				<xsl:with-param name="indent">1</xsl:with-param>
				<xsl:with-param name="value">edit the input parameters</xsl:with-param>
			</xsl:call-template>

			<xsl:value-of select="concat($tab1, 'With brRec', $cr)"/>

			<xsl:for-each select="WTATTRIBUTE[@identity]">
				<xsl:call-template name="VBFieldEdit">
					<xsl:with-param name="indent">2</xsl:with-param>
					<xsl:with-param name="assignto" select="concat('.', @name)"/>
					<xsl:with-param name="name" select="concat('.', @name)"/>
					<xsl:with-param name="label" select="@name"/>
					<xsl:with-param name="type" select="@type"/>
					<xsl:with-param name="default" select="0"/>
					<xsl:with-param name="minval" select="0"/>
					<xsl:with-param name="maxval" select="@max"/>
					<xsl:with-param name="required" select="false()"/>
				</xsl:call-template>
			</xsl:for-each>

			<xsl:call-template name="VBFieldEdit">
				<xsl:with-param name="indent">2</xsl:with-param>
				<xsl:with-param name="assignto">bvUserID</xsl:with-param>
				<xsl:with-param name="name">bvUserID</xsl:with-param>
				<xsl:with-param name="label">User ID</xsl:with-param>
				<xsl:with-param name="type">number</xsl:with-param>
				<xsl:with-param name="required" select="true()"/>
				<xsl:with-param name="minval">1</xsl:with-param>
			</xsl:call-template>

			<xsl:value-of select="concat($tab1, 'End With', $cr, $cr)"/>

			<!--==========SET ADO PARAMETERS==========-->

			<xsl:call-template name="VBComment">
				<xsl:with-param name="indent">1</xsl:with-param>
				<xsl:with-param name="value">populate the parameters for the procedure call</xsl:with-param>
			</xsl:call-template>

			<xsl:value-of select="concat($tab1, 'With oCmd', $cr)"/>

			<xsl:for-each select="WTATTRIBUTE[((@source='entity') or (@source='inherit') or (@source='audit') or (@source='join')) and not(@persist)]">
				<xsl:variable name="dir">
					<xsl:if test="@identity"><xsl:text>input</xsl:text></xsl:if>
					<xsl:if test="not(@identity)"><xsl:text>output</xsl:text></xsl:if>
				</xsl:variable>

				<xsl:call-template name="VBADOSetParam">
					<xsl:with-param name="indent">2</xsl:with-param>
					<xsl:with-param name="name" select="@name"/>
					<xsl:with-param name="direction" select="$dir"/>
					<xsl:with-param name="value" select="concat('brRec.', @name)"/>
					<xsl:with-param name="type" select="@type"/>
					<xsl:with-param name="length" select="@length"/>
					<xsl:with-param name="precision" select="@precision"/>
				</xsl:call-template>
			</xsl:for-each>

			<xsl:call-template name="VBADOSetParam">
				<xsl:with-param name="indent">2</xsl:with-param>
				<xsl:with-param name="name">UserID</xsl:with-param>
				<xsl:with-param name="value">bvUserID</xsl:with-param>
				<xsl:with-param name="type">number</xsl:with-param>
			</xsl:call-template>

			<xsl:value-of select="concat($tab1, 'End With', $cr, $cr)"/>

			<!--==========EXECUTE COMMAND==========-->

 			<xsl:call-template name="VBRunSP">
				<xsl:with-param name="name">Fetch</xsl:with-param>
				<xsl:with-param name="indent">1</xsl:with-param>
			</xsl:call-template>
			<xsl:value-of select="$cr"/>

			<!--==========GET RETURN VALUES==========-->

			<xsl:call-template name="VBComment">
				<xsl:with-param name="indent">1</xsl:with-param>
				<xsl:with-param name="value">get return values</xsl:with-param>
			</xsl:call-template>

			<xsl:value-of select="concat($tab1, 'With brRec', $cr)"/>

			<xsl:for-each select="WTATTRIBUTE[not(@identity) and not(@persist)]">
				<xsl:call-template name="VBADOGetParam">
					<xsl:with-param name="indent">2</xsl:with-param>
					<xsl:with-param name="name" select="@name"/>
					<xsl:with-param name="type" select="@type"/>
					<xsl:with-param name="assignto" select="concat('.', @name)"/>
				</xsl:call-template>
			</xsl:for-each>

			<xsl:value-of select="concat($tab1, 'End With', $cr, $cr)"/>

			<xsl:call-template name="VBMethodEnd">
				<xsl:with-param name="type">Sub</xsl:with-param>
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

			<xsl:call-template name="VBParam">
				<xsl:with-param name="name">Rec</xsl:with-param>
				<xsl:with-param name="type">record</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="VBParam">
				<xsl:with-param name="name">UserID</xsl:with-param>
				<xsl:with-param name="type">number</xsl:with-param>
				<xsl:with-param name="continue" select="false()"/>
			</xsl:call-template>
			<xsl:value-of select="concat(')', $cr)"/>

			<xsl:call-template name="VBFunctionBox">
				<xsl:with-param name="name" select="@name"/>
				<xsl:with-param name="desc">Retrieves the record.</xsl:with-param>
				<xsl:with-param name="ismts" select="false()"/>
			</xsl:call-template>
			<xsl:value-of select="$cr"/>

			<xsl:call-template name="VBStartErrorHandler"/>

			<!--edit input parameters-->
			<xsl:if test="not(@novalidate or @noedit)">
				<xsl:apply-templates select="WTPARAM[@direction='input' or @direction='inputoutput']" mode="editinput">
					<xsl:with-param name="indent">1</xsl:with-param>
				</xsl:apply-templates>
			</xsl:if>

			<!--set ado parameters-->
			<xsl:apply-templates select="WTPARAM" mode="setado">
				<xsl:with-param name="indent">1</xsl:with-param>
			</xsl:apply-templates>

			<!--execute the command-->
 			<xsl:call-template name="VBRunSP">
				<xsl:with-param name="name" select="@name"/>
				<xsl:with-param name="indent">1</xsl:with-param>
			</xsl:call-template>
			<xsl:value-of select="$cr"/>

			<!--get return parameters-->
			<xsl:apply-templates select="descendant::WTPARAM[@direction='output' or @direction='inputoutput']" mode="getado">
				<xsl:with-param name="indent">1</xsl:with-param>
			</xsl:apply-templates>

			<xsl:call-template name="VBMethodEnd">
				<xsl:with-param name="type">Sub</xsl:with-param>
				<xsl:with-param name="ismts" select="false()"/>
			</xsl:call-template>
		</xsl:for-each>

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
					<xsl:with-param name="type">number</xsl:with-param>
				</xsl:call-template>
				<xsl:if test="WTBOOKMARK">
					<xsl:call-template name="VBParam">
						<xsl:with-param name="name">BookMark</xsl:with-param>
						<xsl:with-param name="type">text</xsl:with-param>
						<xsl:with-param name="byref" select="true()"/>
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
						<xsl:with-param name="continue" select="(count(WTPARAM)>0)"/>
					</xsl:call-template>
				</xsl:if>

				<!--==========add any additional parameters==========-->
				<xsl:for-each select="WTPARAM">
					<xsl:call-template name="VBParam">
						<xsl:with-param name="parameter" select="."/>
						<xsl:with-param name="continue" select="not(position()=last())"/>
					</xsl:call-template>
				</xsl:for-each>

				<xsl:value-of select="concat($tab0, ')')"/>
				<xsl:call-template name="VBDataType">
					<xsl:with-param name="datatype">records</xsl:with-param>
				</xsl:call-template>
				<xsl:value-of select="$cr"/>

				<xsl:call-template name="VBFunctionBox">
					<xsl:with-param name="name" select="@name"/>
					<xsl:with-param name="desc">Returns a list of records which match the specified search criteria.</xsl:with-param>
					<xsl:with-param name="ismts" select="false()"/>
					<xsl:with-param name="isrecordset" select="true()"/>
				</xsl:call-template>

				<xsl:value-of select="concat($tab1, 'Dim sProc')"/>
				<xsl:call-template name="VBDataType">
					<xsl:with-param name="datatype">text</xsl:with-param>
				</xsl:call-template>

				<xsl:if test="WTBOOKMARK">
					<xsl:value-of select="concat($cr, $tab1, 'Dim MaxBookMark')"/>
					<xsl:call-template name="VBDataType">
						<xsl:with-param name="datatype">small number</xsl:with-param>
					</xsl:call-template>
					<xsl:value-of select="concat($cr, $tab1, 'Dim MaxRows')"/>
					<xsl:call-template name="VBDataType">
						<xsl:with-param name="datatype">small number</xsl:with-param>
					</xsl:call-template>
					<xsl:value-of select="concat($cr, $tab1, 'Dim oBookmark')"/>
					<xsl:call-template name="VBDataType">
						<xsl:with-param name="datatype">wtSystem.CBookmark</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="WTSEARCH">
					<xsl:value-of select="concat($cr, $tab1, 'Dim MaxLen')"/>
					<xsl:call-template name="VBDataType">
						<xsl:with-param name="datatype">small number</xsl:with-param>
					</xsl:call-template>
				</xsl:if>

				<xsl:value-of select="concat($tab0, $cr, $cr)"/>
				<xsl:call-template name="VBStartErrorHandler"/>

				<!--==========INITIALIZE THE BOOKMARK==========-->

				<xsl:if test="WTBOOKMARK">
					<xsl:call-template name="VBComment">
						<xsl:with-param name="indent">1</xsl:with-param>
						<xsl:with-param name="value">initialize the bookmark</xsl:with-param>
					</xsl:call-template>
					<xsl:value-of select="concat($tab1, 'Set oBookMark = New wtSystem.CBookmark', $cr, $tab1, 'With oBookMark', $cr)"/>
					<xsl:value-of select="concat($tab2, '.LastBookmark = brBookMark', $cr, $tab2, '.Direction = bvDirection', $cr)"/>
					<xsl:value-of select="concat($tab2, '.SearchText = bvSearchText', $cr, $tab2, '.SearchType = bvFindType', $cr)"/>
					<xsl:value-of select="concat($tab1, 'End With', $cr, $cr)"/>
				</xsl:if>

				<!--==========EDIT INPUT PARAMETERS==========-->

				<xsl:call-template name="VBComment">
					<xsl:with-param name="indent">1</xsl:with-param>
					<xsl:with-param name="value">edit the input parameters</xsl:with-param>
				</xsl:call-template>

				<xsl:call-template name="VBFieldEdit">
					<xsl:with-param name="indent">1</xsl:with-param>
					<xsl:with-param name="assignto">bvFindType</xsl:with-param>
					<xsl:with-param name="name">bvFindType</xsl:with-param>
					<xsl:with-param name="label">Find Type</xsl:with-param>
					<xsl:with-param name="type">number</xsl:with-param>
					<xsl:with-param name="required" select="true()"/>
					<xsl:with-param name="minval">1</xsl:with-param>
				</xsl:call-template>

				<!--==========edit any additional parameters==========-->
				<xsl:for-each select="WTPARAM[not(@required='false')]">
					<xsl:variable name="nametype"><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="@name"/></xsl:call-template></xsl:variable>
					<xsl:variable name="nametext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@name"/></xsl:call-template></xsl:variable>
					<xsl:choose>
						<xsl:when test="($nametype='ATTR')">
							<xsl:variable name="attribute" select="/Data/WTENTITY/WTATTRIBUTE[@name=$nametext]"/>
							<xsl:call-template name="VBFieldEdit">
								<xsl:with-param name="indent">1</xsl:with-param>
								<xsl:with-param name="assignto" select="concat('bv', $attribute/@name)"/>
								<xsl:with-param name="name" select="concat('bv', $attribute/@name)"/>
								<xsl:with-param name="label" select="$attribute/@name"/>
								<xsl:with-param name="type" select="$attribute/@type"/>
								<xsl:with-param name="default" select="$attribute/@default"/>
								<xsl:with-param name="minval" select="$attribute/@min"/>
								<xsl:with-param name="maxval" select="$attribute/@max"/>
								<xsl:with-param name="required" select="true()"/>
							</xsl:call-template>
						</xsl:when>
						<xsl:when test="($nametype='SYS') and ($nametext='userid')">
							<xsl:call-template name="VBFieldEdit">
								<xsl:with-param name="indent">1</xsl:with-param>
								<xsl:with-param name="assignto">bvSecurityToken</xsl:with-param>
								<xsl:with-param name="name">bvSecurityToken</xsl:with-param>
								<xsl:with-param name="label">User ID</xsl:with-param>
								<xsl:with-param name="type">number</xsl:with-param>
								<xsl:with-param name="required" select="true()"/>
								<xsl:with-param name="minval">1</xsl:with-param>
							</xsl:call-template>
						</xsl:when>
					</xsl:choose>
				</xsl:for-each>

				<xsl:value-of select="$cr"/>

				<!--==========SET STORED PROCEDURE NAME==========-->

				<xsl:call-template name="VBComment">
					<xsl:with-param name="indent">1</xsl:with-param>
					<xsl:with-param name="value">set the stored procedure name</xsl:with-param>
				</xsl:call-template>

				<xsl:variable name="procname" select="concat($appprefix, '_', $entityname, '_', @name)"/>
				<xsl:value-of select="concat($tab1, 'Select Case bvFindType', $cr)"/>

				<xsl:variable name="isbookmark" select="count(WTBOOKMARK) > 0"/>
				<xsl:variable name="issearch" select="count(WTSEARCH) > 0"/>
				<xsl:variable name="enum">
					<xsl:choose>
						<xsl:when test="@enum">
							<xsl:value-of select="(@enum)"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="('1')"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>

				<xsl:for-each select="/Data/WTENTITY/WTENUM[@type='find' and @id=$enum]/WTATTRIBUTE">
					<xsl:variable name="attribute" select="/Data/WTENTITY/WTATTRIBUTE[@name=current()/@name]"/>
					<xsl:variable name="bkmklen">
						<xsl:choose>
							<xsl:when test="($attribute/@type='date')">20</xsl:when>
              <xsl:when test="($attribute/@type='number')">10</xsl:when>
              <xsl:when test="($attribute/@type='big number')">20</xsl:when>
              <xsl:when test="($attribute/@type='currency')">20</xsl:when>
							<xsl:otherwise><xsl:value-of select="$attribute/@length"/></xsl:otherwise>
						</xsl:choose>
					</xsl:variable>
					<xsl:value-of select="concat($tab2, 'Case c', $appprefix, $entityname, 'Find', @name, $cr)"/>
					<xsl:value-of select="concat($tab3, 'sProc = &quot;', $procname, @name, '&quot;', $cr)"/>
					<xsl:if test="$isbookmark">
						<xsl:value-of select="concat($tab3, 'MaxBookMark = ', $bkmklen+10)"/>
					</xsl:if>
					<xsl:if test="$issearch">
						<xsl:value-of select="concat($tab3, 'MaxLen = ', $bkmklen)"/>
					</xsl:if>
					<xsl:value-of select="$cr"/>
				</xsl:for-each> 
				<xsl:value-of select="concat($tab1, 'End Select', $cr)"/>
				<xsl:value-of select="$cr"/>

				<!--==========SET ADO PARAMETERS==========-->

				<xsl:call-template name="VBComment">
					<xsl:with-param name="indent">1</xsl:with-param>
					<xsl:with-param name="value">populate the parameters for the procedure call</xsl:with-param>
				</xsl:call-template>

				<xsl:value-of select="concat($tab1, 'With oCmd', $cr)"/>

				<xsl:if test="WTBOOKMARK">
					<xsl:call-template name="VBADOSetParam">
						<xsl:with-param name="indent">2</xsl:with-param>
						<xsl:with-param name="name">SearchText</xsl:with-param>
						<xsl:with-param name="value">oBookMark.SearchText</xsl:with-param>
						<xsl:with-param name="type">text</xsl:with-param>
						<xsl:with-param name="length">MaxBookMark</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="VBADOSetParam">
						<xsl:with-param name="indent">2</xsl:with-param>
						<xsl:with-param name="name">Bookmark</xsl:with-param>
						<xsl:with-param name="value">oBookMark.CurrentBookmark</xsl:with-param>
						<xsl:with-param name="type">text</xsl:with-param>
						<xsl:with-param name="length">MaxBookMark</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="VBADOSetParam">
						<xsl:with-param name="indent">2</xsl:with-param>
						<xsl:with-param name="name">MaxRows</xsl:with-param>
						<xsl:with-param name="type">number</xsl:with-param>
						<xsl:with-param name="direction">output</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="WTSEARCH">
					<xsl:call-template name="VBADOSetParam">
						<xsl:with-param name="indent">2</xsl:with-param>
						<xsl:with-param name="name">SearchText</xsl:with-param>
						<xsl:with-param name="value">bvSearchText</xsl:with-param>
						<xsl:with-param name="type">text</xsl:with-param>
						<xsl:with-param name="length">MaxLen</xsl:with-param>
					</xsl:call-template>
				</xsl:if>

				<!--==========additional parameters==========-->
				<xsl:for-each select="(WTPARAM)">
					<xsl:variable name="nametype"><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="@name"/></xsl:call-template></xsl:variable>
					<xsl:variable name="nametext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@name"/></xsl:call-template></xsl:variable>

					<xsl:choose>
						<xsl:when test="($nametype = 'ATTR')">
							<xsl:variable name="attribute" select="/Data/WTENTITY/WTATTRIBUTE[@name=$nametext]"/>
							<xsl:call-template name="VBADOSetParam">
								<xsl:with-param name="indent">2</xsl:with-param>
								<xsl:with-param name="name" select="$attribute/@name"/>
								<xsl:with-param name="type" select="$attribute/@type"/>
								<xsl:with-param name="value" select="concat('bv', $attribute/@name)"/>
								<xsl:with-param name="length" select="$attribute/@length"/>
							</xsl:call-template>
						</xsl:when>
						<xsl:when test="($nametype = 'SYS') and ($nametext='userid')">
							<xsl:call-template name="VBADOSetParam">
								<xsl:with-param name="indent">2</xsl:with-param>
								<xsl:with-param name="name">UserID</xsl:with-param>
								<xsl:with-param name="value">bvSecurityToken</xsl:with-param>
								<xsl:with-param name="type">number</xsl:with-param>
							</xsl:call-template>
						</xsl:when>
					</xsl:choose>
				</xsl:for-each>

				<xsl:value-of select="concat($tab1, 'End With', $cr, $cr)"/>

				<!--==========EXECUTE COMMAND==========-->

	 			<xsl:call-template name="VBRunSPRecordset">
					<xsl:with-param name="name">sProc</xsl:with-param>
					<xsl:with-param name="indent">1</xsl:with-param>
					<xsl:with-param name="noprefix" select="true()"/>
				</xsl:call-template>
				<xsl:value-of select="$cr"/>

				<!--==========GET RETURN VALUES==========-->
				<xsl:if test="WTBOOKMARK">
					<xsl:call-template name="VBComment">
						<xsl:with-param name="indent">1</xsl:with-param>
						<xsl:with-param name="value">get return values</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="VBADOGetParam">
						<xsl:with-param name="indent">1</xsl:with-param>
						<xsl:with-param name="name">MaxRows</xsl:with-param>
						<xsl:with-param name="type">small number</xsl:with-param>
						<xsl:with-param name="assignto">MaxRows</xsl:with-param>
					</xsl:call-template>
					<xsl:value-of select="$cr"/>
					<xsl:call-template name="VBRecordsetStart">
						<xsl:with-param name="indent">1</xsl:with-param>
						<xsl:with-param name="limit">MaxRows</xsl:with-param>
					</xsl:call-template>

					<xsl:if test="not(WTATTRIBUTE)">
						<xsl:for-each select = "/Data/WTENTITY/WTATTRIBUTE[not(@persist)]">
							<xsl:call-template name="VBRecordsetFetch">
								<xsl:with-param name="indent">3</xsl:with-param>
								<xsl:with-param name="name" select="@name"/>
								<xsl:with-param name="assignto" select="concat('vRec.', @name)"/>
								<xsl:with-param name="type" select="@type"/>
								<xsl:with-param name="limit">MaxRows</xsl:with-param>
							</xsl:call-template>
						</xsl:for-each>
					</xsl:if>
					<xsl:if test="WTATTRIBUTE">
						<xsl:for-each select="WTATTRIBUTE">
							<xsl:variable name="attrtype" select="/Data/WTENTITY/WTATTRIBUTE[@name=current()/@name]/@type"/>
							<xsl:call-template name="VBRecordsetFetch">
								<xsl:with-param name="indent">3</xsl:with-param>
								<xsl:with-param name="name" select="@name"/>
								<xsl:with-param name="assignto" select="concat('vRec.', @name)"/>
								<xsl:with-param name="type" select="$attrtype"/>
								<xsl:with-param name="limit">MaxRows</xsl:with-param>
							</xsl:call-template>
						</xsl:for-each>
					</xsl:if>
					
					<xsl:call-template name="VBRecordsetEnd">
						<xsl:with-param name="indent">1</xsl:with-param>
						<xsl:with-param name="limit">MaxRows</xsl:with-param>
					</xsl:call-template>
					<xsl:value-of select="$cr"/>

					<!--==========UPDATE BOOOKMARK==========-->
					<xsl:call-template name="VBComment">
						<xsl:with-param name="indent">1</xsl:with-param>
						<xsl:with-param name="value">update the bookmark for the next call</xsl:with-param>
					</xsl:call-template>
					<xsl:value-of select="concat($tab1, 'With oBookMark', $cr, $tab2, '.MaxRows = MaxRows', $cr)"/>
					<xsl:value-of select="concat($tab2, '.Update oRecs', $cr, $tab2, 'brBookmark = .NextBookmark', $cr)"/>
					<xsl:value-of select="concat($tab1, 'End With', $cr, $cr)"/>
				</xsl:if>

				<xsl:if test="WTSEARCH">
					<xsl:call-template name="VBRecordsetStart">
						<xsl:with-param name="indent">1</xsl:with-param>
					</xsl:call-template>

					<xsl:if test="not(WTATTRIBUTE)">
						<xsl:for-each select = "/Data/WTENTITY/WTATTRIBUTE[not(@persist)]">
							<xsl:call-template name="VBRecordsetFetch">
								<xsl:with-param name="indent">3</xsl:with-param>
								<xsl:with-param name="name" select="@name"/>
								<xsl:with-param name="assignto" select="concat('vRec.', @name)"/>
								<xsl:with-param name="type" select="@type"/>
							</xsl:call-template>
						</xsl:for-each>
					</xsl:if>
					<xsl:if test="WTATTRIBUTE">
						<xsl:for-each select="WTATTRIBUTE">
							<xsl:variable name="attrtype" select="/Data/WTENTITY/WTATTRIBUTE[@name=current()/@name]/@type"/>
							<xsl:call-template name="VBRecordsetFetch">
								<xsl:with-param name="indent">3</xsl:with-param>
								<xsl:with-param name="name" select="@name"/>
								<xsl:with-param name="assignto" select="concat('vRec.', @name)"/>
								<xsl:with-param name="type" select="$attrtype"/>
							</xsl:call-template>
						</xsl:for-each>
					</xsl:if>
					
					<xsl:call-template name="VBRecordsetEnd">
						<xsl:with-param name="indent">1</xsl:with-param>
					</xsl:call-template>
					<xsl:value-of select="$cr"/>

				</xsl:if>

				<xsl:call-template name="VBComment">
					<xsl:with-param name="indent">1</xsl:with-param>
					<xsl:with-param name="value">return the results</xsl:with-param>
				</xsl:call-template>

				<xsl:value-of select="concat($tab1, @name, ' = vRecs', $cr)"/>

				<xsl:value-of select="$cr"/>
				<xsl:call-template name="VBMethodEnd">
					<xsl:with-param name="type">Function</xsl:with-param>
					<xsl:with-param name="ismts" select="false()"/>
					<xsl:with-param name="isrecordset" select="true()"/>
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
					<xsl:with-param name="byref" select="true()"/>
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
					<xsl:with-param name="continue" select="(count(WTPARAM)>0)"/>
				</xsl:call-template>
			</xsl:if>

			<!--==========add any additional parameters==========-->
			<xsl:for-each select="WTPARAM">
				<xsl:call-template name="VBParam">
					<xsl:with-param name="parameter" select="."/>
					<xsl:with-param name="continue" select="not(position()=last())"/>
				</xsl:call-template>
			</xsl:for-each>

			<xsl:value-of select="concat($tab0, ')')"/>
			<xsl:call-template name="VBDataType">
				<xsl:with-param name="datatype">records</xsl:with-param>
			</xsl:call-template>
			<xsl:value-of select="$cr"/>

			<xsl:call-template name="VBFunctionBox">
				<xsl:with-param name="name" select="@name"/>
				<xsl:with-param name="desc">Returns a list of records which match the specified search criteria.</xsl:with-param>
				<xsl:with-param name="ismts" select="false()"/>
				<xsl:with-param name="isrecordset" select="true()"/>
			</xsl:call-template>

			<xsl:if test="WTBOOKMARK">
				<xsl:value-of select="concat($tab1, 'Dim MaxRows')"/>
				<xsl:call-template name="VBDataType">
					<xsl:with-param name="datatype">small number</xsl:with-param>
				</xsl:call-template>
				<xsl:value-of select="concat($cr, $tab1, 'Dim oBookmark')"/>
				<xsl:call-template name="VBDataType">
					<xsl:with-param name="datatype">wtSystem.CBookmark</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<xsl:if test="WTSEARCH">
				<xsl:value-of select="concat($cr, $tab1, 'Dim MaxLen')"/>
				<xsl:call-template name="VBDataType">
					<xsl:with-param name="datatype">small number</xsl:with-param>
				</xsl:call-template>
			</xsl:if>

			<xsl:value-of select="concat($tab0, $cr, $cr)"/>
			<xsl:call-template name="VBStartErrorHandler"/>

			<!--==========INITIALIZE THE BOOKMARK==========-->

			<xsl:if test="WTBOOKMARK">
				<xsl:call-template name="VBComment">
					<xsl:with-param name="indent">1</xsl:with-param>
					<xsl:with-param name="value">initialize the bookmark</xsl:with-param>
				</xsl:call-template>
				<xsl:value-of select="concat($tab1, 'Set oBookMark = New wtSystem.CBookmark', $cr, $tab1, 'With oBookMark', $cr)"/>
				<xsl:value-of select="concat($tab2, '.LastBookmark = brBookMark', $cr, $tab2, '.Direction = bvDirection', $cr)"/>
				<xsl:value-of select="concat($tab2, '.SearchText = bvSearchText', $cr)"/>
				<xsl:value-of select="concat($tab1, 'End With', $cr, $cr)"/>
			</xsl:if>

			<xsl:variable name="bkmklen">
				<xsl:choose>
					<xsl:when test="@bookmarklength"><xsl:value-of select="@bookmarklength"/></xsl:when>
					<xsl:otherwise>100</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>

			<xsl:variable name="srchlen">
				<xsl:choose>
					<xsl:when test="@searchlength"><xsl:value-of select="@searchlength"/></xsl:when>
					<xsl:otherwise>100</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>

			<!--==========SET ADO PARAMETERS==========-->

			<xsl:call-template name="VBComment">
				<xsl:with-param name="indent">1</xsl:with-param>
				<xsl:with-param name="value">populate the parameters for the procedure call</xsl:with-param>
			</xsl:call-template>

			<xsl:value-of select="concat($tab1, 'With oCmd', $cr)"/>

			<xsl:if test="WTBOOKMARK">
				<xsl:call-template name="VBADOSetParam">
					<xsl:with-param name="indent">2</xsl:with-param>
					<xsl:with-param name="name">SearchText</xsl:with-param>
					<xsl:with-param name="value">oBookMark.SearchText</xsl:with-param>
					<xsl:with-param name="type">text</xsl:with-param>
					<xsl:with-param name="length" select="$srchlen"/>
				</xsl:call-template>
				<xsl:call-template name="VBADOSetParam">
					<xsl:with-param name="indent">2</xsl:with-param>
					<xsl:with-param name="name">Bookmark</xsl:with-param>
					<xsl:with-param name="value">oBookMark.CurrentBookmark</xsl:with-param>
					<xsl:with-param name="type">text</xsl:with-param>
					<xsl:with-param name="length" select="$bkmklen"/>
				</xsl:call-template>
				<xsl:call-template name="VBADOSetParam">
					<xsl:with-param name="indent">2</xsl:with-param>
					<xsl:with-param name="name">MaxRows</xsl:with-param>
					<xsl:with-param name="type">number</xsl:with-param>
					<xsl:with-param name="direction">output</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<xsl:if test="WTSEARCH">
				<xsl:call-template name="VBADOSetParam">
					<xsl:with-param name="indent">2</xsl:with-param>
					<xsl:with-param name="name">SearchText</xsl:with-param>
					<xsl:with-param name="value">bvSearchText</xsl:with-param>
					<xsl:with-param name="type">text</xsl:with-param>
					<xsl:with-param name="length">MaxLen</xsl:with-param>
				</xsl:call-template>
			</xsl:if>

			<!--==========additional parameters==========-->
			<xsl:for-each select="WTPARAM[not(@required='false')]">
				<xsl:variable name="nametype"><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="@name"/></xsl:call-template></xsl:variable>
				<xsl:variable name="nametext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@name"/></xsl:call-template></xsl:variable>
				<xsl:choose>
					<xsl:when test="($nametype = 'ATTR')">
						<xsl:variable name="attribute" select="/Data/WTENTITY/WTATTRIBUTE[@name=$nametext]"/>
						<xsl:call-template name="VBADOSetParam">
							<xsl:with-param name="indent">2</xsl:with-param>
							<xsl:with-param name="name" select="$attribute/@name"/>
							<xsl:with-param name="type" select="$attribute/@type"/>
							<xsl:with-param name="value" select="concat('bv', $attribute/@name)"/>
							<xsl:with-param name="length" select="$attribute/@length"/>
						</xsl:call-template>
					</xsl:when>
					<xsl:when test="($nametype = 'SYS') and ($nametext='userid')">
						<xsl:call-template name="VBADOSetParam">
							<xsl:with-param name="indent">2</xsl:with-param>
							<xsl:with-param name="name">UserID</xsl:with-param>
							<xsl:with-param name="value">bvSecurityToken</xsl:with-param>
							<xsl:with-param name="type">number</xsl:with-param>
						</xsl:call-template>
					</xsl:when>
				</xsl:choose>
			</xsl:for-each>

			<xsl:value-of select="concat($tab1, 'End With', $cr, $cr)"/>

			<!--==========EXECUTE COMMAND==========-->

	 		<xsl:call-template name="VBRunSPRecordset">
				<xsl:with-param name="name" select="concat('&quot;', $appprefix, '_', $entityname, '_', @name, '&quot;')"/>
				<xsl:with-param name="indent">1</xsl:with-param>
				<xsl:with-param name="noprefix" select="true()"/>
			</xsl:call-template>
			<xsl:value-of select="$cr"/>

			<!--==========GET RETURN VALUES==========-->

			<xsl:if test="WTBOOKMARK">
				<xsl:call-template name="VBComment">
					<xsl:with-param name="indent">1</xsl:with-param>
					<xsl:with-param name="value">get return values</xsl:with-param>
				</xsl:call-template>

				<xsl:call-template name="VBADOGetParam">
					<xsl:with-param name="indent">1</xsl:with-param>
					<xsl:with-param name="name">MaxRows</xsl:with-param>
					<xsl:with-param name="type">small number</xsl:with-param>
					<xsl:with-param name="assignto">MaxRows</xsl:with-param>
				</xsl:call-template>
				<xsl:value-of select="$cr"/>

				<xsl:call-template name="VBRecordsetStart">
					<xsl:with-param name="indent">1</xsl:with-param>
					<xsl:with-param name="limit">MaxRows</xsl:with-param>
				</xsl:call-template>

				<xsl:for-each select = "descendant::WTATTRIBUTE">
					<xsl:variable name="nametext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>
					<xsl:call-template name="VBRecordsetFetch">
						<xsl:with-param name="indent">3</xsl:with-param>
						<xsl:with-param name="name" select="$nametext"/>
						<xsl:with-param name="assignto" select="concat('vRec.', $nametext)"/>
						<xsl:with-param name="type" select="/Data/WTENTITY/WTATTRIBUTE[@name=$nametext]/@type"/>
					</xsl:call-template>
				</xsl:for-each>

				<xsl:call-template name="VBRecordsetEnd">
					<xsl:with-param name="indent">1</xsl:with-param>
					<xsl:with-param name="limit">MaxRows</xsl:with-param>
				</xsl:call-template>
				<xsl:value-of select="$cr"/>

				<!--==========UPDATE BOOOKMARK==========-->
				<xsl:call-template name="VBComment">
					<xsl:with-param name="indent">1</xsl:with-param>
					<xsl:with-param name="value">update the bookmark for the next call</xsl:with-param>
				</xsl:call-template>
				<xsl:value-of select="concat($tab1, 'With oBookMark', $cr, $tab2, '.MaxRows = MaxRows', $cr)"/>
				<xsl:value-of select="concat($tab2, '.Update oRecs', $cr, $tab2, 'brBookmark = .NextBookmark', $cr)"/>
				<xsl:value-of select="concat($tab1, 'End With', $cr)"/>
				<xsl:value-of select="concat($tab1, 'Set oBookMark = Nothing' $cr, $cr)"/>
			</xsl:if>
			
			<xsl:if test="WTSEARCH">
				<xsl:call-template name="VBRecordsetStart">
					<xsl:with-param name="indent">1</xsl:with-param>
				</xsl:call-template>

				<xsl:for-each select = "descendant::WTATTRIBUTE">
					<xsl:variable name="nametext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>
					<xsl:call-template name="VBRecordsetFetch">
						<xsl:with-param name="indent">3</xsl:with-param>
						<xsl:with-param name="name" select="$nametext"/>
						<xsl:with-param name="assignto" select="concat('vRec.', $nametext)"/>
						<xsl:with-param name="type" select="/Data/WTENTITY/WTATTRIBUTE[@name=$nametext]/@type"/>
					</xsl:call-template>
				</xsl:for-each>
				
				<xsl:call-template name="VBRecordsetEnd">
					<xsl:with-param name="indent">1</xsl:with-param>
				</xsl:call-template>
				<xsl:value-of select="$cr"/>
			</xsl:if>
			
			<xsl:call-template name="VBComment">
				<xsl:with-param name="indent">1</xsl:with-param>
				<xsl:with-param name="value">return the results</xsl:with-param>
			</xsl:call-template>
			<xsl:value-of select="concat($tab1, @name, ' = vRecs', $cr)"/>

			<xsl:value-of select="$cr"/>
			<xsl:call-template name="VBMethodEnd">
				<xsl:with-param name="type">Function</xsl:with-param>
				<xsl:with-param name="ismts" select="false()"/>
				<xsl:with-param name="isrecordset" select="true()"/>
			</xsl:call-template>
		</xsl:for-each>

		<!--==================================================================-->
		<!-- METHOD: LIST -->
		<!--==================================================================-->
		<xsl:if test="($haslist)">
			<xsl:for-each select="/Data/WTENTITY/WTPROCEDURES/WTPROCEDURE[(@type='List') and not(@template)]">
				<xsl:variable name="procbasename">
					<xsl:call-template name="StripText">
						<xsl:with-param name="value" select="@name"/>
					</xsl:call-template>
				</xsl:variable>
				<xsl:variable name="listparams" select="(WTPARAM[@name!='#'])"/>

				<xsl:value-of select="$cr"/>

				<xsl:call-template name="VBMethodStart">
					<xsl:with-param name="type">Function</xsl:with-param>
					<xsl:with-param name="name" select="$procbasename"/>
				</xsl:call-template>

				<xsl:call-template name="VBParam">
					<xsl:with-param name="name">ListType</xsl:with-param>
					<xsl:with-param name="type">number</xsl:with-param>
				</xsl:call-template>

				<xsl:if test="($multilist)">
					<xsl:call-template name="VBParam">
						<xsl:with-param name="name">ParentID</xsl:with-param>
						<xsl:with-param name="type">number</xsl:with-param>
					</xsl:call-template>
				</xsl:if>

				<!--==========add any additional parameters==========-->
				<xsl:for-each select="(WTPARAM[@name!='#'])">
					<xsl:variable name="aname" select="@name"/>
					<xsl:for-each select = "/Data/WTENTITY/WTATTRIBUTE[@name=$aname]">
						<xsl:call-template name="VBParam">
							<xsl:with-param name="name" select="@name"/>
							<xsl:with-param name="type" select="@type"/>
						</xsl:call-template>
					</xsl:for-each>
				</xsl:for-each>

				<xsl:call-template name="VBParam">
					<xsl:with-param name="name">UserID</xsl:with-param>
					<xsl:with-param name="type">number</xsl:with-param>
					<xsl:with-param name="continue" select="false()"/>
				</xsl:call-template>

				<xsl:value-of select="concat($tab0, ')')"/>
				<xsl:call-template name="VBDataType">
					<xsl:with-param name="datatype">records</xsl:with-param>
				</xsl:call-template>
				<xsl:value-of select="$cr"/>

				<xsl:call-template name="VBFunctionBox">
					<xsl:with-param name="name" select="$procbasename"/>
					<xsl:with-param name="desc">Returns a list of items.</xsl:with-param>
					<xsl:with-param name="ismts" select="false()"/>
					<xsl:with-param name="isrecordset" select="true()"/>
				</xsl:call-template>

				<xsl:call-template name="VBVariable">
					<xsl:with-param name="scope">Dim</xsl:with-param>
					<xsl:with-param name="name">sProc</xsl:with-param>
					<xsl:with-param name="type">text</xsl:with-param>
					<xsl:with-param name="indent">1</xsl:with-param>
				</xsl:call-template>

				<xsl:call-template name="VBVariable">
					<xsl:with-param name="scope">Dim</xsl:with-param>
					<xsl:with-param name="name">sParam</xsl:with-param>
					<xsl:with-param name="type">text</xsl:with-param>
					<xsl:with-param name="indent">1</xsl:with-param>
				</xsl:call-template>
				<xsl:value-of select="$cr"/>

			<xsl:call-template name="VBStartErrorHandler"/>

			<!--==========EDIT INPUT PARAMETERS==========-->

				<xsl:call-template name="VBComment">
					<xsl:with-param name="indent">1</xsl:with-param>
					<xsl:with-param name="value">edit the input parameters</xsl:with-param>
				</xsl:call-template>

				<xsl:call-template name="VBFieldEdit">
					<xsl:with-param name="indent">1</xsl:with-param>
					<xsl:with-param name="assignto">bvListType</xsl:with-param>
					<xsl:with-param name="name">bvListType</xsl:with-param>
					<xsl:with-param name="label">List Type</xsl:with-param>
					<xsl:with-param name="type">number</xsl:with-param>
					<xsl:with-param name="required" select="$multilist"/>
					<xsl:with-param name="minval">1</xsl:with-param>
				</xsl:call-template>


				<xsl:if test="($multilist)">
					<xsl:call-template name="VBFieldEdit">
						<xsl:with-param name="indent">1</xsl:with-param>
						<xsl:with-param name="assignto">bvParentID</xsl:with-param>
						<xsl:with-param name="name">bvParentID</xsl:with-param>
						<xsl:with-param name="label">Parent ID</xsl:with-param>
						<xsl:with-param name="type">number</xsl:with-param>
						<xsl:with-param name="required" select="$multilist"/>
						<xsl:with-param name="minval">
							<xsl:choose>
								<xsl:when test="$multilist">1</xsl:when>
								<xsl:otherwise>0</xsl:otherwise>
							</xsl:choose>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>

				<!--==========edit any additional parameters==========-->
				<xsl:for-each select="(WTPARAM[@name!='#' and not(@required='false')])">
					<xsl:variable name="aname" select="@name"/>
					<xsl:for-each select = "/Data/WTENTITY/WTATTRIBUTE[@name=$aname]">
						<xsl:call-template name="VBFieldEdit">
							<xsl:with-param name="indent">1</xsl:with-param>
							<xsl:with-param name="assignto" select="concat('bv', @name)"/>
							<xsl:with-param name="name" select="concat('bv', @name)"/>
							<xsl:with-param name="label" select="@name"/>
							<xsl:with-param name="type" select="@type"/>
							<xsl:with-param name="default" select="@default"/>
							<xsl:with-param name="minval" select="@min"/>
							<xsl:with-param name="maxval" select="@max"/>
							<xsl:with-param name="required" select="false()"/>
						</xsl:call-template>
					</xsl:for-each>
				</xsl:for-each>

				<xsl:call-template name="VBFieldEdit">
					<xsl:with-param name="indent">1</xsl:with-param>
					<xsl:with-param name="assignto">bvUserID</xsl:with-param>
					<xsl:with-param name="name">bvUserID</xsl:with-param>
					<xsl:with-param name="label">User ID</xsl:with-param>
					<xsl:with-param name="type">number</xsl:with-param>
					<xsl:with-param name="required" select="true()"/>
					<xsl:with-param name="minval">1</xsl:with-param>
				</xsl:call-template>
				<xsl:value-of select="$cr"/>

				<!--==========SET STORED PROCEDURE NAME==========-->

				<xsl:call-template name="VBComment">
					<xsl:with-param name="indent">1</xsl:with-param>
					<xsl:with-param name="value">set the stored procedure name</xsl:with-param>
				</xsl:call-template>

				<xsl:value-of select="concat($tab1, 'Select Case bvListType', $cr)"/>
				<xsl:choose>
					<xsl:when test="($multilist)">
						<!--==========add a case for each list type defined for the entity==========-->
						<xsl:for-each select="/Data/WTENTITY/WTENUM[@type='list']/WTATTRIBUTE">
							<xsl:variable name="aname" select="@name"/>
							<xsl:for-each select = "/Data/WTENTITY/WTATTRIBUTE[@name=$aname]">
								<xsl:variable name="procname" select="concat($appprefix, '_', $entityname, '_', $procbasename, @name)"/>
								<xsl:value-of select="concat($tab2, 'Case c', $appprefix, $entityname, 'List', @name, $cr)"/>
								<xsl:value-of select="concat($tab3, 'sProc = &quot;', $procname, '&quot;', $cr)"/>
								<xsl:value-of select="concat($tab3, 'sParam = &quot;@', @name, '&quot;', $cr)"/>
							</xsl:for-each> 
						</xsl:for-each> 
					</xsl:when>
					<xsl:otherwise>
						<!--==========add case else to handle list all==========-->
						<xsl:variable name="procname" select="concat($appprefix, '_', $entityname, '_', $procbasename)"/>
						<xsl:value-of select="concat($tab2, 'Case c', $appprefix, $entityname, 'ListAll', $cr)"/>
						<xsl:value-of select="concat($tab3, 'sProc = &quot;', $procname, '&quot;', $cr)"/>
						<xsl:value-of select="concat($tab3, 'sParam = &quot;&quot;', $cr)"/>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:value-of select="concat($tab1, 'End Select', $cr)"/>
				<xsl:value-of select="$cr"/>

				<!--==========SET ADO PARAMETERS==========-->

				<xsl:call-template name="VBComment">
					<xsl:with-param name="indent">1</xsl:with-param>
					<xsl:with-param name="value">populate the parameters for the procedure call</xsl:with-param>
				</xsl:call-template>

				<xsl:value-of select="concat($tab1, 'With oCmd', $cr)"/>

				<xsl:if test="($multilist)">
					<xsl:call-template name="VBADOSetParam">
						<xsl:with-param name="indent">2</xsl:with-param>
						<xsl:with-param name="name">sParam</xsl:with-param>
						<xsl:with-param name="value">bvParentID</xsl:with-param>
						<xsl:with-param name="type">number</xsl:with-param>
						<xsl:with-param name="noquote" select="true()"/>
					</xsl:call-template>
				</xsl:if>

				<!--==========additional parameters==========-->
				<xsl:for-each select="(WTPARAM[@name!='#'])">

					<xsl:variable name="nametype">
						<xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="@name"/></xsl:call-template>
					</xsl:variable>
					<xsl:variable name="aname">
						<xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@name"/></xsl:call-template>
					</xsl:variable>

					<xsl:choose>
						<xsl:when test="(($nametype != 'SYS') and ($nametype != 'ATTR'))">
							<xsl:for-each select = "/Data/WTENTITY/WTATTRIBUTE[@name=$aname]">
								<xsl:call-template name="VBADOSetParam">
									<xsl:with-param name="indent">2</xsl:with-param>
									<xsl:with-param name="name" select="@name"/>
									<xsl:with-param name="type" select="@type"/>
									<xsl:with-param name="value" select="concat('bv', @name)"/>
								</xsl:call-template>
							</xsl:for-each>
							<xsl:value-of select="$cr"/>
						</xsl:when>
					</xsl:choose>
				</xsl:for-each>

				<xsl:call-template name="VBADOSetParam">
					<xsl:with-param name="indent">2</xsl:with-param>
					<xsl:with-param name="name">UserID</xsl:with-param>
					<xsl:with-param name="value">bvUserID</xsl:with-param>
					<xsl:with-param name="type">number</xsl:with-param>
				</xsl:call-template>

				<xsl:value-of select="concat($tab1, 'End With', $cr, $cr)"/>

				<!--==========EXECUTE COMMAND==========-->

	 			<xsl:call-template name="VBRunSPRecordset">
					<xsl:with-param name="name">sProc</xsl:with-param>
					<xsl:with-param name="indent">1</xsl:with-param>
					<xsl:with-param name="noprefix" select="true()"/>
				</xsl:call-template>
				<xsl:value-of select="$cr"/>

				<!--==========GET RETURN VALUES==========-->

				<xsl:call-template name="VBRecordsetStart">
					<xsl:with-param name="indent">1</xsl:with-param>
				</xsl:call-template>

				<xsl:for-each select = "/Data/WTENTITY/WTATTRIBUTE[not(@persist)]">
					<xsl:call-template name="VBRecordsetFetch">
						<xsl:with-param name="indent">2</xsl:with-param>
						<xsl:with-param name="name" select="@name"/>
						<xsl:with-param name="assignto" select="concat('vRec.', @name)"/>
						<xsl:with-param name="type" select="@type"/>
					</xsl:call-template>
				</xsl:for-each>

				<xsl:call-template name="VBRecordsetEnd">
					<xsl:with-param name="indent">1</xsl:with-param>
				</xsl:call-template>
				<xsl:value-of select="$cr"/>

				<xsl:call-template name="VBComment">
					<xsl:with-param name="indent">1</xsl:with-param>
					<xsl:with-param name="value">return the results</xsl:with-param>
				</xsl:call-template>
				<xsl:value-of select="concat($tab1, $procbasename, ' = vRecs', $cr, $cr)"/>

				<xsl:call-template name="VBMethodEnd">
					<xsl:with-param name="type">Function</xsl:with-param>
					<xsl:with-param name="ismts" select="false()"/>
					<xsl:with-param name="isrecordset" select="true()"/>
				</xsl:call-template>
	
			</xsl:for-each>
		</xsl:if>

		<!--==================================================================-->
		<!-- METHOD: LIST (CUSTOM) -->
		<!--==================================================================-->
		<xsl:for-each select="WTPROCEDURES/WTPROCEDURE[(@type='List') and (@template='new') and (@passthru='true')]">

			<xsl:value-of select="$cr"/>
			<xsl:call-template name="VBMethodStart">
				<xsl:with-param name="type">Function</xsl:with-param>
				<xsl:with-param name="name" select="@name"/>
				<xsl:with-param name="noparams" select="count(WTPARAM[@direction='input'])=0"/>
			</xsl:call-template>

			<!--input parameters-->
			<xsl:apply-templates select="WTPARAM[@direction='input']" mode="inputparam">
				<xsl:with-param name="indent">1</xsl:with-param>
				<xsl:with-param name="functype">function</xsl:with-param>
			</xsl:apply-templates>

			<xsl:call-template name="VBDataType">
				<xsl:with-param name="datatype">records</xsl:with-param>
			</xsl:call-template>
			<xsl:value-of select="$cr"/>

			<xsl:call-template name="VBFunctionBox">
				<xsl:with-param name="name" select="@name"/>
				<xsl:with-param name="desc">Returns a list of items.</xsl:with-param>
				<xsl:with-param name="ismts" select="false()"/>
				<xsl:with-param name="isrecordset" select="true()"/>
			</xsl:call-template>

			<xsl:if test="WTSQL">
				<xsl:value-of select="concat($tab1, 'Dim sSQL As String', $cr)"/>
			</xsl:if>

			<xsl:value-of select="$cr"/>

			<xsl:call-template name="VBStartErrorHandler"/>

			<!--edit input parameters-->
			<xsl:if test="not(@novalidate or @noedit)">
				<xsl:apply-templates select="WTPARAM[@direction='input' and not(@required='false')]" mode="editinput">
					<xsl:with-param name="indent">1</xsl:with-param>
					<xsl:with-param name="functype">function</xsl:with-param>
				</xsl:apply-templates>
			</xsl:if>

			<!--set ado parameters-->
			<xsl:if test="not(WTSQL)">
				<xsl:apply-templates select="WTPARAM" mode="setado">
					<xsl:with-param name="indent">1</xsl:with-param>
					<xsl:with-param name="functype">function</xsl:with-param>
				</xsl:apply-templates>
			</xsl:if>

			<!--execute the command-->
	 		<xsl:call-template name="VBRunSPRecordset">
				<xsl:with-param name="name" select="@name"/>
				<xsl:with-param name="indent">1</xsl:with-param>
			</xsl:call-template>
			<xsl:value-of select="$cr"/>

			<!--fetch recordset values-->
			<xsl:apply-templates select="descendant::WTATTRIBUTE" mode="getadorecords">
				<xsl:with-param name="indent">1</xsl:with-param>
			</xsl:apply-templates>

			<!--set function return value-->
			<xsl:call-template name="VBComment">
				<xsl:with-param name="indent">1</xsl:with-param>
				<xsl:with-param name="value">return the results</xsl:with-param>
			</xsl:call-template>
			<xsl:value-of select="concat($tab1, @name, ' = vRecs', $cr, $cr)"/>

			<xsl:call-template name="VBMethodEnd">
				<xsl:with-param name="type">Function</xsl:with-param>
				<xsl:with-param name="ismts" select="false()"/>
				<xsl:with-param name="isrecordset" select="true()"/>
			</xsl:call-template>
		</xsl:for-each>

		<!--==================================================================-->
		<!-- METHOD: PURGE -->
		<!--==================================================================-->
		<xsl:if test="count(/Data/WTENTITY/WTPROCEDURES/WTPROCEDURE[@type='Delete' and @name='Purge']) > 0">
			<xsl:value-of select="$cr"/>
			<xsl:call-template name="VBMethodStart">
				<xsl:with-param name="type">Sub</xsl:with-param>
				<xsl:with-param name="name">Purge</xsl:with-param>
			</xsl:call-template>

			<xsl:if test="($ischild)">
				<xsl:for-each select="($parentfields)">
					<xsl:variable name="aname" select="@name"/>
					<xsl:for-each select = "/Data/WTENTITY/WTATTRIBUTE[@name=$aname]">
						<xsl:call-template name="VBParam">
							<xsl:with-param name="name" select="@name"/>
							<xsl:with-param name="type" select="@type"/>
						</xsl:call-template>
					</xsl:for-each>
				</xsl:for-each>
			</xsl:if>

			<xsl:call-template name="VBParam">
				<xsl:with-param name="name">UserID</xsl:with-param>
				<xsl:with-param name="type">number</xsl:with-param>
				<xsl:with-param name="continue" select="false()"/>
			</xsl:call-template>
			<xsl:value-of select="concat($tab0, ')', $cr)"/>

			<xsl:call-template name="VBFunctionBox">
				<xsl:with-param name="name">Purge</xsl:with-param>
				<xsl:with-param name="desc">Purges all but the most current child record.</xsl:with-param>
			</xsl:call-template>
			<xsl:value-of select="$cr"/>

			<xsl:call-template name="VBStartErrorHandler"/>
			<xsl:call-template name="VBMTSContext"/>

			<!--==========EDIT INPUT PARAMETERS==========-->

			<xsl:call-template name="VBComment">
				<xsl:with-param name="indent">1</xsl:with-param>
				<xsl:with-param name="value">edit the input parameters</xsl:with-param>
			</xsl:call-template>


			<xsl:if test="($ischild)">
				<xsl:for-each select="($parentfields)">
					<xsl:variable name="aname" select="@name"/>
					<xsl:for-each select = "/Data/WTENTITY/WTATTRIBUTE[@name=$aname]">
						<xsl:call-template name="VBFieldEdit">
							<xsl:with-param name="indent">1</xsl:with-param>
							<xsl:with-param name="assignto" select="concat('bv', @name)"/>
							<xsl:with-param name="name" select="concat('bv', @name)"/>
							<xsl:with-param name="label" select="@name"/>
							<xsl:with-param name="type" select="@type"/>
							<xsl:with-param name="default" select="@default"/>
							<xsl:with-param name="minval" select="@min"/>
							<xsl:with-param name="maxval" select="@max"/>
							<xsl:with-param name="required" select="@required"/>
						</xsl:call-template>
					</xsl:for-each>
				</xsl:for-each>
			</xsl:if>

			<xsl:call-template name="VBFieldEdit">
				<xsl:with-param name="indent">1</xsl:with-param>
				<xsl:with-param name="assignto">bvUserID</xsl:with-param>
				<xsl:with-param name="name">bvUserID</xsl:with-param>
				<xsl:with-param name="label">User ID</xsl:with-param>
				<xsl:with-param name="type">number</xsl:with-param>
				<xsl:with-param name="required" select="true()"/>
				<xsl:with-param name="minval">1</xsl:with-param>
			</xsl:call-template>
			<xsl:value-of select="$cr"/>

			<!--==========SET ADO PARAMETERS==========-->

			<xsl:call-template name="VBComment">
				<xsl:with-param name="indent">1</xsl:with-param>
				<xsl:with-param name="value">populate the parameters for the procedure call</xsl:with-param>
			</xsl:call-template>

			<xsl:value-of select="concat($tab1, 'With oCmd', $cr)"/>

			<xsl:if test="($ischild)">
				<xsl:for-each select="($parentfields)">
					<xsl:variable name="aname" select="@name"/>
					<xsl:for-each select = "/Data/WTENTITY/WTATTRIBUTE[@name=$aname]">
						<xsl:call-template name="VBADOSetParam">
							<xsl:with-param name="indent">2</xsl:with-param>
							<xsl:with-param name="name" select="@name"/>
							<xsl:with-param name="type" select="@type"/>
							<xsl:with-param name="value" select="concat('bv', @name)"/>
						</xsl:call-template>
					</xsl:for-each>
				</xsl:for-each>
			</xsl:if>

			<xsl:call-template name="VBADOSetParam">
				<xsl:with-param name="indent">2</xsl:with-param>
				<xsl:with-param name="name">UserID</xsl:with-param>
				<xsl:with-param name="value">bvUserID</xsl:with-param>
				<xsl:with-param name="type">number</xsl:with-param>
			</xsl:call-template>

			<xsl:value-of select="concat($tab1, 'End With', $cr, $cr)"/>

			<!--==========EXECUTE COMMAND==========-->

			<xsl:call-template name="VBRunSP">
				<xsl:with-param name="name">Purge</xsl:with-param>
				<xsl:with-param name="indent">1</xsl:with-param>
			</xsl:call-template>
			<xsl:value-of select="$cr"/>

			<xsl:call-template name="VBMethodEnd">
				<xsl:with-param name="type">Sub</xsl:with-param>
			</xsl:call-template>
		</xsl:if>
   
		<!--==================================================================-->
		<!-- METHOD: UPDATE -->
		<!--==================================================================-->
		<xsl:if test="WTPROCEDURES/WTPROCEDURE[@type='Update' and not(@passthru='new')]">
			<xsl:value-of select="$cr"/>
			<xsl:call-template name="VBMethodStart">
				<xsl:with-param name="type">Sub</xsl:with-param>
				<xsl:with-param name="name">Update</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="VBParam">
				<xsl:with-param name="name">Rec</xsl:with-param>
				<xsl:with-param name="type">record</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="VBParam">
				<xsl:with-param name="name">UserID</xsl:with-param>
				<xsl:with-param name="type">number</xsl:with-param>
				<xsl:with-param name="continue" select="false()"/>
			</xsl:call-template>
			<xsl:value-of select="concat(')', $cr)"/>

			<xsl:call-template name="VBFunctionBox">
				<xsl:with-param name="name">Update</xsl:with-param>
				<xsl:with-param name="desc">Updates the record.</xsl:with-param>
			</xsl:call-template>
			<xsl:value-of select="$cr"/>

			<xsl:call-template name="VBStartErrorHandler"/>
			<xsl:call-template name="VBMTSContext"/>

			<!--==========EDIT INPUT PARAMETERS==========-->

			<xsl:call-template name="VBComment">
				<xsl:with-param name="indent">1</xsl:with-param>
				<xsl:with-param name="value">edit the input parameters</xsl:with-param>
			</xsl:call-template>

			<xsl:value-of select="concat($tab1, 'Validate brRec, bvUserID', $cr, $cr)"/>

			<!--==========SET ADO PARAMETERS==========-->

			<xsl:call-template name="VBComment">
				<xsl:with-param name="indent">1</xsl:with-param>
				<xsl:with-param name="value">populate the parameters for the procedure call</xsl:with-param>
			</xsl:call-template>

			<xsl:value-of select="concat($tab1, 'With oCmd', $cr)"/>

			<xsl:for-each select="WTATTRIBUTE[@passthru or (@source='entity' and not(WTCOMPUTE) and not(@persist))]">
<!--			<xsl:for-each select="WTATTRIBUTE[@source='entity' and not(WTCOMPUTE) and not(@persist)]">-->

					<xsl:variable name="dir">
					<xsl:choose>
						<xsl:when test="WTUPDATE">output</xsl:when>
						<xsl:otherwise>input</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>

				<xsl:call-template name="VBADOSetParam">
					<xsl:with-param name="indent">2</xsl:with-param>
					<xsl:with-param name="name" select="@name"/>
					<xsl:with-param name="value" select="concat('brRec.', @name)"/>
					<xsl:with-param name="direction" select="$dir"/>
					<xsl:with-param name="type" select="@type"/>
					<xsl:with-param name="length" select="@length"/>
					<xsl:with-param name="precision" select="@precision"/>
				</xsl:call-template>
			</xsl:for-each>

			<xsl:call-template name="VBADOSetParam">
				<xsl:with-param name="indent">2</xsl:with-param>
				<xsl:with-param name="name">UserID</xsl:with-param>
				<xsl:with-param name="value">bvUserID</xsl:with-param>
				<xsl:with-param name="type">number</xsl:with-param>
			</xsl:call-template>

			<xsl:value-of select="concat($tab1, 'End With', $cr, $cr)"/>

			<!--==========EXECUTE COMMAND==========-->

			<xsl:call-template name="VBRunSP">
				<xsl:with-param name="name">Update</xsl:with-param>
				<xsl:with-param name="indent">1</xsl:with-param>
			</xsl:call-template>
			<xsl:value-of select="$cr"/>

			<xsl:if test="count(WTATTRIBUTE[WTUPDATE]) > 0">		
				<xsl:call-template name="VBComment">
					<xsl:with-param name="indent">1</xsl:with-param>
					<xsl:with-param name="value">get return values</xsl:with-param>
				</xsl:call-template>
				<xsl:value-of select="concat($tab1, 'With brRec', $cr)"/>
				<xsl:for-each select="WTATTRIBUTE[WTUPDATE]">
					<xsl:call-template name="VBADOGetParam">
						<xsl:with-param name="indent">2</xsl:with-param>
						<xsl:with-param name="name" select="@name"/>
						<xsl:with-param name="type" select="@type"/>
						<xsl:with-param name="assignto" select="concat('.', @name)"/>
					</xsl:call-template>
				</xsl:for-each>
				<xsl:value-of select="concat($tab1, 'End With', $cr, $cr)"/>
			</xsl:if>		

			<xsl:call-template name="VBMethodEnd">
				<xsl:with-param name="type">Sub</xsl:with-param>
			</xsl:call-template>
		 </xsl:if>

		<!--==================================================================-->
		<!-- METHOD: UPDATE (CUSTOM)                                          -->
		<!--==================================================================-->
		<xsl:for-each select="WTPROCEDURES/WTPROCEDURE[(@type='Update') and (@template='new') and (@passthru='true')]">

		  <xsl:value-of select="$cr"/>
		  <xsl:call-template name="VBMethodStart">
		  	<xsl:with-param name="type">Sub</xsl:with-param>
		  	<xsl:with-param name="name" select="@name"/>
		  </xsl:call-template>
		  <xsl:call-template name="VBParam">
		  	<xsl:with-param name="name">Rec</xsl:with-param>
		  	<xsl:with-param name="type">record</xsl:with-param>
		  </xsl:call-template>
		  <xsl:call-template name="VBParam">
		  	<xsl:with-param name="name">UserID</xsl:with-param>
		  	<xsl:with-param name="type">number</xsl:with-param>
		  	<xsl:with-param name="continue" select="false()"/>
		  </xsl:call-template>
		  <xsl:value-of select="concat(')', $cr)"/>

		  <xsl:call-template name="VBFunctionBox">
		  	<xsl:with-param name="name" select="@name"/>
		  	<xsl:with-param name="desc">Updates the record.</xsl:with-param>
		  </xsl:call-template>
		  <xsl:value-of select="$cr"/>

		  <xsl:call-template name="VBStartErrorHandler"/>
		  <xsl:call-template name="VBMTSContext"/>

		  <!--==========EDIT INPUT PARAMETERS==========-->

		  <xsl:call-template name="VBComment">
		  	<xsl:with-param name="indent">1</xsl:with-param>
		  	<xsl:with-param name="value">edit the input parameters</xsl:with-param>
		  </xsl:call-template>

		  <xsl:if test="not(@novalidate or @noedit)">
	 	  	<xsl:value-of select="concat($tab1, 'Validate brRec, bvUserID', $cr, $cr)"/>
		  </xsl:if>

		  <!--==========SET ADO PARAMETERS==========-->

		  <xsl:call-template name="VBComment">
		  	<xsl:with-param name="indent">1</xsl:with-param>
		  	<xsl:with-param name="value">populate the parameters for the procedure call</xsl:with-param>
		  </xsl:call-template>

		  <xsl:value-of select="concat($tab1, 'With oCmd', $cr)"/>

		  <xsl:for-each select="/Data/WTENTITY/WTATTRIBUTE[(@source='entity' or @source='inherit') and not(WTCOMPUTE) and (not(@persist) or @passthru)]">
		  	<xsl:variable name="dir">
		  		<xsl:choose>
		  			<xsl:when test="WTUPDATE"><xsl:text>output</xsl:text></xsl:when>
		  			<xsl:otherwise><xsl:text>input</xsl:text></xsl:otherwise>
		  		</xsl:choose>
		  	</xsl:variable>

		  	<xsl:call-template name="VBADOSetParam">
		  		<xsl:with-param name="indent">2</xsl:with-param>
		  		<xsl:with-param name="name" select="@name"/>
		  		<xsl:with-param name="value" select="concat('brRec.', @name)"/>
		  		<xsl:with-param name="direction" select="$dir"/>
		  		<xsl:with-param name="type" select="@type"/>
		  		<xsl:with-param name="length" select="@length"/>
		  		<xsl:with-param name="precision" select="@precision"/>
		  	</xsl:call-template>
		  </xsl:for-each>

		  <xsl:call-template name="VBADOSetParam">
		  	<xsl:with-param name="indent">2</xsl:with-param>
		  	<xsl:with-param name="name">UserID</xsl:with-param>
		  	<xsl:with-param name="value">bvUserID</xsl:with-param>
		  	<xsl:with-param name="type">number</xsl:with-param>
		  </xsl:call-template>

		  <xsl:value-of select="concat($tab1, 'End With', $cr, $cr)"/>

		  <!--==========EXECUTE COMMAND==========-->

		  <xsl:call-template name="VBRunSP">
		  	<xsl:with-param name="name" select="@name"/>
		  	<xsl:with-param name="indent">1</xsl:with-param>
		  </xsl:call-template>
		  <xsl:value-of select="$cr"/>

		  <xsl:if test="count(/Data/WTENTITY/WTATTRIBUTE[WTUPDATE]) > 0">		
		  	<xsl:call-template name="VBComment">
		  		<xsl:with-param name="indent">1</xsl:with-param>
		  		<xsl:with-param name="value">get return values</xsl:with-param>
		  	</xsl:call-template>
		  	<xsl:value-of select="concat($tab1, 'With brRec', $cr)"/>
		  	<xsl:for-each select="/Data/WTENTITY/WTATTRIBUTE[WTUPDATE]">
		  		<xsl:call-template name="VBADOGetParam">
		  			<xsl:with-param name="indent">2</xsl:with-param>
		  			<xsl:with-param name="name" select="@name"/>
		  			<xsl:with-param name="type" select="@type"/>
		  			<xsl:with-param name="assignto" select="concat('.', @name)"/>
		  		</xsl:call-template>
		  	</xsl:for-each>
		  	<xsl:value-of select="concat($tab1, 'End With', $cr, $cr)"/>
		  </xsl:if>		

		  <xsl:call-template name="VBMethodEnd">
		  	<xsl:with-param name="type">Sub</xsl:with-param>
		  </xsl:call-template>

		</xsl:for-each>

		<!--==================================================================-->
		<!-- METHOD: VALIDATE -->
		<!--==================================================================-->
		<xsl:value-of select="$cr"/>
		<xsl:call-template name="VBMethodStart">
			<xsl:with-param name="type">Sub</xsl:with-param>
			<xsl:with-param name="name">Validate</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="VBParam">
			<xsl:with-param name="name">Rec</xsl:with-param>
			<xsl:with-param name="type">record</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="VBParam">
			<xsl:with-param name="name">UserID</xsl:with-param>
			<xsl:with-param name="type">number</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="VBParam">
			<xsl:with-param name="name">New</xsl:with-param>
			<xsl:with-param name="type">yesno</xsl:with-param>
			<xsl:with-param name="optional" select="true()"/>
			<xsl:with-param name="default">0</xsl:with-param>
			<xsl:with-param name="continue" select="false()"/>
		</xsl:call-template>
		<xsl:value-of select="concat(')', $cr)"/>

		<xsl:call-template name="VBFunctionBox">
			<xsl:with-param name="name">Validate</xsl:with-param>
			<xsl:with-param name="desc">Validates the record.</xsl:with-param>
			<xsl:with-param name="ismts" select="false()"/>
			<xsl:with-param name="isado" select="false()"/>
		</xsl:call-template>
		<xsl:value-of select="$cr"/>

		<xsl:call-template name="VBStartErrorHandler"/>

		<!--==========EDIT INPUT PARAMETERS==========-->

		<xsl:call-template name="VBComment">
			<xsl:with-param name="indent">1</xsl:with-param>
			<xsl:with-param name="value">edit the input parameters</xsl:with-param>
		</xsl:call-template>

		<xsl:value-of select="concat($tab1, 'With brRec', $cr)"/>

		<xsl:for-each select="WTATTRIBUTE[(@source='entity' or @source='inherit') and not(WTCOMPUTE) and not(@persist) and not(WTUPDATE)]">

			<!--generate IF statement for conditions if they exist-->
			<xsl:if test="WTVALIDATE/WTCONDITION">
				<xsl:call-template name="VBConditionStart">
					<xsl:with-param name="indent" select="2"/>
					<xsl:with-param name="conditions" select="WTVALIDATE/WTCONDITION"/>
				</xsl:call-template>
			</xsl:if>

			<xsl:if test="@identity">
				<xsl:value-of select="concat($tab2, 'If bvNew = 0 Then', $cr)"/>
			</xsl:if>
			<xsl:variable name="indent">
				<xsl:choose>
					<xsl:when test="@identity">3</xsl:when>
					<xsl:otherwise>2</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			
			<xsl:choose>
        <!--==========handle boolean parameters differently since we treat them as integers==========-->
        <xsl:when test="@type='yesno'">
          <xsl:call-template name="VBFieldEdit">
            <xsl:with-param name="indent" select="$indent"/>
            <xsl:with-param name="assignto" select="concat('.', @name)"/>
            <xsl:with-param name="name" select="concat('.', @name)"/>
            <xsl:with-param name="label" select="@name"/>
            <xsl:with-param name="type" select="@type"/>
            <xsl:with-param name="default">0</xsl:with-param>
            <xsl:with-param name="minval">0</xsl:with-param>
            <xsl:with-param name="maxval">1</xsl:with-param>
            <xsl:with-param name="required" select="false()"/>
          </xsl:call-template>
        </xsl:when>
        <!--==========handle big number parameters differently since we treat them as strings ==========-->
        <xsl:when test="@type='big number'">
          <xsl:call-template name="VBFieldEdit">
            <xsl:with-param name="indent" select="$indent"/>
            <xsl:with-param name="assignto" select="concat('.', @name)"/>
            <xsl:with-param name="name" select="concat('.', @name)"/>
            <xsl:with-param name="label" select="@name"/>
            <xsl:with-param name="type" select="@type"/>
            <xsl:with-param name="default">0</xsl:with-param>
            <xsl:with-param name="minval"></xsl:with-param>
            <xsl:with-param name="maxval"></xsl:with-param>
            <xsl:with-param name="required" select="false()"/>
          </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>
					<xsl:variable name="req">
						<xsl:if test="@required or WTVALIDATE/@required">true</xsl:if>
					</xsl:variable>
					<xsl:variable name="min">
						<xsl:choose>
							<xsl:when test="WTVALIDATE/@min"><xsl:value-of select="WTVALIDATE/@min"/></xsl:when>
							<xsl:when test="@min"><xsl:value-of select="@min"/></xsl:when>
						</xsl:choose>
					</xsl:variable>
					<xsl:variable name="max">
						<xsl:choose>
							<xsl:when test="WTVALIDATE/@max"><xsl:value-of select="WTVALIDATE/@max"/></xsl:when>
							<xsl:when test="@max"><xsl:value-of select="@max"/></xsl:when>
						</xsl:choose>
					</xsl:variable>
					<xsl:call-template name="VBFieldEdit">
						<xsl:with-param name="indent" select="$indent"/>
						<xsl:with-param name="assignto" select="concat('.', @name)"/>
						<xsl:with-param name="name" select="concat('.', @name)"/>
						<xsl:with-param name="label" select="@name"/>
						<xsl:with-param name="type" select="@type"/>
						<xsl:with-param name="default" select="@default"/>
						<xsl:with-param name="minval" select="$min"/>
						<xsl:with-param name="maxval" select="$max"/>
						<xsl:with-param name="required" select="$req"/>
					</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:if test="@identity">
				<xsl:value-of select="concat($tab2, 'End If', $cr)"/>
			</xsl:if>
			
			<!--close IF statement for conditions if they exist-->
			<xsl:if test="WTVALIDATE/WTCONDITION">
				<xsl:call-template name="VBConditionEnd">
					<xsl:with-param name="indent" select="2"/>
				</xsl:call-template>
			</xsl:if> 
			
		</xsl:for-each>

		<xsl:call-template name="VBFieldEdit">
			<xsl:with-param name="indent">2</xsl:with-param>
			<xsl:with-param name="assignto">bvUserID</xsl:with-param>
			<xsl:with-param name="name">bvUserID</xsl:with-param>
			<xsl:with-param name="label">User ID</xsl:with-param>
			<xsl:with-param name="type">number</xsl:with-param>
			<xsl:with-param name="required" select="true()"/>
			<xsl:with-param name="minval">1</xsl:with-param>
		</xsl:call-template>

		<xsl:value-of select="concat($tab1, 'End With', $cr, $cr)"/>

		<xsl:call-template name="VBMethodEnd">
			<xsl:with-param name="type">Sub</xsl:with-param>
			<xsl:with-param name="isado" select="false()"/>
			<xsl:with-param name="ismts" select="false()"/>
		</xsl:call-template>

		<!--==================================================================-->
		<!-- METHOD: CLASS INITIALIZE -->
		<!--==================================================================-->
		<xsl:value-of select="$cr"/>
		<xsl:call-template name="VBMethodStart">
			<xsl:with-param name="type">Sub</xsl:with-param>
			<xsl:with-param name="name">Class_Initialize</xsl:with-param>
			<xsl:with-param name="scope">Private</xsl:with-param>
			<xsl:with-param name="noparams" select="true()"/>
		</xsl:call-template>
		<xsl:value-of select="concat($tab0, $cr, $tab1, 'Set moSys = New wtSystem.CSystem', $cr, $tab1, 'Set moUtil = New wtSystem.CUtility', $cr, 'End Sub', $cr)"/>

		<!--==================================================================-->
		<!-- METHOD: CLASS TERMINATE -->
		<!--==================================================================-->
		<xsl:value-of select="$cr"/>
		<xsl:call-template name="VBMethodStart">
			<xsl:with-param name="type">Sub</xsl:with-param>
			<xsl:with-param name="name">Class_Terminate</xsl:with-param>
			<xsl:with-param name="scope">Private</xsl:with-param>
			<xsl:with-param name="noparams" select="true()"/>
		</xsl:call-template>
		<xsl:value-of select="concat($tab0, $cr, $tab1, 'Set moSys = Nothing', $cr, $tab1, 'Set moUtil = Nothing', $cr, 'End Sub', $cr)"/>

	</xsl:template>
	
</xsl:stylesheet>

