<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:include href="GenerateIncludeSQL.xsl"/>
<!--===============================================================================
	Auth: Bob Wood
	Date: January 2008
	Desc: Transforms an ILingual Entity Definition to a SQL Update stored procedure script 
	Copyright 2008 WinTech, Inc.
===================================================================================-->
	<xsl:template match="/">
		<SQL><xsl:apply-templates/></SQL>
	</xsl:template>

	<xsl:template match="WTENTITY">
		<xsl:choose>
			<xsl:when test="(/Data/WTENTITY/WTPROCEDURE/@template='new')">
				<xsl:apply-templates select="/Data/WTENTITY/WTPROCEDURE">
					<xsl:with-param name="indent">0</xsl:with-param>
				</xsl:apply-templates>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="OldTemplate"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="OldTemplate">

		<xsl:call-template name="CheckProc"/>
		<xsl:call-template name="CreateProc"/>

		<!--specifies the type of procedure to create-->
		<xsl:variable name="proctype" select ="/Data/WTENTITY/WTPROCEDURE/@type"/>

		<!--====================PARAMETERS====================-->
		<!--add parameters for bookmark-->
		<xsl:if test="$hasbookmark">
			<xsl:for-each select="/Data/WTENTITY/WTATTRIBUTE[@name=/Data/WTENTITY/WTPROCEDURE/WTBOOKMARK/@name]">
				<xsl:variable name="searchlength">
					<xsl:choose>
						<xsl:when test="(@type='date')">20</xsl:when>
            <xsl:when test="(@type='number')">10</xsl:when>
            <xsl:when test="(@type='big number')">20</xsl:when>
            <xsl:when test="(@type='currency')">20</xsl:when>
						<xsl:otherwise><xsl:value-of select="@length"/></xsl:otherwise>
					</xsl:choose>
				</xsl:variable>

				<xsl:variable name="orderlength">
					<xsl:choose>
						<xsl:when test="Data/WTENTITY/WTPROCEDURE/WTBOOKMARK/@length"><xsl:value-of select="Data/WTENTITY/WTPROCEDURE/WTBOOKMARK/@length"/></xsl:when>
						<xsl:otherwise>0</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>

				<xsl:variable name="bookmarklength">
					<xsl:choose>
						<xsl:when test="(@type='date')"><xsl:value-of select="$searchlength + $orderlength"/></xsl:when>
						<xsl:otherwise><xsl:value-of select="$searchlength + 10 + $orderlength"/></xsl:otherwise>
					</xsl:choose>
				</xsl:variable>

				<xsl:call-template name="SQLParam">
					<xsl:with-param name="name">CONST(SearchText)</xsl:with-param>
					<xsl:with-param name="type">text</xsl:with-param>
					<xsl:with-param name="length" select="$searchlength"/>
				</xsl:call-template>

				<xsl:call-template name="SQLParam">
					<xsl:with-param name="name">CONST(Bookmark)</xsl:with-param>
					<xsl:with-param name="type">text</xsl:with-param>
					<xsl:with-param name="length" select="$bookmarklength"/>
				</xsl:call-template>

				<xsl:call-template name="SQLParam">
					<xsl:with-param name="name">CONST(MaxRows)</xsl:with-param>
					<xsl:with-param name="type">tiny number</xsl:with-param>
					<xsl:with-param name="inout">output</xsl:with-param>
				</xsl:call-template>
			</xsl:for-each>
		</xsl:if>

		<xsl:if test="$hassearch">
			<xsl:variable name="attribute" select="/Data/WTENTITY/WTATTRIBUTE[@name=/Data/WTENTITY/WTPROCEDURE/WTSEARCH/@name]"/>
			<xsl:variable name="searchlength">
				<xsl:choose>
					<xsl:when test="($attribute/@type='date')">20</xsl:when>
					<xsl:when test="($attribute/@type='number')">10</xsl:when>
					<xsl:when test="($attribute/@type='currency')">20</xsl:when>
					<xsl:otherwise><xsl:value-of select="$attribute/@length"/></xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			<xsl:call-template name="SQLParam">
				<xsl:with-param name="name">CONST(SearchText)</xsl:with-param>
				<xsl:with-param name="type">text</xsl:with-param>
				<xsl:with-param name="length" select="$searchlength"/>
			</xsl:call-template>
		</xsl:if>

		<!--add each appropriate attribute as in input or ouput if applicable-->
		<!--call SQLParamDirection to determine if it's an input (IN), output (OUT) or not a parameter (NONE)-->

		<xsl:choose>
			<xsl:when test="$hasprocparams">
				<xsl:for-each select="$procparams">
					<xsl:call-template name="SQLParam">
						<xsl:with-param name="parameter" select="."/>
						<xsl:with-param name="continue" select="(position() != last())"/>
					</xsl:call-template>
				</xsl:for-each>
			</xsl:when>
			
			<xsl:when test="$proctype='Copy'">
				<xsl:call-template name="SQLParam">
					<xsl:with-param name="name" select="$identity"/>
					<xsl:with-param name="type">number</xsl:with-param>
					<xsl:with-param name="inout" select="'output'"/>
					<xsl:with-param name="continue" select="true()"/>
				</xsl:call-template>
				<xsl:call-template name="SQLParam">
					<xsl:with-param name="name" select="concat('Copy', $identity)"/>
					<xsl:with-param name="type">number</xsl:with-param>
					<xsl:with-param name="continue" select="true()"/>
				</xsl:call-template>
				<xsl:call-template name="SQLParam">
					<xsl:with-param name="name">SYS(userid)</xsl:with-param>
					<xsl:with-param name="type">number</xsl:with-param>
					<xsl:with-param name="continue" select="false()"/>
				</xsl:call-template>
			</xsl:when>
			
			<xsl:otherwise>		
				<xsl:for-each select="/Data/WTENTITY/WTATTRIBUTE[not(@persist)]">
					<xsl:variable name="dir">
						<xsl:call-template name="SQLParamDirection">
							<xsl:with-param name="name" select="@name"/>
							<xsl:with-param name="proctype" select="$proctype"/>
						</xsl:call-template>
					</xsl:variable>

					<xsl:choose>
						<xsl:when test="($dir='IN')">
							<xsl:call-template name="SQLParam">
								<xsl:with-param name="name" select="concat('ATTR(', @name, ')')"/>
								<xsl:with-param name="type" select="@type"/>
								<xsl:with-param name="length" select="@length"/>
							</xsl:call-template>
						</xsl:when>
						<xsl:when test="($dir='OUT')">
							<xsl:call-template name="SQLParam">
								<xsl:with-param name="name" select="concat('ATTR(', @name, ')')"/>
								<xsl:with-param name="type" select="@type"/>
								<xsl:with-param name="length" select="@length"/>
								<xsl:with-param name="inout" select="('output')"/>
							</xsl:call-template>
						</xsl:when>
					</xsl:choose>
				</xsl:for-each>
				<!--always add UserID-->
				<xsl:call-template name="SQLParam">
					<xsl:with-param name="name">SYS(userid)</xsl:with-param>
					<xsl:with-param name="type">number</xsl:with-param>
					<xsl:with-param name="continue" select="false()"/>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>

		<!--====================START PROCEDURE DECLARATION====================-->
		<xsl:value-of select="concat($tab0, $cr, $tab2, ')', $cr, 'AS', $cr, $cr)"/>

		<!--====================DECLARES====================-->
		<!--declare variable for audit date fields-->
		<!--NOTE Should declare CreateDate and ChangeDate as WTATTRIBUTES--> 
		<!--NOTE Then (for Add) if any attribute has WTINIT type=system value=sysdate --> 
		<!--NOTE Then (for Update) if any attribute has WTUPDATE type=system value=sysdate --> 
		<xsl:if test="($proctype='Add') or ($proctype='Update') or ($proctype='Init') or ($proctype='Copy')">
			<xsl:call-template name="SQLDeclare">
				<xsl:with-param name="name">@mNow</xsl:with-param>
				<xsl:with-param name="type">date</xsl:with-param>
			</xsl:call-template>
		</xsl:if>

		<!--declare variable for new identity-->
		<xsl:if test="(($proctype='Add') or ($proctype='Copy')) and (WTATTRIBUTE[@identity='true'])">
			<xsl:call-template name="SQLDeclare">
				<xsl:with-param name="name">@mNewID</xsl:with-param>
				<xsl:with-param name="type">number</xsl:with-param>
			</xsl:call-template>
		</xsl:if>

		<!--declare variable for return value on count-->
		<!--NOTE Should declare WTPARAM name=Count type=Return to procedure--> 
		<!--NOTE Then (for any Return Parameters --> 
		<xsl:if test="($proctype='Count')">
			<xsl:call-template name="SQLDeclare">
				<xsl:with-param name="name">@mCount</xsl:with-param>
				<xsl:with-param name="type">number</xsl:with-param>
			</xsl:call-template>
		</xsl:if>

		<!--declare variable for initialized attributes on add-->
		<xsl:if test="($proctype='Add')">
			<xsl:for-each select="WTATTRIBUTE[WTINIT[(@type !='attribute') and (@type !='template')]]">
				<xsl:call-template name="SQLDeclare">
					<xsl:with-param name="name" select="concat('@m', @name)"/>
					<xsl:with-param name="type" select="@type"/>
					<xsl:with-param name="length" select="@length"/>
				</xsl:call-template>
			</xsl:for-each>
		</xsl:if>

		<!--declare variable for initialized attributes on init-->
		<xsl:if test="($proctype='Init')">
			<xsl:for-each select="WTATTRIBUTE[WTINIT[(@type !='attribute') and (@type !='template') and not(@template)]]">
				<xsl:call-template name="SQLDeclare">
					<xsl:with-param name="name" select="concat('@m', @name)"/>
					<xsl:with-param name="type" select="@type"/>
					<xsl:with-param name="length" select="@length"/>
				</xsl:call-template>
			</xsl:for-each>
		</xsl:if>

		<!--declare variable for computed fields on update-->
		<xsl:if test="($proctype='Update')">
			<xsl:for-each select="WTATTRIBUTE[WTUPDATE]">
				<xsl:call-template name="SQLDeclare">
					<xsl:with-param name="name" select="concat('@m', @name)"/>
					<xsl:with-param name="type" select="@type"/>
					<xsl:with-param name="length" select="@length"/>
				</xsl:call-template>
			</xsl:for-each>
		</xsl:if>
		<xsl:value-of select="$cr"/>

		<!--====================SET PROCEDURE OPTIONS====================-->
		<xsl:value-of select="concat('SET NOCOUNT ON', $cr, $cr)"/>

		<!--====================SET VARIABLES====================-->
		<!--set timestamp for audit date fields-->
		<!--NOTE Should declare CreateDate and ChangeDate as WTATTRIBUTES--> 
		<!--NOTE Then (for Add) if any attribute has WTINIT type=system value=sysdate --> 
		<!--NOTE Then (for Update) if any attribute has WTUPDATE type=system value=sysdate --> 
		<xsl:if test="($proctype='Add') or ($proctype='Update') or ($proctype='Init') or ($proctype='Copy')">
			<xsl:call-template name="SQLSet">
				<xsl:with-param name="name">@mNow</xsl:with-param>
				<xsl:with-param name="value">GETDATE()</xsl:with-param>
			</xsl:call-template>
		</xsl:if>

		<!--set timestamp for all column initialized to sysdate-->
		<xsl:if test="($proctype='Add') or ($proctype='Init')">
			<xsl:for-each select="WTATTRIBUTE[WTINIT[@type='system' and @value='sysdate']]">
				<xsl:call-template name="SQLSet">
					<xsl:with-param name="name" select="concat('@m', @name)"/>
				<xsl:with-param name="value">GETDATE()</xsl:with-param>
				</xsl:call-template>
			</xsl:for-each>
		</xsl:if>

		<!--set values for all initialized constants-->
		<xsl:if test="($proctype='Add')">
			<xsl:for-each select="WTATTRIBUTE[WTINIT[@type='constant']]">
				<xsl:call-template name="SQLSet">
					<xsl:with-param name="name" select="concat('@m', @name)"/>
					<xsl:with-param name="value" select="WTINIT/@value"/>
					<xsl:with-param name="datatype" select="@type"/>
				</xsl:call-template>
			</xsl:for-each>
		</xsl:if>
		<xsl:if test="($proctype='Init')">
			<xsl:for-each select="WTATTRIBUTE[WTINIT[@type='constant' and not(@template)]]">
				<xsl:call-template name="SQLSet">
					<xsl:with-param name="name" select="concat('@m', @name)"/>
					<xsl:with-param name="value" select="WTINIT/@value"/>
					<xsl:with-param name="datatype" select="@type"/>
				</xsl:call-template>
			</xsl:for-each>
		</xsl:if>

		<!--set values for all initialized sysidentity columns-->
		<xsl:if test="($proctype='Add') or ($proctype='Init')">
			<xsl:for-each select="WTATTRIBUTE[WTINIT[@type='system' and @value='sysidentity']]">
				<xsl:call-template name="SQLSet">
					<xsl:with-param name="name" select="concat('@m', @name)"/>
					<xsl:with-param name="value">0</xsl:with-param>
					<xsl:with-param name="datatype" select="@type"/>
				</xsl:call-template>
			</xsl:for-each>
		</xsl:if>

		<!-- set the number of rows for the bookmark -->
		<xsl:variable name="bookmarkrows">
			<xsl:choose>
				<xsl:when test="/Data/WTENTITY/WTPROCEDURE/WTBOOKMARK/@rows">
					<xsl:value-of select="/Data/WTENTITY/WTPROCEDURE/WTBOOKMARK/@rows"/>
				</xsl:when>
				<xsl:otherwise>20</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<!--set max rows and handle date field searching for bookmarks-->
		<xsl:if test="($hasbookmark)">
			<xsl:call-template name="SQLSet">
				<xsl:with-param name="name">@MaxRows</xsl:with-param>
				<xsl:with-param name="value" select="$bookmarkrows"/>
			</xsl:call-template>

			<xsl:variable name="col" select="/Data/WTENTITY/WTPROCEDURE/WTBOOKMARK/@name"/>
			<xsl:variable name="attr" select="/Data/WTENTITY/WTATTRIBUTE[@name=$col]"/>
			<xsl:if test="($attr/@type='date')">
				<xsl:value-of select="concat($tab0, 'IF (@Bookmark = ', $apos, $apos, ') SET @Bookmark = ', $apos, '99991231', $apos, $cr)"/>
				<xsl:value-of select="concat($tab0, 'IF (ISDATE(@SearchText) = 1)', $cr)"/>
				<xsl:value-of select="concat($tab4, 'SET @SearchText = CONVERT(nvarchar(10), CONVERT(datetime, @SearchText), 112)', $cr)"/>
				<xsl:value-of select="concat($tab0, 'ELSE', $cr)"/>
				<xsl:value-of select="concat($tab4, 'SET @SearchText = ', $apos, $apos, $cr, $cr)"/>
			</xsl:if>
		</xsl:if>
		<xsl:if test="($hassearch)">
			<xsl:variable name="col2" select="/Data/WTENTITY/WTPROCEDURE/WTSEARCH/@name"/>
			<xsl:variable name="attr" select="/Data/WTENTITY/WTATTRIBUTE[@name=$col2]"/>
			<xsl:if test="($attr/@type='date')">
				<xsl:value-of select="concat($tab0, 'IF (ISDATE(@SearchText) = 1)', $cr)"/>
				<xsl:value-of select="concat($tab4, 'SET @SearchText = CONVERT(nvarchar(10), CONVERT(datetime, @SearchText), 112)', $cr)"/>
				<xsl:value-of select="concat($tab0, 'ELSE', $cr)"/>
				<xsl:value-of select="concat($tab4, 'SET @SearchText = ', $apos, $apos, $cr, $cr)"/>
			</xsl:if>
		</xsl:if>

		<!--call any 'before' procedures for remaining initializations-->
		<xsl:for-each select="/Data/WTENTITY/WTPROCEDURE/WTPROCEDURE[@position='before']">
			<xsl:call-template name="SQLNestedProc">
				<xsl:with-param name="name" select="@name"/>
				<xsl:with-param name="indent">0</xsl:with-param>
			</xsl:call-template>
			<xsl:value-of select="$cr"/>
		</xsl:for-each>

		<!--==================== SQL LOGIC ====================-->
		<xsl:if test="$proctype='Add'">
			<xsl:value-of select="$cr"/>
			<xsl:for-each select="/Data/WTENTITY/WTATTRIBUTE[@seq]">

				<xsl:value-of select="concat($tab0, 'IF @', @name, '=0', $cr)"/>
				<xsl:value-of select="concat($tab0, 'BEGIN', $cr)"/>
				<xsl:value-of select="concat($tab1, 'SELECT @', @name, ' = ISNULL(MAX(', @name, '),0)' $cr)"/>
				<xsl:value-of select="concat($tab1, 'FROM ', $SQLentityname, ' (NOLOCK)' $cr)"/>
				<xsl:for-each select="/Data/WTENTITY/WTATTRIBUTE[@parent]">
					<xsl:if test="position()=1">
						<xsl:value-of select="concat($tab1, 'WHERE ', @name, ' = @', @name $cr)"/>
					</xsl:if>
					<xsl:if test="position()>1">
						<xsl:value-of select="concat($tab1, 'AND ', @name, ' = @', @name $cr)"/>
					</xsl:if>
				</xsl:for-each>
				<xsl:value-of select="concat($tab1, 'SET @', @name, ' = @', @name, ' + ', @seq $cr)"/>
				<xsl:value-of select="concat($tab0, 'END', $cr)"/>
			</xsl:for-each>
		</xsl:if>

		<!--====================SQL STATEMENT====================-->
		<xsl:value-of select="$cr"/>
		<xsl:choose>
			<xsl:when test="($proctype='Add') or ($proctype='Init') or ($proctype='Copy')"><xsl:value-of select="concat($tab0, 'INSERT INTO ', $SQLentityname, ' (', $cr)"/></xsl:when>
			<xsl:when test="($proctype='Delete') or ($proctype='DeleteChild')"><xsl:value-of select="concat($tab0, 'DELETE ', $entityalias, $cr)"/></xsl:when>
			<xsl:when test="($proctype='Update')"><xsl:value-of select="concat($tab0, 'UPDATE ', $entityalias, $cr)"/></xsl:when>
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="($hasbookmark)"><xsl:value-of select="concat($tab0, 'SELECT ', 'TOP ', $bookmarkrows + 1, $cr)"/></xsl:when>
					<xsl:otherwise><xsl:value-of select="concat($tab0, 'SELECT')"/></xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>

		<!--====================COLUMNS====================-->
		<!--bookmark column-->
		<xsl:if test="($hasbookmark)">
			<xsl:value-of select="$tab4"/>
			<xsl:call-template name="SQLColumnBookmark">
				<xsl:with-param name="name" select="/Data/WTENTITY/WTPROCEDURE/WTBOOKMARK/@name"/>
				<xsl:with-param name="order" select="/Data/WTENTITY/WTPROCEDURE/WTBOOKMARK/@order"/>
				<xsl:with-param name="proctype" select="$proctype"/>
				<xsl:with-param name="columnalias" select="true()"/>
			</xsl:call-template>
			<xsl:value-of select="concat(' ,', $cr)"/>
		</xsl:if>

		<xsl:choose>
			<xsl:when test="($proctype='Add') or ($proctype='Copy')">
				<!--create the column list-->
				<xsl:for-each select="WTATTRIBUTE[@source='entity' and not(@identity) and not(WTCOMPUTE) and not(@persist)]">
					<xsl:variable name="attr">
					   <xsl:call-template name="SQLReserved"><xsl:with-param name="ReservedWord" select="@name"/></xsl:call-template>
					</xsl:variable>
					<xsl:if test="position() != last()">
						<xsl:value-of select="concat($tab4, $attr, ' , ', $cr)"/>
					</xsl:if>
					<xsl:if test="position() = last()">
						<xsl:value-of select="concat($tab4, $attr)"/>
					</xsl:if>
				</xsl:for-each>
				
				<xsl:if test="not(@audit='true')">
					<xsl:value-of select="$cr"/>
				</xsl:if>
				<xsl:if test="@audit='true'">
					<xsl:value-of select="concat(' , ',$cr)"/>
					<xsl:value-of select="concat($tab4, 'CreateDate , ', $cr)"/>
					<xsl:value-of select="concat($tab4, 'CreateID , ', $cr)"/>
					<xsl:value-of select="concat($tab4, 'ChangeDate , ', $cr)"/>
					<xsl:value-of select="concat($tab4, 'ChangeID', $cr)"/>
				</xsl:if>
				<xsl:value-of select="concat($tab4, ')', $cr)"/>

				<!--create the values list-->
				<xsl:choose>
					<xsl:when test="($proctype='Copy')">
						<xsl:value-of select="concat($tab0, 'SELECT')"/>
						<xsl:for-each select="WTATTRIBUTE[@source='entity' and not(@identity) and not(WTCOMPUTE) and not(@persist)]">
							<xsl:variable name="attr">
							   <xsl:call-template name="SQLReserved"><xsl:with-param name="ReservedWord" select="@name"/></xsl:call-template>
							</xsl:variable>
						 	<xsl:if test="position() != last()">
						 		<xsl:if test="@title and @length">
		  				 		  	<xsl:value-of select="concat($tab4, $apos, 'Copy of ', $apos, ' + substring(', $entityalias, '.', $attr, ',1,', number(@length)-8, ') , ', $cr)"/>
						 		</xsl:if>
						 		<xsl:if test="not(@title and @length)">
		  				 		  	<xsl:value-of select="concat($tab4, $entityalias, '.', $attr, ' , ', $cr)"/>
						 		</xsl:if>
						 	</xsl:if>
						 	<xsl:if test="position() = last()">
						 		<xsl:if test="@title and @length">
		  				 		  	<xsl:value-of select="concat($tab4, $apos, 'Copy of ', $apos, ' + substring(', $entityalias, '.', $attr, ',1,', number(@length)-8, ')')"/>
						 		</xsl:if>
						 		<xsl:if test="not(@title and @length)">
		  				 		  	<xsl:value-of select="concat($tab4, $entityalias, '.', $attr)"/>
						 		</xsl:if>
						 	</xsl:if>
						</xsl:for-each>
						  
						<xsl:if test="not(@audit='true')">
							<xsl:value-of select="$cr"/>
						</xsl:if>
						<xsl:if test="@audit='true'">
							<xsl:value-of select="concat(' , ',$cr)"/>
							<xsl:value-of select="concat($tab4, '@mNow , ', $cr)"/>
							<xsl:value-of select="concat($tab4, '@UserID , ', $cr)"/>
							<xsl:value-of select="concat($tab4, '@mNow , ', $cr)"/>
							<xsl:value-of select="concat($tab4, '@UserID', $cr)"/>
						</xsl:if>
					</xsl:when>
					<xsl:when test="($hastemplate)">
						<xsl:value-of select="concat($tab0, 'SELECT')"/>
						<xsl:for-each select="WTATTRIBUTE[@source='entity' and not(@identity) and not(WTCOMPUTE) and not(@persist)]">
							<xsl:if test="position() != last()">
								<xsl:call-template name="SQLColumnSelect">
									<xsl:with-param name="proctype" select="$proctype"/>
									<xsl:with-param name="name" select="@name"/>
									<xsl:with-param name="columnalias" select="false()"/>
									<xsl:with-param name="position" select="position()"/>
									<xsl:with-param name="continue" select="true()"/>
								</xsl:call-template>
							</xsl:if>
							<xsl:if test="position() = last()">
								<xsl:call-template name="SQLColumnSelect">
									<xsl:with-param name="proctype" select="$proctype"/>
									<xsl:with-param name="name" select="@name"/>
									<xsl:with-param name="columnalias" select="false()"/>
									<xsl:with-param name="position" select="position()"/>
									<xsl:with-param name="continue" select="false()"/>
								</xsl:call-template>
							</xsl:if>
						</xsl:for-each>

						<xsl:if test="not(@audit='true')">
							<xsl:value-of select="$cr"/>
						</xsl:if>
						<xsl:if test="@audit='true'">
							<xsl:value-of select="concat(' , ',$cr)"/>
							<xsl:value-of select="concat($tab4, '@mNow , ', $cr)"/>
							<xsl:value-of select="concat($tab4, '@UserID , ', $cr)"/>
							<xsl:value-of select="concat($tab4, '@mNow , ', $cr)"/>
							<xsl:value-of select="concat($tab4, '@UserID', $cr)"/>
						</xsl:if>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="concat($tab0, 'VALUES (', $cr)"/>
						<xsl:for-each select="WTATTRIBUTE[@source='entity' and not(@identity) and not(WTCOMPUTE) and not(@persist)]">
							<xsl:value-of select="$tab4"/>
							<xsl:call-template name="SQLColumnValue">
								<xsl:with-param name="name" select="@name"/>
								<xsl:with-param name="proctype" select="$proctype"/>
							</xsl:call-template>
							<xsl:if test="position() != last()">
								<xsl:value-of select="concat(' ,',$cr)"/>
							</xsl:if>
						</xsl:for-each>
						
						<xsl:if test="@audit='true'">
							<xsl:value-of select="concat(' ,',$cr)"/>
							<xsl:value-of select="concat($tab4, '@mNow , ', $cr)"/>
							<xsl:value-of select="concat($tab4, '@UserID , ', $cr)"/>
							<xsl:value-of select="concat($tab4, '@mNow , ', $cr)"/>
							<xsl:value-of select="concat($tab4, '@UserID', $cr)"/>
						</xsl:if>
						<xsl:value-of select="concat($tab4, ')', $cr)"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>

			<xsl:when test="($proctype='Init')">
				<!--create the column list-->
				<xsl:for-each select="WTPROCEDURE/WTATTRIBUTE">
					<xsl:variable name="nametype"><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="@name"/></xsl:call-template></xsl:variable>
					<xsl:variable name="nametext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@name"/></xsl:call-template></xsl:variable>
					<xsl:variable name="attrtext">
					   <xsl:call-template name="SQLReserved"><xsl:with-param name="ReservedWord" select="$nametext"/></xsl:call-template>
					</xsl:variable>
					<xsl:if test="position() != last()">
						<xsl:value-of select="concat($tab4, $attrtext, ' , ', $cr)"/>
					</xsl:if>
					<xsl:if test="position() = last()">
						<xsl:value-of select="concat($tab4, $attrtext)"/>
					</xsl:if>
				</xsl:for-each>

				<xsl:if test="not(@audit='true')">
					<xsl:value-of select="$cr"/>
				</xsl:if>
				<xsl:if test="@audit='true'">
					<xsl:value-of select="concat(' , ',$cr)"/>
					<xsl:value-of select="concat($tab4, 'CreateDate , ', $cr)"/>
					<xsl:value-of select="concat($tab4, 'CreateID , ', $cr)"/>
					<xsl:value-of select="concat($tab4, 'ChangeDate , ', $cr)"/>
					<xsl:value-of select="concat($tab4, 'ChangeID', $cr)"/>
				</xsl:if>
				<xsl:value-of select="concat($tab4, ')', $cr)"/>

				<!--create the values list-->
				<xsl:value-of select="concat($tab0, 'SELECT')"/>
				<xsl:for-each select="WTPROCEDURE/WTATTRIBUTE">
					<!--new code for SQL ATTRIBUTES-->
					<xsl:if test="position() != last()">
						<xsl:call-template name="SQLAttribute">
							<xsl:with-param name="proctype" select="$proctype"/>
							<xsl:with-param name="procjoin" select="/Data/WTENTITY/WTPROCEDURE/WTJOIN/@name"/>
							<xsl:with-param name="sqlattribute" select="."/>
							<xsl:with-param name="position" select="position()"/>
							<xsl:with-param name="continue" select="true()"/>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="position() = last()">
						<xsl:call-template name="SQLAttribute">
							<xsl:with-param name="proctype" select="$proctype"/>
							<xsl:with-param name="procjoin" select="/Data/WTENTITY/WTPROCEDURE/WTJOIN/@name"/>
							<xsl:with-param name="sqlattribute" select="."/>
							<xsl:with-param name="position" select="position()"/>
							<xsl:with-param name="continue" select="false()"/>
						</xsl:call-template>
					</xsl:if>
				</xsl:for-each>

				<xsl:if test="not(@audit='true')">
					<xsl:value-of select="$cr"/>
				</xsl:if>
				<xsl:if test="@audit='true'">
					<xsl:value-of select="concat(' , ',$cr)"/>
					<xsl:value-of select="concat($tab4, '@mNow , ', $cr)"/>
					<xsl:value-of select="concat($tab4, '@UserID , ', $cr)"/>
					<xsl:value-of select="concat($tab4, '@mNow , ', $cr)"/>
					<xsl:value-of select="concat($tab4, '@UserID', $cr)"/>
				</xsl:if>
			</xsl:when>

			<xsl:when test="($proctype='Count')">
				<xsl:call-template name="SQLColumnSet">
					<xsl:with-param name="colname">@mCount</xsl:with-param>
					<xsl:with-param name="colvalue">COUNT(*)</xsl:with-param>
					<xsl:with-param name="position">1</xsl:with-param>
					<xsl:with-param name="continue" select="false()"/>
				</xsl:call-template>
			</xsl:when>

			<xsl:when test="($proctype='Enum')">
				<xsl:for-each select="WTATTRIBUTE[@identity or @name=$column]">
					<xsl:call-template name="SQLColumnSelect">
						<xsl:with-param name="proctype" select="$proctype"/>
						<xsl:with-param name="name" select="@name"/>
						<xsl:with-param name="columnalias" select="true()"/>
						<xsl:with-param name="position" select="position()"/>
						<xsl:with-param name="continue" select="position() != last()"/>
					</xsl:call-template>
				</xsl:for-each>
			</xsl:when>

			<xsl:when test="($proctype='Fetch')">
				<xsl:for-each select="WTATTRIBUTE[not(@identity) and not(@persist)]">
					<xsl:call-template name="SQLColumnSet">
						<xsl:with-param name="proctype" select="$proctype"/>
						<xsl:with-param name="name" select="@name"/>
						<xsl:with-param name="position" select="position()"/>
						<xsl:with-param name="continue" select="position()!=last()"/>
					</xsl:call-template>
				</xsl:for-each>
			</xsl:when>

			<xsl:when test="($proctype='Find')">
				<xsl:if test="not(/Data/WTENTITY/WTPROCEDURE/WTATTRIBUTE)">
					<xsl:for-each select="WTATTRIBUTE[not(@persist)]">
						<xsl:call-template name="SQLColumnSelect">
							<xsl:with-param name="proctype" select="$proctype"/>
							<xsl:with-param name="name" select="@name"/>
							<xsl:with-param name="columnalias" select="true()"/>
							<xsl:with-param name="position">0</xsl:with-param>
							<xsl:with-param name="continue" select="position() != last()"/>
						</xsl:call-template>
					</xsl:for-each>
				</xsl:if>
				<xsl:if test="/Data/WTENTITY/WTPROCEDURE/WTATTRIBUTE">
					<xsl:for-each select="/Data/WTENTITY/WTPROCEDURE/WTATTRIBUTE">
						<xsl:call-template name="SQLColumnSelect">
							<xsl:with-param name="proctype" select="$proctype"/>
							<xsl:with-param name="name" select="@name"/>
							<xsl:with-param name="columnalias" select="true()"/>
							<xsl:with-param name="position">0</xsl:with-param>
							<xsl:with-param name="continue" select="position() != last()"/>
						</xsl:call-template>
					</xsl:for-each>
				</xsl:if>

			</xsl:when>

			<xsl:when test="($proctype='List')">
				<xsl:for-each select="WTATTRIBUTE[not(@persist)]">
					<xsl:call-template name="SQLColumnSelect">
						<xsl:with-param name="proctype" select="$proctype"/>
						<xsl:with-param name="name" select="@name"/>
						<xsl:with-param name="columnalias" select="true()"/>
						<xsl:with-param name="position" select="position()"/>
						<xsl:with-param name="continue" select="position() != last()"/>
					</xsl:call-template>
				</xsl:for-each>
			</xsl:when>

			<xsl:when test="($proctype='Update')">
				<xsl:for-each select="WTATTRIBUTE[@source='entity' and not(@identity) and not(WTCOMPUTE) and not(@persist) and not(WTUPDATE)]">
					<xsl:if test="position() != last()">
						<xsl:call-template name="SQLColumnSet">
							<xsl:with-param name="proctype" select="$proctype"/>
							<xsl:with-param name="name" select="@name"/>
							<xsl:with-param name="position" select="position()"/>
							<xsl:with-param name="continue" select="true()"/>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="position() = last()">
						<xsl:call-template name="SQLColumnSet">
							<xsl:with-param name="proctype" select="$proctype"/>
							<xsl:with-param name="name" select="@name"/>
							<xsl:with-param name="position" select="position()"/>
							<xsl:with-param name="continue" select="false()"/>
						</xsl:call-template>
					</xsl:if>
				</xsl:for-each>

				<xsl:if test="@audit='true'">
					<xsl:value-of select="concat(' , ',$cr)"/>
					<xsl:call-template name="SQLColumnSet">
						<xsl:with-param name="colname" select="concat($entityalias, '.ChangeDate')"/>
						<xsl:with-param name="colvalue">@mNow</xsl:with-param>
						<xsl:with-param name="continue" select="true()"/>
					</xsl:call-template>
					<xsl:call-template name="SQLColumnSet">
						<xsl:with-param name="colname" select="concat($entityalias, '.ChangeID')"/>
						<xsl:with-param name="colvalue">@UserID</xsl:with-param>
						<xsl:with-param name="continue" select="false()"/>
					</xsl:call-template>
				</xsl:if>
			</xsl:when>
		</xsl:choose>

		<!--====================FROM CLAUSE====================-->
		<xsl:variable name="needlock">
			<xsl:choose>
				<xsl:when test="($proctype='Delete') or ($proctype='DeleteChild') or ($proctype='Update')">
					<xsl:value-of select="('YES')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="('NO')"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:call-template name="SQLFrom">
			<xsl:with-param name="proctype" select="$proctype"/>
			<xsl:with-param name="nolock" select="($needlock='NO')"/>
		</xsl:call-template>


		<!--====================WHERE CLAUSE====================-->

		<!--add conditions for bookmark-->
		<xsl:if test="$hasbookmark">
			<xsl:variable name="col3" select="/Data/WTENTITY/WTPROCEDURE/WTBOOKMARK/@name"/>
			<xsl:variable name="attr" select="/Data/WTENTITY/WTATTRIBUTE[@name=$col3]"/>
			<xsl:variable name="order" select="/Data/WTENTITY/WTPROCEDURE/WTBOOKMARK/@order"/>
			<xsl:variable name="enum">
				<xsl:choose>
					<xsl:when test="/Data/WTENTITY/WTENUM/@enum">
						<xsl:value-of select="(/Data/WTENTITY/WTENUM/@enum)"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="('1')"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>

			<!--add a condition for search text-->
			<xsl:value-of select="'WHERE '"/>
			<xsl:call-template name="SQLColumnSearchText">
				<xsl:with-param name="name" select="$col3"/>
				<xsl:with-param name="proctype" select="$proctype"/>
			</xsl:call-template>

			<!--allow search within field-->
			<xsl:choose>
				<xsl:when test="/Data/WTENTITY/WTENUM[@type='find' and @id=$enum]/WTATTRIBUTE[(@name=$col3) and (@contains='true')]">
						<xsl:value-of select="concat(' LIKE ', $apos, '%', $apos, ' + @SearchText + ', $apos, '%', $apos, $cr)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="concat(' LIKE @SearchText + ', $apos, '%', $apos, $cr)"/>
				</xsl:otherwise>
			</xsl:choose>

			<!--add a condition for bookmark-->
			<xsl:value-of select="'AND '"/>
			<xsl:call-template name="SQLColumnBookmark">
				<xsl:with-param name="name" select="$col3"/>
				<xsl:with-param name="order" select="$order"/>
				<xsl:with-param name="proctype" select="$proctype"/>
				<xsl:with-param name="columnalias" select="false"/>
			</xsl:call-template>

			<xsl:choose>
				<xsl:when test="$attr/@type='date'">
					<xsl:value-of select="concat(' &lt;= @BookMark', $cr)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="concat(' &gt;= @BookMark', $cr)"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>

		<!--add conditions for bookmark-->
		<xsl:if test="$hassearch">
			<xsl:variable name="col4" select="/Data/WTENTITY/WTPROCEDURE/WTSEARCH/@name"/>
			<xsl:variable name="attr" select="/Data/WTENTITY/WTATTRIBUTE[@name=$col4]"/>
			<xsl:variable name="order" select="/Data/WTENTITY/WTPROCEDURE/WTSEARCH/@order"/>
			<xsl:variable name="col5" select="/Data/WTENTITY/WTPROCEDURE/WTSEARCH/@name"/>
			<xsl:variable name="enum2">
				<xsl:choose>
					<xsl:when test="/Data/WTENTITY/WTATTRIBUTE/@enum">
						<xsl:value-of select="(/Data/WTENTITY/WTATTRIBUTE/@enum)"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="('1')"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>

			<!--add a condition for search text-->
			<xsl:value-of select="'WHERE '"/>
			<xsl:call-template name="SQLColumnSearchText">
				<xsl:with-param name="name" select="$col5"/>
				<xsl:with-param name="proctype" select="$proctype"/>
			</xsl:call-template>

			<!--allow search within field-->
			<xsl:choose>
				<xsl:when test="/Data/WTENTITY/WTENUM[@type='find' and @id=$enum2]/WTATTRIBUTE[(@name=$col5) and (@contains='true')]">
					<xsl:value-of select="concat(' LIKE ', $apos, '%', $apos, ' + @SearchText + ', $apos, '%', $apos, $cr)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="concat(' LIKE @SearchText + ', $apos, '%', $apos, $cr)"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>

		<xsl:choose>
			<!--if child conditions are defined they take precedence-->
			<xsl:when test="(($proctype='Find') and ($hasconditions))">
				<xsl:call-template name="SQLWhere">
					<xsl:with-param name="conditions" select="/Data/WTENTITY/WTPROCEDURE/WTCONDITION"/>			
					<xsl:with-param name="append" select="true()"/>
				</xsl:call-template>
			</xsl:when>

			<xsl:when test="($hasconditions)">
				<xsl:call-template name="SQLWhere">
					<xsl:with-param name="conditions" select="/Data/WTENTITY/WTPROCEDURE/WTCONDITION"/>			
				</xsl:call-template>
			</xsl:when>

			<xsl:when test="($proctype='Add') and ($hastemplate)">
				<!--add a condition for any specified params-->
				<xsl:for-each select="($procparams)">
					<xsl:variable name="aname" select="@name"/>
					<xsl:for-each select="/Data/WTENTITY/WTATTRIBUTE[@name=$aname]">
						<xsl:call-template name="SQLWhere">
							<xsl:with-param name="name" select="@name"/>
							<xsl:with-param name="proctype" select="$proctype"/>
							<xsl:with-param name="first" select="position()=1"/>
						</xsl:call-template>
					</xsl:for-each>
				</xsl:for-each>
			</xsl:when>
			
			<xsl:when test="(($proctype='Count') or ($proctype='Enum'))">
				<!--add a condition for the parent fields-->
				<xsl:if test="($ischild)">
					<xsl:for-each select="$parentfields">
						<xsl:call-template name="SQLWhere">
							<xsl:with-param name="name" select="@name"/>
							<xsl:with-param name="proctype" select="$proctype"/>
							<xsl:with-param name="first" select="true()"/>
						</xsl:call-template>
					</xsl:for-each>
				</xsl:if>
			</xsl:when>

			<xsl:when test="(($proctype='Delete') or ($proctype='Fetch') or ($proctype='Update'))">
				<!--add a condition for the identity column-->
				<xsl:for-each select = "WTATTRIBUTE[@identity]">
					<xsl:call-template name="SQLWhere">
						<xsl:with-param name="name" select="@name"/>
						<xsl:with-param name="proctype" select="$proctype"/>
						<xsl:with-param name="first" select="true()"/>
					</xsl:call-template>
				</xsl:for-each>
			</xsl:when>

			<xsl:when test="(($proctype='DeleteChild') or ($proctype='List'))">
				<!--add a condition for any specified params-->
				<xsl:for-each select="($procparams)">
					<xsl:variable name="aname" select="@name"/>
					<xsl:for-each select="/Data/WTENTITY/WTATTRIBUTE[@name=$aname]">
						<xsl:call-template name="SQLWhere">
							<xsl:with-param name="name" select="@name"/>
							<xsl:with-param name="proctype" select="$proctype"/>
							<xsl:with-param name="first" select="position()=1"/>
						</xsl:call-template>
					</xsl:for-each>
				</xsl:for-each>
			</xsl:when>

			<xsl:when test="($proctype='Init')">
				<!--add a condition for any specified params-->
				<xsl:for-each select="($procparams)">
					<xsl:variable name="aname" select="@name"/>
					<xsl:for-each select="/Data/WTENTITY/WTATTRIBUTE[@name=$aname]">
						<xsl:call-template name="SQLWhere">
							<xsl:with-param name="name" select="@name"/>
							<xsl:with-param name="first" select="position()=1"/>
							<xsl:with-param name="proctype" select="$proctype"/>
						</xsl:call-template>
					</xsl:for-each>
				</xsl:for-each>
			</xsl:when>

			<xsl:when test="($proctype='Copy')">
				<xsl:value-of select="concat('WHERE ', $entityalias, '.', $identity, ' = @Copy', $identity)"/>
			</xsl:when>

			<xsl:when test="($proctype='Find')">
				<!--add a condition for any specified params-->
				<xsl:for-each select="($procparams)">
					<xsl:variable name="aname" select="@name"/>
					<xsl:for-each select="/Data/WTENTITY/WTATTRIBUTE[@name=$aname]">
						<xsl:call-template name="SQLWhere">
							<xsl:with-param name="name" select="@name"/>
							<xsl:with-param name="proctype" select="$proctype"/>
							<xsl:with-param name="first" select="false()"/>
						</xsl:call-template>
					</xsl:for-each>
				</xsl:for-each>
			</xsl:when>
		</xsl:choose>

		<!--====================ORDER BY CLAUSE====================-->
		<!--if the order by is specified in the XML use that-->
		<!--otherwise do defalt order for Enum and Find procs-->
		<xsl:choose>
			<xsl:when test="($proctype='Enum')">
				<xsl:call-template name="SQLOrderBy">
					<xsl:with-param name="proctype" select="$proctype"/>
					<xsl:with-param name="name" select="$enumcolumn"/>
					<xsl:with-param name="position">1</xsl:with-param>
					<xsl:with-param name="continue" select="false"/>
				</xsl:call-template>
			</xsl:when>

			<xsl:when test="$hasbookmark">
				<xsl:call-template name="SQLOrderBy">
					<xsl:with-param name="proctype" select="$proctype"/>
					<xsl:with-param name="name" select="/Data/WTENTITY/WTPROCEDURE/WTBOOKMARK/@name"/>
					<xsl:with-param name="position">1</xsl:with-param>
					<xsl:with-param name="continue" select="false"/>
				</xsl:call-template>
			</xsl:when>

			<xsl:when test="$hassearch and count($procorders)=0">
				<xsl:call-template name="SQLOrderBy">
					<xsl:with-param name="proctype" select="$proctype"/>
					<xsl:with-param name="name" select="/Data/WTENTITY/WTPROCEDURE/WTSEARCH/@name"/>
					<xsl:with-param name="position">1</xsl:with-param>
					<xsl:with-param name="continue" select="false"/>
				</xsl:call-template>
			</xsl:when>

			<xsl:when test="count($procorders)>0">
				<xsl:for-each select="($procorders)">
					<xsl:call-template name="SQLOrderBy">
						<xsl:with-param name="proctype" select="$proctype"/>
						<xsl:with-param name="name" select="@name"/>
						<xsl:with-param name="dir" select="@direction"/>
						<xsl:with-param name="position" select="position()"/>
						<xsl:with-param name="continue" select="not(position()=last())"/>
					</xsl:call-template>
				</xsl:for-each>
			</xsl:when>

		</xsl:choose>

		<!--====================SET NEW IDENTITY VALUES====================-->
		<xsl:if test="(($proctype='Add') or ($proctype='Copy')) and ($identity)">
			<xsl:value-of select="$cr"/>
			<xsl:call-template name="SQLSet">
				<xsl:with-param name="name">@mNewID</xsl:with-param>
				<xsl:with-param name="value">@@IDENTITY</xsl:with-param>
			</xsl:call-template>
		</xsl:if>

		<xsl:if test="($proctype='Add')">
			<xsl:for-each select="$identityinits">
				<xsl:call-template name="SQLSet">
					<xsl:with-param name="name" select="concat('@m', @name)"/>
				<xsl:with-param name="value">@@IDENTITY</xsl:with-param>
				</xsl:call-template>
			</xsl:for-each>
		</xsl:if>

		<xsl:if test="($proctype='Copy')">
		  <xsl:call-template name="SQLSet">
		  	<xsl:with-param name="name" select="concat('@', $identity)"/>
		  <xsl:with-param name="value">@mNewID</xsl:with-param>
		  </xsl:call-template>
		</xsl:if>

		<!--====================UPDATE INITIALIZED IDENTITY FIELDS====================-->
		<xsl:if test="($proctype='Add') and (count($identityinits)>0)">
			<xsl:value-of select="$cr"/>
			<xsl:value-of select="concat($tab0, 'UPDATE ', $SQLentityname, $cr)"/>
			<xsl:value-of select="concat($tab0, 'SET ')"/>
			<xsl:for-each select="$identityinits">
				<xsl:call-template name="SQLColumnSet">
					<xsl:with-param name="colname" select="@name"/>
					<xsl:with-param name="colvalue" select="concat('@m', @name)"/>
					<xsl:with-param name="position" select="position()"/>
					<xsl:with-param name="continue" select="position()!=last()"/>
				</xsl:call-template>
			</xsl:for-each>
			<xsl:value-of select="concat($tab0, 'WHERE ', /Data/WTENTITY/WTATTRIBUTE[@identity]/@name, ' = @mNewID', $cr, $cr)"/>
		</xsl:if>



		<!--====================CALL NESTED PROCEDURES====================-->
		<xsl:for-each select="/Data/WTENTITY/WTPROCEDURE/WTPROCEDURE[@position='after']">
			<xsl:value-of select="concat($tab0, $cr )"/>
			<xsl:call-template name="SQLNestedProc">
				<xsl:with-param name="name" select="@name"/>
				<xsl:with-param name="indent">0</xsl:with-param>
			</xsl:call-template>
			<xsl:value-of select="$cr"/>
		</xsl:for-each>

		<!--====================RETURN OUTPUT PARAMETERS====================-->
		<xsl:for-each select="/Data/WTENTITY/WTATTRIBUTE">
			<xsl:variable name="dir">
				<xsl:call-template name="SQLParamDirection">
					<xsl:with-param name="name" select="@name"/>
					<xsl:with-param name="proctype" select="$proctype"/>
				</xsl:call-template>
			</xsl:variable>

			<xsl:choose>
				<xsl:when test="($dir='OUT') and not($proctype='Fetch') and not(WTINIT[@type='template'])">
					<xsl:if test="position()=1"><xsl:value-of select="$cr"/></xsl:if>
					<xsl:choose>
						<xsl:when test="(@identity='true')">
							<xsl:call-template name="SQLSet">
								<xsl:with-param name="name" select="concat('@', @name)"/>
								<xsl:with-param name="value">@mNewID</xsl:with-param>
							</xsl:call-template>
						</xsl:when>
						<xsl:otherwise>
							<xsl:call-template name="SQLSet">
								<xsl:with-param name="name" select="concat('@', @name)"/>
								<xsl:with-param name="value" select="concat('@m', @name)"/>
							</xsl:call-template>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
			</xsl:choose>
		</xsl:for-each>


		<!--====================SET PROCEDURE RETURN VALUE====================-->
		<xsl:choose>
			<xsl:when test="($proctype='Count')">
				<xsl:value-of select="$cr"/>
				<xsl:call-template name="SQLReturn">
					<xsl:with-param name="value">ISNULL(@mCount, 0)</xsl:with-param>
				</xsl:call-template>
			</xsl:when>
		</xsl:choose>


		<!--====================END PROCEDURE====================-->
		<xsl:value-of select="concat($tab0, $cr, 'GO', $cr, $cr)"/>
	</xsl:template>
</xsl:stylesheet>
