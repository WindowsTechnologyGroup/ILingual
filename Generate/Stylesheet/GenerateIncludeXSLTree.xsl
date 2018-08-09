<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<!--==================================================================-->
	<xsl:template match="WTTREE">
	<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="ind2" select="concat($ind1, $tab1)"/>
		<xsl:variable name="ind3" select="concat($ind2, $tab1)"/>
		<xsl:variable name="ind4" select="concat($ind3, $tab1)"/>

	 <!-- ***************** Error Checking *******************-->
	 <xsl:if test="not(@duplicate) and not(@entity) and not(@datapath)">
	     <xsl:call-template name="Error">
	     	<xsl:with-param name="msg" select="'WTTREE entity or datapath Missing'"/>
	     	<xsl:with-param name="text" select="'WTTREE'"/>
	     </xsl:call-template>
	 </xsl:if>
	 <xsl:if test="not(@duplicate) and not(@nodeid)">
	     <xsl:call-template name="Error">
	     	<xsl:with-param name="msg" select="'WTTREE nodeid Missing'"/>
	     	<xsl:with-param name="text" select="'WTTREE'"/>
	     </xsl:call-template>
	 </xsl:if>
	 <xsl:if test="not(@duplicate) and not(@parentid)">
	     <xsl:call-template name="Error">
	     	<xsl:with-param name="msg" select="'WTTREE parentid Missing'"/>
	     	<xsl:with-param name="text" select="'WTTREE'"/>
	     </xsl:call-template>
	 </xsl:if>
	 <!--Test valid attributes-->
	 <xsl:for-each select="@*">
		<xsl:variable name="testcol">
			<xsl:call-template name="TestColAttr">
				<xsl:with-param name="attr" select="name()"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:if test="$testcol='0'">
			<xsl:choose>
				<xsl:when test="name()='id'"/>
				<xsl:when test="name()='entity'"/>
				<xsl:when test="name()='datapath'"/>
				<xsl:when test="name()='nodeid'"/>
				<xsl:when test="name()='parentid'"/>
				<xsl:when test="name()='firstparent'"/>
				<xsl:when test="name()='height'"/>
				<xsl:when test="name()='width'"/>
				<xsl:when test="name()='color-select'"/>
				<xsl:when test="name()='color-unselect'"/>
				<xsl:when test="name()='tree-node'"/>
				<xsl:when test="name()='tree-node-open'"/>
				<xsl:when test="name()='tree-nodex'"/>
				<xsl:when test="name()='tree-plus'"/>
				<xsl:when test="name()='tree-minus'"/>
				<xsl:when test="name()='nodewidth'"/>
				<xsl:when test="name()='nodeheight'"/>
				<xsl:when test="name()='treeheight'"/>
				<xsl:when test="name()='border'"/>
				<xsl:when test="name()='borderwidth'"/>
				<xsl:when test="name()='overflow'"/>
				<xsl:when test="name()='css'"/>
				<xsl:when test="name()='display'"/>
				<xsl:when test="name()='style'"/>
				<xsl:when test="name()='duplicate'"/>
				<xsl:when test="name()='nodash'"/>
				<xsl:otherwise>
					 <xsl:call-template name="Error">
						  <xsl:with-param name="msg" select="'WTTREE Invalid Attribute'"/>
						  <xsl:with-param name="text" select="name()"/>
	 				</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
	 </xsl:for-each>
	 <!-- ****************************************************-->

		<!--begin the column tag-->
		<xsl:apply-templates select="." mode="cell-begin">
			<xsl:with-param name="indent" select="$indent"/>
			<xsl:with-param name="wrap" select="false()"/>
			<xsl:with-param name="isfirst" select="position()=1"/>
		</xsl:apply-templates>

		<xsl:variable name="firstparent">
			<xsl:choose>
				<xsl:when test="@firstparent">
					<xsl:variable name="fptype"><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="@firstparent"/></xsl:call-template></xsl:variable>
					<xsl:variable name="fptext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@firstparent"/></xsl:call-template></xsl:variable>
					<xsl:variable name="fpentity"><xsl:call-template name="QualifiedPrefix"><xsl:with-param name="value" select="@firstparent"/></xsl:call-template></xsl:variable>
					<xsl:call-template name="GetValue">
						<xsl:with-param name="type" select="$fptype"/>
						<xsl:with-param name="text" select="$fptext"/>
						<xsl:with-param name="entity" select="$fpentity"/>
						<xsl:with-param name="hidden" select="true()"/>
					</xsl:call-template>
				</xsl:when>
				<xsl:otherwise>0</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		
		<xsl:variable name="id">
			<xsl:choose>
				<xsl:when test="@id"><xsl:value-of select="@id"/></xsl:when>
				<xsl:otherwise>TreeView</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="width">
			<xsl:choose>
				<xsl:when test="@width"><xsl:value-of select="@width"/></xsl:when>
				<xsl:otherwise>600</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="height">
			<xsl:choose>
				<xsl:when test="@height"><xsl:value-of select="@height"/></xsl:when>
				<xsl:otherwise>400</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="treeheight">
			<xsl:choose>
				<xsl:when test="@treeheight"><xsl:value-of select="@treeheight"/></xsl:when>
				<xsl:otherwise><xsl:value-of select="$height"/></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:value-of select="concat($ind2, '&lt;xsl:element name=&quot;SPAN&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;id&quot;&gt;', $id ,'&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;class&quot;&gt;TreeView&lt;/xsl:attribute&gt;', $cr)"/>

		<xsl:if test="@style">
			<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;style&quot;&gt;', @style)"/>
		</xsl:if>
		<xsl:if test="not(@style)">
			<xsl:value-of select="concat($ind3, '&lt;xsl:attribute name=&quot;style&quot;&gt;WIDTH: ', $width ,'; HEIGHT: ', $treeheight ,';')"/>
			<xsl:if test="@border">
				<xsl:value-of select="concat(' BORDER: ', @border ,';')"/>
			</xsl:if>
			<xsl:if test="@overflow">
				<xsl:value-of select="concat(' OVERFLOW: ', @overflow ,';')"/>
			</xsl:if>
		</xsl:if>
		<xsl:value-of select="concat('&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($ind3, '&lt;xsl:call-template name=&quot;TreeNode&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($ind4, '&lt;xsl:with-param name=&quot;parentid&quot; select=&quot;', $firstparent, '&quot;/&gt;', $cr)"/>
		<xsl:value-of select="concat($ind3, '&lt;/xsl:call-template&gt;', $cr)"/>
		<xsl:value-of select="concat($ind2, '&lt;/xsl:element&gt;', $cr)"/>
		
		<!--end the column tag-->
		<xsl:apply-templates select="." mode="cell-end">
			<xsl:with-param name="indent" select="$indent"/>
			<xsl:with-param name="wrap" select="false()"/>
			<xsl:with-param name="islast" select="position()=last()"/>
		</xsl:apply-templates>
	</xsl:template>

	<xsl:template match="WTNODECLICK"/>

	<!--==================================================================-->
	<xsl:template name="TreeNode">
	<!--==================================================================-->
