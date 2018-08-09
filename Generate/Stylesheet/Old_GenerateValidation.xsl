<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:include href="GenerateInclude.xsl"/>
<!--===============================================================================
	Auth: Bob Wood
	Date: October 2001
	Desc: Transforms an ILingual Entity Definition to Constant Declaration List
	Copyright 2001 WinTech, Inc.
===================================================================================-->

<xsl:template match="/">
<VALID>
	<xsl:variable name="msg">
		<xsl:apply-templates/>
	</xsl:variable>
	
	<xsl:choose>
		<xsl:when test="string-length($msg)=0">
			<xsl:text>SUCCESS</xsl:text>
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="$msg"/>
		</xsl:otherwise>
	</xsl:choose>
	
</VALID>
</xsl:template>

<xsl:template match="Data/WTENTITY">
	<xsl:variable name="id" select="/Data/WTENTITY/@id"/>
	<xsl:variable name="alias" select="/Data/WTENTITY/@alias"/>

	<!--TEST valid attributes-->
	<xsl:for-each select="/Data/WTENTITY/@*">
		<xsl:choose>
			<xsl:when test="name()='id'"/>
			<xsl:when test="name()='name'"/>
			<xsl:when test="name()='alias'"/>
			<xsl:otherwise><xsl:value-of select="concat( 'Invalid WTENTITY Attribute (', name(), ')', $cr)"/></xsl:otherwise>
		</xsl:choose>
	</xsl:for-each>

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
	<xsl:if test="count(/Data/WTENTITY/WTATTRIBUTE/@title)=0">
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
				<xsl:when test="name()='min'"/>
				<xsl:when test="name()='max'"/>
				<xsl:when test="name()='source'"/>
				<xsl:when test="name()='required'"/>
				<xsl:when test="name()='length'"/>
				<xsl:when test="name()='title'"/>
				<xsl:when test="name()='begyear'"/>
				<xsl:when test="name()='endyear'"/>
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
			<xsl:otherwise>
				<xsl:value-of select="concat( 'Invalid Attribute Source (', @name, ':', @source, ')', $cr)"/>
			</xsl:otherwise>
		</xsl:choose>
		
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
<!--
			<xsl:if test="not(@child)">
-->
			<!--TEST Relationship should be used by a Procedure WTJOIN or be the Parent Entity -->
			<xsl:if test="not(/Data/WTPROCEDURES/WTPROCEDURE/WTJOIN[@name=$rname])">
				<xsl:if test="not(/Data/WTENTITY/WTPARENTS/WTPARENT[@entity=$rname])">
					<xsl:value-of select="concat( 'Relationship Not Referenced by a Join or Parent (', $rname, ')', $cr)"/>
				</xsl:if>
			</xsl:if>

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
<!--
		</xsl:if>
-->		
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
					<xsl:otherwise><xsl:value-of select="concat( 'Invalid WTRELATIONSHIP/WTENTITY Attribute (', name(), ')', $cr)"/></xsl:otherwise>
				</xsl:choose>
			</xsl:for-each>

			<!--TEST WTENTITY entity must be a valid entity-->
			<xsl:if test="not(/Data/WTENTITIES/WTENTITY[@name=$eentity])">
				<xsl:value-of select="concat( 'Invalid Relationship WTENTITY entity (', $rname, ':', $eentity,')',$cr)"/>
			</xsl:if>

			<!--NEW TEST each relationship to be defined in APP-->
			<!--only do this test if this entity has only one attribute-->
			<xsl:if test="count(WTATTRIBUTE)=1">
				<xsl:variable name="entity1">
					<xsl:call-template name="GetAliasEntity">
						<xsl:with-param name="relationship" select="$rname"/>
						<xsl:with-param name="alias" select="WTATTRIBUTE/@alias"/>
					</xsl:call-template>
				</xsl:variable>

				<xsl:variable name="entity2" select="@entity"/>
				<xsl:variable name="column1" select="WTATTRIBUTE/@name"/>
				<xsl:variable name="column2" select="WTATTRIBUTE/@relname"/>

				<xsl:if test="not(/Data/WTRELATIONSHIPS/WTRELATIONSHIP[@entity=$entity1 and @relentity=$entity2 and @column=$column1 and @relcolumn=$column2])">
					<xsl:value-of select="concat( 'Invalid Relationship Attribute (', $rname, ' = ', $entity1, ':', $column1, '->', $entity2, ':', $column2,')', $cr)"/>
				</xsl:if>
			</xsl:if>

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
						<xsl:otherwise><xsl:value-of select="concat( 'Invalid WTRELATIONSHIP/WTENTITY/WTATTRIBUTE Attribute (', name(), ')', $cr)"/></xsl:otherwise>
					</xsl:choose>
				</xsl:for-each>

				<!--NEW TEST attribute alias must be a defined in thid relationship-->
				<xsl:call-template name="ValidAlias">
					<xsl:with-param name="relationship" select="$rname"/>
					<xsl:with-param name="entity" select="$ename"/>
					<xsl:with-param name="alias" select="@alias"/>
				</xsl:call-template>

				<!--NEW TEST attribute related alias must be a defined in thid relationship-->
				<xsl:call-template name="ValidAlias">
					<xsl:with-param name="relationship" select="$rname"/>
					<xsl:with-param name="entity" select="$ename"/>
					<xsl:with-param name="alias" select="@relalias"/>
				</xsl:call-template>

			</xsl:for-each>
		</xsl:for-each>
	</xsl:for-each>

	<!--***********************************************************************************************-->
	<!--TEST APP Parent and Child Information-->

	<xsl:call-template name="ValidParents"><xsl:with-param name="entity" select="$entityname"/></xsl:call-template>
	<xsl:call-template name="ValidParentEnum"/>

<!--	
	<xsl:call-template name="ValidChildren"><xsl:with-param name="entity" select="$entityname"/></xsl:call-template>
