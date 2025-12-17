<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:axsl="http://www.w3.org/1999/XSL/TransformAlias">
	<xsl:namespace-alias stylesheet-prefix="axsl" result-prefix="xsl"/>

	<xsl:template match="/document">
		<axsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
			<axsl:template match="@*|node()">
				<axsl:copy>
					<axsl:apply-templates select="@*|node()"/>
				</axsl:copy>
			</axsl:template>
			
			<axsl:template match="variable">
				<axsl:choose>
					<xsl:for-each select="variables/variable">
						<xsl:variable name="code" select="text()" />
						<axsl:when>
							<xsl:attribute name="test">
								<xsl:text>text() = '</xsl:text><xsl:value-of select="text()" /><xsl:text>'</xsl:text>
							</xsl:attribute>
							<xsl:text>$</xsl:text>
							<xsl:value-of select="@position" />
						</axsl:when>
					</xsl:for-each>
				</axsl:choose>
			</axsl:template>
		</axsl:stylesheet>
	</xsl:template>
</xsl:stylesheet>
