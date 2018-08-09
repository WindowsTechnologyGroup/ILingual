<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:include href="GenerateInclude.xsl"/>

	<xsl:variable name="NavBar">
		<xsl:choose>
			<xsl:when test="/Data/WTENTITY/WTWEBPAGE/@navbar='false'"/>
			<xsl:when test="/Data/WTENTITY/WTWEBPAGE/@navbar='true'">NavBar</xsl:when>
			<xsl:when test="/Data/WTENTITY/WTWEBPAGE/@navbar"><xsl:value-of select="/Data/WTENTITY/WTWEBPAGE/@navbar"/></xsl:when>
			<xsl:when test="/Data/WTPAGE/@navbar='false'"/>
			<xsl:when test="/Data/WTPAGE/@navbar"><xsl:value-of select="/Data/WTPAGE/@navbar"/></xsl:when>
			<xsl:otherwise>NavBar</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="MenuBar">
		<xsl:choose>
			<xsl:when test="$NavBar=''"></xsl:when>
			<xsl:when test="$NavBar='blank'"></xsl:when>
			<xsl:when test="/Data/WTENTITY/WTWEBPAGE/@worker='true'"/>
			<xsl:when test="/Data/WTENTITY/WTWEBPAGE/@type='mail'"/>
			<xsl:when test="/Data/WTPAGE/@menubar"><xsl:value-of select="/Data/WTPAGE/@menubar"/></xsl:when>
			<xsl:otherwise/>
		
		
		</xsl:choose>
	</xsl:variable>

	<!--==================================================================-->
	<!--==================================================================-->
	<!-- BEGIN NEW TEMPLATES -->
	<!--==================================================================-->
	<!--==================================================================-->

	<!--==================================================================-->
	<xsl:template match="WTINPUTOPTIONS">
	<!--==================================================================-->
		<xsl:param name="indent" select="1"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="ind2" select="concat($ind1, $tab1)"/>
		<xsl:variable name="ind3" select="concat($ind2, $tab1)"/>
		<xsl:variable name="nametype"><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="@name"/></xsl:call-template></xsl:variable>
		<xsl:variable name="nametext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@name"/></xsl:call-template></xsl:variable>
		<xsl:variable name="valuetype"><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="@values"/></xsl:call-template></xsl:variable>
		<xsl:variable name="valuetext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@values"/></xsl:call-template></xsl:variable>
		<xsl:variable name="pricetype"><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="@price"/></xsl:call-template></xsl:variable>
		<xsl:variable name="pricetext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@price"/></xsl:call-template></xsl:variable>
		<xsl:variable name="name">
			<xsl:call-template name="GetValue">
				<xsl:with-param name="type" select="$nametype"/>			
				<xsl:with-param name="text" select="$nametext"/>			
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="value">
			<xsl:call-template name="GetValue">
				<xsl:with-param name="type" select="$valuetype"/>			
				<xsl:with-param name="text" select="$valuetext"/>			
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="price">
			<xsl:if test="not(@price)">tmpPrice</xsl:if>
			<xsl:if test="@price">
				<xsl:call-template name="GetValue">
					<xsl:with-param name="type" select="$pricetype"/>			
					<xsl:with-param name="text" select="$pricetext"/>			
				</xsl:call-template>
			</xsl:if>
		</xsl:variable>
		<xsl:variable name="secure">
			<xsl:if test="not(@secure)">0</xsl:if>
			<xsl:if test="@secure"><xsl:value-of select="@secure"/></xsl:if>
		</xsl:variable>

		<!-- ***************** Error Checking *******************-->
		  <xsl:if test="not(@name)">
		      <xsl:call-template name="Error">
		      	<xsl:with-param name="msg" select="'WTINPUTOPTIONS Name Missing'"/>
		      	<xsl:with-param name="text" select="position()"/>
		      </xsl:call-template>
		  </xsl:if>
		  <xsl:if test="not(@values)">
		      <xsl:call-template name="Error">
		      	<xsl:with-param name="msg" select="'WTINPUTOPTIONS Values Missing'"/>
		      	<xsl:with-param name="text" select="position()"/>
		      </xsl:call-template>
		  </xsl:if>
		<!--TEST valid attributes-->
		<xsl:for-each select="@*">
			<xsl:choose>
				<xsl:when test="name()='name'"/>
				<xsl:when test="name()='values'"/>
				<xsl:when test="name()='price'"/>
				<xsl:when test="name()='secure'"/>
				<xsl:otherwise>
					 <xsl:call-template name="Error">
						  <xsl:with-param name="msg" select="'Invalid WTINPUTOPTIONS Attribute'"/>
						  <xsl:with-param name="text" select="name()"/>
	 				</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
		<!-- ****************************************************-->

		<xsl:value-of select="concat($ind1, $value, ' = DoInputOptions( ', $name, ', ', $value, ', ', $price, ', ', $secure, ')', $cr )"/>
		
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTHTTP" mode="docase">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:apply-templates select=".">
			<xsl:with-param name="indent" select="$indent"/>			
		</xsl:apply-templates>
	</xsl:template>
	
	<!--==================================================================-->
	<xsl:template match="WTHTTP">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:variable name="hasconditions" select="(count(WTCONDITION) > 0)"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="ind2"><xsl:choose><xsl:when test="($hasconditions)"><xsl:value-of select="concat($ind1, $tab1)"/></xsl:when><xsl:otherwise><xsl:value-of select="$ind1"/></xsl:otherwise></xsl:choose></xsl:variable>
		<xsl:variable name="indent2"><xsl:choose><xsl:when test="($hasconditions)"><xsl:value-of select="($indent+1)"/></xsl:when><xsl:otherwise><xsl:value-of select="$indent"/></xsl:otherwise></xsl:choose></xsl:variable>
		<xsl:variable name="indent3"><xsl:value-of select="($indent2+1)"/></xsl:variable>
		<xsl:variable name="ind3"><xsl:value-of select="concat($ind2, $tab1)"/></xsl:variable>

		<xsl:if test="($hasconditions)">
			<xsl:call-template name="ASPConditionStart">
				<xsl:with-param name="indent" select="$indent"/>
				<xsl:with-param name="conditions" select="WTCONDITION"/>
			</xsl:call-template>
		</xsl:if>

		<xsl:value-of select="concat($ind2, 'Set oHTTP = server.CreateObject(&quot;MSXML2.ServerXMLHTTP&quot;)', $cr)"/>
		<xsl:value-of select="concat($ind2, 'If oHTTP Is Nothing Then', $cr)"/>
		<xsl:value-of select="concat($ind3, 'DoError Err.Number, Err.Source, &quot;Unable to Create HTTP Object - MSXML2.ServerXMLHTTP&quot;', $cr)"/>
		<xsl:value-of select="concat($ind2, 'Else', $cr)"/>

		<xsl:apply-templates select="WTLINK">
			<xsl:with-param name="indent" select="$indent3"/>
		</xsl:apply-templates>

		<xsl:value-of select="concat($ind2, 'End If', $cr)"/>
		<xsl:value-of select="concat($ind2, 'Set oHTTP = Nothing', $cr)"/>

		<xsl:if test="($hasconditions)">
			<xsl:call-template name="ASPConditionEnd">
				<xsl:with-param name="indent" select="$indent"/>			
			</xsl:call-template>
		</xsl:if>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTHTTP/WTLINK">
	<!--==================================================================-->
		<xsl:param name="indent"/>

		<xsl:variable name="hasconditions" select="(count(WTCONDITION) > 0)"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="ind2"><xsl:choose><xsl:when test="($hasconditions)"><xsl:value-of select="concat($ind1, $tab1)"/></xsl:when><xsl:otherwise><xsl:value-of select="$ind1"/></xsl:otherwise></xsl:choose></xsl:variable>
		<xsl:variable name="indent2"><xsl:choose><xsl:when test="($hasconditions)"><xsl:value-of select="($indent+1)"/></xsl:when><xsl:otherwise><xsl:value-of select="$indent"/></xsl:otherwise></xsl:choose></xsl:variable>
		<xsl:variable name="indent3"><xsl:value-of select="($indent2+1)"/></xsl:variable>
		<xsl:variable name="ind3"><xsl:value-of select="concat($ind2, $tab1)"/></xsl:variable>

		<xsl:if test="($hasconditions)">
			<xsl:call-template name="ASPConditionStart">
				<xsl:with-param name="indent" select="$indent"/>
				<xsl:with-param name="conditions" select="WTCONDITION"/>
			</xsl:call-template>
		</xsl:if>

		<xsl:variable name="secure">
			<xsl:choose>
				<xsl:when test="@secure"><xsl:value-of select="@secure"/></xsl:when>
				<xsl:when test="/Data/WTENTITY/WTWEBPAGE/@secure"><xsl:value-of select="/Data/WTENTITY/WTWEBPAGE/@secure"/></xsl:when>
				<xsl:when test="/Data/WTPAGE/@secure"><xsl:value-of select="/Data/WTPAGE/@secure"/></xsl:when>
			</xsl:choose>
		</xsl:variable>

	 <!-- ***************** Error Checking *******************-->
	 <xsl:if test="not(@name)">
	     <xsl:call-template name="Error">
	     	<xsl:with-param name="msg" select="'WTLINK Name Missing'"/>
	     	<xsl:with-param name="text" select="position()"/>
	     </xsl:call-template>
	 </xsl:if>
	 <!--Test valid attributes-->
	 <xsl:for-each select="@*">
		  <xsl:choose>
				<xsl:when test="name()='name'"/>
				<xsl:when test="name()='secure'"/>
				<xsl:when test="name()='custom'"/>
				<xsl:otherwise>
					 <xsl:call-template name="Error">
						  <xsl:with-param name="msg" select="'WTLINK Invalid Attribute'"/>
						  <xsl:with-param name="text" select="name()"/>
	 				</xsl:call-template>
				</xsl:otherwise>
		  </xsl:choose>
	 </xsl:for-each>
	 <!-- ****************************************************-->

		<!--create the link-->
		<xsl:choose>
			<xsl:when test="$secure='true'">
				<xsl:value-of select="concat($ind2, 'If reqSysServerName &lt;&gt; &quot;localhost&quot; Then', $cr)"/>
				<xsl:value-of select="concat($ind3, 'tmpServer = &quot;https://&quot; + reqSysServerName + reqSysServerPath', $cr)"/>
				<xsl:value-of select="concat($ind2, 'End If', $cr)"/>
				<xsl:value-of select="concat($ind2, 'oHTTP.open &quot;GET&quot;, tmpServer + &quot;', @name, '.asp&quot;')"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:if test="not(@custom)">
					<xsl:value-of select="concat($ind2, 'tmpServer = &quot;http://&quot; + reqSysServerName + reqSysServerPath', $cr)"/>
					<xsl:value-of select="concat($ind2, 'oHTTP.open &quot;GET&quot;, tmpServer + &quot;', @name, '.asp&quot;')"/>
				</xsl:if>
				<xsl:if test="@custom">
					<xsl:value-of select="concat($ind2, 'oHTTP.open &quot;GET&quot;, &quot;', @name, '.asp&quot;')"/>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:apply-templates select="WTPARAM"/>
		<xsl:value-of select="concat($cr, $ind2, 'oHTTP.send', $cr)"/>

		<xsl:if test="($hasconditions)">
			<xsl:call-template name="ASPConditionEnd">
				<xsl:with-param name="indent" select="$indent"/>			
			</xsl:call-template>
		</xsl:if>

	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTHTTP2">
	<!--==================================================================-->
		<xsl:param name="indent" select="1"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="ind2" select="concat($ind1, $tab1)"/>
		<xsl:variable name="ind3" select="concat($ind2, $tab1)"/>

		<!-- ***************** Error Checking *******************-->
		  <xsl:if test="not(@url)">
		      <xsl:call-template name="Error">
		      	<xsl:with-param name="msg" select="'WTHTTP2 URL Missing'"/>
		      	<xsl:with-param name="text" select="position()"/>
		      </xsl:call-template>
		  </xsl:if>
		<!--TEST valid attributes-->
		<xsl:for-each select="@*">
			<xsl:choose>
				<xsl:when test="name()='url'"/>
				<xsl:otherwise>
					 <xsl:call-template name="Error">
						  <xsl:with-param name="msg" select="'Invalid WTHTTP2 Attribute'"/>
						  <xsl:with-param name="text" select="name()"/>
	 				</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
		<!-- ****************************************************-->

		<xsl:value-of select="$cr"/>
		<xsl:value-of select="concat($ind1, 'Set oHTTP = server.CreateObject(&quot;wtHTTP.CHTTP&quot;)', $cr)"/>
		<xsl:value-of select="concat($ind1, 'ret = oHTTP.HTTP( ', @url, ')', $cr)"/>
		<xsl:value-of select="concat($ind1, 'If (ret &lt;&gt; 0) Then DoError 0, &quot;&quot;, &quot;HTTP Failed&quot; End If', $cr)"/>
		<xsl:value-of select="concat($ind1, 'Set oHTTP = Nothing', $cr)"/>
		
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTWEBPAGE/WTACTION" mode="declare">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>

		  <!-- ***************** Error Checking *******************-->
		  <xsl:if test="not(@name)">
		      <xsl:call-template name="Error">
		      	<xsl:with-param name="msg" select="'WTWEBPAGE/WTACTION Name Missing'"/>
		      	<xsl:with-param name="text" select="position()"/>
		      </xsl:call-template>
		  </xsl:if>
		  <xsl:if test="not(@id)">
		      <xsl:call-template name="Error">
		      	<xsl:with-param name="msg" select="'WTWEBPAGE/WTACTION ID Missing'"/>
		      	<xsl:with-param name="text" select="position()"/>
		      </xsl:call-template>
		  </xsl:if>
	  
		  <xsl:if test="not(@type)">
		      <xsl:call-template name="Error">
		      	<xsl:with-param name="msg" select="'WTWEBPAGE/WTACTION Type Missing'"/>
		      	<xsl:with-param name="text" select="position()"/>
		      </xsl:call-template>
		  </xsl:if>

		  <!--Test valid attributes-->
		  <xsl:for-each select="@*">
		    <xsl:choose>
		  		<xsl:when test="name()='name'"/>
		  		<xsl:when test="name()='id'"/>
		  		<xsl:when test="name()='type'"/>
		  		<xsl:when test="name()='log'"/>
		  		<xsl:otherwise>
		  			 <xsl:call-template name="Error">
		  				  <xsl:with-param name="msg" select="'WTWEBPAGE/WTACTION Invalid Attribute'"/>
		  				  <xsl:with-param name="text" select="name()"/>
		  				</xsl:call-template>
		  		</xsl:otherwise>
		    </xsl:choose>
		  </xsl:for-each>
		  <!-- ****************************************************-->
		  
		  <xsl:if test="position()=1">
				<xsl:call-template name="ASPComment">
					 <xsl:with-param name="indent" select="$indent"/>
					 <xsl:with-param name="value">action code constants</xsl:with-param>
				</xsl:call-template>
		  </xsl:if>

		<xsl:value-of select="concat($ind1, 'Const cAction', @name, ' = ', @id, $cr)"/>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTWEBPAGE/WTSUB">
	<!--==================================================================-->
		<xsl:param name="indent">0</xsl:param>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="ind2"><xsl:value-of select="concat($ind1, $tab1)"/></xsl:variable>

	 <!-- ***************** Error Checking *******************-->
	 <xsl:if test="not(@name or @function or @sub)">
	     <xsl:call-template name="Error">
	     	<xsl:with-param name="msg" select="'WTWEBPAGE/WTSUB Name or Function Missing'"/>
	     	<xsl:with-param name="text" select="position()"/>
	     </xsl:call-template>
	 </xsl:if>
		  <!--Test valid attributes-->
		  <xsl:for-each select="@*">
		    <xsl:choose>
		  		<xsl:when test="name()='name'"/>
		  		<xsl:when test="name()='sub'"/>
		  		<xsl:when test="name()='function'"/>
		  		<xsl:otherwise>
		  			 <xsl:call-template name="Error">
		  				  <xsl:with-param name="msg" select="'WTWEBPAGE/WTSUB Invalid Attribute'"/>
		  				  <xsl:with-param name="text" select="name()"/>
		  				</xsl:call-template>
		  		</xsl:otherwise>
		    </xsl:choose>
		  </xsl:for-each>
	 <!-- ****************************************************-->

		<xsl:if test="@name">
			<xsl:value-of select="concat($ind1, 'Sub ', @name, '()', $cr)"/>
		</xsl:if>
		<xsl:if test="@sub">
			<xsl:value-of select="concat($ind1, 'Sub ', @sub, $cr)"/>
		</xsl:if>
		<xsl:if test="@function">
			<xsl:value-of select="concat($ind1, 'Function ', @function, $cr)"/>
		</xsl:if>
		<xsl:value-of select="concat($ind2, 'On Error Resume Next', $cr)"/>

		<xsl:apply-templates select="WTSETATTRIBUTE | WTSETCACHE | WTGETCACHE | WTSETCOOKIE | WTGETCOOKIE | WTVARIABLE | WTOBJECT | WTCOMMENT | WTCUSTOM | WTMAIL | WTCODEGROUP | WTCALLSUB | WTACTIONLOG | WTHTTP" mode="docase">
			<xsl:with-param name="indent" select="$indent+1"/>
		</xsl:apply-templates>

		<xsl:apply-templates select="WTRETURN" mode="docase">
			<xsl:with-param name="indent" select="$indent+1"/>
		</xsl:apply-templates>

		<xsl:if test="@name or @sub">
			<xsl:value-of select="concat($ind1, 'End Sub', $cr, $cr)"/>
		</xsl:if>
		<xsl:if test="@function">
			<xsl:value-of select="concat($ind1, 'End Function', $cr, $cr)"/>
		</xsl:if>

	</xsl:template>
	
	<!--==================================================================-->
	<xsl:template match="WTCALLSUB" mode="docase">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:apply-templates select=".">
			<xsl:with-param name="indent" select="$indent"/>			
		</xsl:apply-templates>
	</xsl:template>
	
	<!--==================================================================-->
	<xsl:template match="WTCALLSUB">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:variable name="hasconditions" select="(count(WTCONDITION) > 0)"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="ind2"><xsl:choose><xsl:when test="($hasconditions)"><xsl:value-of select="concat($ind1, $tab1)"/></xsl:when><xsl:otherwise><xsl:value-of select="$ind1"/></xsl:otherwise></xsl:choose></xsl:variable>
		<xsl:variable name="indent2"><xsl:choose><xsl:when test="($hasconditions)"><xsl:value-of select="($indent+1)"/></xsl:when><xsl:otherwise><xsl:value-of select="$indent"/></xsl:otherwise></xsl:choose></xsl:variable>

	 <!-- ***************** Error Checking *******************-->
	 <xsl:if test="not(@name)">
	     <xsl:call-template name="Error">
	     	<xsl:with-param name="msg" select="'WTCALLSUB Name Missing'"/>
	     	<xsl:with-param name="text" select="position()"/>
	     </xsl:call-template>
	 </xsl:if>
		  <!--Test valid attributes-->
		  <xsl:for-each select="@*">
		    <xsl:choose>
		  		<xsl:when test="name()='name'"/>
		  		<xsl:otherwise>
		  			 <xsl:call-template name="Error">
		  				  <xsl:with-param name="msg" select="'WTCALLSUB Invalid Attribute'"/>
		  				  <xsl:with-param name="text" select="name()"/>
		  				</xsl:call-template>
		  		</xsl:otherwise>
		    </xsl:choose>
		  </xsl:for-each>
	 <!-- ****************************************************-->

		<!--generate IF statement for conditions if they exist-->
		<xsl:if test="($hasconditions)">
			<xsl:call-template name="ASPConditionStart">
				<xsl:with-param name="indent" select="$indent"/>
				<xsl:with-param name="conditions" select="WTCONDITION"/>			
			</xsl:call-template>
		</xsl:if>

		<xsl:value-of select="concat($ind2, @name, $cr)"/>
		
		<!--close IF statement for conditions if they exist-->
		<xsl:if test="($hasconditions)">
			<xsl:call-template name="ASPConditionEnd">
				<xsl:with-param name="indent" select="$indent"/>
			</xsl:call-template>
		</xsl:if> 

	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTWEBPAGE/WTACTION" mode="docase">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="ind2"><xsl:value-of select="concat($ind1, $tab1)"/></xsl:variable>

		<xsl:if test="position()=1">
			<xsl:value-of select="concat($ind1, 'Select Case CLng(reqActionCode)', $cr)"/>
		</xsl:if>

		<xsl:value-of select="$cr"/>
		<xsl:value-of select="concat($ind2, 'Case CLng(cAction', @name, '):', $cr)"/>

		<xsl:apply-templates select="WTSETATTRIBUTE | WTSETCACHE | WTGETCACHE | WTSETCOOKIE | WTGETCOOKIE | WTVARIABLE | WTOBJECT | WTCOMMENT | WTCUSTOM | WTMAIL | WTCODEGROUP | WTCALLSUB | WTACTIONLOG | WTHTTP" mode="docase">
			<xsl:with-param name="indent" select="$indent+2"/>
		</xsl:apply-templates>

		<xsl:apply-templates select="WTRETURN" mode="docase">
			<xsl:with-param name="indent" select="$indent+2"/>
		</xsl:apply-templates>

		<xsl:if test="position()=last()">
			<xsl:value-of select="concat($ind1, 'End Select', $cr)"/>
		</xsl:if>
	</xsl:template>

	<!--==================================================================-->
<!--
	<xsl:template match="WTENTITY/WTATTRIBUTE" mode="setinput">
		<xsl:param name="indent"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>

		<xsl:choose>
			<xsl:when test="(WTCOMPUTE[@name])">
				<xsl:for-each select="WTCOMPUTE[@name]">
					<xsl:variable name="aname" select="@name"/>
					<xsl:apply-templates select="/Data/WTENTITY/WTATTRIBUTE[@name=$aname]" mode="setinput">
						<xsl:with-param name="indent" select="$indent"/>
						<xsl:with-param name="isfirst" select="position()=1"/>
					</xsl:apply-templates>
				</xsl:for-each>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="concat($ind1, '.', @name, ' = Request.Form.Item(&quot;', @name, '&quot;)', $cr)"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
-->

	<!--==================================================================-->
	<xsl:template match="WTMETHOD" mode="docase">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:apply-templates select=".">
			<xsl:with-param name="indent" select="$indent"/>
		</xsl:apply-templates>
	</xsl:template>
	
	<!--==================================================================-->
	<xsl:template match="WTMETHOD">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:variable name="hasconditions" select="(count(WTCONDITION) > 0)"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="ind2"><xsl:choose><xsl:when test="($hasconditions)"><xsl:value-of select="concat($ind1, $tab1)"/></xsl:when><xsl:otherwise><xsl:value-of select="$ind1"/></xsl:otherwise></xsl:choose></xsl:variable>
		<xsl:variable name="indent2"><xsl:choose><xsl:when test="($hasconditions)"><xsl:value-of select="($indent+1)"/></xsl:when><xsl:otherwise><xsl:value-of select="$indent"/></xsl:otherwise></xsl:choose></xsl:variable>
		<xsl:variable name="returnparam" select="WTPARAM[@direction='return']"/>

	 <!-- ***************** Error Checking *******************-->
	 <xsl:if test="not(@name)">
	     <xsl:call-template name="Error">
	     	<xsl:with-param name="msg" select="'WTOBJECT/WTMETHOD Name Missing'"/>
	     	<xsl:with-param name="text" select="position()"/>
	     </xsl:call-template>
	 </xsl:if>
		  <!--Test valid attributes-->
		  <xsl:for-each select="@*">
		    <xsl:choose>
		  		<xsl:when test="name()='name'"/>
		  		<xsl:otherwise>
		  			 <xsl:call-template name="Error">
		  				  <xsl:with-param name="msg" select="'WTOBJECT/WTMETHOD Invalid Attribute'"/>
		  				  <xsl:with-param name="text" select="name()"/>
		  				</xsl:call-template>
		  		</xsl:otherwise>
		    </xsl:choose>
		  </xsl:for-each>
	 <!-- ****************************************************-->
<!--
		<xsl:if test="position()!=1">
			<xsl:value-of select="$cr"/>
		</xsl:if>
