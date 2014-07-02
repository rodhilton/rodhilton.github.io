---
layout: post
title: 'Language Marathon: First Impressions of Ruby, Python, and C#.'
category: Programming
tags:
- c#
- python
- rails
- ruby
status: publish
type: post
published: true
---
For the past two months, I've been learning three different programming languages simultaneously.  I've been wanting to learn Python for a while, and I finally made some time to read [Learning Python](http://www.amazon.com/Learning-Python-Second-Mark-Lutz/dp/0596002815") cover to cover on camping trips.  I've also been thrown into the world of Ruby (as well as Rails) for work, since we are developing our next web application using that technology.  Lastly, I've had to learn C# and .NET for school - the last class for my Master's degree.  

I've wanted to learn all three of these technologies for a while, but I've never had the time.  This has been a very exciting experience for me, and I wanted to share my first impressions of these languages.

# C#: First Impressions

I've been working with C# less than the other languages, so I still have a great deal to learn.  Overall, the experience has been pretty positive.  The language is almost exactly like Java.  Java stole it's syntax from C for the most part (for developer familiarity), but C# is sort of a syntactic hybrid between Java and C++ (more towards the Java side).  Overall, I like it.  

I used to use C++ in high school and C in college.  I never really liked C++ - I felt like the language hacked object orientation onto a fully procedural language, and it really showed.  The language never seemed well designed to me, and it kind of had a "worst of both worlds" feel to it.  C# seems like a natural progression in the C family - something even higher level than C++, without the procedural vestiges of C.

When I was a Windows user, I did most of my Windows application development in Visual Basic.  Generally if I needed a Windows program, this was the easiest route to take - the form designer let me focus on the look and feel of the application, which was generally important (otherwise I'd be writing it as a console application in a different language entirely).  I dabbled in the MFC a bit, but I generally found that writing Windows applications in C++ reminded me of all the things I hated about C++, and made me hate them even more.  Visual Basic, for all of it's faults, gave me access to the same Win32 API, without the need to jump through so many of MFC's many hoops.  

C# and .NET are a substantial improvement over this type of development.  The easy-to-work-with GUI designer from Visual Basic is preserved, but the code now makes more sense, and uses a far less offensive language than either Basic or C++.  I really liked the fact that when I changed properties of my GUI elements, rather than those being saved magically as they were in Visual Basic (last time I used it, anyway), the IDE simply changed the appropriate lines in the constructor for my form class.  Partial classes are a very neat feature as well - allowing me to define a single class in separate files allows me to separate the event processing GUI code in a class from the look and feel GUI code in the same class.

C# makes me almost regret abandoning Windows a while back - if I were still using Windows, C# would become my development language of choice for native GUI applications.   My fiancee and I both have windows on our phone, so I may start to look into developing mobile applications.

All in all, C# is a lot like Java - if I wanted to write a native Windows GUI application using Java syntax, C# would be the way to go.

# Ruby: First Impressions

Ruby fanbois like to mention that Ruby has been around for over 10 years, but doing so denies reality.  The truth is Ruby had a tiny section of fans (but nothing approaching widespread adoption), but didn't really hit the scene until 2004, when it became the driving force behind Ruby on Rails.  As such, I can't mention much about Ruby without mentioning Rails.

Ruby, to be honest, does not impress me.  Generally, I'm not a fan of languages that let you do the same thing in multiple ways.  It allows personal style to influence code far too much.  As a simple example, I like writing my loops out explicitly, so I use a for statement with a collection.  A co-worker prefers to use the .each method on a collection, passing in a code closure.  There isn't anything 'wrong' with either one of these approaches, but each of us dislike the way the other writes loops.  This means that our shared codebase has inconsistent looping mechanisms all over it, making it less readable and less elegant.  This is obviously not a fault of Ruby, but a fault of my co-worker and myself, since we could just flip a coin or something and commit to a certain way, but my point is that this situation is common in languages that allow multiple ways to do the same thing.

Ruby simply seems like a crappy language to me.  Scripting languages don't get run through compilers, which means that everything which would be a compiler error in a language like Java or C++ becomes a runtime error when the application is actually running.  The way a lot of scripting languages handle this is by being more tolerant - more situations that would lead to a compile error are tolerated by the interpreter, and handled as elegantly as possible, sometimes without even moving into an error state.  Ruby doesn't seem very tolerant to me, but since it's not compiled, I see a lot of errors (which, in my experience, tend to be pretty poor) at runtime.

Rails, however, is excellent.  Whenever I work with RoR, I can't help but be a bit disappointed that somethings as good as Rails is built on top of something like Ruby.  Normally I'm not a big fan of convention over configuration, since the list of "conventions" can tend to grow so quickly that it's difficult for someone to learn all of the rules.  However, having done Java web development for a long time, I definitely find convention over configuration tempting - Java web development suffers from configuration poisoning.  I put my preconceptions aside when I started working with Rails, and though some of the magic it does makes my skin crawl sometimes, I definitely like it.

It didn't take my company very long to get past the RoR learning curve and start being productive - and I definitely have experienced how much easier and faster it is to make changes and improvements to the web application in RoR.  We've been consistently overestimating our stories, since we're trying to estimate based on how long changes would take in Java.  For the past three iterations, we've finished early and had to pull stories in from the next iteration since we were able to enhance the product so quickly.  I have no doubt that RoR is the reason for this productivity gain.  This is particularly impressive, since the Ruby and Rails documentation efforts are both godawful.

Most of what Rails does isn't new or original, though.  I feel like the biggest advantage of Rails is simply how forceful it is about the MVC pattern - making filenames and actions line up is all that is needed to separate the view from the controller, which simply takes a lot of boilerplate code off my back.  The templating and tag definitions are simply very good implementations of very old ideas.  The ORM library actually kind of sucks.  All in all, Rails is just a convenient packaging of ideas that can (and do) exist on other platforms.  I think that 90% of what I actually care about in Rails could be written into a framework for nearly any other language, even Java.  

Overall, RoR has ruined me a bit on Java web development.  I finally understand why people who work with RoR dislike going back to Java for web development.  I used to like Java web development, but there's a small part of me that would dread returning to it as well.  Ruby on Rails really is a fantastic web application development platform.

# Python: First Impressions

When I started using Linux early this year, the hardest adjustment for me was that I had lost the ability to write native GUI applications for my operating system.  Like I said earlier, I used to throw together GUI apps using Visual Basic in Windows, but no such thing existed in Linux.

The deeper I got into the world of Linux, the more I noticed how often applications were written in Python.  Python is extremely popular in the world of Linux.  I would say that about half of the GUI apps I run regularly in Ubuntu are written in Python, or at least have Python components.  

A friend in college was a big fan of Python, so I decided I would learn Python and it would become my application language of choice in Linux.

_Python blew my mind_

Python is, quite simply, amazing.  I've worked with a lot of programming languages, and I don't think I've ever come across one that is designed as elegantly and perfectly as Python.

There are hardly any exceptions to the language rules in Python - everything is incredibly consistent.  As I was reading my Python book, I would often have questions along the lines of "How would Python handle this...", and I got to the point where, instead of reading to find the answer, I would close the book and simply think about it.  Based on the other rules I knew about Python, I would try to predict what Python would do if it were designed consistently, and sure enough that's exactly what the book would tell me on the next page - every single time.  

I still have some gripes about Python, of course. I dislike having to pass self references into class methods.  It irks me that there's no way to make a private variable, and the fact that any method can overwrite anything on any class makes my hair stand on end.  However, for each of these complaints, I UNDERSTAND why it works the way it does, and it makes complete sense to me.  Unlike my complaints with Java, my complaints with Python come not from language inconsistencies, but simply from my own personal preference.  Even if I had the power to change Python to allow private members, I wouldn't, because it would be inconsistent with the design of Python.

I've been writing all of my console apps and shell scripts in Python lately, and I'm excited to write some GUI apps using Glade and Python together soon.

In terms of language design and comfort, Python is officially my new favorite language.  After just one book (which was one of the best programming books I've ever read), I feel like I've completely mastered the language.  It's so straightforward, consistent, and easy to learn - I'm kind of annoyed I didn't learn it sooner.

# Conclusion

That about covers my first impressions of my whirlwind language tour these past two months.  C# is exactly the language I would have loved when I was still a Windows user, Ruby sucks, Rails is awesome, and Python is the best language ever made.

I'm worried that I may get rusty with Java - there's so much exciting stuff to work with, I can't really see myself starting a new Java project any time soon.  I haven't written a single line of Java in a couple of months (I'm doing Ruby exclusively at work, C# at school, and Python at home), but I seriously doubt I'll ever really abandon Java - I still like it a great deal, and I'm excited to see how it continues to evolve.

