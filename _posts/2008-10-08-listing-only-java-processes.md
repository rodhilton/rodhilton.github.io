---
layout: post
title: Listing Only Java Processes
category: Programming
tags:
- java
status: publish
type: post
published: true
---

Ever do something like the following?

~~~terminal
$ ps aux | grep 'java'
~~~

Pretty annoying, especially considering that the output usually shows the enormous startup script commands running with Java.  Wouldn't it be nice if you could just run a command that would list only java processes, and specifically list what the actual application running within the VM is?

As I learned at a JUG last night, there IS a program that will do this.  It's called '[jps](http://java.sun.com/j2se/1.5.0/docs/tooldocs/share/jps.html)'.

JPS will list only the java processes running, with their actual PIDs and the shortened names of the entry classnames or jar files.  This lets you handily see what is actually running:

<pre>
jps
18027 Java2Demo.JAR
18032 jps
18005 jstat
</pre>
Where can you get this amazing tool?  You already have it!  It's part of the JDK, apparently.  Go to a terminal and type 'jps' and check it out.

The program also takes options to list full classnames and it can even connect to a remote machine and list JVMs remotely.

How did I not know about this?  It rocks my face off.

