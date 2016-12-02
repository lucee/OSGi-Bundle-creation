<!--- developer of the created project --->
<cfsavecontent variable="developer">
    <developer>
      <id>micstriit</id>
      <name>Michael Offner</name>
      <email>michael@lucee.org</email>
      <organization>Lucee Association Switzerland</organization>
      <organizationUrl>http://lucee.org</organizationUrl>
      <roles>
        <role>Project-Administrator</role>
        <role>Developer</role>
      </roles>
      <timezone>+1</timezone>
    </developer>
</cfsavecontent>
<!--- licencess --->
<cfsavecontent variable="license.apache">
    <license>
      <name>Apache License, Version 1.0</name>
      <url>http://www.apache.org/licenses/LICENSE-1.0.txt</url>
      <distribution>repo</distribution>
      <comments>A business-friendly OSS license</comments>
    </license>
</cfsavecontent>
<cfsavecontent variable="license.apache2">
    <license>
      <name>Apache License, Version 2.0</name>
      <url>http://www.apache.org/licenses/LICENSE-2.0.txt</url>
      <distribution>repo</distribution>
      <comments>A business-friendly OSS license</comments>
    </license>
</cfsavecontent>
<cfsavecontent variable="license.cpl1">
    <license>
      <name>Common Public License 1.0</name>
      <url>http://opensource.org/licenses/cpl1.0.php</url>
      <distribution>repo</distribution>
    </license>
</cfsavecontent>
<cfsavecontent variable="license.gpl2">
    <license>
      <name>GNU GENERAL PUBLIC LICENSE Version 2</name>
      <url>http://www.gnu.org/licenses/gpl-2.0.txt</url>
      <distribution>repo</distribution>
    </license>
</cfsavecontent>
<cfsavecontent variable="license.bsd">
    <license>
		<name>BSD License</name>
		<url>http://www.opensource.org/licenses/bsd-license.php</url>
		<distribution>repo</distribution>
	</license>
</cfsavecontent>
<cfsavecontent variable="license.sax">
	<license>
		<name>The SAX License</name>
		<url>http://www.saxproject.org/copying.html</url>
		<distribution>repo</distribution>
	</license>
</cfsavecontent>
<cfsavecontent variable="license.lgpl2">
    <license>
        <name>GNU Lesser General Public License, version 2</name>
        <url>https://www.gnu.org/licenses/lgpl-2.0-standalone.html</url>
    </license>
</cfsavecontent>
<cfsavecontent variable="license.lgpl21">
    <license>
        <name>GNU Lesser General Public License, version 2.1</name>
        <url>https://www.gnu.org/licenses/lgpl-2.1-standalone.html</url>
    </license>
</cfsavecontent>
<cfsavecontent variable="license.lgpl3">
    <license>
      <name>GNU Lesser General Public License, Version 3.0</name>
      <url>http://www.gnu.org/licenses/lgpl-3.0.txt</url>
      <distribution>repo</distribution>
    </license>
</cfsavecontent>
<cfsavecontent variable="license.mpl">
    <license>
        <name>Mozilla Public License Version 1.1</name>
        <url>https://www.mozilla.org/MPL/1.1/</url>
    </license>
</cfsavecontent>
<cfsavecontent variable="license.mpl2">
    <license>
        <name>Mozilla Public License Version 2.0</name>
        <url>http://www.mozilla.org/MPL/2.0/</url>
    </license>
</cfsavecontent>
<cfsavecontent variable="license.bcl">
	<license>
		<name>Sun Microsystems, Inc. Binary Code License Agreement</name>
		<url>http://java.sun.com</url>
	</license>
</cfsavecontent>
<cfsavecontent variable="license.cc3">
	<license>
		<name>Creative Commons 3.0 BY-SA</name>
		<url>http://creativecommons.org/licenses/by-sa/3.0/</url>
		<comments>Content License - Create Commons 3.0 BY-SA</comments>
	</license>
</cfsavecontent>
<cfsavecontent variable="license.cddl1">
	<license>
		<name>COMMON DEVELOPMENT AND DISTRIBUTION LICENSE Version 1.0</name>
		<url>https://opensource.org/licenses/CDDL-1.0</url>
		<comments>COMMON DEVELOPMENT AND DISTRIBUTION LICENSE Version 1.0 </comments>
	</license>
</cfsavecontent>
<cfsavecontent variable="license.mit">
	<license>
		<name>MIT license</name>
		<url>http://www.opensource.org/licenses/mit-license.php</url>
		<comments>The MIT License (MIT)</comments>
	</license>
</cfsavecontent>
<cfsavecontent variable="license.bouncycastle">
	<license>
		<name>Bouncy Castle Licence</name>
		<url>http://www.bouncycastle.org/licence.html</url>
		<comments></comments>
	</license>
</cfsavecontent>
<cfsavecontent variable="license.eclipse">
	<license>
		<name>Eclipse Public License - v 1.0</name>
		<url>http://www.eclipse.org/legal/epl-v10.html</url>
		<comments></comments>
	</license>
</cfsavecontent>
<cfsavecontent variable="license.hunterhacker">
	<license>
		<name>Jason Hunter and Brett McLaughlin</name>
		<url>https://raw.github.com/hunterhacker/jdom/master/LICENSE.txt</url>
		<comments></comments>
	</license>
</cfsavecontent>





