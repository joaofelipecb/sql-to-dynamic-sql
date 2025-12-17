<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" id="app-xsl">
	<xsl:template match="/document">
		<document>
			<xsl:call-template name="process">
				<xsl:with-param name="text" select="./text()" />
				<xsl:with-param name="current" select="1" />
			</xsl:call-template>
		</document>
	</xsl:template>

	<xsl:variable name="alphanumeric" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_'" />
		
	<xsl:template name="process">
		<xsl:param name="text" />
		<xsl:param name="current" />
		<xsl:if test="$current &lt; string-length($text)">
			<xsl:choose>
				<xsl:when test="translate(substring($text, $current, 1), $alphanumeric, '') != ''">
					<xsl:choose>
						<xsl:when test="substring($text, $current+1, 3) = 'in_'">
							<xsl:value-of select="substring($text, $current, 1)" />
							<variable>
								<xsl:text>in_</xsl:text>
								<xsl:call-template name="copy-until-nonalphanumeric">
									<xsl:with-param name="text" select="$text" />
									<xsl:with-param name="current" select="$current + string-length(' in_')" />
								</xsl:call-template>
							</variable>
							<xsl:variable name="jump">
								<xsl:call-template name="distance-until-nonalphanumeric">
									<xsl:with-param name="text" select="$text" />
									<xsl:with-param name="current" select="$current + 1" />
								</xsl:call-template>
							</xsl:variable>
							<xsl:call-template name="process">
								<xsl:with-param name="text" select="$text" />
								<xsl:with-param name="current" select="$current + $jump" />
							</xsl:call-template>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="substring($text, $current, 1)" />
							<xsl:call-template name="process">
								<xsl:with-param name="text" select="$text" />
								<xsl:with-param name="current" select="$current + 1" />
							</xsl:call-template>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="substring($text, $current, 1)" />
					<xsl:call-template name="process">
						<xsl:with-param name="text" select="$text" />
						<xsl:with-param name="current" select="$current + 1" />
					</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
	</xsl:template>
	
	<xsl:template name="copy-until-nonalphanumeric">
		<xsl:param name="text" />
		<xsl:param name="current" />
		<xsl:if test="$current &lt; string-length($text)">
			<xsl:if test="translate(substring($text, $current, 1), $alphanumeric, '') = ''">
				<xsl:value-of select="substring($text, $current, 1)" />
				<xsl:call-template name="copy-until-nonalphanumeric">
					<xsl:with-param name="text" select="$text" />
					<xsl:with-param name="current" select="$current + 1" />
				</xsl:call-template>
			</xsl:if>
		</xsl:if>
	</xsl:template>
	
	<xsl:template name="distance-until-nonalphanumeric">
		<xsl:param name="text" />
		<xsl:param name="current" />
		<xsl:param name="accumulator" select="1" />
		<xsl:if test="$current &lt; string-length($text)">
			<xsl:choose>
				<xsl:when test="translate(substring($text, $current, 1), $alphanumeric, '') = ''">
					<xsl:call-template name="distance-until-nonalphanumeric">
						<xsl:with-param name="text" select="$text" />
						<xsl:with-param name="current" select="$current + 1" />
						<xsl:with-param name="accumulator" select="$accumulator + 1" />
					</xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$accumulator" />
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>