-->
		<!--generate IF statement for conditions if they exist-->
		<xsl:if test="($hasconditions)">
			<xsl:call-template name="ASPConditionStart">
				<xsl:with-param name="indent" select="$indent"/>
				<xsl:with-param name="conditions" select="WTCONDITION"/>
			</xsl:call-template>
		</xsl:if>

		<xsl:choose>
			<xsl:when test="($returnparam/@datatype='object')"><xsl:value-of select="concat($ind2, 'Set o', $returnparam/@name, ' = .', @name, '(')"/></xsl:when>
			<xsl:when test="($returnparam/@concat='true')"><xsl:value-of select="concat($ind2, $returnparam/@name, ' = ', $returnparam/@name, ' + .', @name, '(')"/></xsl:when>
			<xsl:when test="($returnparam/@datatype='big number')"><xsl:value-of select="concat($ind2, $returnparam/@name, ' = CStr(.', @name, '(')"/></xsl:when>
			<xsl:when test="($returnparam/@datatype='number')"><xsl:value-of select="concat($ind2, $returnparam/@name, ' = CLng(.', @name, '(')"/></xsl:when>
			<xsl:when test="($returnparam/@datatype='small number')"><xsl:value-of select="concat($ind2, $returnparam/@name, ' = CInt(.', @name, '(')"/></xsl:when>
			<xsl:when test="($returnparam/@datatype='tiny number')"><xsl:value-of select="concat($ind2, $returnparam/@name, ' = CByte(.', @name, '(')"/></xsl:when>
			<xsl:when test="($returnparam/@datatype='decimal')"><xsl:value-of select="concat($ind2, $returnparam/@name, ' = CDbl(.', @name, '(')"/></xsl:when>
			<xsl:when test="($returnparam/@datatype='date')"><xsl:value-of select="concat($ind2, $returnparam/@name, ' = CDate(.', @name, '(')"/></xsl:when>
			<xsl:when test="($returnparam/@datatype='currency')"><xsl:value-of select="concat($ind2, $returnparam/@name, ' = CCur(.', @name, '(')"/></xsl:when>
			<xsl:when test="($returnparam/@datatype='yesno')"><xsl:value-of select="concat($ind2, $returnparam/@name, ' = CBool(.', @name, '(')"/></xsl:when>
			<xsl:when test="($returnparam)"><xsl:value-of select="concat($ind2, $returnparam/@name, ' = .', @name, '(')"/></xsl:when>
			<xsl:otherwise><xsl:value-of select="concat($ind2, '.', @name, ' ')"/></xsl:otherwise>
		</xsl:choose>

		<xsl:apply-templates select="WTPARAM[@direction = 'input']"/>

		<xsl:choose>
			<xsl:when test="($returnparam/@datatype='object')"><xsl:value-of select="concat(')', $cr)"/></xsl:when>
			<xsl:when test="($returnparam/@concat='true')"><xsl:value-of select="concat(')', $cr)"/></xsl:when>
			<xsl:when test="($returnparam/@datatype='big number')"><xsl:value-of select="concat('))', $cr)"/></xsl:when>
			<xsl:when test="($returnparam/@datatype='number')"><xsl:value-of select="concat('))', $cr)"/></xsl:when>
			<xsl:when test="($returnparam/@datatype='small number')"><xsl:value-of select="concat('))', $cr)"/></xsl:when>
			<xsl:when test="($returnparam/@datatype='tiny number')"><xsl:value-of select="concat('))', $cr)"/></xsl:when>
			<xsl:when test="($returnparam/@datatype='decimal')"><xsl:value-of select="concat('))', $cr)"/></xsl:when>
			<xsl:when test="($returnparam/@datatype='date')"><xsl:value-of select="concat('))', $cr)"/></xsl:when>
			<xsl:when test="($returnparam/@datatype='currency')"><xsl:value-of select="concat('))', $cr)"/></xsl:when>
			<xsl:when test="($returnparam/@datatype='yesno')"><xsl:value-of select="concat('))', $cr)"/></xsl:when>
			<xsl:when test="($returnparam)"><xsl:value-of select="concat(')', $cr)"/></xsl:when>
			<xsl:otherwise><xsl:value-of select="$cr"/></xsl:otherwise>
		</xsl:choose>

		<xsl:call-template name="ASPErrorCheck">
			<xsl:with-param name="indent" select="$indent2"/>
		</xsl:call-template>

		<!--close IF statement for conditions if they exist-->
		<xsl:if test="($hasconditions)">
			<xsl:call-template name="ASPConditionEnd">
				<xsl:with-param name="indent" select="$indent"/>
			</xsl:call-template>
		</xsl:if> 
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTOBJECT" mode="appendxml">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>

		<xsl:if test="(@name != 'Bookmark')">
			<xsl:value-of select="concat($ind1, 'xmlTransaction = xmlTransaction +  xml', @name, $cr)"/>
		</xsl:if>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTDATA" mode="appendxml">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>

		<xsl:value-of select="concat($ind1, 'xmlData = xmlData +  xml', @name, $cr)"/>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTDATATXN" mode="appendxml">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>

		<xsl:value-of select="concat($ind1, 'xmlTransaction = xmlTransaction +  xml', @name, $cr)"/>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTOBJECT" mode="docase">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:variable name="hasconditions" select="(count(WTCONDITION) > 0)"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="ind2"><xsl:choose><xsl:when test="($hasconditions)"><xsl:value-of select="concat($ind1, $tab1)"/></xsl:when><xsl:otherwise><xsl:value-of select="$ind1"/></xsl:otherwise></xsl:choose></xsl:variable>
		<xsl:variable name="indent2"><xsl:choose><xsl:when test="($hasconditions)"><xsl:value-of select="($indent+1)"/></xsl:when><xsl:otherwise><xsl:value-of select="$indent"/></xsl:otherwise></xsl:choose></xsl:variable>
		<xsl:variable name="indent3"><xsl:value-of select="($indent2+1)"/></xsl:variable>
		<xsl:variable name="indent4"><xsl:value-of select="($indent3+1)"/></xsl:variable>
		<xsl:variable name="ind3"><xsl:value-of select="concat($ind2, $tab1)"/></xsl:variable>
		<xsl:variable name="ind4"><xsl:value-of select="concat($ind3, $tab1)"/></xsl:variable>

		<xsl:variable name="CreateObject"><xsl:value-of select="count(WTMETHOD | WTCUSTOM)"/></xsl:variable>
		<xsl:variable name="CreateObject2"><xsl:value-of select="count(WTCODEGROUP/WTMETHOD  | WTCODEGROUP/WTCUSTOM)"/></xsl:variable>

		<xsl:if test="($CreateObject &gt; 0 or $CreateObject2 &gt; 0)">
			
			<xsl:value-of select="$cr"/>

			<xsl:if test="($hasconditions)">
				<xsl:call-template name="ASPConditionStart">
					<xsl:with-param name="indent" select="$indent"/>
					<xsl:with-param name="conditions" select="WTCONDITION"/>
				</xsl:call-template>
			</xsl:if>

			<xsl:if test="(@project)">
<!--
				<xsl:if test="/Data/WTPAGE/@trace or /Data/WTENTITY/WTWEBPAGE/@trace">
					<xsl:value-of select="concat($ind2, 'Response.AppendToLog &quot;+', @name, '&quot;', $cr)"/>
				</xsl:if>
-->
				<xsl:value-of select="concat($ind2, 'Set o', @name, ' = server.CreateObject(&quot;', @project, '.', @class, '&quot;)', $cr)"/>
			</xsl:if>
			
			<xsl:value-of select="concat($ind2, 'If o', @name, ' Is Nothing Then', $cr)"/>
			<xsl:value-of select="concat($ind3, 'DoError Err.Number, Err.Source, &quot;Unable to Create Object - ', @project, '.', @class, '&quot;', $cr)"/>
			<xsl:value-of select="concat($ind2, 'Else', $cr)"/>

			<xsl:value-of select="concat($ind3, 'With o', @name, $cr)"/>
			<xsl:if test="not($WorkerPage) and not($PagesLanguage='false' or $PageLanguage='false')">
				<xsl:if test="substring(@project,1,3)=$appprefix">
	 				<xsl:value-of select="concat($ind4, '.SysCurrentLanguage = reqSysLanguage', $cr)"/>
				</xsl:if>
			</xsl:if>
			<xsl:if test="/Data/WTPAGE/@multi-instance and substring(@project,1,3)=$appprefix">
	 			<xsl:value-of select="concat($ind4, '.SysClientProject SysClient, SysProject', $cr)"/>
			</xsl:if>

			<xsl:apply-templates select="WTMETHOD | WTSETATTRIBUTES | WTSETATTRIBUTE | WTSETCACHE | WTGETCACHE | WTSETCOOKIE | WTGETCOOKIE | WTREPEAT | WTCODEGROUP | WTCALLSUB | WTCOMMENT | WTCUSTOM | WTMAIL | WTVARIABLE | WTACTIONLOG | WTINPUTOPTIONS | WTHTTP">
				<xsl:with-param name="indent" select="$indent4"/>
			</xsl:apply-templates>

			<xsl:value-of select="concat($ind3, 'End With', $cr)"/>
			<xsl:value-of select="concat($ind2, 'End If', $cr)"/>
			<xsl:if test="(@project)">
				<xsl:value-of select="concat($ind2, 'Set o', @name, ' = Nothing', $cr)"/>
<!--
				<xsl:if test="/Data/WTPAGE/@trace or /Data/WTENTITY/WTWEBPAGE/@trace">
					<xsl:value-of select="concat($ind2, 'Response.AppendToLog &quot;-', @name, '&quot;', $cr)"/>
				</xsl:if>
-->
			</xsl:if>

			<xsl:if test="($hasconditions)">
				<xsl:call-template name="ASPConditionEnd">
					<xsl:with-param name="indent" select="$indent"/>			
				</xsl:call-template>
			</xsl:if>

		</xsl:if>

	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTVARIABLE" mode="docase">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:apply-templates select=".">
			<xsl:with-param name="indent" select="$indent"/>			
		</xsl:apply-templates>
	</xsl:template>
	
	 <!--==================================================================-->
	 <xsl:template match="WTVARIABLE">
	 <!--==================================================================-->
		  <xsl:param name="indent"/>
		  <xsl:variable name="hasconditions" select="(count(WTCONDITION) > 0)"/>
		  <xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		  <xsl:variable name="ind2"><xsl:choose><xsl:when test="($hasconditions)"><xsl:value-of select="concat($ind1, $tab1)"/></xsl:when><xsl:otherwise><xsl:value-of select="$ind1"/></xsl:otherwise></xsl:choose></xsl:variable>
		  <xsl:variable name="indent2"><xsl:choose><xsl:when test="($hasconditions)"><xsl:value-of select="$indent+1"/></xsl:when><xsl:otherwise><xsl:value-of select="$indent"/></xsl:otherwise></xsl:choose></xsl:variable>

	 <!-- ***************** Error Checking *******************-->
	 <xsl:if test="not(@name)">
	     <xsl:call-template name="Error">
	     	<xsl:with-param name="msg" select="'WTVARIABLE Name Missing'"/>
	     	<xsl:with-param name="text" select="position()"/>
	     </xsl:call-template>
	 </xsl:if>
	 <!--Test valid attributes-->
	 <xsl:for-each select="@*">
		  <xsl:choose>
		   <xsl:when test="name()='name'"/>
		   <xsl:when test="name()='value'"/>
		   <xsl:when test="name()='enum'"/>
		  	<xsl:otherwise>
		  		 <xsl:call-template name="Error">
		  			  <xsl:with-param name="msg" select="'WTVARIABLE Invalid Attribute'"/>
		  			  <xsl:with-param name="text" select="name()"/>
	 	  		</xsl:call-template>
		  	</xsl:otherwise>
		  </xsl:choose>
	 </xsl:for-each>
	 <!-- ****************************************************-->

		  <xsl:if test="($hasconditions)">
				<xsl:call-template name="ASPConditionStart">
				<xsl:with-param name="indent" select="$indent"/>
				<xsl:with-param name="conditions" select="WTCONDITION"/>
				</xsl:call-template>
		  </xsl:if>

		  <xsl:value-of select="concat($ind2, @name)"/>

		  <xsl:if test="@value">
				<xsl:variable name="valuetype"><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>
				<xsl:variable name="valuetext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>
				<xsl:call-template name="GetValue">
					 <xsl:with-param name="type" select="$valuetype"/>
					 <xsl:with-param name="text" select="$valuetext"/>
					 <xsl:with-param name="hidden" select="true()"/>
				</xsl:call-template>
		  </xsl:if>

		  <xsl:apply-templates select="WTVALUE"/>

		  <xsl:value-of select="$cr"/>

		  <xsl:if test="($hasconditions)">
				<xsl:call-template name="ASPConditionEnd">
					 <xsl:with-param name="indent" select="$indent"/>			
				</xsl:call-template>
		  </xsl:if>
	 </xsl:template>

	 <!--==================================================================-->
	 <xsl:template match="WTVALUE">
	 <!--==================================================================-->
		  <xsl:variable name="valuetype"><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>
		  <xsl:variable name="valuetext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>

	 <!-- ***************** Error Checking *******************-->
	 <xsl:if test="not(@value)">
	     <xsl:call-template name="Error">
	     	<xsl:with-param name="msg" select="'WTVALUE Value Missing'"/>
	     	<xsl:with-param name="text" select="position()"/>
	     </xsl:call-template>
	 </xsl:if>
	 <!--Test valid attributes-->
	 <xsl:for-each select="@*">
		  <xsl:choose>
		   <xsl:when test="name()='value'"/>
		  	<xsl:otherwise>
		  		 <xsl:call-template name="Error">
		  			  <xsl:with-param name="msg" select="'WTVALUE Invalid Attribute'"/>
		  			  <xsl:with-param name="text" select="name()"/>
	 	  		</xsl:call-template>
		  	</xsl:otherwise>
		  </xsl:choose>
	 </xsl:for-each>
	 <!-- ****************************************************-->

		<xsl:if test="position()=1">
			<xsl:value-of select="' = '"/>
		</xsl:if>
		<xsl:if test="position()&gt;1">
			<xsl:value-of select="' &amp; '"/>
		</xsl:if>
		  
		  <xsl:call-template name="GetValue">
		  	 <xsl:with-param name="type" select="$valuetype"/>
		  	 <xsl:with-param name="text" select="$valuetext"/>
   		 <xsl:with-param name="hidden" select="true()"/>
		  </xsl:call-template>
	 </xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTPREMAIL">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:apply-templates>
			<xsl:with-param name="indent" select="$indent"/>			
		</xsl:apply-templates>
	</xsl:template>
	
	<!--==================================================================-->
	<xsl:template match="WTPOSTMAIL">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:apply-templates>
			<xsl:with-param name="indent" select="$indent"/>			
		</xsl:apply-templates>
	</xsl:template>
	
	<!--==================================================================-->
	<xsl:template match="WTPRESENDMAIL">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:apply-templates>
			<xsl:with-param name="indent" select="$indent"/>			
		</xsl:apply-templates>
	</xsl:template>
	
	<!--==================================================================-->
	<xsl:template match="WTPOSTSENDMAIL">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:apply-templates>
			<xsl:with-param name="indent" select="$indent"/>			
		</xsl:apply-templates>
	</xsl:template>
	
	<!--==================================================================-->
	<xsl:template match="WTMAIL" mode="docase">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:apply-templates select=".">
			<xsl:with-param name="indent" select="$indent"/>			
		</xsl:apply-templates>
	</xsl:template>
	
	<!--==================================================================-->
	<xsl:template match="WTMAIL">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:variable name="hasconditions" select="(count(WTCONDITION) > 0)"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="ind2"><xsl:choose><xsl:when test="($hasconditions)"><xsl:value-of select="concat($ind1, $tab1)"/></xsl:when><xsl:otherwise><xsl:value-of select="$ind1"/></xsl:otherwise></xsl:choose></xsl:variable>
		<xsl:variable name="indent2"><xsl:choose><xsl:when test="($hasconditions)"><xsl:value-of select="($indent+1)"/></xsl:when><xsl:otherwise><xsl:value-of select="$indent"/></xsl:otherwise></xsl:choose></xsl:variable>
		<xsl:variable name="indent3"><xsl:value-of select="($indent2+1)"/></xsl:variable>
		<xsl:variable name="indent4"><xsl:value-of select="($indent3+1)"/></xsl:variable>
		<xsl:variable name="indent5"><xsl:value-of select="($indent4+1)"/></xsl:variable>
		<xsl:variable name="ind3"><xsl:value-of select="concat($ind2, $tab1)"/></xsl:variable>
		<xsl:variable name="ind4"><xsl:value-of select="concat($ind3, $tab1)"/></xsl:variable>
		<xsl:variable name="ind5"><xsl:value-of select="concat($ind4, $tab1)"/></xsl:variable>

		<xsl:variable name="IsMailPage" select="ancestor::WTWEBPAGE[@type='mail']"/>

		<!-- ***************** Error Checking *******************-->
		<xsl:if test="not(@from)">
			<xsl:call-template name="Error">
				<xsl:with-param name="msg" select="'WTMAIL From: Missing'"/>
				<xsl:with-param name="text" select="position()"/>
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="not(@to)">
			<xsl:call-template name="Error">
				<xsl:with-param name="msg" select="'WTMAIL To: Missing'"/>
				<xsl:with-param name="text" select="@from"/>
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="not(@subject)">
			<xsl:call-template name="Error">
				<xsl:with-param name="msg" select="'WTMAIL Subject: Missing'"/>
				<xsl:with-param name="text" select="@from"/>
			</xsl:call-template>
		</xsl:if>
		<!--Test valid attributes-->
		<xsl:for-each select="@*">
			<xsl:choose>
				<xsl:when test="name()='from'"/>
				<xsl:when test="name()='to'"/>
				<xsl:when test="name()='cc'"/>
				<xsl:when test="name()='bcc'"/>
				<xsl:when test="name()='sender'"/>
				<xsl:when test="name()='subject'"/>
				<xsl:when test="name()='subjectlabel'"/>
				<xsl:when test="name()='body'"/>
				<xsl:when test="name()='html'"/>
				<xsl:when test="name()='autotext'"/>
				<xsl:when test="name()='emailtest'"/>
				<xsl:when test="name()='msgfrom'"/>
				<xsl:when test="name()='msgto'"/>
				<xsl:otherwise>
					<xsl:call-template name="Error">
						<xsl:with-param name="msg" select="'WTMAIL Invalid Attribute'"/>
						<xsl:with-param name="text" select="name()"/>
					</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
		<!-- ****************************************************-->

		<xsl:if test="($hasconditions)">
			<xsl:call-template name="ASPConditionStart">
				<xsl:with-param name="indent" select="$indent"/>
				<xsl:with-param name="conditions" select="WTCONDITION"/>
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="not(@emailtest='false')">
			<xsl:value-of select="concat($ind2, 'If InStr(', @from, ', &quot;@&quot;)=0 Then ', @from, ' = &quot;&quot;', $cr)"/>
			<xsl:value-of select="concat($ind2, 'If InStr(', @to, ', &quot;@&quot;)=0 Then ', @to, ' = &quot;&quot;', $cr)"/>
			<xsl:value-of select="concat($ind2, 'If ', @from, ' &lt;&gt; &quot;&quot; And ', @to, ' &lt;&gt; &quot;&quot; Then', $cr)"/>
		</xsl:if>

		<xsl:if test="($IsMailPage)">
			<xsl:call-template name="ASPMailPageHeader">
				<xsl:with-param name="indent" select="$indent"/>
			</xsl:call-template>
		</xsl:if>

		<xsl:apply-templates select="WTPREMAIL">
			<xsl:with-param name="indent" select="$indent"/>
		</xsl:apply-templates>

		<xsl:value-of select="concat($ind3, 'Set oMail = server.CreateObject(&quot;CDO.Message&quot;)', $cr)"/>
		<xsl:value-of select="concat($ind3, 'If oMail Is Nothing Then', $cr)"/>
		<xsl:value-of select="concat($ind4, 'DoError Err.Number, Err.Source, &quot;Unable to Create Object - CDO.Message&quot;', $cr)"/>
		<xsl:value-of select="concat($ind3, 'Else', $cr)"/>

		<xsl:value-of select="concat($ind4, 'With oMail', $cr)"/>
		
		<xsl:if test="@sender">
			<xsl:value-of select="concat($ind5, '.Sender = ', @sender, $cr)"/>
		</xsl:if>
		<xsl:value-of select="concat($ind5, '.From = ', @from, $cr)"/>
		<xsl:value-of select="concat($ind5, '.To = ', @to, $cr)"/>
		<xsl:value-of select="concat($ind5, '.Subject = ', @subject, $cr)"/>
		
		<xsl:if test="@cc">
			<xsl:value-of select="concat($ind5, '.CC = ', @cc, $cr)"/>
		</xsl:if>
		<xsl:if test="@bcc">
			<xsl:value-of select="concat($ind5, '.BCC = ', @bcc, $cr)"/>
		</xsl:if>
		<xsl:if test="@autotext">
			<xsl:value-of select="concat($ind5, '.AutoGenerateTextBody = True', $cr)"/>
		</xsl:if>

		<xsl:choose>
			<xsl:when test="not(@body)">
				<xsl:value-of select="concat($ind5, '.HTMLBody = tmpBody', $cr)"/>
			</xsl:when>
			<xsl:when test="@html">
				<xsl:value-of select="concat($ind5, '.HTMLBody = ', @html, $cr)"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="concat($ind5, '.TextBody = ', @body, $cr)"/>
			</xsl:otherwise>
		</xsl:choose>

		<xsl:apply-templates select="WTPRESENDMAIL">
			<xsl:with-param name="indent" select="$indent"/>
		</xsl:apply-templates>

		<xsl:value-of select="concat($ind5, 'If tmpTest = 0 Then .Send', $cr)"/>

		<xsl:apply-templates select="WTPOSTSENDMAIL">
			<xsl:with-param name="indent" select="$indent"/>
		</xsl:apply-templates>

		<xsl:value-of select="concat($ind4, 'End With', $cr)"/>
		<xsl:value-of select="concat($ind3, 'End If', $cr)"/>
		<xsl:value-of select="concat($ind3, 'Set oMail = Nothing', $cr)"/>

		<xsl:if test="@msgto">
			<xsl:variable name="msgfrom">
				<xsl:if test="@msgfrom"><xsl:value-of select="@msgfrom"/></xsl:if>
				<xsl:if test="not(@msgfrom)">1</xsl:if>
			</xsl:variable>
			<xsl:value-of select="concat($cr, $ind3, 'If ', @msgto, ' &lt;&gt; &quot;&quot; Then ')"/>
			<xsl:value-of select="concat($cr, $ind4, 'SendMsg ', $msgfrom, ', ',  @msgto, ', ',  @subject, ', ')"/>
			<xsl:choose>
				<xsl:when test="not(@body)"><xsl:value-of select="'tmpBody'"/></xsl:when>
				<xsl:when test="@html"><xsl:value-of select="@html"/></xsl:when>
				<xsl:otherwise><xsl:value-of select="@body"/></xsl:otherwise>
			</xsl:choose>
			<xsl:value-of select="concat($cr, $ind3, 'End If')"/>
			<xsl:value-of select="concat($cr, $cr)"/>
		</xsl:if>

		<xsl:if test="not(@emailtest='false')">
			<xsl:value-of select="concat($ind2, 'End If', $cr)"/>
		</xsl:if>

		<xsl:apply-templates select="WTPOSTMAIL">
			<xsl:with-param name="indent" select="$indent"/>
		</xsl:apply-templates>

		<xsl:if test="($hasconditions)">
			<xsl:call-template name="ASPConditionEnd">
				<xsl:with-param name="indent" select="$indent"/>			
			</xsl:call-template>
		</xsl:if>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTREPEAT">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="ind2" select="concat($ind1, $tab1)"/>
		<xsl:variable name="indent2" select="($indent+1)"/>

	 <!-- ***************** Error Checking *******************-->
	 <xsl:if test="not(@entity)">
	     <xsl:call-template name="Error">
	     	<xsl:with-param name="msg" select="'WTREPEAT Entity Missing'"/>
	     	<xsl:with-param name="text" select="position()"/>
	     </xsl:call-template>
	 </xsl:if>
		  <!--Test valid attributes-->
		  <xsl:for-each select="@*">
		    <xsl:choose>
		  		<xsl:when test="name()='entity'"/>
		  		<xsl:otherwise>
		  			 <xsl:call-template name="Error">
		  				  <xsl:with-param name="msg" select="'WTREPEAT Invalid Attribute'"/>
		  				  <xsl:with-param name="text" select="name()"/>
		  				</xsl:call-template>
		  		</xsl:otherwise>
		    </xsl:choose>
		  </xsl:for-each>
	 <!-- ****************************************************-->

		<xsl:value-of select="concat($ind1, 'For Each o', @entity, ' In o', @entity, 's', $cr)"/>

		<xsl:apply-templates select="WTSETATTRIBUTE | WTSETCACHE | WTGETCACHE | WTSETCOOKIE | WTGETCOOKIE">
			<xsl:with-param name="indent" select="$indent2"/>
		</xsl:apply-templates>

		<xsl:apply-templates select="WTOBJECT" mode="docase">
			<xsl:with-param name="indent" select="$indent2"/>
		</xsl:apply-templates>

		<xsl:value-of select="concat($ind1, 'Next', $cr)"/>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTOBJECT" mode="declare">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>

		<!-- ***************** Error Checking *******************-->
		<xsl:if test="not(@name)">
		    <xsl:call-template name="Error">
		    	<xsl:with-param name="msg" select="'WTOBJECT Name Missing'"/>
		    	<xsl:with-param name="text" select="position()"/>
		    </xsl:call-template>
		</xsl:if>
		<xsl:if test="not(@project)">
		    <xsl:call-template name="Error">
		    	<xsl:with-param name="msg" select="'WTOBJECT Project Missing'"/>
		    	<xsl:with-param name="text" select="@name"/>
		    </xsl:call-template>
		</xsl:if>
		<xsl:if test="not(@class)">
		    <xsl:call-template name="Error">
		    	<xsl:with-param name="msg" select="'WTOBJECT Class Missing'"/>
		    	<xsl:with-param name="text" select="@name"/>
		    </xsl:call-template>
		</xsl:if>
			  <!--Test valid attributes-->
			  <xsl:for-each select="@*">
			    <xsl:choose>
			  		<xsl:when test="name()='name'"/>
			  		<xsl:when test="name()='project'"/>
			  		<xsl:when test="name()='class'"/>
			  		<xsl:when test="name()='language'"/>
			  		<xsl:otherwise>
			  			 <xsl:call-template name="Error">
			  				  <xsl:with-param name="msg" select="'WTOBJECT Invalid Attribute'"/>
			  				  <xsl:with-param name="text" select="name()"/>
			  				</xsl:call-template>
			  		</xsl:otherwise>
			    </xsl:choose>
			  </xsl:for-each>
		<!-- ****************************************************-->

		<xsl:if test="position()=1">
			<xsl:call-template name="ASPComment">
				<xsl:with-param name="indent" select="$indent"/>
				<xsl:with-param name="value">object variables</xsl:with-param>
			</xsl:call-template>
		</xsl:if>

		<xsl:value-of select="concat($ind1, 'Dim o', @name, ', xml', @name, $cr)"/>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTDATA" mode="declare">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>

	 <!-- ***************** Error Checking *******************-->
	 <xsl:if test="not(@name)">
	     <xsl:call-template name="Error">
	     	<xsl:with-param name="msg" select="'WTDATA Name Missing'"/>
	     	<xsl:with-param name="text" select="position()"/>
	     </xsl:call-template>
	 </xsl:if>
		  <!--Test valid attributes-->
		  <xsl:for-each select="@*">
		    <xsl:choose>
		  		<xsl:when test="name()='name'"/>
		  		<xsl:otherwise>
		  			 <xsl:call-template name="Error">
		  				  <xsl:with-param name="msg" select="'WTDATA Invalid Attribute'"/>
		  				  <xsl:with-param name="text" select="name()"/>
		  				</xsl:call-template>
		  		</xsl:otherwise>
		    </xsl:choose>
		  </xsl:for-each>
	 <!-- ****************************************************-->

		<xsl:if test="position()=1">
			<xsl:call-template name="ASPComment">
				<xsl:with-param name="indent" select="$indent"/>
				<xsl:with-param name="value">other transaction data variables</xsl:with-param>
			</xsl:call-template>
		</xsl:if>

		<xsl:value-of select="concat($ind1, 'Dim xml', @name, $cr)"/>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTDATATXN" mode="declare">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>

	 <!-- ***************** Error Checking *******************-->
	 <xsl:if test="not(@name)">
	     <xsl:call-template name="Error">
	     	<xsl:with-param name="msg" select="'WTDATATXN Name Missing'"/>
	     	<xsl:with-param name="text" select="position()"/>
	     </xsl:call-template>
	 </xsl:if>
		  <!--Test valid attributes-->
		  <xsl:for-each select="@*">
		    <xsl:choose>
		  		<xsl:when test="name()='name'"/>
		  		<xsl:otherwise>
		  			 <xsl:call-template name="Error">
		  				  <xsl:with-param name="msg" select="'WTDATATXN Invalid Attribute'"/>
		  				  <xsl:with-param name="text" select="name()"/>
		  				</xsl:call-template>
		  		</xsl:otherwise>
		    </xsl:choose>
		  </xsl:for-each>
	 <!-- ****************************************************-->

		<xsl:if test="position()=1">
			<xsl:call-template name="ASPComment">
				<xsl:with-param name="indent" select="$indent"/>
				<xsl:with-param name="value">other transaction data variables</xsl:with-param>
			</xsl:call-template>
		</xsl:if>

		<xsl:value-of select="concat($ind1, 'Dim xml', @name, $cr)"/>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTWEBPAGE/WTPARAM" mode="declare">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>

	 <!-- ***************** Error Checking *******************-->
	 <xsl:if test="not(@name)">
	     <xsl:call-template name="Error">
	     	<xsl:with-param name="msg" select="'WTWEBPAGE/WTPARAM Name Missing'"/>
	     	<xsl:with-param name="text" select="position()"/>
	     </xsl:call-template>
	 </xsl:if>
		  <!--Test valid attributes-->
		  <xsl:for-each select="@*">
		    <xsl:choose>
		  		<xsl:when test="name()='name'"/>
		  		<xsl:when test="name()='datatype'"/>
		  		<xsl:when test="name()='url'"/>
		  		<xsl:when test="name()='private'"/>
		  		<xsl:otherwise>
		  			 <xsl:call-template name="Error">
		  				  <xsl:with-param name="msg" select="'WTWEBPAGE/WTPARAM Invalid Attribute'"/>
		  				  <xsl:with-param name="text" select="name()"/>
		  				</xsl:call-template>
		  		</xsl:otherwise>
		    </xsl:choose>
		  </xsl:for-each>
	 <!-- ****************************************************-->

		<xsl:if test="position()=1">
			<xsl:call-template name="ASPComment">
				<xsl:with-param name="indent" select="$indent"/>
				<xsl:with-param name="value">declare page parameters</xsl:with-param>
			</xsl:call-template>
		</xsl:if>

		<xsl:value-of select="concat($ind1, 'Dim req', @name, $cr)"/>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTWEBPAGE/WTPARAM" mode="fetch">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>

		<xsl:if test="position()=1">
			<xsl:call-template name="ASPComment">
				<xsl:with-param name="indent" select="$indent"/>
				<xsl:with-param name="value">fetch page parameters</xsl:with-param>
			</xsl:call-template>
		</xsl:if>
		<xsl:variable name="convert1">
			<xsl:choose>
				<xsl:when test="(@datatype='number')">Numeric(</xsl:when>
				<xsl:otherwise></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="convert2">
			<xsl:choose>
				<xsl:when test="(@datatype='number')">)</xsl:when>
				<xsl:otherwise></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:choose>
			<xsl:when test="@url">
				<xsl:value-of select="concat($ind1, 'req', @name, ' =  ', $convert1, 'Replace(GetInput(&quot;', @name, '&quot;, reqPageData), &quot;&amp;&quot;, &quot;%26&quot;)', $convert2, $cr)"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="concat($ind1, 'req', @name, ' =  ', $convert1, 'GetInput(&quot;', @name, '&quot;, reqPageData)', $convert2, $cr)"/>
			</xsl:otherwise>
		</xsl:choose>
			
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTWEBPAGE/WTVARIABLE" mode="declare">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>

	 <!-- ***************** Error Checking *******************-->
	 <xsl:if test="not(@name)">
	     <xsl:call-template name="Error">
	     	<xsl:with-param name="msg" select="'WTWEBPAGE/WTVARIABLE Name Missing'"/>
	     	<xsl:with-param name="text" select="position()"/>
	     </xsl:call-template>
	 </xsl:if>
		  <!--Test valid attributes-->
		  <xsl:for-each select="@*">
		    <xsl:choose>
		  		<xsl:when test="name()='name'"/>
		  		<xsl:when test="name()='datatype'"/>
		  		<xsl:otherwise>
		  			 <xsl:call-template name="Error">
		  				  <xsl:with-param name="msg" select="'WTWEBPAGE/WTVARIABLE Invalid Attribute'"/>
		  				  <xsl:with-param name="text" select="name()"/>
		  				</xsl:call-template>
		  		</xsl:otherwise>
		    </xsl:choose>
		  </xsl:for-each>
	 <!-- ****************************************************-->

		<xsl:value-of select="concat($ind1, 'Dim ', @name, $cr)"/>
	</xsl:template>

	 <!--==================================================================-->
	 <xsl:template match="WTMETHOD/WTPARAM">
	 <!--==================================================================-->
		  <xsl:variable name="valuetype"><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>
		  <xsl:variable name="valuetext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>

	 <!-- ***************** Error Checking *******************-->
	 <xsl:if test="not(@name)">
	     <xsl:call-template name="Error">
	     	<xsl:with-param name="msg" select="'WTMETHOD/WTPARAM Name Missing'"/>
	     	<xsl:with-param name="text" select="position()"/>
	     </xsl:call-template>
	 </xsl:if>
	 <xsl:if test="not(@direction)">
	     <xsl:call-template name="Error">
	     	<xsl:with-param name="msg" select="'WTMETHOD/WTPARAM Direction Missing'"/>
	     	<xsl:with-param name="text" select="@name"/>
	     </xsl:call-template>
	 </xsl:if>
	 <xsl:if test="@direction='return' and not(@datatype)">
	     <xsl:call-template name="Error">
	     	<xsl:with-param name="msg" select="'WTMETHOD/WTPARAM Return Data Type Missing'"/>
	     	<xsl:with-param name="text" select="@name"/>
	     </xsl:call-template>
	 </xsl:if>
	 <xsl:if test="@direction!='return' and not(@value)">
	     <xsl:call-template name="Error">
	     	<xsl:with-param name="msg" select="'WTMETHOD/WTPARAM Value Missing'"/>
	     	<xsl:with-param name="text" select="@name"/>
	     </xsl:call-template>
	 </xsl:if>
	 <!-- ****************************************************-->

		  <xsl:variable name="datatype">
				<xsl:call-template name="GetDataType">
					 <xsl:with-param name="type" select="$valuetype"/>			
					 <xsl:with-param name="text" select="$valuetext"/>			
				</xsl:call-template>
		  </xsl:variable>

		  <xsl:variable name="dataconvert">
				<xsl:call-template name="GetDataConvert">
					<xsl:with-param name="type" select="$datatype"/>
				</xsl:call-template>
		  </xsl:variable>
	
			<xsl:value-of select="$dataconvert"/>
			
		  <xsl:call-template name="GetValue">
				<xsl:with-param name="type" select="$valuetype"/>			
				<xsl:with-param name="text" select="$valuetext"/>			
		  </xsl:call-template>

		<xsl:choose>
