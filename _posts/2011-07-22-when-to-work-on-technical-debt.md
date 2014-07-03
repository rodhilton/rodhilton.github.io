---
layout: post
title: When To Work On Technical Debt
category: Programming
tags:
- agile
- estimation
- Planning
- slack
- technical debt
status: publish
type: post
published: true
---

I hear the same complaints and concerns from all sorts of different software development organizations.  It seems that development teams only suffer from a small handful of problems in the broad sense, and nearly every team seems to share them.

One problem I encounter constantly is this: **"We don't have time to address our technical debt!"**

Every company I've ever worked for has had this problem to some degree.  The development team realizes that there are some parts of the system that need to be cleaned up, but for a wide variety of different reasons, they feel like they don't have the time to actually work on improving those areas of the system.

{% image panic-300x225.jpg align="right" %}

The truth is, this is not actually that difficult a problem to deal solve.  As software developers, we deal with significantly more complex problems on a regular basis.

# Step 1: Stop Creating Technical Debt

I know this seems glib, but it really is the first step to solving the problem of technical debt.  No matter what you do to fix your system's problems, if you are creating more while you do it, you will never be out of the hole into which you've dug yourself.

Otherwise competent developers tend to create technical debt for one of two reasons:

 1. You're cutting corners to meet a deadline
 2. You're cutting corners to meet expectations

These seem similar, but there is a subtle difference between them.

## Meeting Deadlines

The former happens when there's a trade show or a conference coming up and your company wants to have something to show.  It can happen when your competitor is going to unleash something on a specific date and you want to take the wind out of their sails by making a similar announcement at the same time.  This is development with a deadline: the scope of the features and the time of delivery are fixed.

{% image credit_card-300x200.jpg align="left" caption="Sometimes, incurring debt is okay." %}

This is a bad situation to be in, but the fact is that it happens, and that's okay.

Think of it like money.  You want to only buy things you can afford, but occasionally a situation will occur that makes this difficult.  Imagine your television broke, and it would take 6 months to save up the money for a replacement.  If you do this, however, nobody in your home will be able to watch television, a movie, or anything else for 6 months.  On the other hand, you could go down to Big Box and purchase a new TV right now on your credit card, then pay it off, which will take 8 months.  You may decide that the two-month loss is worth it, and put it on your card, incurring debt.  This is not a problem, **as long as you pay it off right away**.  Pretending you never incurred the debt will screw you financially, you have to address it.

If this situation is uncommon, it's not bad (if this is happening every month, you have a serious problem).  Tread lightly, but if you have a conference coming up, it's okay to cut a few corners in order to make it happen, as long as you truly do go back into the system and clean it up immediately.

Incurring debt should, at the very least, be a conscious, team-wide decision. "We're going to have to create some debt right now in order to make this deadline, so before we start let's discuss when exactly we're going to fix it."

## Meeting Expectations

The other kind of debt is incurred when a team is trying to meet someone's expectations rather than a deadline.  Maybe for the first 12 months of development on the product, your team worked at a certain pace.  Your customers, your product owners, and the rest of your organization came to understand this pace, and have now come to expect it.  Unfortunately, since the 8th month or so of development, the only way to keep this pace has been to cut corners.  **_This is deadly to your project._**

What this means is that your _real_ pace, the pace at which you can develop features while maintaining the health of the system, is slower than the pace that the organization has come to expect.  You may not even know your _real_ pace anymore, because you have been working at the fake pace for so long, cutting corners and incurring debt.

There is absolutely no way to develop in this situation in the long term.  Your codebase will eventually get to a point where no work can be done, and you will have to either suspend all feature development to pay down all of your debt at once, or you will have to rewrite the entire application.  The organization and your customers will be furious with you for halting development, trust will dissolve, and tensions will mount.

{% image "http://chart.apis.google.com/chart?chbh=40,5,11&chs=300x200&cht=bhg&chco=4D89F9,FF0000&chd=s:l,x&chdl=Real+Pace|Bullshit+Pace&chdlp=t&chp=0.01,0.01&chma=|0,10&chtt=How+To+Lie+To+Your+Company" align="right" %}