<xsl:if test="not(@duplicate)">

		<xsl:variable name="ind1" select="$tab1"/>
		<xsl:variable name="ind2" select="concat($ind1, $tab1)"/>
		<xsl:variable name="ind3" select="concat($ind2, $tab1)"/>
		<xsl:variable name="ind4" select="concat($ind3, $tab1)"/>
		<xsl:variable name="ind5" select="concat($ind4, $tab1)"/>
		<xsl:variable name="ind6" select="concat($ind5, $tab1)"/>
		<xsl:variable name="ind7" select="concat($ind6, $tab1)"/>
		<xsl:variable name="ind8" select="concat($ind7, $tab1)"/>
		<xsl:variable name="ind9" select="concat($ind8, $tab1)"/>
		<xsl:variable name="ind10" select="concat($ind9, $tab1)"/>
		<xsl:variable name="ind11" select="concat($ind10, $tab1)"/>
		<xsl:variable name="ind12" select="concat($ind11, $tab1)"/>
		<xsl:variable name="ind13" select="concat($ind12, $tab1)"/>
		<xsl:variable name="ind14" select="concat($ind13, $tab1)"/>

		<xsl:variable name="nodeid">
			<xsl:call-template name="CaseLower">
				<xsl:with-param name="value" select="@nodeid"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="parentid">
			<xsl:call-template name="CaseLower">
				<xsl:with-param name="value" select="@parentid"/>
			</xsl:call-template>
		</xsl:variable>

		<xsl:variable name="fp">
			<xsl:choose>
				<xsl:when test="@firstparent">
					<xsl:variable name="fptype"><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="@firstparent"/></xsl:call-template></xsl:variable>
					<xsl:variable name="fptext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@firstparent"/></xsl:call-template></xsl:variable>
					<xsl:variable name="fpentity"><xsl:call-template name="QualifiedPrefix"><xsl:with-param name="value" select="@firstparent"/></xsl:call-template></xsl:variable>
					<xsl:call-template name="GetValue">
						<xsl:with-param name="type" select="$fptype"/>
						<xsl:with-param name="text" select="$fptext"/>
						<xsl:with-param name="entity" select="$fpentity"/>
						<xsl:with-param name="hidden" select="true()"/>
					</xsl:call-template>
				</xsl:when>
				<xsl:otherwise>0</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		
		<xsl:variable name="tree-nodex">
			<xsl:choose>
				<xsl:when test="@tree-nodex">
					<xsl:variable name="nxtype"><xsl:call-template name="QualifiedType"><xsl:with-param name="value" select="@tree-nodex"/></xsl:call-template></xsl:variable>
					<xsl:variable name="nxtext"><xsl:call-template name="QualifiedValue"><xsl:with-param name="value" select="@tree-nodex"/></xsl:call-template></xsl:variable>
					<xsl:variable name="nxentity"><xsl:call-template name="QualifiedPrefix"><xsl:with-param name="value" select="@tree-nodex"/></xsl:call-template></xsl:variable>
					<xsl:call-template name="GetValue">
						<xsl:with-param name="type" select="$nxtype"/>
						<xsl:with-param name="text" select="$nxtext"/>
						<xsl:with-param name="entity" select="$nxentity"/>
						<xsl:with-param name="hidden" select="true()"/>
					</xsl:call-template>
				</xsl:when>
				<xsl:otherwise></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="color-select">
			<xsl:if test="@color-select">
	 			<xsl:call-template name="GetColor"><xsl:with-param name="color" select="@color-select"/></xsl:call-template>
			</xsl:if>
		</xsl:variable>

		<xsl:variable name="color-unselect">
			<xsl:if test="@color-unselect">
		 		<xsl:call-template name="GetColor"><xsl:with-param name="color" select="@color-unselect"/></xsl:call-template>
			</xsl:if>
		</xsl:variable>

		<xsl:variable name="tree-node">
			<xsl:choose>
				<xsl:when test="@tree-node"><xsl:value-of select="@tree-node"/></xsl:when>
				<xsl:otherwise>tree-node.gif</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="tree-node-open">
			<xsl:choose>
				<xsl:when test="@tree-node-open"><xsl:value-of select="@tree-node-open"/></xsl:when>
				<xsl:otherwise>tree-node.gif</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="tree-plus">
			<xsl:choose>
				<xsl:when test="@tree-plus='false'"></xsl:when>
				<xsl:when test="@tree-plus"><xsl:value-of select="@tree-plus"/></xsl:when>
				<xsl:otherwise>tree-plus.gif</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="tree-minus">
			<xsl:choose>
				<xsl:when test="@tree-minus='false'"></xsl:when>
				<xsl:when test="@tree-minus"><xsl:value-of select="@tree-minus"/></xsl:when>
				<xsl:otherwise>tree-minus.gif</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="datapath">
			<xsl:choose>
				<xsl:when test="@datapath"><xsl:value-of select="@datapath"/></xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="XSLDataPath">
						<xsl:with-param name="entity" select="@entity"/>
						<xsl:with-param name="iscollection" select="true()"/>
					</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="width">
			<xsl:choose>
				<xsl:when test="@width"><xsl:value-of select="@width"/></xsl:when>
				<xsl:otherwise>600</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="nodewidth">
			<xsl:choose>
				<xsl:when test="@nodewidth"><xsl:value-of select="@nodewidth"/></xsl:when>
				<xsl:otherwise>20</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		
		<xsl:variable name="nodeheight">
			<xsl:choose>
				<xsl:when test="@nodeheight"><xsl:value-of select="@nodeheight"/></xsl:when>
				<xsl:otherwise>18</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="tablewidth">
			<xsl:choose>
				<xsl:when test="@borderwidth"><xsl:value-of select="($width - 50) - @borderwidth"/></xsl:when>
				<xsl:when test="$width&gt;50"><xsl:value-of select="$width - 50"/></xsl:when>
				<xsl:otherwise>50</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:value-of select="concat($ind1, '&lt;xsl:variable name=&quot;firstparent&quot; select=&quot;', $fp, '&quot;/&gt;', $cr, $cr)"/>

		<xsl:value-of select="concat($ind1, '&lt;xsl:template name=&quot;TreeNode&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($ind2, '&lt;xsl:param name=&quot;parentid&quot;/&gt;', $cr, $cr)"/>

		<xsl:value-of select="concat($ind2, '&lt;xsl:for-each select=&quot;', $datapath ,'[@', $parentid, '=$parentid]&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($ind3, '&lt;xsl:variable name=&quot;nodeid&quot; select=&quot;@', $nodeid, '&quot;/&gt;', $cr)"/>
		<xsl:value-of select="concat($ind3, '&lt;xsl:variable name=&quot;children&quot; select=&quot;count(', $datapath ,'[@', $parentid, '=$nodeid])&quot;/&gt;', $cr, $cr)"/>

		<xsl:value-of select="concat($ind3, '&lt;xsl:element name=&quot;SPAN&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;class&quot;&gt;Trigger&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;id&quot;&gt;H&lt;xsl:value-of select=&quot;$nodeid&quot;/&gt;&lt;/xsl:attribute&gt;', $cr)"/>

		<xsl:if test="string-length($color-select)&gt;0">
			<xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;onMouseOver&quot;&gt;highliteBranch(', $apos, '&lt;xsl:value-of select=&quot;$nodeid&quot;/&gt;', $apos, ', true);&lt;/xsl:attribute&gt;', $cr)"/>
			<xsl:value-of select="concat($ind4, '&lt;xsl:attribute name=&quot;onMouseOut&quot;&gt;highliteBranch(', $apos, '&lt;xsl:value-of select=&quot;$nodeid&quot;/&gt;', $apos, ', false);&lt;/xsl:attribute&gt;', $cr)"/>
		</xsl:if>

		<xsl:value-of select="concat($ind4, '&lt;xsl:element name=&quot;TABLE&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($ind5, '&lt;xsl:attribute name=&quot;width&quot;&gt;', $tablewidth, '&lt;/xsl:attribute&gt;', $cr)"/>
   
      <xsl:value-of select="concat($ind5, '&lt;xsl:element name=&quot;TR&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($ind6, '&lt;xsl:element name=&quot;TD&quot;&gt;', $cr)"/>
      <xsl:value-of select="concat($ind7, '&lt;xsl:attribute name=&quot;width&quot;&gt;', ($nodewidth + 15),'&lt;/xsl:attribute&gt;', $cr)"/>
      <xsl:value-of select="concat($ind7, '&lt;xsl:attribute name=&quot;height&quot;&gt;100%&lt;/xsl:attribute&gt;', $cr)"/> 
        
      <xsl:value-of select="concat($ind7, '&lt;xsl:element name=&quot;TABLE&quot;&gt;', $cr)"/>
      <xsl:value-of select="concat($ind8, '&lt;xsl:attribute name=&quot;height&quot;&gt;100%&lt;/xsl:attribute&gt;', $cr)"/> 

		<xsl:value-of select="concat($ind8, '&lt;xsl:element name=&quot;TR&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($ind9, '&lt;xsl:attribute name=&quot;align&quot;&gt;center&lt;/xsl:attribute&gt;', $cr)"/> 
		<xsl:value-of select="concat($ind9, '&lt;xsl:attribute name=&quot;height&quot;&gt;',$nodeheight,'&lt;/xsl:attribute&gt;', $cr)"/> 	
		
      <xsl:value-of select="concat($ind9, '&lt;xsl:element name=&quot;TD&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($ind10, '&lt;xsl:attribute name=&quot;width&quot;&gt;2&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($ind10, '&lt;xsl:attribute name=&quot;valign&quot;&gt;top&lt;/xsl:attribute&gt;', $cr)"/>   	
		<xsl:value-of select="concat($ind10, '&lt;xsl:if test=&quot;$parentid!=$firstparent&quot;&gt;', $cr)"/>
  		<xsl:value-of select="concat($ind11, '&lt;xsl:choose&gt;', $cr)"/>
		<xsl:value-of select="concat($ind11, '&lt;xsl:when test=&quot;position()=last()&quot;&gt;', $cr)"/>
      <xsl:value-of select="concat($ind12, '&lt;xsl:element name=&quot;DIV&quot;&gt;', $cr)"/>  				  
  		<xsl:value-of select="concat($ind13, '&lt;xsl:attribute name=&quot;height&quot;&gt;',($nodeheight div 2),'&lt;/xsl:attribute&gt;', $cr)"/>		  
  		
  		<xsl:if test="not(@nodash)">
  			<xsl:value-of select="concat($ind13, '&lt;xsl:attribute name=&quot;class&quot;&gt;TreeBar&lt;/xsl:attribute&gt;', $cr)"/>		  
		</xsl:if>
      
      <xsl:value-of select="concat($ind13, '&lt;xsl:element name=&quot;IMG&quot;&gt;', $cr)"/>  				  
  		<xsl:value-of select="concat($ind14, '&lt;xsl:attribute name=&quot;height&quot;&gt;',($nodeheight div 2),'&lt;/xsl:attribute&gt;', $cr)"/>		  
  		<xsl:value-of select="concat($ind14, '&lt;xsl:attribute name=&quot;width&quot;&gt;2&lt;/xsl:attribute&gt;', $cr)"/>		  
  		<xsl:value-of select="concat($ind14, '&lt;xsl:attribute name=&quot;src&quot;&gt;Images/spacer.gif&lt;/xsl:attribute&gt;', $cr)"/>		  

      <xsl:value-of select="concat($ind13, '&lt;/xsl:element&gt;', $cr)"/>
      <xsl:value-of select="concat($ind12, '&lt;/xsl:element&gt;', $cr)"/>
		<xsl:value-of select="concat($ind11, '&lt;/xsl:when&gt;', $cr)"/>
		<xsl:value-of select="concat($ind11, '&lt;xsl:otherwise&gt;', $cr)"/>
		<xsl:if test="not(@nodash)">
  			<xsl:value-of select="concat($ind11, '&lt;xsl:attribute name=&quot;class&quot;&gt;TreeBar&lt;/xsl:attribute&gt;', $cr)"/>	  
		</xsl:if>
		<xsl:value-of select="concat($ind11, '&lt;/xsl:otherwise&gt;', $cr)"/>
		<xsl:value-of select="concat($ind11, '&lt;/xsl:choose&gt;', $cr)"/>	
      <xsl:value-of select="concat($ind10, '&lt;/xsl:if&gt;', $cr)"/>	  				
      <xsl:value-of select="concat($ind9, '&lt;/xsl:element&gt;', $cr, $cr)"/>	
		
      <xsl:value-of select="concat($ind9, '&lt;xsl:element name=&quot;TD&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($ind10, '&lt;xsl:attribute name=&quot;width&quot;&gt;13&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($ind10, '&lt;xsl:attribute name=&quot;valign&quot;&gt;center&lt;/xsl:attribute&gt;', $cr)"/>   	
	   <xsl:value-of select="concat($ind10, '&lt;xsl:if test=&quot;$parentid!=$firstparent&quot;&gt;', $cr)"/>
	   <xsl:if test="not(@nodash)">
  			<xsl:value-of select="concat($ind11, '&lt;xsl:attribute name=&quot;class&quot;&gt;TreeBarH&lt;/xsl:attribute&gt;', $cr)"/>
		</xsl:if>
	   
	   <xsl:value-of select="concat($ind10, '&lt;/xsl:if&gt;', $cr)"/>	
	
	   <xsl:if test="string-length($tree-plus)&gt;0">
		  <xsl:value-of select="concat($ind10, '&lt;xsl:if test=&quot;($children &gt; 0)&quot;&gt;', $cr)"/>
		  <xsl:value-of select="concat($ind11, '&lt;xsl:element name=&quot;IMG&quot;&gt;', $cr)"/>
		  <xsl:value-of select="concat($ind12, '&lt;xsl:attribute name=&quot;id&quot;&gt;I&lt;xsl:value-of select=&quot;$nodeid&quot;/&gt;&lt;/xsl:attribute&gt;', $cr)"/>

		  <xsl:if test="not(@display)">
			  <xsl:value-of select="concat($ind12, '&lt;xsl:attribute name=&quot;src&quot;&gt;Images/', $tree-plus, '&lt;/xsl:attribute&gt;', $cr)"/>
		  </xsl:if>
		  <xsl:if test="@display">
			  <xsl:value-of select="concat($ind12, '&lt;xsl:attribute name=&quot;src&quot;&gt;Images/', $tree-minus, '&lt;/xsl:attribute&gt;', $cr)"/>
		  </xsl:if>

		  <xsl:value-of select="concat($ind12, '&lt;xsl:attribute name=&quot;onClick&quot;&gt;showBranch(', $apos, '&lt;xsl:value-of select=&quot;$nodeid&quot;/&gt;', $apos, ',&lt;xsl:value-of select=&quot;$children&quot;/&gt;);&lt;/xsl:attribute&gt;', $cr)"/>
		  <xsl:value-of select="concat($ind11, '&lt;/xsl:element&gt;', $cr)"/>
		  <xsl:value-of select="concat($ind10, '&lt;/xsl:if&gt;', $cr)"/>
		</xsl:if>	  				
      <xsl:value-of select="concat($ind9, '&lt;/xsl:element&gt;', $cr, $cr)"/>
	
		<xsl:value-of select="concat($ind9, '&lt;xsl:element name=&quot;TD&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($ind10, '&lt;xsl:attribute name=&quot;width&quot;&gt;',$nodewidth,'&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($ind10, '&lt;xsl:attribute name=&quot;valign&quot;&gt;center&lt;/xsl:attribute&gt;', $cr)"/>   	
	
		<xsl:value-of select="concat($ind10, '&lt;xsl:element name=&quot;IMG&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($ind12, '&lt;xsl:attribute name=&quot;id&quot;&gt;N&lt;xsl:value-of select=&quot;$nodeid&quot;/&gt;&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($ind11, '&lt;xsl:attribute name=&quot;src&quot;&gt;Images/', $tree-nodex, $tree-node, '&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($ind11, '&lt;xsl:attribute name=&quot;onClick&quot;&gt;showBranch(', $apos, '&lt;xsl:value-of select=&quot;$nodeid&quot;/&gt;', $apos, ',&lt;xsl:value-of select=&quot;$children&quot;/&gt;)', ';openNode(&lt;xsl:value-of select=&quot;$nodeid&quot;/&gt;);', WTNODECLICK, '&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($ind10, '&lt;/xsl:element&gt;', $cr)"/>
	  				
      <xsl:value-of select="concat($ind9, '&lt;/xsl:element&gt;', $cr, $cr)"/>

      <xsl:value-of select="concat($ind8, '&lt;/xsl:element&gt;', $cr, $cr)"/>
        
		<xsl:value-of select="concat($ind8, '&lt;xsl:element name=&quot;TR&quot;&gt;', $cr)"/>
      <xsl:value-of select="concat($ind9, '&lt;xsl:element name=&quot;TD&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($ind10, '&lt;xsl:attribute name=&quot;colspan&quot;&gt;2&lt;/xsl:attribute&gt;', $cr)"/>  				
		<xsl:if test="not(@nodash)">
			<xsl:value-of select="concat($ind10, '&lt;xsl:if test=&quot;($parentid!=$firstparent) and (position()!=last())&quot;&gt;&lt;xsl:attribute name=&quot;class&quot;&gt;TreeBar&lt;/xsl:attribute&gt;&lt;/xsl:if&gt;', $cr)"/>
		</xsl:if>
		<xsl:value-of select="concat($ind9, '&lt;/xsl:element&gt;', $cr, $cr)"/>
		
		<xsl:value-of select="concat($ind9, '&lt;xsl:element name=&quot;TD&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($ind10, '&lt;xsl:attribute name=&quot;id&quot;&gt;S&lt;xsl:value-of select=&quot;$nodeid&quot;/&gt;&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($ind9, '&lt;/xsl:element&gt;', $cr, $cr)"/>
		<xsl:value-of select="concat($ind8, '&lt;/xsl:element&gt;', $cr, $cr)"/>   
