<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:include href="GenerateInclude.xsl"/>
<!--===============================================================================
	Auth: Bob Wood
	Date: October 2002
	Desc: Validates an ILingual Entity Definition
	Copyright 2002 WinTech, Inc.
===================================================================================-->

<xsl:template match="/">
<VALID>
	 <xsl:apply-templates/>
</VALID>
</xsl:template>

<xsl:template match="Data/WTENTITY">
	<xsl:variable name="id" select="@id"/>
	<xsl:variable name="alias" select="@alias"/>

	<!--TEST valid attributes-->
	<xsl:for-each select="@*">
		<xsl:choose>
			<xsl:when test="name()='id'"/>
			<xsl:when test="name()='name'"/>
			<xsl:when test="name()='alias'"/>
			<xsl:when test="name()='VB'"/>
			<xsl:when test="name()='language'"/>
			<xsl:when test="name()='log'"/>
			<xsl:when test="name()='audit'"/>
			<xsl:when test="name()='identity'"/>
			<xsl:when test="name()='title'"/>
			<xsl:when test="name()='translate'"/>
			<xsl:otherwise><xsl:value-of select="concat( 'Invalid WTENTITY Attribute (', name(), ')', $cr)"/></xsl:otherwise>
		</xsl:choose>
	</xsl:for-each>
	<xsl:if test="not(@id)">
		<xsl:value-of select="concat( 'Missing Entity id Attribute',$cr)"/>
	</xsl:if>
	<xsl:if test="not(@name)">
		<xsl:value-of select="concat( 'Missing Entity name Attribute',$cr)"/>
	</xsl:if>
	<xsl:if test="not(@alias)">
		<xsl:value-of select="concat( 'Missing Entity alias Attribute',$cr)"/>
	</xsl:if>

	<!--TEST Entity-->
	<xsl:choose>
		<!--TEST entity exists-->
		<xsl:when test="/Data/WTENTITIES/WTENTITY[@name=$entityname]">

			<!--TEST entity id-->
			<xsl:if test="/Data/WTENTITIES/WTENTITY[@name=$entityname]/@number!=$id">
				<xsl:value-of select="concat( 'Invalid Entity ID! (', $entityname, ':', $id,')',$cr)"/>
			</xsl:if>
			
			<!--TEST entity alias-->
			<xsl:if test="/Data/WTENTITIES/WTENTITY[@name=$entityname]/@alias!=$alias">
				<xsl:value-of select="concat( 'Invalid Entity alias! (', $entityname, ':', $alias,')',$cr)"/>
			</xsl:if>
			
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="concat( 'Entity not found! (', $entityname, ')',$cr)"/>
		</xsl:otherwise>
	</xsl:choose>

	<!--***********************************************************************************************-->
	<!--TEST Entity Attributes-->
	<!--TEST unique IDs-->
	<xsl:if test="count(/Data/WTENTITY/WTATTRIBUTE[@id=preceding-sibling::WTATTRIBUTE/@id])!=0">
		<xsl:value-of select="concat( 'All Attribute IDs are NOT Unique',$cr)"/>
	</xsl:if>
	
	<!--TEST unique Names-->
	<xsl:if test="count(/Data/WTENTITY/WTATTRIBUTE[@name=preceding-sibling::WTATTRIBUTE/@name])!=0">
		<xsl:value-of select="concat( 'All Attribute Names are NOT Unique',$cr)"/>
	</xsl:if>
	
	<!--TEST required Title-->
	<xsl:if test="count(/Data/WTENTITY/WTATTRIBUTE/@title)=0 and not(/Data/WTENTITY/@title='false')">
		<xsl:value-of select="concat( 'No Title Attribute Defined',$cr)"/>
	</xsl:if>
	<!--TEST single Title-->
	<xsl:if test="count(/Data/WTENTITY/WTATTRIBUTE/@title)>1">
		<xsl:value-of select="concat( 'Only One Title Attribute Allowed',$cr)"/>
	</xsl:if>
	
	<!--TEST unique Names-->
	<xsl:for-each select="/Data/WTENTITY/WTATTRIBUTE">
		<xsl:variable name="attrname" select="@name"/>

		<!--TEST valid attributes-->
		<xsl:for-each select="@*">
			<xsl:choose>
				<xsl:when test="name()='id'"/>
				<xsl:when test="name()='name'"/>
				<xsl:when test="name()='type'"/>
				<xsl:when test="name()='identity'"/>
				<xsl:when test="name()='parent'"/>
				<xsl:when test="name()='seq'"/>
				<xsl:when test="name()='min'"/>
				<xsl:when test="name()='max'"/>
				<xsl:when test="name()='source'"/>
				<xsl:when test="name()='required'"/>
				<xsl:when test="name()='length'"/>
				<xsl:when test="name()='precision'"/>
				<xsl:when test="name()='title'"/>
				<xsl:when test="name()='persist'"/>
				<xsl:when test="name()='passthru'"/>
				<xsl:when test="name()='language'"/>
				<xsl:when test="name()='sum'"/>
	 			<xsl:when test="name()='embed'"/>
	 			<xsl:when test="name()='embedhtml'"/>
	 			<xsl:when test="name()='xml'"/>
        <xsl:when test="name()='blankrow'"/>
        <xsl:when test="name()='label'"/>
        <xsl:otherwise><xsl:value-of select="concat( 'Invalid WTATTRIBUTE Attribute (', $attrname, ':', name(), ')', $cr)"/></xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>

		<!--TEST valid attributes-->
		<xsl:for-each select="WTINIT/@*">
			<xsl:choose>
				<xsl:when test="name()='name'"/>
				<xsl:when test="name()='type'"/>
				<xsl:when test="name()='value'"/>
				<xsl:when test="name()='template'"/>
				<xsl:otherwise><xsl:value-of select="concat( 'Invalid WTATTRIBUTE/WTINIT Attribute (', $attrname, ':', name(), ')', $cr)"/></xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>

		<!--TEST valid attributes-->
		<xsl:for-each select="WTFORMAT/@*">
			<xsl:choose>
				<xsl:when test="name()='value'"/>
				<xsl:when test="name()='zero'"/>
        <xsl:when test="name()='round'"/>
        <xsl:when test="name()='convert'"/>
        <xsl:otherwise><xsl:value-of select="concat( 'Invalid WTATTRIBUTE/WTFORMAT Attribute (', $attrname, ':', name(), ')', $cr)"/></xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>

		<!--TEST valid attributes-->
		<xsl:for-each select="WTCOMPUTE/@*">
			<xsl:choose>
				<xsl:when test="name()='name'"/>
				<xsl:when test="name()='width'"/>
				<xsl:when test="name()='text'"/>
				<xsl:when test="name()='convert'"/>
				<xsl:when test="name()='required'"/>
				<xsl:when test="name()='custom'"/>
				<xsl:otherwise><xsl:value-of select="concat( 'Invalid WTATTRIBUTE/WTCOMPUTE Attribute (', $attrname, ':', name(), ')', $cr)"/></xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>

		<xsl:for-each select="WTCOMPUTE">
			<!--TEST each compute attribute to be a valid entity attribute-->
			<xsl:if test="@name">
				<xsl:variable name="cname" select="@name"/>
				<xsl:if test="not(/Data/WTENTITY/WTATTRIBUTE[@name=$cname])">
					<xsl:value-of select="concat( 'Invalid Compute Name (', ../@name, ':', $cname, ')', $cr)"/>
				</xsl:if>
			</xsl:if>
		</xsl:for-each>

		<!--TEST valid attributes-->
		<xsl:for-each select="WTTRUE/@*">
			<xsl:choose>
				<xsl:when test="name()='name'"/>
				<xsl:otherwise><xsl:value-of select="concat( 'Invalid WTATTRIBUTE/WTTRUE Attribute (', $attrname, ':', name(), ')', $cr)"/></xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>

		<!--TEST valid attributes-->
		<xsl:for-each select="WTFALSE/@*">
			<xsl:choose>
				<xsl:when test="name()='name'"/>
				<xsl:otherwise><xsl:value-of select="concat( 'Invalid WTATTRIBUTE/WTFALSE Attribute (', $attrname, ':', name(), ')', $cr)"/></xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>

		<xsl:if test="WTLOOKUP">
			<!--TEST valid attributes-->
			<xsl:for-each select="WTLOOKUP/@*">
				<xsl:choose>
					<xsl:when test="name()='entity'"/>
					<xsl:when test="name()='class'"/>
					<xsl:when test="name()='method'"/>
					<xsl:when test="name()='template'"/>
					<xsl:when test="name()='blankrow'"/>
					<xsl:otherwise><xsl:value-of select="concat( 'Invalid WTLOOKUP Attribute (', $attrname, ':', name(), ')', $cr)"/></xsl:otherwise>
				</xsl:choose>
			</xsl:for-each>

			<xsl:for-each select="WTLOOKUP/WTPARAM">
				<!--TEST valid attributes-->
				<xsl:for-each select="WTLOOKUP/WTPARAM/@*">
					<xsl:choose>
						<xsl:when test="name()='name'"/>
						<xsl:when test="name()='direction'"/>
						<xsl:when test="name()='type'"/>
						<xsl:when test="name()='value'"/>
						<xsl:otherwise><xsl:value-of select="concat( 'Invalid WTLOOKUP/WTPARAM Attribute (', $attrname, ':', name(), ')', $cr)"/></xsl:otherwise>
					</xsl:choose>
				</xsl:for-each>
			</xsl:for-each>
		</xsl:if>

    <xsl:if test="WTINPUTOPTIONS">
      <!--TEST required Value-->
      <xsl:if test="count(/Data/WTENTITY/WTATTRIBUTE/WTINPUTOPTIONS/@values)=0">
        <xsl:value-of select="concat('WTINPUTOPTIONS missing Values',$cr)"/>
      </xsl:if>
      <!--TEST valid attributes-->
      <xsl:for-each select="WTINPUTOPTIONS/@*">
        <xsl:choose>
          <xsl:when test="name()='name'"/>
          <!--not used-->
          <xsl:when test="name()='values'"/>
          <xsl:otherwise>
            <xsl:value-of select="concat( 'Invalid WTINPUTOPTIONS Attribute (', $attrname, ':', name(), ')', $cr)"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:for-each>
    </xsl:if>

    <xsl:if test="WTCUSTOMFIELDS">
      <!--TEST required Value-->
      <xsl:if test="count(/Data/WTENTITY/WTATTRIBUTE/WTCUSTOMFIELDS/@values)=0">
        <xsl:value-of select="concat('WTCUSTOMFIELDS missing Values',$cr)"/>
      </xsl:if>
      <!--TEST valid attributes-->
      <xsl:for-each select="WTCUSTOMFIELDS/@*">
        <xsl:choose>
          <xsl:when test="name()='name'"/>
          <xsl:when test="name()='display'"/>
          <!--not used-->
          <xsl:when test="name()='values'"/>
          <xsl:otherwise>
            <xsl:value-of select="concat( 'Invalid WTCUSTOMFIELDS Attribute (', $attrname, ':', name(), ')', $cr)"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:for-each>
    </xsl:if>

    <xsl:if test="WTINPUTVALUES">
			<!--TEST valid attributes-->
			<xsl:for-each select="WTINPUTVALUES/@*">
				<xsl:choose>
					<xsl:when test="name()='name'"/>  <!--not used-->
					<xsl:when test="name()='values'"/> <!--not used-->
					<xsl:otherwise><xsl:value-of select="concat( 'Invalid WTINPUTVALUES Attribute (', $attrname, ':', name(), ')', $cr)"/></xsl:otherwise>
				</xsl:choose>
			</xsl:for-each>
		</xsl:if>

		<!--TEST attribute type-->
		<xsl:choose>
			<xsl:when test="@type='char'"/>
			<xsl:when test="@type='text'"/>
      <xsl:when test="@type='big number'"/>
      <xsl:when test="@type='number'"/>
      <xsl:when test="@type='small number'"/>
      <xsl:when test="@type='tiny number'"/>
			<xsl:when test="@type='decimal'"/>
			<xsl:when test="@type='date'"/>
			<xsl:when test="@type='time'"/>
			<xsl:when test="@type='currency'"/>
			<xsl:when test="@type='yesno'"/>
			<xsl:when test="@type='password'"/>
			<xsl:otherwise>
				<xsl:value-of select="concat( 'Invalid Attribute Type (', @name, ':', @type, ')', $cr)"/>
			</xsl:otherwise>
		</xsl:choose>
		
		<!--TEST attribute source-->
		<xsl:choose>
			<xsl:when test="@source='entity'"/>
			<xsl:when test="@source='join'"/>
			<xsl:when test="@source='inherit'"/>
			<xsl:when test="@source='audit'"/>
			<xsl:otherwise>
				<xsl:value-of select="concat( 'Invalid Attribute Source (', @name, ':', @source, ')', $cr)"/>
			</xsl:otherwise>
		</xsl:choose>
		
		<!--TEST attribute audit source-->
		<xsl:if test="@source='audit'">
			<!--TEST if entity supports audit fields-->
			<xsl:if test="not(/Data/WTENTITY/@audit='true')">
				<xsl:value-of select="concat( 'entity does not support audit fields (', @name, ')',$cr)"/>
			</xsl:if>
			<xsl:choose>
				<xsl:when test="@name='CreateID'"/>
				<xsl:when test="@name='CreateDate'"/>
				<xsl:when test="@name='ChangeID'"/>
				<xsl:when test="@name='ChangeDate'"/>
				<xsl:otherwise>
					<xsl:value-of select="concat( 'Invalid Audit Attribute Name (', @name, ')', $cr)"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
		
		<!--TEST entity Attributes must Not have WTJOIN-->
		<xsl:if test="@source='entity'">
			<xsl:if test="WTJOIN">
				<xsl:value-of select="concat( 'entity source Attribute Can Not have a WTJOIN (', @name, ')',$cr)"/>
			</xsl:if>
		</xsl:if>

		<!--TEST join and inherit Attributes must have WTJOIN-->
		<xsl:if test="@source='join' or @source='inherit'">
			<xsl:if test="not(WTJOIN)">
				<xsl:value-of select="concat( 'Attribute is Missing WTJOIN (', @name, ')',$cr)"/>
			</xsl:if>
		</xsl:if>

		<!--TEST attribute WTJOIN-->
		<xsl:if test="WTJOIN">
			<xsl:variable name="join" select="WTJOIN/@entity"/>
			<xsl:if test="not(/Data/WTENTITY/WTRELATIONSHIPS/WTRELATIONSHIP[*]/WTENTITY[@name=$join])">
				<xsl:value-of select="concat( 'Attribute WTJOIN has no Relationship defined (', @name, ':', $join, ')',$cr)"/>
			</xsl:if>
			
			<!--TEST valid attributes-->
			<xsl:for-each select="WTJOIN/@*">
				<xsl:choose>
					<xsl:when test="name()='entity'"/>
					<xsl:when test="name()='name'"/>
					<xsl:otherwise><xsl:value-of select="concat( 'Invalid WTJOIN Attribute (', name(), ')', $cr)"/></xsl:otherwise>
				</xsl:choose>
			</xsl:for-each>
		</xsl:if>
		
		<!--TEST each attribute number to be in the same series as the entity id-->
		<xsl:if test="floor(@id div 100)!=$id">
			<xsl:value-of select="concat( 'Attribute ID Not in same series as the Entity ID (', @id, ')',$cr)"/>
		</xsl:if>
		
		<!--TEST attribute langauge for joined attributes-->
		<xsl:if test="@language and WTJOIN">
			<xsl:variable name="lname" select="@language"/>
			<xsl:if test="not(/Data/WTENTITY/WTATTRIBUTE[@name=$lname])">
				<xsl:value-of select="concat( 'Language Attribute is Not a valid Entity Attribute (', $lname, ')',$cr)"/>
			</xsl:if>
			<xsl:if test="/Data/WTENTITY/WTATTRIBUTE[@name=$lname]">
	 			<xsl:if test="not(/Data/WTENTITY/WTATTRIBUTE[@name=$lname and @type='number'])">
	 				<xsl:value-of select="concat( 'Language Attribute is Not a number type (', $lname, ')',$cr)"/>
				</xsl:if>
			</xsl:if>

		   <!-- test if the language label is defined in the Application XML -->
		   <xsl:variable name="langentity" select="WTJOIN/@entity"/> 
		   <xsl:variable name="langattribute" select="WTJOIN/@name"/>
			<xsl:if test="not(/Data/WTLABELS/LABEL[@entity=$langentity and @attribute=$langattribute])">
				<xsl:value-of select="concat( 'Language Attribute is Not defined in the Application XML (', @name, ')',$cr)"/>
			</xsl:if>
		</xsl:if>
		
		
	</xsl:for-each>
	<!--TEST single identity attribute-->
	<xsl:if test="count(/Data/WTENTITY/WTATTRIBUTE/@identity)&gt;1">
		<xsl:value-of select="concat( 'Only one Identity Attribute allowed',$cr)"/>
	</xsl:if>
	
	<!--TEST identity attribute to be a number-->
	<xsl:if test="/Data/WTENTITY/WTATTRIBUTE[@identity]/@type!='number'">
		<xsl:value-of select="concat( 'Identity Attribute must be a number',$cr)"/>
	</xsl:if>

	<!--***********************************************************************************************-->
	<!--TEST WTINDEXES-->
	 <xsl:for-each select="WTINDEX">
		  <xsl:variable name="iname" select="@name"/>
		  <xsl:for-each select="@*">
		  		<xsl:choose>
		  			<xsl:when test="name()='name'"/>
		  			<xsl:when test="name()='unique'"/>
		  			<xsl:otherwise><xsl:value-of select="concat( 'Invalid WTINDEX Attribute (', $iname, ':', name(), ')', $cr)"/></xsl:otherwise>
		  		</xsl:choose>
		  </xsl:for-each>
	 
	 	 <xsl:for-each select="WTATTRIBUTE">
				<xsl:variable name="ianame" select="@name"/>
		  		<xsl:if test="not(/Data/WTENTITY/WTATTRIBUTE[@name=$ianame])">
					 <xsl:value-of select="concat( 'Invalid Index Attribute Name (', $iname, ':', $ianame, ')', $cr)"/>
				</xsl:if>
		</xsl:for-each>
	 </xsl:for-each>

	<!--***********************************************************************************************-->
	<!--TEST WTRELATIONSHIPS-->
	<!--TEST unique entities-->
	<xsl:if test="count(/Data/WTENTITY/WTRELATIONSHIPS/WTRELATIONSHIP[@name=preceding-sibling::WTRELATIONSHIP/@name])!=0">
		<xsl:value-of select="concat( 'All Relationship Names are NOT Unique',$cr)"/>
	</xsl:if>

	<!--TEST each relationship-->
	<xsl:for-each select="/Data/WTENTITY/WTRELATIONSHIPS/WTRELATIONSHIP">
		<xsl:variable name="rname" select="@name"/>

		  <!--TEST valid attributes-->
		  <xsl:for-each select="@*">
		  	<xsl:choose>
		  		<xsl:when test="name()='name'"/>
		  		<xsl:when test="name()='entity'"/>
		  		<xsl:when test="name()='alias'"/>
		  		<xsl:otherwise><xsl:value-of select="concat( 'Invalid WTRELATIONSHIP Attribute (', name(), ')', $cr)"/></xsl:otherwise>
		  	</xsl:choose>
		  </xsl:for-each>
		  <!-- Only test Common and Parent Relationships for primary name and alias-->
		  <xsl:variable name="testprimary">
		  	<xsl:if test="@name='Common'">Yes</xsl:if>
		  	<xsl:if test="/Data/WTENTITY/WTPARENTS/WTPARENT[@entity=$rname]">Yes</xsl:if>
		  </xsl:variable>
		  <xsl:if test="string-length($testprimary)>0">
		  	<!--NEW TEST relationship entity must be the primary entity-->
		  	<xsl:if test="@entity!=$entityname">
		  		<xsl:value-of select="concat( 'Relationship entity is Not the primary entity (', $rname, ':', @entity, ')',$cr)"/>
		  	</xsl:if>
		  	<!--NEW TEST relationship entity must be the primary alias-->
		  	<xsl:if test="@alias!=$alias">
		  		<xsl:value-of select="concat( 'Relationship alias is Not the primary entity (', $rname, ':', @alias, ')',$cr)"/>
		  	</xsl:if>
		  </xsl:if>

		<!--NEW TEST unique aliases-->
		<xsl:if test="count(WTENTITY[@name=preceding-sibling::WTENTITY/@name])!=0">
			<xsl:value-of select="concat( 'All Relationship WTENTITY Names are NOT Unique(', $rname, ')', $cr)"/>
		</xsl:if>
		
		<!--NEW TEST unique aliases-->
		<xsl:if test="count(WTENTITY[@alias=preceding-sibling::WTENTITY/@alias])!=0">
			<xsl:value-of select="concat( 'All Relationship WTENTITY Aliases are NOT Unique(', $rname, ')', $cr)"/>
		</xsl:if>

		<!--TEST each relationship's attributes-->
		<xsl:for-each select="WTENTITY">
			<xsl:variable name="ename" select="@name"/>
			<xsl:variable name="eentity" select="@entity"/>

			<!--TEST valid attributes-->
			<xsl:for-each select="@*">
				<xsl:choose>
					<xsl:when test="name()='name'"/>
					<xsl:when test="name()='entity'"/>
					<xsl:when test="name()='alias'"/>
					<xsl:when test="name()='join'"/>
					<xsl:when test="name()='validate'"/>
					<xsl:otherwise><xsl:value-of select="concat( 'Invalid WTRELATIONSHIP/WTENTITY Attribute (', name(), ')', $cr)"/></xsl:otherwise>
				</xsl:choose>
			</xsl:for-each>

			<!--TEST WTENTITY entity must be a valid entity-->
			<xsl:if test="not(@validate='false') and not(/Data/WTENTITIES/WTENTITY[@name=$eentity])">
				<xsl:value-of select="concat( 'Invalid Relationship WTENTITY entity (', $rname, ':', $eentity,')',$cr)"/>
			</xsl:if>

			<!--NEW TEST each relationship to be defined in APP-->
			<!--only do this test if this entity has only one attribute-->

			<xsl:for-each select="WTATTRIBUTE">
				<xsl:variable name="aname" select="@name"/>

				<!--TEST valid attributes-->
				<xsl:for-each select="@*">
					<xsl:choose>
						<xsl:when test="name()='alias'"/>
						<xsl:when test="name()='name'"/>
						<xsl:when test="name()='relalias'"/>
						<xsl:when test="name()='relname'"/>
						<xsl:when test="name()='connector'"/>
						<xsl:when test="name()='validate'"/>
						<xsl:otherwise><xsl:value-of select="concat( 'Invalid WTRELATIONSHIP/WTENTITY/WTATTRIBUTE Attribute (', name(), ')', $cr)"/></xsl:otherwise>
					</xsl:choose>
				</xsl:for-each>

				<xsl:if test="not(@validate='false')">
					<!--NEW TEST attribute alias must be defined in this relationship-->
					<xsl:call-template name="ValidAlias">
						<xsl:with-param name="relationship" select="$rname"/>
						<xsl:with-param name="entity" select="$ename"/>
						<xsl:with-param name="alias" select="@alias"/>
					</xsl:call-template>

					<!--NEW TEST attribute related alias must be a defined in this relationship-->
					<xsl:call-template name="ValidAlias">
						<xsl:with-param name="relationship" select="$rname"/>
						<xsl:with-param name="entity" select="$ename"/>
						<xsl:with-param name="alias" select="@relalias"/>
					</xsl:call-template>
				</xsl:if>

			</xsl:for-each>
		</xsl:for-each>
	</xsl:for-each>

	<!--***********************************************************************************************-->
	<!--TEST each WTPARENT-->
	<xsl:for-each select="/Data/WTENTITY/WTPARENTS/WTPARENT">
		
		<!--TEST valid attributes-->
		<xsl:for-each select="@*">
			<xsl:choose>
				<xsl:when test="name()='entity'"/>
				<xsl:when test="name()='id'"/>
				<xsl:when test="name()='title'"/>
				<xsl:when test="name()='parenttitle'"/>
				<xsl:otherwise><xsl:value-of select="concat( 'Invalid WTPARENT Attribute (', name(), ')', $cr)"/></xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>

		<!--TEST WTPARENT Entity exisits-->
		<xsl:variable name="pentity" select="@entity"/>
		<xsl:if test="not(/Data/WTENTITIES/WTENTITY[@name=$pentity])">
			<xsl:value-of select="concat( 'Invalid Parent Entity Name (', $pentity, ')',$cr)"/>
		</xsl:if>

		<!--TEST parent entity matches id-->
		<xsl:variable name="pid" select="@id"/>
		<xsl:if test="not(/Data/WTENTITIES/WTENTITY[@name=$pentity and @identity=$pid])">
			<xsl:value-of select="concat( 'Invalid Parent Entity ID (', $pentity, ':', $pid, ')',$cr)"/>
		</xsl:if>

	</xsl:for-each>

	<!--***********************************************************************************************-->
	<!--TEST each WTENUM-->

	<xsl:for-each select="/Data/WTENTITY/WTENUM">

		<!--TEST Enum type must be list or find-->
		<xsl:if test="not(@type='list' or @type='find')">
			<xsl:value-of select="concat( 'Invalid Enum Type (', @type, ')',$cr)"/>
		</xsl:if>
		
		<!--TEST for valid entity attribute-->
		<xsl:for-each select="WTATTRIBUTE">
		
			<xsl:variable name="ename" select="@name"/>
			<xsl:if test="not(/Data/WTENTITY/WTATTRIBUTE[@name=$ename])">
				<xsl:value-of select="concat( 'Enum Attribute is Not a valid Entity Attribute (', $ename, ')',$cr)"/>
			</xsl:if>
			
		</xsl:for-each>

	</xsl:for-each>

	<xsl:if test="count(/Data/WTENTITY/WTENUM)>1">
	
		<!--Get number of unique enum ids-->
		<!--TEST unique enum ids-->

		<xsl:if test="count(/Data/WTENTITY/WTENUM[@id=preceding-sibling::WTENUM/@id])!=0">
			<xsl:value-of select="concat( 'All Enum IDs are Not Unique',$cr)"/>
		</xsl:if>

		<!--TEST unique enum types-->
