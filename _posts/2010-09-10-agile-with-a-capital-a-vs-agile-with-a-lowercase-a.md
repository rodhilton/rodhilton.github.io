---
layout: post
title: Agile With a Capital “A” Vs. agile With a Lowercase “a”.
category: Programming
tags: 
- agile
- process
status: publish
type: post
published: true
---
There have been a number of blog posts and discussions lately around the evils of agile.  Lots of traffic recently surrounding an [old post by Cedric](http://beust.com/weblog/2006/06/07/agile-people-still-dont-get-it/").  This [stackoverflowist](http://stackoverflow.com/questions/3226711/giving-up-agile-switching-to-waterfall-is-this-right") is switching to waterfall.  Hell, agile ruined [this guy’s life](http://www.whattofix.com/blog/archives/2010/09/agile-ruined-my.php") - **HIS ENTIRE LIFE**!

I’m a big fan of agile software development, which should come as no surprise given that I work at Rally.  But honestly, I understand where all of this backlash is coming from.  Whenever someone has come to me and told me "this is the way you will do things now," then decreed some elaborate, formal process I would have to follow, I’ve resented it.  Don’t tell me how to work.

But I think a lot of people who are annoyed at agile lately are confusing **Agile** with **agile**.

# "agile" with a lowercase a**

In truth, "agile" – with a lowercase a – is not a process.  It’s not a ruleset, it’s a mindset.  A mindset that, to quote from the [manifesto](http://agilemanifesto.org/"), values:

 > Individuals and interactions over processes and tools
 > Working software over comprehensive documentation
 > Customer collaboration over contract negotiation
 > Responding to change over following a plan

That’s it.  That’s all there is to "agile".  It just means, "_hey, we’ve noticed that software projects tend to go a lot better when we get working software into the hands of customers as early and as often as possible._"

{% image agile-thinker1.png align="left"%}

Frankly, I think it’s hard to deny the power of this sentiment.  Handing a customer working software is vastly superior to handing them a diagram.  Getting honest feedback on the software right away and making changes seems much saner than pinning down the exact wording in some kind of contract.  The "agile" mindset leads to successful software projects much more easily than alternatives.

Once you decide that you want to develop software by delivering working products to customers as soon as possible, it only takes a little bit of effort to come up with some stuff that helps enable that:

 * If we’re responding to change quickly, we’re probably going to want a bunch of tests to make sure that our rapid changes don’t break stuff that was already working.  And we probably don’t want to manually test stuff after every change.  Thus, automated tests become an important part of agile.  Not because it’s part of a decree, but because it seems to do a good job of helping us accomplish what we want.
 * If we’re going to be collaborating with our customers to help determine what stuff to implement next, we’re probably going to have to give that customer a general sense of how much effort each feature is going to take so they can prioritize things.  We could give them hourly estimates, but the customer really only needs a sense of relative size, so let’s just assign unitless numbers to each feature.
 * If we’re going to be interacting with each other a lot, we probably don’t want all the developers to be in little offices by themselves.  We should try to keep everyone chatting regularly, so that if Adam mentions he is struggling with something, and Britney happens to know a bit about that area, they can work together to solve the problem faster.  A quick 10-minute check-in should do the trick.

These are the cases for automated testing, story points, and daily standups.  But that’s not because they are mandates, it’s because they seem to be three ways of helping increase the chances of success developing good software.  If you hate daily standups, maybe an IRC channel would be a suitable replacement.  If you hate story points, maybe throwing index cards into small, medium, and large-sized buckets would be enough.  If you hate writing tests but have an army of folks who love doing manual testing, fine.  If it helps you stay "agile," then it helps you deliver working software.

# "Agile" With a Capital A

The problem here is that all of these sensible suggestions got formalized into "Agile", with a Capital A.  This set of suggestions for "things that seem to work" got boxed up into a package with a bow on top, to be sold to companies and managers.  When "agile" turns into "Agile", "automated tests would probably help you" turns into "you must write automated tests at all times, or else."  Don’t tell me how to work.

{% image agile-box2.png align="right" %}

Once Agile becomes dogma, it becomes an overbearing process that annoys the developers.  It becomes about burn-down charts and backlogs and other things that managers love to see.  This isn’t terribly shocking.  Agile is meant to make life easier for developers, but if you can’t convince your manager (and her manager, etc) that it’s worth adopting, it won’t work.  In order for developers to be able to be agile, they need to sell their bosses on it.  Unfortunately, that means those bosses may need to be presented with the shiny box of "Agile" with a Capital A, which is why said shiny box has come to exist.

The most important piece of "Agile" is, truly, the retrospective.  We developers often hate it – it’s a big stupid meeting that’s taking us away from our computers ("doing real work") – but it’s the most important thing we can do.  The reason is simple: the retrospective gives the team the opportunity to figure out where their daily routine has shifted away from "agile" and turned into "Agile".  **It’s a chance to figure out where a series of values in which "process" is valued relatively low have shifted, ironically, into an overbearing process**.  Is part of the "Agile" package making your life harder?  Sit down with your team, identify what that thing is supposed to be making better, figure out an alternative way to make it better, and drop the thing that sucks.  Try it for a while, then meet back up and chat about if it’s working.  The agile mindset is about adapting.

"Agile" may have ruined a life, but "agile" probably did not.  I would guess that "agile" has made it a great deal better, and the dogmatic adherence to a predefined box labelled "Agile" is what made it worse.  Don’t chuck the baby out with the bathwater.

Rigid process is the antithesis of "agile."  Simply ensure that everything your team does enables it to deliver working software early and often, and pieces will fall into place.  The [vast array of books](http://www.amazon.com/gp/search/ref=sr_nr_scat_4016_ln?rh=n:4016,k:agile&keywords=agile&ie=UTF8&qid=1284078587&scn=4016&h=1c5d783e62fdda166786e5852002e9608fbc7636") on "Agile" should be taken as guides, not gospel.  These books, Rally’s training, and other sources all contain excellent suggestions for enabling teams to deliver quality software, but not all things will work for all teams.  These are just things that a lot of people have seen work really well, and they might be useful for your team, too.  Try stuff out, experiment, then evaluate.  Over time, your team will figure out what works best for it.