<!--end table-->
        <xsl:value-of select="concat($ind7, '&lt;/xsl:element&gt;', $cr, $cr)"/>
<!--end cell-->        
        <xsl:value-of select="concat($ind6, '&lt;/xsl:element&gt;', $cr, $cr)"/>
	
		<xsl:value-of select="concat($ind6, '&lt;xsl:element name=&quot;TD&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($ind7, '&lt;xsl:attribute name=&quot;style&quot;&gt;PADDING: 2px;&lt;/xsl:attribute&gt;', $cr)"/> 
		
		<!-- apply node content templates -->
		<xsl:apply-templates>
			<xsl:with-param name="indent" select="7"/>
		</xsl:apply-templates>
		
		<xsl:value-of select="concat($ind6, '&lt;/xsl:element&gt;', $cr, $cr)"/>
<!--end row-->
		<xsl:value-of select="concat($ind5, '&lt;/xsl:element&gt;', $cr, $cr)"/>
<!--end table-->
		<xsl:value-of select="concat($ind4, '&lt;/xsl:element&gt;', $cr, $cr)"/>
<!--end span-->		
		<xsl:value-of select="concat($ind3, '&lt;/xsl:element&gt;', $cr, $cr)"/>
		
		<xsl:value-of select="concat($ind3, '&lt;xsl:element name=&quot;DIV&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($ind4, '&lt;xsl:if test=&quot;($parentid!=$firstparent) and (position()!=last())&quot;&gt;', $cr)"/>
		<xsl:if test="not(@nodash)">
  			<xsl:value-of select="concat($ind5, '&lt;xsl:attribute name=&quot;class&quot;&gt;TreeBar&lt;/xsl:attribute&gt;', $cr)"/>
		</xsl:if>
		
		<xsl:value-of select="concat($ind4, '&lt;/xsl:if&gt;', $cr, $cr)"/>
		
		<xsl:value-of select="concat($ind4, '&lt;xsl:element name=&quot;SPAN&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($ind5, '&lt;xsl:attribute name=&quot;class&quot;&gt;Branch&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($ind5, '&lt;xsl:attribute name=&quot;id&quot;&gt;&lt;xsl:value-of select=&quot;$nodeid&quot;/&gt;&lt;/xsl:attribute&gt;', $cr, $cr)"/>
		
		<xsl:value-of select="concat($ind5, '&lt;xsl:call-template name=&quot;TreeNode&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($ind6, '&lt;xsl:with-param name=&quot;parentid&quot; select=&quot;$nodeid&quot;/&gt;', $cr)"/>
		<xsl:value-of select="concat($ind5, '&lt;/xsl:call-template&gt;', $cr, $cr)"/>
		
		<xsl:value-of select="concat($ind4, '&lt;/xsl:element&gt;', $cr)"/>
		<xsl:value-of select="concat($ind3, '&lt;/xsl:element&gt;', $cr)"/>
		<xsl:value-of select="concat($ind2, '&lt;/xsl:for-each&gt;', $cr)"/>
		<xsl:value-of select="concat($ind1, '&lt;/xsl:template&gt;', $cr, $cr)"/>