-->
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
		<xsl:if test="count(/Data/WTENTITY/WTENUM[@type=preceding-sibling::WTENUM/@type])!=0">
			<xsl:value-of select="concat( 'All Enum Types are Not Unique',$cr)"/>
		</xsl:if>
		
	</xsl:if>

	<xsl:for-each select="/Data/WTENTITY/WTENUM[@type='find']/WTATTRIBUTE">
	
		<!--TEST valid attributes-->
		<xsl:for-each select="@*">
			<xsl:choose>
				<xsl:when test="name()='name'"/>
				<xsl:when test="name()='hidden'"/>
				<xsl:when test="name()='default'"/>
				<xsl:otherwise><xsl:value-of select="concat( 'Invalid Find WTENUM/WTATTRIBUTE Attribute (', name(), ')', $cr)"/></xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>

		<!--TEST each find WTENUM name to be a valid entity attribute-->
		<xsl:variable name="fename" select="@name"/>
		<xsl:if test="not(/Data/WTENTITY/WTATTRIBUTE[@name=$fename])">
			<xsl:value-of select="concat( 'Invalid Find Enum Attribute (', $fename, ')',$cr)"/>
		</xsl:if>
		
		<!--TEST each find WTENUM name to have a find procedure-->
		<xsl:variable name="fpname" select="concat( 'Find', $fename )"/>

		<!--TEST each find WTENUM name to have a find page datarow-->
		<xsl:if test="not(/Data/WTWEBPAGES/WTWEBPAGE[contains(@aspstyle,'Find')]/WTDATAROW/WTCONDITION[contains(@value,$fename)])">
			<xsl:value-of select="concat( 'Find Enum - Missing Find Page DataRow (', $fpname, ')',$cr)"/>
		</xsl:if>
		
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

		<!--TEST each list WTENUM name to be a valid entity attribute-->
		<xsl:variable name="lename" select="@name"/>
		<xsl:if test="not(/Data/WTENTITY/WTATTRIBUTE[@name=$lename])">
			<xsl:value-of select="concat( 'Invalid List Enum Attribute(', $lename, ')',$cr)"/>
		</xsl:if>

		<xsl:variable name="leentity" select="@entity"/>
		
		<xsl:choose>
			<xsl:when test="/Data/WTENTITIES/WTENTITY[@name=$leentity]">

				<!--TEST entity id-->
				<xsl:if test="/Data/WTENTITIES/WTENTITY[@name=$leentity]/@identity!=$lename">
					<xsl:value-of select="concat( 'Invalid List Enum Entity ID (', $leentity, ':', $lename,')',$cr)"/>
				</xsl:if>
				
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="concat( 'Invalid List Enum Entity (', $leentity,')',$cr)"/>
			</xsl:otherwise>
		</xsl:choose>

		<!--TEST each list WTENUM name to have a list procedure-->
		<xsl:variable name="lpname" select="concat( 'List', $lename )"/>

		<!--TEST each list WTENUM name to have a list page datarow-->
		<xsl:if test="not(/Data/WTWEBPAGES/WTWEBPAGE[contains(@aspstyle,'List')]/WTDATAROW/WTCONDITION[contains(@value,$lename)])">
			<xsl:value-of select="concat( 'List Enum - Missing List Page DataRow (', $lpname, ')',$cr)"/>
		</xsl:if>
		
		<!--TEST each list WTENUM name to have a list page owner link-->
		<xsl:if test="not(/Data/WTWEBPAGES/WTWEBPAGE[contains(@aspstyle,'List')]/WTLINK[@label='SYS(owner)' and @tag=$leentity])">
			<xsl:value-of select="concat( 'List Enum - Missing List Page Owner Link (', $leentity, ')',$cr)"/>
		</xsl:if>
		
	</xsl:for-each>
	
	<xsl:variable name="fecnt" select="count(/Data/WTENTITY/WTENUM[@type='find']/WTATTRIBUTE)"/>
	<xsl:if test="count(/Data/WTWEBPAGES/WTWEBPAGE[contains(@aspstyle,'Find')]/WTDATAROW) != $fecnt">
		<xsl:value-of select="concat( 'Number of Find Enum Attributes != Find Page Data Rows', $cr)"/>
	</xsl:if>

	<xsl:variable name="lecnt" select="count(/Data/WTENTITY/WTENUM[@type='list']/WTATTRIBUTE)"/>
	<xsl:if test="$lecnt > 1">
		<xsl:if test="count(/Data/WTWEBPAGES/WTWEBPAGE[contains(@aspstyle,'List')]/WTDATAROW) != $lecnt">
			<xsl:value-of select="concat( 'Number of List Enum Attributes != List Page Data Rows', $cr)"/>
		</xsl:if>
	</xsl:if>

	<xsl:if test="count(/Data/WTWEBPAGES/WTWEBPAGE[contains(@aspstyle,'List')]/WTLINK[@label='SYS(owner)']) != $lecnt">
		<xsl:value-of select="concat( 'Number of List Enum Attributes != List Page Owner Links', $cr)"/>
	</xsl:if>

	<!--***********************************************************************************************-->
	<!--TEST each find WTPROCEDURE-->
	<xsl:for-each select="/Data/WTPROCEDURES/WTPROCEDURE">
		<xsl:variable name="prname" select="@name"/>

		<!--TEST valid attributes-->
		<xsl:for-each select="@*">
			<xsl:choose>
				<xsl:when test="name()='type'"/>
				<xsl:when test="name()='name'"/>
				<xsl:when test="name()='style'"/>
				<xsl:when test="name()='column'"/>
				<xsl:when test="name()='proc'"/>
				<xsl:otherwise><xsl:value-of select="concat( 'Invalid Procedure Attribute (', name(), ')', $cr)"/></xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
		
		<xsl:for-each select="WTPROCEDURE">
			<!--TEST valid attributes-->
			<xsl:for-each select="@*">
				<xsl:choose>
					<xsl:when test="name()='name'"/>
					<xsl:when test="name()='position'"/>
					<xsl:otherwise><xsl:value-of select="concat( 'Invalid Procedure WTPROCEDURE Attribute (', name(), ')', $cr)"/></xsl:otherwise>
				</xsl:choose>
			</xsl:for-each>
		</xsl:for-each>

		<xsl:for-each select="WTPARAM">
			<!--TEST valid attributes-->
			<xsl:for-each select="@*">
				<xsl:choose>
					<xsl:when test="name()='name'"/>
					<xsl:when test="name()='entity'"/>
					<xsl:when test="name()='direction'"/>
					<xsl:when test="name()='value'"/>
					<xsl:when test="name()='secured'"/>
					<xsl:otherwise><xsl:value-of select="concat( 'Invalid Procedure WTPARAM Attribute (', name(), ')', $cr)"/></xsl:otherwise>
				</xsl:choose>
			</xsl:for-each>
			
			<xsl:if test="@entity">
				<xsl:variable name="pentityname" select="@entity"/>
				<xsl:if test="not(/Data/WTENTITIES/WTENTITY[@name=$pentityname])">
					<xsl:value-of select="concat( 'Invalid Procedure WTPARAM Entity! (', @prname, ':', @entity,')',$cr)"/>
				</xsl:if>
			</xsl:if>
			
			<xsl:if test="@name">
				<xsl:call-template name="ValidFunctionValue">
					<xsl:with-param name="name" select="@name"/>
					<xsl:with-param name="errtext">Procedure WTPARAM Name</xsl:with-param>
					<xsl:with-param name="errobj" select="$prname"/>
				</xsl:call-template>
			</xsl:if>
			<xsl:if test="@value">
				<xsl:call-template name="ValidFunctionValue">
					<xsl:with-param name="name" select="@value"/>
					<xsl:with-param name="errtext">Procedure WTPARAM Value</xsl:with-param>
					<xsl:with-param name="errobj" select="$prname"/>
				</xsl:call-template>
			</xsl:if>

			<!--TEST direction attribute-->
			<xsl:if test="@direction">
				<xsl:choose>
					<xsl:when test="@direction='input'"/>
					<xsl:when test="@direction='output'"/>
					<xsl:otherwise>
						<xsl:value-of select="concat( 'Invalid Procedure WTPARAM Direction! (', @prname, ':', @direction,')',$cr)"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:if>
			
		</xsl:for-each>

		<xsl:for-each select="WTJOIN">
			<!--TEST valid attributes-->
			<xsl:for-each select="@*">
				<xsl:choose>
					<xsl:when test="name()='name'"/>
					<xsl:otherwise><xsl:value-of select="concat( 'Invalid Procedure WTJOIN Attribute (', name(), ')', $cr)"/></xsl:otherwise>
				</xsl:choose>
			</xsl:for-each>
		</xsl:for-each>

		<xsl:for-each select="WTBOOKMARK">
			<!--TEST valid attributes-->
			<xsl:for-each select="@*">
				<xsl:choose>
					<xsl:when test="name()='name'"/>
					<xsl:otherwise><xsl:value-of select="concat( 'Invalid Procedure WTBOOKMARK Attribute (', name(), ')', $cr)"/></xsl:otherwise>
				</xsl:choose>
			</xsl:for-each>
		</xsl:for-each>

		<xsl:for-each select="WTORDER">
			<!--TEST valid attributes-->
			<xsl:for-each select="@*">
				<xsl:choose>
					<xsl:when test="name()='name'"/>
					<xsl:otherwise><xsl:value-of select="concat( 'Invalid Procedure WTORDER Attribute (', name(), ')', $cr)"/></xsl:otherwise>
				</xsl:choose>
			</xsl:for-each>
		</xsl:for-each>

		<xsl:if test="not(@type)">
			<xsl:value-of select="concat( 'Procedure Type Missing (', $prname, ')',$cr)"/>
		</xsl:if>
				
		<!--TEST each procedure join should not exist-->
		<xsl:if test="@join">
			<xsl:value-of select="concat( 'Unneccesary Procedure join attribute (', $prname, ':', @join, ')',$cr)"/>
		</xsl:if>
		
		<!--TEST each procedure WTJOIN must have a Relationship defined (except the primary entity - Delete() proc???)-->
		<xsl:if test="WTJOIN">
			<xsl:for-each select="WTJOIN">
				<xsl:variable name="prjoinname" select="@name"/>
				<xsl:if test="$prjoinname!=$entityname">
					<xsl:if test="not(/Data/WTENTITY/WTRELATIONSHIPS/WTRELATIONSHIP[@name=$prjoinname])">
						<xsl:value-of select="concat( 'Procedure WTJOIN Name missing Relationship (', $prname, ':', $prjoinname, ')',$cr)"/>
					</xsl:if>
				</xsl:if>
			</xsl:for-each>
		</xsl:if>
		
		<!--TEST each procedure WTPARENT-->
		<xsl:if test="WTPARENT">
			<xsl:for-each select="WTPARENT">
				<xsl:variable name="parname" select="@entity"/>
				<xsl:variable name="paridentity" select="@name"/>
				
				<!--TEST each procedure WTPARENT join must match a Parent name-->
				<xsl:if test="not(/Data/WTENTITY/WTPARENTS/WTPARENT[@entity=$parname])">
					<xsl:value-of select="concat( 'Procedure WTPARENT Name missing Parent Name (', $prname, ':', $parname, ')',$cr)"/>
				</xsl:if>
				
				<!--TEST each procedure WTPARENT join must match a Parent ID-->
				<xsl:if test="not(/Data/WTENTITY/WTPARENTS/WTPARENT[@entity=$parname and @id=$paridentity])">
					<xsl:value-of select="concat( 'Procedure WTPARENT Name Missing Parent ID (', $prname, ':', $paridentity, ')',$cr)"/>
				</xsl:if>
				
			</xsl:for-each>
		</xsl:if>

		<!--TEST the Find Procedures-->
		<xsl:if test="@type='Find'">


		</xsl:if>
		
		<xsl:if test="@type='List'">
		
			<xsl:choose>
				<xsl:when test="WTPARAM">

					<!--TEST each List procedure parameter name to match a List Enum-->
