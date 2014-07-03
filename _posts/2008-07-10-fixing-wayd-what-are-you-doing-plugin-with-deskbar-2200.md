---
layout: post
title: Fixing WAYD (What Are You Doing) Plugin for Gnome Deskbar 2.20.0
category: Programming
tags:
- code
- linux
- twitter
- ubuntu
status: publish
type: post
published: true
---

I wanted to start experimenting with the Gnome Deskbar recently, particularly to make it easier to update my twitter feed.  There are a number of deskbar plugins for twitter updating, though most of them are obsolete because of recent changes to Deskbar.

I had a lot of trouble getting [WAYD](http://www.butterfat.net/wiki/Projects/DeskbarPlugins) (a twitter/pownce/jaiku updater) to work with Deskbar, so I figured I'd post to explain what I had to do to make it work.

First, when you download the plugin, you need to put it in the correct directory.  A lot of instructions tell you to place the file in `~/.gnome2/deskbar-applet/handlers` but these instructions are for older style plugins.  You want to place the file in `~/.gnome2/deskbar-applet/modules-2.20-compatible`

Next, you need to rename the file.  The file is named to have a version number in the filename after a dash.  Dashes aren't allowed in python filenames, so rename `wayd-1.4.py` to `wayd.py`

Last, you need to fix a small bug in the WAYD code.  Around line 375 you will see:

~~~python
  if not c.twitter() and not c.jaiku() and not p.pownce():
~~~

change this to:

~~~python
  if not c.twitter() and not c.jaiku() and not c.pownce():
~~~

Then you can reload Deskbar (remove it from your panel and re-add it), right click the icon, go to preferences, and enable the plugin.  Be sure to put your login information in by clicking 'more' on the preferences screen.

**Update:** You also need to change line 107 from

~~~python
  except URLError, e:
~~~

to

~~~python
        except urllib2.URLError, e:
~~~

To prevent a crash when there's a problem with twitter updates.  Additionally, if you post a message that's too long (>140 characters) to twitter, you get an unhelpful generic error message.  To make it tell you something useful, find the following code

~~~python
  message = "Your post to Twitter might have had a problem"
~~~

and add this below it:

~~~python
        if len(self.text) > 140:
            message="Your post is too long for Twitter."
            n = pynotify.Notification("Twitter Results", message, "stock_internet")
            n.show()
            return
~~~

I've sent the author my changes, so hopefully he'll update his site with a new copy of the file and make this post obsolete.

**Update:** The author has merged my changes in.  Go to [his site](http://www.butterfat.net/wiki/Projects/DeskbarPlugins) to get the latest version (you still need to rename it to wayd.py though).