</xsl:if>

	</xsl:template>
	
	<!--==================================================================-->
	<xsl:template name="TreeJavaScript">
	<!--==================================================================-->
		<xsl:param name="indent"/>

<xsl:if test="not(@duplicate)">

		<xsl:variable name="ind1"><xsl:call-template name="Indent"><xsl:with-param name="level" select="$indent"/></xsl:call-template></xsl:variable>
		<xsl:variable name="ind2" select="concat($ind1, $tab1)"/>
		<xsl:variable name="ind3" select="concat($ind2, $tab1)"/>
		<xsl:variable name="ind4" select="concat($ind3, $tab1)"/>

		<xsl:variable name="color-select">
			<xsl:if test="@color-select">
	 			<xsl:call-template name="GetColor"><xsl:with-param name="color" select="@color-select"/></xsl:call-template>
			</xsl:if>
		</xsl:variable>

		<xsl:variable name="color-unselect">
			<xsl:if test="@color-unselect">
		 		<xsl:call-template name="GetColor"><xsl:with-param name="color" select="@color-unselect"/></xsl:call-template>
			</xsl:if>
		</xsl:variable>

		<xsl:variable name="tree-plus">
			<xsl:choose>
				<xsl:when test="@tree-plus='false'"></xsl:when>
				<xsl:when test="@tree-plus"><xsl:value-of select="@tree-plus"/></xsl:when>
				<xsl:otherwise>tree-plus.gif</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		
		<xsl:variable name="tree-node-open">
			<xsl:choose>
				<xsl:when test="@tree-node-open"><xsl:value-of select="@tree-node-open"/></xsl:when>
				<xsl:otherwise>tree-node.gif</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		
		<xsl:variable name="tree-node">
			<xsl:choose>
				<xsl:when test="@tree-node"><xsl:value-of select="@tree-node"/></xsl:when>
				<xsl:otherwise>tree-node.gif</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		
		<xsl:variable name="nodewidth">
			<xsl:choose>
				<xsl:when test="@nodewidth"><xsl:value-of select="@nodewidth"/></xsl:when>
				<xsl:otherwise>20</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		
		<xsl:variable name="tree-minus">
			<xsl:choose>
				<xsl:when test="@tree-minus='false'"></xsl:when>
				<xsl:when test="@tree-minus"><xsl:value-of select="@tree-minus"/></xsl:when>
				<xsl:otherwise>tree-minus.gif</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:value-of select="concat($ind1, '&lt;xsl:element name=&quot;SCRIPT&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($ind2, '&lt;xsl:attribute name=&quot;language&quot;&gt;JavaScript&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($ind2, '&lt;xsl:text disable-output-escaping=&quot;yes&quot;&gt;&lt;![CDATA[', $cr)"/>

		<xsl:if test="string-length($tree-plus)&gt;0">
			<xsl:value-of select="concat($ind2, 'var openImg = new Image();', $cr)"/>
			<xsl:value-of select="concat($ind2, 'openImg.src = &quot;Images/', $tree-plus, '&quot;;', $cr)"/>
			<xsl:value-of select="concat($ind2, 'var closeImg = new Image();', $cr)"/>
			<xsl:value-of select="concat($ind2, 'closeImg.src = &quot;Images/', $tree-minus, '&quot;;', $cr, $cr)"/>
			<xsl:value-of select="concat($ind2, 'var nodeImg = new Image();', $cr)"/>
			<xsl:value-of select="concat($ind2, 'nodeImg.src = &quot;Images/', $tree-node, '&quot;;', $cr, $cr)"/>
			<xsl:value-of select="concat($ind2, 'var nodeOpenImg = new Image();', $cr)"/>
			<xsl:value-of select="concat($ind2, 'nodeOpenImg.src = &quot;Images/', $tree-node-open, '&quot;;', $cr, $cr)"/>
			<xsl:value-of select="concat($ind2, 'var nodeOpen = 0;', $cr)"/>
		</xsl:if>
		
		<xsl:value-of select="concat($ind2, 'function showBranch(branch, children){', $cr)"/>
		<xsl:value-of select="concat($ind3, 'var objBranch = document.getElementById(branch).style;', $cr)"/>
		<xsl:value-of select="concat($ind3, 'if(children &gt; 0){', $cr)"/>

		<xsl:if test="not(@display)">
			<xsl:value-of select="concat($ind4, 'if(objBranch.display==&quot;block&quot;){objBranch.display=&quot;none&quot;;} else{objBranch.display=&quot;block&quot;;}', $cr)"/>
		</xsl:if>
		<xsl:if test="@display">
			<xsl:value-of select="concat($ind4, 'if(objBranch.display==&quot;block&quot; || objBranch.display==&quot;&quot;){objBranch.display=&quot;none&quot;;} else{objBranch.display=&quot;block&quot;;}', $cr)"/>
		</xsl:if>

		<xsl:value-of select="concat($ind4, 'swapFolder(branch);', $cr)"/>
		<xsl:value-of select="concat($ind3, '}', $cr)"/>
		<xsl:value-of select="concat($ind2, '}', $cr, $cr)"/>
		
		<xsl:value-of select="concat($ind2, 'function openNode(branch){', $cr)"/>
		<xsl:value-of select="concat($ind3, 'objImg = document.getElementById(', $apos, 'N', $apos, ' + String(branch) );', $cr)"/>
		<xsl:value-of select="concat($ind3, 'objOldImg = document.getElementById(', $apos, 'N', $apos, ' + String(nodeOpen) );', $cr)"/>
		<xsl:value-of select="concat($ind3, 'if(nodeOpen != 0){objOldImg.src = nodeImg.src;};', $cr)"/>
		<xsl:value-of select="concat($ind3, 'objImg.src = nodeOpenImg.src;', $cr)"/>
		<xsl:value-of select="concat($ind3, 'nodeOpen = branch;', $cr)"/>
		<xsl:value-of select="concat($ind2, '}', $cr, $cr)"/>
		
		<xsl:value-of select="concat($ind2, 'function swapFolder(branch){', $cr)"/>
		<xsl:value-of select="concat($ind3, 'objImg = document.getElementById(', $apos, 'I', $apos, ' + String(branch) );', $cr)"/>
		<xsl:value-of select="concat($ind3, 'objClass = document.getElementById(', $apos, 'S', $apos, ' + String(branch) );', $cr)"/>
		<xsl:value-of select="concat($ind3, 'if(objImg.src.indexOf(', $apos, 'Images/', $tree-minus, $apos, ')&gt;-1) {', $cr)"/>

		<xsl:if test="string-length($tree-plus)&gt;0">
			<xsl:value-of select="concat($ind4, 'objImg.src = openImg.src;', $cr)"/>
		</xsl:if>

		<xsl:value-of select="concat($ind4, 'objClass.className = ', $apos, $apos, ';', $cr)"/>
		<xsl:value-of select="concat($ind3, '} else {', $cr)"/>

		<xsl:if test="string-length($tree-plus)&gt;0">
			<xsl:value-of select="concat($ind4, 'objImg.src = closeImg.src;', $cr)"/>
		</xsl:if>
		<xsl:if test="not(@nodash)">
  			<xsl:value-of select="concat($ind4, 'objClass.className = ', $apos, 'SubTreeBar', $apos, ';', $cr)"/>
		</xsl:if>
		
		<xsl:value-of select="concat($ind3, '}', $cr)"/>
		<xsl:value-of select="concat($ind2, '}', $cr, $cr)"/>
		
		<xsl:if test="string-length($color-select)&gt;0">
			<xsl:value-of select="concat($ind2, 'function highliteBranch(branch, show){', $cr)"/>
			<xsl:value-of select="concat($ind3, 'var objBranch = document.getElementById(', $apos, 'H', $apos, ' + String(branch) ).style;', $cr)"/>
			<xsl:value-of select="concat($ind3, 'if(show==true)', $cr)"/>
			<xsl:value-of select="concat($ind4, 'objBranch.background=&quot;', $color-select, '&quot;; &lt;!-- highlite color --&gt;', $cr)"/>
			<xsl:if test="string-length($color-unselect)&gt;0">
				<xsl:value-of select="concat($ind3, 'else', $cr)"/>
				<xsl:value-of select="concat($ind4, 'objBranch.background=&quot;', $color-unselect, '&quot;;', $cr)"/>
			</xsl:if>
			<xsl:value-of select="concat($ind2, '}')"/>
		</xsl:if>
		<xsl:value-of select="concat($ind2, ']]&gt;&lt;/xsl:text&gt;', $cr, $cr)"/>
		
		<xsl:value-of select="concat($ind1, '&lt;/xsl:element&gt;', $cr, $cr)"/>
		
