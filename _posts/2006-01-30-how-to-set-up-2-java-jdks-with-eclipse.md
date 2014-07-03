---
layout: post
title: How To Set Up 2 Java JDKs With Eclipse
category: Programming
tags: []
status: publish
type: post
published: true
---

At work, I maintain a legacy application written in Java 1.4.  However, as a Java nerd, I do all of my new development on other projects in Java 5.0.  Therefore, I had the somewhat challenging task of setting up two versions of Java in my development environment.  While this process wasn't difficult, it was somewhat complicated, and I've had to show a few people at work how to do it, so I thought I'd share it.

This post is for Windows users running [Eclipse](http://www.eclipse.org/") 3.1 or newer (prior versions did not support Java 5).

First you need to decide on which version of Java will be your "primary" version and which will be your "secondary" version.  Basically, you need to decide which version of Java will be your primary JDK, and which will the exception to that.  If your primary role at work is a maintainer of old systems, you want the old version of Java.  If you're going to be doing a lot of new development, you want the new version.  If you do a lot of work with ColdFusion (like we do at my job), you'll want the old version, as Java 5 is not currently supported by JRun (though it is possible to swap it in, but you gain little to nothing by doing that).

Now you have to install both.  It is unfortunate that Sun no longer offers the JDK as a zip file - you can only download installer exe files for Windows.  Thus, you will have to somewhat clever.  First install what will be your "secondary" JDK (Note: Eclipse only requires a JRE, even to compile code.  However, the JDK comes with a number of useful development tools, so I recommend it anyway).  It will install a bunch of stuff all over.  Find the directory where it installs the JDK (I usually use something like c:\Java\jdk_versionNumber) and back it up somewhere.  Now uninstall the JDK from Add/Remove Programs.  Next, install your primary JDK.  Then put the backup back where it used to be.  Now you should have to separate directories with two different JDK versions.  Your environment variables should be set up to use the Primary JDK (the Installer does this) and you're done installing Java.

Next install Eclipse.  It will probably detect your primary JDK and try to use it, but I'll assume it didn't for the purpose of this tutorial, in case you are trying to modify an existing Eclipse installation.  To install your primary JDK (again, Eclipse only needs a JRE), do the following:

 1. In Eclipse, click Window / Preferences
 2. Now select Java / Installed JREs
 3. Click Add
 4. Leave the type as Standard VM
 5. Name it "Java 1.4 JRE" or "Java 5 JRE" depending on which you are setting up.
 6. Click "Browse" next to Home Directory
 7. Select the JRE subdirectory in the JDK directory you want.  If the JDK were in c:\jdk1.5.0_06, the directory you want to select is c:\jdk1.5.0_06\jre
 8. It should add the library Jar files you need.
 9. Click OK

Now repeat those instructions for the secondary JRE.  When done, you should have both JDKs in your list, but a checkmark next to the entry for your Primary JDK.

Eclipse will now use your primary JDK as the default when you make a new project or when you open an existing one.  

To make Eclipse use your secondary JRE for a specific project, follow these instructions:

 1. Right click on your project in the navigator or package explorer
 2. Select Properties
 3. Click Java Build Path
 4. You should see the primary JRE in the list under the "Libraries" tab.  Click it, then click Edit
 5. Choose Alternate JRE
 6. Select your secondary JRE from your list.
 7. Click Finish
 8. Now Select Java Compiler on your properties window
 9. Check off "Enable Project Specific Settings". This will let this project, and this project alone, not use the default project settings.
 10. Set compiler compliance to the version number for your secondary JRE. Leave everything else alone. 

That's it.  Now this project will use the secondary JRE, while others will use the primary one.  Happy coding!

