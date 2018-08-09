<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:include href="GenerateInclude.xsl"/>

	<xsl:variable name="SQLentityname">
	   <xsl:call-template name="SQLReserved"><xsl:with-param name="ReservedWord" select="$entityname"/></xsl:call-template>
	</xsl:variable>

	<!--==================================================================-->
	<xsl:template name="SQLReserved">
	<!--==================================================================-->
		<xsl:param name="ReservedWord"/>
		<xsl:variable name="word" select="translate($ReservedWord, 'abcdefghijklmnopqrstuvwxyz', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ')"/>
		<xsl:choose>
			<xsl:when test="$word='CASE'"><xsl:value-of select="concat('[', $ReservedWord, ']')"/></xsl:when>
			<xsl:when test="$word='CHECK'"><xsl:value-of select="concat('[', $ReservedWord, ']')"/></xsl:when>
			<xsl:when test="$word='DATABASE'"><xsl:value-of select="concat('[', $ReservedWord, ']')"/></xsl:when>
			<xsl:when test="$word='DUMMY'"><xsl:value-of select="concat('[', $ReservedWord, ']')"/></xsl:when>
			<xsl:when test="$word='FUNCTION'"><xsl:value-of select="concat('[', $ReservedWord, ']')"/></xsl:when>
			<xsl:when test="$word='GROUP'"><xsl:value-of select="concat('[', $ReservedWord, ']')"/></xsl:when>
			<xsl:when test="$word='INDEX'"><xsl:value-of select="concat('[', $ReservedWord, ']')"/></xsl:when>
			<xsl:when test="$word='KEY'"><xsl:value-of select="concat('[', $ReservedWord, ']')"/></xsl:when>
			<xsl:when test="$word='OPTION'"><xsl:value-of select="concat('[', $ReservedWord, ']')"/></xsl:when>
			<xsl:when test="$word='ORDER'"><xsl:value-of select="concat('[', $ReservedWord, ']')"/></xsl:when>
			<xsl:when test="$word='PLAN'"><xsl:value-of select="concat('[', $ReservedWord, ']')"/></xsl:when>
			<xsl:when test="$word='PROCEDURE'"><xsl:value-of select="concat('[', $ReservedWord, ']')"/></xsl:when>
			<xsl:when test="$word='RULE'"><xsl:value-of select="concat('[', $ReservedWord, ']')"/></xsl:when>
			<xsl:when test="$word='SCHEMA'"><xsl:value-of select="concat('[', $ReservedWord, ']')"/></xsl:when>
			<xsl:when test="$word='TABLE'"><xsl:value-of select="concat('[', $ReservedWord, ']')"/></xsl:when>
			<xsl:when test="$word='TRANSACTION'"><xsl:value-of select="concat('[', $ReservedWord, ']')"/></xsl:when>
			<xsl:when test="$word='TRIGGER'"><xsl:value-of select="concat('[', $ReservedWord, ']')"/></xsl:when>
			<xsl:when test="$word='UNION'"><xsl:value-of select="concat('[', $ReservedWord, ']')"/></xsl:when>
			<xsl:when test="$word='UPDATE'"><xsl:value-of select="concat('[', $ReservedWord, ']')"/></xsl:when>
			<xsl:when test="$word='USER'"><xsl:value-of select="concat('[', $ReservedWord, ']')"/></xsl:when>
			<xsl:when test="$word='VIEW'"><xsl:value-of select="concat('[', $ReservedWord, ']')"/></xsl:when>
			<xsl:otherwise><xsl:value-of select="$ReservedWord"/></xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template name="SQLAlias">
	<!--==================================================================-->
		<xsl:param name="join"/>
		<xsl:param name="entity"/>

		<xsl:choose>
			<xsl:when test="not($join)">
				<xsl:value-of select="$entityalias"/>
			</xsl:when>
			<xsl:when test="($join = '')">
				<xsl:value-of select="$entityalias"/>
			</xsl:when>
			<xsl:when test="(/Data/WTENTITY/WTRELATIONSHIPS/WTRELATIONSHIP[@name=$join]/@entity=$entity)">
				<xsl:value-of select="/Data/WTENTITY/WTRELATIONSHIPS/WTRELATIONSHIP[@name=$join]/@alias"/>
			</xsl:when>
			<xsl:when test="($entity = '')">
				<xsl:value-of select="/Data/WTENTITY/WTRELATIONSHIPS/WTRELATIONSHIP[@name=$join]/@alias"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="/Data/WTENTITY/WTRELATIONSHIPS/WTRELATIONSHIP[@name=$join]/WTENTITY[@name=$entity]/@alias"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTSETVALUE">
	<!--==================================================================-->
		<xsl:param name="indent"/>

		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="nametype"><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="@name"/></xsl:call-template></xsl:variable>
		<xsl:variable name="nameprefix"><xsl:call-template name="QualifiedPrefix"><xsl:with-param name="value" select="@name"/></xsl:call-template></xsl:variable>
		<xsl:variable name="nametext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@name"/></xsl:call-template></xsl:variable>
		<xsl:variable name="valuetype"><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>
		<xsl:variable name="valueprefix"><xsl:call-template name="QualifiedPrefix"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>
		<xsl:variable name="valuetext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>

	 <!-- ***************** Error Checking *******************-->
	 <xsl:if test="not(@name)">
	     <xsl:call-template name="Error">
	     	<xsl:with-param name="msg" select="'WTSETVALUE Name Missing'"/>
	     	<xsl:with-param name="text" select="position()"/>
	     </xsl:call-template>
	 </xsl:if>
	 <xsl:if test="not(@value)">
	     <xsl:call-template name="Error">
	     	<xsl:with-param name="msg" select="'WTSETVALUE Value Missing'"/>
	     	<xsl:with-param name="text" select="@name"/>
	     </xsl:call-template>
	 </xsl:if>
	 <!--Test valid attributes-->
	 <xsl:for-each select="@*">
		  <xsl:choose>
				<xsl:when test="name()='name'"/>
				<xsl:when test="name()='value'"/>
				<xsl:when test="name()='null'"/>
				<xsl:otherwise>
					 <xsl:call-template name="Error">
						  <xsl:with-param name="msg" select="'WTSETVALUE Invalid Attribute'"/>
						  <xsl:with-param name="text" select="name()"/>
	 				</xsl:call-template>
				</xsl:otherwise>
		  </xsl:choose>
	 </xsl:for-each>
	 <!-- ****************************************************-->

		<xsl:value-of select="concat($ind1, 'SET ')"/>

		  <xsl:call-template name="GetValue">
				<xsl:with-param name="type" select="$nametype"/>			
				<xsl:with-param name="text" select="$nametext"/>			
		  </xsl:call-template>

		<xsl:value-of select="' '"/>
		<xsl:if test="not($nametype = 'CONST')">
			<xsl:value-of select="'= '"/>
		</xsl:if>		

		<xsl:if test="@null">
			<xsl:value-of select="('ISNULL(')"/>
		</xsl:if>		

		  <xsl:call-template name="GetValue">
				<xsl:with-param name="type" select="$valuetype"/>			
				<xsl:with-param name="text" select="$valuetext"/>			
		  </xsl:call-template>

		<xsl:if test="@null">
			<xsl:value-of select="concat(', ', @null, ')')"/>
		</xsl:if>		
		<xsl:value-of select="$cr"/>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTRELATIONSHIP" mode="from">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:param name="lock"/>

		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>

	 <!-- ***************** Error Checking *******************-->
	 <xsl:if test="not(@name)">
	     <xsl:call-template name="Error">
	     	<xsl:with-param name="msg" select="'WTRELATIONSHIP Name Missing'"/>
	     	<xsl:with-param name="text" select="position()"/>
	     </xsl:call-template>
	 </xsl:if>
	 <xsl:if test="not(@entity)">
	     <xsl:call-template name="Error">
	     	<xsl:with-param name="msg" select="'WTRELATIONSHIP Entity Missing'"/>
	     	<xsl:with-param name="text" select="@name"/>
	     </xsl:call-template>
	 </xsl:if>
	 <xsl:if test="not(@alias)">
	     <xsl:call-template name="Error">
	     	<xsl:with-param name="msg" select="'WTRELATIONSHIP Alias Missing'"/>
	     	<xsl:with-param name="text" select="@name"/>
	     </xsl:call-template>
	 </xsl:if>
	 <!--Test valid attributes-->
	 <xsl:for-each select="@*">
		  <xsl:choose>
				<xsl:when test="name()='name'"/>
				<xsl:when test="name()='entity'"/>
				<xsl:when test="name()='alias'"/>
				<xsl:otherwise>
					 <xsl:call-template name="Error">
						  <xsl:with-param name="msg" select="'WTRELATIONSHIP Invalid Attribute'"/>
						  <xsl:with-param name="text" select="name()"/>
	 				</xsl:call-template>
				</xsl:otherwise>
		  </xsl:choose>
	 </xsl:for-each>
	 <!-- ****************************************************-->

	   <xsl:variable name="entity">
		   <xsl:call-template name="SQLReserved"><xsl:with-param name="ReservedWord" select="@entity"/></xsl:call-template>
	   </xsl:variable>

		<xsl:value-of select="concat($ind1, 'FROM ', $entity, ' AS ', @alias)"/>
		<xsl:if test="not ($lock)"><xsl:value-of select="(' (NOLOCK)')"/></xsl:if>
		<xsl:value-of select="$cr"/>

		<xsl:apply-templates select="WTENTITY" mode="from">
			<xsl:with-param name="indent" select="$indent"/>
			<xsl:with-param name="lock" select="$lock"/>
		</xsl:apply-templates>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTRELATIONSHIP/WTENTITY" mode="from">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:param name="lock"/>

		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>

	 <!-- ***************** Error Checking *******************-->
	 <xsl:if test="not(@name)">
	     <xsl:call-template name="Error">
	     	<xsl:with-param name="msg" select="'WTRELATIONSHIP/WTENTITY Name Missing'"/>
	     	<xsl:with-param name="text" select="position()"/>
	     </xsl:call-template>
	 </xsl:if>
	 <xsl:if test="not(@entity)">
	     <xsl:call-template name="Error">
	     	<xsl:with-param name="msg" select="'WTRELATIONSHIP/WTENTITY Entity Missing'"/>
	     	<xsl:with-param name="text" select="@name"/>
	     </xsl:call-template>
	 </xsl:if>
	 <xsl:if test="not(@alias)">
	     <xsl:call-template name="Error">
	     	<xsl:with-param name="msg" select="'WTRELATIONSHIP/WTENTITY Alias Missing'"/>
	     	<xsl:with-param name="text" select="@name"/>
	     </xsl:call-template>
	 </xsl:if>
	 <!--Test valid attributes-->
	 <xsl:for-each select="@*">
		  <xsl:choose>
				<xsl:when test="name()='name'"/>
				<xsl:when test="name()='entity'"/>
				<xsl:when test="name()='alias'"/>
				<xsl:when test="name()='join'"/>
				<xsl:otherwise>
					 <xsl:call-template name="Error">
						  <xsl:with-param name="msg" select="'WTRELATIONSHIP/WTENTITY Invalid Attribute'"/>
						  <xsl:with-param name="text" select="name()"/>
	 				</xsl:call-template>
				</xsl:otherwise>
		  </xsl:choose>
	 </xsl:for-each>
	 <!-- ****************************************************-->

	   <xsl:variable name="entity">
		   <xsl:call-template name="SQLReserved"><xsl:with-param name="ReservedWord" select="@entity"/></xsl:call-template>
	   </xsl:variable>

		<xsl:choose>
			<xsl:when test="(@join='inner')"><xsl:value-of select="concat($ind1, 'INNER JOIN ', $entity, ' AS ', @alias)"/></xsl:when>
			<xsl:otherwise><xsl:value-of select="concat($ind1, 'LEFT OUTER JOIN ', $entity, ' AS ', @alias)"/></xsl:otherwise>
		</xsl:choose>

		<xsl:if test="not ($lock)"><xsl:value-of select="(' (NOLOCK)')"/></xsl:if>
		<xsl:value-of select="(' ON (')"/>
		<xsl:for-each select="WTATTRIBUTE">
			<xsl:if test="@connector"><xsl:value-of select="concat(' ', @connector, ' ')"/></xsl:if>
			<xsl:if test="@relalias">
				<xsl:value-of select="concat(@alias, '.', @name, ' = ', @relalias, '.', @relname)"/>
			</xsl:if>
			<xsl:if test="not(@relalias)">
				<xsl:value-of select="concat(@alias, '.', @name, ' = ', @relname)"/>
			</xsl:if>
		</xsl:for-each>
		<xsl:value-of select="concat(')', $cr)"/>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTATTRIBUTE" mode="insert">
	<!--==================================================================-->
		<xsl:param name="indent"/>

		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="nametype"><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="@name"/></xsl:call-template></xsl:variable>
		<xsl:variable name="nameprefix"><xsl:call-template name="QualifiedPrefix"><xsl:with-param name="value" select="@name"/></xsl:call-template></xsl:variable>
		<xsl:variable name="nametext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@name"/></xsl:call-template></xsl:variable>

	 <!-- ***************** Error Checking *******************-->
    <xsl:call-template name="ErrorCheckAttribute"/>
	 <!-- ****************************************************-->

	   <xsl:variable name="nametxt">
		   <xsl:call-template name="SQLReserved"><xsl:with-param name="ReservedWord" select="$nametext"/></xsl:call-template>
	   </xsl:variable>
		<xsl:choose>
			<xsl:when test="($nametype = 'ATTR')"><xsl:value-of select="concat($ind1, $tab3, $nametxt, ' ')"/></xsl:when>
		</xsl:choose>

		<xsl:if test="position() != last()">
			<xsl:value-of select="(' , ')"/>
		</xsl:if>
		<xsl:value-of select="$cr"/>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTATTRIBUTE" mode="value">
	<!--==================================================================-->
		<xsl:param name="indent"/>

		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="valuetype"><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>
		<xsl:variable name="valueprefix"><xsl:call-template name="QualifiedPrefix"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>
		<xsl:variable name="valuetext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>

	 <!-- ***************** Error Checking *******************-->
    <xsl:call-template name="ErrorCheckAttribute"/>
	 <!-- ****************************************************-->

		  <xsl:value-of select="concat($ind1, $tab1)"/>
		  <xsl:call-template name="GetValue">
				<xsl:with-param name="type" select="$valuetype"/>			
				<xsl:with-param name="text" select="$valuetext"/>			
				<xsl:with-param name="entity" select="$valueprefix"/>
				<xsl:with-param name="join" select="../WTJOIN/@name"/>
		  </xsl:call-template>
		  <xsl:value-of select="' '"/>

		<xsl:if test="position() != last()">
			<xsl:value-of select="(' , ')"/>
		</xsl:if>
		<xsl:value-of select="$cr"/>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTATTRIBUTE" mode="update">
	<!--==================================================================-->
		<xsl:param name="indent"/>

		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="nametype"><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="@name"/></xsl:call-template></xsl:variable>
		<xsl:variable name="nameprefix"><xsl:call-template name="QualifiedPrefix"><xsl:with-param name="value" select="@name"/></xsl:call-template></xsl:variable>
		<xsl:variable name="nametext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@name"/></xsl:call-template></xsl:variable>
		<xsl:variable name="valuetype"><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>
		<xsl:variable name="valueprefix"><xsl:call-template name="QualifiedPrefix"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>
		<xsl:variable name="valuetext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>

	 <!-- ***************** Error Checking *******************-->
    <xsl:call-template name="ErrorCheckAttribute"/>
	 <!-- ****************************************************-->

		<xsl:choose>
			<xsl:when test="position()=1"><xsl:value-of select="concat($ind1, 'SET ')"/></xsl:when>
			<xsl:otherwise><xsl:value-of select="concat($ind1, $tab1)"/></xsl:otherwise>
		</xsl:choose>

		  <xsl:call-template name="GetValue">
				<xsl:with-param name="type" select="$nametype"/>
				<xsl:with-param name="text" select="$nametext"/>			
				<xsl:with-param name="entity" select="$nameprefix"/>
				<xsl:with-param name="join" select="../WTJOIN/@name"/>
		  </xsl:call-template>
		  <xsl:value-of select="' = '"/>

		  <xsl:call-template name="GetValue">
				<xsl:with-param name="type" select="$valuetype"/>			
				<xsl:with-param name="text" select="$valuetext"/>			
				<xsl:with-param name="entity" select="$valueprefix"/>
				<xsl:with-param name="join" select="../WTJOIN/@name"/>
		  </xsl:call-template>
		  <xsl:value-of select="' '"/>
		  <xsl:if test="position()!=last()"><xsl:value-of select="', '"/></xsl:if>
		  <xsl:value-of select="$cr"/>

	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTATTRIBUTE" mode="concat">
	<!--==================================================================-->
		<xsl:param name="indent"/>

		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		
	 <!-- ***************** Error Checking *******************-->
    <xsl:call-template name="ErrorCheckAttribute"/>
	 <!-- ****************************************************-->

		<xsl:apply-templates select="WTARGUMENT">
			<xsl:with-param name="indent" select="$indent"/>
		</xsl:apply-templates>

		<xsl:value-of select="concat(' AS ', $apos, @alias, $apos, $cr)"/>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTATTRIBUTE" mode="compute">
	<!--==================================================================-->
		<xsl:param name="indent"/>

		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		
	 <!-- ***************** Error Checking *******************-->
    <xsl:call-template name="ErrorCheckAttribute"/>
	 <!-- ****************************************************-->

		<xsl:apply-templates select="WTARGUMENT">
			<xsl:with-param name="indent" select="$indent"/>
		</xsl:apply-templates>

		<xsl:value-of select="concat(' AS ', $apos, @alias, $apos, $cr)"/>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTARGUMENT">
	<!--==================================================================-->
		<xsl:param name="indent"/>

		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="nametype"><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="@name"/></xsl:call-template></xsl:variable>
		<xsl:variable name="nameprefix"><xsl:call-template name="QualifiedPrefix"><xsl:with-param name="value" select="@name"/></xsl:call-template></xsl:variable>
		<xsl:variable name="nametext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@name"/></xsl:call-template></xsl:variable>
		<xsl:variable name="valuetype"><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>
		<xsl:variable name="valueprefix"><xsl:call-template name="QualifiedPrefix"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>
		<xsl:variable name="valuetext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>

	 <!-- ***************** Error Checking *******************-->
	 <xsl:if test="not(@value)">
	     <xsl:call-template name="Error">
	     	<xsl:with-param name="msg" select="'WTARGUMENT Value Missing'"/>
	     	<xsl:with-param name="text" select="@name"/>
	     </xsl:call-template>
	 </xsl:if>
	 <!--Test valid attributes-->
	 <xsl:for-each select="@*">
		  <xsl:choose>
				<xsl:when test="name()='name'"/>
				<xsl:when test="name()='oper'"/>
				<xsl:when test="name()='value'"/>
				<xsl:when test="name()='null'"/>
				<xsl:otherwise>
					 <xsl:call-template name="Error">
						  <xsl:with-param name="msg" select="'WTARGUMENT Invalid Attribute'"/>
						  <xsl:with-param name="text" select="name()"/>
	 				</xsl:call-template>
				</xsl:otherwise>
		  </xsl:choose>
	 </xsl:for-each>
	 <!-- ****************************************************-->

		<!-- Handle Operator -->  
		<xsl:choose>
			<xsl:when test="position()=1"><xsl:value-of select="concat($ind1, $tab2)"/></xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="GetOperator"><xsl:with-param name="oper" select="@oper"/></xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>

		<!-- Get Name Value -->  
		<xsl:if test="(@name)">
		  <xsl:call-template name="GetValue">
				<xsl:with-param name="type" select="$nametype"/>			
				<xsl:with-param name="text" select="$nametext"/>			
		  </xsl:call-template>
		  <xsl:value-of select="' = '"/>
		  <xsl:if test="@null"><xsl:value-of select="('ISNULL(')"/></xsl:if>		
		</xsl:if>

		  <xsl:variable name="datatype">
		  	<xsl:call-template name="GetDataType">
		  		<xsl:with-param name="type" select="$valuetype"/>			
		  		<xsl:with-param name="text" select="$valuetext"/>			
		  	</xsl:call-template>
		  </xsl:variable>
	   <xsl:variable name="cast">
			<xsl:choose>
				<xsl:when test="$datatype='text'"/>
				<xsl:when test="$datatype='char'"/>
				<xsl:when test="$datatype='password'"/>
				<xsl:otherwise>true</xsl:otherwise>
			</xsl:choose>
	   </xsl:variable>

		<xsl:if test="($valuetype = 'ATTR') and (../@type = 'concat')">
			<xsl:if test="$cast='true'"><xsl:value-of select="'CAST('"/></xsl:if>
		</xsl:if>

			<xsl:variable name="compute" select="count(/Data/WTENTITY/WTATTRIBUTE[(@name=$valuetext) and WTCOMPUTE])&gt;0"/>
			<xsl:variable name="attrjoin" select="/Data/WTENTITY/WTATTRIBUTE[(@name=$valuetext) and WTJOIN]"/>
			<xsl:variable name="join">
				<xsl:choose>
					<xsl:when test="$compute"><xsl:value-of select="../WTJOIN/@name"/></xsl:when>
					<xsl:otherwise><xsl:value-of select="ancestor::WTSELECT[1]/WTJOIN/@name"/></xsl:otherwise>
				</xsl:choose>
			</xsl:variable>

		  <xsl:call-template name="GetValue">
				<xsl:with-param name="type" select="$valuetype"/>
				<xsl:with-param name="text" select="$valuetext"/>
				<xsl:with-param name="entity" select="$valueprefix"/>
				<xsl:with-param name="join" select="$join"/>
				<xsl:with-param name="compute" select="$compute"/>
				<xsl:with-param name="attrjoin" select="$attrjoin"/>
				<xsl:with-param name="proctype" select="Fetch"/>
				<xsl:with-param name="columnalias" select="false()"/>
		  </xsl:call-template>

		<xsl:if test="($valuetype = 'ATTR') and (../@type = 'concat')">
			<xsl:if test="$cast='true'"><xsl:value-of select="' AS nvarchar(20))'"/></xsl:if>
		</xsl:if>

		<xsl:if test="@null">
			<xsl:value-of select="concat(', ', @null, ')')"/>
		</xsl:if>		
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTORDER">
	<!--==================================================================-->
		<xsl:param name="indent"/>

		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="nametype"><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="@name"/></xsl:call-template></xsl:variable>
		<xsl:variable name="nameprefix"><xsl:call-template name="QualifiedPrefix"><xsl:with-param name="value" select="@name"/></xsl:call-template></xsl:variable>
		<xsl:variable name="nametext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@name"/></xsl:call-template></xsl:variable>

	 <!-- ***************** Error Checking *******************-->
	 <xsl:if test="not(@name)">
	     <xsl:call-template name="Error">
	     	<xsl:with-param name="msg" select="'WTORDER Name Missing'"/>
	     	<xsl:with-param name="text" select="position()"/>
	     </xsl:call-template>
	 </xsl:if>
	 <!--Test valid attributes-->
	 <xsl:for-each select="@*">
		  <xsl:choose>
				<xsl:when test="name()='name'"/>
				<xsl:when test="name()='descend'"/>
				<xsl:otherwise>
					 <xsl:call-template name="Error">
						  <xsl:with-param name="msg" select="'WTORDER Invalid Attribute'"/>
						  <xsl:with-param name="text" select="name()"/>
	 				</xsl:call-template>
				</xsl:otherwise>
		  </xsl:choose>
	 </xsl:for-each>
	 <!-- ****************************************************-->

		<xsl:if test="position() = 1">
			<xsl:value-of select="concat($ind1, 'ORDER BY   ')"/>
		</xsl:if>

		  <xsl:variable name="compute" select="count(/Data/WTENTITY/WTATTRIBUTE[(@name=$nametext) and WTCOMPUTE])&gt;0"/>

		  <xsl:call-template name="GetValue">
				<xsl:with-param name="type" select="$nametype"/>
				<xsl:with-param name="text" select="$nametext"/>
				<xsl:with-param name="entity" select="$nameprefix"/>
				<xsl:with-param name="join" select="../WTJOIN/@name"/>
				<xsl:with-param name="compute" select="$compute"/>
				<xsl:with-param name="nameonly" select="true()"/>
		  </xsl:call-template>

			<xsl:if test="@descend">
				<xsl:value-of select="' DESC'"/>
			</xsl:if>

		<xsl:choose>
			<xsl:when test="position()=last()">
				<xsl:value-of select="$cr"/>
			</xsl:when>
			<xsl:otherwise><xsl:value-of select="(' , ')"/></xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTATTRIBUTE" mode="fetch">
	<!--==================================================================-->
		<xsl:param name="indent"/>

		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="nametype"><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="@name"/></xsl:call-template></xsl:variable>
		<xsl:variable name="nameprefix"><xsl:call-template name="QualifiedPrefix"><xsl:with-param name="value" select="@name"/></xsl:call-template></xsl:variable>
		<xsl:variable name="nametext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@name"/></xsl:call-template></xsl:variable>
		<xsl:variable name="valuetype"><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>
		<xsl:variable name="valueprefix"><xsl:call-template name="QualifiedPrefix"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>
		<xsl:variable name="valuetext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>

	 <!-- ***************** Error Checking *******************-->
    <xsl:call-template name="ErrorCheckAttribute"/>
	 <!-- ****************************************************-->

		<xsl:choose>
			<xsl:when test="(@type='concat')">
				<xsl:apply-templates select="." mode="concat">
					<xsl:with-param name="indent" select="$indent"/>
				</xsl:apply-templates>
			</xsl:when>
			<xsl:when test="(@type='compute')">
				<xsl:apply-templates select="." mode="compute">
					<xsl:with-param name="indent" select="$indent"/>
				</xsl:apply-templates>
			</xsl:when>
			
			<xsl:otherwise>
			
				<xsl:choose>
					<xsl:when test="position()=1"><xsl:value-of select="concat($ind1, $tab2)"/></xsl:when>
					<xsl:otherwise><xsl:value-of select="concat($ind1, $tab3)"/></xsl:otherwise>
				</xsl:choose>

				<xsl:if test="(@name)">
				  <xsl:call-template name="GetValue">
						<xsl:with-param name="type" select="$nametype"/>			
						<xsl:with-param name="text" select="$nametext"/>			
				  </xsl:call-template>
				  <xsl:value-of select="' = '"/>
				  <xsl:if test="@null"><xsl:value-of select="('ISNULL(')"/></xsl:if>		
				</xsl:if>

				<xsl:if test="@func">
					<xsl:value-of select="concat( $dbowner, '.wtfn_', @func, '(')"/>
				</xsl:if>

				<xsl:variable name="compute" select="count(/Data/WTENTITY/WTATTRIBUTE[(@name=$valuetext) and WTCOMPUTE])&gt;0"/>
				<xsl:variable name="attrjoin" select="/Data/WTENTITY/WTATTRIBUTE[(@name=$valuetext)]/WTJOIN"/>

				<xsl:call-template name="GetValue">
					<xsl:with-param name="type" select="$valuetype"/>
					<xsl:with-param name="text" select="$valuetext"/>
					<xsl:with-param name="entity" select="$valueprefix"/>
					<xsl:with-param name="join" select="../WTJOIN/@name"/>
					<xsl:with-param name="compute" select="$compute"/>
					<xsl:with-param name="attrjoin" select="$attrjoin"/>
					<xsl:with-param name="columnalias" select="false()"/>
					<xsl:with-param name="proctype" select="Fetch"/>
				</xsl:call-template>

				<xsl:if test="@func">
					<xsl:if test="@parm">
						<xsl:value-of select="concat(', ', @parm )"/>
					</xsl:if>
					<xsl:value-of select="')'"/>
				</xsl:if>

				<xsl:if test="@null">
					<xsl:value-of select="concat(', ', @null, ')')"/>
				</xsl:if>		
				
				<!-- add column alias -->
				<xsl:choose>
					<xsl:when test="($valuetype = 'ATTR' or $valuetype = 'CONST') and ($compute or @alias)">
						<xsl:if test="not(@name)">
							<xsl:value-of select="concat(' AS ', $apos, @alias, $apos)"/>
						</xsl:if>
					</xsl:when>
					<xsl:when test="$valuetype = 'ATTR' and $attrjoin">
						<xsl:if test="not(@name)">
							<xsl:value-of select="concat(' AS ', $apos, $valuetext, $apos)"/>
						</xsl:if>
					</xsl:when>
				</xsl:choose>

			</xsl:otherwise>
		</xsl:choose>

		<xsl:if test="position()!=last()"><xsl:value-of select="', '"/></xsl:if>
	   <xsl:value-of select="$cr"/>
	   
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTUPDATE | WTSELECT | WTINSERT | WTDELETE" mode="where">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="indent2" select="concat($indent, $tab3)"/>
		<xsl:variable name="hasconditions" select="(count(WTCONDITION) > 0)"/>

		<xsl:if test="$hasconditions">
			<xsl:value-of select="concat($ind1, 'WHERE ')"/>

			<xsl:for-each select="WTCONDITION">
				<xsl:choose>
					<xsl:when test="(position() = 1)">
						<xsl:apply-templates select="." mode="dotest">
							<xsl:with-param name="indent" select="$indent"/>
						</xsl:apply-templates>
					</xsl:when>
					<xsl:otherwise>
						<xsl:apply-templates select="." mode="dotest">
							<xsl:with-param name="indent" select="$indent2"/>
						</xsl:apply-templates>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:value-of select="$cr"/>
			</xsl:for-each>

			<xsl:value-of select="$cr"/>
		</xsl:if>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTINSERT">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="ind2" select="concat($ind1, $tab1)"/>
		<xsl:variable name="indent2" select="$indent + 1"/>
		<xsl:variable name="proctype" select ="/Data/WTENTITY/WTPROCEDURE/@type"/>

	 <!-- ***************** Error Checking *******************-->
	 <!--Test valid attributes-->
	 <xsl:for-each select="@*">
		  <xsl:choose>
				<xsl:when test="name()='select'"/>
				<xsl:otherwise>
					 <xsl:call-template name="Error">
						  <xsl:with-param name="msg" select="'WTINSERT Invalid Attribute'"/>
						  <xsl:with-param name="text" select="name()"/>
	 				</xsl:call-template>
				</xsl:otherwise>
		  </xsl:choose>
	 </xsl:for-each>
	 <!-- ****************************************************-->

		<!--==================== SEQ LOGIC ====================-->
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
			<xsl:value-of select="concat($tab0, 'END', $cr, $cr)"/>
		</xsl:for-each>

		<!--column list-->
		<xsl:value-of select="concat($ind1, 'INSERT INTO ', $SQLentityname, ' ('$cr)"/>

		<xsl:choose>
			<xsl:when test="count(WTATTRIBUTE)!=0">
				<xsl:apply-templates select="WTATTRIBUTE" mode="insert">
					<xsl:with-param name="indent" select="$indent2"/>
				</xsl:apply-templates>
			</xsl:when>
			<xsl:otherwise>
				<xsl:for-each select="/Data/WTENTITY/WTATTRIBUTE[@source='entity' and not(@identity) and not(WTCOMPUTE) and not(@persist)]">
					<xsl:if test="position() != last()">
						<xsl:value-of select="concat($tab4, @name, ' , ', $cr)"/>
					</xsl:if>
					<xsl:if test="position() = last()">
						<xsl:value-of select="concat($tab4, @name)"/>
					</xsl:if>
				</xsl:for-each>
				
				<xsl:if test="not(/Data/WTENTITY/@audit='true')">
					<xsl:value-of select="$cr"/>
				</xsl:if>
				<xsl:if test="/Data/WTENTITY/@audit='true'">
					<xsl:value-of select="concat(' , ',$cr)"/>
					<xsl:value-of select="concat($tab4, 'CreateDate , ', $cr)"/>
					<xsl:value-of select="concat($tab4, 'CreateID , ', $cr)"/>
					<xsl:value-of select="concat($tab4, 'ChangeDate , ', $cr)"/>
					<xsl:value-of select="concat($tab4, 'ChangeID', $cr)"/>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
		
		<xsl:value-of select="concat($cr, $ind1, $tab4, ')', $cr)"/>

		<!--values list-->
		<xsl:choose>
			<xsl:when test="(@select='true')"><xsl:value-of select="concat($ind1, 'SELECT ', $cr)"/></xsl:when>
			<xsl:otherwise><xsl:value-of select="concat($ind1, 'VALUES (', $cr)"/></xsl:otherwise>
		</xsl:choose>
			
		<xsl:choose>
			<xsl:when test="count(WTATTRIBUTE)!=0">
				<xsl:apply-templates select="WTATTRIBUTE" mode="value">
					<xsl:with-param name="indent" select="$indent2"/>
				</xsl:apply-templates>
			</xsl:when>
			<xsl:otherwise>
				<xsl:for-each select="/Data/WTENTITY/WTATTRIBUTE[@source='entity' and not(@identity) and not(WTCOMPUTE) and not(@persist)]">
					<xsl:value-of select="$tab4"/>
					<xsl:call-template name="SQLColumnValue">
						<xsl:with-param name="name" select="@name"/>
						<xsl:with-param name="proctype" select="$proctype"/>
					</xsl:call-template>
					<xsl:if test="position() != last()">
						<xsl:value-of select="concat(' ,',$cr)"/>
					</xsl:if>
				</xsl:for-each>
				
				<xsl:if test="not(/Data/WTENTITY/@audit='true')">
					<xsl:value-of select="$cr"/>
				</xsl:if>		
				<xsl:if test="/Data/WTENTITY/@audit='true'">
					<xsl:value-of select="concat(' ,',$cr)"/>
					<xsl:value-of select="concat($tab4, '@mNow , ', $cr)"/>
					<xsl:value-of select="concat($tab4, '@UserID , ', $cr)"/>
					<xsl:value-of select="concat($tab4, '@mNow , ', $cr)"/>
					<xsl:value-of select="concat($tab4, '@UserID', $cr)"/>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>

		<xsl:choose>
			<xsl:when test="(@select='true')"></xsl:when>
			<xsl:otherwise><xsl:value-of select="concat($ind1, $tab4, ')', $cr)"/></xsl:otherwise>
		</xsl:choose>

		<!--from clause-->
		<xsl:apply-templates select="/Data/WTENTITY/WTRELATIONSHIPS/WTRELATIONSHIP[@name=current()/WTJOIN/@name]" mode="from">
			<xsl:with-param name="indent" select="$indent"/>
			<xsl:with-param name="lock" select="(current()/WTJOIN/@lock='true')"/>
		</xsl:apply-templates>

		<!--where clause-->
		<xsl:apply-templates select="." mode="where">
			<xsl:with-param name="indent" select="$indent"/>
		</xsl:apply-templates>

		<xsl:value-of select="$cr"/>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTUPDATE">
	<!--==================================================================-->
		<xsl:param name="indent"/>

		<xsl:variable name="hasconditions" select="(count(WTCONDITION) > 0)"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="ind2" select="concat($ind1, $tab1)"/>
		<xsl:variable name="indent2" select="$indent + 1"/>
		<xsl:variable name="proctype" select ="/Data/WTENTITY/WTPROCEDURE/@type"/>

	 <!-- ***************** Error Checking *******************-->
	 <!--Test valid attributes-->
	 <xsl:for-each select="@*">
		  <xsl:choose>
				<xsl:when test="1=0"/>
				<xsl:otherwise>
					 <xsl:call-template name="Error">
						  <xsl:with-param name="msg" select="'WTUPDATE Invalid Attribute'"/>
						  <xsl:with-param name="text" select="name()"/>
	 				</xsl:call-template>
				</xsl:otherwise>
		  </xsl:choose>
	 </xsl:for-each>
	 <!-- ****************************************************-->

		<!--columm list-->
		<xsl:value-of select="concat($ind1, 'UPDATE ', $entityalias, $cr)"/>

		<xsl:choose>
			<xsl:when test="count(WTATTRIBUTE)!=0">
				<xsl:apply-templates select="WTATTRIBUTE" mode="update">
					<xsl:with-param name="indent" select="$indent"/>
				</xsl:apply-templates>
			</xsl:when>
			<xsl:otherwise>
				<xsl:for-each select="/Data/WTENTITY/WTATTRIBUTE[@source='entity' and not(@identity) and not(WTCOMPUTE) and not(@persist) and not(WTUPDATE)]">
					<xsl:call-template name="SQLColumnSet">
						<xsl:with-param name="proctype" select="$proctype"/>
						<xsl:with-param name="name" select="@name"/>
						<xsl:with-param name="position" select="position()"/>
						<xsl:with-param name="continue" select="position() != last()"/>
						<xsl:with-param name="newline" select="position() != last()"/>
					</xsl:call-template>
				</xsl:for-each>
				
				<xsl:if test="not(/Data/WTENTITY/@audit='true')">
					<xsl:value-of select="$cr"/>
				</xsl:if>
				<xsl:if test="/Data/WTENTITY/@audit='true'">
					<xsl:value-of select="concat(' ,',$cr)"/>
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
			</xsl:otherwise>
		</xsl:choose>

		<!--from clause-->
		<xsl:apply-templates select="/Data/WTENTITY/WTRELATIONSHIPS/WTRELATIONSHIP[@name=current()/WTJOIN/@name]" mode="from">
			<xsl:with-param name="indent" select="$indent"/>
			<xsl:with-param name="lock" select="(current()/WTJOIN/@lock='true')"/>
		</xsl:apply-templates>

		<!--where clause-->
		<xsl:apply-templates select="." mode="where">
			<xsl:with-param name="indent" select="$indent"/>
		</xsl:apply-templates>

		<xsl:value-of select="$cr"/>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTDELETE">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="ind2" select="concat($ind1, $tab1)"/>
		<xsl:variable name="indent2" select="$indent + 1"/>

	 <!-- ***************** Error Checking *******************-->
	 <!--Test valid attributes-->
	 <xsl:for-each select="@*">
		  <xsl:choose>
				<xsl:when test="1=0"/>
				<xsl:otherwise>
					 <xsl:call-template name="Error">
						  <xsl:with-param name="msg" select="'WTDELETE Invalid Attribute'"/>
						  <xsl:with-param name="text" select="name()"/>
	 				</xsl:call-template>
				</xsl:otherwise>
		  </xsl:choose>
	 </xsl:for-each>
	 <!-- ****************************************************-->

		<xsl:value-of select="concat($ind1, 'DELETE ', $entityalias, $cr)"/>

		<!--from clause-->
		<xsl:apply-templates select="/Data/WTENTITY/WTRELATIONSHIPS/WTRELATIONSHIP[@name=current()/WTJOIN/@name]" mode="from">
			<xsl:with-param name="indent" select="$indent"/>
			<xsl:with-param name="lock" select="(current()/WTJOIN/@lock='true')"/>
		</xsl:apply-templates>

		<!--where clause-->
		<xsl:apply-templates select="." mode="where">
			<xsl:with-param name="indent" select="$indent"/>
		</xsl:apply-templates>

		<xsl:value-of select="$cr"/>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTSELECT">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="ind2" select="concat($ind1, $tab1)"/>
		<xsl:variable name="indent2" select="$indent + 1"/>

	 <!-- ***************** Error Checking *******************-->
	 <!--Test valid attributes-->
	 <xsl:for-each select="@*">
		  <xsl:choose>
				<xsl:when test="name()='top'"/>
				<xsl:when test="name()='distinct'"/>
				<xsl:otherwise>
					 <xsl:call-template name="Error">
						  <xsl:with-param name="msg" select="'WTSELECT Invalid Attribute'"/>
						  <xsl:with-param name="text" select="name()"/>
	 				</xsl:call-template>
				</xsl:otherwise>
		  </xsl:choose>
	 </xsl:for-each>
	 <!-- ****************************************************-->

		<xsl:value-of select="concat($ind1, 'SELECT')"/>
		<xsl:if test="@top">
			<xsl:value-of select="concat( ' TOP ', @top)"/>
		</xsl:if>
		<xsl:if test="@distinct">
			<xsl:value-of select="' DISTINCT '"/>
		</xsl:if>

		<!--column list-->
		<xsl:apply-templates select="WTATTRIBUTE" mode="fetch">
			<xsl:with-param name="indent" select="$indent"/>
		</xsl:apply-templates>

		<!--from clause-->
		<xsl:apply-templates select="/Data/WTENTITY/WTRELATIONSHIPS/WTRELATIONSHIP[@name=current()/WTJOIN/@name]" mode="from">
			<xsl:with-param name="indent" select="$indent"/>
			<xsl:with-param name="lock" select="(current()/WTJOIN/@lock='true')"/>
		</xsl:apply-templates>

		<!--where clause-->
		<xsl:apply-templates select="." mode="where">
			<xsl:with-param name="indent" select="$indent"/>
		</xsl:apply-templates>

		<!--order by clause-->
		<xsl:apply-templates select="WTORDER">
			<xsl:with-param name="indent" select="$indent"/>
		</xsl:apply-templates>

		<xsl:value-of select="$cr"/>
	</xsl:template>

	<!--==================================================================-->
	<!--==================================================================-->
	<xsl:template match="WTPROCEDURE">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="ind2" select="concat($ind1, $tab1)"/>
		<xsl:variable name="indent2" select="$indent + 1"/>

	 <!-- ***************** Error Checking *******************-->
    <xsl:call-template name="ErrorCheckProcedure"/>
	 <!-- ****************************************************-->

		<xsl:value-of select="concat($ind1, 'EXEC [dbo].', $appprefix, '_CheckProc ', $apos, $appprefix, '_', $entityname, '_', @name, $apos, $cr)"/>
		<xsl:value-of select="concat($ind1, 'GO', $cr, $cr)"/>
		<xsl:value-of select="concat($ind1, 'CREATE PROCEDURE [dbo].', $appprefix, '_', $entityname, '_', @name, $cr)"/>
			
		<!--handle parameters-->
		<xsl:choose>
			<xsl:when test="$hasprocparams">
				<xsl:apply-templates select="WTPARAM">
					<xsl:with-param name="indent" select="$indent2"/>
				</xsl:apply-templates>
			</xsl:when>
			<xsl:otherwise>
				<xsl:variable name="proctype" select="/Data/WTENTITY/WTPROCEDURE/@type"/>
				<xsl:for-each select="/Data/WTENTITY/WTATTRIBUTE">
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
								<xsl:with-param name="precision" select="@precision"/>
							</xsl:call-template>
						</xsl:when>
						<xsl:when test="($dir='OUT')">
							<xsl:call-template name="SQLParam">
								<xsl:with-param name="name" select="concat('ATTR(', @name, ')')"/>
								<xsl:with-param name="type" select="@type"/>
								<xsl:with-param name="length" select="@length"/>
								<xsl:with-param name="precision" select="@precision"/>
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
				
				<xsl:value-of select="$cr"/>
				
			</xsl:otherwise>
		</xsl:choose>

		<xsl:value-of select="concat($ind1, 'AS', $cr, $cr)"/>

		<!--handle declares-->
		<xsl:apply-templates select="WTDECLARE">
			<xsl:with-param name="indent" select="$indent"/>
		</xsl:apply-templates>

		<xsl:value-of select="concat($ind1, 'SET NOCOUNT ON', $cr, $cr)"/>

		<!--handle procedure code-->
		<xsl:apply-templates select="WTCODEGROUP | WTSETVALUE">
			<xsl:with-param name="indent" select="$indent"/>
		</xsl:apply-templates>

		<xsl:value-of select="concat($ind1, 'GO', $cr, $cr)"/>
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
				<xsl:when test="1=0"/>
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
			<xsl:call-template name="SQLConditionStart">
				<xsl:with-param name="indent" select="$indent"/>
				<xsl:with-param name="conditions" select="WTCONDITION"/>
			</xsl:call-template>
		</xsl:if>

		<!--apply child templates-->
		<xsl:apply-templates>
			<xsl:with-param name="indent" select="$indent2"/>
		</xsl:apply-templates>

		<!--close IF statement for conditions if they exist-->
		<xsl:if test="($hasconditions)">
			<xsl:call-template name="SQLConditionEnd">
				<xsl:with-param name="indent" select="$indent"/>			
			</xsl:call-template>
		</xsl:if>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTCUSTOM">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:value-of select="concat($ind1, ., $cr)"/>
		<xsl:if test="@newline"><xsl:value-of select="$cr"/></xsl:if>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTDECLARE">
	<!--==================================================================-->
		<xsl:param name="indent"/>

		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>

	 <!-- ***************** Error Checking *******************-->
	 <xsl:if test="not(@name)">
	     <xsl:call-template name="Error">
	     	<xsl:with-param name="msg" select="'WTDECLARE Name Missing'"/>
	     	<xsl:with-param name="text" select="position()"/>
	     </xsl:call-template>
	 </xsl:if>
	 <!--Test valid attributes-->
	 <xsl:for-each select="@*">
		  <xsl:choose>
				<xsl:when test="name()='name'"/>
				<xsl:when test="name()='datatype'"/>
				<xsl:when test="name()='length'"/>
				<xsl:when test="name()='precision'"/>
				<xsl:otherwise>
					 <xsl:call-template name="Error">
						  <xsl:with-param name="msg" select="'WTDECLARE Invalid Attribute'"/>
						  <xsl:with-param name="text" select="name()"/>
	 				</xsl:call-template>
				</xsl:otherwise>
		  </xsl:choose>
	 </xsl:for-each>
	 <!-- ****************************************************-->

		<xsl:choose>
			<xsl:when test="position()=1"><xsl:value-of select="concat($ind1, 'DECLARE @m', @name, ' ')"/></xsl:when>
			<xsl:otherwise><xsl:value-of select="concat($ind1, $tab3, '@m', @name, ' ')"/></xsl:otherwise>
		</xsl:choose>

		<xsl:call-template name="SQLDataType">
			<xsl:with-param name="datatype" select="@datatype"/>
			<xsl:with-param name="length" select="@length"/>
			<xsl:with-param name="precision" select="@precision"/>
			<xsl:with-param name="language" select="not(@language='false')"/>
		</xsl:call-template>

		<xsl:choose>
			<xsl:when test="position()=last()"><xsl:value-of select="concat($cr, $cr)"/></xsl:when>
			<xsl:otherwise><xsl:value-of select="concat(', ', $cr)"/></xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTERROR">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>

		<!-- ***************** Error Checking *******************-->
		<!--TEST valid attributes-->
		<xsl:for-each select="@*">
			<xsl:choose>
				<xsl:when test="name()='number'"/>
				<xsl:when test="name()='source'"/>
				<xsl:when test="name()='message'"/>
				<xsl:otherwise>
					 <xsl:call-template name="Error">
						  <xsl:with-param name="msg" select="'Invalid WTERROR Attribute'"/>
						  <xsl:with-param name="text" select="name()"/>
	 				</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
		<!-- ****************************************************-->

		<xsl:value-of select="concat($ind1, 'RAISERROR (', $apos, @number, ': ', @message, $apos, ', 16, 1)', $cr)"/>
		<xsl:value-of select="concat($ind1, 'RETURN @@ERROR', $cr)"/>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTPARAM">
	<!--==================================================================-->
		<xsl:param name="indent"/>

		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="nametype"><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="@name"/></xsl:call-template></xsl:variable>
		<xsl:variable name="nametext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@name"/></xsl:call-template></xsl:variable>
		<xsl:variable name="valuetype"><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>
		<xsl:variable name="valuetext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>

	 <!-- ***************** Error Checking *******************-->
    <xsl:call-template name="ErrorCheckParam"/>
	 <!-- ****************************************************-->

		  <xsl:value-of select="$ind1"/>
		  <xsl:call-template name="GetValue">
				<xsl:with-param name="type" select="$nametype"/>
				<xsl:with-param name="text" select="$nametext"/>
				<xsl:with-param name="param" select="true()"/>
		  </xsl:call-template>
		  <xsl:value-of select="' '"/>
		  
		<xsl:variable name="datatype">
		  <xsl:call-template name="GetDataType">
				<xsl:with-param name="type" select="$nametype"/>
				<xsl:with-param name="text" select="$nametext"/>
		  </xsl:call-template>
		</xsl:variable>
		
		<xsl:variable name="datalength">
			<xsl:if test="@length"><xsl:value-of select="@length"/></xsl:if>
			<xsl:if test="not(@length)">
				<xsl:call-template name="GetDataLength">
					<xsl:with-param name="type" select="$nametype"/>
					<xsl:with-param name="text" select="$nametext"/>
				</xsl:call-template>
			</xsl:if>
		</xsl:variable>
		
		<xsl:variable name="dataprecision">
		  <xsl:call-template name="GetDataPrecision">
				<xsl:with-param name="type" select="$nametype"/>
				<xsl:with-param name="text" select="$nametext"/>
		  </xsl:call-template>
		</xsl:variable>

		<xsl:call-template name="SQLDataType">
			<xsl:with-param name="datatype" select="$datatype"/>
			<xsl:with-param name="length" select="$datalength"/>
			<xsl:with-param name="precision" select="$dataprecision"/>
			<xsl:with-param name="language" select="not(@language='false')"/>
		</xsl:call-template>

		<xsl:if test="((@direction = 'output') or (@direction = 'inputoutput'))">
			<xsl:value-of select="(' OUTPUT')"/>
		</xsl:if>

		<xsl:if test="position() != last()">
			<xsl:value-of select="' ,'"/>
		</xsl:if>

		<xsl:value-of select="$cr"/>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTPARAM" mode="childproc">
	<!--==================================================================-->
		<xsl:param name="indent"/>

		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="valuetype"><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>
		<xsl:variable name="valuetext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>

	 <!-- ***************** Error Checking *******************-->
    <xsl:call-template name="ErrorCheckParam"/>
	 <!-- ****************************************************-->

		<xsl:variable name="output" select="@direction='output' or @direction='inputoutput'"/>

		<xsl:choose>
			<xsl:when test="$output"><xsl:value-of select="concat($ind1, '@m', @name)"/></xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$ind1"/>
				<xsl:call-template name="GetValue">
					<xsl:with-param name="type" select="$valuetype"/>
					<xsl:with-param name="text" select="$valuetext"/>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>

		<xsl:if test="$output"><xsl:value-of select="(' OUTPUT')"/></xsl:if>

		<xsl:if test="position()!=last()">
			<xsl:value-of select="concat(' ,', $cr)"/>
		</xsl:if>
		
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTCODEGROUP/WTPROCEDURE">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="ind2" select="concat($ind1, $tab3)"/>
		<xsl:variable name="indent2" select="$indent + 3"/>

	 <!-- ***************** Error Checking *******************-->
    <xsl:call-template name="ErrorCheckProcedure"/>
	 <!-- ****************************************************-->

		<xsl:value-of select="concat($ind1, 'EXEC ', $appprefix, '_', @name, $cr)"/>

		<!--handle parameters-->
		<xsl:apply-templates mode="childproc">
			<xsl:with-param name="indent" select="$indent + 1"/>
		</xsl:apply-templates>

		<xsl:value-of select="concat($cr, $cr)"/>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTCONDITION" mode="dotest">
	<!--==================================================================-->
		<xsl:param name="indent"/>

		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="exprtype"><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="@expr"/></xsl:call-template></xsl:variable>
		<xsl:variable name="exprtext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@expr"/></xsl:call-template></xsl:variable>
		<xsl:variable name="exprentity"><xsl:call-template name="QualifiedPrefix"><xsl:with-param name="value" select="@expr"/></xsl:call-template></xsl:variable>
		<xsl:variable name="valuetype"><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>
		<xsl:variable name="valuetext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>
		<xsl:variable name="valueentity"><xsl:call-template name="QualifiedPrefix"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>

	 <!-- ***************** Error Checking *******************-->
	<xsl:if test="$exprtype!='NONE'">
		  <xsl:if test="$valuetext=''">
		      <xsl:call-template name="Error">
		      	<xsl:with-param name="msg" select="'WTCONDITION Value Missing'"/>
		      	<xsl:with-param name="text" select="$exprtext"/>
		      </xsl:call-template>
		  </xsl:if>
		  <xsl:if test="@connecter='' and position()&gt;1">
		      <xsl:call-template name="Error">
		      	<xsl:with-param name="msg" select="'WTCONDITION Connector Missing'"/>
		      	<xsl:with-param name="text" select="$exprtext"/>
		      </xsl:call-template>
		  </xsl:if>
	</xsl:if>
	 <!--Test valid attributes-->
	 <xsl:for-each select="@*">
		  <xsl:choose>
				<xsl:when test="name()='expr'"/>
				<xsl:when test="name()='oper'"/>
				<xsl:when test="name()='value'"/>
				<xsl:when test="name()='connector'"/>
				<xsl:when test="name()='exprfunc'"/>
				<xsl:when test="name()='valuefunc'"/>
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

		<xsl:if test="$indent">
			<xsl:value-of select="$ind1"/>
		</xsl:if>

		<!--add the connector-->
		<xsl:choose>
			<xsl:when test="(@connector='and')"> AND </xsl:when>
			<xsl:when test="(@connector='or')"> OR </xsl:when>
		</xsl:choose>

		<!--start opening parenthesis-->
		<xsl:if test="@paren='start'">
			<xsl:value-of select="'('"/>
		</xsl:if>
		<xsl:if test="@paren='start2'">
			<xsl:value-of select="'(('"/>
		</xsl:if>

		<!--enclose the test in parenthesis-->
		<xsl:value-of select="('(')"/>

		<!--enclose the exprfunc in parenthesis-->
		<xsl:if test="(@exprfunc)">
			<xsl:value-of select="concat('dbo.', @exprfunc, '(')"/>
		</xsl:if>

		  <xsl:variable name="compute" select="count(/Data/WTENTITY/WTATTRIBUTE[(@name=$exprtext) and WTCOMPUTE])&gt;0"/>

		  <xsl:call-template name="GetValue">
				<xsl:with-param name="type" select="$exprtype"/>
				<xsl:with-param name="text" select="$exprtext"/>
				<xsl:with-param name="entity" select="$exprentity"/>
				<xsl:with-param name="join" select="../WTJOIN/@name"/>
				<xsl:with-param name="compute" select="$compute"/>
				<xsl:with-param name="columnalias" select="false()"/>
				<xsl:with-param name="proctype" select="Fetch"/>
		  </xsl:call-template>

		<!--enclose the exprfunc in parenthesis-->
		<xsl:if test="(@exprfunc)">
			<xsl:value-of select="(')')"/>
		</xsl:if>

		<!--handle the operator-->
		  <xsl:call-template name="GetOperator">
				<xsl:with-param name="oper" select="@oper"/>
		  </xsl:call-template>

		<!--enclose the valuefunc in parenthesis-->
		<xsl:if test="(@valuefunc)">
			<xsl:value-of select="concat('dbo.', @valuefunc, '(')"/>
		</xsl:if>

		<xsl:if test="(@oper='contains') or (@oper='not-contains')">
			<xsl:value-of select="' + '"/>
		</xsl:if>

		<!--handle the value-->
		  <xsl:call-template name="GetValue">
				<xsl:with-param name="type" select="$valuetype"/>
				<xsl:with-param name="text" select="$valuetext"/>
				<xsl:with-param name="entity" select="$valueentity"/>
				<xsl:with-param name="join" select="../WTJOIN/@name"/>
		  </xsl:call-template>

		<!--enclose the valuefunc in parenthesis-->
		<xsl:if test="(@valuefunc)">
			<xsl:value-of select="(')')"/>
		</xsl:if>

		<xsl:if test="(@oper='starts') or (@oper='contains') or (@oper='not-contains')">
			<xsl:value-of select="concat(' + ', $apos, '%', $apos )"/>
		</xsl:if>

		<!--enclose the test in parenthesis-->
		<xsl:value-of select="(')')"/>

		<!--end closing parenthesis-->
		<xsl:if test="@paren='end'">
			<xsl:value-of select="')'"/>
		</xsl:if>
		<xsl:if test="@paren='end2'">
			<xsl:value-of select="'))'"/>
		</xsl:if>

	</xsl:template>

	<!--==================================================================-->
	<xsl:template name="SQLConditionStart">
	<!--==================================================================-->
		<xsl:param name="conditions"/>
		<xsl:param name="indent"/>

		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="ind2" select="concat($ind1, $tab1)"/>
		<xsl:variable name="indent2" select="$indent + 1"/>

		<!--start the IF statement-->
		<xsl:value-of select="concat($ind1, 'IF (')"/>

		<!--process each condition-->
		<xsl:apply-templates select="$conditions" mode="dotest"/>

		<!--end the IF statement-->
		<xsl:value-of select="concat($ind1, ')', $cr)"/>
		<xsl:value-of select="concat($ind2, 'BEGIN', $cr)"/>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template name="SQLConditionEnd">
	<!--==================================================================-->
		<xsl:param name="indent"/>

		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="ind2" select="concat($ind1, $tab1)"/>
		<xsl:variable name="indent2" select="$indent + 1"/>

		<xsl:value-of select="concat($ind2, 'END', $cr, $cr)"/>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: SQL ATTRIBUTE -->
	<!-- outputs a column within a SQL statement with {column 'alias'} syntax -->
	<!--==================================================================-->
	<xsl:template name="SQLAttribute">
		<xsl:param name="proctype"/>
		<xsl:param name="procjoin"/>
		<xsl:param name="sqlattribute"/>
		<xsl:param name="position">0</xsl:param>
		<xsl:param name="continue" select="true()"/>

		<!--parse the name and value attribute-->
		<xsl:variable name="valuetype"><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="$sqlattribute/@value"/></xsl:call-template></xsl:variable>
		<xsl:variable name="valuetext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="$sqlattribute/@value"/></xsl:call-template></xsl:variable>
		<xsl:variable name="valueprefix"><xsl:call-template name="QualifiedPrefix"><xsl:with-param name="value" select="$sqlattribute/@value"/></xsl:call-template></xsl:variable>

		<xsl:choose>
			<xsl:when test="($position='1')"><xsl:value-of select="$tab3"/></xsl:when>
			<xsl:otherwise><xsl:value-of select="$tab4"/></xsl:otherwise>
		</xsl:choose>

		  <xsl:call-template name="GetValue">
				<xsl:with-param name="type" select="$valuetype"/>
				<xsl:with-param name="text" select="$valuetext"/>
				<xsl:with-param name="entity" select="$valueprefix"/>
				<xsl:with-param name="join" select="$procjoin"/>
				<xsl:with-param name="compute" select="true()"/>
				<xsl:with-param name="proctype" select="$proctype"/>
		  </xsl:call-template>

		<xsl:if test="($continue)"><xsl:value-of select="concat($tab0, ' ,')"/></xsl:if>
		<xsl:value-of select="$cr"/>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: SQL COLUMN ALIAS -->
	<!-- returns the alias for a column name in a SQL statement-->
	<!--==================================================================-->
	<xsl:template name="SQLColumnAlias">
		<xsl:param name="name"/>
		<xsl:param name="proctype"/>

		<xsl:variable name="attr" select="/Data/WTENTITY/WTATTRIBUTE[@name=$name]"/>
		<xsl:choose>
			<xsl:when test="($proctype='Enum') and ($attr/@identity='true')"><xsl:value-of select="concat(' ', $apos, 'ID', $apos)"/></xsl:when>
			<xsl:when test="($proctype='Enum')"><xsl:value-of select="concat(' ', $apos, 'Name', $apos)"/></xsl:when>
			<xsl:otherwise><xsl:value-of select="concat(' ', $apos, $name, $apos)"/></xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: SQL COLUMN BOOKMARK -->
	<!-- returns the sql for the bookmark field-->
	<!--==================================================================-->
	<xsl:template name="SQLColumnBookmark">
		<xsl:param name="name"/>
		<xsl:param name="order"/>
		<xsl:param name="proctype"/>
		<xsl:param name="columnalias"/>

		<xsl:call-template name="SQLColumnSearchText">
			<xsl:with-param name="name" select="$name"/>
			<xsl:with-param name="proctype" select="$proctype"/>
		</xsl:call-template>

		<xsl:if test="$order != ''">
			<xsl:value-of select="' + '"/>
			<xsl:call-template name="SQLColumnSearchText">
				<xsl:with-param name="name" select="$order"/>
				<xsl:with-param name="proctype" select="$proctype"/>
			</xsl:call-template>
		</xsl:if>

		<xsl:value-of select="' + dbo.wtfn_FormatNumber('"/>
		<xsl:call-template name="SQLColumnValue">
			<xsl:with-param name="name" select="/Data/WTENTITY/WTATTRIBUTE[@identity='true']/@name"/>
			<xsl:with-param name="columnalias" select="false()"/>
			<xsl:with-param name="proctype" select="$proctype"/>
		</xsl:call-template>
		<xsl:value-of select="', 10)'"/>

		<xsl:if test="($columnalias)">
			<xsl:value-of select="concat(' ', $apos, 'BookMark', $apos)"/>
		</xsl:if>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: SQL COLUMN NAME -->
	<!-- returns the name of the sql table alias and column name -->
	<!--==================================================================-->
	<xsl:template name="SQLColumnName">
		<xsl:param name="name"/>
		<xsl:param name="proctype"/>
		<xsl:param name="columnalias" select="true()"/>
		<xsl:param name="joinname"/>

		<!--if the entity doesn't have a JOIN child then use entity's alias and the name of the attribute as the column-->
		<!--otherwise, get the relationship record that matches the entity on the JOIN element and use that alias-->
		<!--and use the name on the JOIN as the column name-->

		<xsl:variable name="procjoin">
			<xsl:choose>
				<xsl:when test="$joinname"><xsl:value-of select="$joinname"/></xsl:when>
				<xsl:otherwise><xsl:value-of select="/Data/WTENTITY/WTPROCEDURE/WTJOIN/@name"/></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="join" select="/Data/WTENTITY/WTATTRIBUTE[@name=$name]/WTJOIN/@entity"/>
		<xsl:variable name="relationship" select="/Data/WTENTITY/WTRELATIONSHIPS/WTRELATIONSHIP[@name=$procjoin]"/>
		<xsl:variable name="attribute" select="/Data/WTENTITY/WTATTRIBUTE[@name=$name]"/>

	   <xsl:variable name="attr">
		   <xsl:call-template name="SQLReserved"><xsl:with-param name="ReservedWord" select="$name"/></xsl:call-template>
	   </xsl:variable>

		<xsl:choose>

			<!--Add with templates works like init-->
			<xsl:when test="($parentfields[@name=$name]) and ($proctype='Add') and ($hastemplate)">
				<xsl:value-of select="($relationship/WTENTITY[@name=$parentname]/@alias)"/>
				<xsl:value-of select="concat('.', $attr)"/>
			</xsl:when>
			<xsl:when test="($attribute/WTINIT[@type='template']) and ($proctype='Add') and ($hastemplate)">
				<xsl:value-of select="($relationship/@alias)"/>
				<xsl:value-of select="concat('.', $attr)"/>
			</xsl:when>
			<xsl:when test="($procparams[@name=$name]) and ($proctype='Add') and ($hastemplate)">
				<xsl:value-of select="($relationship/@alias)"/>
				<xsl:value-of select="concat('.', $attr)"/>
			</xsl:when>
			<!--Init procs need to alias a parent foreign key with the parent table's alias-->
			<xsl:when test="($parentfields[@name=$name]) and ($proctype='Init')">
				<xsl:value-of select="($relationship/WTENTITY[@name=$parentname]/@alias)"/>
				<xsl:value-of select="concat('.', $attr)"/>
			</xsl:when>
			<xsl:when test="($attribute/WTINIT[(@type='constant' or @type='system') and not(@template)]) and ($proctype='Init')">
				<xsl:value-of select="concat('@m', $name)"/>
			</xsl:when>
			<xsl:when test="($join)">
				<xsl:variable name="jattr">
				   <xsl:call-template name="SQLReserved"><xsl:with-param name="ReservedWord" select="$attribute/WTJOIN/@name"/></xsl:call-template>
				</xsl:variable>
				<xsl:value-of select="($relationship/WTENTITY[@name=$join]/@alias)"/>
				<xsl:value-of select="concat('.', $jattr)"/>
			</xsl:when>
			<xsl:when test="($proctype='Init')">
				<xsl:value-of select="($relationship/@alias)"/>
				<xsl:value-of select="concat('.', $attr)"/>
			</xsl:when>
			<!--Init procs need attributes intialized with a template to alias the template-->
			<xsl:when test="($relationship/@entity=$entityname)">
				<xsl:value-of select="($relationship/@alias)"/>
				<xsl:value-of select="concat('.', $attr)"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="($relationship/WTENTITY[@name=$entityname]/@alias)"/>
				<xsl:value-of select="concat($entityalias, '.', $attr)"/>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:if test="($columnalias)">
			<xsl:call-template name="SQLColumnAlias">
				<xsl:with-param name="name" select="$attr"/>
				<xsl:with-param name="proctype" select="$proctype"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: SQL COLUMN SEARCH TEXT -->
	<!-- returns the sql for the search text parameter to a bookmark stored procedure-->
	<!--==================================================================-->
	<xsl:template name="SQLColumnSearchText">
		<xsl:param name="name"/>
		<xsl:param name="proctype"/>

		  <xsl:variable name="attr" select="/Data/WTENTITY/WTATTRIBUTE[@name=$name]"/>
		  <xsl:variable name="value">
				<xsl:call-template name="SQLColumnValue">
					 <xsl:with-param name="name" select="$name"/>
					 <xsl:with-param name="columnalias" select="false()"/>
					 <xsl:with-param name="proctype" select="$proctype"/>
				</xsl:call-template>
		  </xsl:variable>

		<xsl:choose>
			<xsl:when test="$attr/@type='date'">
				<xsl:value-of select="concat($tab0, 'ISNULL(CONVERT(nvarchar(10), ')"/>
				<xsl:value-of select="concat($value, ', 112), ', $apos, $apos, ')')"/>
			</xsl:when>

			<xsl:when test="$attr/@type='number'">
				<xsl:value-of select="concat($tab0, 'ISNULL(CONVERT(nvarchar(10), ')"/>
				<xsl:value-of select="concat($value, '), ', $apos, $apos, ')')"/>
			</xsl:when>
			<xsl:when test="$attr/@type='currency'">
				<xsl:value-of select="concat($tab0, 'ISNULL(CONVERT(nvarchar(15), ')"/>
				<xsl:value-of select="concat($value, '), ', $apos, $apos, ')')"/>
			</xsl:when>

			<xsl:otherwise>
				<xsl:value-of select="concat($tab0, 'ISNULL(')"/>
				<xsl:value-of select="concat($value, ', ', $apos, $apos, ')')"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: SQL COLUMN SELECT -->
	<!-- outputs a column within a SQL statement with {column 'alias'} systax -->
	<!--==================================================================-->
	<xsl:template name="SQLColumnSelect">
		<xsl:param name="proctype"/>
		<xsl:param name="name"/>
		<xsl:param name="columnalias" select="true()"/>
		<xsl:param name="position">0</xsl:param>
		<xsl:param name="continue" select="true()"/>

		<xsl:choose>
			<xsl:when test="($position='1')"><xsl:value-of select="$tab3"/></xsl:when>
			<xsl:otherwise><xsl:value-of select="($tab4)"/></xsl:otherwise>
		</xsl:choose>

		<!--output the column-->
		<xsl:call-template name="SQLColumnValue">
			<xsl:with-param name="name" select="$name"/>
			<xsl:with-param name="proctype" select="$proctype"/>
			<xsl:with-param name="columnalias" select="$columnalias"/>
		</xsl:call-template>

		<xsl:if test="($continue)"><xsl:value-of select="concat($tab0, ' ,')"/></xsl:if>
		<xsl:value-of select="$cr"/>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: SQL COLUMN SET -->
	<!-- outputs a column within a SQL statement with {column = value} systax -->
	<!--==================================================================-->
	<xsl:template name="SQLColumnSet">
		<xsl:param name="proctype"/>
		<xsl:param name="name"/>
		<xsl:param name="colname"/>
		<xsl:param name="colvalue"/>
		<xsl:param name="position">0</xsl:param>
		<xsl:param name="continue" select="true()"/>
		<xsl:param name="newline" select="true()"/>

		<!--include SET command on first column-->
		<xsl:choose>
			<xsl:when test="($proctype='Update') and ($position='1')"><xsl:value-of select="'SET '"/></xsl:when>
			<xsl:when test="($position='1')"><xsl:value-of select="$tab1"/></xsl:when>
			<xsl:otherwise><xsl:value-of select="($tab1)"/></xsl:otherwise>
		</xsl:choose>

		<!--calculate code for column name-->
		<xsl:variable name="cname">
			<xsl:choose>
				<xsl:when test="($colname)"><xsl:value-of select="$colname"/></xsl:when>
				<xsl:when test="($proctype='Update')">
					<xsl:call-template name="SQLColumnName">
						<xsl:with-param name="name" select="$name"/>
						<xsl:with-param name="proctype" select="$proctype"/>
						<xsl:with-param name="columnalias" select="false()"/>
					</xsl:call-template>
				</xsl:when>
				<xsl:otherwise><xsl:value-of select="concat('@', $name)"/></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<!--calculate code for column value-->
		<xsl:variable name="cvalue">
			<xsl:choose>
				<xsl:when test="($colvalue)"><xsl:value-of select="$colvalue"/></xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="SQLColumnValue">
						<xsl:with-param name="name" select="$name"/>
						<xsl:with-param name="proctype" select="$proctype"/>
						<xsl:with-param name="columnalias" select="false()"/>
					</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<!--output the SQL-->
	   <xsl:variable name="attr">
		   <xsl:call-template name="SQLReserved"><xsl:with-param name="ReservedWord" select="$cvalue"/></xsl:call-template>
	   </xsl:variable>
		<xsl:value-of select="concat($cname, ' = ', $attr)"/>
		<xsl:if test="($continue)"><xsl:value-of select="concat($tab0, ' ,')"/></xsl:if>
		<xsl:if test="($newline)"><xsl:value-of select="$cr"/></xsl:if>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: SQL COLUMN VALUE -->
	<!-- outputs the SQL to select the value for column within a SQL statement -->
	<!--==================================================================-->
	<xsl:template name="SQLColumnValue">
		<xsl:param name="name"/>
		<xsl:param name="columnalias" select="true()"/>
		<xsl:param name="proctype"/>
		<xsl:param name="joinname"/>

		<xsl:variable name="attr" select="/Data/WTENTITY/WTATTRIBUTE[@name=$name]"/>

		<xsl:choose>
			<xsl:when test="($proctype='Add') and ($hastemplate)">
				<xsl:choose>
					<!--alias template intialized fields with the alias for the template entity-->
					<xsl:when test="$attr/WTINIT[@type='template']">
						<xsl:call-template name="SQLColumnName">
							<xsl:with-param name="name" select="$name"/>
							<xsl:with-param name="proctype" select="$proctype"/>
							<xsl:with-param name="columnalias" select="false()"/>
						</xsl:call-template>
					</xsl:when>
					<xsl:when test="$attr/WTINIT"><xsl:value-of select="concat('@m', $name)"/></xsl:when>
					<xsl:otherwise><xsl:value-of select="concat('@', $name)"/></xsl:otherwise>
				</xsl:choose>
			</xsl:when>

			<xsl:when test="($proctype='Add')">
				<xsl:choose>
					<xsl:when test="$attr/WTINIT"><xsl:value-of select="concat('@m', $name)"/></xsl:when>
					<xsl:otherwise><xsl:value-of select="concat('@', $name)"/></xsl:otherwise>
				</xsl:choose>
			</xsl:when>

			<xsl:when test="($proctype='Init')">
				<xsl:choose>
					<!--alias any parent foreign keys with the parent's alias-->
					<xsl:when test="($parentfields[@name=$name])">
						<xsl:call-template name="SQLColumnName">
							<xsl:with-param name="name" select="$name"/>
							<xsl:with-param name="proctype" select="$proctype"/>
							<xsl:with-param name="columnalias" select="false()"/>
						</xsl:call-template>
					</xsl:when>
					<!--alias all other fields with template's alias-->
					<xsl:otherwise>
						<xsl:call-template name="SQLColumnName">
							<xsl:with-param name="name" select="$name"/>
							<xsl:with-param name="proctype" select="$proctype"/>
							<xsl:with-param name="columnalias" select="false()"/>
						</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>

			<xsl:when test="($proctype='Update')">
				<xsl:value-of select="concat('@', $name)"/>
			</xsl:when>

			<xsl:when test="not($attr/WTCOMPUTE)">
				<xsl:call-template name="SQLColumnName">
					<xsl:with-param name="name" select="$name"/>
					<xsl:with-param name="proctype" select="$proctype"/>
					<xsl:with-param name="columnalias" select="$columnalias"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:for-each select="$attr/WTCOMPUTE">
					<xsl:choose>
						<xsl:when test="(@text)">
							<xsl:value-of select="concat(' ', $apos, @text, $apos, ' ')"/>
						</xsl:when>
						<xsl:when test="(@custom)">
							<xsl:value-of select="concat(' ', @custom, ' ')"/>
						</xsl:when>
						<xsl:when test="(@convert)">
							<xsl:value-of select="concat('CONVERT(', @convert, ', ')"/>
							<xsl:call-template name="SQLColumnName">
								<xsl:with-param name="name" select="@name"/>
								<xsl:with-param name="proctype" select="$proctype"/>
								<xsl:with-param name="columnalias" select="false()"/>
								<xsl:with-param name="joinname" select="$joinname"/>
							</xsl:call-template>
							<xsl:value-of select="(')')"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="('LTRIM(RTRIM(')"/>
							<xsl:call-template name="SQLColumnName">
								<xsl:with-param name="name" select="@name"/>
								<xsl:with-param name="proctype" select="$proctype"/>
								<xsl:with-param name="columnalias" select="false()"/>
								<xsl:with-param name="joinname" select="$joinname"/>
							</xsl:call-template>
							<xsl:value-of select="('))')"/>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:if test="(position() != last())"><xsl:value-of select="concat($tab0, ' + ')"/></xsl:if>
				</xsl:for-each>
				<xsl:if test="($columnalias)">
					<xsl:call-template name="SQLColumnAlias">
						<xsl:with-param name="name" select="$name"/>
						<xsl:with-param name="proctype" select="$proctype"/>
					</xsl:call-template>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: SQL COMMENT -->
	<!-- outputs a comment line -->
	<!--==================================================================-->
	<xsl:template name="SQLComment">
		<xsl:param name="value"/>
		<xsl:param name="indent"/>
	
		<xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template>
		<xsl:value-of select="concat('--', $value, $cr)"/>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: SQL CONDITION TEST-->
	<!-- returns the SQL for a single test within a condition -->
	<!--==================================================================-->
	<xsl:template name="SQLConditionTest">
		<xsl:param name="condition"/>
		<xsl:param name="isfirst"/>
		<xsl:param name="proctype"/>
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
					
					<xsl:if test="not($condition/@connector='' or $condition/@connector='and' or $condition/@connector='or')">
					    <xsl:call-template name="Error">
					    	<xsl:with-param name="msg" select="'WTCONDITION Operator Invalid'"/>
					    	<xsl:with-param name="text" select="$condition/@connector"/>
					    </xsl:call-template>
					</xsl:if>
					</xsl:when>
				<xsl:otherwise></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:choose>
			<xsl:when test="($exprtype='NONE')">
				<!--==========the condition is a WTCONDITION node reference so call this routine recursively for each of its child conditions==========-->
				<xsl:for-each select="(/Data/WTENTITY/WTCONDITIONS/WTCONDITION[@name=$exprtext]/WTCONDITION)">
					<xsl:call-template name="SQLConditionTest">
						<xsl:with-param name="condition" select="."/>					
						<xsl:with-param name="proctype" select="$proctype"/>					
						<xsl:with-param name="isfirst" select="$isfirst"/>
						<xsl:with-param name="connector" select="$connect"/>
					</xsl:call-template>
				</xsl:for-each>
			</xsl:when>
			<xsl:otherwise>

				<!--==========add the connector==========-->
				<xsl:if test="not($isfirst)">
					<xsl:call-template name="CaseUpper">
						<xsl:with-param name="value" select="$connect"/>
					</xsl:call-template>
					<xsl:value-of select="$tab3"/>
				</xsl:if>

				<!--start opening parenthesis-->
				<xsl:if test="$condition/@paren='start'">
					<xsl:value-of select="'('"/>
				</xsl:if>

				<!--==========enclose the test in parenthesis==========-->
				<xsl:value-of select="concat($tab0,'(')"/>

				<!--==========handle the expression==========-->
				<xsl:call-template name="GetValue">
					<xsl:with-param name="type" select="$exprtype"/>
					<xsl:with-param name="text" select="$exprtext"/>
					<xsl:with-param name="compute" select="true()"/>
					<xsl:with-param name="proctype" select="$proctype"/>
					<xsl:with-param name="columnalias" select="false()"/>
				</xsl:call-template>

				<!--==========handle the operator==========-->
				<xsl:call-template name="GetOperator">
					<xsl:with-param name="oper" select="$opertext"/>
				</xsl:call-template>

				<!--==========handle the value==========-->
				<xsl:call-template name="GetValue">
					<xsl:with-param name="type" select="$valuetype"/>
					<xsl:with-param name="text" select="$valuetext"/>
					<xsl:with-param name="compute" select="true()"/>
					<xsl:with-param name="proctype" select="$proctype"/>
					<xsl:with-param name="columnalias" select="false()"/>
				</xsl:call-template>

				<xsl:if test="(@oper='starts') or (@oper='contains') or (@oper='not-contains')">
					<xsl:value-of select="concat(' + ', $apos, '%', $apos )"/>
				</xsl:if>

				<!--==========enclose the test in parenthesis==========-->
				<xsl:value-of select="')'"/>

				<!--end closing parenthesis-->
				<xsl:if test="$condition/@paren='end'">
					<xsl:value-of select="')'"/>
				</xsl:if>

				<xsl:value-of select="$cr"/>

			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: SQL DATA TYPE -->
	<!-- returns the native SQL server data type declaration -->
	<!--==================================================================-->
	<xsl:template name="SQLDataType">
		<xsl:param name="datatype"/>
		<xsl:param name="length"/>
		<xsl:param name="precision"/>
		<xsl:param name="language" select="true()"/>

		<xsl:choose>
		  <xsl:when test="($datatype='char')">nchar</xsl:when>
		  <xsl:when test="($datatype='text' and $language)">nvarchar</xsl:when>
		  <xsl:when test="($datatype='text' and not($language))">varchar</xsl:when>
      <xsl:when test="($datatype='big number')">bigint</xsl:when>
      <xsl:when test="($datatype='number')">int</xsl:when>
      <xsl:when test="($datatype='small number')">smallint</xsl:when>
		  <xsl:when test="($datatype='tiny number')">tinyint</xsl:when>
		  <xsl:when test="($datatype='decimal')">decimal</xsl:when>
		  <xsl:when test="($datatype='date')">datetime</xsl:when>
		  <xsl:when test="($datatype='time')">smallint</xsl:when>
		  <xsl:when test="($datatype='currency')">money</xsl:when>
		  <xsl:when test="($datatype='yesno')">bit</xsl:when>
		  <xsl:when test="($datatype='password')">nvarchar</xsl:when>
		</xsl:choose>

		
		<xsl:choose>
			<xsl:when test="($datatype='decimal')">
				<xsl:if test="($length != '') and ($precision != '')">
					<xsl:value-of select="concat(' (', $length, ', ', $precision, ')')"/>
				</xsl:if>
			</xsl:when>
			<xsl:otherwise>
				<xsl:if test="($length != '')">
					<xsl:value-of select="concat(' (', $length, ')')"/>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
		
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: SQL DECLARE -->
	<!-- outputs a DECLARE statement -->
	<!--==================================================================-->
	<xsl:template name="SQLDeclare">
		<xsl:param name="name"/>
		<xsl:param name="type"/>
		<xsl:param name="length"/>
		<xsl:param name="precision"/>

		<xsl:variable name="dtype">
			<xsl:call-template name="SQLDataType">
				<xsl:with-param name="datatype" select="$type"/>
				<xsl:with-param name="length" select="$length"/>
				<xsl:with-param name="precision" select="$precision"/>
				<xsl:with-param name="language" select="not(@language='false')"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:value-of select="concat('DECLARE ', $name, ' ', $dtype, $cr)"/>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: SQL FROM -->
	<!-- generate the FROM clause for a SQL stored procedure -->
	<!--==================================================================-->
	<xsl:template name="SQLFrom">
		<xsl:param name="proctype"/>
		<xsl:param name="nolock" select="true()"/>

		<!-- base table-->
		<xsl:choose>
			<xsl:when test="$proctype='Add' and not($hastemplate)"></xsl:when>
			<xsl:when test="$proctype='Copy'">
				<xsl:value-of select="concat('FROM ', $SQLentityname, ' AS ', $entityalias, $cr)"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:variable name="procjoin" select="/Data/WTENTITY/WTPROCEDURE/WTJOIN/@name"/>
				<xsl:variable name="basetable" select="/Data/WTENTITY/WTRELATIONSHIPS/WTRELATIONSHIP[@name=$procjoin]/@entity"/>
				<xsl:variable name="basealias" select="/Data/WTENTITY/WTRELATIONSHIPS/WTRELATIONSHIP[@name=$procjoin]/@alias"/>
				<xsl:choose>
					<xsl:when test="$basetable">
						<xsl:variable name="SQLtable">
						   <xsl:call-template name="SQLReserved"><xsl:with-param name="ReservedWord" select="$basetable"/></xsl:call-template>
						</xsl:variable>
						<xsl:value-of select="concat('FROM ', $SQLtable, ' AS ', $basealias)"/>
						<xsl:if test="($nolock)"><xsl:value-of select="(' (NOLOCK)')"/></xsl:if>
						<xsl:value-of select="$cr"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="concat('FROM ', $SQLentityname, ' AS ', $entityalias)"/>
						<xsl:if test="($nolock)"><xsl:value-of select="(' (NOLOCK)')"/></xsl:if>
						<xsl:value-of select="$cr"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>

		<!-- joined tables-->
		<xsl:variable name="joins" select="/Data/WTENTITY/WTPROCEDURE/WTJOIN/@name"/>
		<xsl:for-each select="/Data/WTENTITY/WTRELATIONSHIPS/WTRELATIONSHIP[@name=$joins]/WTENTITY">
			<xsl:variable name="entity">
			   <xsl:call-template name="SQLReserved"><xsl:with-param name="ReservedWord" select="@entity"/></xsl:call-template>
			</xsl:variable>
			<xsl:choose>
				<xsl:when test="(@join='inner')"><xsl:value-of select="concat('INNER JOIN ', $entity, ' AS ', @alias)"/></xsl:when>
				<xsl:otherwise><xsl:value-of select="concat('LEFT OUTER JOIN ', $entity, ' AS ', @alias)"/></xsl:otherwise>
			</xsl:choose>
			<xsl:if test="($nolock)"><xsl:value-of select="(' (NOLOCK)')"/></xsl:if>
			<xsl:value-of select="(' ON (')"/>
			<xsl:for-each select="WTATTRIBUTE">
				<xsl:if test="@connector"><xsl:value-of select="concat(' ', @connector, ' ')"/></xsl:if>
				<xsl:variable name="relaliasname">
					<xsl:if test="@relalias">
						<xsl:value-of select="concat(@relalias, '.', @relname)"/>
					</xsl:if>
					<xsl:if test="not(@relalias)">
						<xsl:value-of select="@relname"/>
					</xsl:if>
				</xsl:variable>
				<xsl:if test="@alias">
					<xsl:value-of select="concat(@alias, '.', @name, ' = ', $relaliasname)"/>
				</xsl:if>
				<xsl:if test="not(@alias)">
					<xsl:value-of select="concat( @name, ' = ', $relaliasname)"/>
				</xsl:if>
			</xsl:for-each>
			<xsl:value-of select="concat(')', $cr)"/>
		</xsl:for-each>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: SQL NESTED PROC -->
	<!-- outputs the SQL script to call another stored procedure -->
	<!--==================================================================-->
	<xsl:template name="SQLNestedProc">
		<xsl:param name="name"/>
		<xsl:param name="indent"/>
	
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="proc" select="/Data/WTENTITY/WTPROCEDURES/WTPROCEDURE[@name=$name]"/>
		<xsl:value-of select="concat($ind1, 'EXEC ', $appprefix, '_', $proc/@proc, $cr)"/>

		<xsl:for-each select="$proc/WTPARAM">
			<xsl:choose>
				<xsl:when test="@direction='input'">
					<xsl:call-template name="SQLSelect">
						<xsl:with-param name="name" select="concat('@', @value)"/>
						<xsl:with-param name="continue" select="(position() != last())"/>
					</xsl:call-template>
				</xsl:when>
				<xsl:when test="((@direction = 'output') or (@direction = 'inputoutput'))">
					<xsl:call-template name="SQLSelect">
						<xsl:with-param name="name" select="concat('@m', @value, ' OUTPUT')"/>
						<xsl:with-param name="continue" select="(position() != last())"/>
					</xsl:call-template>
				</xsl:when>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: SQL ORDER BY -->
	<!-- outputs an ORDER BY clause for a SQL procedure -->
	<!--==================================================================-->
	<xsl:template name="SQLOrderBy">
		<xsl:param name="name"/>
		<xsl:param name="dir"/>
		<xsl:param name="proctype"/>
		<xsl:param name="position">0</xsl:param>
		<xsl:param name="continue" select="true()"/>

		<xsl:choose>
			<xsl:when test="($proctype='Enum')">
				<xsl:value-of select="'ORDER BY '"/>
				<xsl:call-template name="SQLColumnValue">
					<xsl:with-param name="name" select="$name"/>
					<xsl:with-param name="proctype" select="$proctype"/>
					<xsl:with-param name="columnalias" select="false()"/>
				</xsl:call-template>
				<xsl:value-of select="$cr"/>
			</xsl:when>

			<xsl:when test="$hasbookmark">
				<xsl:if test="count(/Data/WTENTITY/WTPROCEDURE/WTBOOKMARK/WTORDER)=0">
					<xsl:value-of select="concat('ORDER BY ', $apos, 'Bookmark', $apos)"/>
					<xsl:if test="/Data/WTENTITY/WTATTRIBUTE[@name=$name]/@type='date'">
						<xsl:value-of select="' DESC'"/>
					</xsl:if>
					<xsl:value-of select="$cr"/>
				</xsl:if>
				<xsl:if test="count(/Data/WTENTITY/WTPROCEDURE/WTBOOKMARK/WTORDER)>0">
					<xsl:value-of select="'ORDER BY '"/>
					<!-- start order with search field -->
					<xsl:call-template name="SQLColumnValue">
						<xsl:with-param name="name" select="$name"/>
						<xsl:with-param name="columnalias" select="false()"/>
						<xsl:with-param name="proctype" select="$proctype"/>
					</xsl:call-template>
					<xsl:value-of select="', '"/>
					<!-- get extra order by fields -->
					<xsl:for-each select="/Data/WTENTITY/WTPROCEDURE/WTBOOKMARK/WTORDER">
						<xsl:call-template name="SQLColumnValue">
							<xsl:with-param name="name" select="@name"/>
							<xsl:with-param name="columnalias" select="false()"/>
							<xsl:with-param name="proctype" select="$proctype"/>
						</xsl:call-template>
						<xsl:if test="@descend">
							<xsl:value-of select="' DESC'"/>
						</xsl:if>
						<xsl:value-of select="', '"/>
					</xsl:for-each>
					<!-- end order with identity field -->
					<xsl:call-template name="SQLColumnValue">
						<xsl:with-param name="name" select="/Data/WTENTITY/WTATTRIBUTE[@identity='true']/@name"/>
						<xsl:with-param name="columnalias" select="false()"/>
						<xsl:with-param name="proctype" select="$proctype"/>
					</xsl:call-template>
					<xsl:value-of select="$cr"/>
				</xsl:if>
			</xsl:when>

			<xsl:when test="$hassearch and count($procorders)=0">
				<xsl:if test="count(/Data/WTENTITY/WTPROCEDURE/WTSEARCH/WTORDER)=0">
					<xsl:value-of select="'ORDER BY '"/>
					<!-- start order with search field -->
					<xsl:call-template name="SQLColumnValue">
						<xsl:with-param name="name" select="$name"/>
						<xsl:with-param name="columnalias" select="false()"/>
						<xsl:with-param name="proctype" select="$proctype"/>
					</xsl:call-template>
					<xsl:value-of select="$cr"/>
				</xsl:if>
				<!-- get extra order by fields -->
				<xsl:for-each select="/Data/WTENTITY/WTPROCEDURE/WTSEARCH/WTORDER">
					<xsl:value-of select="', '"/>
					<xsl:call-template name="SQLColumnValue">
						<xsl:with-param name="name" select="@name"/>
						<xsl:with-param name="columnalias" select="false()"/>
						<xsl:with-param name="proctype" select="$proctype"/>
					</xsl:call-template>
					<xsl:if test="@descend">
						<xsl:value-of select="' DESC'"/>
					</xsl:if>
				</xsl:for-each>
				<xsl:value-of select="$cr"/>
			</xsl:when>

			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="($position=1)"><xsl:value-of select="'ORDER BY '"/></xsl:when>
					<xsl:otherwise><xsl:value-of select="$tab4"/></xsl:otherwise>
				</xsl:choose>
				<xsl:call-template name="SQLColumnAlias">
					<xsl:with-param name="name" select="$name"/>
					<xsl:with-param name="proctype" select="$proctype"/>
				</xsl:call-template>
				<xsl:if test="($dir)"><xsl:value-of select="concat(' ', $dir)"/></xsl:if>
				<xsl:if test="($continue)"><xsl:value-of select="(', ')"/></xsl:if>
				<xsl:if test="@descend">
					<xsl:value-of select="' DESC'"/>
				</xsl:if>
				<xsl:value-of select="$cr"/>

			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: SQL PARAM -->
	<!-- outputs the declaration for a parameter to a SQL stored procedure -->
	<!--==================================================================-->
	<xsl:template name="SQLParam">
		<xsl:param name="parameter"/>
		<xsl:param name="name"/>
		<xsl:param name="inout"/>
		<xsl:param name="value"/>
		<xsl:param name="type"/>
		<xsl:param name="length"/>
		<xsl:param name="precision"/>
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
		<xsl:variable name="direction">
			<xsl:choose>
				<xsl:when test="(($inout = 'output') or ($inout = 'inputoutput'))"> OUTPUT</xsl:when>
				<xsl:when test="((@direction = 'output') or (@direction = 'inputoutput'))"> OUTPUT</xsl:when>
				<xsl:otherwise></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="valuetype">
			<xsl:choose>
				<xsl:when test="$value"><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="$value"/></xsl:call-template></xsl:when>	
				<xsl:otherwise><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="valuetext">
			<xsl:choose>
				<xsl:when test="$value"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="$value"/></xsl:call-template></xsl:when>
				<xsl:otherwise><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		
		<xsl:variable name="datatype">
			<xsl:choose>
				<xsl:when test="$type"><xsl:value-of select="$type"/></xsl:when>
				<xsl:otherwise>
					 <xsl:call-template name="GetDataType">
					 	<xsl:with-param name="type" select="$nametype"/>
					 	<xsl:with-param name="text" select="$nametext"/>
					 </xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		
		<xsl:variable name="datalength">
			<xsl:choose>
				<xsl:when test="$length"><xsl:value-of select="$length"/></xsl:when>
				<xsl:otherwise>
					 <xsl:call-template name="GetDataLength">
					 	<xsl:with-param name="type" select="$nametype"/>
					 	<xsl:with-param name="text" select="$nametext"/>
					 </xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		
		<xsl:variable name="dataprecision">
			<xsl:choose>
				<xsl:when test="$precision"><xsl:value-of select="$precision"/></xsl:when>
				<xsl:otherwise>
					 <xsl:call-template name="GetDataPrecision">
					 	<xsl:with-param name="type" select="$nametype"/>
					 	<xsl:with-param name="text" select="$nametext"/>
					 </xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		  <xsl:value-of select="$tab1"/>
		  <xsl:call-template name="GetValue">
		  	<xsl:with-param name="type" select="$nametype"/>
		  	<xsl:with-param name="text" select="$nametext"/>
			<xsl:with-param name="param" select="true()"/>
		  </xsl:call-template>
		  <xsl:value-of select="' '"/>

		<xsl:call-template name="SQLDataType">
			<xsl:with-param name="datatype" select="$datatype"/>
			<xsl:with-param name="length" select="$datalength"/>
			<xsl:with-param name="precision" select="$dataprecision"/>
			<xsl:with-param name="language" select="not(@language='false')"/>
		</xsl:call-template>
		
		<xsl:value-of select="$direction"/>
		<xsl:if test="($continue)">
			<xsl:value-of select="concat(',', $cr)"/>
		</xsl:if>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: SQL PARAM DIRECTION -->
	<!-- returns 'IN' or 'OUT' indicating the direction of the attribute for the specified procedure-->
	<!-- returns 'NONE' if the attribute is not a parameter-->
	<!-- Root Template: WTATTRIBUTE-->
	<!--==================================================================-->
	<xsl:template name="SQLParamDirection">
		<xsl:param name="name"/>
		<xsl:param name="proctype"/>

		<xsl:variable name="aname" select="@name"/>

		<xsl:choose>
			<xsl:when test="($proctype='Add')">

				<xsl:choose>
					<xsl:when test="WTCOMPUTE">NONE</xsl:when>
					<xsl:when test="@identity='true'">OUT</xsl:when>
					<xsl:when test="WTINIT">OUT</xsl:when>
					<xsl:when test="@passthru">IN</xsl:when>
					<xsl:when test="@persist='false'">NONE</xsl:when>
					<xsl:when test="@source='entity' or @source='inherit'">IN</xsl:when>
					<xsl:otherwise>NONE</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="($proctype='Count')">
				<xsl:choose>
					<xsl:when test="count($parentfields[@relname = $aname]) > 0">IN</xsl:when>
					<xsl:otherwise>NONE</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="($proctype='Enum')">
				<xsl:choose>
					<xsl:when test="count($parentfields[@relname = $aname]) > 0">IN</xsl:when>
					<xsl:otherwise>NONE</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="($proctype='Delete')">
				<xsl:choose>
					<xsl:when test="(@identity='true')">IN</xsl:when>
					<xsl:otherwise>NONE</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="($proctype='DeleteChild')">
				<xsl:choose>
					<xsl:when test="count($procparams[@name = $aname]) > 0">IN</xsl:when>
					<xsl:otherwise>NONE</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="($proctype='Fetch')">
				<xsl:choose>
					<xsl:when test="(@identity='true')">IN</xsl:when>
					<xsl:otherwise>OUT</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="($proctype='Find')">
				<xsl:choose>
					<xsl:when test="count($procparams[@name = $aname]) > 0">IN</xsl:when>
					<xsl:otherwise>NONE</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="($proctype='Init')">
				<xsl:choose>
					<xsl:when test="count(/Data/WTENTITY/WTPROCEDURE/WTPARAM[@name=$aname]) > 0">IN</xsl:when>
					<xsl:otherwise>NONE</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="($proctype='List')">
				<xsl:choose>
					<xsl:when test="count($procparams[@name = $aname]) > 0">IN</xsl:when>
					<xsl:otherwise>NONE</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="($proctype='Update')">
				<xsl:choose>
					<xsl:when test="(WTUPDATE)">OUT</xsl:when>
					<xsl:when test="(WTCOMPUTE)">NONE</xsl:when>
					<xsl:when test="@passthru">IN</xsl:when>
					<xsl:when test="@persist='false'">NONE</xsl:when>
					<xsl:when test="(@source='entity' or @source='inherit')">IN</xsl:when>
					<xsl:otherwise>NONE</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
		</xsl:choose>
	</xsl:template>

	<!--==========SQL Select==========-->
	<xsl:template name="SQLSelect">
		<xsl:param name="name"/>
		<xsl:param name="value"/>
		<xsl:param name="alias"/>
		<xsl:param name="position"/>
		<xsl:param name="continue" select="true()"/>

		<xsl:if test="($position != '1')">
			<xsl:value-of select="$tab4"/>
		</xsl:if>
		<xsl:value-of select="$name"/>
		<xsl:if test="($value != '')">
			<xsl:value-of select="concat(' = ', $value)"/>
		</xsl:if>

		<xsl:if test="($continue)">
			<xsl:value-of select="concat($tab0, ' ,')"/>
		</xsl:if>
		<xsl:value-of select="$cr"/>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: SQL SET -->
	<!-- outputs a SET statement -->
	<!--==================================================================-->
	<xsl:template name="SQLSet">
		<xsl:param name="name"/>
		<xsl:param name="value"/>
		<xsl:param name="datatype"/>

		<xsl:choose>
			<xsl:when test="($datatype) and ($value = '')">
				<xsl:choose>
					<xsl:when test="($datatype='char') or ($datatype='text')">
						<xsl:value-of select="concat('SET ', $name, ' = ', $apos, $apos, $cr)"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="concat('SET ', $name, ' = 0', $cr)"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="concat('SET ', $name, ' = ', $value, $cr)"/>
			</xsl:otherwise>
		</xsl:choose>

	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: SQL RETURN -->
	<!-- outputs a RETURN statement for a SQL procedure -->
	<!--==================================================================-->
	<xsl:template name="SQLReturn">
		<xsl:param name="value"/>

		<xsl:value-of select="concat('RETURN ', $value, $cr)"/>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: SQL WHERE -->
	<!-- generate the WHERE clause for a SQL stored procedure -->
	<!--==================================================================-->
	<xsl:template name="SQLWhere">
		<xsl:param name="conditions"/>
		<xsl:param name="name"/>
		<xsl:param name="proctype"/>
		<xsl:param name="append"/>
		<xsl:param name="first" select="false()"/>

		<xsl:choose>
			<xsl:when test="($name)">
				<!--==========do the default where clause for the procedure==========-->
				<xsl:choose>
					<xsl:when test="($first) and (position() = '1')">
						<xsl:value-of select="'WHERE '"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="'AND '"/>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:call-template name="SQLSelect">
					<xsl:with-param name="name">
						<xsl:call-template name="SQLColumnName">
							<xsl:with-param name="name" select="$name"/>
							<xsl:with-param name="proctype" select="$proctype"/>
							<xsl:with-param name="columnalias" select="false()"/>
						</xsl:call-template>
					</xsl:with-param>
					<xsl:with-param name="value" select="concat('@', $name)"/>
					<xsl:with-param name="position" select="1"/>
					<xsl:with-param name="continue" select="false()"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<!--==========build conditions from the WTCONDITION elements==========-->
				<!--==========start the IF statement==========-->
				
				<xsl:if test="not ($append)">
					<xsl:value-of select="'WHERE '"/>
				</xsl:if>

				<xsl:for-each select="$conditions">
					<xsl:choose>
						<xsl:when test="($append)">
							<xsl:call-template name="SQLConditionTest">
								<xsl:with-param name="proctype" select="$proctype"/>
								<xsl:with-param name="condition" select="."/>
								<xsl:with-param name="isfirst" select="false()"/>
							</xsl:call-template>
						</xsl:when>
						<xsl:otherwise>
							<xsl:call-template name="SQLConditionTest">
								<xsl:with-param name="proctype" select="$proctype"/>
								<xsl:with-param name="condition" select="."/>
								<xsl:with-param name="isfirst" select="(position()=1)"/>
							</xsl:call-template>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:for-each>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: SQL CHECK TABLE -->
	<!-- returns the code to execute the CheckTable stored procedure -->
	<!--==================================================================-->
	<xsl:template name="CheckTable">
		<xsl:value-of select="concat('EXEC [', $dbowner, '].', $appprefix, '_CheckTable ', $apos, $entityname, $apos, $cr, ' GO', $cr, $cr)"/>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: SQL CHECK TABLE REBUILD	-->
	<!-- returns the code to execute the CheckTable stored procedure -->
	<!--==================================================================-->
	<xsl:template name="CheckTableRebuild">
		<xsl:value-of select="concat('EXEC [', $dbowner, '].', $appprefix, '_CheckTableRebuild ', $apos, $entityname, $apos, $cr, ' GO', $cr, $cr)"/>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: SQL CHECK FOREIGN KEY -->
	<!-- returns the code to execute the CheckForeignKey stored procedure -->
	<!--==================================================================-->
	<xsl:template name="CheckForeignKey">
		<xsl:value-of select="concat('EXEC [', $dbowner, '].', $appprefix, '_CheckForeignKey ', $apos, 'FK_', $entityname, '_', /Data/WTENTITY/WTRELATIONSHIP/@name, $apos, $cr, ' GO', $cr, $cr)"/>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: SQL CHECK PROC -->
	<!-- returns the code to execute the CheckProc stored procedure -->
	<!--==================================================================-->
	<xsl:template name="CheckProc">
		<xsl:value-of select="concat('EXEC [dbo].', $appprefix, '_CheckProc ', $apos, $appprefix, '_', $entityname, '_', /Data/WTENTITY/WTPROCEDURE/@name, $apos, $cr, ' GO', $cr, $cr)"/>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: SQL CREATE PROC -->
	<!-- returns the code for the CREATE PROCEDURE statement  -->
	<!--==================================================================-->
	<xsl:template name="CreateProc">
		<xsl:value-of select="concat('CREATE PROCEDURE [dbo].', $appprefix, '_', $entityname, '_', /Data/WTENTITY/WTPROCEDURE/@name, ' ( ', $cr)"/>
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
				<xsl:when test="$oper='plus'"> + </xsl:when>
				<xsl:when test="$oper='minus'"> - </xsl:when>
				<xsl:when test="$oper='divide'"> / </xsl:when>
				<xsl:when test="$oper='multiply'"> * </xsl:when>
				<xsl:when test="$oper='starts'"> LIKE </xsl:when>
				<xsl:when test="$oper='contains'"> LIKE '%' </xsl:when>
				<xsl:when test="$oper='not-contains'"> NOT LIKE '%' </xsl:when>
				<xsl:when test="$oper='IS'"> IS </xsl:when>
				<xsl:otherwise>
					 <xsl:if test="$oper!=''">
						  <xsl:call-template name="Error">
						  	<xsl:with-param name="msg" select="'Invalid Operator'"/>
						  	<xsl:with-param name="text" select="$oper"/>
						  </xsl:call-template>
					 </xsl:if>
				</xsl:otherwise>
		  </xsl:choose>
	</xsl:template>

	 <!--==================================================================-->
	 <!-- If compute = true(), requires: proctype, columnalias             -->
	 <!-- attrjoin = the attribute is joined from another entity (compute) -->
	 <!-- nameonly - don't get the computed long name                      -->
	 <!--==================================================================-->
	 <xsl:template name="GetValue">
	 <!--==================================================================-->
		  <xsl:param name="type"/>
		  <xsl:param name="text"/>
		  <xsl:param name="entity"/>
		  <xsl:param name="join"/>
		  <xsl:param name="attrjoin"/>
		  <xsl:param name="compute" select="false()"/>
		  <xsl:param name="proctype"/>
		  <xsl:param name="columnalias" select="true()"/>
		  <xsl:param name="nameonly" select="false()"/>
		  <xsl:param name="param" select="false()"/>
		  
		  <xsl:choose>
			<xsl:when test="$type = 'ATTR'">

  				<!-- ***************** Error Checking *******************-->
				<!--  Check if this is a valid Attribute for this Entity -->
				<!-- ****************************************************-->
				<xsl:if test="$entity=$entityname and not($text='ChangeID') and not($text='ChangeDate')">
				  <xsl:if test="count(/Data/WTENTITY/WTATTRIBUTE[@name=$text])=0">
						 <xsl:call-template name="Error">
							  <xsl:with-param name="msg" select="'WTENTITY/WTATTRIBUTE Invalid Name'"/>
							  <xsl:with-param name="text" select="$text"/>
	 					</xsl:call-template>
	 				</xsl:if>
				</xsl:if>
				<!-- ****************************************************-->

				<xsl:choose>
				<!--......................................................-->
				<xsl:when test="$compute">
					 <xsl:choose>
					 <xsl:when test="$nameonly">
		  				<xsl:value-of select="concat($apos, $text, $apos)"/>
					 </xsl:when>
					 <xsl:otherwise>
						  <xsl:call-template name="SQLColumnValue">
						  	<xsl:with-param name="name" select="$text"/>
						  	<xsl:with-param name="columnalias" select="$columnalias"/>
						  	<xsl:with-param name="proctype" select="$proctype"/>
						  	<xsl:with-param name="joinname" select="$join"/>
						  </xsl:call-template>
					 </xsl:otherwise>
					 </xsl:choose>
				</xsl:when>
				<!--......................................................-->
				<xsl:otherwise>
					 <xsl:choose>
						  <xsl:when test="$param">
								<xsl:value-of select="concat('@', $text)"/>
						  </xsl:when>
						  <xsl:otherwise>
								<xsl:variable name="alias">
								<xsl:call-template name="SQLAlias">
									 <xsl:with-param name="join" select="$join"/>
									 <xsl:with-param name="entity" select="$entity"/>
								</xsl:call-template>
								</xsl:variable>
								<xsl:choose>
									 <xsl:when test="$attrjoin">
											<xsl:variable name="attr">
											   <xsl:call-template name="SQLReserved"><xsl:with-param name="ReservedWord" select="$attrjoin/@name"/></xsl:call-template>
											</xsl:variable>
											<xsl:if test="@length">
												<xsl:value-of select="concat('Left(', $alias, '.', $attr, ',', @length, ') ', $apos, $attr, $apos)"/>
											</xsl:if>
											<xsl:if test="not(@length)">
												<xsl:value-of select="concat($alias, '.', $attr)"/>
											</xsl:if>
									 </xsl:when>
									 <xsl:otherwise>
											<xsl:variable name="attr">
											   <xsl:call-template name="SQLReserved"><xsl:with-param name="ReservedWord" select="$text"/></xsl:call-template>
											</xsl:variable>
											<xsl:if test="@length">
												<xsl:value-of select="concat('Left(', $alias, '.', $attr, ',', @length, ') ', $apos, $attr, $apos)"/>
											</xsl:if>
											<xsl:if test="not(@length)">
												<xsl:value-of select="concat($alias, '.', $attr)"/>
											</xsl:if>
									 </xsl:otherwise>
	 						  </xsl:choose>
	 					  </xsl:otherwise>
					 </xsl:choose>
				</xsl:otherwise>
				</xsl:choose>
			</xsl:when>

			<xsl:when test="$type = 'DATA'">
				<xsl:variable name="alias">
					<xsl:call-template name="SQLAlias">
						<xsl:with-param name="join" select="$join"/>
						<xsl:with-param name="entity" select="$entity"/>
					</xsl:call-template>
				</xsl:variable>
				<xsl:value-of select="concat($alias, '.', $text)"/>
			</xsl:when>

		  <xsl:when test="$type='PARAM'">
				<xsl:value-of select="concat('@', $text)"/>