<!--
			<xsl:when test="($datatype='text')">&quot;</xsl:when>
			<xsl:when test="($datatype='char')">&quot;</xsl:when>
			<xsl:when test="string-length($datatype)&gt;0">)</xsl:when>
-->
			<xsl:when test="string-length($dataconvert)&gt;0">)</xsl:when>
		</xsl:choose>

		<xsl:if test="position() != last()">
			<xsl:value-of select="(', ')"/>
		</xsl:if>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTRETURN" mode="docase">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:variable name="hasconditions" select="(count(WTCONDITION) > 0)"/>
		<xsl:variable name="pageno" select="../../@name"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="ind2"><xsl:choose><xsl:when test="($hasconditions)"><xsl:value-of select="concat($ind1, $tab1)"/></xsl:when><xsl:otherwise><xsl:value-of select="$ind1"/></xsl:otherwise></xsl:choose></xsl:variable>
		<xsl:variable name="indent2"><xsl:choose><xsl:when test="($hasconditions)"><xsl:value-of select="$indent+1"/></xsl:when><xsl:otherwise><xsl:value-of select="$indent"/></xsl:otherwise></xsl:choose></xsl:variable>
		<xsl:variable name="ind3"><xsl:value-of select="concat($ind2, $tab1)"/></xsl:variable>

		<xsl:value-of select="$cr"/>

		<xsl:if test="($hasconditions)">
			<xsl:call-template name="ASPConditionStart">
				<xsl:with-param name="indent" select="$indent"/>
				<xsl:with-param name="conditions" select="WTCONDITION"/>
			</xsl:call-template>
		</xsl:if>

		<xsl:choose>
			<xsl:when test="WTLINK">
				<xsl:apply-templates select="WTLINK">
					<xsl:with-param name="indent" select="$indent2"/>
				</xsl:apply-templates>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="concat($ind2, 'reqReturnURL = GetCache(&quot;', $pageno, 'URL&quot;)', $cr)"/>
				<xsl:value-of select="concat($ind2, 'reqReturnData = GetCache(&quot;', $pageno, 'DATA&quot;)', $cr)"/>
				<xsl:value-of select="concat($ind2, 'SetCache &quot;', $pageno, 'URL&quot;, &quot;&quot;', $cr)"/>
				<xsl:value-of select="concat($ind2, 'SetCache &quot;', $pageno, 'DATA&quot;, &quot;&quot;', $cr)"/>
				<xsl:value-of select="concat($ind2, 'If (Len(reqReturnURL) &gt; 0) Then', $cr)"/>
				<xsl:value-of select="concat($ind3, 'SetCache &quot;RETURNURL&quot;, reqReturnURL', $cr)"/>
				<xsl:value-of select="concat($ind3, 'SetCache &quot;RETURNDATA&quot;, reqReturnData', $cr)"/>
				<xsl:value-of select="concat($ind3, 'Response.Redirect Replace(reqReturnURL, &quot;%26&quot;, &quot;&amp;&quot;)', $cr)"/>
				<xsl:value-of select="concat($ind2, 'End If', $cr)"/>
			</xsl:otherwise>
		</xsl:choose>

		<xsl:if test="($hasconditions)">
			<xsl:call-template name="ASPConditionEnd">
				<xsl:with-param name="indent" select="$indent"/>			
			</xsl:call-template>
		</xsl:if>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTLINK">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="ind2"><xsl:value-of select="concat($ind1, $tab1)"/></xsl:variable>
		<xsl:variable name="pageno" select="ancestor::WTWEBPAGE/@name"/>

		<xsl:variable name="secure">
			<xsl:choose>
				<xsl:when test="@secure"><xsl:value-of select="@secure"/></xsl:when>
				<xsl:when test="/Data/WTENTITY/WTWEBPAGE/@secure"><xsl:value-of select="/Data/WTENTITY/WTWEBPAGE/@secure"/></xsl:when>
				<xsl:when test="/Data/WTPAGE/@secure"><xsl:value-of select="/Data/WTPAGE/@secure"/></xsl:when>
			</xsl:choose>
		</xsl:variable>

	 <!-- ***************** Error Checking *******************-->
	 <xsl:if test="not(@name)">
	     <xsl:call-template name="Error">
	     	<xsl:with-param name="msg" select="'WTLINK Name Missing'"/>
	     	<xsl:with-param name="text" select="position()"/>
	     </xsl:call-template>
	 </xsl:if>
	 <!--Test valid attributes-->
	 <xsl:for-each select="@*">
		  <xsl:choose>
				<xsl:when test="name()='name'"/>
				<xsl:when test="name()='nodata'"/>
				<xsl:when test="name()='nolocaldata'"/>
				<xsl:when test="name()='skipreturn'"/>
				<xsl:when test="name()='return'"/>
				<xsl:when test="name()='secure'"/>
				<xsl:when test="name()='custom'"/>
				<xsl:when test="name()='noquote'"/>
				<xsl:otherwise>
					 <xsl:call-template name="Error">
						  <xsl:with-param name="msg" select="'WTLINK Invalid Attribute'"/>
						  <xsl:with-param name="text" select="name()"/>
	 				</xsl:call-template>
				</xsl:otherwise>
		  </xsl:choose>
	 </xsl:for-each>
	 <!-- ****************************************************-->

		<!--create the link-->
		<xsl:choose>
			<xsl:when test="@custom">
				<xsl:if test="@noquote">
					<xsl:value-of select="concat($ind1, 'Response.Redirect ', @name )"/>
				</xsl:if>
				<xsl:if test="not(@noquote)">
					<xsl:value-of select="concat($ind1, 'Response.Redirect &quot;', @name, '&quot;')"/>
				</xsl:if>
			</xsl:when>
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="$secure='true'">
						<xsl:value-of select="concat($ind1, 'If reqSysServerName &lt;&gt; &quot;localhost&quot; Then', $cr)"/>
						<xsl:value-of select="concat($ind2, 'tmpRedirect = &quot;https://&quot; + reqSysServerName + reqSysServerPath', $cr)"/>
						<xsl:value-of select="concat($ind1, 'End If', $cr)"/>
						<xsl:value-of select="concat($ind1, 'Response.Redirect tmpRedirect + &quot;', @name, '.asp&quot;')"/>
					</xsl:when>
					<xsl:when test="$secure='false'">
						<xsl:value-of select="concat($ind2, 'tmpRedirect = &quot;http://&quot; + reqSysServerName + reqSysServerPath', $cr)"/>
						<xsl:value-of select="concat($ind1, 'Response.Redirect tmpRedirect + &quot;', @name, '.asp&quot;')"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="concat($ind1, 'Response.Redirect &quot;', @name, '.asp&quot;')"/>
					</xsl:otherwise>
				</xsl:choose>
				
				<xsl:apply-templates select="WTPARAM"/>

				<!--add return URL parameters-->
				<xsl:if test="not(@return='false')">
					<xsl:if test="not(@nodata)">
					  <xsl:choose>
					  	<xsl:when test="(count(WTPARAM)=0)"><xsl:text> &amp; &quot;?</xsl:text></xsl:when>
					  	<xsl:otherwise><xsl:text> &amp; &quot;&amp;</xsl:text></xsl:otherwise>
					  </xsl:choose>
					</xsl:if>
					<xsl:choose>
						<xsl:when test="@skipreturn">
							<xsl:value-of select="concat('ReturnURL=&quot; &amp; GetCache(&quot;', $pageno, 'URL&quot;)')"/>
						</xsl:when>
						<xsl:when test="@nolocaldata">
							<xsl:value-of select="concat($tab0, 'ReturnURL=&quot; &amp; reqPageURL')"/>
<!--							<xsl:value-of select="' &amp; &quot;&amp;ReturnData=&quot; &amp; Request.Item(&quot;ReturnData&quot;)'"/>-->
						</xsl:when>
						<xsl:when test="not(@nodata)">
							<xsl:value-of select="concat($tab0, 'ReturnURL=&quot; &amp; reqPageURL')"/>
							<xsl:value-of select="' &amp; &quot;&amp;ReturnData=&quot; &amp; reqPageData'"/>
						</xsl:when>
					</xsl:choose>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>

<!--		<xsl:if test="@target"><xsl:value-of select="concat($ind1, '&lt;xsl:attribute name=&quot;target&quot;&gt;',@target, '&lt;/xsl:attribute&gt;', $cr)"/></xsl:if>		-->

		<xsl:value-of select="$cr"/>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTLINK/WTPARAM">
	<!--==================================================================-->
		<xsl:variable name="valuetype"><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>
		<xsl:variable name="valuetext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>

	 <!-- ***************** Error Checking *******************-->
	 <xsl:if test="not(@name)">
	     <xsl:call-template name="Error">
	     	<xsl:with-param name="msg" select="'WTLINK/WTPARAM Name Missing'"/>
	     	<xsl:with-param name="text" select="position()"/>
	     </xsl:call-template>
	 </xsl:if>
	 <xsl:if test="not(@value)">
	     <xsl:call-template name="Error">
	     	<xsl:with-param name="msg" select="'WTLINK/WTPARAM Value Missing'"/>
	     	<xsl:with-param name="text" select="@name"/>
	     </xsl:call-template>
	 </xsl:if>
	 <!--Test valid attributes-->
	 <xsl:for-each select="@*">
		  <xsl:choose>
				<xsl:when test="name()='name'"/>
				<xsl:when test="name()='value'"/>
				<xsl:otherwise>
					 <xsl:call-template name="Error">
						  <xsl:with-param name="msg" select="'WTLINK/WTPARAM Invalid Attribute'"/>
						  <xsl:with-param name="text" select="name()"/>
	 				</xsl:call-template>
				</xsl:otherwise>
		  </xsl:choose>
	 </xsl:for-each>
	 <!-- ****************************************************-->

		<xsl:choose>
			<xsl:when test="(position() = '1')"><xsl:value-of select="concat(' &amp; &quot;?', @name, '=&quot; &amp; ')"/></xsl:when>
			<xsl:otherwise><xsl:value-of select="concat(' &amp; &quot;&amp;', @name, '=&quot; &amp; ')"/></xsl:otherwise>
		</xsl:choose>

		  <xsl:call-template name="GetValue">
				<xsl:with-param name="type" select="$valuetype"/>			
				<xsl:with-param name="text" select="$valuetext"/>			
		  </xsl:call-template>

	</xsl:template>


	<!--==================================================================-->
	<xsl:template match="WTOBJECT/WTSETATTRIBUTES">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="object" select="../@name"/>
<!--
		<xsl:variable name="unique-attributes" select="/Data/WTENTITY/WTWEBPAGE/WTCONTENT/WTROW/*[@value][generate-id() = generate-id(key('key-attributes',@value))]"/>