<!--
					<xsl:variable name="parmname" select="WTPARAM/@name"/>
					<xsl:if test="not(/Data/WTENTITY/WTENUM[@type='list']/WTATTRIBUTE[@name=$parmname])">
						<xsl:value-of select="concat( 'List Procedure Parameter - Missing List Enum (', $prname, ':', $parmname, ')', $cr)"/>
					</xsl:if>
-->
					<!--TEST each List procedure parameter name to match its Procedure name-->
<!--
					<xsl:variable name="lpname" select="concat( 'List', $parmname )"/>
					<xsl:if test="not(@name=$lpname)">
						<xsl:value-of select="concat( 'List Procedure Parameter - Mismatch Procedure Name (', $prname, ')', $cr)"/>
					</xsl:if>
-->
					<!--TEST each List procedure parameter name is a valid entity attribute-->
<!--
					<xsl:if test="not(/Data/WTENTITY/WTATTRIBUTE[@name=$parmname])">
						<xsl:value-of select="concat( 'Invalid Procedure Parameter Attribute (', $prname, ':', $parmname, ')', $cr)"/>
					</xsl:if>
-->
				</xsl:when>
				<xsl:otherwise>

					<!--TEST each List procedure name to be "List"-->
					<xsl:if test="$prname!='List'">
						<xsl:value-of select="concat( 'Invalid List Procedure Name (', $prname, ')', $cr)"/>
					</xsl:if>

				</xsl:otherwise>
			</xsl:choose>

			<xsl:if test="WTORDER">

				<!--TEST each List procedure order name is a valid entity attribute-->
				<xsl:variable name="oname" select="WTORDER/@name"/>
				<xsl:if test="not(/Data/WTENTITY/WTATTRIBUTE[@name=$oname])">
					<xsl:value-of select="concat( 'Invalid Procedure Order Attribute (', $prname, ':', $oname, ')', $cr)"/>
				</xsl:if>

			</xsl:if>

		</xsl:if>

	</xsl:for-each>

	<!--***********************************************************************************************-->
	<!--TEST each WTWEBPAGE-->
	<xsl:for-each select="/Data/WTWEBPAGES">

		<xsl:if test="count(WTWEBPAGE[contains(@aspstyle,'Find')]) > 1">
			<xsl:value-of select="concat( 'Only One Find Page Allowed',$cr)"/>
		</xsl:if>
		
		<xsl:if test="count(WTWEBPAGE[contains(@aspstyle,'List')]) > 1">
			<xsl:value-of select="concat( 'Only One List Page Allowed',$cr)"/>
		</xsl:if>
		
		<xsl:for-each select="WTWEBPAGE">
			<xsl:variable name="wpname" select="@name"/>
			
			<!--TEST valid attributes-->
			<xsl:for-each select="@*">
				<xsl:choose>
					<xsl:when test="name()='name'"/>
					<xsl:when test="name()='aspstyle'"/>
					<xsl:when test="name()='xslstyle'"/>
					<xsl:when test="name()='secured'"/>
