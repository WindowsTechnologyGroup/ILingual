<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:include href="GenerateIncludeXSL.xsl"/>
<!--=====================================================================
	Auth:   Bob Wood
	Date:   February 2002
	Desc:   Creates the Entity XML file 
	Copyright 2002 WinTech, Inc.
======================================================================-->

	<xsl:template match="/">
		<XML><xsl:apply-templates/></XML>
	</xsl:template>

	<xsl:template match="WTROOT">

		<xsl:variable name="rootprefix" select="@prefix"/>
		<xsl:variable name="rootcolor" select="@color"/>
		<xsl:variable name="rootdbo" select="@dbo"/>
		<xsl:variable name="rootsystem" select="@system"/>
	
		<xsl:variable name="entity" select="/WTROOT/@entity"/>

		<xsl:for-each select="/WTROOT/WTENTITIES/WTENTITY[@name=$entity]">

			<xsl:variable name="identity" select="@identity"/>
			<xsl:variable name="number" select="@number"/>
			<xsl:variable name="title" select="@title"/>
			<xsl:variable name="lookup" select="@lookup"/>
			<xsl:variable name="alias" select="@alias"/>

			<!--create the entity info-->

			<xsl:value-of select="concat('&lt;WTROOT prefix=&quot;', @rootprefix, '&quot; color=&quot;', @rootcolor, '&quot; dbo=&quot;', @rootdbo, '&quot; system=&quot;', @rootsystem, '&quot;&gt;', $cr)"/>
			<xsl:value-of select="concat($tab1, '&lt;WTENTITY id=&quot;', @number, '&quot; name=&quot;', @name, '&quot; alias=&quot;', @alias, '&quot;&gt;', $cr, $cr)"/>
			
			<!--**********create the Attributes section**************************************************************-->
			<xsl:value-of select="concat($tab2, '&lt;!--Identity--&gt;', $cr)"/>
			<xsl:value-of select="concat($tab2, '&lt;WTATTRIBUTE id=&quot;', @number, '01&quot; name=&quot;', @identity, '&quot; type=&quot;number&quot; identity=&quot;true&quot; min=&quot;1&quot; required=&quot;true&quot; source=&quot;entity&quot;/&gt;', $cr, $cr)"/>

			<xsl:if test="not($lookup)">
				<xsl:value-of select="concat($tab2, '&lt;!--Foreign Keys--&gt;', $cr)"/>
			
				<!--create the parent identity attributes-->
				<xsl:call-template name="ParentIdentityAttribute">
					<xsl:with-param name="entity" select="$entity"/>
					<xsl:with-param name="enum" select="@number"/>
					<xsl:with-param name="number">2</xsl:with-param>
				</xsl:call-template>
			
				<!--Build the Related To Identity Attributes-->
				<xsl:for-each select="/WTROOT/WTRELATIONSHIPS/WTRELATIONSHIP[@entity=$entity and not(@parent) and @column!=$identity]">
					<!--create the Identity Atttribute-->
					<xsl:call-template name="IdentityAttribute">
						<xsl:with-param name="entity" select="@relentity"/>
						<xsl:with-param name="enum" select="$number"/>
						<xsl:with-param name="number" select="position()+5"/>
						<xsl:with-param name="fkey" select="true()"/>
					</xsl:call-template>
				</xsl:for-each>

				<xsl:value-of select="concat($cr, $tab2, '&lt;!--Foreign Table Fields--&gt;', $cr)"/>
				<!--create the parent Title attributes-->
				<xsl:call-template name="ParentTitleAttribute">
					<xsl:with-param name="entity" select="$entity"/>
					<xsl:with-param name="enum" select="@number"/>
					<xsl:with-param name="number">10</xsl:with-param>
				</xsl:call-template>
			
				<!--Build the Related To Title Attributes-->
				<xsl:for-each select="/WTROOT/WTRELATIONSHIPS/WTRELATIONSHIP[@entity=$entity and not(@parent) and @column!=$identity]">
					<!--create the Identity Atttribute-->
					<xsl:call-template name="TitleAttribute">
						<xsl:with-param name="entity" select="@relentity"/>
						<xsl:with-param name="enum" select="$number"/>
						<xsl:with-param name="number" select="position()+15"/>
					</xsl:call-template>
				</xsl:for-each>

				<xsl:value-of select="$cr"/>
			</xsl:if>

			<xsl:value-of select="concat($tab2, '&lt;!--Attributes--&gt;', $cr)"/>

			<!--Build the Title Attribute (non-lookup list)-->
			<xsl:if test="not($lookup)">
				<xsl:value-of select="concat($tab2, '&lt;WTATTRIBUTE id=&quot;', $number, '25&quot; name=&quot;', $title, '&quot; type=&quot;text&quot; length=&quot;30&quot; min=&quot;1&quot; max=&quot;30&quot; required=&quot;true&quot; title=&quot;true&quot; source=&quot;entity&quot;/&gt;', $cr)"/>
			</xsl:if>
			
			<!--Build the Title Attribute (lookup list)-->
			<xsl:if test="$lookup">
				<xsl:value-of select="concat($tab2, '&lt;WTATTRIBUTE id=&quot;', $number, '02&quot; name=&quot;Name&quot; type=&quot;text&quot; length=&quot;20&quot; min=&quot;1&quot; max=&quot;20&quot; required=&quot;true&quot; title=&quot;true&quot; source=&quot;entity&quot;/&gt;', $cr)"/>
				<xsl:value-of select="concat($tab2, '&lt;WTATTRIBUTE id=&quot;', $number, '03&quot; name=&quot;Seq&quot; type=&quot;number&quot; min=&quot;1&quot; source=&quot;entity&quot;/&gt;', $cr)"/>
			</xsl:if>

			<xsl:value-of select="$cr"/>

			<!--**********create the Relationships section**************************************************************-->
			<xsl:if test="not($lookup)">
				<xsl:value-of select="concat($tab2, '&lt;!--Relationships--&gt;', $cr)"/>
				<xsl:value-of select="concat($tab2, '&lt;WTRELATIONSHIPS&gt;', $cr)"/>

				<xsl:value-of select="concat( $tab3, '&lt;WTRELATIONSHIP name=&quot;Common&quot; entity=&quot;', $entity, '&quot; alias=&quot;', $alias, '&quot;&gt;',$cr)"/>
				<!--Build the parent relationship Entities-->
				<xsl:call-template name="ParentEntity">
					<xsl:with-param name="entity" select="$entity"/>
					<xsl:with-param name="me" select="$entity"/>
				</xsl:call-template>
				<!--Build the Related To relationship Entities-->
				<xsl:for-each select="/WTROOT/WTRELATIONSHIPS/WTRELATIONSHIP[@entity=$entity and not(@parent) and @column!=$identity]">
					<xsl:variable name="relentity" select="@relentity"/>
					<xsl:variable name="relalias" select="/WTROOT/WTENTITIES/WTENTITY[@name=$relentity]/@alias"/>
					<xsl:value-of select="concat( $tab4, '&lt;WTENTITY name=&quot;', $relentity, '&quot; entity=&quot;', $relentity, '&quot; alias=&quot;', $relalias, '&quot;&gt;',$cr)"/>
					<xsl:call-template name="RelationshipAttribute"/>
					<xsl:value-of select="concat( $tab4, '&lt;/WTENTITY&gt;',$cr)"/>
				</xsl:for-each>
				<xsl:value-of select="concat( $tab3, '&lt;/WTRELATIONSHIP&gt;',$cr)"/>

				<!--build a relationship for each parent-->
				<xsl:call-template name="ParentRelationship">
					<xsl:with-param name="entity" select="$entity"/>
					<xsl:with-param name="me" select="$entity"/>
				</xsl:call-template>
			
				<xsl:value-of select="concat($tab2, '&lt;/WTRELATIONSHIPS&gt;', $cr, $cr)"/>
			</xsl:if>

			<!--**********create the Parents section**************************************************************-->
			<xsl:variable name="parents">
				<xsl:call-template name="BuildParents">
					<xsl:with-param name="entity" select="$entity"/>
				</xsl:call-template>
			</xsl:variable>
			<xsl:if test="string-length($parents)>0">
				<xsl:value-of select="concat($tab2, '&lt;WTPARENTS&gt;', $cr)"/>
				<xsl:value-of select="$parents"/>
				<xsl:value-of select="concat($tab2, '&lt;/WTPARENTS&gt;', $cr, $cr)"/>
			</xsl:if>

			<!--**********create the Enum Find section**************************************************************-->
			<xsl:if test="not($lookup)">
				<xsl:value-of select="concat($tab2, '&lt;WTENUM id=&quot;1&quot; type=&quot;find&quot;&gt;', $cr)"/>
				<xsl:value-of select="concat($tab3, '&lt;WTATTRIBUTE name=&quot;', $title, '&quot; default=&quot;true&quot;/&gt;', $cr)"/>

				<!--Build the Parent Find Enum-->
				<xsl:for-each select="/WTROOT/WTRELATIONSHIPS/WTRELATIONSHIP[@entity=$entity and @parent]">