-->
		<xsl:value-of select="$cr"/>
		
		<xsl:for-each select="/Data/WTENTITY/WTWEBPAGE/WTCONTENT/descendant::*[@value and not(@data='false')]">
			<xsl:variable name="valuetype"><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>
			<xsl:variable name="valuetext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>
			<xsl:variable name="valueentity"><xsl:call-template name="QualifiedPrefix"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>

			<xsl:if test="($valuetype='ATTR') and ($valueentity=$object)">
				<xsl:if test="(name()='WTTEXT') or (name()='WTCHECK') or (name()='WTCOMBO') or (name()='WTMEMO') or (name()='WTFILE')">
	 				<xsl:value-of select="concat($ind1, '.', $valuetext, ' = Request.Form.Item(&quot;', $valuetext, '&quot;)', $cr)"/>
				</xsl:if>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTSETATTRIBUTE" mode="docase">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:apply-templates select=".">
			<xsl:with-param name="indent" select="$indent"/>			
		</xsl:apply-templates>
	</xsl:template>
	
	<!--==================================================================-->
	<xsl:template match="WTSETATTRIBUTE">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:variable name="hasconditions" select="(count(WTCONDITION) > 0)"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="ind2"><xsl:choose><xsl:when test="($hasconditions)"><xsl:value-of select="concat($ind1, $tab1)"/></xsl:when><xsl:otherwise><xsl:value-of select="$ind1"/></xsl:otherwise></xsl:choose></xsl:variable>

		<xsl:variable name="nametype"><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="@name"/></xsl:call-template></xsl:variable>
		<xsl:variable name="nametext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@name"/></xsl:call-template></xsl:variable>
		<xsl:variable name="nameentity"><xsl:call-template name="QualifiedPrefix"><xsl:with-param name="value" select="@name"/></xsl:call-template></xsl:variable>
		<xsl:variable name="valuetype"><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>
		<xsl:variable name="valuetext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>
		<xsl:variable name="valueentity"><xsl:call-template name="QualifiedPrefix"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>
		<xsl:variable name="idtype"><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="@id"/></xsl:call-template></xsl:variable>
		<xsl:variable name="idtext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@id"/></xsl:call-template></xsl:variable>
		<xsl:variable name="identity"><xsl:call-template name="QualifiedPrefix"><xsl:with-param name="value" select="@id"/></xsl:call-template></xsl:variable>

	 <!-- ***************** Error Checking *******************-->
	 <xsl:if test="not(@name)">
	     <xsl:call-template name="Error">
	     	<xsl:with-param name="msg" select="'WTSETATTRIBUTE Name Missing'"/>
	     	<xsl:with-param name="text" select="position()"/>
	     </xsl:call-template>
	 </xsl:if>
	 <xsl:if test="not(@value)">
	     <xsl:call-template name="Error">
	     	<xsl:with-param name="msg" select="'WTSETATTRIBUTE Value Missing'"/>
	     	<xsl:with-param name="text" select="@name"/>
	     </xsl:call-template>
	 </xsl:if>
	 <!--Test valid attributes-->
	 <xsl:for-each select="@*">
		  <xsl:choose>
				<xsl:when test="name()='name'"/>
				<xsl:when test="name()='value'"/>
				<xsl:when test="name()='id'"/>
				<xsl:when test="name()='datatype'"/>
				<xsl:otherwise>
					 <xsl:call-template name="Error">
						  <xsl:with-param name="msg" select="'WTSETATTRIBUTE Invalid Attribute'"/>
						  <xsl:with-param name="text" select="name()"/>
	 				</xsl:call-template>
				</xsl:otherwise>
		  </xsl:choose>
	 </xsl:for-each>
	 <!-- ****************************************************-->

		<xsl:if test="($hasconditions)">
			<xsl:call-template name="ASPConditionStart">
				<xsl:with-param name="indent" select="$indent"/>
				<xsl:with-param name="conditions" select="WTCONDITION"/>
			</xsl:call-template>
		</xsl:if>

		<xsl:variable name="var">
		  	<xsl:call-template name="GetValue">
		  	    <xsl:with-param name="type" select="$nametype"/>
		  	    <xsl:with-param name="text" select="$nametext"/>
				<xsl:with-param name="entity" select="$nameentity"/>
		  	</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="convert1">
			<xsl:choose>
				<xsl:when test="(@datatype='number')">Numeric(</xsl:when>
				<xsl:otherwise></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="convert2">
			<xsl:choose>
				<xsl:when test="(@datatype='number')">)</xsl:when>
				<xsl:otherwise></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		  <xsl:value-of select="concat($ind2, $var, ' = ', $convert1)"/>

		  <xsl:choose>
				<xsl:when test="($valuetype='FORM') and (@id)"><xsl:value-of select="concat('Request.Form.Item(&quot;', $valuetext, '&quot; + CStr(.', $idtext, '))', $convert2, $cr)"/></xsl:when>
				<xsl:otherwise>
					 <xsl:call-template name="GetValue">
						  <xsl:with-param name="type" select="$valuetype"/>			
						  <xsl:with-param name="text" select="$valuetext"/>			
						  <xsl:with-param name="entity" select="$valueentity"/>
					 </xsl:call-template>
				  <xsl:value-of select="concat($convert2, $cr)"/>
				</xsl:otherwise>			  
		  </xsl:choose>

		<xsl:if test="($hasconditions)">
			<xsl:call-template name="ASPConditionEnd">
				<xsl:with-param name="indent" select="$indent"/>			
			</xsl:call-template>
		</xsl:if>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTSETCACHE" mode="docase">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:apply-templates select=".">
			<xsl:with-param name="indent" select="$indent"/>			
		</xsl:apply-templates>
	</xsl:template>
	
	<!--==================================================================-->
	<xsl:template match="WTSETCACHE">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:variable name="hasconditions" select="(count(WTCONDITION) > 0)"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="ind2"><xsl:choose><xsl:when test="($hasconditions)"><xsl:value-of select="concat($ind1, $tab1)"/></xsl:when><xsl:otherwise><xsl:value-of select="$ind1"/></xsl:otherwise></xsl:choose></xsl:variable>

		<xsl:variable name="nametype"><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="@name"/></xsl:call-template></xsl:variable>
		<xsl:variable name="nametext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@name"/></xsl:call-template></xsl:variable>
		<xsl:variable name="nameentity"><xsl:call-template name="QualifiedPrefix"><xsl:with-param name="value" select="@name"/></xsl:call-template></xsl:variable>
		<xsl:variable name="valuetype"><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>
		<xsl:variable name="valuetext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>
		<xsl:variable name="valueentity"><xsl:call-template name="QualifiedPrefix"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>

	 <!-- ***************** Error Checking *******************-->
	 <xsl:if test="not(@name)">
	     <xsl:call-template name="Error">
	     	<xsl:with-param name="msg" select="'WTSETCACHE Name Missing'"/>
	     	<xsl:with-param name="text" select="position()"/>
	     </xsl:call-template>
	 </xsl:if>
	 <xsl:if test="not(@value)">
	     <xsl:call-template name="Error">
	     	<xsl:with-param name="msg" select="'WTSETCACHE Value Missing'"/>
	     	<xsl:with-param name="text" select="@name"/>
	     </xsl:call-template>
	 </xsl:if>
	 <!--Test valid attributes-->
	 <xsl:for-each select="@*">
		  <xsl:choose>
				<xsl:when test="name()='name'"/>
				<xsl:when test="name()='value'"/>
				<xsl:otherwise>
					 <xsl:call-template name="Error">
						  <xsl:with-param name="msg" select="'WTSETCACHE Invalid Attribute'"/>
						  <xsl:with-param name="text" select="name()"/>
	 				</xsl:call-template>
				</xsl:otherwise>
		  </xsl:choose>
	 </xsl:for-each>
	 <!-- ****************************************************-->

		<xsl:if test="($hasconditions)">
			<xsl:call-template name="ASPConditionStart">
				<xsl:with-param name="indent" select="$indent"/>
				<xsl:with-param name="conditions" select="WTCONDITION"/>
			</xsl:call-template>
		</xsl:if>

		  <xsl:value-of select="concat($ind2, 'SetCache &quot;')"/>

		  <xsl:variable name="value">
		  	 <xsl:call-template name="GetValue">
		  	     <xsl:with-param name="type" select="$nametype"/>
		  	     <xsl:with-param name="text" select="$nametext"/>
				 <xsl:with-param name="entity" select="$nameentity"/>
		  	 </xsl:call-template>
		  </xsl:variable>
		  <xsl:choose>
		  	 <xsl:when test="substring($value,1,6) = 'reqSys'">
		  	 	 <xsl:call-template name="CaseUpper">
		  	 	 	<xsl:with-param name="value" select="substring($value,7)"/>
		  	 	 </xsl:call-template>
		  	 </xsl:when>
		  	 <xsl:when test="substring($value,1,3) = 'req'">
		  	 	 <xsl:call-template name="CaseUpper">
		  	 	 	<xsl:with-param name="value" select="substring($value,4)"/>
		  	 	 </xsl:call-template>
		  	 </xsl:when>
		  	 <xsl:otherwise>
		  	 	 <xsl:call-template name="CaseUpper">
		  	 	 	<xsl:with-param name="value" select="$value"/>
		  	 	 </xsl:call-template>
		  	 </xsl:otherwise>
		  </xsl:choose>
		  
		  
		  <xsl:value-of select="'&quot;, '"/>

		  <xsl:call-template name="GetValue">
				<xsl:with-param name="type" select="$valuetype"/>			
				<xsl:with-param name="text" select="$valuetext"/>			
				<xsl:with-param name="entity" select="$valueentity"/>
		  </xsl:call-template>

		  <xsl:value-of select="$cr"/>

		<xsl:if test="($hasconditions)">
			<xsl:call-template name="ASPConditionEnd">
				<xsl:with-param name="indent" select="$indent"/>			
			</xsl:call-template>
		</xsl:if>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTGETCACHE" mode="docase">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:apply-templates select=".">
			<xsl:with-param name="indent" select="$indent"/>			
		</xsl:apply-templates>
	</xsl:template>
	
	<!--==================================================================-->
	<xsl:template match="WTGETCACHE">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:variable name="hasconditions" select="(count(WTCONDITION) > 0)"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="ind2"><xsl:choose><xsl:when test="($hasconditions)"><xsl:value-of select="concat($ind1, $tab1)"/></xsl:when><xsl:otherwise><xsl:value-of select="$ind1"/></xsl:otherwise></xsl:choose></xsl:variable>

		<xsl:variable name="nametype"><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="@name"/></xsl:call-template></xsl:variable>
		<xsl:variable name="nametext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@name"/></xsl:call-template></xsl:variable>
		<xsl:variable name="nameentity"><xsl:call-template name="QualifiedPrefix"><xsl:with-param name="value" select="@name"/></xsl:call-template></xsl:variable>
		<xsl:variable name="valuetype"><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>
		<xsl:variable name="valuetext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>
		<xsl:variable name="valueentity"><xsl:call-template name="QualifiedPrefix"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>

	 <!-- ***************** Error Checking *******************-->
	 <xsl:if test="not(@name)">
	     <xsl:call-template name="Error">
	     	<xsl:with-param name="msg" select="'WTGETCACHE Name Missing'"/>
	     	<xsl:with-param name="text" select="position()"/>
	     </xsl:call-template>
	 </xsl:if>
	 <xsl:if test="not(@value)">
	     <xsl:call-template name="Error">
	     	<xsl:with-param name="msg" select="'WTGETCACHE Value Missing'"/>
	     	<xsl:with-param name="text" select="@name"/>
	     </xsl:call-template>
	 </xsl:if>
	 <!--Test valid attributes-->
	 <xsl:for-each select="@*">
		  <xsl:choose>
				<xsl:when test="name()='name'"/>
				<xsl:when test="name()='value'"/>
				<xsl:when test="name()='datatype'"/>
				<xsl:otherwise>
					 <xsl:call-template name="Error">
						  <xsl:with-param name="msg" select="'WTGETCACHE Invalid Attribute'"/>
						  <xsl:with-param name="text" select="name()"/>
	 				</xsl:call-template>
				</xsl:otherwise>
		  </xsl:choose>
	 </xsl:for-each>
	 <!-- ****************************************************-->

		<xsl:if test="($hasconditions)">
			<xsl:call-template name="ASPConditionStart">
				<xsl:with-param name="indent" select="$indent"/>
				<xsl:with-param name="conditions" select="WTCONDITION"/>
			</xsl:call-template>
		</xsl:if>

		<xsl:variable name="var">
		  	<xsl:call-template name="GetValue">
		  	    <xsl:with-param name="type" select="$nametype"/>
		  	    <xsl:with-param name="text" select="$nametext"/>
				<xsl:with-param name="entity" select="$nameentity"/>
		  	</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="convert1">
			<xsl:choose>
				<xsl:when test="(@datatype='number')">Numeric(</xsl:when>
				<xsl:otherwise></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="convert2">
			<xsl:choose>
				<xsl:when test="(@datatype='number')">)</xsl:when>
				<xsl:otherwise></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		  <xsl:value-of select="concat($ind2, $var, ' = ', $convert1, 'GetCache(&quot;')"/>

		  <xsl:variable name="value">
		  	 <xsl:call-template name="GetValue">
		  	     <xsl:with-param name="type" select="$valuetype"/>
		  	     <xsl:with-param name="text" select="$valuetext"/>
				 <xsl:with-param name="entity" select="$valueentity"/>
		  	 </xsl:call-template>
		  </xsl:variable>
		  <xsl:choose>
		  	 <xsl:when test="substring($value,1,6) = 'reqSys'">
		  	 	 <xsl:call-template name="CaseUpper">
		  	 	 	<xsl:with-param name="value" select="substring($value,7)"/>
		  	 	 </xsl:call-template>
		  	 </xsl:when>
		  	 <xsl:when test="substring($value,1,3) = 'req'">
		  	 	 <xsl:call-template name="CaseUpper">
		  	 	 	<xsl:with-param name="value" select="substring($value,4)"/>
		  	 	 </xsl:call-template>
		  	 </xsl:when>
		  	 <xsl:otherwise>
		  	 	 <xsl:call-template name="CaseUpper">
		  	 	 	<xsl:with-param name="value" select="$value"/>
		  	 	 </xsl:call-template>
		  	 </xsl:otherwise>
		  </xsl:choose>
		  <xsl:value-of select="concat('&quot;)', $convert2, $cr)"/>

		<xsl:if test="($hasconditions)">
			<xsl:call-template name="ASPConditionEnd">
				<xsl:with-param name="indent" select="$indent"/>			
			</xsl:call-template>
		</xsl:if>
	</xsl:template>


	<!--==================================================================-->
	<xsl:template match="WTSETCOOKIE" mode="docase">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:apply-templates select=".">
			<xsl:with-param name="indent" select="$indent"/>			
		</xsl:apply-templates>
	</xsl:template>
	
	<!--==================================================================-->
	<xsl:template match="WTSETCOOKIE">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:variable name="hasconditions" select="(count(WTCONDITION) > 0)"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="ind2"><xsl:choose><xsl:when test="($hasconditions)"><xsl:value-of select="concat($ind1, $tab1)"/></xsl:when><xsl:otherwise><xsl:value-of select="$ind1"/></xsl:otherwise></xsl:choose></xsl:variable>

		<xsl:variable name="nametype"><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="@name"/></xsl:call-template></xsl:variable>
		<xsl:variable name="nametext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@name"/></xsl:call-template></xsl:variable>
		<xsl:variable name="nameentity"><xsl:call-template name="QualifiedPrefix"><xsl:with-param name="value" select="@name"/></xsl:call-template></xsl:variable>
		<xsl:variable name="valuetype"><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>
		<xsl:variable name="valuetext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>
		<xsl:variable name="valueentity"><xsl:call-template name="QualifiedPrefix"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>

	 <!-- ***************** Error Checking *******************-->
	 <xsl:if test="not(@name)">
	     <xsl:call-template name="Error">
	     	<xsl:with-param name="msg" select="'WTSETCOOKIE Name Missing'"/>
	     	<xsl:with-param name="text" select="position()"/>
	     </xsl:call-template>
	 </xsl:if>
	 <xsl:if test="not(@value)">
	     <xsl:call-template name="Error">
	     	<xsl:with-param name="msg" select="'WTSETCOOKIE Value Missing'"/>
	     	<xsl:with-param name="text" select="@name"/>
	     </xsl:call-template>
	 </xsl:if>
	 <!--Test valid attributes-->
	 <xsl:for-each select="@*">
		  <xsl:choose>
				<xsl:when test="name()='name'"/>
				<xsl:when test="name()='value'"/>
				<xsl:otherwise>
					 <xsl:call-template name="Error">
						  <xsl:with-param name="msg" select="'WTSETCOOKIE Invalid Attribute'"/>
						  <xsl:with-param name="text" select="name()"/>
	 				</xsl:call-template>
				</xsl:otherwise>
		  </xsl:choose>
	 </xsl:for-each>
	 <!-- ****************************************************-->

		<xsl:if test="($hasconditions)">
			<xsl:call-template name="ASPConditionStart">
				<xsl:with-param name="indent" select="$indent"/>
				<xsl:with-param name="conditions" select="WTCONDITION"/>
			</xsl:call-template>
		</xsl:if>

		  <xsl:value-of select="concat($ind2, 'SetCookie &quot;')"/>

		  <xsl:variable name="value">
		  	 <xsl:call-template name="GetValue">
		  	     <xsl:with-param name="type" select="$nametype"/>
		  	     <xsl:with-param name="text" select="$nametext"/>
				 <xsl:with-param name="entity" select="$nameentity"/>
		  	 </xsl:call-template>
		  </xsl:variable>
		  <xsl:choose>
		  	 <xsl:when test="substring($value,1,6) = 'reqSys'">
		  	 	 <xsl:call-template name="CaseUpper">
		  	 	 	<xsl:with-param name="value" select="substring($value,7)"/>
		  	 	 </xsl:call-template>
		  	 </xsl:when>
		  	 <xsl:when test="substring($value,1,3) = 'req'">
		  	 	 <xsl:call-template name="CaseUpper">
		  	 	 	<xsl:with-param name="value" select="substring($value,4)"/>
		  	 	 </xsl:call-template>
		  	 </xsl:when>
		  	 <xsl:otherwise>
		  	 	 <xsl:call-template name="CaseUpper">
		  	 	 	<xsl:with-param name="value" select="$value"/>
		  	 	 </xsl:call-template>
		  	 </xsl:otherwise>
		  </xsl:choose>
		  
		  <xsl:value-of select="'&quot;, '"/>

		  <xsl:call-template name="GetValue">
				<xsl:with-param name="type" select="$valuetype"/>			
				<xsl:with-param name="text" select="$valuetext"/>			
				<xsl:with-param name="entity" select="$valueentity"/>
		  </xsl:call-template>

		  <xsl:value-of select="$cr"/>

		<xsl:if test="($hasconditions)">
			<xsl:call-template name="ASPConditionEnd">
				<xsl:with-param name="indent" select="$indent"/>			
			</xsl:call-template>
		</xsl:if>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTGETCOOKIE" mode="docase">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:apply-templates select=".">
			<xsl:with-param name="indent" select="$indent"/>			
		</xsl:apply-templates>
	</xsl:template>
	
	<!--==================================================================-->
	<xsl:template match="WTGETCOOKIE">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:variable name="hasconditions" select="(count(WTCONDITION) > 0)"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="ind2"><xsl:choose><xsl:when test="($hasconditions)"><xsl:value-of select="concat($ind1, $tab1)"/></xsl:when><xsl:otherwise><xsl:value-of select="$ind1"/></xsl:otherwise></xsl:choose></xsl:variable>

		<xsl:variable name="nametype"><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="@name"/></xsl:call-template></xsl:variable>
		<xsl:variable name="nametext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@name"/></xsl:call-template></xsl:variable>
		<xsl:variable name="nameentity"><xsl:call-template name="QualifiedPrefix"><xsl:with-param name="value" select="@name"/></xsl:call-template></xsl:variable>
		<xsl:variable name="valuetype"><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>
		<xsl:variable name="valuetext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>
		<xsl:variable name="valueentity"><xsl:call-template name="QualifiedPrefix"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>

	 <!-- ***************** Error Checking *******************-->
	 <xsl:if test="not(@name)">
	     <xsl:call-template name="Error">
	     	<xsl:with-param name="msg" select="'WTGETCOOKIE Name Missing'"/>
	     	<xsl:with-param name="text" select="position()"/>
	     </xsl:call-template>
	 </xsl:if>
	 <xsl:if test="not(@value)">
	     <xsl:call-template name="Error">
	     	<xsl:with-param name="msg" select="'WTGETCOOKIE Value Missing'"/>
	     	<xsl:with-param name="text" select="@name"/>
	     </xsl:call-template>
	 </xsl:if>
	 <!--Test valid attributes-->
	 <xsl:for-each select="@*">
		  <xsl:choose>
				<xsl:when test="name()='name'"/>
				<xsl:when test="name()='value'"/>
        <xsl:when test="name()='datatype'"/>
        <xsl:otherwise>
					 <xsl:call-template name="Error">
						  <xsl:with-param name="msg" select="'WTGETCOOKIE Invalid Attribute'"/>
						  <xsl:with-param name="text" select="name()"/>
	 				</xsl:call-template>
				</xsl:otherwise>
		  </xsl:choose>
	 </xsl:for-each>
	 <!-- ****************************************************-->

		<xsl:if test="($hasconditions)">
			<xsl:call-template name="ASPConditionStart">
				<xsl:with-param name="indent" select="$indent"/>
				<xsl:with-param name="conditions" select="WTCONDITION"/>
			</xsl:call-template>
		</xsl:if>
    <xsl:variable name="var">
      <xsl:call-template name="GetValue">
        <xsl:with-param name="type" select="$nametype"/>
        <xsl:with-param name="text" select="$nametext"/>
        <xsl:with-param name="entity" select="$nameentity"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="convert1">
      <xsl:choose>
        <xsl:when test="(@datatype='number')">Numeric(</xsl:when>
        <xsl:otherwise></xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="convert2">
      <xsl:choose>
        <xsl:when test="(@datatype='number')">)</xsl:when>
        <xsl:otherwise></xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:value-of select="concat($ind2, $var, ' = ', $convert1, 'GetCookie(&quot;')"/>

    <xsl:variable name="value">
		  	 <xsl:call-template name="GetValue">
		  	     <xsl:with-param name="type" select="$valuetype"/>
		  	     <xsl:with-param name="text" select="$valuetext"/>
				 <xsl:with-param name="entity" select="$valueentity"/>
		  	 </xsl:call-template>
		  </xsl:variable>
		  <xsl:choose>
		  	 <xsl:when test="substring($value,1,6) = 'reqSys'">
		  	 	 <xsl:call-template name="CaseUpper">
		  	 	 	<xsl:with-param name="value" select="substring($value,7)"/>
		  	 	 </xsl:call-template>
		  	 </xsl:when>
		  	 <xsl:when test="substring($value,1,3) = 'req'">
		  	 	 <xsl:call-template name="CaseUpper">
		  	 	 	<xsl:with-param name="value" select="substring($value,4)"/>
		  	 	 </xsl:call-template>
		  	 </xsl:when>
		  	 <xsl:otherwise>
		  	 	 <xsl:call-template name="CaseUpper">
		  	 	 	<xsl:with-param name="value" select="$value"/>
		  	 	 </xsl:call-template>
		  	 </xsl:otherwise>
		  </xsl:choose>
      <xsl:value-of select="concat('&quot;)', $convert2, $cr)"/>

    <xsl:if test="($hasconditions)">
			<xsl:call-template name="ASPConditionEnd">
				<xsl:with-param name="indent" select="$indent"/>			
			</xsl:call-template>
		</xsl:if>
	</xsl:template>
	<!--==================================================================-->
	<!--==================================================================-->
	<!-- END NEW TEMPLATES -->
	<!--==================================================================-->
	<!--==================================================================-->


	<!--==================================================================-->
	<!-- TEMPLATE: ASP PARAM-->
	<!-- returns the VB Script for a single parameter -->
	<!--==================================================================-->
	<xsl:template name="ASPParam">
		<xsl:param name="parameter"/>
		<xsl:param name="name"/>
		<xsl:param name="inout"/>
		<xsl:param name="value"/>
		<xsl:param name="type"/>
		<xsl:param name="length"/>
		<xsl:param name="continue" select="true()"/>

		<xsl:variable name="nametype">
			<xsl:choose>
				<xsl:when test="$name"><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="$name"/></xsl:call-template></xsl:when>	
				<xsl:otherwise><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="$parameter/@name"/></xsl:call-template></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="nametext">
			<xsl:choose>
				<xsl:when test="$name"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="$name"/></xsl:call-template></xsl:when>
				<xsl:otherwise><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="$parameter/@name"/></xsl:call-template></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="valuetype">
			<xsl:choose>
				<xsl:when test="$value"><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="$value"/></xsl:call-template></xsl:when>	
				<xsl:otherwise><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="$parameter/@value"/></xsl:call-template></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="valuetext">
			<xsl:choose>
				<xsl:when test="$value"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="$value"/></xsl:call-template></xsl:when>
				<xsl:otherwise><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="$parameter/@value"/></xsl:call-template></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="direction">
			<xsl:choose>
				<xsl:when test="$inout"><xsl:value-of select="$inout"/></xsl:when>
				<xsl:otherwise><xsl:value-of select="$parameter/@direction"/></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="datatype">
			<xsl:choose>
				<xsl:when test="$type"><xsl:value-of select="$type"/></xsl:when>
				<xsl:otherwise>
					 <xsl:call-template name="GetDataType">
					     <xsl:with-param name="type" select="$valuetype"/>
					     <xsl:with-param name="text" select="$valuetext"/>
					 </xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		
		<xsl:variable name="datalength">
			<xsl:choose>
				<xsl:when test="$length"><xsl:value-of select="$length"/></xsl:when>
				<xsl:when test="($valuetype='ATTR')"><xsl:value-of select="/Data/WTENTITY/WTATTRIBUTE[@name=$valuetext]/@length"/></xsl:when>
				<xsl:when test="($valuetype='CONST')"><xsl:value-of select="$parameter/@length"/></xsl:when>
				<xsl:when test="($valuetype='CONFIG') and ($valuetext='documentpath')">255</xsl:when>
				<xsl:when test="($valuetype='SYS') and ($valuetext='username')">32</xsl:when>
			</xsl:choose>
		</xsl:variable>
		
		  <xsl:variable name="dataconvert">
				<xsl:call-template name="GetDataConvert">
					<xsl:with-param name="type" select="$datatype"/>
				</xsl:call-template>
		  </xsl:variable>

		  <!--==========format the parameter==========-->
			<xsl:value-of select="$dataconvert"/>

		  <xsl:call-template name="GetValue">
		      <xsl:with-param name="type" select="$nametype"/>
		      <xsl:with-param name="text" select="$nametext"/>
		  </xsl:call-template>

		<xsl:choose>
			<xsl:when test="($datatype='text')">&quot;</xsl:when>
			<xsl:when test="($datatype='char')">&quot;</xsl:when>
			<xsl:when test="string-length($datatype)&gt;0">)</xsl:when>
		</xsl:choose>

		<!--==========continue==========-->
		<xsl:if test="($continue)">
			<xsl:value-of select="(', ')"/>
		</xsl:if>

	</xsl:template>


	<!--==================================================================-->
	<!-- TEMPLATE: ASP ACTION CODE -->
	<!-- returns the common value for the standard action codes -->
	<!--==================================================================-->
	<xsl:template name="ASPActionCode">
		<xsl:param name="name"/>
		<xsl:choose>
			<xsl:when test="($name='New')"><xsl:text>0</xsl:text></xsl:when>
			<xsl:when test="($name='Update')"><xsl:text>1</xsl:text></xsl:when>
			<xsl:when test="($name='Add')"><xsl:text>2</xsl:text></xsl:when>
			<xsl:when test="($name='Cancel')"><xsl:text>3</xsl:text></xsl:when>
			<xsl:when test="($name='Delete')"><xsl:text>4</xsl:text></xsl:when>
			<xsl:when test="($name='Find')"><xsl:text>5</xsl:text></xsl:when>
			<xsl:when test="($name='Previous')"><xsl:text>6</xsl:text></xsl:when>
			<xsl:when test="($name='Next')"><xsl:text>7</xsl:text></xsl:when>
			<xsl:when test="($name='Success')"><xsl:text>8</xsl:text></xsl:when>
			<xsl:when test="($name='UpdateEmail')"><xsl:text>9</xsl:text></xsl:when>
			<xsl:when test="($name='SignOut')"><xsl:text>10</xsl:text></xsl:when>
			<xsl:when test="($name='ResetLogon')"><xsl:text>11</xsl:text></xsl:when>
			<xsl:when test="($name='ResetPswd')"><xsl:text>12</xsl:text></xsl:when>
		</xsl:choose>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: ASP ACTION CODE DECLARE -->
	<!-- returns the action code constant declaration -->
	<!--==================================================================-->
	<xsl:template name="ASPActionCodeDeclare">
		<xsl:param name="name"/>

		<xsl:value-of select="concat('Const cAction', $name, ' = ')"/>
		<xsl:call-template name="ASPActionCode">
			<xsl:with-param name="name"><xsl:value-of select="$name"/></xsl:with-param>
		</xsl:call-template>
		<xsl:value-of select="$cr"/>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: ASP ACTION CODE CASE -->
	<!-- returns the action code constant declaration -->
	<!--==================================================================-->
	<xsl:template name="ASPActionCodeCase">
		<xsl:param name="name"/>
		<xsl:param name="indent"/>

		<xsl:call-template name="Indent">
			<xsl:with-param name="level"><xsl:value-of select="$indent"/></xsl:with-param>
		</xsl:call-template>
		<xsl:value-of select="concat('Case CLng(cAction', $name, '):', $cr)"/>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: ASP COMMENT -->
	<!-- returns and asp comment -->
	<!--==================================================================-->
	<xsl:template name="ASPComment">
		<xsl:param name="indent"/>
		<xsl:param name="value"/>

		<xsl:call-template name="Indent">
			<xsl:with-param name="level"><xsl:value-of select="$indent"/></xsl:with-param>
		</xsl:call-template>
		<xsl:text>'-----</xsl:text>
		<xsl:value-of select="concat($value, $cr)"/>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: ASP CONDITION START-->
	<!-- returns the VB Script for a conditional IF test -->
	<!--==================================================================-->
	<xsl:template name="ASPConditionStart">
		<xsl:param name="conditions"/>
		<xsl:param name="indent"/>
		<xsl:param name="hidden"/>
		<xsl:param name="protected"/>

		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>

		<!--==========start the IF statement==========-->
		<xsl:value-of select="concat($ind1, 'If ')"/>

		<xsl:choose>
			<xsl:when test="($hidden) and ($protected)">
				<!--==========just build a single condition for the user group==========-->
				<xsl:call-template name="ASPConditionTest">
					<xsl:with-param name="expr">SYS(usergroup)</xsl:with-param>
					<xsl:with-param name="oper">less</xsl:with-param>
					<xsl:with-param name="value" select="concat('CONST(', $hidden, ')')"/>
				</xsl:call-template>

				<xsl:call-template name="ASPConditionTest">
					<xsl:with-param name="expr">SYS(userstatus)</xsl:with-param>
					<xsl:with-param name="oper">equal</xsl:with-param>
					<xsl:with-param name="value" select="('CONST(1)')"/>
					<xsl:with-param name="connector">and</xsl:with-param>
				</xsl:call-template>

				<xsl:call-template name="ASPConditionTest">
					<xsl:with-param name="expr">SYS(usergroup)</xsl:with-param>
					<xsl:with-param name="oper">less</xsl:with-param>
					<xsl:with-param name="value" select="concat('CONST(', $protected, ')')"/>
					<xsl:with-param name="connector">and</xsl:with-param>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="($hidden)">
				<!--==========just build a single condition for the user group==========-->
				<xsl:call-template name="ASPConditionTest">
					<xsl:with-param name="expr">SYS(usergroup)</xsl:with-param>
					<xsl:with-param name="oper">less</xsl:with-param>
					<xsl:with-param name="value" select="concat('CONST(', $hidden, ')')"/>
				</xsl:call-template>

				<xsl:call-template name="ASPConditionTest">
					<xsl:with-param name="expr">SYS(userstatus)</xsl:with-param>
					<xsl:with-param name="oper">equal</xsl:with-param>
					<xsl:with-param name="value" select="('CONST(1)')"/>
					<xsl:with-param name="connector">and</xsl:with-param>
				</xsl:call-template>

			</xsl:when>
			<xsl:when test="($protected)">
				<!--==========just build a single condition for the user group==========-->
				<xsl:call-template name="ASPConditionTest">
					<xsl:with-param name="expr">SYS(usergroup)</xsl:with-param>
					<xsl:with-param name="oper">less</xsl:with-param>
					<xsl:with-param name="value" select="concat('CONST(', $protected, ')')"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<!--==========build conditions from the WTCONDITION elements==========-->
				<xsl:for-each select="$conditions">
					<xsl:call-template name="ASPConditionTest">
						<xsl:with-param name="condition" select="."/>
					</xsl:call-template>
				</xsl:for-each>
			</xsl:otherwise>
		</xsl:choose>

		<!--==========end the IF statement==========-->
		<xsl:value-of select="concat(' Then', $cr)"/>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: ASP CONDITION TEST-->
	<!-- returns the VB Script for a single test within a condition -->
	<!--==================================================================-->
	<xsl:template name="ASPConditionTest">
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
									<xsl:variable name="con">
										<xsl:choose>
											<xsl:when test="$connect != ''"><xsl:value-of select="$connect"/></xsl:when>
											<xsl:otherwise><xsl:value-of select="@connector"/></xsl:otherwise>
										</xsl:choose>
									</xsl:variable>
									 <xsl:call-template name="ASPConditionTest">
										  <xsl:with-param name="condition" select="."/>
										  <xsl:with-param name="isfirst" select="$isfirst"/>
										  <xsl:with-param name="connector" select="$con"/>
									 </xsl:call-template>
								</xsl:for-each>
						  </xsl:when>
						  <xsl:otherwise>
								<xsl:for-each select="(/Data/WTENTITY/WTCONDITIONS/WTCONDITION[@name=$exprtext]/WTCONDITION)">
									<xsl:variable name="con">
										<xsl:choose>
											<xsl:when test="$connect != ''"><xsl:value-of select="$connect"/></xsl:when>
											<xsl:otherwise><xsl:value-of select="@connector"/></xsl:otherwise>
										</xsl:choose>
									</xsl:variable>
									 <xsl:call-template name="ASPConditionTest">
										  <xsl:with-param name="condition" select="."/>
										  <xsl:with-param name="isfirst" select="$isfirst"/>
										  <xsl:with-param name="connector" select="$con"/>
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
	<!-- TEMPLATE: ASP CONDITION END-->
	<!-- returns the VB Script for a conditional END IF -->
	<!--==================================================================-->
	<xsl:template name="ASPConditionEnd">
		<xsl:param name="indent"/>

		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>

		<xsl:value-of select="concat($ind1, 'End If', $cr)"/>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: ASP CHECK CONFIRM -->
	<!-- returns common code to check for a confirmation message to display on a page -->
	<!--==================================================================-->
	<xsl:template name="ASPCheckConfirm">
		<xsl:if test="not($WorkerPage)">
			<xsl:call-template name="ASPComment">
				<xsl:with-param name="value">display the confirmation message if appropriate</xsl:with-param>
			</xsl:call-template>
			<xsl:value-of select="concat('If (Len(xmlError) = 0) Then', $cr)"/>
			<xsl:value-of select="concat($tab1, 'If (Len(reqConfirm) > 0) Then', $cr)"/>
			<xsl:value-of select="concat($tab2, 'DoError 0, &quot;&quot;, reqConfirm', $cr)"/>
			<xsl:value-of select="concat($tab1, 'End If', $cr)"/>
			<xsl:value-of select="concat('End If', $cr)"/>
		</xsl:if>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: ASP CREATE OBJECT -->
	<!-- returns the code to instantiate an object -->
	<!--==================================================================-->
	<xsl:template name="ASPCreateObject">
		<xsl:param name="name"/>
		<xsl:param name="project"/>
		<xsl:param name="class"/>

		<xsl:value-of select="concat('Set ', $name, ' = server.CreateObject(&quot;', $project, '.', $class, '&quot;)', $cr)"/>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: ASP DOM LOAD -->
	<!-- returns the code to create DOM object and load the specified xml file -->
	<!--==================================================================-->
	<xsl:template name="ASPDOMLoad">
		<xsl:param name="name"/>
		<xsl:param name="xml"/>

		<xsl:call-template name="ASPCreateObject">
			<xsl:with-param name="name"><xsl:value-of select="$name"/></xsl:with-param>
			<xsl:with-param name="project"><xsl:text>MSXML2</xsl:text></xsl:with-param>
			<xsl:with-param name="class"><xsl:text>FreeThreadedDOMDocument</xsl:text></xsl:with-param>
		</xsl:call-template>

		<xsl:value-of select="concat($name, '.loadXML ', $xml, $cr)"/>
		<xsl:value-of select="concat('If ', $name, '.parseError &lt;&gt; 0 Then', $cr)"/>
		<xsl:value-of select="concat($tab1, 'Response.Write &quot;', /Data/WTENTITY/WTWEBPAGE/@name, ' Load file (', $name, ') failed with error code &quot; + CStr(', $name, '.parseError)', $cr)"/>
		<xsl:value-of select="concat($tab1, 'Response.Write &quot;&lt;BR/&gt;&quot; + ', $xml, $cr)"/>
		<xsl:value-of select="concat($tab1, 'Response.End', $cr)"/>
		<xsl:value-of select="concat($tab0, 'End If', $cr)"/>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: ASP DOM LOAD FILE-->
	<!-- returns the code to create DOM object and load the specified file -->
	<!--==================================================================-->
	<xsl:template name="ASPDOMLoadFile">
		<xsl:param name="name"/>
		<xsl:param name="file"/>

		<xsl:call-template name="ASPCreateObject">
			<xsl:with-param name="name"><xsl:value-of select="$name"/></xsl:with-param>
			<xsl:with-param name="project"><xsl:text>MSXML2</xsl:text></xsl:with-param>
			<xsl:with-param name="class"><xsl:text>FreeThreadedDOMDocument</xsl:text></xsl:with-param>
		</xsl:call-template>

		<xsl:value-of select="concat($name, '.load server.MapPath(', $file, ')', $cr)"/>
		<xsl:value-of select="concat('If ', $name, '.parseError &lt;&gt; 0 Then', $cr)"/>
		<xsl:value-of select="concat($tab1, 'Response.Write &quot;', /Data/WTENTITY/WTWEBPAGE/@name, ' Load file (', $name, ') failed with error code &quot; + CStr(', $name, '.parseError)', $cr)"/>
		<xsl:value-of select="concat($tab1, 'Response.End', $cr)"/>
		<xsl:value-of select="concat($tab0, 'End If', $cr)"/>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: ASP DOM LOAD URL-->
	<!-- returns the code to create DOM object and load the specified file -->
	<!--==================================================================-->
	<xsl:template name="ASPDOMLoadURL">
		<xsl:param name="name"/>
		<xsl:param name="url"/>

		<xsl:call-template name="ASPCreateObject">
			<xsl:with-param name="name"><xsl:value-of select="$name"/></xsl:with-param>
			<xsl:with-param name="project"><xsl:text>MSXML2</xsl:text></xsl:with-param>
			<xsl:with-param name="class"><xsl:text>FreeThreadedDOMDocument</xsl:text></xsl:with-param>
		</xsl:call-template>

		<xsl:value-of select="concat($name, '.setProperty &quot;ServerHTTPRequest&quot;, True', $cr)"/>
		<xsl:value-of select="concat($name, '.async = False', $cr)"/>
		<xsl:value-of select="concat($name, '.load ', $url, $cr)"/>
		<xsl:value-of select="concat('If ', $name, '.parseError &lt;&gt; 0 Then', $cr)"/>
		<xsl:value-of select="concat($tab1, 'Response.Write &quot;', /Data/WTENTITY/WTWEBPAGE/@name, ' Load file (&quot; + ', $url, ' + &quot;) failed with error code &quot; + CStr(', $name, '.parseError)', $cr)"/>
		<xsl:value-of select="concat($tab1, 'Response.End', $cr)"/>
		<xsl:value-of select="concat($tab0, 'End If', $cr)"/>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: ASP ERROR FUNCTION-->
	<!-- returns the code for the ASP error handler routine -->
	<!--==================================================================-->
	<xsl:template name="ASPErrorFunction">
		<xsl:value-of select="concat($tab0, 'Sub DoError(ByVal bvNumber, ByVal bvSource, ByVal bvErrorMsg)', $cr)"/>

		<xsl:if test="$WorkerPage">
			<xsl:value-of select="concat($tab1, 'xmlError = bvErrorMsg', $cr)"/>
		</xsl:if>
		<xsl:if test="not($WorkerPage)">
			<xsl:value-of select="concat($tab1, 'bvErrorMsg = Replace(bvErrorMsg, Chr(39), Chr(34))', $cr)"/>
			<xsl:value-of select="concat($tab1, 'Set oUtil = server.CreateObject(&quot;wtSystem.CUtility&quot;)', $cr)"/>
			<xsl:value-of select="concat($tab1, 'With oUtil', $cr)"/>
			<xsl:value-of select="concat($tab2, 'tmpMsgFld = .ErrMsgFld( bvErrorMsg )', $cr)"/>
			<xsl:value-of select="concat($tab2, 'tmpMsgVal = .ErrMsgVal( bvErrorMsg )', $cr)"/>
			<xsl:value-of select="concat($tab1, 'End With', $cr)"/>
			<xsl:value-of select="concat($tab1, 'Set oUtil = Nothing', $cr)"/>
			<xsl:value-of select="concat($tab1, 'xmlError = &quot;&lt;ERROR number=&quot; + Chr(34) &amp; bvNumber &amp; Chr(34) + &quot; src=&quot; + Chr(34) + bvSource + Chr(34) + &quot; msgfld=&quot; + Chr(34) + tmpMsgFld + Chr(34) + &quot; msgval=&quot; + Chr(34) + tmpMsgVal + Chr(34) + &quot;&gt;&quot; + CleanXML(bvErrorMsg) + &quot;&lt;/ERROR&gt;&quot;', $cr)"/>
			<xsl:if test="/Data/WTPAGE/@trace or /Data/WTENTITY/WTWEBPAGE/@trace">
				<xsl:value-of select="concat($tab1, 'If bvNumber &gt; 0 Then Response.AppendToLog xmlError', $cr)"/>
			</xsl:if>
		</xsl:if>
		
		<xsl:value-of select="concat($tab1, 'Err.Clear', $cr)"/>
		<xsl:value-of select="concat($tab0, 'End Sub', $cr)"/>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: ASP AUDIT -->
	<!-- returns the code for the ASP auditing  -->
	<!--==================================================================-->
	<xsl:template name="ASPAudit">
		<xsl:value-of select="$cr"/>
		<xsl:call-template name="ASPComment">
			<xsl:with-param name="value">Log Audit Information</xsl:with-param>
		</xsl:call-template>
		<xsl:value-of select="concat($tab0, 'DoAudit &quot;', /Data/WTENTITY/WTWEBPAGE/@name, '&quot;, &quot;', /Data/WTENTITY/WTWEBPAGE/@audit, '&quot;', $cr)"/>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: ASP LOG FUNCTION-->
	<!-- returns the code for the ASP log routine -->
	<!--==================================================================-->
	<xsl:template name="ASPLogFunction">
		<xsl:variable name="hasconditions" select="(count(/Data/WTPAGE/WTLOGCONDITION/WTCONDITION) > 0)"/>
		<xsl:variable name="page">