<!--
					<xsl:when test="name()='hidden'"/>
-->
					<xsl:otherwise><xsl:value-of select="concat( 'Invalid WTWEBPAGE Attribute (', $wpname, ':', name(), ')', $cr)"/></xsl:otherwise>
				</xsl:choose>
			</xsl:for-each>

			<xsl:for-each select="WTHEADER">
				<!--TEST valid attributes-->
				<xsl:for-each select="@*">
					<xsl:choose>
						<xsl:when test="name()='title'"/>
						<xsl:when test="name()='tag'"/>
						<xsl:otherwise><xsl:value-of select="concat( 'Invalid WebPage WTHEADER Attribute (', $wpname, ':', name(), ')', $cr)"/></xsl:otherwise>
					</xsl:choose>
				</xsl:for-each>

				<xsl:if test="@title">
					<xsl:call-template name="ValidFunctionValue">
						<xsl:with-param name="name" select="@title"/>
						<xsl:with-param name="errtext">WebPage WTHEADER Title</xsl:with-param>
						<xsl:with-param name="errobj" select="$wpname"/>
						<xsl:with-param name="testattr" select="false()"/>
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="@tag">
					<xsl:call-template name="ValidFunctionValue">
						<xsl:with-param name="name" select="@tag"/>
						<xsl:with-param name="errtext">WebPage WTHEADER Tag</xsl:with-param>
						<xsl:with-param name="errobj" select="$wpname"/>
						<xsl:with-param name="testattr" select="false()"/>
					</xsl:call-template>
				</xsl:if>
				
			</xsl:for-each>

			<xsl:for-each select="WTCONDITION">
				<!--TEST valid attributes-->
				<xsl:for-each select="@*">
					<xsl:choose>
						<xsl:when test="name()='name'"/>
						<xsl:when test="name()='column'"/>
						<xsl:when test="name()='secured'"/>
<!--
						<xsl:when test="name()='current'"/>
