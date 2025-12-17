<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" id="app-xsl">
	<xsl:key name="variables" match="variable" use="text()" />

	<xsl:template match="/document">
		<document>
			<variables>
				<xsl:for-each select="variable[generate-id() = generate-id(key('variables', text())[1])]">
					<variable position="{position()}">
						<xsl:value-of select="text()" />
					</variable>
				</xsl:for-each>
			</variables>
		</document>
	</xsl:template>
</xsl:stylesheet>