<!--
					<xsl:variable name="relentity" select="@relentity"/>
					<xsl:variable name="reltitle" select="/WTROOT/WTENTITIES/WTENTITY[@name=$relentity]/@title"/>
-->
					<xsl:if test="not(@nodisplay)">
						<xsl:value-of select="concat($tab3, '&lt;WTATTRIBUTE name=&quot;', @relentity, '&quot;/&gt;', $cr)"/>
					</xsl:if>
				</xsl:for-each>

				<!--Build the Related To Find Enums-->
				<xsl:for-each select="/WTROOT/WTRELATIONSHIPS/WTRELATIONSHIP[@entity=$entity and not(@parent) and @column!=$identity]">
<!--
					<xsl:variable name="relentity" select="@relentity"/>
					<xsl:variable name="reltitle" select="/WTROOT/WTENTITIES/WTENTITY[@name=$relentity]/@title"/>
-->
					<xsl:if test="not(@nodisplay)">
						<xsl:value-of select="concat($tab3, '&lt;WTATTRIBUTE name=&quot;', @relentity, '&quot;/&gt;', $cr)"/>
					</xsl:if>
				</xsl:for-each>

				<xsl:value-of select="concat($tab2, '&lt;/WTENUM&gt;', $cr, $cr)"/>
			</xsl:if>

			<!--**********create the Enum List section**************************************************************-->
			<xsl:variable name="lists">
				<!--Build the Parent List Enum-->
				<xsl:for-each select="/WTROOT/WTRELATIONSHIPS/WTRELATIONSHIP[@entity=$entity and @parent]">
					<xsl:variable name="relentity" select="@relentity"/>
					<xsl:variable name="relidentity" select="/WTROOT/WTENTITIES/WTENTITY[@name=$relentity]/@identity"/>
					<xsl:if test="not(@nodisplay)">
						<xsl:value-of select="concat($tab3, '&lt;WTATTRIBUTE name=&quot;', $relidentity, '&quot; entity=&quot;', $relentity, '&quot;/&gt;', $cr)"/>
					</xsl:if>
				</xsl:for-each>

				<!--Build the Related To List Enums-->
				<xsl:for-each select="/WTROOT/WTRELATIONSHIPS/WTRELATIONSHIP[@entity=$entity and not(@parent) and @column!=$identity]">
					<xsl:variable name="relentity" select="@relentity"/>
					<xsl:variable name="relidentity" select="/WTROOT/WTENTITIES/WTENTITY[@name=$relentity]/@identity"/>
					<xsl:variable name="rellookup" select="/WTROOT/WTENTITIES/WTENTITY[@name=$relentity]/@lookup"/>
					
					<xsl:if test="not($rellookup or @nodisplay)">
						<xsl:value-of select="concat($tab3, '&lt;WTATTRIBUTE name=&quot;', $relidentity, '&quot; entity=&quot;', $relentity, '&quot;/&gt;', $cr)"/>
					</xsl:if>
				</xsl:for-each>
			</xsl:variable>

			<xsl:choose>
				<xsl:when test="string-length($lists)>0">
					<xsl:value-of select="concat($tab2, '&lt;WTENUM id=&quot;2&quot; type=&quot;list&quot;&gt;', $cr)"/>
					<xsl:value-of select="$lists"/>
					<xsl:value-of select="concat($tab2, '&lt;/WTENUM&gt;', $cr, $cr)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="concat($tab2, '&lt;WTENUM id=&quot;2&quot; type=&quot;list&quot;/&gt;', $cr)"/>
				</xsl:otherwise>
			</xsl:choose>

			<!--**********close the Entity section**************************************************************-->
			<xsl:value-of select="concat($tab1, '&lt;/WTENTITY&gt;', $cr, $cr)"/>

			<!--**********check for joined entities - to pass to procedures*************************************-->
			<xsl:variable name="joins">
				<!--create the parent identity attributes-->
				<xsl:call-template name="ParentJoin">
					<xsl:with-param name="entity" select="$entity"/>
				</xsl:call-template>
			
				<!--Build the Related To Identity Attributes-->
				<xsl:for-each select="/WTROOT/WTRELATIONSHIPS/WTRELATIONSHIP[@entity=$entity and not(@parent) and @column!=$identity]">
					<!--create the Identity Atttribute-->
					<xsl:call-template name="Join">
						<xsl:with-param name="entity" select="@relentity"/>
					</xsl:call-template>
				</xsl:for-each>
			</xsl:variable>

			<!--**********create the Procedures section**************************************************************-->
			<xsl:value-of select="concat($tab1, '&lt;WTPROCEDURES&gt;', $cr)"/>

			<xsl:call-template name="Procedures">
				<xsl:with-param name="entity" select="$entity"/>
				<xsl:with-param name="title" select="$title"/>
				<xsl:with-param name="identity" select="$identity"/>
				<xsl:with-param name="lookup" select="$lookup"/>
				<xsl:with-param name="join" select="string-length($joins)>0"/>
			</xsl:call-template>

			<xsl:value-of select="concat($tab1, '&lt;/WTPROCEDURES&gt;', $cr, $cr)"/>

			<!--**********create the Procedures section**************************************************************-->
			<xsl:value-of select="concat($tab1, '&lt;WTWEBPAGES&gt;', $cr)"/>

			<xsl:call-template name="WebPages">
				<xsl:with-param name="entity" select="$entity"/>
				<xsl:with-param name="number" select="$number"/>
				<xsl:with-param name="identity" select="$identity"/>
				<xsl:with-param name="title" select="$title"/>
				<xsl:with-param name="lookup" select="$lookup"/>
				<xsl:with-param name="list" select="string-length($lists)>0"/>
			</xsl:call-template>

			<xsl:value-of select="concat($tab1, '&lt;/WTWEBPAGES&gt;', $cr, $cr)"/>

			<xsl:value-of select="concat($tab0, '&lt;/WTROOT&gt;', $cr)"/>

		</xsl:for-each>
		
	</xsl:template>

	<!--***********************************************************************************************-->
	<xsl:template name="ParentIdentityAttribute">
		<xsl:param name="entity"/>
		<xsl:param name="enum"/>
		<xsl:param name="number"/>
		<xsl:param name="step">1</xsl:param>

		<xsl:for-each select="/WTROOT/WTRELATIONSHIPS/WTRELATIONSHIP[@entity=$entity and @parent]">
			<xsl:variable name="relentity" select="@relentity"/>

			<!--create the Identity Atttribute-->
			<xsl:call-template name="IdentityAttribute">
				<xsl:with-param name="entity" select="$relentity"/>
				<xsl:with-param name="enum" select="$enum"/>
				<xsl:with-param name="number" select="$number"/>
				<xsl:with-param name="step" select="$step"/>
			</xsl:call-template>

			<!--Get the next Parent-->
			<xsl:call-template name="ParentIdentityAttribute">
				<xsl:with-param name="entity" select="$relentity"/>
				<xsl:with-param name="enum" select="$enum"/>
				<xsl:with-param name="number" select="$number+1"/>
				<xsl:with-param name="step" select="$step+1"/>
			</xsl:call-template>

		</xsl:for-each>
	</xsl:template>

	<!--***********************************************************************************************-->
	<xsl:template name="IdentityAttribute">
		<xsl:param name="entity"/>
		<xsl:param name="enum"/>
		<xsl:param name="number"/>
		<xsl:param name="step">1</xsl:param>
		<xsl:param name="fkey"/>

		<xsl:if test="not(@nodisplay)">
			<!--create the Identity Atttribute-->
			<xsl:variable name="identity" select="/WTROOT/WTENTITIES/WTENTITY[@name=$entity]/@identity"/>
			<xsl:variable name="lookup" select="/WTROOT/WTENTITIES/WTENTITY[@name=$entity]/@lookup"/>

			<xsl:variable name="anum">
				<xsl:value-of select="$enum"/>
				<xsl:if test="string-length($number)=1">0</xsl:if>
				<xsl:value-of select="$number"/>
			</xsl:variable>
			
			<xsl:variable name="source">
				<xsl:if test="$step=1">entity</xsl:if>
				<xsl:if test="$step>1">join</xsl:if>
			</xsl:variable>

			<xsl:variable name="content">
				<xsl:if test="$step>1">
					<xsl:value-of select="concat($tab3, '&lt;WTJOIN entity=&quot;', $entity, '&quot; name=&quot;', $identity, '&quot;/&gt;', $cr)"/>
				</xsl:if>
				<xsl:if test="$lookup or $fkey">
					<xsl:value-of select="concat($tab3, '&lt;WTLOOKUP entity=&quot;', $entity, '&quot; class=&quot;', $entity, 's&quot; method=&quot;Enumerate&quot;&gt;', $cr)"/>
					<xsl:value-of select="concat($tab4, '&lt;WTPARAM name=&quot;UserID&quot; direction=&quot;input&quot; type=&quot;system&quot; value=&quot;sysuser&quot;/&gt;', $cr)"/>
					<xsl:value-of select="concat($tab3, '&lt;/WTLOOKUP&gt;', $cr)"/>
				</xsl:if>
			</xsl:variable>
			
			<xsl:value-of select="concat($tab2, '&lt;WTATTRIBUTE id=&quot;', $anum, '&quot; name=&quot;', $identity, '&quot; type=&quot;number&quot; min=&quot;1&quot; required=&quot;true&quot; source=&quot;', $source, '&quot;')"/>
			<xsl:if test="string-length($content)>0">
				<xsl:value-of select="concat('&gt;', $cr, $content)"/>
				<xsl:value-of select="concat($tab2, '&lt;/WTATTRIBUTE&gt;', $cr)"/>
			</xsl:if>
			<xsl:if test="string-length($content)=0">
				<xsl:value-of select="concat('/&gt;', $cr )"/>
			</xsl:if>
			
		</xsl:if>

	</xsl:template>

	<!--***********************************************************************************************-->
	<xsl:template name="ParentTitleAttribute">
		<xsl:param name="entity"/>
		<xsl:param name="enum"/>
		<xsl:param name="number"/>

		<xsl:for-each select="/WTROOT/WTRELATIONSHIPS/WTRELATIONSHIP[@entity=$entity and @parent]">
			<xsl:variable name="relentity" select="@relentity"/>

			<!--create the Identity Atttribute-->
			<xsl:call-template name="TitleAttribute">
				<xsl:with-param name="entity" select="$relentity"/>
				<xsl:with-param name="enum" select="$enum"/>
				<xsl:with-param name="number" select="$number"/>
			</xsl:call-template>

			<!--Get the next Parent-->
			<xsl:call-template name="ParentTitleAttribute">
				<xsl:with-param name="entity" select="$relentity"/>
				<xsl:with-param name="enum" select="$enum"/>
				<xsl:with-param name="number" select="$number+1"/>
			</xsl:call-template>

		</xsl:for-each>
	</xsl:template>

	<!--***********************************************************************************************-->
	<xsl:template name="TitleAttribute">
		<xsl:param name="entity"/>
		<xsl:param name="enum"/>
		<xsl:param name="number"/>

		<xsl:if test="not(@nodisplay)">
			<!--create the Identity Atttribute-->
			<xsl:variable name="title" select="/WTROOT/WTENTITIES/WTENTITY[@name=$entity]/@title"/>
			<xsl:variable name="anum">
				<xsl:value-of select="$enum"/>
				<xsl:if test="string-length($number)=1">0</xsl:if>
				<xsl:value-of select="$number"/>
			</xsl:variable>
			<xsl:value-of select="concat($tab2, '&lt;WTATTRIBUTE id=&quot;', $anum, '&quot; name=&quot;', $entity, '&quot; type=&quot;number&quot; min=&quot;1&quot; required=&quot;true&quot; source=&quot;join&quot;&gt;', $cr)"/>
			<xsl:value-of select="concat($tab3, '&lt;WTJOIN entity=&quot;', $entity, '&quot; name=&quot;', $title, '&quot;/&gt;', $cr)"/>
			<xsl:value-of select="concat($tab2, '&lt;/WTATTRIBUTE&gt;', $cr)"/>
		</xsl:if>

	</xsl:template>

	<!--***********************************************************************************************-->
	<xsl:template name="ParentJoin">
		<xsl:param name="entity"/>

		<xsl:for-each select="/WTROOT/WTRELATIONSHIPS/WTRELATIONSHIP[@entity=$entity and @parent]">
			<xsl:variable name="relentity" select="@relentity"/>

			<!--create the Identity Atttribute-->
			<xsl:call-template name="Join">
				<xsl:with-param name="entity" select="$relentity"/>
			</xsl:call-template>

			<!--Get the next Parent-->
			<xsl:call-template name="ParentJoin">
				<xsl:with-param name="entity" select="$relentity"/>
			</xsl:call-template>

		</xsl:for-each>
	</xsl:template>

	<!--***********************************************************************************************-->
	<xsl:template name="Join">
		<xsl:param name="entity"/>

		<xsl:value-of select="concat($tab3, '&lt;WTJOIN name=&quot;', $entity, '&quot;/&gt;', $cr)"/>

	</xsl:template>

	<!--***********************************************************************************************-->
	<xsl:template name="ParentEntity">
		<xsl:param name="entity"/>
		<xsl:param name="me"/>

		<xsl:for-each select="/WTROOT/WTRELATIONSHIPS/WTRELATIONSHIP[@entity=$entity and @parent]">
			<xsl:variable name="relentity" select="@relentity"/>

			<!--Define the Relationship for this Parent-->
			<xsl:for-each select="/WTROOT/WTENTITIES/WTENTITY[@name=$relentity]">
				<xsl:variable name="relalias" select="@alias"/>
				<xsl:value-of select="concat( $tab4, '&lt;WTENTITY name=&quot;', $relentity, '&quot; entity=&quot;', $relentity, '&quot; alias=&quot;', $relalias, '&quot;&gt;',$cr)"/>
			</xsl:for-each>

			<xsl:call-template name="RelationshipAttribute"/>
			<xsl:value-of select="concat( $tab4, '&lt;/WTENTITY&gt;',$cr)"/>

			<!--Get the next Parent-->
			<xsl:call-template name="ParentEntity">
				<xsl:with-param name="entity" select="$relentity"/>
				<xsl:with-param name="me" select="$me"/>
			</xsl:call-template>

		</xsl:for-each>
	</xsl:template>

	<!--***********************************************************************************************-->
	<xsl:template name="ParentRelationship">
		<xsl:param name="entity"/>
		<xsl:param name="me"/>

		<xsl:for-each select="/WTROOT/WTRELATIONSHIPS/WTRELATIONSHIP[@entity=$entity and @parent]">
			<xsl:variable name="relentity" select="@relentity"/>

			<!--Define the Relationship for this Parent-->
			<xsl:for-each select="/WTROOT/WTENTITIES/WTENTITY[@name=$me]">
				<xsl:variable name="alias" select="@alias"/>
				<xsl:value-of select="concat( $tab3, '&lt;WTRELATIONSHIP name=&quot;', $relentity'&quot; entity=&quot;', $me, '&quot; alias=&quot;', $alias, '&quot;&gt;',$cr)"/>
			</xsl:for-each>
			
			<xsl:call-template name="RelationshipEntity">
				<xsl:with-param name="entity" select="$me"/>
				<xsl:with-param name="toentity" select="$entity"/>
			</xsl:call-template>
				
			<xsl:value-of select="concat( $tab3, '&lt;/WTRELATIONSHIP&gt;',$cr)"/>

			<!--Get the next Parent-->
			<xsl:call-template name="ParentRelationship">
				<xsl:with-param name="entity" select="$relentity"/>
				<xsl:with-param name="me" select="$me"/>
			</xsl:call-template>

		</xsl:for-each>
	</xsl:template>

	<!--***********************************************************************************************-->
	<xsl:template name="RelationshipEntity">
		<xsl:param name="entity"/>
		<xsl:param name="toentity"/>

		<xsl:for-each select="/WTROOT/WTRELATIONSHIPS/WTRELATIONSHIP[@entity=$entity and @parent]">
			<xsl:variable name="relentity" select="@relentity"/>
			<xsl:variable name="relalias" select="/WTROOT/WTENTITIES/WTENTITY[@name=$relentity]/@alias"/>

			<xsl:value-of select="concat( $tab4, '&lt;WTENTITY name=&quot;', $relentity, '&quot; entity=&quot;', $relentity, '&quot; alias=&quot;', $relalias, '&quot;&gt;',$cr)"/>
			<xsl:call-template name="RelationshipAttribute"/>
			<xsl:value-of select="concat( $tab4, '&lt;/WTENTITY&gt;',$cr)"/>

			<xsl:if test="$entity!=$toentity">
				<xsl:call-template name="RelationshipEntity">
					<xsl:with-param name="entity" select="$relentity"/>
					<xsl:with-param name="toentity" select="$toentity"/>
				</xsl:call-template>
			</xsl:if>
					
		</xsl:for-each>
		
	</xsl:template>
	<!--***********************************************************************************************-->
	<xsl:template name="RelationshipAttribute">

		<xsl:variable name="entity" select="@entity"/>
		<xsl:variable name="relentity" select="@relentity"/>
		<xsl:variable name="alias" select="/WTROOT/WTENTITIES/WTENTITY[@name=$entity]/@alias"/>
		<xsl:variable name="relalias" select="/WTROOT/WTENTITIES/WTENTITY[@name=$relentity]/@alias"/>

		<xsl:value-of select="concat( $tab5, '&lt;WTATTRIBUTE alias=&quot;', $alias, '&quot; name=&quot;', @column, '&quot;')"/>
		<xsl:value-of select="concat( ' relalias=&quot;', $relalias, '&quot; relname=&quot;', @relcolumn, '&quot;/&gt;', $cr)"/>

	</xsl:template>

	<!--***********************************************************************************************-->
	<xsl:template name="BuildParents">
		<xsl:param name="entity"/>

		<xsl:for-each select="/WTROOT/WTRELATIONSHIPS/WTRELATIONSHIP[@entity=$entity and @parent]">
			<xsl:variable name="relentity" select="@relentity"/>
			<xsl:variable name="relcolumn" select="@relcolumn"/>
			<xsl:variable name="reltitle" select="/WTROOT/WTENTITIES/WTENTITY[@name=$relentity]/@title"/>

			<xsl:call-template name="BuildParents">
				<xsl:with-param name="entity" select="$relentity"/>
			</xsl:call-template>
					
			<xsl:if test="not(@nodisplay)">
				<xsl:value-of select="concat( $tab3, '&lt;WTPARENT entity=&quot;', $relentity, '&quot; id=&quot;', $relcolumn, '&quot; title=&quot;', $relentity, '&quot; parenttitle=&quot;', $reltitle, '&quot;/&gt;', $cr)"/>
			</xsl:if>

		</xsl:for-each>
	</xsl:template>

	<!--***********************************************************************************************-->
	<xsl:template name="Procedures">
		<xsl:param name="entity"/>
		<xsl:param name="title"/>
		<xsl:param name="identity"/>
		<xsl:param name="lookup"/>
		<xsl:param name="join"/>

		<!--Fetch procedure must be first for to handle dependencies-->
		<xsl:value-of select="concat($tab2, '&lt;WTPROCEDURE type=&quot;Fetch&quot; name=&quot;Fetch&quot; style=&quot;GenerateDataProc.xsl&quot;')"/>

		<xsl:variable name="content">
			<xsl:if test="$join">
				<xsl:value-of select="concat($tab3, '&lt;WTJOIN name=&quot;Common&quot;/&gt;', $cr)"/>
			</xsl:if>
		</xsl:variable>
			
		<xsl:if test="string-length($content)>0">		
			<xsl:value-of select="concat('&gt;', $cr, $content)"/>
			<xsl:value-of select="concat($tab2, '&lt;/WTPROCEDURE&gt;', $cr)"/>
		</xsl:if>		
		<xsl:if test="string-length($content)=0">		
			<xsl:value-of select="concat('/&gt;', $cr)"/>
		</xsl:if>		

		<xsl:value-of select="concat($tab2, '&lt;WTPROCEDURE type=&quot;Add&quot; name=&quot;Add&quot; style=&quot;GenerateDataProc.xsl&quot;/&gt;', $cr)"/>
		<xsl:value-of select="concat($tab2, '&lt;WTPROCEDURE type=&quot;Count&quot; name=&quot;Count&quot; style=&quot;GenerateDataProc.xsl&quot;/&gt;', $cr)"/>
		<xsl:value-of select="concat($tab2, '&lt;WTPROCEDURE type=&quot;Enum&quot; name=&quot;Enum&quot; style=&quot;GenerateDataProc.xsl&quot; column=&quot;', $title '&quot;')"/>
		<xsl:if test="$lookup">
			<xsl:value-of select="concat('&gt;', $cr, $tab3, '&lt;WTORDER name=&quot;Seq&quot;/&gt;', $cr)"/>
			<xsl:value-of select="concat($tab2, '&lt;/WTPROCEDURE&gt;', $cr)"/>
		</xsl:if>
		<xsl:if test="not($lookup)">
			<xsl:value-of select="concat('/&gt;', $cr)"/>
		</xsl:if>

		<xsl:value-of select="concat($tab2, '&lt;WTPROCEDURE type=&quot;Update&quot; name=&quot;Update&quot; style=&quot;GenerateDataProc.xsl&quot;/&gt;', $cr)"/>

		<xsl:call-template name="ParentDelete">
			<xsl:with-param name="entity" select="$entity"/>
			<xsl:with-param name="me" select="$entity"/>
		</xsl:call-template>

		<xsl:value-of select="concat($tab2, '&lt;WTPROCEDURE type=&quot;Delete&quot; name=&quot;Delete&quot; style=&quot;GenerateDataProc.xsl&quot;')"/>

		<xsl:variable name="content2">
			<xsl:for-each select="/WTROOT/WTRELATIONSHIPS/WTRELATIONSHIP[@relentity=$entity and @parent]">
				<xsl:value-of select="concat($tab3, '&lt;WTPROCEDURE name=&quot;', @entity, '_Delete', $entity, '&quot; position=&quot;before&quot;/&gt;', $cr)"/>
			</xsl:for-each>
		</xsl:variable>

		<xsl:if test="string-length($content2)>0">		
			<xsl:value-of select="concat('&gt;', $cr, $content2)"/>
			<xsl:value-of select="concat($tab2, '&lt;/WTPROCEDURE&gt;', $cr)"/>
		</xsl:if>		
		<xsl:if test="string-length($content2)=0">		
			<xsl:value-of select="concat('/&gt;', $cr)"/>
		</xsl:if>		

		<xsl:if test="not($lookup)">
			<xsl:value-of select="concat($tab2, '&lt;WTPROCEDURE type=&quot;Find&quot; name=&quot;Find&quot; style=&quot;GenerateDataProc.xsl&quot;&gt;', $cr)"/>
			<xsl:if test="$join">
				<xsl:value-of select="concat($tab3, '&lt;WTJOIN name=&quot;Common&quot;/&gt;', $cr)"/>
			</xsl:if>
			<xsl:value-of select="concat($tab3, '&lt;WTBOOKMARK name=&quot;&quot;/&gt;', $cr)"/>
			<xsl:value-of select="concat($tab2, '&lt;/WTPROCEDURE&gt;', $cr)"/>
		</xsl:if>

		<xsl:if test="$lookup">
			<xsl:value-of select="concat($tab2, '&lt;WTPROCEDURE type=&quot;List&quot; name=&quot;List&quot; style=&quot;GenerateDataProc.xsl&quot;&gt;', $cr)"/>
			<xsl:if test="$lookup">
				<xsl:value-of select="concat($tab3, '&lt;WTORDER name=&quot;Seq&quot;/&gt;', $cr)"/>
			</xsl:if>
			<xsl:if test="$join">
				<xsl:value-of select="concat($tab3, '&lt;WTJOIN name=&quot;Common&quot;/&gt;', $cr)"/>
			</xsl:if>
			<xsl:value-of select="concat($tab2, '&lt;/WTPROCEDURE&gt;', $cr)"/>
		</xsl:if>

		<!--Build Parent List Procedure-->
		<xsl:for-each select="/WTROOT/WTRELATIONSHIPS/WTRELATIONSHIP[@entity=$entity and @parent]">
			<xsl:variable name="relentity" select="@relentity"/>
			<xsl:variable name="relidentity" select="/WTROOT/WTENTITIES/WTENTITY[@name=$relentity]/@identity"/>

			<xsl:if test="not(@nodisplay)">
				<xsl:value-of select="concat($tab2, '&lt;WTPROCEDURE type=&quot;List&quot; name=&quot;List', $relidentity,'&quot; style=&quot;GenerateDataProc.xsl&quot;&gt;', $cr)"/>
				<xsl:value-of select="concat($tab3, '&lt;WTPARAM name=&quot;', $relidentity, '&quot;/&gt;', $cr)"/>
				<xsl:value-of select="concat($tab3, '&lt;WTORDER name=&quot;' $title, '&quot;/&gt;', $cr)"/>
				<xsl:if test="$join">
					<xsl:value-of select="concat($tab3, '&lt;WTJOIN name=&quot;Common&quot;/&gt;', $cr)"/>
				</xsl:if>
				<xsl:value-of select="concat($tab2, '&lt;/WTPROCEDURE&gt;', $cr)"/>
			</xsl:if>
		</xsl:for-each>

		<!--Build the Related To List Procedures-->
		<xsl:for-each select="/WTROOT/WTRELATIONSHIPS/WTRELATIONSHIP[@entity=$entity and not(@parent) and @column!=$identity]">
			<xsl:variable name="relentity" select="@relentity"/>
			<xsl:variable name="relidentity" select="/WTROOT/WTENTITIES/WTENTITY[@name=$relentity]/@identity"/>
			<xsl:variable name="rellookup" select="/WTROOT/WTENTITIES/WTENTITY[@name=$relentity]/@lookup"/>

			<xsl:if test="not($rellookup or @nodisplay)">
				<xsl:value-of select="concat($tab2, '&lt;WTPROCEDURE type=&quot;List&quot; name=&quot;List', $relidentity,'&quot; style=&quot;GenerateDataProc.xsl&quot;&gt;', $cr)"/>
				<xsl:value-of select="concat($tab3, '&lt;WTPARAM name=&quot;', $relidentity, '&quot;/&gt;', $cr)"/>
				<xsl:value-of select="concat($tab3, '&lt;WTORDER name=&quot;' $title, '&quot;/&gt;', $cr)"/>
				<xsl:if test="$join">
					<xsl:value-of select="concat($tab3, '&lt;WTJOIN name=&quot;Common&quot;/&gt;', $cr)"/>
				</xsl:if>
				<xsl:value-of select="concat($tab2, '&lt;/WTPROCEDURE&gt;', $cr)"/>
			</xsl:if>

		</xsl:for-each>

		<!--build a custom Delete procedure for each parent-->
		<xsl:for-each select="/WTROOT/WTRELATIONSHIPS/WTRELATIONSHIP[@relentity=$entity and @parent]">
			<xsl:value-of select="concat($tab2, '&lt;WTPROCEDURE type=&quot;Custom&quot; name=&quot;', @entity, '_Delete', $entity, '&quot; proc=&quot;', @entity, '_Delete', $entity, '&quot;&gt;', $cr)"/>
			<xsl:value-of select="concat($tab3, '&lt;WTPARAM name=&quot;', @relcolumn, '&quot; direction=&quot;input&quot; value=&quot;', @relcolumn, '&quot;/&gt;', $cr)"/>
			<xsl:value-of select="concat($tab3, '&lt;WTPARAM name=&quot;UserID&quot; direction=&quot;input&quot; value=&quot;UserID&quot;/&gt;', $cr)"/>
			<xsl:value-of select="concat($tab2, '&lt;/WTPROCEDURE&gt;', $cr)"/>
		</xsl:for-each>

	</xsl:template>

	<!--***********************************************************************************************-->
	<xsl:template name="ParentDelete">
		<xsl:param name="entity"/>
		<xsl:param name="me"/>

		<xsl:for-each select="/WTROOT/WTRELATIONSHIPS/WTRELATIONSHIP[@entity=$entity and @parent]">
			<xsl:variable name="relentity" select="@relentity"/>

			<xsl:if test="not(@nodisplay)">
				<xsl:value-of select="concat($tab2, '&lt;WTPROCEDURE type=&quot;DeleteChild&quot; name=&quot;Delete', $relentity '&quot; style=&quot;GenerateDataProc.xsl&quot;&gt;', $cr)"/>

				<xsl:value-of select="concat($tab3, '&lt;WTPARAM entity=&quot;', $relentity, '&quot; name=&quot;', @relcolumn, '&quot;/&gt;', $cr)"/>
				<xsl:value-of select="concat($tab3, '&lt;WTJOIN name=&quot;', $relentity, '&quot;/&gt;', $cr)"/>
				<xsl:for-each select="/WTROOT/WTRELATIONSHIPS/WTRELATIONSHIP[@relentity=$me and @parent]">
					<xsl:value-of select="concat($tab3, '&lt;WTCASCADE entity=&quot;', @entity, '&quot;/&gt;', $cr)"/>
				</xsl:for-each>
				<xsl:value-of select="concat($tab2, '&lt;/WTPROCEDURE&gt;', $cr)"/>
			</xsl:if>

			<!--Get the next Parent-->
			<xsl:call-template name="ParentDelete">
				<xsl:with-param name="entity" select="$relentity"/>
				<xsl:with-param name="me" select="$me"/>
			</xsl:call-template>

		</xsl:for-each>
	</xsl:template>

	<!--***********************************************************************************************-->
	<xsl:template name="WebPages">
		<xsl:param name="entity"/>
		<xsl:param name="number"/>
		<xsl:param name="identity"/>
		<xsl:param name="title"/>
		<xsl:param name="lookup"/>
		<xsl:param name="list"/>

		<xsl:variable name="secured"><xsl:if test="$lookup"> secured="2"</xsl:if></xsl:variable>

		<xsl:variable name="enum">
			<xsl:if test="string-length($number)=1">0</xsl:if>
			<xsl:value-of select="$number"/>
		</xsl:variable>

		<!--********************************************************************************************************* -->
		<!--************ Build Add Page ***************************************************************************** -->
		<!--********************************************************************************************************* -->
		<xsl:value-of select="concat($tab2, '&lt;!--Add--&gt;', $cr)"/>
		<xsl:value-of select="concat($tab2, '&lt;WTWEBPAGE name=&quot;', $enum, '02&quot; aspstyle=&quot;GenerateWebASPAdd.xsl&quot; xslstyle=&quot;GenerateWebXSLAdd.xsl&quot;', $secured, '&gt;', $cr)"/>
		<xsl:value-of select="concat($tab3, '&lt;WTACTION name=&quot;Add&quot; type=&quot;Add&quot; id=&quot;2&quot; style=&quot;Button&quot;/&gt;', $cr)"/>
		<xsl:value-of select="concat($tab3, '&lt;WTACTION name=&quot;Cancel&quot; type=&quot;Cancel&quot; id=&quot;3&quot; style=&quot;Button&quot;/&gt;', $cr)"/>

		<!--get parent links-->
		<xsl:call-template name="ParentLink">
			<xsl:with-param name="entity" select="$entity"/>
			<xsl:with-param name="me" select="$entity"/>
		</xsl:call-template>

		<!--Build the Related To Identity Attributes-->
		<xsl:for-each select="/WTROOT/WTRELATIONSHIPS/WTRELATIONSHIP[@entity=$entity and not(@parent) and @column!=$identity]">
			<xsl:value-of select="concat($tab3, '&lt;WTATTRIBUTE name=&quot;', @column, '&quot;/&gt;', $cr)"/>
		</xsl:for-each>

		<xsl:if test="$lookup">
			<xsl:value-of select="concat($tab3, '&lt;WTATTRIBUTE name=&quot;Name&quot;/&gt;', $cr)"/>
			<xsl:value-of select="concat($tab3, '&lt;WTATTRIBUTE name=&quot;Seq&quot;/&gt;', $cr)"/>
		</xsl:if>

		<xsl:value-of select="concat($tab2, '&lt;/WTWEBPAGE&gt;', $cr, $cr)"/>

		<!--********************************************************************************************************* -->
		<!--************ Build Update Page ************************************************************************** -->
		<!--********************************************************************************************************* -->
		<xsl:value-of select="concat($tab2, '&lt;!--Update--&gt;', $cr)"/>
		<xsl:value-of select="concat($tab2, '&lt;WTWEBPAGE name=&quot;', $enum, '03&quot; aspstyle=&quot;GenerateWebASPItem.xsl&quot; xslstyle=&quot;GenerateWebXSLItem.xsl&quot;', $secured, '&gt;', $cr)"/>
		<xsl:value-of select="concat($tab3, '&lt;WTACTION name=&quot;Update&quot; type=&quot;Update&quot; id=&quot;1&quot; style=&quot;Button&quot;/&gt;', $cr)"/>
		<xsl:value-of select="concat($tab3, '&lt;WTACTION name=&quot;Cancel&quot; type=&quot;Cancel&quot; id=&quot;3&quot; style=&quot;Button&quot;/&gt;', $cr)"/>
		<xsl:value-of select="concat($tab3, '&lt;WTACTION name=&quot;Delete&quot; type=&quot;Delete&quot; id=&quot;4&quot; style=&quot;Button&quot;/&gt;', $cr)"/>

		<!--get parent links-->
		<xsl:call-template name="ParentLink">
			<xsl:with-param name="entity" select="$entity"/>
			<xsl:with-param name="me" select="$entity"/>
		</xsl:call-template>

		<!--Build the Child Links-->
		<xsl:for-each select="/WTROOT/WTRELATIONSHIPS/WTRELATIONSHIP[@relentity=$entity and @parent]">
			<xsl:variable name="relentity" select="@entity"/>
			<xsl:variable name="num" select="/WTROOT/WTENTITIES/WTENTITY[@name=$relentity]/@number"/>

			<xsl:variable name="pagename">
				<xsl:if test="string-length($num)=1">0</xsl:if>
				<xsl:value-of select="concat($num, '11')"/>
			</xsl:variable>

			<xsl:value-of select="concat($tab3, '&lt;WTLINK page=&quot;list&quot; name=&quot;', $pagename, '&quot; entity=&quot;', $relentity, '&quot;/&gt;', $cr)"/>

		</xsl:for-each>

		<!--Build the Related To Identity Attributes-->
		<xsl:for-each select="/WTROOT/WTRELATIONSHIPS/WTRELATIONSHIP[@entity=$entity and not(@parent) and @column!=$identity]">
			<xsl:value-of select="concat($tab3, '&lt;WTATTRIBUTE name=&quot;', @column, '&quot;/&gt;', $cr)"/>
		</xsl:for-each>

		<xsl:if test="$lookup">
			<xsl:value-of select="concat($tab3, '&lt;WTATTRIBUTE name=&quot;Name&quot;/&gt;', $cr)"/>
			<xsl:value-of select="concat($tab3, '&lt;WTATTRIBUTE name=&quot;Seq&quot;/&gt;', $cr)"/>
		</xsl:if>

		<xsl:value-of select="concat($tab2, '&lt;/WTWEBPAGE&gt;', $cr, $cr)"/>

		<!--********************************************************************************************************* -->
		<!--************ Build Find Page **************************************************************************** -->
		<!--********************************************************************************************************* -->
		<xsl:if test="not($lookup)">
			<xsl:value-of select="concat($tab2, '&lt;!--Find--&gt;', $cr)"/>
			<xsl:value-of select="concat($tab2, '&lt;WTWEBPAGE name=&quot;', $enum, '01&quot; aspstyle=&quot;GenerateWebASPFind.xsl&quot; xslstyle=&quot;GenerateWebXSLFind.xsl&quot;', $secured, '&gt;', $cr)"/>
			<xsl:value-of select="concat($tab3, '&lt;WTLINK page=&quot;item&quot;  name=&quot;', $enum, '03&quot; entity=&quot;', $entity, '&quot;/&gt;', $cr)"/>

			<!--Build the Entity's Title DataRow-->
			<xsl:value-of select="concat($tab3, '&lt;WTDATAROW repeat=&quot;true&quot; graybar=&quot;true&quot;&gt;', $cr)"/>
			<xsl:value-of select="concat($tab4, '&lt;WTCONDITION name=&quot;SYS(searchtype)&quot; oper=&quot;equal&quot; value=&quot;FINDID(', $title, ')&quot;/&gt;', $cr)"/>
			<xsl:value-of select="concat($tab4, '&lt;WTATTRIBUTE name=&quot;', $title, '&quot; width=&quot;20&quot; class=&quot;ColumnHeader&quot;/&gt;', $cr)"/>
			<xsl:value-of select="concat($tab3, '&lt;/WTDATAROW&gt;', $cr)"/>

			<!--Build the Parent DataRow-->
			<xsl:for-each select="/WTROOT/WTRELATIONSHIPS/WTRELATIONSHIP[@entity=$entity and @parent]">
				<xsl:variable name="relentity" select="@relentity"/>
				<xsl:variable name="relidentity" select="/WTROOT/WTENTITIES/WTENTITY[@name=$relentity]/@identity"/>
				
				<xsl:if test="not(@nodisplay)">
					<xsl:value-of select="concat($tab3, '&lt;WTDATAROW repeat=&quot;true&quot; graybar=&quot;true&quot;&gt;', $cr)"/>
					<xsl:value-of select="concat($tab4, '&lt;WTCONDITION name=&quot;SYS(searchtype)&quot; oper=&quot;equal&quot; value=&quot;FINDID(', $title, ')&quot;/&gt;', $cr)"/>
					<xsl:value-of select="concat($tab4, '&lt;WTATTRIBUTE name=&quot;', $title, '&quot; width=&quot;20&quot; class=&quot;ColumnHeader&quot;/&gt;', $cr)"/>
					<xsl:value-of select="concat($tab3, '&lt;/WTDATAROW&gt;', $cr)"/>
				</xsl:if>
			</xsl:for-each>

			<!--Build the Related To DataRow-->
			<xsl:for-each select="/WTROOT/WTRELATIONSHIPS/WTRELATIONSHIP[@entity=$entity and not(@parent) and @column!=$identity]">
				<xsl:variable name="relentity" select="@relentity"/>
				<xsl:variable name="relidentity" select="/WTROOT/WTENTITIES/WTENTITY[@name=$relentity]/@identity"/>
				
				<xsl:if test="not(@nodisplay)">
					<xsl:value-of select="concat($tab3, '&lt;WTDATAROW repeat=&quot;true&quot; graybar=&quot;true&quot;&gt;', $cr)"/>
					<xsl:value-of select="concat($tab4, '&lt;WTCONDITION name=&quot;SYS(searchtype)&quot; oper=&quot;equal&quot; value=&quot;FINDID(', $title, ')&quot;/&gt;', $cr)"/>
					<xsl:value-of select="concat($tab4, '&lt;WTATTRIBUTE name=&quot;', $title, '&quot; width=&quot;20&quot; class=&quot;ColumnHeader&quot;/&gt;', $cr)"/>
					<xsl:value-of select="concat($tab3, '&lt;/WTDATAROW&gt;', $cr)"/>
				</xsl:if>
			</xsl:for-each>

			<xsl:value-of select="concat($tab2, '&lt;/WTWEBPAGE&gt;', $cr, $cr)"/>
		</xsl:if>

		<!--********************************************************************************************************* -->
		<!--************ Build List Page **************************************************************************** -->
		<!--********************************************************************************************************* -->
		<xsl:if test="$list or $lookup">
			
			<xsl:value-of select="concat($tab2, '&lt;!--List--&gt;', $cr)"/>
			<xsl:value-of select="concat($tab2, '&lt;WTWEBPAGE name=&quot;', $enum, '11&quot; aspstyle=&quot;GenerateWebASPList.xsl&quot; xslstyle=&quot;GenerateWebXSLList.xsl&quot;', $secured, '&gt;', $cr)"/>

			<!--Build the Parent Owner Links-->
			<xsl:for-each select="/WTROOT/WTRELATIONSHIPS/WTRELATIONSHIP[@entity=$entity and @parent]">
				<xsl:if test="not(@nodisplay)">
					<xsl:variable name="relentity" select="@relentity"/>
					<xsl:variable name="num" select="/WTROOT/WTENTITIES/WTENTITY[@name=$relentity]/@number"/>
					<xsl:variable name="pagename">
						<xsl:if test="string-length($num)=1">0</xsl:if>
						<xsl:value-of select="concat($num, '03')"/>
					</xsl:variable>
					<xsl:value-of select="concat($tab3, '&lt;WTLINK page=&quot;owner&quot; name=&quot;', $pagename, '&quot; entity=&quot;', $relentity, '&quot;/&gt;', $cr)"/>
				</xsl:if>
			</xsl:for-each>

			<!--Build the Related To Owner Links-->
			<xsl:for-each select="/WTROOT/WTRELATIONSHIPS/WTRELATIONSHIP[@entity=$entity and not(@parent) and @column!=$identity]">
				<xsl:variable name="relentity" select="@relentity"/>
				<xsl:variable name="rellookup" select="/WTROOT/WTENTITIES/WTENTITY[@name=$relentity]/@lookup"/>
				<xsl:variable name="num" select="/WTROOT/WTENTITIES/WTENTITY[@name=$relentity]/@number"/>
				<xsl:variable name="pagename">
					<xsl:if test="string-length($num)=1">0</xsl:if>
					<xsl:value-of select="concat($num, '03')"/>
				</xsl:variable>
				<xsl:if test="not($rellookup or @nodisplay)">
					<xsl:value-of select="concat($tab3, '&lt;WTLINK page=&quot;owner&quot; name=&quot;', $pagename, '&quot; entity=&quot;', $relentity, '&quot;/&gt;', $cr)"/>
				</xsl:if>
			</xsl:for-each>

			<xsl:value-of select="concat($tab3, '&lt;WTLINK page=&quot;item&quot; name=&quot;', $enum, '03&quot; entity=&quot;', $entity, '&quot;/&gt;', $cr)"/>
			<xsl:value-of select="concat($tab3, '&lt;WTLINK page=&quot;new&quot; name=&quot;', $enum, '02&quot; entity=&quot;', $entity, '&quot;/&gt;', $cr)"/>

			<xsl:if test="not($lookup)">
				<xsl:variable name="datarow">
					<!--Build the Parent DataRow-->
					<xsl:for-each select="/WTROOT/WTRELATIONSHIPS/WTRELATIONSHIP[@entity=$entity and @parent]">
						<xsl:variable name="relentity" select="@relentity"/>
						<xsl:variable name="relidentity" select="/WTROOT/WTENTITIES/WTENTITY[@name=$relentity]/@identity"/>
						
						<xsl:if test="not(@nodisplay)">
							<xsl:value-of select="concat($tab3, '&lt;WTDATAROW repeat=&quot;true&quot; graybar=&quot;true&quot;&gt;', $cr)"/>
							<xsl:value-of select="concat($tab4, '&lt;WTCONDITION name=&quot;SYS(listtype)&quot; oper=&quot;equal&quot; value=&quot;LISTID(', $title, ')&quot;/&gt;', $cr)"/>
							<xsl:value-of select="concat($tab4, '&lt;WTATTRIBUTE name=&quot;', $title, '&quot; width=&quot;20&quot;/&gt;', $cr)"/>
							<xsl:value-of select="concat($tab3, '&lt;/WTDATAROW&gt;', $cr)"/>
						</xsl:if>
					</xsl:for-each>

					<!--Build the Related To DataRows-->
					<xsl:for-each select="/WTROOT/WTRELATIONSHIPS/WTRELATIONSHIP[@entity=$entity and not(@parent) and @column!=$identity]">
						<xsl:variable name="relentity" select="@relentity"/>
						<xsl:variable name="relidentity" select="/WTROOT/WTENTITIES/WTENTITY[@name=$relentity]/@identity"/>
						<xsl:variable name="rellookup" select="/WTROOT/WTENTITIES/WTENTITY[@name=$relentity]/@lookup"/>
						<xsl:if test="not($rellookup or @nodisplay)">
							<xsl:value-of select="concat($tab3, '&lt;WTDATAROW repeat=&quot;true&quot; graybar=&quot;true&quot;&gt;', $cr)"/>
							<xsl:value-of select="concat($tab4, '&lt;WTCONDITION name=&quot;SYS(listtype)&quot; oper=&quot;equal&quot; value=&quot;LISTID(', $title, ')&quot;/&gt;', $cr)"/>
							<xsl:value-of select="concat($tab4, '&lt;WTATTRIBUTE name=&quot;', $title, '&quot; width=&quot;20&quot;/&gt;', $cr)"/>
							<xsl:value-of select="concat($tab3, '&lt;/WTDATAROW&gt;', $cr)"/>
						</xsl:if>
					</xsl:for-each>
				</xsl:variable>
		
				<xsl:if test="string-length($datarow)=0">
					<xsl:value-of select="concat($tab3, '&lt;WTDATAROW repeat=&quot;true&quot; graybar=&quot;true&quot;&gt;', $cr)"/>
					<xsl:value-of select="concat($tab4, '&lt;WTATTRIBUTE name=&quot;', $title, '&quot; width=&quot;20&quot;/&gt;', $cr)"/>
					<xsl:value-of select="concat($tab3, '&lt;/WTDATAROW&gt;', $cr)"/>
				</xsl:if>
				<xsl:if test="string-length($datarow)>0">
					<xsl:value-of select="$datarow"/>
				</xsl:if>
			</xsl:if>

			<xsl:if test="$lookup">
				<xsl:value-of select="concat($tab3, '&lt;WTDATAROW repeat=&quot;true&quot; graybar=&quot;true&quot;&gt;', $cr)"/>
				<xsl:value-of select="concat($tab4, '&lt;WTATTRIBUTE name=&quot;Seq&quot; width=&quot;15&quot;/&gt;', $cr)"/>
				<xsl:value-of select="concat($tab4, '&lt;WTATTRIBUTE name=&quot;Name&quot; width=&quot;85&quot;/&gt;', $cr)"/>
				<xsl:value-of select="concat($tab3, '&lt;/WTDATAROW&gt;', $cr)"/>
			</xsl:if>

			<xsl:value-of select="concat($tab2, '&lt;/WTWEBPAGE&gt;', $cr, $cr)"/>

		</xsl:if>

	</xsl:template>

	<!--***********************************************************************************************-->
	<xsl:template name="ParentLink">
		<xsl:param name="entity"/>
		<xsl:param name="me"/>

		<xsl:for-each select="/WTROOT/WTRELATIONSHIPS/WTRELATIONSHIP[@entity=$entity and @parent]">
			<xsl:variable name="relentity" select="@relentity"/>
			<xsl:variable name="number" select="/WTROOT/WTENTITIES/WTENTITY[@name=$relentity]/@number"/>

			<!--Get the next Parent-->
			<xsl:call-template name="ParentLink">
				<xsl:with-param name="entity" select="$relentity"/>
				<xsl:with-param name="me" select="$me"/>
			</xsl:call-template>

				<xsl:variable name="pagename">
					<xsl:if test="string-length($number)=1">0</xsl:if>
					<xsl:value-of select="concat($number, '03')"/>
				</xsl:variable>
				<xsl:value-of select="concat($tab3, '&lt;WTLINK page=&quot;parent&quot; name=&quot;', $pagename, '&quot; entity=&quot;', $relentity, '&quot;/&gt;', $cr)"/>

		</xsl:for-each>
	</xsl:template>

</xsl:stylesheet>

