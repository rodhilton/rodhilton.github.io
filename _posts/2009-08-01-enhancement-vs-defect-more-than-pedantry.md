---
layout: post
title: 'Enhancement vs. Defect: More Than Pedantry'
category: Programming
tags:
- agile
- bugs
- defects
- enhancements
- quality
- software
status: publish
type: post
published: true
---

Change is inevitable in the world of software.  In fact, the need for change and the related need to adapt to change are the driving forces behind the agile movement.  Requests for change generally come in one of two main forms: enhancements and defects.  A defect means "the software isn't working the way it says it will", whereas an enhancement basically means "the software isn't working the way the customer wants."

The basic cycle of modern software development looks like this:

 1. The customer tells the development team (often through a product owner) what he or she wants the software to do.
 2. The development team responds to this by telling the customer what it will do (via direct conversation, help documentation, the UI, etc).
 3. The development team makes the software do it.
 4. The customer tells the team how well it did.

It's step 4 that generates change requests.  The customer says that something isn't working the way they want it to be working, and the cycle repeats.

Very often, you will hear developers whine about enhancements that are being filed as defects.  Product owners will often respond by saying that it doesn't matter, it all has to be fixed.  A common phrase I hear is "they are all defects from the customer's perspective."  This mentality is echoed in [Practices of an Agile Developer](http://www.pragprog.com/titles/pad/practices-of-an-agile-developer).  The attitude is generally, defects and enhancements are basically the same thing, it's all work that needs to be done, and programmers are being pedantic when they insist on making the distinction.

But here's the deal: **the programmers are right.**

I understand that it seems pedantic to distinguish between defects and enhancements.  I understand that the way it looks is that developers are trying to play the "blame game."  The perception is that programmers feel that filed defects are their fault and filed enhancements are not, so when they complain about the line between the two things blurring, it seems like programmers are simply trying to prevent the company from blaming them.  This has some truth to it, of course, but there is far more to making the distinction than this oversimplification implies.

The fact of the matter is, it's important to know when the defects start piling up.  If you've got a backlog of hundreds of defects, defects that are being filed more quickly than you can close them, your team clearly has a problem.  You need to **solve that problem**, but you cannot do so until you've determined exactly _what the problem is_.  To do this, you must know if the defects are really defects, or if they are enhancements disguised as defects.

**What's the problem?**

A stack of **defects** means that there is a problem between steps 2 and 3.  The team makes a series of promises regarding what the software will do.  These promises may come in the form of public commitments, documentation, or UI that tells the user to expect certain things (sometimes subtly). But then the team fails to make the software correctly perform those duties.  Actions don't work, menu items cause crashes, commands result in incorrect responses, data is wrong, etc.  These are **defects**, and they indicate that the team is not going a good job making the software correctly do what it is supposed to, in terms of what the **team** wants it to do.

A stack of **enhancements**, on the other hand, means that there is a problem between steps 1 and 2.  The team looks over what the customer wants and then decides what to actually make the system do.  If what the system does is not what the customer really wanted, then the team has failed to adequately understand the customer's needs, and enhancements will be filed.  Functionality is needed, interfaces need to be less confusing, data needs to be easier interpret (even though it was ultimately correct).  These are **enhancements**, and they indicate that the team is not doing a good job making the software correctly do what it is supposed to, in terms of what the **customer** wants it to do.

A stack of defects points to a problem in _code_.  When the team opens the toolchest to solve the problem, the tools that will emerge are automated testing, stricter builds, better engineering practices like test-driven development or pair programming, code reviews, root cause analysis, code coverage metrics, and so forth.

A stack of enhancements points to a problem in _software_.  When the team opens the toolchest to solve the problem, the tools that emerge are conversations, more in-depth acceptance criteria, usability testing, frequent iterations and demos, prototyping, contracting with UI designers, and so forth.

**Code powers software, but it's not the same as software**.  Software is what users see, code is what programmers see.  If you are going to solve a problem, you're going to need to understand where the problem is.  Is it in your software, or your code?  The only way to know is to draw a clear line between defects and enhancements, then look at which of those two is taking up most of the team's time.

Does it seem overly pedantic to draw the distinction?  Yes.  Is it crucial to improving the quality of what gets delivered to end-users?  Absolutely.

**How do we know the difference?**

I thought about concluding this article with some type of flow chart that asks questions to help determine if something is a defect or an enhancement.  I thought about all of the different rules I use when trying to make the determination, but ultimately what I wound up with is a lot simpler than I expected.

The customer has filed a complaint about the system.  The complaint states that they are expecting a certain thing to happen, but something else happens instead.

Ask yourself this: **Does the something-else that's happening violate the acceptance criteria of any user story that the team has ever implemented and had accepted?**

If the answer is _yes_, it's a defect. The root cause is code quality.

If the answer is _no_, it's an enhancement.  The root cause is software quality.

I really couldn't think of a better way to draw a hard line between these two concepts, though I welcome visitors to comment with their own rules of thumb.

