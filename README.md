
# OSGi Bundle creation
This repo provides you with CFML code that allows to build OSGi bundles.
There are 2 ways to do it. Convert a regular local physical jar to an OSGi bundle or create a maven Project that extends an existing maven project that defines a regular jar.
Look for "//////////////////////////// CUSTOMIZE BEGINNING /////////////////////////////" in both script to set your data.


## Regular Jar to OSGi Bundle
This script simply takes a existing jar you have on your system and converts that jar to an OSGi bundle.
In the file "jar2osgi.cfm" simply define the configuration for your jar and then copy that jar in a sub directory next to the file "jar2osgi.cfm".

## Maven Jar to Maven OSGi Bundle
This is the **preferred** way to do it. Important to know, the script "mavenjar2osgi.cfm" does not create a jar directly, it creates a maven built script.
That built script then can be executed with "mvn install" on command line to create the OSGi bundle locally or you do "mvn deploy" to publish it on central maven directly or your own maven repo.

"mavenjar2osgi.cfm" also creates all script necessary in the result page of the browser to publish that mvn script as a new repo to github.
This is an example that was created that way https://github.com/lucee/osgi-bundle-aspectj

In addition you get in the browser output information, how you can use that bundle in your enviroment as a Maven dependency or as an OSGi bundle.

This is the **preferred** way to do it, because it is easy to improve and repeat to anybody in the world, as soon that github repo containg your maven script is published, everybody can improve it, update for a new version of the source jar for example.
