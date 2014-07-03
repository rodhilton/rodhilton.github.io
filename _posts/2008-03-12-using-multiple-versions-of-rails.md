---
layout: post
title: Using Multiple Versions Of Rails
category: Programming
tags:
- rails
- ruby
status: publish
type: post
published: true
---

It's quite easy to have multiple versions of rails installed as gems when working with ruby on rails.  Quite frequently, you will be working on a project that uses an older version of rails than one on your machine, and all you have to do to get the correct version is:

~~~terminal
$ gem install -v 1.2.3 rails --include-dependencies
~~~

Multiple versions of rails can exist independently on your machine without much of a problem.  Since your individual rails projects store the version number they expect, and your projects don't tend to depend on each other, you can have hundreds of different rails versions installed and never notice. Mostly.

If, however, you wish to start a NEW project, when you run

~~~terminal
$ rails projectname
~~~

It will use the most recent version of rails.  But what if, for some reason, you have rails 2.0.1 and rails 1.2.6 on your machine, and wish to generate a rails 1.2.6 application?  This came up because I'm trying to teach a friend rails, and the book he has is for rails 1.2, meaning that if he uses 2.0 all of the scaffolding code (as well as other bits) from the book are incorrect.  At the same time, the application he and I are working on together uses rails 2.0, so he needs both versions on his machine.

This solution works in linux (haven't tried windows):

~~~terminal
$ rails _1.2.6_ projectname
~~~

I didn't see any documentation about this anywhere.  In fact, I found it by cracking open the actual 'rails' script in /usr/bin and noticing that it did a regex match for a parameter that started and ended with underscores, then interpreted that as the version.

In any case, this allows you to happily generate a new rails app using an old version of rails.  Nothing quite like discovering an undocumented feature by reading the source code.

