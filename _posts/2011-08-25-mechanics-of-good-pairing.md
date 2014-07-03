---
layout: post
title: Mechanics of Good Pairing
categories:
- Programming
tags:
- environment
- pairing
- team
status: publish
type: post
published: true
meta:
  _edit_last: '1'
  dsq_thread_id: '605226803'
author:
  login: air0day
  email: blog@air0day.com
  display_name: Rod Hilton
  first_name: Rod
  last_name: Hilton
---
I've made no secret about the fact that [I Love Pair-Programming]({% post_url 2009-02-21-i-love-pair-programming %}).  I've tried pair programming with a number of different setups, each one better than the last.

I've had a lot of people ask me about how best to set up pair-programming environments at work, so I'm going to take you through a number of different ways to pair-program and discuss the advantages of each.

# Level -1: Not Pairing

The first level of pairing is something I see surprisingly often.  An inside-corner desk, typically an individual's workstation.  Another person scoots their chair over and leans in, looking at the same monitor.

{% image level-1.png %}

It seems like no coincidence that virtually everyone I've seen "pair program" this way dislikes pairing.  That's because this setup is not actually pairing.  It's just coding with someone watching over your shoulder.

Nobody likes having someone read over their shoulder, let alone read code they are writing.  This set-up basically ensures that the person writing the code (the driver) and person thinking about the next steps (the navigator) never trade places.  Trading places involves not merely sliding a keyboard over, but actually scooting rolling chairs out of the way, so it never happens.

Just as importantly, the two programmers are not the same distance from the monitor.  The monitor "belongs" to the person sitting closest to it, so the other person is really just watching.  The navigator will probably just zone out and think about something else while the driver codes away, confident that their pairing partner is helping ensure they don't make mistakes.

This kind of pairing is a waste of time.  Corner desks are the office furniture from hell.  Put it in a cubicle so that it's basically impossible for two people to fit and you've essentially ensured that nobody on your team will ever pair program.

# Level 0: Basic Pairing

The first level of actual pairing is simple.  A rectangular desk with two people sitting at it, sharing a computer.

{% image level0.png %}

The great advantage to this setup is that it's free.  As long as you don't make the mistake of filling your development area with corner desks, all that needs to happen here is have a second person scoot up to another person's workstation.

The two developers need to make sure they sit equidistant from the monitor so that neither person "owns" the machine and both people feel like they can grab the keyboard at any time.  If this is one person's workstation that's been re-appropriated as a pairing machine temporarily, the normal user of it may be more likely to hog the keyboard, so it's important to be careful to avoid that.

One of the problems of this set up is that it's probably not a devoted pairing machine.  This means that the environment will be configured for the workstation's usual user.  Keyboard bindings, IDE color schemes, fonts, installed programs, and so on won't be what a pair agreed to use, but what a single person prefers.  The person who scooted over may feel like a fish out of water in an unfamiliar environment, leading to another situation where one person is doing all of the driving.   

One way to help this problem is for the owner of the workstation to make a second user on the workstation, with its own desktop.  Most operating systems make it easy to switch between users these days, so having a regular user and a pair user that can be switched into easily is nice.  The only problem is that, of course, sharing information between users is difficult, so it may be hard if there is already work-in-progress when the pairing starts.  

At least this is better than the previous level, since both people can see the monitor equally well.

# Level 1: Good Pairing

At the next level, we add a second keyboard and a mouse.  Each programmer has his or her own input device set, but the programmers share a monitor.

{% image level1.png %}

This is good because it's easy to upgrade an existing workstation.  All you need to buy is another keyboard and mouse, both of which are generally dirt cheap.

This empowers both developers to feel like they "own" the machine, and they can feel free to take control and write code without any ceremony whatsoever.  Because of the setup, it nearly forces people to sit equidistant to the monitor, further aiding in the sense that both programmers have equal right to code at the machine.

One con of this setup is that there are sometimes "mouse wars" - two people using their mice simultaneously and causing problems.  This doesn't happen all that often and a little communication resolves it quickly, so it's easy to move past.

Another problem with this set up is that a lot of mice these days are bluetooth, particularly on Macs.  OS X has given me a lot of trouble with two identical bluetooth mice connecting to it simultaneously, it's much easier to use a wired mouse.

The biggest win here is that the machine stops seeming like it's a single developer workstation.  Even when only one person is at it, it "feels" like a devoted pairing machine because there is an extra keyboard and mouse at the machine.  This makes people less likely to apply strange customizations that alienate other programmers.

Finally, the biggest problem with this set up is that, because it forces people to sit equidistant to the monitor, both programmers may find that the monitor is actually too far away from them.  Increasing the font size in the editor helps this greatly, but it still can lead to eyestrain.  Large monitors are very helpful here.

# Level 2: Great Pairing

At the next level, you add a second monitor to the machine.  These monitors are mirrored, which can be done with either software or [DVI splitters](http://www.amazon.com/Cables-Unlimited-DVI-D-Splitter-PCM-2260/dp/B000H09RFM).

{% image level2.png %}

Both programmers feel equal control over the machine, and there are no eyestrain problems.  This is a really pleasant pairing situation, and it only adds the cost of a keyboard, mouse, and extra monitor to a regular workstation.

One common problem is that developers, rather than mirroring the desktop on both monitors, may want simply expand the desktop to both monitors.  This is a mistake.  The main IDE will be on only one of these monitors, and whoever is sitting at that monitor will eventually become the permanent driver and you're in a situation no better than the Level -1 setup.  This is even worse on OS X, where even the menu bar "belongs" to only one of the monitors (though this can be somewhat [fixed](http://blog.boastr.net/?page_id=79)).

The other problem is that the desk can get pretty cramped, particularly for the person the left side, since their mouse may be constantly hitting the keyboard of the person to their right.

# Level 3: Awesome Pairing

The cramped problem can be solved by simply adding an extra desk.  But rather than pushing them next to each other, push them perpendicular to each other.

{% image level3.png %}

In addition to giving each developer plenty of space to move around and be comfortable, this sets up both programmers to actually FACE each other while working together by only slightly turning their heads.

Setting up pairing in this way makes a very noticeable difference right away.  Switch a pair from Level 2 to Level 3 and you'll notice them talking a LOT more.  Developers will discuss design, bounce ideas off each other, and generally collaborate much better, simply because they are facing each other.

This setup takes up quite a bit of room and it looks a little silly, but it is absolutely fantastic.  It leaves room for sticky notes, pens, a developer's tablet or laptop, and lots of other things.  The entire setup 'feels' like a pairing station, and it works exceptionally well.

There aren't really any problems with this setup, though there is one way it could be better...

# Level 4: "Pair"-adise (ha!)

Give the pair an extra laptop to share, put it between the programmers.

{% image level4.png %}

Often the navigator may want to look something up on Google or StackOverflow, but doesn't want to take the driver off his current task to do so.  Having a laptop sitting between the programmers allows either one of them to shift away from the code to look things up or even try things out in a REPL environment.

Another nice thing about this setup is that two identical set ups can be pushed together to make a nice square pairing station hub:

{% image level4-stations.png %}

Yeah, it's extremely expensive to go from Level 0 to here, but it's an absolutely amazing setup.  You may quickly find that, with pairing stations set up like this, developers no longer wish to work alone at all.

