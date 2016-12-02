
<cfset versions={

/**
* Example how a record should look like, only set criteria you need to customize,
* If not set Lucee will figure them out, for example if "exportPackage" is not set, Lucee will simply add all packages in the jar.
* if "ignoreExistingManifest" is set to false, you extend the existing manifest.
*/
'example.jar':{
	file:"example.jar"
	,name:"example"
	,version:"1.2.3.4"
	,dynamicImportPackage:"org.lucee.whatever"
	,bundleActivator:"none"
	,importPackage:"org.lucee.whatelse"
	,exportPackage:"org.lucee.susi"
	,requireBundle:"susi.sorglos;bundle-version=1.2.3.4"
	,requireBundleFragment:"susi.sorglos.whatever;bundle-version=1.2.3.4"
	,bundleActivationPolicy:"lazy"
	,fragmentHost:"example.base"
	,ignoreExistingManifest:false
}

}>

<!--- jars to ignore, that are used to load other jars needed. --->
<cfset ignore={'javax.servlet.jar':'','org.mortbay.jetty.jar':'','railo-inst.jar':''}>

<!--- build 3 party bundles --->

<h1>convert one of the following</h1>
<cfdirectory action="list" directory="#request.currentPath#" name="dir">
<cfoutput><a href="?source=all">--- all ---</a></cfoutput><br>
<cfloop query="#dir#">
	<cfif dir.type=="Dir" && dir.name!="trg">
		<cfoutput><a href="?source=#dir.name#">#dir.name#</a></cfoutput><br>
	</cfif>
</cfloop>
<cfif dir.recordcount==0>
	<h2>there is no directory in #request.currentPath# that contains jar files.</h2>
</cfif>
<cfif !isDefined("url.source")>
	<cfabort>
</cfif>



<cfset tmp=request.currentPath&"tmp/">
<cfset trg=request.currentPath&"trg/">


<cfif directoryExists(tmp)>
	<cfdirectory action="delete" directory="#tmp#" recurse="true">
</cfif>
<cfif directoryExists(trg)>
	<cfdirectory action="delete" directory="#trg#" recurse="true">
</cfif>

<cfif !directoryExists(tmp)>
	<cfdirectory action="create" directory="#tmp#">
</cfif>

<cfif !directoryExists(trg)>
	<cfdirectory action="create" directory="#trg#">
</cfif>

<cfif url.source == "all">
	<cfloop query="#dir#">
		<cfif dir.type=="Dir" && dir.name!="trg">
			<cfset build(request.currentPath&"#dir.name#/")>
		</cfif>
	</cfloop>
<cfelse>
	<cfset build(request.currentPath&"#url.source#/")>
</cfif>