Every time you do a week of development at your fake, unsustainable pace, you are **lying to your organization**.  Every week that goes by, you are reinforcing in their minds that your fake pace is a sustainable one.  Some developers will assume they know, claiming "well, it's so fast, surely they know we're incurring debt."  **No, they do not.**  They are assuming you are being a professional and doing your job, which means owning the code and growing it in a healthy way.

If you are in this situation, **immediately slow down**, start addressing any debt you've incurred, and adopt the correct pace.  The correct pace is not "the fastest we can get these features done," it's "the fastest we can get these features done without incurring even a single line of technical debt."  The best television you can afford is the one that costs less than how much money you have.  If you have to put even one dollar on your credit card, you cannot "afford" it under any reasonable definition of the word "afford."

Don't create new debt when it can be avoided, and pay it off immediately when it can't. 

# Step 2: Identify High-Interest Debt

Okay, so you're no longer putting the company's features on your engineering credit card, now what?  Unsurprisingly, the credit card analogy actually tells us what to do here as well.  The general strategy with credit cards is to [identify the credit card with the highest interest rate, and start paying that one off right away, supplying the minimum payment to other cards](http://www.suzeorman.com/igsbase/igstemplate.cfm?SRC=MD012&SRCN=aoedetails&GnavID=84&SnavID=20&TnavID=&AreasofExpertiseID=5").

{% image debt-free-300x225.jpg align="left" caption="Prioritize and attack debt." %}

The same goes for technical debt.  Make a list of all of the areas in the system that are problematic and causing pain for development.  Whiteboard it with your team (just don't let it become a bitching session).  Everyone can write down problem areas on index cards, then put them up on a board together.  Have your team discuss, or maybe even vote to identify the debt causing the most pain.

Once you have a prioritized list of debt, start at the top and work your way down.  Ignore anything on the list that isn't being addressed **right now**.  This allows you to pay off your debt while still developing new features and keeping the business happy.  If a new feature requires working with an area of the codebase that has been identified as debt, talk to your team about potentially re-prioritizing the debt list to move that area to the top.  If you decide not to, refuse to make it any worse.

# Step 3: Pay It Off

The last step is to simply work on the areas of debt.  Refactor, redesign, maybe even rewrite submodules.  Simple, right?

Of course, it's never that simple.  **This is actually where teams, in my experience, struggle the most.**  They feel like they are taking features away from customers or the business by working on debt instead.  They do all sorts of crazy things to deal with this, and all of them are bad.

# Mistakes

There are two common mistakes development teams make when trying to pay off technical debt.

## Mistake 1: Create a Debt User Story

A lot of agile organizations will create a user story to address the technical debt in a particular area, then try to get that story scheduled into an iteration.  **This is wrong**.

First of all, it's not really a user story: user stories are written from the user's perspective.  Users should not be able to see the effects of addressing technical debt.  Some teams will get cute with this, writing stories like "As a developer on the team, I'd like the XYZ module to not suck. Har-dee-har."  This is asinine, and it's an indication your team is suffering from process poisoning, allowing their process to dictate how they work even when it does not apply.  Even a story like "As a user, I want this page to load faster" is just shoving a square peg into a round hole.  Shoehorning something into your process means that your process has a flaw, because it does not allow for certain types of work that need to be done.

{% image pleading-300x200.jpg align="right" caption="Don't beg other people to let you do your job well." %}

More importantly, this tends to lead to teams begging their product owners to prioritize debt stories.  This is not a fair thing to ask your product owner to do.  He or she does not care about technical debt, all they can see is features and users.  Start telling them about how the database tables are designed in a way that causes too many joins per page load and you'll find their eyes start glazing over.

Customers and product owners have no reason to care about debt.  **Debt is your problem, not theirs**.  Even if a customer has a strong technical background, asking them to prioritize debt stories is not fair to them.  You are taking _your_ responsibility of managing your codebase's debt and making it _their_ responsibility.  It's a dick move.

Product owners and developers both have insight into the overall product and it's features.  But _only_ developers have insight into the code.  The product is everyone's job, but the **code** is your job.  Nobody else is going to make sure the code is clean, that's **your team's responsibility**.

## Mistake 2: Explain To The Customer/Product Owner

Even if you don't beg your customers to let you schedule a tech debt card, shouldn't you still explain it to them?  **No.**

Your customers and product owners do not care, nor should they.  Not only should they not have the responsibility hoisted upon them to solve your tech debt woes, but they shouldn't even be made aware of when you're doing it.  Frankly, it's none of their damn business.

"But because we want to address debt, we'll be delivering a feature later than we promised, shouldn't we tell them?" you may ask.  Yes, the very instant that you know something will not be delivered when you said it would, you should communicate that to everyone expecting it.  But don't explain why in any more detail than "we needed to address some problematic areas of the system."  

If you find yourself explaining the details of the problem, you're justifying it.  You're implicitly asking the customer to approve of your decision to address the debt.  You do not need to seek their approval.

{% image prescription-300x300.jpg align="left" caption="Trust is essential" %}

**Software developers are like doctors, not mechanics.**  When your mechanic tells you that you need to fix _X_, _Y_, and _Z_, you may ask for details about each fix so that you can say "well, it sounds like I need _X_ and _Z_, but not _Y_."  This is because there is no trust in the mechanic/customer relationship, people often assume their mechanic is trying to rip them off.  

When your doctor, on the other hand, tells you to take _X_ and _Y_ medication, the level of detail you ask for is much, much lower.  "It will help your liver."  Well, okay then.  We **trust** our doctors, so we know when they tell us to do something that it's for our own good.  Software developers need to be trusted by the organization in exactly the same way.  If we say we needed to work on some debt, the organization should assume that we're doing it for their own good and not farting around on YouTube all day.

Even more importantly, your feature delivery shouldn't slip because of addressing debt in the first place.  **You should be building debt work into your estimates.**  When you have to provide an estimate for some piece of work, you should realize that you will want to address some debt and increase your estimate accordingly.

**Doing the work correctly implies fixing the debt associated with it**, and it's not _done_ unless you have done so.  So when you asked when it will be _done_, you should keep in mind that some of the time spent will be addressing relevant debt.  Even if you can't think of any debt at the time of estimation, it's a good bet that there will be _some_ refactoring you want to do to improve things.  Assume it to be there, and estimate accordingly.

If you feel like this is "padding your estimates" then it's a safe bet you are planning your work out **at capacity**.  You are probably scheduling the maximum possible amount of work you can imagine getting done, so that your team is busy 100% of the time.  **This is stupid**.  Your plan should have slack built into it to address potential debt as well as unforeseen events such as illness or server explosions.  Spinning at 100% is a surefire way to burn out.  Relax, slow down, build a little flexibility into your schedule.  Start low, and if you find that week after week you're pulling in extra work, THEN you can increase the amount of work you schedule.  Starting high and reducing as needed never works, because you feel like you're disappointing your organization, so you stay at 100% no matter what.

Build slack into your schedule and your estimations.  The worst thing that happens is that you were wrong, meaning you deliver your feature earlier than you promised.  **Under-promise, over-deliver**.

# Summary

For the TL;DR crowd:

 * The first step to paying off your technical debt is to stop creating it.
 * The next step is to prioritize existing debt, ignoring everything that isn't top-priority.
 * Finally, start attacking it.  Maintaining the health of the codebase is your job, and yours alone.
 * Don't schedule cards or stories to deal with debt.  Just deal with it.
 * Don't ask permission or even tell the rest of the business.  They don't care.  They are assuming you're creating a healthy system as part of your job, make them correct in that assumption.
 * The key to attacking technical debt is to build it into your estimates.  The work can't be done unless you address its relevant debt.

{% image programmer-300x228.jpg align="right" caption="This is why they hired you even if they don't know it." %}

This is one of those solutions that's so obvious it's easy to miss.  It's not always easy to slow down, or deliver features later than you "could get them done" (for a completely incorrect definition of the word "done"), because everyone wants to make the business happy.

Making the business happy now at the expense of making them miserable later is not how a professional team operates.  Software development is a long game, not a short one, because software spends one hell of a lot longer being maintained than it spends being initially developed.

Nobody is going to maintain the internal health of the codebase other than you, nor should anyone else be expected to.  Make no apologies for doing your job well.

