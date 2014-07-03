---
layout: post
title: Bypassing an OK-Only Message Box
category: Programming
tags:
- c#
- code
- windows
status: publish
type: post
published: true
---

At work, when we log onto the system, we are greeted with a message about how our company is free to monitor our network usage and so forth.  The bottom tells us that "By Clicking OK" we are agreeing to the terms.  The only button available to click, of course, is an "OK" button.  

A co-worker realized, however, he could get rid of the box by pressing escape rather than clicking "OK", and that this meant he was not agreeing to the terms but still able to access the system.

This led to a discussion about the Windows API.  My contention was that the way the windows API MessageBox works, pressing escape returns the same value as pressing OK.  

The way the function works, you basically call the MessageBox function provided by Windows.  You give it a windows handle (more on that in a second), a string containing the message box text, another string containing the caption (like a window title), and an integer that represents the TYPE of message box.  Types can be "OK Button Only" or "Yes Button and No Button" or "Abort, Retry, Ignore" or a handful of other types.  The application calls this function, and windows makes a message box pop up.  Where it pops up is based on the windows handle you provide and what buttons it has result from the fourth parameter, which can also supply which icon is presented, like the Stop icon or the Warning icon.  The application pauses and waits for a response - and when the user clicks a button, the function returns the value for that button to the application.  Presumably, the application will then check the result and decide what course of action to take.

My contention was that if you press escape on a message box with ONLY an OK button, the same value is returned that is returned when the OK button is clicked.  Let's find out:

~~~cpp
/* messagebox.cpp */
#include <cstdlib>

#include <iostream>

#include <windows.h>


int main(int argc, char *argv[])
{
  int ret_ok = MessageBox(0,"Click OK", "MessageBox 1", MB_OK);
  int ret_esc = MessageBox(0,"Press Esc", "MessageBox 2", MB_OK);
  if(ret_ok == ret_esc)
    printf("Same values returned: %i %i\n", ret_ok, ret_esc);
  else
    printf("Different values returned: %i %i\n", ret_ok, ret_esc);
  system("PAUSE");
  return EXIT_SUCCESS;
}
~~~

When we run this, we are prompted with two message boxes, one telling us to click OK, the other telling us to press escape.  If we obey, the output is this:

~~~output
Same values returned: 1 1
Press any key to continue . . .
~~~

Indeed, pressing escape is exactly the same as clicking OK.  Clicking the X on the window caption yields the same result as well.  It seems that any way you can get rid of the box, the value returned is the same as when OK is clicked.

So if you're hax0ring your notice at work, it's not working.

Plus you probably had to sign a contract anyway.

