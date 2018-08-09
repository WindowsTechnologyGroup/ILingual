<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:include href="GenerateInclude.xsl"/>
<!--===============================================================================
	Auth: Bob Wood
	Date: January 28, 2001
	Desc: Transforms an Entity Definition and the Global Relationships to Entity Relationships 
	Copyright 2001 WinTech, Inc.
===================================================================================-->
	<xsl:template match="/">
		<REL><xsl:apply-templates/></REL>
	</xsl:template>

	<xsl:template match="Data/WTENTITY">

		<xsl:value-of select="concat($tab0, '&lt;WTROOT&gt;', $cr)"/>
		<xsl:value-of select="concat($tab1, '&lt;WTRELATIONSHIPS&gt;', $cr)"/>

		<!-- save the primary entity that we are processing -->
		<xsl:variable name="alias" select="/Data/WTENTITIES/WTENTITY[@name=$entityname]/@alias"/>
		<xsl:variable name="identity" select="/Data/WTENTITIES/WTENTITY[@name=$entityname]/@identity"/>

		<!--Get a unique list of non-custom WTJOIN entities-->
		<xsl:for-each select="WTATTRIBUTE/WTJOIN[ not(@custom) and not(@entity=preceding::WTATTRIBUTE/WTJOIN/@entity)]">
			<xsl:variable name="relentity" select="@entity"/>
			
			<!--Find the related entity, check if it is the parent, and start WTRELATIONSHIP -->
			<xsl:for-each select="/Data/WTENTITIES/WTENTITY[@name=$relentity]">
				<xsl:variable name="relalias" select="@alias"/>

				<xsl:variable name="parent">
					<xsl:if test="/Data/WTRELATIONSHIPS/WTRELATIONSHIP[@entity=$entityname and @relentity=$relentity and @parent]"> parent="true"</xsl:if>
					<xsl:if test="/Data/WTRELATIONSHIPS/WTRELATIONSHIP[@entity=$entityname and @relentity=$relentity and @child]"> child="true"</xsl:if>
				</xsl:variable>

				<xsl:value-of select="concat( $tab2, '&lt;WTRELATIONSHIP entity=&quot;', $relentity, '&quot; alias=&quot;', $relalias, '&quot;', $parent, '&gt;',$cr)"/>

				<xsl:call-template name="BuildAttributes">
					<xsl:with-param name="entity" select="$entityname"/>
					<xsl:with-param name="relentity" select="$relentity"/>
				</xsl:call-template>
				
				<xsl:value-of select="concat( $tab2, '&lt;/WTRELATIONSHIP&gt;',$cr)"/>

			</xsl:for-each>
		</xsl:for-each>

		<!--Get a unique list of custom WTJOIN entities-->
		<xsl:for-each select="WTATTRIBUTE/WTJOIN[ @custom and not(@entity=preceding::WTATTRIBUTE/WTJOIN/@entity)]">
			<xsl:variable name="relentity" select="@entity"/>

			<xsl:for-each select="/Data/WTENTITY/WTJOINS/WTJOIN[@entity=$relentity]">

				<!--Find the related entity, check if it is the parent, and start WTRELATIONSHIP -->
				<xsl:for-each select="/Data/WTENTITIES/WTENTITY[@name=$relentity]">
					<xsl:variable name="relalias" select="@alias"/>

					<xsl:value-of select="concat( $tab2, '&lt;WTRELATIONSHIP entity=&quot;', $relentity, '&quot; alias=&quot;', $relalias, '&quot;&gt;',$cr)"/>

					<xsl:for-each select="/Data/WTENTITY/WTJOINS/WTJOIN[@entity=$relentity]/WTJOIN">
						<xsl:call-template name="BuildCustomAttribute">
							<xsl:with-param name="entity" select="@entity"/>
							<xsl:with-param name="relentity" select="@relentity"/>
						</xsl:call-template>
					</xsl:for-each>
					
					<xsl:value-of select="concat( $tab2, '&lt;/WTRELATIONSHIP&gt;',$cr)"/>

				</xsl:for-each>
			</xsl:for-each>
		</xsl:for-each>

		<!--Build the child relationships-->
		<xsl:for-each select="/Data/WTRELATIONSHIPS/WTRELATIONSHIP[@relentity=$entityname and @parent]">
			<xsl:value-of select="concat( $tab2, '&lt;WTRELATIONSHIP entity=&quot;', @entity, '&quot; child=&quot;true&quot;/&gt;',$cr)"/>
		</xsl:for-each>

		<xsl:value-of select="concat($tab1, '&lt;/WTRELATIONSHIPS&gt;', $cr, $cr)"/>

		<!--build parent list-->
		<xsl:if test="/Data/WTRELATIONSHIPS/WTRELATIONSHIP[@entity=$entityname and @parent]">
			<xsl:value-of select="concat($tab1, '&lt;WTPARENTS&gt;', $cr)"/>
				<xsl:call-template name="BuildParents">
					<xsl:with-param name="entity" select="$entityname"/>
				</xsl:call-template>
			<xsl:value-of select="concat($tab1, '&lt;/WTPARENTS&gt;', $cr)"/>
		</xsl:if>
		
		<xsl:value-of select="concat($tab0, '&lt;/WTROOT&gt;', $cr)"/>

	</xsl:template>
	
	<!--***********************************************************************************************-->
	<xsl:template name="BuildParents">
		<xsl:param name="entity"/>

		<xsl:for-each select="/Data/WTRELATIONSHIPS/WTRELATIONSHIP[@entity=$entityname and @parent]">
			<xsl:variable name="relentity" select="@relentity"/>
			<xsl:variable name="relcolumn" select="@relcolumn"/>
			<xsl:variable name="reltitle" select="/Data/WTENTITIES/WTENTITY[@name=$relentity]/@title"/>

			<xsl:call-template name="BuildParents">
				<xsl:with-param name="entity" select="$relentity"/>
			</xsl:call-template>
					
			<xsl:if test="not(@nodisplay)">
				<xsl:value-of select="concat( $tab2, '&lt;WTPARENT entity=&quot;', $relentity, '&quot; id=&quot;', $relcolumn, '&quot; title=&quot;', $reltitle, '&quot;/&gt;', $cr)"/>
			</xsl:if>

		</xsl:for-each>
	</xsl:template>

	<!--***********************************************************************************************-->
	<xsl:template name="LookupEntity">
		<xsl:param name="entity"/>
		<xsl:param name="relentity"/>
		
		<xsl:choose>
			<xsl:when test="/Data/WTRELATIONSHIPS/WTRELATIONSHIP[@entity=$entityname and @parent]">
				<xsl:for-each select="/Data/WTRELATIONSHIPS/WTRELATIONSHIP[@entity=$entityname and @parent]">
					<xsl:choose>
						<xsl:when test="@relentity=$relentity">true</xsl:when>
						<xsl:otherwise>
							<xsl:call-template name="LookupEntity">
								<xsl:with-param name="entity" select="@relentity"/>
								<xsl:with-param name="relentity" select="$relentity"/>
							</xsl:call-template>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:for-each>
			</xsl:when>
			<xsl:otherwise>false</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!--***********************************************************************************************-->
	<xsl:template name="BuildUpAttribute">
		<xsl:param name="entity"/>
		<xsl:param name="relentity"/>

		<xsl:choose>
			<xsl:when test="/Data/WTRELATIONSHIPS/WTRELATIONSHIP[@entity=$entityname and @parent]">
				<xsl:for-each select="/Data/WTRELATIONSHIPS/WTRELATIONSHIP[@entity=$entityname and @parent]">
					<xsl:variable name="nextentity" select="@relentity"/>
					<xsl:variable name="alias" select="/Data/WTENTITIES/WTENTITY[@name=$entityname]/@alias"/>
					<xsl:variable name="relalias" select="/Data/WTENTITIES/WTENTITY[@name=$nextentity]/@alias"/>

					<xsl:value-of select="concat( $tab3, '&lt;WTATTRIBUTE entity=&quot;', @entity, '&quot; alias=&quot;', $alias, '&quot; name=&quot;', @column, '&quot;')"/>
					<xsl:value-of select="concat( ' relentity=&quot;', @relentity, '&quot; relalias=&quot;', $relalias, '&quot; relname=&quot;', @relcolumn, '&quot;/&gt;', $cr)"/>

					<xsl:if test="@relentity!=$relentity">
						<xsl:call-template name="BuildUpAttribute">
							<xsl:with-param name="entity" select="@relentity"/>
							<xsl:with-param name="relentity" select="$relentity"/>
						</xsl:call-template>
					</xsl:if>
					
				</xsl:for-each>
			</xsl:when>
		</xsl:choose>
	</xsl:template>

	<!--***********************************************************************************************-->
	<xsl:template name="BuildDnAttribute">
		<xsl:param name="entity"/>
		<xsl:param name="relentity"/>

		<xsl:choose>
			<xsl:when test="/Data/WTRELATIONSHIPS/WTRELATIONSHIP[@entity=$entityname and not(@parent)]">
				<xsl:for-each select="/Data/WTRELATIONSHIPS/WTRELATIONSHIP[@entity=$entityname and not(@parent)]">
					<xsl:if test="@relentity=$relentity">
						<xsl:variable name="nextentity" select="@relentity"/>
						<xsl:variable name="alias" select="/Data/WTENTITIES/WTENTITY[@name=$entityname]/@alias"/>
						<xsl:variable name="relalias" select="/Data/WTENTITIES/WTENTITY[@name=$nextentity]/@alias"/>

						<xsl:value-of select="concat( $tab3, '&lt;WTATTRIBUTE entity=&quot;', @entity, '&quot; alias=&quot;', $alias, '&quot; name=&quot;', @column, '&quot;')"/>
						<xsl:value-of select="concat( ' relentity=&quot;', @relentity, '&quot; relalias=&quot;', $relalias, '&quot; relname=&quot;', @relcolumn, '&quot;/&gt;', $cr)"/>
					</xsl:if>
				</xsl:for-each>
			</xsl:when>
		</xsl:choose>
	</xsl:template>

	<!--***********************************************************************************************-->
	<xsl:template name="BuildCustomAttribute">
		<xsl:param name="entity"/>
		<xsl:param name="relentity"/>

		<xsl:for-each select="/Data/WTRELATIONSHIPS/WTRELATIONSHIP[@entity=$entityname and @relentity=$relentity]">
			<xsl:variable name="nextentity" select="@relentity"/>
			<xsl:variable name="alias" select="/Data/WTENTITIES/WTENTITY[@name=$entityname]/@alias"/>
			<xsl:variable name="relalias" select="/Data/WTENTITIES/WTENTITY[@name=$nextentity]/@alias"/>

			<xsl:value-of select="concat( $tab3, '&lt;WTATTRIBUTE entity=&quot;', @entity, '&quot; alias=&quot;', $alias, '&quot; name=&quot;', @column, '&quot;')"/>
			<xsl:value-of select="concat( ' relentity=&quot;', @relentity, '&quot; relalias=&quot;', $relalias, '&quot; relname=&quot;', @relcolumn, '&quot;/&gt;', $cr)"/>
		</xsl:for-each>
	</xsl:template>

	<!--***********************************************************************************************-->
	<xsl:template name="BuildAttributes">
		<xsl:param name="entity"/>
		<xsl:param name="relentity"/>

		<!--first check if the related entity is an upline parent-->
		<xsl:variable name="upline">
			<xsl:call-template name="LookupEntity">
				<xsl:with-param name="entity" select="$entityname"/>
				<xsl:with-param name="relentity" select="$relentity"/>
			</xsl:call-template>
		</xsl:variable>
				
		<xsl:choose>
			<xsl:when test="$upline='true'">
			
				<!--we found the related entity upline, so build the attributes-->
				<xsl:call-template name="BuildUpAttribute">
					<xsl:with-param name="entity" select="$entityname"/>
					<xsl:with-param name="relentity" select="$relentity"/>
				</xsl:call-template>
				
			</xsl:when>
			<xsl:otherwise>

				<!--look at the entities non-parent relationships-->
				<xsl:call-template name="BuildDnAttribute">
					<xsl:with-param name="entity" select="$entityname"/>
					<xsl:with-param name="relentity" select="$relentity"/>
				</xsl:call-template>

			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

</xsl:stylesheet>