<!--
		<xsl:if test="count(/Data/WTENTITY/WTENUM[@type=preceding-sibling::WTENUM/@type])!=0">
			<xsl:value-of select="concat( 'All Enum Types are Not Unique',$cr)"/>
		</xsl:if>
-->		
	</xsl:if>

	<xsl:for-each select="/Data/WTENTITY/WTENUM[@type='find']/WTATTRIBUTE">
	
		<!--TEST valid attributes-->
		<xsl:for-each select="@*">
			<xsl:choose>
				<xsl:when test="name()='name'"/>
				<xsl:when test="name()='hidden'"/>
				<xsl:when test="name()='default'"/>
				<xsl:when test="name()='contains'"/>
				<xsl:when test="name()='rows'"/>
				<xsl:when test="name()='order'"/>
        <xsl:when test="name()='length'"/>
        <xsl:when test="name()='const'"/>
        <xsl:otherwise><xsl:value-of select="concat( 'Invalid Find WTENUM/WTATTRIBUTE Attribute (', name(), ')', $cr)"/></xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
	</xsl:for-each>

	<xsl:for-each select="/Data/WTENTITY/WTENUM[@type='list']/WTATTRIBUTE">
	
		<!--TEST valid attributes-->
		<xsl:for-each select="@*">
			<xsl:choose>
				<xsl:when test="name()='name'"/>
				<xsl:when test="name()='hidden'"/>
				<xsl:when test="name()='entity'"/>
				<xsl:otherwise><xsl:value-of select="concat( 'Invalid List WTENUM/WTATTRIBUTE Attribute (', name(), ')', $cr)"/></xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>

		<xsl:variable name="leentity" select="@entity"/>
		<xsl:variable name="lename" select="@name"/>
		<xsl:choose>
			<xsl:when test="/Data/WTENTITIES/WTENTITY[@name=$leentity]">

				<!--TEST entity id-->