<!--			<xsl:value-of select="substring(concat(/Data/WTENTITY/WTWEBPAGE/@name, ' ',/Data/WTENTITY/WTWEBPAGE/@caption),1,30)"/> -->
			<xsl:choose>
				<xsl:when test="/Data/WTENTITY/WTWEBPAGE/WTLOGPAGE">
					<xsl:value-of select="concat('Left(', /Data/WTENTITY/WTWEBPAGE/WTLOGPAGE/@name, ',30)')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="concat('&quot;', substring(/Data/WTENTITY/WTWEBPAGE/@caption,1,30), '&quot;')"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:value-of select="concat($tab0, 'Sub DoLog(ByVal bvData)', $cr)"/>
		<xsl:value-of select="concat($tab1, 'On Error Resume Next', $cr)"/>
		<xsl:value-of select="concat($tab1, 'Dim oLog', $cr)"/>

		<!--generate IF statement for conditions if they exist-->
		<xsl:if test="($hasconditions)">
			<xsl:call-template name="ASPConditionStart">
				<xsl:with-param name="indent" select="$tab1"/>
				<xsl:with-param name="conditions" select="/Data/WTPAGE/WTLOGCONDITION/WTCONDITION"/>
			</xsl:call-template>
		</xsl:if>

		<xsl:value-of select="concat($tab1, 'Set oLog = server.CreateObject(&quot;', $appprefix, 'LogUser.CLog&quot;)', $cr)"/>
		<xsl:value-of select="concat($tab1, 'If oLog Is Nothing Then', $cr)"/>
		<xsl:value-of select="concat($tab2, 'DoError Err.Number, Err.Source, &quot;Unable to Create Object - ', $appprefix, 'LogUser.CLog&quot;', $cr)"/>
		<xsl:value-of select="concat($tab1, 'Else', $cr)"/>
		<xsl:value-of select="concat($tab2, 'With oLog', $cr)"/>
		<xsl:if test="/Data/WTPAGE/@multi-instance">
	 		<xsl:value-of select="concat($tab3, '.SysClientProject SysClient, SysProject', $cr)"/>
		</xsl:if>
		<xsl:value-of select="concat($tab3, '.LogDate = Now', $cr)"/>
		<xsl:value-of select="concat($tab3, '.UserIP = Request.ServerVariables(&quot;REMOTE_ADDR&quot;)', $cr)"/>
		<xsl:value-of select="concat($tab3, '.Page = ', $page, $cr)"/>
		<xsl:value-of select="concat($tab3, '.AffiliateID = reqSysAffiliateID', $cr)"/>
		<xsl:value-of select="concat($tab3, '.Data = bvData', $cr)"/>

		<xsl:apply-templates select="/Data/WTPAGE/WTATTRLOG"/>

		<xsl:value-of select="concat($tab3, '.Add 1', $cr)"/>
		<xsl:value-of select="concat($tab3, 'If (Err.Number &lt;&gt; 0) Then DoError Err.Number, Err.Source, Err.Description End If', $cr)"/>
		<xsl:value-of select="concat($tab2, 'End With', $cr)"/>
		<xsl:value-of select="concat($tab1, 'End If', $cr)"/>
		<xsl:value-of select="concat($tab1, 'Set oLog = Nothing', $cr)"/>

		<!--close IF statement for conditions if they exist-->
		<xsl:if test="($hasconditions)">
			<xsl:call-template name="ASPConditionEnd">
				<xsl:with-param name="indent" select="$tab1"/>
			</xsl:call-template>
		</xsl:if>

		<xsl:value-of select="concat($tab0, 'End Sub', $cr)"/>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: ASP PAGE LOG-->
	<!-- returns the code for the ASP Page logging -->
	<!--==================================================================-->
	<xsl:template name="LogPage">
		<xsl:param name="indent" select="0"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level"><xsl:value-of select="$indent"/></xsl:with-param></xsl:call-template></xsl:variable>

		<xsl:if test="/Data/WTENTITY/WTWEBPAGE/WTLOGCONDITION">
			<xsl:value-of select="concat($ind1, 'If ', /Data/WTENTITY/WTWEBPAGE/WTLOGCONDITION/@name, ' Then', $cr)"/>
		</xsl:if>

		<xsl:value-of select="concat($ind1, 'If IsLogging Then DoLog ')"/>
		<xsl:apply-templates select="/Data/WTENTITY/WTWEBPAGE/WTLOG | /Data/WTPAGE/WTLOG"/>
		<xsl:if test="count(/Data/WTENTITY/WTWEBPAGE/WTLOG | /Data/WTPAGE/WTLOG)=0">
			<xsl:value-of select="'&quot;&quot;'"/>
		</xsl:if>

		<xsl:if test="/Data/WTENTITY/WTWEBPAGE/WTLOGCONDITION">
			<xsl:value-of select="concat($cr, $ind1, 'End If')"/>
		</xsl:if>

		<xsl:value-of select="concat($cr, $cr)"/>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTATTRLOG">
	<!--==================================================================-->
		<!-- ***************** Error Checking *******************-->
		<xsl:if test="not(@name)">
			<xsl:call-template name="Error">
				<xsl:with-param name="msg" select="'WTATTRLOG Name Missing'"/>
				<xsl:with-param name="text" select="position()"/>
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="not(@value)">
			<xsl:call-template name="Error">
				<xsl:with-param name="msg" select="'WTATTRLOG Value Missing'"/>
				<xsl:with-param name="text" select="@name"/>
			</xsl:call-template>
		</xsl:if>
		<!-- ****************************************************-->
		<xsl:value-of select="concat($tab3, '.', @name, ' = ', @value, $cr)"/>
	</xsl:template>
	
	<!--==================================================================-->
	<xsl:template match="WTACTIONLOG" mode="docase">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:apply-templates select=".">
			<xsl:with-param name="indent" select="$indent"/>
		</xsl:apply-templates>
	</xsl:template>
	
	<!--==================================================================-->
	<!-- TEMPLATE: ASP ACTION LOG-->
	<!--==================================================================-->
	<xsl:template match="WTACTIONLOG">
		<xsl:param name="indent" select="0"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level"><xsl:value-of select="$indent"/></xsl:with-param></xsl:call-template></xsl:variable>
		<xsl:value-of select="concat($ind1, 'If IsLogging Then DoLog ')"/>
		<xsl:apply-templates select="WTLOG | /Data/WTPAGE/WTLOG"/>
		<xsl:if test="count(WTLOG | /Data/WTPAGE/WTLOG)=0">
			<xsl:value-of select="'&quot;&quot;'"/>
		</xsl:if>
		<xsl:value-of select="$cr"/>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTLOG">
	<!--==================================================================-->
		<xsl:variable name="valuetype"><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>
		<xsl:variable name="valuetext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>

		<!-- ***************** Error Checking *******************-->
		<xsl:if test="not(@name)">
			<xsl:call-template name="Error">
				<xsl:with-param name="msg" select="'WTLOG Name Missing'"/>
				<xsl:with-param name="text" select="position()"/>
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="not(@value)">
			<xsl:call-template name="Error">
				<xsl:with-param name="msg" select="'WTLOG Value Missing'"/>
				<xsl:with-param name="text" select="@name"/>
			</xsl:call-template>
		</xsl:if>
		<!-- ****************************************************-->

		<xsl:variable name="connect">
			<xsl:if test="position()!=1"><xsl:value-of select="'; '"/></xsl:if>
		</xsl:variable>

		<xsl:value-of select="concat('&quot;', $connect, @name, '=&quot; &amp; ')"/>
			
		<xsl:call-template name="GetValue">
			<xsl:with-param name="type" select="$valuetype"/>			
			<xsl:with-param name="text" select="$valuetext"/>			
		</xsl:call-template>

		<xsl:if test="position() != last()">
			<xsl:value-of select="(' &amp; ')"/>
		</xsl:if>

	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTERROR" mode="docase">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:apply-templates select=".">
			<xsl:with-param name="indent" select="$indent"/>			
		</xsl:apply-templates>
	</xsl:template>
	
	<!--==================================================================-->
	<!-- TEMPLATE: WTERROR -->
	<!-- call the error handler -->
	<!--==================================================================-->
	<xsl:template match="WTERROR">
		<xsl:param name="indent"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level"><xsl:value-of select="$indent"/></xsl:with-param></xsl:call-template></xsl:variable>

		<!-- ***************** Error Checking *******************-->
		<!--TEST valid attributes-->
		<xsl:for-each select="@*">
			<xsl:choose>
				<xsl:when test="name()='number'"/>
				<xsl:when test="name()='source'"/>
				<xsl:when test="name()='message'"/>
				<xsl:when test="name()='quote'"/>
				<xsl:otherwise>
					 <xsl:call-template name="Error">
						  <xsl:with-param name="msg" select="'Invalid WTERROR Attribute'"/>
						  <xsl:with-param name="text" select="name()"/>
	 				</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
		<!-- ****************************************************-->

		<xsl:if test="@quote='false'">
			<xsl:value-of select="concat($ind1, 'DoError ', @number, ', &quot;', @source, '&quot;, ', @message, $cr)"/>
		</xsl:if>
		<xsl:if test="not(@quote)">
			<xsl:value-of select="concat($ind1, 'DoError ', @number, ', &quot;', @source, '&quot;, &quot;', @message, '&quot;', $cr)"/>
		</xsl:if>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: ASP ERROR CHECK-->
	<!-- returns the code to check the runtime error and call the error handler -->
	<!--==================================================================-->
	<xsl:template name="ASPErrorCheck">
		<xsl:param name="indent"/>
		<xsl:param name="pageno"/>

		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level"><xsl:value-of select="$indent"/></xsl:with-param></xsl:call-template></xsl:variable>
		<xsl:variable name="ind2"><xsl:value-of select="concat($ind1, '&#009;')"/></xsl:variable>
		<xsl:variable name="ind3"><xsl:value-of select="concat($ind2, '&#009;')"/></xsl:variable>

		<xsl:choose>
			<xsl:when test="($pageno)">
				<xsl:value-of select="concat($ind1, 'If (Err.Number &lt;&gt; 0) Then', $cr)"/>
				<xsl:value-of select="concat($ind2, 'DoError Err.Number, Err.Source, Err.Description', $cr)"/>
				<xsl:value-of select="concat($ind1, 'Else', $cr)"/>
				<xsl:value-of select="concat($ind2, 'reqReturnURL = GetCache(&quot;', $pageno, 'URL&quot;)', $cr)"/>
				<xsl:value-of select="concat($ind2, 'reqReturnData = GetCache(&quot;', $pageno, 'DATA&quot;)', $cr)"/>
				<xsl:value-of select="concat($ind2, 'SetCache &quot;', $pageno, 'URL&quot;, &quot;&quot;', $cr)"/>
				<xsl:value-of select="concat($ind2, 'SetCache &quot;', $pageno, 'DATA&quot;, &quot;&quot;', $cr)"/>
				<xsl:value-of select="concat($ind2, 'If (Len(reqReturnURL) &gt; 0) Then', $cr)"/>
				<xsl:value-of select="concat($ind3, 'SetCache &quot;RETURNURL&quot;, reqReturnURL', $cr)"/>
				<xsl:value-of select="concat($ind3, 'SetCache &quot;RETURNDATA&quot;, reqReturnData', $cr)"/>
				<xsl:value-of select="concat($ind3, 'Response.Redirect Replace(reqReturnURL, &quot;%26&quot;, &quot;&amp;&quot;)', $cr)"/>
				<xsl:value-of select="concat($ind2, 'End If', $cr)"/>
				<xsl:value-of select="concat($ind1, 'End If', $cr)"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="concat($ind1, 'If (Err.Number &lt;&gt; 0) Then DoError Err.Number, Err.Source, Err.Description End If', $cr)"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: ASP ERROR INIT-->
	<!-- returns the code to initialize the error handling on the page -->
	<!--==================================================================-->
	<xsl:template name="ASPErrorInit">
		<xsl:call-template name="ASPComment">
			<xsl:with-param name="value">initialize the error data</xsl:with-param>
		</xsl:call-template>
		<xsl:value-of select="concat('xmlError = &quot;&quot;', $cr)"/>
		<xsl:if test="/Data/WTPAGE/@multi-instance">
			<xsl:value-of select="concat('If SysClient=&quot;&quot; or SysProject=&quot;&quot; Then DoError -1, &quot;System&quot;, &quot;SysClient and/or SysProject not set in System.asp&quot;', $cr)"/>
		</xsl:if>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: ASP ERROR START-->
	<!-- returns the code to start the error handling -->
	<!--==================================================================-->
	<xsl:template name="ASPErrorStart">
		<xsl:value-of select="concat('On Error Resume Next', $cr)"/>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: ASP INCLUDE-->
	<!-- returns the code to reference an included ASP page -->
	<!--==================================================================-->
	<xsl:template name="ASPInclude">
		<xsl:param name="filename"/>
		<xsl:value-of select="concat('&lt;!--#include file=&quot;', $filename, '&quot;--&gt;', $cr)"/>
	</xsl:template>

	<xsl:template match="WTINCLUDE">
		<xsl:call-template name="ASPInclude">
			<xsl:with-param name="filename" select="concat('Include\', @name)"/>
		</xsl:call-template>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: ASP INIT REQUEST ITEMS-->
	<!-- returns the code to initialize every request field from the cache or request object -->
	<!--==================================================================-->
	<xsl:template name="ASPInitRequestItems">
		<xsl:param name="indent"/>

		<xsl:for-each select="/Data/WTENTITY/WTWEBPAGE/WTATTRIBUTE">
			<xsl:variable name="aname" select="@name"/>
			<xsl:for-each select="/Data/WTENTITY/WTATTRIBUTE[@name=$aname]">
				<xsl:variable name="iscompute" select="count(WTCOMPUTE) > 0"/>
				<xsl:choose>
					<xsl:when test="($iscompute = false)">
						<xsl:call-template name="Indent">
							<xsl:with-param name="level"><xsl:value-of select="$indent"/></xsl:with-param>
						</xsl:call-template>
						<xsl:value-of select="concat('req', @name, '= GetInput(&quot;', @name, '&quot;, reqPageData)', $cr)"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:for-each select="WTCOMPUTE[@name]">
							<xsl:call-template name="Indent">
								<xsl:with-param name="level"><xsl:value-of select="$indent"/></xsl:with-param>
							</xsl:call-template>
							<xsl:value-of select="concat('req', @name, '= GetInput(&quot;', @name, '&quot;, reqPageData)', $cr)"/>
						</xsl:for-each>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:for-each>
		</xsl:for-each>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template name="ASPLanguageCheck">
	<!--==================================================================-->
		<xsl:if test="not($WorkerPage)">
			<xsl:call-template name="ASPComment">
				<xsl:with-param name="value">get language settings</xsl:with-param>
			</xsl:call-template>

			<xsl:variable name="default"><xsl:value-of select="/Data/WTENTITY/WTLANGUAGES/WTLANGUAGE[@default='true']/@code"/></xsl:variable>

			<xsl:value-of select="concat($tab0, 'reqLangDefault = &quot;', $default, '&quot;', $cr)"/>
			<xsl:value-of select="concat($tab0, 'reqSysLanguage = GetInput(&quot;SysLanguage&quot;, reqPageData)', $cr)"/>
			<xsl:value-of select="concat($tab0, 'If Len(reqSysLanguage) = 0 Then', $cr)"/>
			<xsl:value-of select="concat($tab1, 'reqSysLanguage = GetCache(&quot;LANGUAGE&quot;)', $cr)"/>
			<xsl:value-of select="concat($tab1, 'If Len(reqSysLanguage) = 0 Then', $cr)"/>
			
<!--
			<xsl:value-of select="concat($tab2, 'GetLanguage &quot;')"/>
			<xsl:value-of select="$default"/>
			<xsl:if test="/Data/@language='true'">
			  <xsl:for-each select="/Data/WTENTITY/WTLANGUAGES/WTLANGUAGE[not(@default)]">
			  	<xsl:value-of select="concat(',', @code)"/>
			  </xsl:for-each>
			</xsl:if>
			  <xsl:value-of select="concat('&quot;, reqLangDialect, reqLangCountry, reqLangDefault', $cr)"/>