-->
						<xsl:otherwise><xsl:value-of select="concat( 'Invalid WebPage WTCONDITION Attribute (', $wpname, ':', name(), ')', $cr)"/></xsl:otherwise>
					</xsl:choose>
				</xsl:for-each>
			</xsl:for-each>

			<xsl:for-each select="WTLINK">
				<!--TEST valid attributes-->
				<xsl:for-each select="@*">
					<xsl:choose>
						<xsl:when test="name()='page'"/>
						<xsl:when test="name()='name'"/>
						<xsl:when test="name()='entity'"/>
						<xsl:when test="name()='hidden'"/>
						<xsl:when test="name()='location'"/>
						<xsl:when test="name()='target'"/>
						<xsl:when test="name()='newline'"/>
						<xsl:when test="name()='tag'"/>
						<xsl:when test="name()='label'"/>
						<xsl:otherwise><xsl:value-of select="concat( 'Invalid WebPage WTLINK Attribute (', $wpname, ':', name(), ')', $cr)"/></xsl:otherwise>
					</xsl:choose>
				</xsl:for-each>

				<xsl:for-each select="WTPARAM">
					<!--TEST valid attributes-->
					<xsl:for-each select="@*">
						<xsl:choose>
							<xsl:when test="name()='name'"/>
							<xsl:when test="name()='value'"/>
							<xsl:when test="name()='entity'"/>
							<xsl:otherwise><xsl:value-of select="concat( 'Invalid WebPage Link WTPARAM Attribute (', $wpname, ':', name(), ')', $cr)"/></xsl:otherwise>
						</xsl:choose>
					</xsl:for-each>
					
					<xsl:if test="@name">
						<xsl:call-template name="ValidFunctionValue">
							<xsl:with-param name="name" select="@name"/>
							<xsl:with-param name="errtext">WebPage Link WTPARAM Name</xsl:with-param>
							<xsl:with-param name="errobj" select="$wpname"/>
							<xsl:with-param name="testattr" select="false()"/>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="@value">
						<xsl:call-template name="ValidFunctionValue">
							<xsl:with-param name="name" select="@value"/>
							<xsl:with-param name="errtext">WebPage Link WTPARAM Value</xsl:with-param>
							<xsl:with-param name="errobj" select="$wpname"/>
						</xsl:call-template>
					</xsl:if>
					
				</xsl:for-each>

				<xsl:for-each select="WTCONDITION">
					<!--TEST valid attributes-->
					<xsl:for-each select="@*">
						<xsl:choose>
							<xsl:when test="name()='expr'"/>
							<xsl:when test="name()='oper'"/>
							<xsl:when test="name()='value'"/>
							<xsl:when test="name()='connector'"/>
							<xsl:otherwise><xsl:value-of select="concat( 'Invalid WebPage Link WTCONDITION Attribute (', $wpname, ':', name(), ')', $cr)"/></xsl:otherwise>
						</xsl:choose>
					</xsl:for-each>

					<xsl:if test="@expr">
						<xsl:call-template name="ValidFunctionValue">
							<xsl:with-param name="name" select="@expr"/>
							<xsl:with-param name="errtext">WebPage Link WTCONDITION Expression</xsl:with-param>
							<xsl:with-param name="errobj" select="$wpname"/>
							<xsl:with-param name="testattr" select="false()"/>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="@value">
						<xsl:call-template name="ValidFunctionValue">
							<xsl:with-param name="name" select="@value"/>
							<xsl:with-param name="errtext">WebPage Link WTCONDITION Value</xsl:with-param>
							<xsl:with-param name="errobj" select="$wpname"/>
							<xsl:with-param name="testattr" select="false()"/>
						</xsl:call-template>
					</xsl:if>

					<!--TEST connector attribute-->
					<xsl:if test="@connector">
						<xsl:choose>
							<xsl:when test="@connector='and'"/>
							<xsl:when test="@connector='or'"/>
							<xsl:otherwise>
								<xsl:value-of select="concat( 'Invalid WebPage Link WTCONDITION Connector! (', $wpname, ':', @connector,')',$cr)"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:if>
			
				</xsl:for-each>
			</xsl:for-each>

			<!--TEST valid attributes-->
			<xsl:for-each select="WTLIST">
				<xsl:for-each select="@*">
					<xsl:choose>
						<xsl:when test="name()='type'"/>
						<xsl:when test="name()='entity'"/>
						<xsl:when test="name()='page'"/>
						<xsl:when test="name()='new'"/>
						<xsl:when test="name()='position'"/>
						<xsl:when test="name()='hidden'"/>
						<xsl:when test="name()='newhidden'"/>
						<xsl:otherwise><xsl:value-of select="concat( 'Invalid WebPage WTLIST Attribute (', $wpname, ':', name(), ')', $cr)"/></xsl:otherwise>
					</xsl:choose>
				</xsl:for-each>
			</xsl:for-each>

			<xsl:for-each select="WTACTION">
				<!--TEST valid attributes-->
				<xsl:for-each select="@*">
					<xsl:choose>
						<xsl:when test="name()='name'"/>
						<xsl:when test="name()='type'"/>
						<xsl:when test="name()='id'"/>
						<xsl:when test="name()='style'"/>
						<xsl:when test="name()='hidden'"/>
						<xsl:otherwise><xsl:value-of select="concat( 'Invalid WebPage WTACTION Attribute (', $wpname, ':', name(), ')', $cr)"/></xsl:otherwise>
					</xsl:choose>
				</xsl:for-each>
			</xsl:for-each>

			<xsl:for-each select="WTDATAROW">
				<!--TEST valid attributes-->
				<xsl:for-each select="@*">
					<xsl:choose>
						<xsl:when test="name()='repeat'"/>
						<xsl:when test="name()='graybar'"/>
						<xsl:otherwise><xsl:value-of select="concat( 'Invalid WebPage WTDATAROW Attribute (', $wpname, ':', name(), ')', $cr)"/></xsl:otherwise>
					</xsl:choose>
				</xsl:for-each>

				<xsl:for-each select="WTCONDITION">
					<!--TEST valid attributes-->
					<xsl:for-each select="@*">
						<xsl:choose>
							<xsl:when test="name()='name'"/>
							<xsl:when test="name()='value'"/>
							<xsl:when test="name()='expr'"/>
							<xsl:when test="name()='oper'"/>
							<xsl:otherwise><xsl:value-of select="concat( 'Invalid WebPage DataRow WTCONDITION Attribute (', $wpname, ':', name(), ')', $cr)"/></xsl:otherwise>
						</xsl:choose>
					</xsl:for-each>

					<xsl:if test="@expr">
						<xsl:call-template name="ValidFunctionValue">
							<xsl:with-param name="name" select="@expr"/>
							<xsl:with-param name="errtext">WebPage DataRow WTCONDITION Expression</xsl:with-param>
							<xsl:with-param name="errobj" select="$wpname"/>
							<xsl:with-param name="testattr" select="false()"/>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="@value">
						<xsl:call-template name="ValidFunctionValue">
							<xsl:with-param name="name" select="@value"/>
							<xsl:with-param name="errtext">WebPage DataRow WTCONDITION Value</xsl:with-param>
							<xsl:with-param name="errobj" select="$wpname"/>
							<xsl:with-param name="testattr" select="false()"/>
						</xsl:call-template>
					</xsl:if>

					<!--TEST connector attribute-->
					<xsl:if test="@oper">
						<xsl:choose>
							<xsl:when test="@oper='equal'"/>
							<xsl:otherwise>
								<xsl:value-of select="concat( 'Invalid WebPage DataRow WTCONDITION Operator! (', $wpname, ':', @oper,')',$cr)"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:if>

				</xsl:for-each>

				<xsl:for-each select="WTATTRIBUTE">
					<!--TEST valid attributes-->
					<xsl:for-each select="@*">
						<xsl:choose>
							<xsl:when test="name()='name'"/>
							<xsl:when test="name()='width'"/>
							<xsl:when test="name()='class'"/>
							<xsl:when test="name()='hidden'"/>
							<xsl:otherwise><xsl:value-of select="concat( 'Invalid WebPage DataRow WTATTRIBUTE Attribute (', $wpname, ':', name(), ')', $cr)"/></xsl:otherwise>
						</xsl:choose>
					</xsl:for-each>
					
					<xsl:variable name="wpaname" select="@name"/>
					<xsl:if test="not(/Data/WTENTITY/WTATTRIBUTE[@name=$wpaname])">
							<xsl:value-of select="concat( 'Invalid WebPage Datarow Attribute Name (', $wpname, ':', $wpaname, ')',$cr)"/>
					</xsl:if>
					
				</xsl:for-each>

			</xsl:for-each>

			<!--TEST each web page for valid secured user group-->
			<xsl:if test="@secured">
				<xsl:variable name="secured" select="@secured"/>
				<xsl:if test="not(/Data/WTUSERGROUPS/WTUSERGROUP[@id=$secured])">
					<xsl:value-of select="concat( 'Web Page Secured User Group Number Not Valid (', @name, ':', $secured, ')',$cr)"/>
				</xsl:if>
			</xsl:if>

			<!--TEST each web page number to be in the same series as the entity id-->
			<xsl:if test="floor(@name div 100)!=$id">
				<xsl:value-of select="concat( 'Web Page Number Not in same series as the Entity ID (', @name, ')',$cr)"/>
			</xsl:if>

			<!--TEST each Find web page number to be xx01-->
			<xsl:if test="contains(@aspstyle, 'Find')">
				<xsl:if test="@name mod 100!=1">
					<xsl:value-of select="concat( 'Find Web Page Number Not ending in 01 (', @name, ')',$cr)"/>
				</xsl:if>
			</xsl:if>

			<!--TEST each Add web page number to be xx02-->
			<xsl:if test="contains(@aspstyle, 'Add')">
				<xsl:if test="@name mod 100!=2">
					<xsl:value-of select="concat( 'Add Web Page Number Not ending in 02 (', @name, ')',$cr)"/>
				</xsl:if>
			</xsl:if>

			<!--TEST each Item web page number to be xx03-->
			<xsl:if test="contains(@aspstyle, 'Item')">
				<xsl:if test="@name mod 100!=3">
					<xsl:value-of select="concat( 'Item Web Page Number Not ending in 03 (', @name, ')',$cr)"/>
				</xsl:if>
			</xsl:if>

			<!--TEST each List web page number to be xx11-->
			<xsl:if test="contains(@aspstyle, 'List')">
			
				<xsl:if test="@name mod 100!=11">
					<xsl:value-of select="concat( 'List Web Page Number Not ending in 11 (', @name, ')',$cr)"/>
				</xsl:if>
				
				<!--TEST if this list page has no list enums-->
				<xsl:if test="count(/Data/WTENTITY/WTENUM[@type='list']/WTATTRIBUTE)=0">
				
					<!--TEST Must have One Data Row-->
					<xsl:if test="count(WTDATAROW)=0">
						<xsl:value-of select="concat( 'List Web Page must have exactly One Data Row (', @name, ')',$cr)"/>
					</xsl:if>
					
					<!--TEST No Condition Allowed-->
					<xsl:if test="count(WTDATAROW/WTCONDITION)>0">
						<xsl:value-of select="concat( 'List Web Page Data Row Condition Not Allowed (', @name, ')',$cr)"/>
					</xsl:if>
					
				</xsl:if>
				
			</xsl:if>

			<!--TEST each Web Page Attribute to be a valid entity attribute-->
			<xsl:for-each select="WTATTRIBUTE">
			
				<!--TEST valid attributes-->
				<xsl:if test="@name">
					<xsl:for-each select="@*">
						<xsl:choose>
							<xsl:when test="name()='name'"/>
							<xsl:when test="name()='hidden'"/>
							<xsl:when test="name()='protected'"/>
							<xsl:when test="name()='rows'"/>
							<xsl:when test="name()='label'"/>
							<xsl:when test="name()='datalabel'"/>
							<xsl:otherwise><xsl:value-of select="concat( 'Invalid WTWEBPAGE/WTATTRIBUTE Name Attribute (', @name, ':', name(), ')', $cr)"/></xsl:otherwise>
						</xsl:choose>
					</xsl:for-each>
				</xsl:if>

				<!--TEST valid attributes-->
				<xsl:if test="@type='separator'">
					<xsl:for-each select="@*">
						<xsl:choose>
							<xsl:when test="name()='type'"/>
							<xsl:when test="name()='column'"/>
							<xsl:when test="name()='width'"/>
							<xsl:when test="name()='height'"/>
							<xsl:when test="name()='size'"/>
							<xsl:when test="name()='align'"/>
							<xsl:when test="name()='hidden'"/>
							<xsl:otherwise><xsl:value-of select="concat( 'Invalid WTWEBPAGE/WTATTRIBUTE Separator Attribute (', @name, ':', name(), ')', $cr)"/></xsl:otherwise>
						</xsl:choose>
					</xsl:for-each>
				</xsl:if>

				<!--TEST valid attributes-->
				<xsl:if test="@type='blank'">
					<xsl:for-each select="@*">
						<xsl:choose>
							<xsl:when test="name()='type'"/>
							<xsl:when test="name()='height'"/>
							<xsl:when test="name()='hidden'"/>
							<xsl:otherwise><xsl:value-of select="concat( 'Invalid WTWEBPAGE/WTATTRIBUTE Blank Attribute (', @name, ':', name(), ')', $cr)"/></xsl:otherwise>
						</xsl:choose>
					</xsl:for-each>
				</xsl:if>

				<!--TEST valid attributes-->
				<xsl:if test="@type='label'">
					<xsl:for-each select="@*">
						<xsl:choose>
							<xsl:when test="name()='type'"/>
							<xsl:when test="name()='label'"/>
							<xsl:when test="name()='column'"/>
							<xsl:when test="name()='class'"/>
							<xsl:when test="name()='height'"/>
							<xsl:when test="name()='align'"/>
							<xsl:when test="name()='valign'"/>
							<xsl:when test="name()='hidden'"/>
							<xsl:otherwise><xsl:value-of select="concat( 'Invalid WTWEBPAGE/WTATTRIBUTE Separator Attribute (', @name, ':', name(), ')', $cr)"/></xsl:otherwise>
						</xsl:choose>
					</xsl:for-each>
				</xsl:if>

				<!--TEST each web page attribute for valid hidden user group-->
				<xsl:if test="@hidden">
					<xsl:variable name="hidden" select="@hidden"/>
					<xsl:if test="not(/Data/WTUSERGROUPS/WTUSERGROUP[@id=$hidden])">
						<xsl:value-of select="concat( 'Web Page Attribute Hidden User Group Number Not Valid (', $wpname, ':', @name, ':', $hidden, ')',$cr)"/>
					</xsl:if>
				</xsl:if>

				<!--TEST each web page attribute for valid protected user group-->
				<xsl:if test="@protected">
					<xsl:variable name="protected" select="@protected"/>
					<xsl:if test="not(/Data/WTUSERGROUPS/WTUSERGROUP[@id=$protected])">
						<xsl:value-of select="concat( 'Web Page Attribute Protected User Group Number Not Valid (', $wpname, ':', @name, ':', $protected, ')',$cr)"/>
					</xsl:if>
				</xsl:if>

				<!--TEST each Web Page Attribute-->
				<xsl:choose>
					<xsl:when test="@type">
						<!--TEST attribute type-->
						<xsl:choose>
							<xsl:when test="@type='separator'"/>
							<xsl:when test="@type='blank'"/>
							<xsl:when test="@type='label'">
								<xsl:if test="not(@label)">
									<xsl:value-of select="concat( 'Web Page Attribute Type requires a Label (', $wpname, ':', @type, ')', $cr)"/>
								</xsl:if>
							</xsl:when>
							<xsl:when test="@type='list'"/>
							<xsl:when test="@type='enum'"/>
							<xsl:otherwise>
								<xsl:value-of select="concat( 'Invalid Attribute Type (', $wpname, ':', @type, ')', $cr)"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
						<!--TEST each Web Page Attribute to be a valid entity attribute-->
						<xsl:variable name="wpaname" select="@name"/>
						<xsl:choose>
							<xsl:when test="not(/Data/WTENTITY/WTATTRIBUTE[@name=$wpaname])">
									<xsl:value-of select="concat( 'Invalid Web Page Attribute Name (', $wpname, ':', $wpaname, ')',$cr)"/>
							</xsl:when>
							<xsl:otherwise>
							
								<!--TEST each Add Web Page Attribute to not be a Initialized entity attribute-->
								<xsl:if test="contains(../@aspstyle, 'Add')">
									<xsl:if test="/Data/WTENTITY/WTATTRIBUTE[@name=$wpaname]/WTINIT">
										<xsl:value-of select="concat( 'Add Web Page Cannot include an Initialized Attribute (', $wpname, ':', $wpaname, ')',$cr)"/>
									</xsl:if>
								</xsl:if>
								
							</xsl:otherwise>
						</xsl:choose>
					</xsl:otherwise>
				</xsl:choose>

			</xsl:for-each>
			
			<!--TEST each Web Page Link to be a valid entity and page number-->
			<!--TEST each WTLINK-->
			<xsl:for-each select="WTLINK">
			
				<!--TEST valid attributes-->
				<xsl:for-each select="@*">
					<xsl:choose>
						<xsl:when test="name()='name'"/>
						<xsl:when test="name()='location'"/>
						<xsl:when test="name()='tag'"/>
						<xsl:when test="name()='label'"/>
						<xsl:when test="name()='target'"/>
						<xsl:when test="name()='newline'"/>
						<xsl:otherwise><xsl:value-of select="concat( 'Invalid WTWEBPAGE/WTLINK Attribute (', @name, ':', name(), ')', $cr)"/></xsl:otherwise>
					</xsl:choose>
				</xsl:for-each>
			
				<xsl:variable name="lentity" select="@entity"/>
				<xsl:variable name="lname" select="@name"/>
				
				<!--TEST each web page link for valid hidden user group-->
				<xsl:if test="@hidden">
					<xsl:variable name="hidden" select="@hidden"/>
					<xsl:if test="not(/Data/WTUSERGROUPS/WTUSERGROUP[@id=$hidden])">
						<xsl:value-of select="concat( 'Web Page Link Hidden User Group Number Not Valid (', $wpname, ':', @name, ':', $hidden, ')',$cr)"/>
					</xsl:if>
				</xsl:if>

				<!--TEST each Web Page Link to be a valid page number for the linked entity-->
				<xsl:variable name="lid" select="/Data/WTENTITIES/WTENTITY[@name=$lentity]/@number"/>
				<xsl:if test="floor($lname div 100)!=$lid">
					<xsl:value-of select="concat( 'Web Page Link Number Does Not match Linked Entity (', $lentity, ':', $lname,')',$cr)"/>
				</xsl:if>
				
				<!--TEST link page type-->
