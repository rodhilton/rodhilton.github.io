---
layout: post
title: You Have To Buy It Twice Before It’s Cheap
category: Programming
tags:
- crossposted
- Design
- Estimating
- estimation
- Incremental Design
status: publish
type: post
published: true
---

One of the most common sources of tension between product owners and developers is when product owners are surprised at how high an estimate for a story might be.  Usually this tension is easy to resolve by reiterating that the product owners really have no concept of how much something should cost.  However, there is one scenario I see over and over again: when a product owner protests the estimate of a story because it seems, to the PO, like it's simply re-using an aspect of the system somewhere else.

"I already paid for that!" he or she might say, quite correctly.  A simple example recently for us here was our column picker.  Our grids allow you to select which columns you wish to see on any given grid.  Later on, we created the ability to have grids inside of panels on user dashboards.  Our product owner wanted to put the column picker on the settings pane of a grid panel.  To him, this was simply reusing the column picker that had already been created for an earlier story.  He was quite shocked when our estimate for the effort was just as high as it was the first time.

His frustration is completely understandable.  How is this possible?  Why isn't it easy to just drop that component into another place and have it work?  After all, if we were good engineers, wouldn't we have written that component to be reusable?

Actually, **no**.  It's **because** we were good engineers that it wasn't written in that way.  This is one of the hardest things for product owners to understand, and I hope to explain it in this post.

# Evolutionary Design

Once upon a time, development teams worked in specific phases.  First they would design all of the code they were going to write; boxes would be drawn on whiteboards, sequences captured in documents, and so on.  Once the design was finished, the developers would go off and write the code for it.  Luckily, our industry has realized that this is a problematic way to write software.

It's simply not likely that the team will discover all of the quirks of the design during the design phase.  It's even more likely that requirements and features will change during the long span of time this process takes, forcing the developers to throw away work and go "back to the drawing board" on the design.  Splitting the design phase from the coding phase is a recipe for disaster.

Instead, it's generally preferable to practice [evolutionary design](http://en.wikipedia.org/wiki/Continuous_design); allow the design to grow organically as the code is written.  This, combined with testing and refactoring, seems to be the best known way to ensure that the quality of the code remains high as a product grows.

Doing this makes it easier to deal with changes that effect design, and it prevents the team from wasting time going "back to the drawing board" in the event a problem is discovered.

# YAGNI

One principle to follow as you code is the [YAGNI](http://en.wikipedia.org/wiki/YAGNI) principle.  YAGNI means "You Ain't Gonna Need It" and essentially it means that developers should discourage themselves from adding additional code to support something that is not, at the time, required.  Developers have a strong desire to add code here or there while editing code, and YAGNI helps us remember to resist the urge to add superfluous code or functionality.

Following this principle helps eliminate waste, and helps keep developers focused on adding value that product owners want.  But why?

If I'm editing **_Module A_** to add **_Functionality X_**, why not just add **_Functionality Y_** while I'm there?  It may delay the delivering of **_Functionality X_** in the short-term, but later when it's decided that **_Functionality Y_** must be supported as well, it will be dirt cheap, right?

The trick to understanding why YAGNI helps is realizing that there are thousands upon thousands of potential **_Module A_**s in a system.  The truth is, **_Functionality Y_** may simply never be required.  And even if it is, **_Functionality Z_** may not be.  Adding that functionality would be a waste of time and resources if it's never used.

# YAGNI Applied to Design

The same principle behind YAGNI can be extended to aspects of high-level design.  When we originally designed the Column Picker component, it was not designed to be dropped into any part of the system.  This was intentional: if we had spent the time to make the Column Picker completely generic and reusable, but then had never needed to drop it into another part of the system, the additional effort required to make it super-generic would have been a wasted effort.  This is true for any aspect of the system being designed: we can spend the extra time and effort to make something extremely generic, but if that generality is never needed, that time is waste.  Many times developers will refer to something that's overly generic as "over-engineered."

This means that the description of the component can often be misleading.  We never built "a column picker" &#8211; we built "a column picker for a grid page".  The column picker was written in a way that assumed it was part of a grid page.  Again, it could have been written more generically, but doing so would have potentially created waste (_this does not mean that it's alright to design code that violates [principles of good design](http://en.wikipedia.org/wiki/Solid_(Object_Oriented_Design)).   Code can be well-designed but still not fully generic_).

So when it came time to put the component in a completely different context than the one for which it was designed, it was still a lot of work: almost as much as was originally required to make the first pass.  Though some time was saved simply because it was a known and well-understood problem for which we would leverage newly-developed knowledge, it still effectively required writing a whole new component: one that was much more generic and utilized what it could of the previous increment.

Essentially, to avoid having developers waste time, components should be "generic on demand".  Once a component needs to be reused, then it should be refactored into something extremely generic, but not before.  The end result is that a product owner will have to pay for a component twice before it's cheap.

This may seem counterintuitive to product owners, but it's important to understand.  Because the team approaches coding in a way that causes the second time to be nearly as expensive as the first, the team is able to deliver **everything else** quickly.

The first time, it is costly because the developers have to solve unknowns and create something new from scratch.

The second time, it is costly because it has to be molded into something generic and reusable.

The third time, however, is cheap.