<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:include href="GenerateIncludeXSL.xsl"/>
<!--=====================================================================
	Auth:   Bob Wood
	Date:   February 2002
	Desc:   Validates the Application.xml file
	Copyright 2002 WinTech, Inc.
======================================================================-->

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

	<xsl:template match="WTROOT">
	
		<xsl:variable name="cnt" select="count(/WTROOT/WTENTITIES/WTENTITY[ not(@number=preceding::WTENTITY/@number)])"/>
		<!--TEST unique Entity Numbers-->
		<xsl:if test="count(/WTROOT/WTENTITIES/WTENTITY/@number)!=$cnt">
			<xsl:value-of select="concat( 'All Entity Numbers are NOT Unique',$cr)"/>
		</xsl:if>

		<xsl:variable name="cnt2" select="count(/WTROOT/WTENTITIES/WTENTITY[ not(@alias=preceding::WTENTITY/@alias)])"/>
		<!--TEST unique Entity Aliases-->
		<xsl:if test="count(/WTROOT/WTENTITIES/WTENTITY/@alias)!=$cnt2">
			<xsl:value-of select="concat( 'All Entity Aliases are NOT Unique',$cr)"/>
		</xsl:if>

		<xsl:variable name="cnt3" select="count(/WTROOT/WTENTITIES/WTENTITY[ not(@name=preceding::WTENTITY/@name)])"/>
		<!--TEST unique Entity Names-->
		<xsl:if test="count(/WTROOT/WTENTITIES/WTENTITY/@name)!=$cnt3">
			<xsl:value-of select="concat( 'All Entity Names are NOT Unique',$cr)"/>
		</xsl:if>

		<xsl:if test="count(/WTROOT/WTENTITIES/WTENTITY[@lookup])=0">
			<xsl:value-of select="concat( 'No Lookup List Entities are defined',$cr)"/>
		</xsl:if>

		<xsl:for-each select="/WTROOT/WTENTITIES/WTENTITY">
	
			<xsl:variable name="prefix" select="/WTROOT/@prefix"/>	
			<xsl:variable name="name" select="@name"/>	
			<xsl:variable name="file" select="concat( $prefix, $name, '\', $name, '.xml' )"/>
			
			<xsl:if test="@file">
				<xsl:if test="$file!=@file">
					<xsl:value-of select="concat( 'Invalid Entity Filename (', $file,')',$cr)"/>
				</xsl:if>
			</xsl:if>
			
		</xsl:for-each>

		<xsl:for-each select="/WTROOT/WTRELATIONSHIPS/WTRELATIONSHIP">
	
			<xsl:variable name="entity" select="@entity"/>	
			<xsl:variable name="relentity" select="@relentity"/>	
	
			<xsl:if test="not(/WTROOT/WTENTITIES/WTENTITY[@name=$entity])">
				<xsl:value-of select="concat( 'Invalid Relationship Entity (', $entity,')',$cr)"/>
			</xsl:if>
			<xsl:if test="not(/WTROOT/WTENTITIES/WTENTITY[@name=$relentity])">
				<xsl:value-of select="concat( 'Invalid Relationship Related Entity (', $relentity,')',$cr)"/>
			</xsl:if>

		</xsl:for-each>

		<xsl:for-each select="/WTROOT/WTUSERGROUPS/WTUSERGROUP">
	
			<xsl:if test="@entity">
				<xsl:variable name="entity" select="@entity"/>	
				<xsl:if test="not(/WTROOT/WTENTITIES/WTENTITY[@name=$entity])">
					<xsl:value-of select="concat( 'Invalid User Group Entity (', $entity,')',$cr)"/>
				</xsl:if>
			</xsl:if>

		</xsl:for-each>

		<xsl:for-each select="/WTROOT/WTNAVBAR/WTITEM">

			<xsl:if test="@name">	
			
				<xsl:variable name="entity" select="@name"/>	
	
				<xsl:if test="not(/WTROOT/WTENTITIES/WTENTITY[@name=$entity])">
					<xsl:value-of select="concat( 'Invalid NavBar Item Entity (', @name,')',$cr)"/>
				</xsl:if>
				
			</xsl:if>
			<xsl:if test="@section">	
			
				<xsl:if test="@secure">
					<xsl:value-of select="concat( 'NavBar Section can not be Secure (', @section,')',$cr)"/>
				</xsl:if>
				
			</xsl:if>
				
		</xsl:for-each>

		<xsl:for-each select="/WTROOT/WTNAVBAR/WTSECTION">
			<xsl:for-each select="WTITEM">
	
				<xsl:variable name="entity" select="@name"/>	
	
				<xsl:if test="not(/WTROOT/WTENTITIES/WTENTITY[@name=$entity])">
					<xsl:value-of select="concat( 'Invalid NavBar Section Item Entity (', $entity,')',$cr)"/>
				</xsl:if>
					
			</xsl:for-each>
		</xsl:for-each>

	</xsl:template>

</xsl:stylesheet>