<!--
				<xsl:choose>
					<xsl:when test="@page='custom'"/>
					<xsl:when test="@page='item'"/>
					<xsl:when test="@page='list'"/>
					<xsl:when test="@page='owner'"/>
					<xsl:when test="@page='new'"/>
					<xsl:when test="@page='parent'"/>
					<xsl:otherwise>
						<xsl:value-of select="concat( 'Invalid Web Page Link Type (', $wpname, ':', @page, ')', $cr)"/>
					</xsl:otherwise>
				</xsl:choose>
-->			
				<!--TEST non-custom link-->
				<xsl:if test="not(@page='custom')">
				
					<!--TEST each Web Page Link to be a valid entity-->
<!--
					<xsl:if test="not(/Data/WTENTITIES/WTENTITY[@name=$lentity])">
						<xsl:value-of select="concat( 'Invalid Web Page Link Entity (', $wpname, ':', $lentity,')',$cr)"/>
					</xsl:if>
-->					
					<!--TEST only a custom link can have WTPARAM-->
<!--
					<xsl:if test="WTPARAM">
						<xsl:value-of select="concat( 'Web Page Link Unnecessary WTPARAM (', $wpname, ':', @page,')',$cr)"/>
					</xsl:if>
-->
					<!--TEST only a custom link can have a Location-->