-->
			  <xsl:value-of select="concat($tab2, 'GetLanguage reqLangDialect, reqLangCountry, reqLangDefault', $cr)"/>
			  		
			  <xsl:value-of select="concat($tab2, 'If len(reqLangDialect) &gt; 0 Then', $cr)"/>
			  <xsl:value-of select="concat($tab3, 'reqSysLanguage = reqLangDialect', $cr)"/>
			  <xsl:value-of select="concat($tab2, 'ElseIf len(reqLangCountry) &gt; 0 Then', $cr)"/>
			  <xsl:value-of select="concat($tab3, 'reqSysLanguage = reqLangCountry', $cr)"/>
			  <xsl:value-of select="concat($tab2, 'Else', $cr)"/>
			  <xsl:value-of select="concat($tab3, 'reqSysLanguage = reqLangDefault', $cr)"/>
			  <xsl:value-of select="concat($tab2, 'End If', $cr)"/>
			  <xsl:value-of select="concat($tab2, 'SetCache &quot;LANGUAGE&quot;, reqSysLanguage', $cr)"/>
			  <xsl:value-of select="concat($tab1, 'End If', $cr)"/>
			  <xsl:value-of select="concat($tab0, 'Else', $cr)"/>
			  <xsl:value-of select="concat($tab1, 'SetCache &quot;LANGUAGE&quot;, reqSysLanguage', $cr)"/>
			  <xsl:value-of select="concat($tab0, 'End If', $cr)"/>
		</xsl:if>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template name="ASPLanguageData">
	<!--==================================================================-->
		<xsl:param name="common"/>
		<xsl:if test="not($WorkerPage)">
			<xsl:call-template name="ASPComment">
				<xsl:with-param name="value">get the language XML</xsl:with-param>
			</xsl:call-template>
			<xsl:variable name="LangPath">
				<xsl:choose>
					<xsl:when test="/Data/WTENTITY/WTWEBPAGE/@langpath"><xsl:value-of select="/Data/WTENTITY/WTWEBPAGE/@langpath"/></xsl:when>
					<xsl:otherwise><xsl:value-of select="'&quot;Language&quot;'"/></xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			<xsl:variable name="LangFile">
					<xsl:choose>
						 <xsl:when test="/Data/WTENTITY/WTWEBPAGE/@langfile"><xsl:value-of select="/Data/WTENTITY/WTWEBPAGE/@langfile"/></xsl:when>
						 <xsl:otherwise><xsl:value-of select="$entityname"/></xsl:otherwise>
					</xsl:choose>
			  </xsl:variable>
			  <xsl:variable name="CommonFile">
					<xsl:choose>
						 <xsl:when test="$common='false'"/>
						 <xsl:when test="/Data/WTENTITY/WTWEBPAGE/@commonlabels='false'"/>
						 <xsl:when test="/Data/WTENTITY/WTWEBPAGE/@commonlabels"><xsl:value-of select="/Data/WTENTITY/WTWEBPAGE/@commonlabels"/></xsl:when>
						 <xsl:otherwise>Common</xsl:otherwise>
					</xsl:choose>
			  </xsl:variable>
			<xsl:if test="not(/Data/WTENTITY/WTWEBPAGE/@languageurl)">
				<xsl:if test="not($PagesLanguage='false' or $PageLanguage='false')">
					<xsl:value-of select="concat('fileLanguage = ', $LangPath, ' + &quot;\', $LangFile,'[&quot; + reqSysLanguage + &quot;].xml&quot;', $cr )"/>
					<xsl:value-of select="concat('If reqSysLanguage &lt;&gt; &quot;en&quot; Then', $cr )"/>
					<xsl:value-of select="concat($tab1, 'If Not FileExists( reqSysWebDirectory + fileLanguage ) Then fileLanguage = &quot;Language\', $LangFile,'[en].xml&quot;', $cr )"/>
					<xsl:value-of select="concat('End If', $cr )"/>
				</xsl:if>
				<xsl:if test="$PagesLanguage='false' or $PageLanguage='false'">
					<xsl:value-of select="concat('fileLanguage = &quot;Language\', $LangFile,'.xml&quot;', $cr )"/>
				</xsl:if>
			</xsl:if>
			<xsl:if test="not(/Data/WTENTITY/WTWEBPAGE/@languageurl)">
				<xsl:call-template name="ASPDOMLoadFile">
					<xsl:with-param name="name"><xsl:text>oLanguage</xsl:text></xsl:with-param>
					<xsl:with-param name="file"><xsl:text>fileLanguage</xsl:text></xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<xsl:if test="/Data/WTENTITY/WTWEBPAGE/@languageurl">
				<xsl:call-template name="ASPDOMLoadURL">
					<xsl:with-param name="name"><xsl:text>oLanguage</xsl:text></xsl:with-param>
					<xsl:with-param name="url"><xsl:value-of select="/Data/WTENTITY/WTWEBPAGE/@languageurl"/></xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<xsl:value-of select="concat('oLanguage.removeChild oLanguage.firstChild', $cr, $cr)"/>

			<xsl:if test="$CommonFile!=''">
				<xsl:call-template name="ASPComment">
					<xsl:with-param name="value">append common labels</xsl:with-param>
				</xsl:call-template>
				<xsl:value-of select="concat('fileLanguage = &quot;Language\', $CommonFile, '[&quot; + reqSysLanguage + &quot;].xml&quot;', $cr )"/>
				<xsl:value-of select="concat('If reqSysLanguage &lt;&gt; &quot;en&quot; Then', $cr )"/>
				<xsl:value-of select="concat($tab1, 'If Not FileExists( reqSysWebDirectory + fileLanguage ) Then fileLanguage = &quot;Language\', $CommonFile,'[en].xml&quot;', $cr )"/>
				<xsl:value-of select="concat('End If', $cr )"/>
				<xsl:call-template name="ASPDOMLoadFile">
					<xsl:with-param name="name"><xsl:text>oCommon</xsl:text></xsl:with-param>
					<xsl:with-param name="file"><xsl:text>fileLanguage</xsl:text></xsl:with-param>
				</xsl:call-template>
				<xsl:value-of select="concat('Set oLabels = oCommon.selectNodes(&quot;LANGUAGE/LABEL&quot;)', $cr)"/>
				<xsl:value-of select="concat('For Each oLabel In oLabels', $cr)"/>
				<xsl:value-of select="concat('Set oAdd = oLanguage.selectSingleNode(&quot;LANGUAGE&quot;).appendChild(oLabel.cloneNode(True))', $cr)"/>
				<xsl:value-of select="concat('Set oAdd = Nothing', $cr)"/>
				<xsl:value-of select="concat('Next', $cr)"/>
			</xsl:if>
			<xsl:value-of select="concat('xmlLanguage = oLanguage.XML', $cr)"/>
			<xsl:value-of select="concat('Set oLanguage = Nothing', $cr, $cr)"/>

			<xsl:value-of select="concat($apos, '-----If there is an Error, get the Error Labels XML', $cr )"/>
			<xsl:value-of select="concat('If xmlError &lt;&gt; &quot;&quot; Then', $cr )"/>
			<xsl:value-of select="concat('fileLanguage = &quot;Language\Error[&quot; + reqSysLanguage + &quot;].xml&quot;', $cr )"/>
			<xsl:value-of select="concat('If reqSysLanguage &lt;&gt; &quot;en&quot; Then', $cr )"/>
			<xsl:value-of select="concat($tab1, 'If Not FileExists( reqSysWebDirectory + fileLanguage ) Then fileLanguage = &quot;Language\Error[en].xml&quot;', $cr )"/>
			<xsl:value-of select="concat('End If', $cr )"/>

			<xsl:call-template name="ASPDOMLoadFile">
				<xsl:with-param name="name"><xsl:text>oLanguage</xsl:text></xsl:with-param>
				<xsl:with-param name="file"><xsl:text>fileLanguage</xsl:text></xsl:with-param>
			</xsl:call-template>
			<xsl:value-of select="concat('oLanguage.removeChild oLanguage.firstChild', $cr)"/>
			<xsl:value-of select="concat('xmlErrorLabels = oLanguage.XML', $cr)"/>
			<xsl:value-of select="concat('End If', $cr, $cr )"/>
		</xsl:if>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template name="ASPLanguageDeclares">
	<!--==================================================================-->
		<xsl:if test="not($WorkerPage)">
			<xsl:call-template name="ASPComment">
				<xsl:with-param name="value">language variables</xsl:with-param>
			</xsl:call-template>
			<xsl:value-of select="concat('Dim oLanguage, xmlLanguage', $cr)"/>
			<xsl:value-of select="concat('Dim xslPage', $cr)"/>
			<xsl:value-of select="concat('Dim fileLanguage', $cr)"/>
		</xsl:if>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: ASP LOAD REQUEST ITEMS-->
	<!-- returns the code to populate the object's properties from the page data -->
	<!--==================================================================-->
	<xsl:template name="ASPLoadRequestItems">
		<xsl:param name="indent"/>
		<xsl:variable name="object" select="$entityname"/>

		<xsl:for-each select="/Data/WTENTITY/WTWEBPAGE/WTCONTENT/WTROW/descendant::*[@value]">
			<xsl:variable name="valuetype"><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>
			<xsl:variable name="valuetext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>
			<xsl:variable name="valueentity"><xsl:call-template name="QualifiedPrefix"><xsl:with-param name="value" select="@value"/></xsl:call-template></xsl:variable>

			<xsl:if test="($valuetype='ATTR') and ($valueentity=$object)">
				<xsl:if test="(name()='WTTEXT') or (name()='WTCHECK') or (name()='WTCOMBO') or (name()='WTMEMO')">
					<xsl:apply-templates select="." mode="setinput">
						<xsl:with-param name="indent" select="$indent"/>
					</xsl:apply-templates>
				</xsl:if>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: ASP OBJECT DECLARES-->
	<!-- returns the code to create the declaration for an object and its xml -->
	<!--==================================================================-->
	<xsl:template name="ASPObjectDeclares">
		<xsl:param name="name"/>
		<xsl:value-of select="concat('Dim o', $name, ', xml', $name, $cr)"/>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: ASP PAGE END-->
	<!-- returns the common code at the end of each ASP page -->
	<!--==================================================================-->
	<xsl:template name="ASPPageEnd">
		<xsl:if test="not($WorkerPage)">
			<xsl:value-of select="concat('Set oData = Nothing', $cr)"/>
			<xsl:value-of select="concat('Set oStyle = Nothing', $cr)"/>
			<xsl:value-of select="concat('Set oLanguage = Nothing', $cr)"/>
		</xsl:if>
		<xsl:value-of select="concat('%&gt;', $cr)"/>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: ASP PAGE DECLARES-->
	<!-- returns the code to create the common declaration for every ASP page -->
	<!--==================================================================-->
	<xsl:template name="ASPPageDeclares">
		<xsl:if test="not($WorkerPage)">
			<xsl:call-template name="ASPComment">
				<xsl:with-param name="value">page variables</xsl:with-param>
			</xsl:call-template>
			<xsl:value-of select="concat('Dim oData', $cr, 'Dim oStyle', $cr)"/>
		</xsl:if>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: ASP PARAM DATA-->
	<!-- returns the code to create the PARAM xml for the page -->
	<!--==================================================================-->

	<xsl:template name="ASPParamData">

		<xsl:call-template name="ASPComment">
			<xsl:with-param name="value">get page parameter data</xsl:with-param>
		</xsl:call-template>
		<xsl:value-of select="concat('xmlParam = xmlParam+ &quot;&lt;PARAM&quot;', $cr)"/>

		<xsl:for-each select="/Data/WTENTITY/WTWEBPAGE/WTPARAM">
			<xsl:variable name="pname">
				<xsl:call-template name="CaseLower">
					<xsl:with-param name="value" select="@name"/>
				</xsl:call-template>
			</xsl:variable>
			<xsl:value-of select="concat('xmlParam = xmlParam + &quot; ', $pname, '=&quot; + Chr(34) + Request(&quot;', @name, '&quot;) + Chr(34)', $cr)"/>
		</xsl:for-each>

		<xsl:value-of select="concat('xmlParam = xmlParam + &quot; /&gt;&quot;', $cr)"/>
	</xsl:template>


	<!--==================================================================-->
	<!-- TEMPLATE: ASP SECURE REQUEST ITEMS-->
	<!-- returns the code to initialize a secured parameter on the ASP page -->
	<!--==================================================================-->
	<xsl:template name="ASPSecureRequestItem">
		<xsl:param name="name"/>

		<xsl:value-of select="concat('req', $name, ' = GetCache(&quot;')"/>
		<xsl:call-template name="CaseUpper">
			<xsl:with-param name="value"><xsl:value-of select="$name"/></xsl:with-param>
		</xsl:call-template>
		<xsl:value-of select="concat('&quot;)', $cr)"/>
		<xsl:value-of select="concat('If (Len(req', $name, ') = 0) Then', $cr)"/>
		<xsl:value-of select="concat($tab1, 'req', $name, ' = CLng(Request.Item(&quot;', $name, '&quot;))', $cr)"/>
		<xsl:value-of select="concat('End If', $cr)"/>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: ASP SECURITY CHECK-->
	<!-- returns the code to validate that a user is signed in before executing a page -->
	<!--==================================================================-->
	<xsl:template name="ASPSecurityCheck">
		<xsl:param name="pagetype"/>

		<xsl:choose>
			<xsl:when test="/Data/WTENTITY/WTWEBPAGE/@checksecurity = 'false'"></xsl:when>
			<xsl:otherwise>			
				<xsl:call-template name="ASPComment">
					<xsl:with-param name="value">get the userID and security group</xsl:with-param>
				</xsl:call-template>
				<xsl:choose>
					<xsl:when test="/Data/WTENTITY/WTWEBPAGE/@securedonly">
						<xsl:if test="not(/Data/WTENTITY/WTWEBPAGE/@mobile)">
							<xsl:value-of select="concat('CheckSecurity reqSysUserID, reqSysUserGroup, 2, ', /Data/WTENTITY/WTWEBPAGE/@securedonly, $cr)"/>
						</xsl:if>
						<xsl:if test="/Data/WTENTITY/WTWEBPAGE/@mobile">
							<xsl:value-of select="concat('m_CheckSecurity reqSysUserID, reqSysUserGroup, 2, ', /Data/WTENTITY/WTWEBPAGE/@securedonly, ', &quot;', /Data/WTENTITY/WTWEBPAGE/@mobile, '&quot;', $cr)"/>
						</xsl:if>
					</xsl:when>
					<xsl:when test="/Data/WTENTITY/WTWEBPAGE/@secured">
						<xsl:if test="not(/Data/WTENTITY/WTWEBPAGE/@mobile)">
							<xsl:value-of select="concat('CheckSecurity reqSysUserID, reqSysUserGroup, 1, ', /Data/WTENTITY/WTWEBPAGE/@secured, $cr)"/>
						</xsl:if>
						<xsl:if test="/Data/WTENTITY/WTWEBPAGE/@mobile">
							<xsl:value-of select="concat('m_CheckSecurity reqSysUserID, reqSysUserGroup, 1, ', /Data/WTENTITY/WTWEBPAGE/@secured, ', &quot;', /Data/WTENTITY/WTWEBPAGE/@mobile, '&quot;', $cr)"/>
						</xsl:if>
					</xsl:when>
					<xsl:when test="not(/Data/WTENTITY/WTWEBPAGE/@secured)">
						<xsl:if test="not(/Data/WTENTITY/WTWEBPAGE/@mobile)">
							<xsl:value-of select="concat('CheckSecurity reqSysUserID, reqSysUserGroup, 0, 0', $cr)"/>
						</xsl:if>
						<xsl:if test="/Data/WTENTITY/WTWEBPAGE/@mobile">
							<xsl:value-of select="concat('m_CheckSecurity reqSysUserID, reqSysUserGroup, 0, 0, &quot;', /Data/WTENTITY/WTWEBPAGE/@mobile, '&quot;', $cr)"/>
						</xsl:if>
					</xsl:when>
					<xsl:when test="($pagetype='list')">
						<xsl:value-of select="concat($tab0, 'Select Case reqOwner', $cr)"/>
						<xsl:for-each select="/Data/WTENTITY/WTWEBPAGE/WTLINK[@page='owner']">
							<xsl:variable name="ename" select="@entity"/>
							<xsl:variable name="hide" select="/Data/WTENTITY/WTENUM[@type='list']/WTATTRIBUTE[@entity=$ename]/@hidden"/>
							<xsl:if test="($hide != '')">
								<xsl:value-of select="concat($tab1, 'Case &quot;', $ename, '&quot;: CheckSecurity reqSysUserID, reqSysUserGroup, True, ', $hide,$cr)"/>
							</xsl:if>
						</xsl:for-each> 
						<xsl:value-of select="concat($tab1, 'Case Else: CheckSecurity reqSysUserID, reqSysUserGroup, False, 0', $cr)"/>
						<xsl:value-of select="concat($tab0, 'End Select', $cr)"/>
					</xsl:when>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>

		<xsl:if test="not($WorkerPage)">
			<xsl:value-of select="concat($tab0, 'reqSysUserStatus = GetCache(&quot;USERSTATUS&quot;)', $cr)"/>
			<xsl:value-of select="concat($tab0, 'reqSysUserName = GetCache(&quot;USERNAME&quot;)', $cr)"/>
		</xsl:if>
		
		<xsl:if test="/Data/WTENTITY/WTWEBPAGE/@audit">
			<xsl:call-template name="ASPAudit"/>
		</xsl:if>
		
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: ASP SYSTEM DATA-->
	<!-- returns the code to create the SYSTEM xml for the page -->
	<!--==================================================================-->
	<xsl:template name="ASPSystemData">
		<xsl:param name="pagetype"/>

		<xsl:if test="not($WorkerPage)">
			<xsl:call-template name="ASPComment">
				<xsl:with-param name="value">get system data</xsl:with-param>
			</xsl:call-template>
			<xsl:value-of select="concat('xmlSystem = &quot;&lt;SYSTEM&quot;', $cr)"/>
			<xsl:if test="not($WorkerPage)">
				<xsl:value-of select="concat('xmlSystem = xmlSystem + &quot; headerimage=&quot; + Chr(34) + reqSysHeaderImage + Chr(34)', $cr)"/>
				<xsl:value-of select="concat('xmlSystem = xmlSystem + &quot; footerimage=&quot; + Chr(34) + reqSysFooterImage + Chr(34)', $cr)"/>
				<xsl:value-of select="concat('xmlSystem = xmlSystem + &quot; returnimage=&quot; + Chr(34) + reqSysReturnImage + Chr(34)', $cr)"/>
				<xsl:value-of select="concat('xmlSystem = xmlSystem + &quot; navbarimage=&quot; + Chr(34) + reqSysNavBarImage + Chr(34)', $cr)"/>
				<xsl:value-of select="concat('xmlSystem = xmlSystem + &quot; headerurl=&quot; + Chr(34) + reqSysHeaderURL + Chr(34)', $cr)"/>
				<xsl:value-of select="concat('xmlSystem = xmlSystem + &quot; returnurl=&quot; + Chr(34) + CleanXML(reqSysReturnURL) + Chr(34)', $cr)"/>
				<xsl:value-of select="concat('xmlSystem = xmlSystem + &quot; language=&quot; + Chr(34) + reqSysLanguage + Chr(34)', $cr)"/>
				<xsl:value-of select="concat('xmlSystem = xmlSystem + &quot; langdialect=&quot; + Chr(34) + reqLangDialect + Chr(34)', $cr)"/>
				<xsl:value-of select="concat('xmlSystem = xmlSystem + &quot; langcountry=&quot; + Chr(34) + reqLangCountry + Chr(34)', $cr)"/>
				<xsl:value-of select="concat('xmlSystem = xmlSystem + &quot; langdefault=&quot; + Chr(34) + reqLangDefault + Chr(34)', $cr)"/>
			</xsl:if>
			<xsl:value-of select="concat('xmlSystem = xmlSystem + &quot; userid=&quot; + Chr(34) + CStr(reqSysUserID) + Chr(34)', $cr)"/>
			<xsl:value-of select="concat('xmlSystem = xmlSystem + &quot; usergroup=&quot; + Chr(34) + CStr(reqSysUserGroup) + Chr(34)', $cr)"/>
			<xsl:value-of select="concat('xmlSystem = xmlSystem + &quot; userstatus=&quot; + Chr(34) + CStr(reqSysUserStatus) + Chr(34)', $cr)"/>
			<xsl:value-of select="concat('xmlSystem = xmlSystem + &quot; username=&quot; + Chr(34) + CleanXML(reqSysUserName) + Chr(34)', $cr)"/>
			<xsl:if test="/Data/WTENTITY/WTWEBPAGE/@system-plan or /Data/WTPAGE/@system-plan">
				<xsl:value-of select="concat('xmlSystem = xmlSystem + &quot; planid=&quot; + Chr(34) + CStr(reqSysPlanID) + Chr(34)', $cr)"/>
			</xsl:if>
			<xsl:if test="/Data/WTENTITY/WTWEBPAGE/@system-shopping or /Data/WTPAGE/@system-shopping">
				<xsl:value-of select="concat('xmlSystem = xmlSystem + &quot; cartid=&quot; + Chr(34) + CStr(reqSysCartID) + Chr(34)', $cr)"/>
				<xsl:value-of select="concat('xmlSystem = xmlSystem + &quot; storeid=&quot; + Chr(34) + CStr(reqSysStoreID) + Chr(34)', $cr)"/>
			</xsl:if>
			<xsl:if test="/Data/WTENTITY/WTWEBPAGE/@system-board or /Data/WTPAGE/@system-board">
				<xsl:value-of select="concat('xmlSystem = xmlSystem + &quot; brduserid=&quot; + Chr(34) + CStr(reqSysBrdUserID) + Chr(34)', $cr)"/>
				<xsl:value-of select="concat('xmlSystem = xmlSystem + &quot; brdusergroup=&quot; + Chr(34) + CStr(reqSysBrdUserGroup) + Chr(34)', $cr)"/>
			</xsl:if>
			<xsl:if test="/Data/WTENTITY/WTWEBPAGE/@system-colors or /Data/WTPAGE/@system-colors">
				<xsl:value-of select="concat('xmlSystem = xmlSystem + &quot; pagecolor=&quot; + Chr(34) + CStr(reqSysPageColor) + Chr(34)', $cr)"/>
				<xsl:value-of select="concat('xmlSystem = xmlSystem + &quot; linkcolor=&quot; + Chr(34) + CStr(reqSysLinkColor) + Chr(34)', $cr)"/>
				<xsl:value-of select="concat('xmlSystem = xmlSystem + &quot; pageimage=&quot; + Chr(34) + CStr(reqSysPageImage) + Chr(34)', $cr)"/>
				<xsl:value-of select="concat('xmlSystem = xmlSystem + &quot; pageimagefixed=&quot; + Chr(34) + CStr(reqSysPageImageFixed) + Chr(34)', $cr)"/>
				<xsl:value-of select="concat('xmlSystem = xmlSystem + &quot; pageimagefolder=&quot; + Chr(34) + CStr(reqSysPageImageFolder) + Chr(34)', $cr)"/>
				<xsl:value-of select="concat('xmlSystem = xmlSystem + &quot; colorgraybaron=&quot; + Chr(34) + CStr(reqSysColorGraybarOn) + Chr(34)', $cr)"/>
				<xsl:value-of select="concat('xmlSystem = xmlSystem + &quot; colorgraybaroff=&quot; + Chr(34) + CStr(reqSysColorGraybarOff) + Chr(34)', $cr)"/>
				<xsl:value-of select="concat('xmlSystem = xmlSystem + &quot; colordivider=&quot; + Chr(34) + CStr(reqSysColorDivider) + Chr(34)', $cr)"/>
				<xsl:value-of select="concat('xmlSystem = xmlSystem + &quot; colortext=&quot; + Chr(34) + CStr(reqSysColorText) + Chr(34)', $cr)"/>
				<xsl:value-of select="concat('xmlSystem = xmlSystem + &quot; colorprompt=&quot; + Chr(34) + CStr(reqSysColorPrompt) + Chr(34)', $cr)"/>
			</xsl:if>
			<xsl:value-of select="concat('xmlSystem = xmlSystem + &quot; customerid=&quot; + Chr(34) + CStr(reqSysCustomerID) + Chr(34)', $cr)"/>
			<xsl:value-of select="concat('xmlSystem = xmlSystem + &quot; employeeid=&quot; + Chr(34) + CStr(reqSysEmployeeID) + Chr(34)', $cr)"/>
			<xsl:value-of select="concat('xmlSystem = xmlSystem + &quot; affiliateid=&quot; + Chr(34) + CStr(reqSysAffiliateID) + Chr(34)', $cr)"/>
			<xsl:value-of select="concat('xmlSystem = xmlSystem + &quot; affiliatetype=&quot; + Chr(34) + CStr(reqSysAffiliateType) + Chr(34)', $cr)"/>
			<xsl:value-of select="concat('xmlSystem = xmlSystem + &quot; actioncode=&quot; + Chr(34) + CStr(reqActionCode) + Chr(34)', $cr)"/>
			<xsl:if test="$MenuBar!=''">
				<xsl:value-of select="concat('xmlSystem = xmlSystem + &quot; menubarstate=&quot; + Chr(34) + CStr(reqSysMenuBarState) + Chr(34)', $cr)"/>
			</xsl:if>
			<xsl:value-of select="concat('xmlSystem = xmlSystem + &quot; confirm=&quot; + Chr(34) + CStr(reqConfirm) + Chr(34)', $cr)"/>
			<xsl:if test="not($WorkerPage)">
				<xsl:value-of select="concat('xmlSystem = xmlSystem + &quot; pageData=&quot; + Chr(34) + CleanXML(reqPageData) + Chr(34)', $cr)"/>
				<xsl:value-of select="concat('xmlSystem = xmlSystem + &quot; pageURL=&quot; + Chr(34) + CleanXML(reqPageURL) + Chr(34)', $cr)"/>
			</xsl:if>
			<xsl:value-of select="concat('xmlSystem = xmlSystem + &quot; currdate=&quot; + Chr(34) + reqSysDate + Chr(34)', $cr)"/>
			<xsl:value-of select="concat('xmlSystem = xmlSystem + &quot; currtime=&quot; + Chr(34) + reqSysTime + Chr(34)', $cr)"/>
			<xsl:value-of select="concat('xmlSystem = xmlSystem + &quot; currtimeno=&quot; + Chr(34) + reqSysTimeno + Chr(34)', $cr)"/>
			<xsl:value-of select="concat('xmlSystem = xmlSystem + &quot; servername=&quot; + Chr(34) + reqSysServerName + Chr(34)', $cr)"/>
			<xsl:value-of select="concat('xmlSystem = xmlSystem + &quot; serverpath=&quot; + Chr(34) + reqSysServerPath + Chr(34)', $cr)"/>
			<xsl:value-of select="concat('xmlSystem = xmlSystem + &quot; webdirectory=&quot; + Chr(34) + reqSysWebDirectory + Chr(34)', $cr)"/>
			<xsl:if test="/Data/WTENTITY/WTWEBPAGE/@system-options or /Data/WTPAGE/@system-options">
				<xsl:value-of select="concat('xmlSystem = xmlSystem + &quot; options=&quot; + Chr(34) + reqSysOptions + Chr(34)', $cr)"/>
			</xsl:if>

			<xsl:for-each select="/Data/WTPAGE/WTSYSVAR">
		  		<xsl:variable name="lvar">
		  			<xsl:call-template name="CaseLower">
		  				<xsl:with-param name="value" select="@name"/>
		  			</xsl:call-template>
		  		</xsl:variable>
				<xsl:choose>
					<xsl:when test="(@type='text')">
						<xsl:value-of select="concat('xmlSystem = xmlSystem + &quot; ', $lvar, '=&quot; + Chr(34) + reqSys', @name, ' + Chr(34)', $cr)"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="concat('xmlSystem = xmlSystem + &quot; ', $lvar, '=&quot; + Chr(34) + CStr(reqSys', @name, ') + Chr(34)', $cr)"/>
					</xsl:otherwise>
				</xsl:choose>

			</xsl:for-each>

			<xsl:value-of select="concat('xmlSystem = xmlSystem + &quot; /&gt;&quot;', $cr)"/>

			<xsl:if test="not($pagetype='mail')">
				<xsl:value-of select="concat('xmlOwner = &quot;&lt;OWNER&quot;', $cr)"/>
				<xsl:value-of select="concat('xmlOwner = xmlOwner + &quot; id=&quot; + Chr(34) + CStr(reqOwnerID) + Chr(34)', $cr)"/>
				<xsl:value-of select="concat('xmlOwner = xmlOwner + &quot; title=&quot; + Chr(34) + CleanXML(reqOwnerTitle) + Chr(34)', $cr)"/>
				<xsl:value-of select="concat('xmlOwner = xmlOwner + &quot; entity=&quot; + Chr(34) + CStr(reqOwner) + Chr(34)', $cr)"/>
				<xsl:value-of select="concat('xmlOwner = xmlOwner + &quot; /&gt;&quot;', $cr)"/>

				<xsl:value-of select="concat('xmlConfig = &quot;&lt;CONFIG&quot;', $cr)"/>
				<xsl:value-of select="concat('xmlConfig = xmlConfig + &quot; isdocuments=&quot; + Chr(34) + GetCache(&quot;ISDOCUMENTS&quot;) + Chr(34)', $cr)"/>
				<xsl:value-of select="concat('xmlConfig = xmlConfig + &quot; documentpath=&quot; + Chr(34) + GetCache(&quot;DOCUMENTPATH&quot;) + Chr(34)', $cr)"/>
				<xsl:value-of select="concat('xmlConfig = xmlConfig + &quot; /&gt;&quot;', $cr)"/>

				<xsl:call-template name="ASPSysParamData"/>
			</xsl:if>
		</xsl:if>

	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: ASP PARAM DATA-->
	<!-- returns the code to create the PARAM xml for the page -->
	<!--==================================================================-->
	<xsl:template name="ASPSysParamData">
		<xsl:if test="not($WorkerPage)">
			<xsl:value-of select="concat('xmlParam = &quot;&lt;PARAM&quot;', $cr)"/>
			<xsl:for-each select="/Data/WTENTITY/WTWEBPAGE/WTPARAM[not(@private)]">
				<xsl:value-of select="('xmlParam = xmlParam + &quot; ')"/>
				<xsl:call-template name="CaseLower">
					<xsl:with-param name="value" select="@name"/>
				</xsl:call-template>
				<xsl:choose>
					<xsl:when test="(@datatype='text')"><xsl:value-of select="concat('=&quot; + Chr(34) + CleanXML(req', @name, ') + Chr(34)', $cr)"/></xsl:when>
					<xsl:when test="(@datatype='char')"><xsl:value-of select="concat('=&quot; + Chr(34) + req', @name, ' + Chr(34)', $cr)"/></xsl:when>
					<xsl:otherwise><xsl:value-of select="concat('=&quot; + Chr(34) + CStr(req', @name, ') + Chr(34)', $cr)"/></xsl:otherwise>
				</xsl:choose>
			</xsl:for-each>
			<xsl:value-of select="concat('xmlParam = xmlParam + &quot; /&gt;&quot;', $cr, $cr)"/>
		</xsl:if>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: ASP SYSTEM DECLARES-->
	<!-- returns the code to create the common declaration for all system variables -->
	<!--==================================================================-->
	<xsl:template name="ASPSystemDeclares">
		<xsl:param name="pagetype"/>

		<xsl:call-template name="ASPComment">
			<xsl:with-param name="value">system variables</xsl:with-param>
		</xsl:call-template>
		<xsl:value-of select="concat('Dim reqActionCode', $cr)"/>
		<xsl:if test="$MenuBar!=''">
			<xsl:value-of select="concat('Dim reqSysMenuBarState', $cr)"/>
		</xsl:if>
		<xsl:if test="not($WorkerPage)">
			<xsl:value-of select="concat('Dim reqSysTestFile, reqSysLanguage', $cr)"/>
			<xsl:value-of select="concat('Dim reqSysHeaderImage, reqSysFooterImage, reqSysReturnImage, reqSysNavBarImage, reqSysHeaderURL, reqSysReturnURL', $cr)"/>
		</xsl:if>
		<xsl:value-of select="concat('Dim reqSysUserID, reqSysUserGroup, reqSysUserStatus, reqSysUserName, reqSysEmployeeID, reqSysCustomerID, reqSysAffiliateID, reqSysAffiliateType', $cr)"/>
		<xsl:value-of select="concat('Dim reqSysDate, reqSysTime, reqSysTimeno, reqSysServerName, reqSysServerPath, reqSysWebDirectory', $cr)"/>
		<xsl:if test="/Data/WTENTITY/WTWEBPAGE/@system-plan or /Data/WTPAGE/@system-plan">
			<xsl:value-of select="concat('Dim reqSysPlanID', $cr)"/>
		</xsl:if>
		<xsl:if test="/Data/WTENTITY/WTWEBPAGE/@system-shopping or /Data/WTPAGE/@system-shopping">
			<xsl:value-of select="concat('Dim reqSysCartID, reqSysStoreID', $cr)"/>
		</xsl:if>
		<xsl:if test="/Data/WTENTITY/WTWEBPAGE/@system-board or /Data/WTPAGE/@system-board">
			<xsl:value-of select="concat('Dim reqSysBrdUserID, reqSysBrdUserGroup', $cr)"/>
		</xsl:if>
		<xsl:value-of select="concat('Dim reqPageURL, reqPageData, reqReturnURL, reqReturnData', $cr)"/>
		<xsl:if test="count(/Data/WTPAGE/WTSYSVAR)&gt;0">
			<xsl:value-of select="'Dim '"/>
			<xsl:for-each select="/Data/WTPAGE/WTSYSVAR">
				<xsl:value-of select="concat('reqSys', @name )"/>
				<xsl:if test="position()!=last()">
					<xsl:value-of select="', '"/>
				</xsl:if>
			</xsl:for-each>
			<xsl:value-of select="$cr"/>
		</xsl:if>
		<xsl:if test="not($WorkerPage)">
			<xsl:if test="/Data/WTENTITY/WTWEBPAGE/@system-colors or /Data/WTPAGE/@system-colors">
				<xsl:value-of select="concat('Dim reqSysPageColor, reqSysLinkColor, reqSysPageImage, reqSysPageImageFixed, reqSysPageImageFolder, reqSysColorGraybarOn, reqSysColorGraybarOff, reqSysColorDivider, reqSysColorText, reqSysColorPrompt', $cr)"/>
			</xsl:if>
			<xsl:if test="/Data/WTENTITY/WTWEBPAGE/@system-options or /Data/WTPAGE/@system-options">
				<xsl:value-of select="concat('Dim reqSysOptions', $cr)"/>
			</xsl:if>
			<xsl:value-of select="concat('Dim reqLangDialect, reqLangCountry, reqLangDefault', $cr)"/>
			<xsl:value-of select="concat('Dim xmlSystem, xmlConfig, xmlParam, xmlError, xmlErrorLabels, reqConfirm', $cr)"/>
			<xsl:value-of select="concat('Dim xmlTransaction, xmlData', $cr)"/>
			<xsl:if test="($pagetype='list')">
				<xsl:value-of select="concat('Dim xmlOwner, reqOwner, reqOwnerID, reqOwnerTitle', $cr)"/>
			</xsl:if>
		</xsl:if>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: ASP SYSTEM REQUEST ITEMS-->
	<!-- returns the code to populate the page variables for the system data -->
	<!--==================================================================-->
	<xsl:template name="ASPSystemRequestItems">
		<xsl:param name="defaultaction">0</xsl:param>
		<xsl:param name="pagetype"/>
		
		<xsl:if test="not($WorkerPage)">
			<xsl:value-of select="concat($tab0, 'reqSysTestFile = GetInput(&quot;SysTestFile&quot;, reqPageData)', $cr)"/>
			<xsl:value-of select="concat($tab0, 'If Len(reqSysTestFile) &gt; 0 Then', $cr)"/>
			<xsl:value-of select="concat($tab1, 'SetCache &quot;SYSTESTFILE&quot;, reqSysTestFile', $cr)"/>
			<xsl:value-of select="concat($tab0, 'Else', $cr)"/>
			<xsl:value-of select="concat($tab1, 'reqSysTestFile = GetCache(&quot;SYSTESTFILE&quot;)', $cr)"/>
			<xsl:value-of select="concat($tab0, 'End If', $cr, $cr)"/>
		</xsl:if>
		<xsl:value-of select="concat($tab0, 'reqActionCode = Numeric(GetInput(&quot;ActionCode&quot;, reqPageData))', $cr)"/>
		<xsl:if test="$pagetype!='open'">
			<xsl:if test="$MenuBar!=''">
				<xsl:value-of select="concat($tab0, 'If reqActionCode = 0 Then', $cr)"/>
				<xsl:value-of select="concat($tab1, 'reqSysMenuBarState = GetCache(&quot;MENUBARSTATE&quot;)', $cr)"/>
				<xsl:value-of select="concat($tab0, 'Else', $cr)"/>
				<xsl:value-of select="concat($tab1, 'reqSysMenuBarState = GetInput(&quot;MenuBarState&quot;, reqPageData)', $cr)"/>
				<xsl:value-of select="concat($tab1, 'SetCache &quot;MENUBARSTATE&quot;, reqSysMenuBarState', $cr)"/>
				<xsl:value-of select="concat($tab0, 'End If', $cr)"/>
			</xsl:if>
			<xsl:if test="($pagetype='list')">
				<xsl:value-of select="concat($tab0, 'reqOwnerID = Numeric(GetInput(&quot;OwnerID&quot;, reqPageData))', $cr)"/>
				<xsl:value-of select="concat($tab0, 'reqOwner = GetInput(&quot;Owner&quot;, reqPageData)', $cr)"/>
				<xsl:value-of select="concat($tab0, 'reqOwnerTitle = GetInput(&quot;OwnerTitle&quot;, reqPageData)', $cr)"/>
			</xsl:if>
			<xsl:if test="not($WorkerPage)">
				<xsl:value-of select="concat($tab0, 'reqSysHeaderImage = GetCache(&quot;HEADERIMAGE&quot;)', $cr)"/>
				<xsl:value-of select="concat($tab0, 'reqSysFooterImage = GetCache(&quot;FOOTERIMAGE&quot;)', $cr)"/>
				<xsl:value-of select="concat($tab0, 'reqSysReturnImage = GetCache(&quot;RETURNIMAGE&quot;)', $cr)"/>
				<xsl:value-of select="concat($tab0, 'reqSysNavBarImage = GetCache(&quot;NAVBARIMAGE&quot;)', $cr)"/>
				<xsl:value-of select="concat($tab0, 'reqSysHeaderURL = GetCache(&quot;HEADERURL&quot;)', $cr)"/>
				<xsl:value-of select="concat($tab0, 'reqSysReturnURL = GetCache(&quot;RETURNURL&quot;)', $cr)"/>
			</xsl:if>

			<xsl:if test="not($WorkerPage)">
				<xsl:value-of select="concat($tab0, 'reqConfirm = GetCache(&quot;CONFIRM&quot;)', $cr)"/>
				<xsl:value-of select="concat($tab0, 'SetCache &quot;CONFIRM&quot;, &quot;&quot;', $cr)"/>
			</xsl:if>
			<xsl:value-of select="concat($tab0, 'reqSysEmployeeID = Numeric(GetCache(&quot;EMPLOYEEID&quot;))', $cr)"/>
			<xsl:value-of select="concat($tab0, 'reqSysCustomerID = Numeric(GetCache(&quot;CUSTOMERID&quot;))', $cr)"/>
			<xsl:value-of select="concat($tab0, 'reqSysAffiliateID = Numeric(GetCache(&quot;AFFILIATEID&quot;))', $cr)"/>
			<xsl:value-of select="concat($tab0, 'reqSysAffiliateType = Numeric(GetCache(&quot;AFFILIATETYPE&quot;))', $cr)"/>
			<xsl:if test="/Data/WTENTITY/WTWEBPAGE/@system-plan or /Data/WTPAGE/@system-plan">
				<xsl:value-of select="concat($tab0, 'reqSysPlanID = Numeric(GetCache(&quot;PLANID&quot;))', $cr)"/>
			</xsl:if>
			<xsl:if test="/Data/WTENTITY/WTWEBPAGE/@system-shopping or /Data/WTPAGE/@system-shopping">
				<xsl:value-of select="concat($tab0, 'reqSysCartID = Numeric(GetCache(&quot;CARTID&quot;))', $cr)"/>
				<xsl:value-of select="concat($tab0, 'reqSysStoreID = Numeric(GetCache(&quot;STOREID&quot;))', $cr)"/>
			</xsl:if>
			<xsl:if test="/Data/WTENTITY/WTWEBPAGE/@system-board or /Data/WTPAGE/@system-board">
				<xsl:value-of select="concat($tab0, 'reqSysBrdUserID = Numeric(GetCache(&quot;BRDUSERID&quot;))', $cr)"/>
				<xsl:value-of select="concat($tab0, 'reqSysBrdUserGroup = Numeric(GetCache(&quot;BRDUSERGROUP&quot;))', $cr)"/>
			</xsl:if>
			<xsl:if test="/Data/WTENTITY/WTWEBPAGE/@system-colors or /Data/WTPAGE/@system-colors">
				<xsl:value-of select="concat($tab0, 'reqSysPageColor = GetCache(&quot;PAGECOLOR&quot;)', $cr)"/>
				<xsl:value-of select="concat($tab0, 'reqSysLinkColor = GetCache(&quot;LINKCOLOR&quot;)', $cr)"/>
				<xsl:value-of select="concat($tab0, 'reqSysPageImage = GetCache(&quot;PAGEIMAGE&quot;)', $cr)"/>
				<xsl:value-of select="concat($tab0, 'reqSysPageImageFixed = GetCache(&quot;PAGEIMAGEFIXED&quot;)', $cr)"/>
				<xsl:value-of select="concat($tab0, 'reqSysPageImageFolder = GetCache(&quot;PAGEIMAGEFOLDER&quot;)', $cr)"/>
				<xsl:value-of select="concat($tab0, 'reqSysColorGraybarOn = GetCache(&quot;COLORGRAYBARON&quot;)', $cr)"/>
				<xsl:value-of select="concat($tab0, 'reqSysColorGraybarOff = GetCache(&quot;COLORGRAYBAROFF&quot;)', $cr)"/>
				<xsl:value-of select="concat($tab0, 'reqSysColorDivider = GetCache(&quot;COLORDIVIDER&quot;)', $cr)"/>
				<xsl:value-of select="concat($tab0, 'reqSysColorText = GetCache(&quot;COLORTEXT&quot;)', $cr)"/>
				<xsl:value-of select="concat($tab0, 'reqSysColorPrompt = GetCache(&quot;COLORPROMPT&quot;)', $cr)"/>
			</xsl:if>
		</xsl:if>
		<xsl:variable name="lowername">
			<xsl:call-template name="CaseLower">
				<xsl:with-param name="value" select="/Data/WTENTITY/WTWEBPAGE/@name"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:value-of select="concat($tab0, 'reqSysDate = CStr(Date())', $cr)"/>
		<xsl:value-of select="concat($tab0, 'reqSysTime = CStr(Time())', $cr)"/>
		<xsl:value-of select="concat($tab0, 'reqSysTimeno = CStr((Hour(Time())*100 ) + Minute(Time()))', $cr)"/>
		<xsl:value-of select="concat($tab0, 'reqSysServerName = Request.ServerVariables(&quot;SERVER_NAME&quot;)', $cr)"/>
		<xsl:value-of select="concat($tab0, 'reqSysWebDirectory = Request.ServerVariables(&quot;APPL_PHYSICAL_PATH&quot;)', $cr)"/>
		<xsl:value-of select="concat($tab0, 'reqSysServerPath = Request.ServerVariables(&quot;PATH_INFO&quot;)', $cr)"/>
		<xsl:value-of select="concat($tab0, 'pos = InStr(LCASE(reqSysServerPath), &quot;', $lowername, '&quot;)', $cr)"/>
		<xsl:value-of select="concat($tab0, 'If pos &gt; 0 Then reqSysServerPath = left(reqSysServerPath, pos-1)', $cr, $cr)"/>

		<xsl:if test="$pagetype!='open'">
			<xsl:for-each select="/Data/WTPAGE/WTSYSVAR">
		  		<xsl:variable name="uvar">
		  			<xsl:call-template name="CaseUpper">
		  				<xsl:with-param name="value" select="@name"/>
		  			</xsl:call-template>
		  		</xsl:variable>
				<xsl:variable name="convert1">
					<xsl:choose>
						<xsl:when test="(@type='number')">Numeric(</xsl:when>
						<xsl:otherwise></xsl:otherwise>
					</xsl:choose>
				</xsl:variable>
				<xsl:variable name="convert2">
					<xsl:choose>
						<xsl:when test="(@type='number')">)</xsl:when>
						<xsl:otherwise></xsl:otherwise>
					</xsl:choose>
				</xsl:variable>

				<xsl:value-of select="concat($tab0, 'reqSys', @name, ' = ', $convert1, 'GetCache(&quot;', $uvar, '&quot;)', $convert2, $cr)"/>
			</xsl:for-each>

			<xsl:if test="not($WorkerPage)">
				<xsl:if test="/Data/WTENTITY/WTWEBPAGE/@system-options or /Data/WTPAGE/@system-options">
					<xsl:if test="/Data/WTENTITY/WTWEBPAGE/@system-loadoptions or /Data/WTPAGE/@system-loadoptions">
						<xsl:value-of select="concat($tab0, 'reqSysOptions = GetCache(&quot;OPTIONS&quot;)', $cr)"/>
						<xsl:value-of select="concat($tab0, 'If reqSysOptions = &quot;&quot; Then', $cr)"/>
						<xsl:value-of select="concat($tab1, 'Set oBusiness = server.CreateObject(&quot;', $appprefix, 'BusinessUser.CBusiness&quot;)', $cr)"/>
						<xsl:value-of select="concat($tab1, 'If oBusiness Is Nothing Then', $cr)"/>
						<xsl:value-of select="concat($tab2, 'DoError Err.Number, Err.Source, &quot;Unable to Create Object - ', $appprefix, 'BusinessUser.CBusiness&quot;', $cr)"/>
						<xsl:value-of select="concat($tab1, 'Else', $cr)"/>
						<xsl:value-of select="concat($tab2, 'With oBusiness', $cr)"/>
						<xsl:if test="/Data/WTPAGE/@multi-instance">
							<xsl:value-of select="concat($tab3, '.SysClientProject SysClient, SysProject', $cr)"/>
						</xsl:if>
						<xsl:value-of select="concat($tab3, '.Load 1, 1', $cr)"/>
						<xsl:value-of select="concat($tab3, 'If (Err.Number &lt;&gt; 0) Then DoError Err.Number, Err.Source, Err.Description End If', $cr)"/>
						<xsl:value-of select="concat($tab3, 'reqSysOptions = .Options', $cr)"/>
						<xsl:value-of select="concat($tab3, 'If reqSysOptions = &quot;&quot; Then reqSysOptions = &quot;~&quot;', $cr)"/>
						<xsl:value-of select="concat($tab3, 'SetCache &quot;OPTIONS&quot;, reqSysOptions', $cr)"/>
						<xsl:value-of select="concat($tab2, 'End With', $cr)"/>
						<xsl:value-of select="concat($tab1, 'End If', $cr)"/>
						<xsl:value-of select="concat($tab1, 'Set oBusiness = Nothing', $cr)"/>
						<xsl:value-of select="concat($tab0, 'End If', $cr)"/>
					</xsl:if>
					<xsl:if test="not(/Data/WTENTITY/WTWEBPAGE/@system-loadoptions or /Data/WTPAGE/@system-loadoptions)">
						<xsl:value-of select="concat($tab0, 'reqSysOptions = GetCache(&quot;OPTIONS&quot;)', $cr)"/>
					</xsl:if>
				</xsl:if>
			</xsl:if>
		</xsl:if>

	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: ASP RETURN URL CREATE-->
	<!-- returns the code to create the page's URL and form data -->
	<!--==================================================================-->
	<xsl:template name="ASPReturnURLCreate">
		<xsl:if test="not($WorkerPage)">
			<xsl:call-template name="ASPComment">
				<xsl:with-param name="value">set my page's URL and form for any of my links</xsl:with-param>
			</xsl:call-template>
			<xsl:value-of select="concat($tab0, 'reqPageURL = Replace(MakeReturnURL(), &quot;&amp;&quot;, &quot;%26&quot;)', $cr)"/>
			<xsl:value-of select="concat($tab0, 'tmpPageData = Replace(MakeFormCache(), &quot;&amp;&quot;, &quot;%26&quot;)', $cr)"/>
			<xsl:call-template name="ASPComment">
				<xsl:with-param name="value">If the Form cache is empty, do not replace the return data</xsl:with-param>
			</xsl:call-template>
			<xsl:value-of select="concat($tab0, 'If tmpPageData &lt;&gt; &quot;&quot; Then', $cr)"/>
			<xsl:value-of select="concat($tab1, 'reqPageData = tmpPageData', $cr)"/>
			<xsl:value-of select="concat($tab0, 'End If', $cr, $cr)"/>
		</xsl:if>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: ASP RETURN URL SET-->
	<!-- returns the code to set the return URL information for the page -->
	<!--==================================================================-->
	<xsl:template name="ASPReturnURLSet">
		<xsl:param name="pageno"/>

		<xsl:call-template name="ASPComment">
			<xsl:with-param name="value">save the return URL and form data if supplied</xsl:with-param>
		</xsl:call-template>
		<xsl:value-of select="concat($tab0, 'If (Len(Request.Item(&quot;ReturnURL&quot;)) &gt; 0) Then', $cr)"/>
		<xsl:value-of select="concat($tab1, 'reqReturnURL = Replace(Request.Item(&quot;ReturnURL&quot;), &quot;&amp;&quot;, &quot;%26&quot;)', $cr)"/>
		<xsl:value-of select="concat($tab1, 'reqReturnData = Replace(Request.Item(&quot;ReturnData&quot;), &quot;&amp;&quot;, &quot;%26&quot;)', $cr)"/>
		<xsl:value-of select="concat($tab1, 'SetCache &quot;', $pageno, 'URL&quot;, reqReturnURL', $cr)"/>
		<xsl:value-of select="concat($tab1, 'SetCache &quot;', $pageno, 'DATA&quot;, reqReturnData', $cr)"/>
		<xsl:value-of select="concat($tab0, 'End If', $cr, $cr)"/>

		<xsl:call-template name="ASPComment">
			<xsl:with-param name="value">restore my form if it was cached</xsl:with-param>
		</xsl:call-template>
		<xsl:value-of select="concat($tab0, 'reqPageData = GetCache(&quot;RETURNDATA&quot;)', $cr)"/>
		<xsl:value-of select="concat($tab0, 'SetCache &quot;RETURNDATA&quot;, &quot;&quot;', $cr, $cr)"/>

