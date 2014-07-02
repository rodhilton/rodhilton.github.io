---
layout: post
title: Java 5 Global Exception Handling
category: Programming
tags:
- code
- java
status: publish
type: post
published: true
---
Ever since Java 5 came out, many articles and blog posts have been written talking about the new features.  Just recently, however, I came upon a feature new to Java 5 that I had never seen mentioned in any of the articles I read: global exception handling.

There is a way to set a default handler for any exceptions that are thrown which are not caught.  This is very handy for adding handlers for `RuntimeException`s, since they are unchecked and the compiler will not tell you to catch them.

For example, you may want to write a handler that will catch any `NullPointerException`, and e-mail the development team to let them know someone has made a coding mistake.  There are many useful purposes for this feature.  It should also be noted, however, that it breaks the idea of capturing an exception as close to the point of origin as possible.  You should try to keep exception handling close to the exception, so that you have as much contextual information as possible to deal with the error and recover from it gracefully.

There is no denying, though, that we all write empty catch blocks, or catch blocks that print a trace to a log file and ignore it.  For those, this is handy.

Below is an example that shows a simple default handler that catches an exception in the application, as well as one in an unrelated child thread.

~~~java
//ExceptionHandlerExample.java
package com.air0day.machetejuggling;

public class ExceptionHandlerExample {
  public static void main(String[] args) throws Exception {

    Handler handler = new Handler();
    Thread.setDefaultUncaughtExceptionHandler(handler);

    Thread t = new Thread(new SomeThread(), "Some Thread");
    t.start();

    Thread.sleep(100);

    throw new RuntimeException("Thrown from Main");
  }

}

class Handler implements Thread.UncaughtExceptionHandler {
  public void uncaughtException(Thread t, Throwable e) {
    System.out.println("Throwable: " + e.getMessage());
    System.out.println(t.toString());
  }
}

class SomeThread implements Runnable {
  public void run() {
    throw new RuntimeException("Thrown From Thread");
  }
}
~~~

This example uses `setDefaultUncaughtExceptionHandler`, which sets it globally for all `Thread`s (your main application runs as a `Thread`).  There is also `setUncaughtExceptionHandler`, which is not a static method and applies to a specific thread.