<!--
					<xsl:if test="@location">
						<xsl:value-of select="concat( 'Web Page Link Unnecessary Location (', $wpname, ':', @location,')',$cr)"/>
					</xsl:if>
-->
					<!--TEST only a custom link can have a Target-->
<!--
					<xsl:if test="@target">
						<xsl:value-of select="concat( 'Web Page Link Unnecessary Target (', $wpname, ':', @target,')',$cr)"/>
					</xsl:if>
-->
				</xsl:if>

				<!--TEST custom link -->
				<xsl:if test="@page='custom'">

					<!--TEST each custom Link to have a Location-->
					<xsl:if test="not(@location)">
							<xsl:value-of select="concat( 'Web Page Custom Link Missing Location (', $wpname, ')',$cr)"/>
					</xsl:if>

					<xsl:for-each select="WTPARAM">

						<!--TEST each Link Parameter Value to be a valid entity attribute-->
<!--
						<xsl:variable name="parattr" select="@value"/>
						<xsl:if test="not(/Data/WTENTITY/WTATTRIBUTE[@name=$parattr])">
								<xsl:value-of select="concat( 'Invalid Web Page Link Parameter Value (', $wpname, ':', $parattr, ')',$cr)"/>
						</xsl:if>
-->
						<!--TEST each Link Parameter Entity to be a valid entity in the APP-->
						<xsl:variable name="parentity" select="@entity"/>
						<xsl:if test="not(/Data/WTENTITIES/WTENTITY[@name=$parentity])">
								<xsl:value-of select="concat( 'Invalid Web Page Link Parameter Entity (', $wpname, ':', $parentity, ')',$cr)"/>
						</xsl:if>

					</xsl:for-each>

				</xsl:if>

				<xsl:if test="@page='new'">
				
					<!--TEST a new link can only add for the primary entity-->
					<xsl:if test="@entity!=$entityname">
						<xsl:value-of select="concat( 'Invalid Web Page Add Link (', $wpname, ':', @page,')',$cr)"/>
					</xsl:if>
					
					<!--TEST a new(Add) link must have a corresponding parent link-->
					<xsl:variable name="parent" select="/Data/WTRELATIONSHIPS/WTRELATIONSHIP[@entity=$entityname and @parent]/@relentity"/>
					<xsl:if test="$parent">
						<xsl:if test="not(../WTLINK[@page='owner' and @entity=$parent]/@entity)">
							<xsl:value-of select="concat( 'Web Page Add Link Requires Owner Link to Parent (', $wpname, ':', $parent,')',$cr)"/>
						</xsl:if>
					</xsl:if>

				</xsl:if>
				
				<xsl:if test="@page='owner'">
				
					<!--TEST a owner link must match a List Enum Attribute-->
					<xsl:variable name="oentity" select="@entity"/>
					<xsl:if test="not(/Data/WTENTITY/WTENUM[@type='list']/WTATTRIBUTE[@entity=$oentity])">
						<xsl:value-of select="concat( 'Web Page Owner Link - Missing List Enum (', $wpname, ':', $oentity, ')',$cr)"/>
					</xsl:if>

				</xsl:if>
				
			</xsl:for-each>

			<!--TEST each Find and List Page column widths to add up to 100-->
			<xsl:for-each select="WTDATAROW">
				<xsl:variable name="datarow" select="position()"/>
				<xsl:if test="WTATTRIBUTE[@width]">
					<xsl:if test="sum(WTATTRIBUTE/@width)!=100">
						<xsl:value-of select="concat( 'Web Page Column Widths Not 100% (', $wpname, '-DataRow:', $datarow, ':', sum(WTATTRIBUTE/@width),'%)',$cr)"/>
					</xsl:if>
				</xsl:if>
			</xsl:for-each>

		</xsl:for-each>

	</xsl:for-each>

</xsl:template>

