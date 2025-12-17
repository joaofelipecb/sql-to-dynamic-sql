# Overview
This set of XSLT files are intented to replace variables in_* in SQL file with $n to be used in dynamic queries.

# How to use
```bash
mit -s unlimited
xsltproc --huge --maxdepth 60000 --maxvars 40000 parser.xsl temp/input.xml > temp/parsed.xml
xsltproc --huge --maxdepth 60000 --maxvars 40000 list-variables.xsl temp/parsed.xml > temp/variables.xml
xsltproc --huge --maxdepth 60000 --maxvars 40000 generate-replacer.xsl temp/variables.xml > temp/replacer.xsl
xslxsltproc --huge --maxdepth 60000 --maxvars 40000 temp/replacer.xsl temp/parsed.xml
```
