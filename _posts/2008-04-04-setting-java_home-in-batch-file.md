---
layout: post
title: Setting JAVA_HOME in a Batch File
category: Programming
tags:
- batch
- code
- ruby
- windows
status: publish
type: post
published: true
---

Recently at work I had a bizarre problem to deal with.  Essentially, we are distributing an application that uses [JRuby](http://jruby.codehaus.org/), and we were encountering a problem whenever people would use our application in Windows if they installed Java in a specific way.

A lot of Windows users install Java not by putting the bits on disk and setting JAVA_HOME, but by adding java.exe to their path.  When done this way, Java works in the sense that you can type "java" in a command prompt and have it understand what that means.  You can compile java from command line and run it with no problem.

The problem we experienced was that JRuby, in windows, specifically looks to see if JAVA_HOME is set.  If it is not set, the JRuby executable bails.  I submitted a [patch](http://jira.codehaus.org/browse/JRUBY-2301) to JRuby to fix this behavior, but we could not rely on that solution until it was integrated.

What we are doing now is, in the batch file that we have that calls our application, we look to see if JAVA_HOME is set and, if it is not, step through the PATH looking for java.exe.  We then set JAVA_HOME based on the location.  As a result, by the time the JRuby script runs, JAVA_HOME has been set.

This is actually a handy trick to look for anything in the path in a Windows batch file.

Here's the code:

~~~batch
if not "%JAVA_HOME%" == "" goto javaHomeAlreadySet
for %%P in (%PATH%) do if exist %%P\java.exe set JAVA_HOME=%%P..\
:javaHomeAlreadySet
~~~