<!--***********************************************************************************************-->
<!--TEST value in function ATTR(), SYS(), DATA(), CONST(), FINDID(), LISTID(), PARAM() -->
<xsl:template name="ValidFunctionValue">
	<xsl:param name="name"/>
	<xsl:param name="errtext"/>
	<xsl:param name="errobj"/>
	<xsl:param name="testattr" select="true()"/>

	<xsl:choose>
		<xsl:when test="substring($name, 1, 5)='ATTR('">
			<xsl:variable name="nam" select="substring($name, 6, string-length($name)-6)"/>
			<!-- name may contain # (wildcard) or . (contact.contactid) -->
			<xsl:if test="not( $nam='#' or contains($nam,'.') )">
				<xsl:if test="not(/Data/WTENTITY/WTATTRIBUTE[@name=$nam])">
					<xsl:value-of select="concat( 'Invalid ', $errtext, ' (', $errobj, ':', $nam, ')',$cr)"/>
				</xsl:if>
			</xsl:if>
		</xsl:when>
		
		<xsl:when test="substring($name, 1, 4)='SYS('">
			<xsl:variable name="nam" select="substring($name, 5, string-length($name)-5)"/>
			<xsl:choose>
				<xsl:when test="$nam='userid'"/>
				<xsl:when test="$nam='usergroup'"/>
				<xsl:when test="$nam='owner'"/>
				<xsl:when test="$nam='ownerid'"/>
				<xsl:when test="$nam='ownertitle'"/>
				<xsl:when test="$nam='searchtype'"/>
				<xsl:when test="$nam='listtype'"/>
				<xsl:otherwise><xsl:value-of select="concat( $errtext, ' is Not a valid System Value (', $errobj, ':', $nam, ')',$cr)"/></xsl:otherwise>
			</xsl:choose>
		</xsl:when>
		
		<xsl:when test="substring($name, 1, 5)='DATA('">
			<!-- name must start with @ -->
			<xsl:if test="not(substring($name, 1, 6)='DATA(@')">
				<xsl:value-of select="concat( 'DATA Missing @ - ', $errtext, ' (', $errobj, ':', $name, ')',$cr)"/>
			</xsl:if>
		</xsl:when>

		<xsl:when test="substring($name, 1, 6)='CONST('"/>
		<xsl:when test="substring($name, 1, 7)='FINDID('"/>
		<xsl:when test="substring($name, 1, 7)='LISTID('"/>
		<xsl:when test="substring($name, 1, 6)='PARAM('"/>
		
		<xsl:otherwise>
			<xsl:choose>
				<!-- test if we have an invalid function -->
				<xsl:when test="contains($name, '(' )">
					<xsl:value-of select="concat( 'Invalid Function - ', $errtext, ' (', $errobj, ':', $name, ')',$cr)"/>
				</xsl:when>
				<xsl:otherwise>
				
					<!-- if their is no function, should we test for a valid attribute? -->
					<xsl:if test="$testattr">
						<xsl:choose>
							<xsl:when test="$name='UserID'"/>
							<xsl:when test="$name='mNewID'"/>
							<xsl:otherwise>
								<xsl:if test="not(/Data/WTENTITY/WTATTRIBUTE[@name=$name])">
									<xsl:value-of select="concat( 'Invalid ', $errtext, ' (', $errobj, ':', $name, ')',$cr)"/>
								</xsl:if>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:if>
				
				</xsl:otherwise>
			</xsl:choose>
		</xsl:otherwise>

	</xsl:choose>
	
</xsl:template>
	
<!--***********************************************************************************************-->
<!--TEST that all Parents are defined and have a DeleteChild Procedure-->
<xsl:template name="ValidParents">
	<xsl:param name="entity"/>
	<xsl:param name="step">1</xsl:param>

	<xsl:if test="/Data/WTRELATIONSHIPS/WTRELATIONSHIP[@entity=$entity and @parent]">
		<xsl:for-each select="/Data/WTRELATIONSHIPS/WTRELATIONSHIP[@entity=$entity and @parent]">
				
			<xsl:if test="$step > 1">

				<!--TEST if the Parent is define in WTPARENTS-->
				<xsl:if test="not(/Data/WTENTITY/WTPARENTS/WTPARENT[@entity=$entity])">
					<xsl:value-of select="concat( 'Parent Not Defined (', $entity ,')',$cr)"/>
				</xsl:if>

				<!--TEST if the Parent has a DeleteChild Procedure-->
				<xsl:if test="not(/Data/WTPROCEDURES/WTPROCEDURE[@type='DeleteChild']/WTPARAM[@entity=$entity])">
					<xsl:value-of select="concat( 'Parent Missing DeleteChild Procedure (', $entity ,')',$cr)"/>
				</xsl:if>

			</xsl:if>

			<xsl:if test="not(@nodisplay)">
				<xsl:call-template name="ValidParents">
					<xsl:with-param name="entity" select="@relentity"/>
					<xsl:with-param name="step" select="$step+1"/>
				</xsl:call-template>
			</xsl:if>
					
		</xsl:for-each>
	</xsl:if>

</xsl:template>

<!--***********************************************************************************************-->
<xsl:template name="ValidParentEnum">

	<xsl:for-each select="/Data/WTENTITY/WTPARENTS/WTPARENT">
		<xsl:variable name="identity" select="@id"/>
		<xsl:variable name="title" select="@title"/>

			<!--TEST if the Parent identity is defined in Attributes-->
			<xsl:choose>
			
				<xsl:when test="not(/Data/WTENTITY/WTATTRIBUTE[@name=$identity])">
					<xsl:value-of select="concat( 'Parent Identity Attribute Not Defined (', @entity, ':', $identity,')',$cr)"/>
				</xsl:when>
				<xsl:otherwise>
				
					<!--TEST that all grandparent's identity attributes have a join source-->
					<xsl:if test="position() != last()">
						<xsl:if test="not(/Data/WTENTITY/WTATTRIBUTE[@name=$identity]/@source='join')">
							<xsl:value-of select="concat( 'Parent Identity Attribute must have a Join Source (', @entity, ':', $identity,')',$cr)"/>
						</xsl:if>
					</xsl:if>
					
				</xsl:otherwise>
			</xsl:choose>

		<!--TEST if the Parent title are defined in Attributes-->
		<xsl:choose>
			
			<xsl:when test="not(/Data/WTENTITY/WTATTRIBUTE[@name=$title])">
				<xsl:value-of select="concat( 'Parent Title Attribute Not Defined (', @entity, ':', $title,')',$cr)"/>

			</xsl:when>
			<xsl:otherwise>

				<!--TEST that all parent's title attributes have a join source-->
				<xsl:if test="not(/Data/WTENTITY/WTATTRIBUTE[@name=$title]/@source='join')">
					<xsl:value-of select="concat( 'Parent Title Attribute must have a Join Source (', @entity, ':', $identity, ':', $title,')',$cr)"/>
				</xsl:if>
					
			</xsl:otherwise>
		</xsl:choose>

	</xsl:for-each>

</xsl:template>

<!--***********************************************************************************************-->
<!--TEST that all Children are defined and have a Delete Procedure-->
<xsl:template name="ValidChildren">
	<xsl:param name="entity"/>

	<xsl:for-each select="/Data/WTRELATIONSHIPS/WTRELATIONSHIP[@relentity=$entity and @parent]">
		<xsl:variable name="rentity" select="@entity"/>

		<!--TEST if the Child is define in WTRELATIONSHIPS-->
		<xsl:if test="not(/Data/WTENTITY/WTRELATIONSHIPS/WTRELATIONSHIP[@entity=$rentity])">
			<xsl:value-of select="concat( 'Child Relationship Not defined (', $rentity ,')',$cr)"/>
		</xsl:if>

		<!--TEST if the Parent has a DeleteChild Procedure-->
		<xsl:if test="not(/Data/WTPROCEDURES/WTPROCEDURE[@type='Delete']/WTCASCADE[@entity=$rentity])">
			<xsl:value-of select="concat( 'Child Missing Delete Procedure (', $rentity ,')',$cr)"/>
		</xsl:if>

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
		<xsl:if test="not(/Data/WTENTITY/WTRELATIONSHIPS/WTRELATIONSHIP[@name=$relationship]/WTENTITY[@alias=$alias])">
			<xsl:value-of select="concat( 'Relationship WTENTITY alias Not defined (', $relationship, ':', $entity, ':', $alias ,')',$cr)"/>
		</xsl:if>
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