<cfscript>
//////////////////////////// CUSTOMIZE BEGINNING /////////////////////////////
projectFolder=<target where the maven project should be built>;//"/Users/mic/Projects/Lucee/jar2osgi/";
githubTarget="https://github.com/lucee/osgi-bundle-{id}.git";
/*
* 2 example projects, groupid, artifactid and versionneed to come from central maven.
* symbolicName and bundleVersion are the identifier you wish for the OSGi bundle created, 
* please have in mind that a OSGi Bundle version need to follow that pattern: <number>.<number>.<number>[.<string>]
*/
projects={

	'commons-logging-adapters':{
		version:'1.1'
		,bundleVersion:'1.1.0'
		,label:'Apache Commons Logging Adapters'
		,groupId:'commons-logging'
		,artifactId:'commons-logging-adapters'
		,symbolicName: 'org.lucee.commons.logging.adapters'
		,developer:developer
		,license:license.apache2
		,requireBundle: 'org.lucee.commons.logging.api;bundle-version=1.1.0,log4j;bundle-version=1.2.17'
		,dynamicImportPackage:"org.apache.log,org.apache.avalon.framework.logger"
	}
	,'xalan-serializer':{
		version:'2.7.2'
		,bundleVersion:'2.7.2'
		,label:'Xalan Serializer'
		,groupId:'xalan'
		,artifactId:'serializer'
		,symbolicName: 'org.lucee.xalan.serializer'
		,developer:developer
		,license:license.apache2
		,fragmentHost:"org.lucee.xalan"
		,requireBundle:"org.lucee.xml.xerces;bundle-version=2.11.0,org.lucee.xml.apis;bundle-version=1.4.1"
	}
//////////////////////////// CUSTOMIZE END /////////////////////////////


};

//////////////////////////// BUILD /////////////////////////////
curr=getDirectoryFromPath(getCurrentTemplatePath());
template=curr&"jar2osgi/";
dir=curr&"trg-jar2osgi/";


if(directoryExists(dir)) directoryDelete(dir,true);
directoryCreate(dir);

tmpPom=fileRead(template&"pom.xml");
tmpIgnore=fileRead(template&".gitignore");

loop struct=projects item="project" index="id" {

	if(isNull(project.bundleVersion))project.bundleVersion=project.version;

	trg=dir&"osgi-bundle-"&id&"/";
	trg2=projectFolder&"osgi-bundle-"&id&"/";

	//if(directoryExists(trg2)) continue;

	echo("
<pre>
<b>#project.label#</b>
");

if(!directoryExists(trg2))
	echo("
create git: osgi-bundle-#id#

install:
	cd #trg2#
	git init
	git add .
	git commit -m ""inital commit""
	git remote add origin #replace(githubTarget,'{id}',id,'all')#
	git push -u origin master
");


	echo(replace("
deploy:
	mvn -DperformRelease=true clean deploy
or
	mvn clean install

set in poms (loader and core):
  <dependency>
  	<groupId>org.lucee</groupId>
  	<artifactId>#id#</artifactId>
  	<version>#project.bundleVersion#</version>
  </dependency>

set in MANIFEST.MF:
	#project.symbolicName#;bundle-version=#project.bundleVersion#,

",'<','&lt;','all'));

	echo("</pre>");




	directoryCreate(trg);
	pom=replace(tmpPom,'{id}',id,'all');
	pom=replace(pom,'{version}',project.version,'all');
	pom=replace(pom,'{label}',project.label,'all');
	pom=replace(pom,'{groupId}',project.groupId,'all');
	pom=replace(pom,'{artifactId}',project.artifactId,'all');
	pom=replace(pom,'{developer}',project.developer,'all');
	pom=replace(pom,'{license}',project.license,'all');
	pom=replace(pom,'{symbolicName}',project.symbolicName,'all');
	pom=replace(pom,'{bundleVersion}',project.bundleVersion,'all');
	
	if(!isNull(project.requireBundle))
		pom=replace(pom,
			'<!-- <Require-Bundle></Require-Bundle> -->',
			'<Require-Bundle>#project.requireBundle#</Require-Bundle>','all');

	if(!isNull(project.requireBundleFragment))
		pom=replace(pom,
			'<!-- <Require-Bundle-Fragment></Require-Bundle-Fragment> -->',
			'<Require-Bundle-Fragment>#project.requireBundleFragment#</Require-Bundle-Fragment>','all');

	if(!isNull(project.dynamicImportPackage)) {
		pom=replace(pom,
			'<!-- <DynamicImport-Package>*</DynamicImport-Package> -->',
			'<DynamicImport-Package>#project.dynamicImportPackage#</DynamicImport-Package>','all');
		pom=replace(pom,
			'<!-- <Import-Package>*</Import-Package> -->',
			'<Import-Package>!#ListChangeDelims(listItemTrim(project.dynamicImportPackage),',!')#,*</Import-Package>','all');
	}
	if(!isNull(project.importPackage)) {
		pom=replace(pom,
			'<!-- <Import-Package>*</Import-Package> -->',
			'<Import-Package>#project.importPackage#,*</Import-Package>','all');
	}
	if(!isNull(project.fragmentHost)) {
		pom=replace(pom,
			'<!-- <Fragment-Host></Fragment-Host> -->',
			'<Fragment-Host>#project.fragmentHost#</Fragment-Host>','all');
	}
	//ListChangeDelims( list, new_delimiter [, delimiters [, includeEmptyFields [, multiCharacterDelimiter ] ] ] )

	
// <Require-Bundle>a.b.c</Require-Bundle>



	fileWrite(trg&"pom.xml",pom);
	fileWrite(trg&".gitignore",tmpIgnore);

	if(!directoryExists(trg2)) {
		directoryCreate(trg2);
		fileWrite(trg2&"pom.xml",pom);
		fileWrite(trg2&".gitignore",tmpIgnore);
	}
}





</cfscript>