<!-- THE LIST NAME DOES NOT HAVE TO BE THE ENTITY IDENTITY 				
				<xsl:if test="/Data/WTENTITIES/WTENTITY[@name=$leentity]/@identity!=$lename">
					<xsl:value-of select="concat( 'Invalid List Enum Entity ID (', $leentity, ':', $lename,')',$cr)"/>
				</xsl:if>
-->				
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="concat( 'Invalid List Enum Entity (', $leentity,')',$cr)"/>
			</xsl:otherwise>
		</xsl:choose>

	</xsl:for-each>
	
</xsl:template>

<!--***********************************************************************************************-->
<xsl:template name="ValidAlias">
	<xsl:param name="relationship"/>
	<xsl:param name="entity"/>
	<xsl:param name="alias"/>

	<!--TEST if the alias is define in WTRELATIONSHIP-->
	<xsl:if test="not(/Data/WTENTITY/WTRELATIONSHIPS/WTRELATIONSHIP[@name=$relationship and @alias=$alias])">
		<!--TEST if the alias is define in a WTRELATIONSHIP WTENTITY-->
<!--
		<xsl:if test="not(/Data/WTENTITY/WTRELATIONSHIPS/WTRELATIONSHIP[@name=$relationship]/WTENTITY[@alias=$alias])">
			<xsl:value-of select="concat( 'Relationship WTENTITY alias Not defined (', $relationship, ':', $entity, ':', $alias ,')',$cr)"/>
		</xsl:if>
-->
	</xsl:if>

</xsl:template>

<!--***********************************************************************************************-->
<xsl:template name="GetAliasEntity">
	<xsl:param name="relationship"/>
	<xsl:param name="alias"/>

	<!--Look for alias in WTRELATIONSHIP-->
	<xsl:choose>
		<xsl:when test="/Data/WTENTITY/WTRELATIONSHIPS/WTRELATIONSHIP[@name=$relationship and @alias=$alias]">
			<xsl:value-of select="/Data/WTENTITY/WTRELATIONSHIPS/WTRELATIONSHIP[@name=$relationship and @alias=$alias]/@entity"/>
		</xsl:when>
		<xsl:otherwise>
			<!--Look for alias in a WTRELATIONSHIP WTENTITY-->
			<xsl:if test="/Data/WTENTITY/WTRELATIONSHIPS/WTRELATIONSHIP[@name=$relationship]/WTENTITY[@alias=$alias]">
				<xsl:value-of select="/Data/WTENTITY/WTRELATIONSHIPS/WTRELATIONSHIP[@name=$relationship]/WTENTITY[@alias=$alias]/@entity"/>
			</xsl:if>
		</xsl:otherwise>
	</xsl:choose>

</xsl:template>

</xsl:stylesheet>