<!--*** TEST Page URL Data *** -->
<xsl:if test="false()">		
		<xsl:value-of select="concat($tab0, 'Response.Write &quot;&lt;BR/&gt; ReturnURL: &quot; + reqReturnURL', $cr)"/>
		<xsl:value-of select="concat($tab0, 'Response.Write &quot;&lt;BR/&gt; ReturnData: &quot; + reqReturnData', $cr)"/>
		<xsl:value-of select="concat($tab0, 'Response.Write &quot;&lt;BR/&gt; CACHE PageData: &quot; + reqPageData', $cr)"/>
		<xsl:value-of select="concat($tab0, 'Response.Write &quot;&lt;BR/&gt; FORM PageURL: &quot; + MakeReturnURL()', $cr, $cr)"/>
		<xsl:value-of select="concat($tab0, 'Response.Write &quot;&lt;BR/&gt; FORM PageData: &quot; + MakeFormCache()', $cr)"/>
</xsl:if>		

	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: Build/Load Menu Definitions -->
	<!--==================================================================-->
	<xsl:template name="BuildMenus">

		<xsl:if test="not($WorkerPage)">

			<xsl:call-template name="ASPComment">
				<xsl:with-param name="value">get the menu Definitions</xsl:with-param>
			</xsl:call-template>

			<xsl:if test="$MenuBar!=''">
				<xsl:if test="/Data/WTENTITY/WTWEBPAGE/@contentpage">
					<xsl:value-of select="concat($tab0, 'If reqContentPage = 0 Then', $cr)"/>
						<xsl:value-of select="concat($tab1, 'xml', $MenuBar, ' = Get', $MenuBar, '()', $cr)"/>
					<xsl:value-of select="concat($tab0, 'End If', $cr, $cr)"/>
				</xsl:if>
				<xsl:if test="not(/Data/WTENTITY/WTWEBPAGE/@contentpage)">
					<xsl:value-of select="concat($tab0, 'xml', $MenuBar, ' = Get', $MenuBar, '()', $cr, $cr)"/>
				</xsl:if>
			</xsl:if>

			<xsl:for-each select="/Data/WTENTITY/WTWEBPAGE/WTCONTENT">
				<xsl:apply-templates select="WTMENU"/>
			</xsl:for-each>

		</xsl:if>

	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: ASP BUILD TXN DATA -->
	<!-- build text string of Transaction Data -->
	<!--==================================================================-->
	<xsl:template name="ASPBuildTXNData">
		<xsl:param name="unique-objects"/>
		<xsl:param name="datatxn-objects"/>

		<xsl:if test="not($WorkerPage)">
			<xsl:call-template name="ASPComment">
				<xsl:with-param name="value">get the transaction XML</xsl:with-param>
			</xsl:call-template>
			<xsl:value-of select="concat($tab0, 'xmlTransaction = &quot;&lt;TXN&gt;&quot;', $cr)"/>
			<xsl:apply-templates select="$unique-objects" mode="appendxml">
				<xsl:with-param name="indent">0</xsl:with-param>
			</xsl:apply-templates>
			<xsl:apply-templates select="$datatxn-objects" mode="appendxml">
				<xsl:with-param name="indent">0</xsl:with-param>
			</xsl:apply-templates>
			<xsl:value-of select="concat($tab0, 'xmlTransaction = xmlTransaction + &quot;&lt;/TXN&gt;&quot;', $cr, $cr)"/>
		</xsl:if>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: ASP BUILD XML DATA -->
	<!-- returns the code to transform the page's XML using the XSL stylesheet -->
	<!--==================================================================-->
	<xsl:template name="ASPBuildXMLData">
		<xsl:param name="pagetype"/>

		<xsl:if test="not($WorkerPage)">
			<xsl:call-template name="ASPComment">
				<xsl:with-param name="value">get the data XML</xsl:with-param>
			</xsl:call-template>
			<xsl:value-of select="concat($tab0, 'xmlData = &quot;&lt;DATA&gt;&quot;', $cr)"/>
			<xsl:value-of select="concat($tab0, 'xmlData = xmlData +  xmlTransaction', $cr)"/>
			<xsl:value-of select="concat($tab0, 'xmlData = xmlData +  xmlSystem', $cr)"/>
			<xsl:value-of select="concat($tab0, 'xmlData = xmlData +  xmlParam', $cr)"/>
		
			<xsl:if test="not($pagetype='mail')">
				<xsl:value-of select="concat($tab0, 'xmlData = xmlData +  xmlOwner', $cr)"/>
				<xsl:value-of select="concat($tab0, 'xmlData = xmlData +  xmlConfig', $cr)"/>
				<xsl:value-of select="concat($tab0, 'xmlData = xmlData +  xmlParent', $cr)"/>
				<xsl:value-of select="concat($tab0, 'xmlData = xmlData +  xmlBookmark', $cr)"/>
			</xsl:if>
		
			<xsl:value-of select="concat($tab0, 'xmlData = xmlData +  xmlLanguage', $cr)"/>
			<xsl:value-of select="concat($tab0, 'xmlData = xmlData +  xmlError', $cr)"/>
			<xsl:value-of select="concat($tab0, 'xmlData = xmlData +  xmlErrorLabels', $cr)"/>

			<xsl:if test="$MenuBar!=''">
				<xsl:value-of select="concat($tab0, 'xmlData = xmlData +  xml', $MenuBar, $cr)"/>
			</xsl:if>

			<xsl:for-each select="/Data/WTENTITY/WTWEBPAGE/WTCONTENT/WTMENU">
				<xsl:value-of select="concat($tab0, 'xmlData = xmlData +  xml', @name, $cr)"/>
			</xsl:for-each>

			<xsl:for-each select="/Data/WTENTITY/WTWEBPAGE/WTCONTENT/WTTAB">
				<xsl:value-of select="concat($tab0, 'xmlData = xmlData +  xml', @name, $cr)"/>
			</xsl:for-each>

			<xsl:apply-templates select="WTWEBPAGE/WTDATA" mode="appendxml">
				<xsl:with-param name="indent">0</xsl:with-param>
			</xsl:apply-templates>
			<xsl:value-of select="concat($tab0, 'xmlData = xmlData + &quot;&lt;/DATA&gt;&quot;', $cr, $cr)"/>
		</xsl:if>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: ASP TRANSFORM -->
	<!-- returns the code to transform the page's XML using the XSL stylesheet -->
	<!--==================================================================-->
	<xsl:template name="ASPTransform">
		<xsl:if test="not($WorkerPage)">
			<xsl:call-template name="ASPComment">
				<xsl:with-param name="value">transform the XML with the XSL</xsl:with-param>
			</xsl:call-template>
			<xsl:if test="/Data/WTENTITY/WTWEBPAGE/@hack=1">
				<xsl:value-of select="concat('Response.Write Replace( oData.transformNode(oStyle), &quot;charset=UTF-16&quot;, &quot;charset=UTF-8&quot; )', $cr, $cr)"/>
			</xsl:if>
			<xsl:if test="not(/Data/WTENTITY/WTWEBPAGE/@hack=1)">
				<xsl:value-of select="concat('Response.Write oData.transformNode(oStyle)', $cr, $cr)"/>
			</xsl:if>
		</xsl:if>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: ASP TRANSFORM MAIL -->
	<!-- returns the code to transform the page's XML using the XSL stylesheet -->
	<!--==================================================================-->
	<xsl:template name="ASPTransformMail">
		<xsl:call-template name="ASPComment">
			<xsl:with-param name="value">transform the XML with the XSL</xsl:with-param>
		</xsl:call-template>
		<xsl:value-of select="concat('tmpBody = oData.transformNode(oStyle)', $cr, $cr)"/>
		<xsl:value-of select="concat('tmpTest =  Numeric(GetInput(&quot;TEST&quot;, reqPageData))', $cr)"/>
		<xsl:value-of select="concat('If tmpTest &lt;&gt; 0 Then', $cr)"/>
		<xsl:value-of select="concat('   response.write &quot;&lt;br&gt;sender: &quot; + tmpSender', $cr)"/>
		<xsl:value-of select="concat('   response.write &quot;&lt;br&gt;from: &quot; + tmpFrom', $cr)"/>
		<xsl:value-of select="concat('   response.write &quot;&lt;br&gt;to: &quot; + tmpTo', $cr)"/>
		<xsl:value-of select="concat('   response.write &quot;&lt;br&gt;subject: &quot; + tmpSubject', $cr)"/>
		<xsl:value-of select="concat('   response.write &quot;&lt;br&gt;body:&lt;br&gt;&quot; + tmpBody', $cr)"/>
		<xsl:value-of select="concat('End If', $cr, $cr)"/>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: ASP MAIL PAGE HEADER -->
	<!-- setup for a Mail Page message -->
	<!--==================================================================-->
	<xsl:template name="ASPMailPageHeader">
		<xsl:variable name="unique-objects" select="/Data/WTENTITY/WTWEBPAGE/*/WTOBJECT[generate-id() = generate-id(key('key-objects',@name))]"/>
		<xsl:variable name="datatxn-objects" select="/Data/WTENTITY/WTWEBPAGE/WTDATATXN"/>

		<xsl:value-of select="$cr"/>
		<xsl:call-template name="ASPComment">
			<xsl:with-param name="value">*****Setup for Email Message*****</xsl:with-param>
		</xsl:call-template>

		<!--========== GET LANGUAGE XML ==========-->
		<xsl:value-of select="concat('If tmpSysLanguage &lt;&gt; reqSysLanguage Then', $cr)"/>
		<xsl:value-of select="concat($tab1, 'tmpSysLanguage = reqSysLanguage', $cr)"/>
		<xsl:value-of select="concat('End If', $cr, $cr)"/>
		<xsl:call-template name="ASPLanguageData"/>

		<!--========== GET PARAMETERS XML =======-->
		<xsl:call-template name="ASPSysParamData"/>

		<!--========== GET TRANSACTION XML =======-->
		<xsl:call-template name="ASPBuildTXNData">
			<xsl:with-param name="unique-objects" select="$unique-objects"/>
			<xsl:with-param name="datatxn-objects" select="$datatxn-objects"/>
		</xsl:call-template>

		<!--========== GET DATA XML ==========-->
		<xsl:call-template name="ASPBuildXMLData">
			<xsl:with-param name="pagetype">mail</xsl:with-param>
		</xsl:call-template>

		<!--========== LOAD XML DATA ==========-->
		<xsl:call-template name="ASPXMLData"/>

		<!--========== SAVE XML DATA ==========-->
		<xsl:call-template name="ASPSaveXMLData"/>

		<!--========== TRANSFORM PAGE =========-->
		<xsl:call-template name="ASPTransformMail"/>
		
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: ASP XML DATA-->
	<!-- load XML data -->
	<!--==================================================================-->
	<xsl:template name="ASPXMLData">
		<xsl:if test="not($WorkerPage)">
			<xsl:call-template name="ASPComment">
				<xsl:with-param name="value">create a DOM object for the XML</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="ASPDOMLoad">
				<xsl:with-param name="name"><xsl:text>oData</xsl:text></xsl:with-param>
				<xsl:with-param name="xml"><xsl:text>xmlData</xsl:text></xsl:with-param>
			</xsl:call-template>
			<xsl:value-of select="$cr"/>
		</xsl:if>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: ASP STYLESHEET -->
	<!-- load page stylesheet -->
	<!--==================================================================-->
	<xsl:template name="ASPStyleSheet">
		<xsl:if test="not($WorkerPage)">
			<xsl:call-template name="ASPComment">
				<xsl:with-param name="value">create a DOM object for the XSL</xsl:with-param>
			</xsl:call-template>
			<xsl:if test="not(/Data/WTENTITY/WTWEBPAGE/@stylesheeturl)">
				<xsl:value-of select="concat('xslPage = &quot;', /Data/WTENTITY/WTWEBPAGE/@name, '.xsl&quot;', $cr)"/>
				<xsl:call-template name="ASPDOMLoadFile">
					<xsl:with-param name="name"><xsl:text>oStyle</xsl:text></xsl:with-param>
					<xsl:with-param name="file"><xsl:text>xslPage</xsl:text></xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<xsl:if test="/Data/WTENTITY/WTWEBPAGE/@stylesheeturl">
				<xsl:call-template name="ASPDOMLoadURL">
					<xsl:with-param name="name"><xsl:text>oStyle</xsl:text></xsl:with-param>
					<xsl:with-param name="url"><xsl:value-of select="/Data/WTENTITY/WTWEBPAGE/@stylesheeturl"/></xsl:with-param>
				</xsl:call-template>
			</xsl:if>

			<xsl:value-of select="$cr"/>
		</xsl:if>
	</xsl:template>

	<!--==================================================================-->
	<!-- TEMPLATE: ASP SAVEXMLDATA -->
	<!-- save the XML data file -->
	<!--==================================================================-->
	<xsl:template name="ASPSaveXMLData">
		<xsl:if test="not($WorkerPage)">
			<xsl:value-of select="concat($tab0, 'If Len(reqSysTestFile) &gt; 0 Then', $cr)"/>
			<xsl:value-of select="concat($tab1, 'oData.save reqSysTestFile', $cr)"/>
			<xsl:value-of select="concat($tab0, 'End If', $cr, $cr)"/>

			<xsl:if test="/Data/WTENTITY/WTWEBPAGE/@test or /Data/WTPAGE/@test">
				<xsl:value-of select="concat($tab0, 'Response.write Request.Cookies(&quot;temp', $appprefix, '&quot;)', $cr, $cr)"/>
			</xsl:if>
		</xsl:if>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTCODEGROUP" mode="docase">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:apply-templates select=".">
			<xsl:with-param name="indent" select="$indent"/>			
		</xsl:apply-templates>
	</xsl:template>
	
	<!--==================================================================-->
	<xsl:template match="WTCODEGROUP">
	<!--==================================================================-->
		<xsl:param name="indent">0</xsl:param>

		<xsl:variable name="hasconditions" select="(count(WTCONDITION) > 0)"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="ind2"><xsl:choose><xsl:when test="$hasconditions"><xsl:value-of select="concat($ind1, $tab1)"/></xsl:when><xsl:otherwise><xsl:value-of select="$ind1"/></xsl:otherwise></xsl:choose></xsl:variable>
		<xsl:variable name="indent2"><xsl:choose><xsl:when test="$hasconditions"><xsl:value-of select="$indent+1"/></xsl:when><xsl:otherwise><xsl:value-of select="$indent"/></xsl:otherwise></xsl:choose></xsl:variable>
		<xsl:variable name="ind3" select="concat($ind2, $tab1)"/>
		<xsl:variable name="indent3" select="$indent2+1"/>

		<!--generate IF statement for conditions if they exist-->
		<xsl:if test="($hasconditions)">
			<xsl:call-template name="ASPConditionStart">
				<xsl:with-param name="indent" select="$indent"/>
				<xsl:with-param name="conditions" select="WTCONDITION"/>
			</xsl:call-template>
		</xsl:if>

		<xsl:apply-templates select="WTSETATTRIBUTE | WTSETCACHE | WTGETCACHE | WTSETCOOKIE | WTGETCOOKIE | WTVARIABLE | WTOBJECT | WTCOMMENT | WTCUSTOM | WTMETHOD | WTMAIL | WTRETURN | WTERROR | WTCODEGROUP | WTCALLSUB | WTACTIONLOG | WTHTTP" mode="docase">
			<xsl:with-param name="indent" select="$indent2"/>
		</xsl:apply-templates>

		<!--close IF statement for conditions if they exist-->
		<xsl:if test="($hasconditions)">
			<xsl:call-template name="ASPConditionEnd">
				<xsl:with-param name="indent" select="$indent"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTCOMMENT" mode="docase">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:apply-templates select=".">
			<xsl:with-param name="indent" select="$indent"/>			
		</xsl:apply-templates>
	</xsl:template>
	
	<!--==================================================================-->
	<xsl:template match="WTCOMMENT">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:value-of select="concat($ind1, $apos, ., $cr)"/>
	</xsl:template>
	
	<!--==================================================================-->
	<xsl:template match="WTCUSTOM" mode="docase">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:apply-templates select=".">
			<xsl:with-param name="indent" select="$indent"/>			
		</xsl:apply-templates>
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
			<xsl:when test="$type='PARAM'">
			<xsl:value-of select="concat('req', $text)"/>
			<xsl:if test="count(/Data/WTENTITY/WTWEBPAGE/WTPARAM[@name=$text])=0">
				<xsl:call-template name="Error">
					<xsl:with-param name="msg" select="'Invalid PARAM() Name'"/>
					<xsl:with-param name="text" select="$text"/>
				</xsl:call-template>
			</xsl:if>
			</xsl:when>
			<xsl:when test="$type='CONST'"><xsl:value-of select="$text"/></xsl:when>
			<xsl:when test="$type='FINDID'"><xsl:value-of select="/Data/WTENTITY/WTATTRIBUTE[@name=$text]/@id"/></xsl:when>
			<xsl:when test="$type='FORM'"><xsl:value-of select="concat('Request.Form.Item(&quot;', $text, '&quot;)')"/></xsl:when>
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
			<xsl:when test="$type='ATTRIBUTE'">
				<xsl:variable name="ent"><xsl:value-of select="/Data/WTENTITY/WTATTRIBUTE[@name=$text]/@id"/></xsl:variable>
				<xsl:value-of select="$ent"/>
				<xsl:if test="string-length($ent)=0">
					<xsl:call-template name="Error">
					 	<xsl:with-param name="msg" select="'Invalid ATTRIBUTE() Name'"/>
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
				<xsl:when test="$ltext='headerimage'">reqSysHeaderImage</xsl:when>
				<xsl:when test="$ltext='footerimage'">reqSysFooterImage</xsl:when>
				<xsl:when test="$ltext='returnimage'">reqSysReturnImage</xsl:when>
				<xsl:when test="$ltext='navbarimage'">reqSysNavBarImage</xsl:when>
				<xsl:when test="$ltext='headerurl'">reqSysHeaderURL</xsl:when>
				<xsl:when test="$ltext='returnurl'">reqSysReturnURL</xsl:when>
				<xsl:when test="$ltext='language'">reqSysLanguage</xsl:when>
				<xsl:when test="$ltext='langdialect'">reqLangDialect</xsl:when>
				<xsl:when test="$ltext='langcountry'">reqLangCountry</xsl:when>
				<xsl:when test="$ltext='langdefault'">reqLangDefault</xsl:when>
				<xsl:when test="$ltext='userid'">reqSysUserID</xsl:when>
				<xsl:when test="$ltext='usergroup'">reqSysUserGroup</xsl:when>
				<xsl:when test="$ltext='userstatus'">reqSysUserStatus</xsl:when>
				<xsl:when test="$ltext='username'">reqSysUserName</xsl:when>
				<xsl:when test="$ltext='employeeid'">reqSysEmployeeID</xsl:when>
				<xsl:when test="$ltext='customerid'">reqSysCustomerID</xsl:when>
				<xsl:when test="$ltext='affiliateid'">reqSysAffiliateID</xsl:when>
				<xsl:when test="$ltext='affiliatetype'">reqSysAffiliateType</xsl:when>
				<xsl:when test="$ltext='planid'">reqSysPlanID</xsl:when>
				<xsl:when test="$ltext='cartid'">reqSysCartID</xsl:when>
				<xsl:when test="$ltext='storeid'">reqSysStoreID</xsl:when>
				<xsl:when test="$ltext='brduserid'">reqSysBrdUserID</xsl:when>
				<xsl:when test="$ltext='brdusergroup'">reqSysBrdUserGroup</xsl:when>
				<xsl:when test="$ltext='pagecolor'">reqSysPageColor</xsl:when>
				<xsl:when test="$ltext='linkcolor'">reqSysLinkColor</xsl:when>
				<xsl:when test="$ltext='pageimage'">reqSysPageImage</xsl:when>
				<xsl:when test="$ltext='pageimagefixed'">reqSysPageImageFixed</xsl:when>
				<xsl:when test="$ltext='pageimagefolder'">reqSysPageImageFolder</xsl:when>
				<xsl:when test="$ltext='colorgraybaron'">reqSysColorGraybarOn</xsl:when>
				<xsl:when test="$ltext='colorgraybaroff'">reqSysColorGraybarOff</xsl:when>
				<xsl:when test="$ltext='colordivider'">reqSysColorDivider</xsl:when>
				<xsl:when test="$ltext='colortext'">reqSysColorText</xsl:when>
				<xsl:when test="$ltext='colorprompt'">reqSysColorPrompt</xsl:when>
				<xsl:when test="$ltext='actioncode'">reqActionCode</xsl:when>
				<xsl:when test="$ltext='menubarstate'">reqMenuBarState</xsl:when>
				<xsl:when test="$ltext='now'">Now</xsl:when>
				<xsl:when test="$ltext='date'">reqSysDate</xsl:when>
				<xsl:when test="$ltext='time'">reqSysTime</xsl:when>
				<xsl:when test="$ltext='timeno'">reqSysTimeno</xsl:when>
				<xsl:when test="$ltext='servername'">reqSysServerName</xsl:when>
				<xsl:when test="$ltext='serverpath'">reqSysServerPath</xsl:when>
				<xsl:when test="$ltext='webdirectory'">reqSysWebDirectory</xsl:when>
				<xsl:when test="$ltext='options'">reqSysOptions</xsl:when>
				<xsl:when test="$ltext='country'">reqCountry</xsl:when>
				<xsl:when test="$ltext='dialect'">reqDialect</xsl:when>
				<xsl:when test="$ltext='searchtype'">reqFindID</xsl:when>
				<xsl:when test="$ltext='listtype'">reqListType</xsl:when>
				<xsl:when test="$ltext='owner'">reqOwner</xsl:when>
				<xsl:when test="$ltext='ownerid'">reqOwnerID</xsl:when>
				<xsl:when test="$ltext='ownertitle'">reqOwnerTitle</xsl:when>
				<xsl:when test="$ltext='pageurl'">reqPageURL</xsl:when>
				<xsl:when test="$ltext='returnurl'">reqReturnURL</xsl:when>
				<xsl:when test="$ltext='signinurl'">reqSignInURL</xsl:when>
				<xsl:when test="$ltext='errormsg'">xmlError</xsl:when>
				<xsl:when test="$ltext='errorno'">Err.Number</xsl:when>
				<xsl:otherwise>
					<!-- check for an application defined variable -->
				  	<xsl:variable name="GetVal">
						<xsl:for-each select="/Data/WTPAGE/WTSYSVAR">
						  	<xsl:variable name="lvar">
						  		<xsl:call-template name="CaseLower">
						  			<xsl:with-param name="value" select="@name"/>
						  		</xsl:call-template>
						  	</xsl:variable>
							<xsl:if test="$ltext=$lvar">
								<xsl:value-of select="concat('reqSys', @name)"/>
							</xsl:if>
						</xsl:for-each>
				  	</xsl:variable>

					<xsl:choose>
					<xsl:when test="string-length($GetVal)!=0"><xsl:value-of select="$GetVal"/></xsl:when>
					<xsl:otherwise>
						<xsl:call-template name="Error">
							<xsl:with-param name="msg" select="'Invalid SYS() Name'"/>
							<xsl:with-param name="text" select="$text"/>
						</xsl:call-template>
					</xsl:otherwise>
					</xsl:choose>

				</xsl:otherwise>
				</xsl:choose>
		   </xsl:when>

		  <xsl:when test="$type='SVR'">
				<xsl:choose>
				<xsl:when test="$text='ALL_HTTP'"/>
				<xsl:when test="$text='ALL_RAW'"/>
				<xsl:when test="$text='APPL_MD_PATH'"/>
				<xsl:when test="$text='APPL_PHYSICAL_PATH'"/>
				<xsl:when test="$text='AUTH_PASSWORD'"/>
				<xsl:when test="$text='AUTH_TYPE'"/>
				<xsl:when test="$text='AUTH_USER'"/>
				<xsl:when test="$text='CERT_COOKIE'"/>
				<xsl:when test="$text='CERT_FLAGS'"/>
				<xsl:when test="$text='CERT_ISSUER'"/>
				<xsl:when test="$text='CERT_KEYSIZE'"/>
				<xsl:when test="$text='CERT_SECRETKEYSIZE'"/>
				<xsl:when test="$text='CERT_SERIALNUMBER'"/>
				<xsl:when test="$text='CERT_SERVER_ISSUER'"/>
				<xsl:when test="$text='CERT_SERVER_SUBJECT'"/>
				<xsl:when test="$text='CERT_SUBJECT'"/>
				<xsl:when test="$text='CONTENT_LENGTH'"/>
				<xsl:when test="$text='CONTENT_TYPE'"/>
				<xsl:when test="$text='GATEWAY_INTERFACE'"/>
				<xsl:when test="$text='HTTP_ACCEPT'"/>
				<xsl:when test="$text='HTTP_ACCEPT_LANGUAGE'"/>
				<xsl:when test="$text='HTTP_USER_AGENT'"/>
				<xsl:when test="$text='HTTP_COOKIE'"/>
				<xsl:when test="$text='HTTP_REFERER'"/>
				<xsl:when test="$text='HTTPS'"/>
				<xsl:when test="$text='HTTPS_KEYSIZE'"/>
				<xsl:when test="$text='HTTPS_SECRETKEYSIZE'"/>
				<xsl:when test="$text='HTTPS_SERVER_ISSUER'"/>
				<xsl:when test="$text='HTTPS_SERVER_SUBJECT'"/>
				<xsl:when test="$text='INSTANCE_ID'"/>
				<xsl:when test="$text='INSTANCE_META_PATH'"/>
				<xsl:when test="$text='LOCAL_ADDR'"/>
				<xsl:when test="$text='LOGON_USER'"/>
				<xsl:when test="$text='PATH_INFO'"/>
				<xsl:when test="$text='PATH_TRANSLATED'"/>
				<xsl:when test="$text='QUERY_STRING'"/>
				<xsl:when test="$text='REMOTE_ADDR'"/>
				<xsl:when test="$text='REMOTE_HOST'"/>
				<xsl:when test="$text='REMOTE_USER'"/>
				<xsl:when test="$text='REQUEST_METHOD'"/>
				<xsl:when test="$text='SCRIPT_NAME'"/>
				<xsl:when test="$text='SERVER_NAME'"/>
				<xsl:when test="$text='SERVER_PORT'"/>
				<xsl:when test="$text='SERVER_PORT_SECURE'"/>
				<xsl:when test="$text='SERVER_PROTOCOL'"/>
				<xsl:when test="$text='SERVER_SOFTWARE'"/>
				<xsl:otherwise>
					 <xsl:call-template name="Error">
					 	<xsl:with-param name="msg" select="'Invalid SYS() Name'"/>
					 	<xsl:with-param name="text" select="$text"/>
					 </xsl:call-template>
				</xsl:otherwise>
				</xsl:choose>
				<xsl:value-of select="concat('Request.ServerVariables(&quot;', $text, '&quot;)')"/>
		   </xsl:when>

		  <xsl:when test="$type='CONFIG'">
				<xsl:choose>
				<xsl:when test="$text='isdocuments'">cfgIsDocuments</xsl:when>
				<xsl:when test="$text='documentpath'">cfgDocumentPath</xsl:when>
				<xsl:otherwise>
					 <xsl:call-template name="Error">
					 	<xsl:with-param name="msg" select="'Invalid CONFIG() Name'"/>
					 	<xsl:with-param name="text" select="$text"/>
					 </xsl:call-template>
				</xsl:otherwise>
				</xsl:choose>
		  </xsl:when>
		  <xsl:when test="$type='VALUE'">
				<xsl:value-of select="$text"/>
		  </xsl:when>
		  <xsl:when test="$type='NONE'">
				<xsl:choose>
					 <xsl:when test="$text='true'">True</xsl:when>
					 <xsl:when test="$text='false'">False</xsl:when>
					 <xsl:otherwise><xsl:value-of select="$text"/></xsl:otherwise>
				</xsl:choose>
		  </xsl:when>
		  <xsl:otherwise>
				<xsl:value-of select="$text"/>
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
		  <xsl:when test="$type='PARAM'"><xsl:value-of select="/Data/WTENTITY/WTATTRIBUTE[@name=$text]/@type"/></xsl:when>
