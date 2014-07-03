---
layout: post
title: Getting Remote IP Address In Axis
category: Programming
tags:
- code
- java
- webservices
status: publish
type: post
published: true
---

I've been trying to figure out for a while now how to get the IP address of a user consuming an Axis web service.  Finally figured it out today.

The class used by the service doesn't extend anything in Axis, and Axis invokes the methods on the class through reflection, so there didn't seem to be an obvious way to get an IP address - in fact, the class had no concept of being involved with networking at all.

Well it turns out you can get a MessageContext for the "current thread" statically, and that context has properties which can be accessed by string keys, which are stored in a constants file.  Phew.

Be careful, though.  If you were making the object locally rather than through Axis (say, for testing),  getCurrentContext() will be null, so make sure you deal gracefully with that if you use this method.

Here is is an example web service that tells you your IP: 

~~~java
// WebService.java
package com.air0day.machetejuggling;

import org.apache.axis.Constants;
import org.apache.axis.AxisFault;
import org.apache.axis.MessageContext;

/**
 * Example code to get IP Address of remote user
 * invoking a method in an axis web service.
 * 
 * URL: http://blog.air0day.com
 * 
 * @author Rod Hilton
 */

public class WebService {
  public String remoteMethod(String input) throws AxisFault {
    MessageContext curContext = MessageContext.getCurrentContext();

    String remoteIp = "Unknown";
    if(curContext != null) {
      Object ipProperty = curContext.getProperty(Constants.MC_REMOTE_ADDR);
      remoteIp = ipProperty.toString();
    }

    return "Your IP address is " + remoteIp;
  }
}
~~~

As a side note, if anyone knows a good way to display code in a blog like this one (say, in a textarea) with a wordpress 2 plugin, I'd really appreciate it.