<!--
				<xsl:if test="count(/Data/WTENTITY/WTPROCEDURE/WTPARAM[@name=$text])=0">
					<xsl:call-template name="Error">
						<xsl:with-param name="msg" select="'Invalid PARAM() Name'"/>
						<xsl:with-param name="text" select="$text"/>
					</xsl:call-template>
				</xsl:if>
-->
		  </xsl:when>
		  <xsl:when test="$type='CONST'">
					 <xsl:choose>
					    <xsl:when test="$param">
					  		<xsl:value-of select="concat('@', $text)"/>
					    </xsl:when>
					    <xsl:otherwise>
					  		<xsl:value-of select="$text"/>
					    </xsl:otherwise>
					 </xsl:choose>
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
				<xsl:choose>
				<xsl:when test="$ltext='date'">GETDATE()</xsl:when>
				<xsl:when test="$ltext='timestamp'">GETDATE()</xsl:when>
				<xsl:when test="$ltext='identity'">@@IDENTITY</xsl:when>
				<xsl:when test="$ltext='userid'">@UserID</xsl:when>
				<xsl:when test="$ltext='security'">@UserID</xsl:when>
				<xsl:when test="$ltext='currdate'">@CurrDate</xsl:when>
				<xsl:otherwise>
					 <xsl:call-template name="Error">
					 	<xsl:with-param name="msg" select="'Invalid SYS() Name'"/>
					 	<xsl:with-param name="text" select="$text"/>
					 </xsl:call-template>
				</xsl:otherwise>
				</xsl:choose>
		   </xsl:when>

		  <xsl:when test="$type='NONE'">
				<xsl:choose>
				<xsl:when test="$text='true'">1</xsl:when>
				<xsl:when test="$text='false'">0</xsl:when>
				<xsl:otherwise>
					 <xsl:choose>
						  <xsl:when test="$param"><xsl:value-of select="concat('@', $text)"/></xsl:when>
						  <xsl:otherwise><xsl:value-of select="concat('@m', $text)"/></xsl:otherwise>
					 </xsl:choose>
				</xsl:otherwise>
				</xsl:choose>
		   </xsl:when>
		  <xsl:otherwise>
		  	 <xsl:choose>
		  		  <xsl:when test="$param"><xsl:value-of select="concat('@', $text)"/></xsl:when>
		  		  <xsl:otherwise><xsl:value-of select="concat('@m', $text)"/></xsl:otherwise>
		  	 </xsl:choose>
		  </xsl:otherwise>
		  </xsl:choose>
	 </xsl:template>

	 <!--==================================================================-->
	 <xsl:template name="GetDataType">
	 <!--==================================================================-->
		  <xsl:param name="type"/>
		  <xsl:param name="text"/>
		  
		  <xsl:choose>
		  <xsl:when test="$type='ATTR'"><xsl:value-of select="/Data/WTENTITY/WTATTRIBUTE[@name=$text]/@type"/></xsl:when>
		  <xsl:when test="$type='CONST'"><xsl:value-of select="@datatype"/></xsl:when>
		  <xsl:when test="$type='SYS'">
				<xsl:choose>
				<xsl:when test="$text='date'">date</xsl:when>
				<xsl:when test="$text='timestamp'">date</xsl:when>
				<xsl:when test="$text='identity'">number</xsl:when>
				<xsl:when test="$text='userid'">number</xsl:when>
				<xsl:when test="$text='security'">number</xsl:when>
				<xsl:when test="$text='currdate'">date</xsl:when>
				<xsl:otherwise>
					 <xsl:call-template name="Error">
					 	<xsl:with-param name="msg" select="'Invalid SYS() Name'"/>
					 	<xsl:with-param name="text" select="$text"/>
					 </xsl:call-template>
				</xsl:otherwise>
				</xsl:choose>
		   </xsl:when>
		  <xsl:when test="$type='NONE'">
				<xsl:choose>
				<xsl:when test="$text='true'">yesno</xsl:when>
				<xsl:when test="$text='false'">yesno</xsl:when>
				<xsl:otherwise><xsl:value-of select="@datatype"/></xsl:otherwise>
				</xsl:choose>
		  </xsl:when>
		  <xsl:otherwise><xsl:value-of select="@datatype"/></xsl:otherwise>
		  </xsl:choose>
	 </xsl:template>

	 <!--==================================================================-->
	 <xsl:template name="GetDataLength">
	 <!--==================================================================-->
		  <xsl:param name="type"/>
		  <xsl:param name="text"/>
		  <xsl:choose>
		  <xsl:when test="$type='ATTR'"><xsl:value-of select="/Data/WTENTITY/WTATTRIBUTE[@name=$text]/@length"/></xsl:when>
		  <xsl:otherwise><xsl:value-of select="@datalength"/></xsl:otherwise>
		  </xsl:choose>
	 </xsl:template>
	 
	 <!--==================================================================-->
	 <xsl:template name="GetDataPrecision">
	 <!--==================================================================-->
		  <xsl:param name="type"/>
		  <xsl:param name="text"/>
		  <xsl:choose>
		  <xsl:when test="$type='ATTR'"><xsl:value-of select="/Data/WTENTITY/WTATTRIBUTE[@name=$text]/@precision"/></xsl:when>
		  <xsl:otherwise><xsl:value-of select="@precision"/></xsl:otherwise>
		  </xsl:choose>
	 </xsl:template>

	<xsl:template name="ErrorCheckProcedure">
	<!--==================================================================-->
	 <xsl:if test="not(@name)">
	     <xsl:call-template name="Error">
	     	<xsl:with-param name="msg" select="'WTPROCEDURE Name Missing'"/>
	     	<xsl:with-param name="text" select="position()"/>
	     </xsl:call-template>
	 </xsl:if>
	 <!--Test valid attributes-->
	 <xsl:for-each select="@*">
		  <xsl:choose>
				<xsl:when test="name()='name'"/>
				<xsl:when test="name()='type'"/>
				<xsl:when test="name()='style'"/>
				<xsl:when test="name()='template'"/>
				<xsl:when test="name()='id'"/>
				<xsl:when test="name()='column'"/>
				<xsl:when test="name()='passthru'"/>
				<xsl:when test="name()='noedit'"/>
				<xsl:when test="name()='novalidate'"/>
				<xsl:otherwise>
					 <xsl:call-template name="Error">
						  <xsl:with-param name="msg" select="'WTPROCEDURE Invalid Attribute'"/>
						  <xsl:with-param name="text" select="name()"/>
	 				</xsl:call-template>
				</xsl:otherwise>
		  </xsl:choose>
	 </xsl:for-each>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template name="ErrorCheckAttribute">
	<!--==================================================================-->
	 <!--Test valid attributes-->
	 <xsl:for-each select="@*">
		  <xsl:choose>
				<xsl:when test="name()='name'"/>
				<xsl:when test="name()='type'"/>
				<xsl:when test="name()='value'"/>
				<xsl:when test="name()='alias'"/>
				<xsl:when test="name()='null'"/>
				<xsl:when test="name()='func'"/>
				<xsl:when test="name()='parm'"/>
				<xsl:when test="name()='length'"/>
				<xsl:otherwise>
					 <xsl:call-template name="Error">
						  <xsl:with-param name="msg" select="'WTATTRIBUTE Invalid Attribute'"/>
						  <xsl:with-param name="text" select="name()"/>
	 				</xsl:call-template>
				</xsl:otherwise>
		  </xsl:choose>
	 </xsl:for-each>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template name="ErrorCheckParam">
	<!--==================================================================-->
	 <xsl:if test="not(@name)">
	     <xsl:call-template name="Error">
	     	<xsl:with-param name="msg" select="'WTPARAM Name Missing'"/>
	     	<xsl:with-param name="text" select="position()"/>
	     </xsl:call-template>
	 </xsl:if>
	 <xsl:if test="not(@direction)">
	     <xsl:call-template name="Error">
	     	<xsl:with-param name="msg" select="'WTPARAM Direction Missing'"/>
	     	<xsl:with-param name="text" select="@name"/>
	     </xsl:call-template>
	 </xsl:if>
	 <!--Test valid attributes-->
	 <xsl:for-each select="@*">
		  <xsl:choose>
				<xsl:when test="name()='name'"/>
				<xsl:when test="name()='value'"/>
				<xsl:when test="name()='datatype'"/>
				<xsl:when test="name()='datalength'"/>
				<xsl:when test="name()='dataprecision'"/>
				<xsl:when test="name()='direction'"/>
				<xsl:when test="name()='required'"/>
				<xsl:when test="name()='length'"/>
				<xsl:when test="name()='passthru'"/>
				<xsl:otherwise>
					 <xsl:call-template name="Error">
						  <xsl:with-param name="msg" select="'WTPARAM Invalid Attribute'"/>
						  <xsl:with-param name="text" select="name()"/>
	 				</xsl:call-template>
				</xsl:otherwise>
		  </xsl:choose>
	 </xsl:for-each>
	</xsl:template>

</xsl:stylesheet>