<!--		  <xsl:when test="$type='PARAM'"><xsl:value-of select="/Data/WTENTITY/WTWEBPAGE/WTPARAM[@name=$text]/@datatype"/></xsl:when>-->
		  <xsl:when test="$type='CONST'"><xsl:value-of select="@datatype"/></xsl:when>
		  <xsl:when test="$type='FINDID'">number</xsl:when>
		  <xsl:when test="$type='LISTID'">number</xsl:when>
		  <xsl:when test="$type='SVR'">text</xsl:when>
		  <xsl:when test="$type='SYS'">
				<xsl:variable name="ltext">
					<xsl:call-template name="CaseLower">
						<xsl:with-param name="value" select="$text"/>
					</xsl:call-template>
				</xsl:variable>
				<xsl:choose>
				<xsl:when test="$ltext='header'">text</xsl:when>
				<xsl:when test="$ltext='footer'">text</xsl:when>
				<xsl:when test="$ltext='headerimage'">text</xsl:when>
				<xsl:when test="$ltext='footerimage'">text</xsl:when>
				<xsl:when test="$ltext='returnimage'">text</xsl:when>
				<xsl:when test="$ltext='navbarimage'">text</xsl:when>
				<xsl:when test="$ltext='headerurl'">text</xsl:when>
				<xsl:when test="$ltext='returnurl'">text</xsl:when>
				<xsl:when test="$ltext='language'">text</xsl:when>
				<xsl:when test="$ltext='langdialect'">text</xsl:when>
				<xsl:when test="$ltext='langcountry'">text</xsl:when>
				<xsl:when test="$ltext='langdefault'">text</xsl:when>
				<xsl:when test="$ltext='userid'">number</xsl:when>
				<xsl:when test="$ltext='usergroup'">number</xsl:when>
				<xsl:when test="$ltext='userstatus'">number</xsl:when>
				<xsl:when test="$ltext='username'">text</xsl:when>
				<xsl:when test="$ltext='employeeid'">number</xsl:when>
				<xsl:when test="$ltext='actioncode'">number</xsl:when>
				<xsl:when test="$ltext='customerid'">number</xsl:when>
				<xsl:when test="$ltext='affiliateid'">number</xsl:when>
				<xsl:when test="$ltext='affiliatetype'">number</xsl:when>
				<xsl:when test="$ltext='planid'">number</xsl:when>
				<xsl:when test="$ltext='cartid'">number</xsl:when>
				<xsl:when test="$ltext='storeid'">number</xsl:when>
				<xsl:when test="$ltext='brduserid'">number</xsl:when>
				<xsl:when test="$ltext='brdusergroup'">number</xsl:when>
				<xsl:when test="$ltext='pagecolor'">text</xsl:when>
				<xsl:when test="$ltext='linkcolor'">text</xsl:when>
				<xsl:when test="$ltext='pageimage'">text</xsl:when>
				<xsl:when test="$ltext='pageimagefixed'">text</xsl:when>
				<xsl:when test="$ltext='pageimagefolder'">text</xsl:when>
				<xsl:when test="$ltext='colorgraybaron'">text</xsl:when>
				<xsl:when test="$ltext='colorgraybaroff'">text</xsl:when>
				<xsl:when test="$ltext='colordivider'">text</xsl:when>
				<xsl:when test="$ltext='colortext'">text</xsl:when>
				<xsl:when test="$ltext='colorprompt'">text</xsl:when>
				<xsl:when test="$ltext='date'">date</xsl:when>
				<xsl:when test="$ltext='time'">time</xsl:when>
				<xsl:when test="$ltext='timeno'">number</xsl:when>
				<xsl:when test="$ltext='country'">text</xsl:when>
				<xsl:when test="$ltext='dialect'">text</xsl:when>
				<xsl:when test="$ltext='searchtype'">number</xsl:when>
				<xsl:when test="$ltext='listtype'">number</xsl:when>
				<xsl:when test="$ltext='owner'">text</xsl:when>
				<xsl:when test="$ltext='ownerid'">number</xsl:when>
				<xsl:when test="$ltext='ownertitle'">text</xsl:when>
				<xsl:when test="$ltext='error'">number</xsl:when>
				<xsl:when test="$ltext='errormsg'">text</xsl:when>
				<xsl:when test="$ltext='errorno'">number</xsl:when>
				<xsl:otherwise>
					<!-- check for an application defined variable -->
				  	<xsl:variable name="GetVal">
						<xsl:for-each select="/Data/WTPAGE/WTSYSVAR">
						  	<xsl:variable name="lvar">
						  		<xsl:call-template name="CaseLower">
						  			<xsl:with-param name="value" select="@name"/>
						  		</xsl:call-template>
						  	</xsl:variable>
							<xsl:if test="$ltext=$lvar">
								<xsl:value-of select="@type"/>
							</xsl:if>
						</xsl:for-each>
				  	</xsl:variable>
				  	
					<xsl:choose>
					<xsl:when test="string-length($GetVal)!=0"><xsl:value-of select="$GetVal"/></xsl:when>
					<xsl:otherwise>
						<xsl:call-template name="Error">
							<xsl:with-param name="msg" select="'Invalid SYS() Name'"/>
							<xsl:with-param name="text" select="$text"/>
						</xsl:call-template>
					</xsl:otherwise>
					</xsl:choose>

				</xsl:otherwise>
				</xsl:choose>
		   </xsl:when>
		  <xsl:when test="$type='CONFIG'">
				<xsl:choose>
				<xsl:when test="$text='isdocuments'">yesno</xsl:when>
				<xsl:when test="$text='documentpath'">text</xsl:when>
				<xsl:otherwise>
					 <xsl:call-template name="Error">
					 	<xsl:with-param name="msg" select="'Invalid CONFIG() Name'"/>
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
		  <xsl:otherwise>
				<xsl:value-of select="@datatype"/>
		  </xsl:otherwise>
		  </xsl:choose>
	 </xsl:template>

	 <!--==================================================================-->
	 <xsl:template name="GetDataConvert">
	 <!--==================================================================-->
		  <xsl:param name="type"/>
			<xsl:choose>
				<xsl:when test="$type='number'">CLng(</xsl:when>
        <xsl:when test="$type='big number'">CStr(</xsl:when>
        <xsl:when test="$type='small number'">CInt(</xsl:when>
				<xsl:when test="$type='tiny number'">CByte(</xsl:when>
				<xsl:when test="$type='decimal'">CDbl(</xsl:when>
				<xsl:when test="$type='date'">CDate(</xsl:when>
				<xsl:when test="$type='currency'">CCur(</xsl:when>
				<xsl:when test="$type='yesno'">CBool(</xsl:when>
<!--
				<xsl:when test="$type='text'">&quot;</xsl:when>
				<xsl:when test="$type='char'">&quot;</xsl:when>
-->
				<xsl:when test="$type='text'"></xsl:when>
				<xsl:when test="$type='char'"></xsl:when>
				<xsl:otherwise>
					 <xsl:if test="string-length($type)&gt;0">
						  <xsl:call-template name="Error">
						  	<xsl:with-param name="msg" select="'Invalid Data Type'"/>
						  	<xsl:with-param name="text" select="$type"/>
						  </xsl:call-template>
					 </xsl:if>
				</xsl:otherwise>
			</xsl:choose>
	 </xsl:template>

</xsl:stylesheet>
