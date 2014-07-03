---
layout: post
title: Leaving Rally
category: Life
tags:
- career
status: publish
type: post
published: true
---

Today was my last day at [Rally Software](http://www.rallydev.com).  In two weeks, I will be starting a new job, working on a variety of web services, mostly with Java and Groovy.

{% image IMG_20110531_104216-300x224.jpg align="right" %}

Leaving Rally was tough for me.  It's easy to leave a job when I'm unhappy, or irritated with management, or tired of a project, or if I'm just not learning anything new.  But none of these were the case with Rally.  I'm leaving not because anything is wrong with Rally, but because there's simply a better opportunity for me elsewhere.  Time Warner is in downtown Denver (right near campus), they have a great benefits and tuition reimbursement program, they're working with technology I want to know more about, and their staff reads like a fantasy league of my career (I already know half the developers from other jobs).  The switch just made sense for me, but it wasn't easy to leave.

When I started at Rally nearly 3 years ago, it was a company that was struggling.  Not financially, but technologically.  For a long time, the company had done very well spreading agile to various customers, led by a product that was having features added to it at a breakneck pace.  **From the outside, the company seemed to have things together, but internally the codebase was a monument of technical debt and hasty decisions.**

The company had survived in "startup mode" for years, but the team was starting to buckle under the pressure of technical debt.  Feature development was slowing, and external bug reports were flooding in. Things weren't looking good.

Similar situations cause other companies to fail, but Rally was different.  Rally sold itself as a company that could help your company adopt agile and succeed.  Rally insisted on living what they preached, and the team committed itself to attacking their problems using the very tools and techniques the company taught.

{% image IMG_20110531_104052-300x224.jpg align="left" caption="The Engineering area" %}

We increased our test coverage, more than quadrupling the total number of tests in the system.  We worked to convert integration tests into unit tests where possible.  We threaded the tests out during runs (which initially resulted in huge numbers of thread safety failures).  We converted a class of tests that could only run from within our J2EE container to tests that had no such requirement.  **Overall, the suite of tests went from running in 40 minutes to running in about 5, and with better coverage**.

We also completely rewrote our GUI test system, vastly reducing the number of false negatives.  We wrote a GUI test framework from scratch in order to abstract a lot of behaviors and assertions to substantially increase coverage of our app through the GUI.  **Our efforts provided a safety net for making large, crosscutting changes to the application, and we got the GUI tests down from an 8-hour nightly run to a 30-minute run on every commit.**

We attacked areas of the code that had grown brittle and problematic.  Through an enormous undertaking, we converted our entire domain, previously mapped to a relational database in a 5000-line file called `GeneratedTopLinkProject.java` (despite the name, it was hand-modified) to actually use [JPA](http://en.wikipedia.org/wiki/Java_Persistence_API) on top of EclipseLink, making modification of the domain classes far easier.  We held weekly "[Refactotums](http://thinkrelevance.com/blog/2008/05/23/refactotum-overview.html)" where we'd gather the entire team in front of a projector, use [Sonar](http://www.sonarsource.org/) to identify areas of the code that needed help, and refactor that code to improve it's design. **The code was aggressively and fearlessly improved.**  Hundreds of thousands of lines of code were deleted.

Personally, one of my personally proudest achievements was the elimination of "Use Case Mode" a deprecated mode in the application that, while used by very few customers, forced the code to branch in hundreds of areas and doubled the overall testing effort.  I was instrumental in both developing the data migration that converted our customers out of this mode, as well as [deleting tens of thousands of lines of legacy code](http://www.youtube.com/watch?v=qHjpIaH0i80).  I vowed to destroy this mode in my second week at the company, so being able to actually do it allowed me to tie a nice bow on my time at Rally.

There were even more efforts undertaken than those mentioned here.  Some took weeks and some took months, but the team was resolute.  Astonishingly, **all of this happened while still delivering new features for our customers and maintaining a healthy work-life balance**.  Feature development slowed, but it never stopped.  We never rewrote the codebase; we transformed the code, organically.

Being a part of Rally during this period of transformation has been fantastic for my career.  **Rally wasn't the only entity that was in "startup mode" 3 years ago - I was too**.  I was a cowboy coder, the kind of guy that didn't have time to write tests, and just wanted to get stuff done and out the door, quality be damned.  I managed to start at Rally right on the ground floor of the effort to mature, and as a direct result I got to mature right along with it.

Today, where I am in terms of how I approach software is miles ahead of where I was 3 years ago.  **I've grown and learned far more in the last 3 years than I did in the first 7 of my career.**  My understanding of design principles and good coding practices is so much more evolved, I'm almost embarrassed to ever have even been the person I was 3 years ago.  I hope to continue to improve and hone my craft, but I don't think I'll ever have an experience as intense and eye-opening as Rally's code quality bootcamp.

No matter where my career takes me, I believe that my years at Rally will be some of the best I ever had.  Though I am extremely excited to start at my new company, I know I will miss Rally a great deal.