<!-- css embedded styles -->
		
		<xsl:value-of select="concat($ind1, '&lt;xsl:element name=&quot;STYLE&quot;&gt;', $cr)"/>

<!--
<xsl:attribute name="type">text/css</xsl:attribute>
<xsl:attribute name="media">screen</xsl:attribute>
            <xsl:text disable-output-escaping="yes"><![CDATA[
TABLE {
   BORDER: 0px;
   BORDER-SPACING: 0px;
   BORDER-COLLAPSE: collapse;
}
TD {
   PADDING: 0px;
}
.Branch{     
   margin-left: 35px;
   DISPLAY: none;
}
]]></xsl:text>
-->
		<xsl:value-of select="concat($ind2, '&lt;xsl:attribute name=&quot;type&quot;&gt;text/css&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($ind2, '&lt;xsl:attribute name=&quot;media&quot;&gt;screen&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($ind2, '&lt;xsl:text disable-output-escaping=&quot;yes&quot;&gt;&lt;![CDATA[', $cr)"/>


		<xsl:value-of select="concat($ind2, 'TABLE {BORDER: 0px; BORDER-SPACING: 0px; BORDER-COLLAPSE: collapse;}', $cr)"/>
		<xsl:value-of select="concat($ind2, 'TD {PADDING: 0px;}', $cr)"/>

		<xsl:if test="not(@display)">
			<xsl:value-of select="concat($ind2, '.Branch{MARGIN-LEFT: ',(ceiling( $nodewidth div 2 ) + 14),'px; DISPLAY: none;}', $cr)"/>
		</xsl:if>
		<xsl:if test="@display">
			<xsl:value-of select="concat($ind2, '.Branch{MARGIN-LEFT: ',(ceiling( $nodewidth div 2 ) + 14),'px; DISPLAY: block;}', $cr)"/>
		</xsl:if>

		<xsl:value-of select="concat($ind2, ']]&gt;&lt;/xsl:text&gt;', $cr, $cr)"/>
		
		<xsl:value-of select="concat($ind1, '&lt;/xsl:element&gt;', $cr, $cr)"/>
		