<cffunction name="build" localMode="true">
	<cfargument name="src" type="string" required="true">

	<cfset local.pom="">
	<cfset local.dep="">
	<cfset local.req="">

	<cfdirectory action="list" directory="#src#" filter="*.jar" name="jars">
	<cfloop query="#jars#">
		<cfif structKeyExists(ignore,jars.name)>
			<cfcontinue>
		</cfif>
		<!--- if there is no info we simply copy the file --->
		<cfif !structKeyExists(versions,jars.name)>
			<cffile action="copy" 
				source="#jars.directory#/#jars.name#" 
				destination="#trg#/#jars.name#" nameconflict="overwrite">
			<cfcontinue>
		</cfif>
		
		<!--- create the bundle    FragmentHost="railo.core" --->
		<cfadmin action="buildBundle"
			name="#versions[jars.name].name#" 
			jar="#jars.directory#/#jars.name#"
			version="#versions[jars.name].version#"
			bundleActivationPolicy="#isNull(versions[jars.name].bundleActivationPolicy)?'':versions[jars.name].bundleActivationPolicy#"
			bundleActivator="#isNull(versions[jars.name].bundleActivator)?'':versions[jars.name].bundleActivator#"
			exportPackage="#isNull(versions[jars.name].exportPackage)?'':versions[jars.name].exportPackage#"
			importPackage="#isNull(versions[jars.name].importPackage)?'':versions[jars.name].importPackage#"
			fragmentHost="#isNull(versions[jars.name].fragmentHost)?'':versions[jars.name].fragmentHost#"
			dynamicImportPackage="#isNull(versions[jars.name].dynamicImportPackage)?'':versions[jars.name].dynamicImportPackage#"
			requireBundle="#isNull(versions[jars.name].requireBundle)?'':versions[jars.name].requireBundle#"
			requireBundleFragment="#isNull(versions[jars.name].requireBundleFragment)?'':versions[jars.name].requireBundleFragment#"
			ignoreExistingManifest="#!isNull(versions[jars.name].ignoreExistingManifest) and versions[jars.name].ignoreExistingManifest#"
			pom=true
			destination="#tmp#/#jars.name#">
		
		<!--- read it to get symbolic name and version in valid format --->
		<cfadmin action="readBundle"
			bundle="#tmp#/#jars.name#"
			returnvariable="bundle">
		<!--- change temporary name --->
		<cffile action="move" 
				source="#tmp#/#jars.name#" 
				destination="#trg#/#replace(bundle.SymbolicName,'.','-','all')#-#replace(bundle.Version,'.','-','all')#.jar">
		
		<!--- <cffile action="move" 
				source="#trg#/#jars.name#" 
				destination="#trg#/#replace(bundle.SymbolicName,'.','-','all')#-#replace(bundle.Version,'.','-','all')#.jar">--->
		 <cfoutput>
		 #bundle.SymbolicName# - 
		#jars.name# --> #trg#/#replace(bundle.SymbolicName,'.','-','all')#-#replace(bundle.Version,'.','-','all')#.jar<br>
		
		<cfset local.last=listLast(bundle.SymbolicName,'.')>
		<cfset local.len=listLen(bundle.SymbolicName,'.')>
		<cfif local.len GT 1>
			<cfset local.rest=reverse(listRest(list:reverse(bundle.SymbolicName),offset:1,delimiters:'.'))>
		<cfelse>
			<cfset local.rest=last>
		</cfif>
		<cfsavecontent variable="pom" trim>
#pom#
<!-- #bundle.SymbolicName# - #bundle.Version# -->
		<execution>
			<id>#bundle.SymbolicName#-#bundle.Version#</id>
			<phase>initialize</phase>
			<goals>
				<goal>install-file</goal>
			</goals>
			<configuration>
				<groupId>#local.rest#</groupId>
				<artifactId>#local.last#</artifactId>
				<version>#bundle.Version#</version>
				<packaging>jar</packaging>
				<createChecksum>true</createChecksum>
				<generatePom>true</generatePom>
				<localRepositoryPath>${dir.trg}</localRepositoryPath>
				<file>${dir.src}/#replace(bundle.SymbolicName,'.','-','all')#-#replace(bundle.Version,'.','-','all')#.jar</file>
			</configuration>
		</execution>
</cfsavecontent>

<cfsavecontent variable="dep" trim>
#dep#
<!-- #bundle.SymbolicName# - #bundle.Version# -->
		<dependency>
			<groupId>#local.rest#</groupId>
			<artifactId>#local.last#</artifactId>
			<type>jar</type>
			<version>#bundle.Version#</version>
			<scope>compile</scope>
		</dependency>
</cfsavecontent>

<!--- Require-bundle --->
<cfscript>
	if(len(req)>0)req&=",
";
	req&=" "&bundle.SymbolicName&";bundle-version="&bundle.Version;

</cfscript>




		

		</cfoutput>
	</cfloop>

<h2>install file (for mvn-repo)</h2>
	<cfset echo(replace(replace(replace(pom,'	','&nbsp;&nbsp;&nbsp;','all'),'<','&lt;','all'),'
','<br>','all'))>


<h2>dependency (for core)</h2>

	<cfset echo(replace(replace(replace(dep,'	','&nbsp;&nbsp;&nbsp;','all'),'<','&lt;','all'),'
','<br>','all'))>

<h2>require-bundle</h2>

	<cfset echo("Require-Bundle:"&replace(replace(replace(req,'	','&nbsp;&nbsp;&nbsp;','all'),'<','&lt;','all'),'
','<br>','all'))>

</cffunction>

<cfif directoryExists(tmp)>
		<cfdirectory action="delete" directory="#tmp#" recurse="true">
	</cfif>


