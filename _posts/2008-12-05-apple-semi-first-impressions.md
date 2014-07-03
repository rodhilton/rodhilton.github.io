---
layout: post
title: 'Apple: Semi-First Impressions'
category: Technology
tags:
- apple
- mac
- open source
- software
status: publish
type: post
published: true
---

Two months ago, I took a new job.  I'll write a post about the company some other time, but I do want to highlight one aspect of the company: the usage of Apple products.

I spent most of my youth in Windows, but I switched to Linux a few years back and greatly enjoyed it.  It annoyed me that I didn't know my way around Mac OS, the only remaining one of the "big three" with which I was not proficient.  When I took the job at Rally, I was excited to find out that they were an Apple shop.  All of the developers had powerful mac machines, the pairing stations were all iMacs, and pretty much everyone owned a Macbook or iPhone, or both.  Rally was going to be a good place to learn my way around the world of Apple, so I was excited.

To give a little background on myself, I am a bit of an open source zealot.  Even when I was a Windows user (for a while, I worked as a Flash programmer and Flash didn't run in Linux), I replaced the Windows shell with [LiteStep](http://www.ls-universe.info/news.php"), an open source shell.  I ran open source Windows software almost exclusively - my goal was to make the Windows Kernel the only proprietary thing running on my machine.

The only Apple product I had owned up until I took the new job had been an iPod, but I replaced the iPod firmware with [Rockbox](http://www.rockbox.org/"), which is open source.  A year ago I wanted to upgrade my iPod Nano to the newer, smaller model, but when I brought it home and tried to install Rockbox on it, I found out that the newer Nanos had some kind of protection that prevented firmware replacement.  My response was to actually return the Nano to the store and keep my old one, which I still use.

So suffice it to say, 'closed' systems irritate me, and Apple products are arguably the most closed hardware/software products available for purchase.  I decided to go into this process with an open mind, since I wanted to learn my way around Mac OS X, but the odds were definitely stacked against Apple, so take what I say here as a fundamentally biased view of the world.

Here are my observations about using Mac OS X (Leopard).  Remember, I have only been using this system for two months, and I only purchased a MacBook for home one month ago.

**Setup Is Easier, Perfection Is Harder**

The most noticeable difference between OS X and, say, Ubuntu has been the ease/difficulty of getting things to be the way I like them.  In Linux, it takes quite a while before you can get your environment from nonfunctional to functional.  This means editing your xorg.conf file for your monitor, setting up your mail application, and everything else.  Going from nothing working to basic functionality is very difficult and time-consuming in Linux.  In OS X, it takes mere seconds.  The Mac OS goes out of its way to make basic configuration as easy as possible.  One thing that stood out to me was the fact that, when setting up my e-mail accounts in Apple Mail, I didn't have to select if I was using SSL or not - the mail client seemed to just try SSL and, if it worked, used it, but otherwise tried to connect without it.  This took a very small amount of code I'm sure, but it made the process of set-up so much easier.

That said, it takes about the same amount of time in Linux going from nonfunctional to functional as it does to go from functional to ideal.  By this I mean, making the tiny little tweaks that make your environment 'perfect' for you.  Binding applications and commands to global keyboard shortcuts, managing your workspaces, etc - everything that makes your machine perfectly suited for you.  It's time consuming in Linux, but very possible, and it takes about as long as it takes to get things working at all.  In the world of Mac, this is not the case.  Very, very frequently making these little 'perfection' tweaks proved exceedingly difficult, bordering on impossible.  When I asked my Apple fanboy friends how to do this or that, the response was overwhelmingly "don't do it that way, do it the Mac(tm) way."  

I had to spend a lot of time adjusting my Linux environment to the way I like to work, but I've had to spend a lot of time adjusting how I like to work to the Mac environment.  This isn't necessarily **wrong**, but it's certainly a difference.  The Apple philosophy seems to be to make applications more intuitive and easier to work with, at the expense of some degree of power and control.

**The Apple Community Likes Open Source, Sort Of**

In the Linux community, open source is not just a decent way to write software.  It's the predominant philosophy driving all decisions.  Open Source is more than a means to an end in Linux, it's a moral and ethical imperative.   The fact that Mac OS is based on BSD under the hood, the easy available of a good terminal, and the existence of projects like Macports make Mac OS something like the ideal Operating System for people that like Open Source, but don't like it enough to futz with their wireless drivers for three hours to get on someone else's wireless network.  As a result, the community is strangely split between people that love open source and people that only love it because it makes it easier for small projects to get off the ground.

It's weird for someone with my open source zealotry to see people behave as though Mac OS is somehow more open because it **feels** more like Linux.  When I say to people at work that, so far I prefer Linux to Leopard, they respond along the lines of "Why?  You can still use the command line" as though the reason to prefer Linux is that I have to do everything through vim.  If anything, that's the worst part of using Linux, not the best part.  I prefer the commandline to a GUI for a lot of things, but I can't make the argument that it's somehow better.

I don't have access to the source code of my operating system in Leopard.  It is, therefore, fundamentally un-Linux-like.  Having a terminal doesn't make it open source, anymore than installing cygwin in Windows makes Windows open source.  I'll grant that the BSD backend and Unix-like file system make it more _familiar_ to me as a Linux person, but that's where the similarities end.  It still kind of boggles my mind that I see people giving presentations about the power of open source software on their MacBooks.

**Application Competition Is Thin**

In Windows and Linux, there are tons of FTP programs.  Linux gives me at least 15 different ways to manage and play my mp3 library.  I can easily replace Windows's Notepad with at least 30 different plain text editors.  The competition between applications for your hard drive space in Windows and Linux is very high.  It's not a function of popularity either, because it's still true in Linux despite having the lowest desktop market share of the Big Three Operating Systems.

Excluding multiplatform applications that run in all three operating systems, in Mac OS, there's basically one IM client: Adium.  There's basically one file manager: Finder.  There's basically one music player: iTunes.  I'm sure that commenters can point out a few straggling applications in each of these arenas, but the fact of the matter is that they are simply not on the radar, realistically.

There are other application categories where this is true as well.  What I consistently found when I would do a search for something like "Mac OS FTP programs" the internet would always respond with a single, clear winner.  Doing this sort of search for Linux tends to bring up forums in which (sometimes very heated) arguments rage on trying to answer the question.  There is rarely a "best" application, but a small handful of "best depending on what you're looking for" applications.  With Mac OS, there is one application, and it's the best, and if you don't like it, hey, what the hell is wrong with you?

The worst offender in this area is iTunes.  I **loathe** iTunes.  I don't need anything fancy in a music player: list my files, let me play them, let me have a shuffle mode.  iTunes goes so far beyond what I require that it's clearly not suited for me, but ideally any music playing appliation should serve as a superset of the functionality I require.  iTunes does not.  I have less than 100 gigs of music, but I mount it over a network via NFS.  Adding my entire library to Audacious (an indirect descendant of XMMS) in Linux takes 2 minutes.  I timed it: 120 seconds.  Adding my library to iTunes takes, I kid you not, 3 hours.  Three hours from clicking "Open" to being able to play my music.  I turned off as much as iTunes would let me to speed this up, and three hours is the best I can do (before doing anything, it was five). I told iTunes not to copy music to the local disk, I told it not to sort my music for me, everything.  And what happens if you try to ask someone what you can use other than iTunes?  You're asked why on earth you don't like iTunes.  Say "because it takes 3 hours to load my music" and they will tell you that you have too much music.  Explain you don't have that much, but it's mounted on a network and they'll tell you to copy it to your hard drive.  Those aren't solutions, they are workarounds.  iTunes sucks.

I've tried MacAmp (crashes), Play (freezes), Audion (freezes), and Cog (crashes).  Cog is the most promising of the group, so I tried a number of different nightly builds of it, but it's still not quite there.

Even if I manage to find a better music player, deviating from Apple's philosophy has costs.  Based on a few hours of research, even if I find player I like, I'll be unable to make the keyboards multimedia keys control it.  Those are, apparently, reserved for iTunes.

**Concluding Remarks**

Overall, I like Mac OS, but I do not love it the way I love Linux.  I like the fact that my wireless worked right out of the box, and that I can hook my MacBook up to external monitors without any pain whatsoever.  I like that I can just expect everything on my Mac to be easy to configure, and I like that application interfaces are so intuitive that I can get up to speed quickly.  My level of proficiency with Mac OS after only two months is far, far higher than my level was after working with Linux for only two months, and that's worthy of note.

But I do greatly detest the lack of control I have over my system and it's applications.  I loathe the fact that the home and end keys do something that nobody would ever want to do (Start and end of buffer? Seriously?  How worthless) and that my ability to modify this behavior is pretty severely limited, and largely up to the application.  I hate the fact that there doesn't seem to be a particularly strong notion of 'global shortcuts' vs 'local shortcuts' (in Windows the Win key means 'global', and in Linux the Super key means the same thing, yet in Mac OS Command-Space globally brings up your spotlight, but Command-Q locally quits your current application).  And seriously, iTunes is garbage.

Most of my gripes are minor, aside from the staggering level of suckiness that is iTunes.  I don't anticipate ever becoming an "Apple Convert" like so many others, and I still prefer Linux on my desktop, but there are a lot of positive things to say about my Mac.  

I can easily see an Apple OS running on any and all laptops I ever use, but I can't see it on my phone (I still have high hopes for Android and I eagerly await a Verizon Android phone).  I'm definitely not an Apple fanboy, but I am a fan of my Apple.