</xsl:if>

	</xsl:template>

	<!--==================================================================-->
	<xsl:template match="WTTREE2">
		<!--==================================================================-->
		<xsl:param name="indent"/>
		<xsl:variable name="ind1">
			<xsl:call-template name="Indent">
				<xsl:with-param name="level" select="$indent"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="ind2" select="concat($ind1, $tab1)"/>

		<!-- ***************** Error Checking *******************-->
		<xsl:if test="not(@entity) and not(@datapath)">
			<xsl:call-template name="Error">
				<xsl:with-param name="msg" select="'WTTREE2 entity or datapath Missing'"/>
				<xsl:with-param name="text" select="'WTTREE2'"/>
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="not(@nodeid)">
			<xsl:call-template name="Error">
				<xsl:with-param name="msg" select="'WTTREE2 nodeid Missing'"/>
				<xsl:with-param name="text" select="'WTTREE2'"/>
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="not(@parentid)">
			<xsl:call-template name="Error">
				<xsl:with-param name="msg" select="'WTTREE2 parentid Missing'"/>
				<xsl:with-param name="text" select="'WTTREE2'"/>
			</xsl:call-template>
		</xsl:if>
		<!--Test valid attributes-->
		<xsl:for-each select="@*">
			<xsl:variable name="testcol">
				<xsl:call-template name="TestColAttr">
					<xsl:with-param name="attr" select="name()"/>
				</xsl:call-template>
			</xsl:variable>
			<xsl:if test="$testcol='0'">
				<xsl:choose>
					<xsl:when test="name()='id'"/>
					<xsl:when test="name()='entity'"/>
					<xsl:when test="name()='datapath'"/>
					<xsl:when test="name()='nodeid'"/>
					<xsl:when test="name()='parentid'"/>
					<xsl:when test="name()='color'"/>
					<xsl:when test="name()='imgline'"/>
					<xsl:when test="name()='imgdir'"/>
					<xsl:when test="name()='imgdiropen'"/>
					<xsl:when test="name()='imgdir_l'"/>
					<xsl:when test="name()='imgdiropen_l'"/>
					<xsl:when test="name()='itemoffset_x'"/>
					<xsl:when test="name()='itemoffset_y'"/>
					<xsl:when test="name()='fixwidth'"/>
					<xsl:when test="name()='fixheight'"/>
					<xsl:when test="name()='css'"/>
					<xsl:when test="name()='lined'"/>
					<xsl:when test="name()='imgitem'"/>
					<xsl:when test="name()='imgitem_l'"/>
					<xsl:when test="name()='styleover_css'"/>
					<xsl:when test="name()='styleover_color'"/>
					<xsl:when test="name()='styleover_bgcolor'"/>
					<xsl:when test="name()='target'"/>
					<xsl:when test="name()='position_abs'"/>
					<xsl:when test="name()='position_x'"/>
					<xsl:when test="name()='position_y'"/>
					<xsl:when test="name()='size_x'"/>
					<xsl:when test="name()='size_y'"/>
					<xsl:when test="name()='bgimg'"/>
					<xsl:when test="name()='imgdir_l2'"/>
					<xsl:when test="name()='imgdiropen_l2'"/>
					<xsl:otherwise>
						<xsl:call-template name="Error">
							<xsl:with-param name="msg" select="'WTTREE2 Invalid Attribute'"/>
							<xsl:with-param name="text" select="name()"/>
						</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:if>
		</xsl:for-each>

		<!--begin the column tag-->
		<xsl:apply-templates select="." mode="cell-begin">
			<xsl:with-param name="indent" select="$indent"/>
			<xsl:with-param name="wrap" select="false()"/>
			<xsl:with-param name="isfirst" select="position()=1"/>
		</xsl:apply-templates>

		<xsl:value-of select="concat($ind1, '&lt;xsl:element name=&quot;SCRIPT&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($ind2, '&lt;xsl:attribute name=&quot;language&quot;&gt;JavaScript&lt;/xsl:attribute&gt;', $cr)"/>
		<xsl:value-of select="concat($ind2, '&lt;xsl:text disable-output-escaping=&quot;yes&quot;&gt;&lt;![CDATA[', $cr)"/>
		<xsl:value-of select="concat($ind2, 'var t1 = new CTree(TreeDef', @entity, ', &quot;', @entity, 'Tree&quot;);', $cr)"/>
		<xsl:value-of select="concat($ind2, 't1.create();', $cr)"/>
		<xsl:value-of select="concat($ind2, 't1.draw();', $cr)"/>
		<xsl:value-of select="concat($ind2, ']]&gt;&lt;/xsl:text&gt;', $cr)"/>
		<xsl:value-of select="concat($ind1, '&lt;/xsl:element&gt;', $cr)"/>

		<!--end the column tag-->
		<xsl:apply-templates select="." mode="cell-end">
			<xsl:with-param name="indent" select="$indent"/>
			<xsl:with-param name="wrap" select="false()"/>
			<xsl:with-param name="islast" select="position()=last()"/>
		</xsl:apply-templates>

	</xsl:template>

	<!--==================================================================-->
	<xsl:template name="DefineTree2">
	<!--==================================================================-->
		<xsl:variable name="ind1" select="$tab1"/>
		<xsl:variable name="ind2" select="concat($ind1, $tab1)"/>
		<xsl:variable name="ind3" select="concat($ind2, $tab1)"/>
		<xsl:variable name="ind4" select="concat($ind3, $tab1)"/>
		<xsl:variable name="ind5" select="concat($ind4, $tab1)"/>

		<xsl:variable name="nodeid">
			<xsl:call-template name="CaseLower">
				<xsl:with-param name="value" select="@nodeid"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="parentid">
			<xsl:call-template name="CaseLower">
				<xsl:with-param name="value" select="@parentid"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="datapath">
			<xsl:choose>
				<xsl:when test="@datapath">
					<xsl:value-of select="@datapath"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="XSLDataPath">
						<xsl:with-param name="entity" select="@entity"/>
						<xsl:with-param name="iscollection" select="true()"/>
					</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:value-of select="concat($ind1, '&lt;xsl:template name=&quot;DefineTree', @entity, '&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($ind2, '&lt;xsl:call-template name=&quot;StartTree&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($ind3, '&lt;xsl:with-param name=&quot;name&quot;&gt;', @entity, '&lt;/xsl:with-param&gt;', $cr)"/>
		<xsl:if test="@color"><xsl:value-of select="concat($ind3, '&lt;xsl:with-param name=&quot;color&quot; select=&quot;@color&quot;/&gt;', $cr)"/></xsl:if>
		<xsl:if test="@imgline"><xsl:value-of select="concat($ind3, '&lt;xsl:with-param name=&quot;imgline&quot; select=&quot;@imgline&quot;/&gt;', $cr)"/></xsl:if>
		<xsl:if test="@imgdir"><xsl:value-of select="concat($ind3, '&lt;xsl:with-param name=&quot;imgdir&quot; select=&quot;@imgdir&quot;/&gt;', $cr)"/></xsl:if>
		<xsl:if test="@imgdiropen"><xsl:value-of select="concat($ind3, '&lt;xsl:with-param name=&quot;imgdiropen&quot; select=&quot;@imgdiropen&quot;/&gt;', $cr)"/></xsl:if>
		<xsl:if test="@imgdir_l"><xsl:value-of select="concat($ind3, '&lt;xsl:with-param name=&quot;imgdir_l&quot; select=&quot;@imgdir_l&quot;/&gt;', $cr)"/></xsl:if>
		<xsl:if test="@imgdiropen_l"><xsl:value-of select="concat($ind3, '&lt;xsl:with-param name=&quot;imgdiropen_l&quot; select=&quot;@imgdiropen_l&quot;/&gt;', $cr)"/></xsl:if>
		<xsl:if test="@itemoffset_x"><xsl:value-of select="concat($ind3, '&lt;xsl:with-param name=&quot;itemoffset_x&quot; select=&quot;@itemoffset_x&quot;/&gt;', $cr)"/></xsl:if>
		<xsl:if test="@itemoffset_y"><xsl:value-of select="concat($ind3, '&lt;xsl:with-param name=&quot;itemoffset_y&quot; select=&quot;@itemoffset_y&quot;/&gt;', $cr)"/></xsl:if>
		<xsl:if test="@fixwidth"><xsl:value-of select="concat($ind3, '&lt;xsl:with-param name=&quot;fixwidth&quot; select=&quot;@fixwidth&quot;/&gt;', $cr)"/></xsl:if>
		<xsl:if test="@fixheight"><xsl:value-of select="concat($ind3, '&lt;xsl:with-param name=&quot;fixheight&quot; select=&quot;@fixheight&quot;/&gt;', $cr)"/></xsl:if>
		<xsl:if test="@css"><xsl:value-of select="concat($ind3, '&lt;xsl:with-param name=&quot;css&quot; select=&quot;@css&quot;/&gt;', $cr)"/></xsl:if>
		<xsl:if test="@lined"><xsl:value-of select="concat($ind3, '&lt;xsl:with-param name=&quot;lined&quot; select=&quot;@lined&quot;/&gt;', $cr)"/></xsl:if>
		<xsl:if test="@imgitem"><xsl:value-of select="concat($ind3, '&lt;xsl:with-param name=&quot;imgitem&quot; select=&quot;@imgitem&quot;/&gt;', $cr)"/></xsl:if>
		<xsl:if test="@imgitem_l"><xsl:value-of select="concat($ind3, '&lt;xsl:with-param name=&quot;imgitem_l&quot; select=&quot;@imgitem_l&quot;/&gt;', $cr)"/></xsl:if>
		<xsl:if test="@styleover_css"><xsl:value-of select="concat($ind3, '&lt;xsl:with-param name=&quot;styleover_css&quot; select=&quot;@styleover_css&quot;/&gt;', $cr)"/></xsl:if>
		<xsl:if test="@styleover_color"><xsl:value-of select="concat($ind3, '&lt;xsl:with-param name=&quot;styleover_color&quot; select=&quot;@styleover_color&quot;/&gt;', $cr)"/></xsl:if>
		<xsl:if test="@styleover_bgcolor"><xsl:value-of select="concat($ind3, '&lt;xsl:with-param name=&quot;styleover_bgcolor&quot; select=&quot;@styleover_bgcolor&quot;/&gt;', $cr)"/></xsl:if>
		<xsl:if test="@target"><xsl:value-of select="concat($ind3, '&lt;xsl:with-param name=&quot;target&quot; select=&quot;@target&quot;/&gt;', $cr)"/></xsl:if>
		<xsl:if test="@position_abs"><xsl:value-of select="concat($ind3, '&lt;xsl:with-param name=&quot;position_abs&quot; select=&quot;@position_abs&quot;/&gt;', $cr)"/></xsl:if>
		<xsl:if test="@position_x"><xsl:value-of select="concat($ind3, '&lt;xsl:with-param name=&quot;position_x&quot; select=&quot;@position_x&quot;/&gt;', $cr)"/></xsl:if>
		<xsl:if test="@position_y"><xsl:value-of select="concat($ind3, '&lt;xsl:with-param name=&quot;position_y&quot; select=&quot;@position_y&quot;/&gt;', $cr)"/></xsl:if>
		<xsl:if test="@size_x"><xsl:value-of select="concat($ind3, '&lt;xsl:with-param name=&quot;size_x&quot; select=&quot;@size_x&quot;/&gt;', $cr)"/></xsl:if>
		<xsl:if test="@size_y"><xsl:value-of select="concat($ind3, '&lt;xsl:with-param name=&quot;size_y&quot; select=&quot;@size_y&quot;/&gt;', $cr)"/></xsl:if>
		<xsl:if test="@bgimg"><xsl:value-of select="concat($ind3, '&lt;xsl:with-param name=&quot;bgimg&quot; select=&quot;@bgimg&quot;/&gt;', $cr)"/></xsl:if>
		<xsl:value-of select="concat($ind2, '&lt;/xsl:call-template&gt;', $cr)"/>

		<xsl:value-of select="concat($ind2, '&lt;xsl:call-template name=&quot;TreeNode', @entity, '&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($ind3, '&lt;xsl:with-param name=&quot;parentid&quot; select=&quot;0&quot;/&gt;', $cr)"/>
		<xsl:value-of select="concat($ind3, '&lt;xsl:with-param name=&quot;level&quot; select=&quot;0&quot;/&gt;', $cr)"/>
		<xsl:value-of select="concat($ind3, '&lt;xsl:with-param name=&quot;indent&quot; select=&quot;$tree_tab&quot;/&gt;', $cr)"/>
		<xsl:value-of select="concat($ind2, '&lt;/xsl:call-template&gt;', $cr)"/>

		<xsl:value-of select="concat($ind2, '&lt;xsl:call-template name=&quot;EndTree&quot;/&gt;', $cr)"/>
		<xsl:value-of select="concat($ind1, '&lt;/xsl:template&gt;', $cr, $cr)"/>

		<xsl:value-of select="concat($ind1, '&lt;xsl:template name=&quot;TreeNode', @entity, '&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($ind2, '&lt;xsl:param name=&quot;parentid&quot;/&gt;', $cr)"/>
		<xsl:value-of select="concat($ind2, '&lt;xsl:param name=&quot;level&quot;/&gt;', $cr)"/>
		<xsl:value-of select="concat($ind2, '&lt;xsl:param name=&quot;indent&quot;/&gt;', $cr, $cr)"/>

		<xsl:value-of select="concat($ind2, '&lt;xsl:variable name=&quot;ind2&quot; select=&quot;concat($indent, $tree_tab, $tree_tab)&quot;/&gt;', $cr, $cr)"/>

		<xsl:value-of select="concat($ind2, '&lt;xsl:for-each select=&quot;', $datapath ,'[@', $parentid, '=$parentid]&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($ind3, '&lt;xsl:variable name=&quot;nodeid&quot; select=&quot;@', $nodeid, '&quot;/&gt;', $cr)"/>
		<xsl:value-of select="concat($ind3, '&lt;xsl:variable name=&quot;children&quot; select=&quot;count(', $datapath ,'[@', $parentid, '=$nodeid])&quot;/&gt;', $cr)"/>
		<xsl:value-of select="concat($ind3, '&lt;xsl:variable name=&quot;link&quot;&gt;', WTNODECLICK, '&lt;/xsl:variable&gt;', $cr, $cr)"/>

		<xsl:value-of select="concat($ind3, '&lt;xsl:call-template name=&quot;StartTreeNode1&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($ind4, '&lt;xsl:with-param name=&quot;indent&quot; select=&quot;$indent&quot;/&gt;', $cr)"/>
		<xsl:value-of select="concat($ind3, '&lt;/xsl:call-template&gt;', $cr, $cr)"/>

		<xsl:apply-templates>
			<xsl:with-param name="indent" select="2"/>
		</xsl:apply-templates>
		<xsl:value-of select="$cr"/>

		<xsl:value-of select="concat($ind3, '&lt;xsl:call-template name=&quot;StartTreeNode2&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($ind4, '&lt;xsl:with-param name=&quot;indent&quot; select=&quot;$indent&quot;/&gt;', $cr)"/>
		<xsl:value-of select="concat($ind4, '&lt;xsl:with-param name=&quot;level&quot; select=&quot;$level&quot;/&gt;', $cr)"/>
		<xsl:value-of select="concat($ind4, '&lt;xsl:with-param name=&quot;children&quot; select=&quot;$children&quot;/&gt;', $cr)"/>
		<xsl:value-of select="concat($ind4, '&lt;xsl:with-param name=&quot;link&quot; select=&quot;$link&quot;/&gt;', $cr)"/>
		<xsl:if test="@imgdir_l2"><xsl:value-of select="concat($ind4, '&lt;xsl:with-param name=&quot;imgdir_l&quot; select=&quot;@imgdir_l2&quot;/&gt;', $cr)"/></xsl:if>
		<xsl:if test="@imgdiropen_l2"><xsl:value-of select="concat($ind4, '&lt;xsl:with-param name=&quot;imgdiropen_l&quot; select=&quot;@imgdiropen_l2&quot;/&gt;', $cr)"/></xsl:if>
		<xsl:value-of select="concat($ind3, '&lt;/xsl:call-template&gt;', $cr, $cr)"/>

		<xsl:value-of select="concat($ind3, '&lt;xsl:if test=&quot;$children!=0&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($ind4, '&lt;xsl:call-template name=&quot;TreeNode', @entity, '&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($ind5, '&lt;xsl:with-param name=&quot;parentid&quot; select=&quot;$nodeid&quot;/&gt;', $cr)"/>
		<xsl:value-of select="concat($ind5, '&lt;xsl:with-param name=&quot;level&quot; select=&quot;$level+1&quot;/&gt;', $cr)"/>
		<xsl:value-of select="concat($ind5, '&lt;xsl:with-param name=&quot;indent&quot; select=&quot;$ind2&quot;/&gt;', $cr)"/>
		<xsl:value-of select="concat($ind4, '&lt;/xsl:call-template&gt;', $cr)"/>
		<xsl:value-of select="concat($ind3, '&lt;/xsl:if&gt;', $cr, $cr)"/>

		<xsl:value-of select="concat($ind3, '&lt;xsl:call-template name=&quot;EndTreeNode&quot;&gt;', $cr)"/>
		<xsl:value-of select="concat($ind4, '&lt;xsl:with-param name=&quot;indent&quot; select=&quot;$indent&quot;/&gt;', $cr)"/>
		<xsl:value-of select="concat($ind4, '&lt;xsl:with-param name=&quot;children&quot; select=&quot;$children&quot;/&gt;', $cr)"/>
		<xsl:value-of select="concat($ind4, '&lt;xsl:with-param name=&quot;link&quot; select=&quot;$link&quot;/&gt;', $cr)"/>
		<xsl:value-of select="concat($ind3, '&lt;/xsl:call-template&gt;', $cr, $cr)"/>

		<xsl:value-of select="concat($ind2, '&lt;/xsl:for-each&gt;', $cr)"/>
		<xsl:value-of select="concat($ind1, '&lt;/xsl:template&gt;', $cr, $cr)"/>
	</xsl:template>

</xsl:stylesheet>
