---
layout: post
title: What Is Technical Debt?
category: Programming
tags:
- agile
- business
- debt
- software
- technical debt
- yagni
status: publish
type: post
published: true
---

Paul Dyson has made a blog post entitled "[Technical Debt and the Lean Startup](http://pauldyson.wordpress.com/2011/08/15/technical-debt-and-the-lean-startup/")" as well as commented on my post about [When To Work On Technical Debt](http://www.nomachetejuggling.com/2011/07/22/when-to-work-on-technical-debt/"), challenging some of my claims.  I read through his post and, while it makes a number of good points, I think it ultimately advocates for a risky manner of running a business.  I started typing this as a response to his comment, but realized that it was long enough to warrant a separate post, so I'd like to go through his post's points one by one.

# Hit-By-A-Bus Syndrome

Let's look at his first example: that it's okay in a lean start-up to have an area of the system only understood by a single person.  He basically argues that, in a small start-up, you don't have enough people to pair-program on everything, so having a single person understand the system is alright.  This is a false dichotomy, he is saying that code must be either _paired_ or it must be _understood by only one person._  Even if you do not have the resources to pair-program every task, you can still have collective code ownership by simply having regular code reviews with your team.  It's not quite as good as pairing, but it's leaps and bounds better than a single person knowing the system.

Having an area of the system understood by only one person is unbelievably risky, so much so that I'm a bit stunned that someone as experienced as Paul would advocate it publicly.  If that one person fell ill, or took an offer at another company, he would have been royally screwed.  Development would have to completely stop while the other members of his team came up to speed on that aspect of the system, unable to ask questions of the original developer.  This situation would be even worse if he had very few developers; he may have to wait and continue development only after hiring a replacement.

What he's basically saying is "look, I know people say you need to drive with glasses if you have poor eyesight, but I have poor eyesight and I've been driving for years without getting in an accident.  If you have poor eyesight, you should consider driving without glasses too."

The fact that **PAUL** has not had to pay the price for incredibly risky behavior does not change the fact that it's incredibly risky.  If he's been able to get by with only a single developer understanding part of the system, he's gotten _lucky_.  That's what high-risk, high-reward behavior is: doing something dangerous because the payoff is high.  It works well when the risk doesn't bite you in the ass.  But when it does, you look back and realize what a mistake it was to engage in that behavior in the first place.

# Delaying Large-Scale Refactorings

Paul's second example is that custom code was developed in-house, but then a vendor supplied a solution later on that would have worked just as well.  He says that moving to the vendor-supplied solution qualified as a large-scale refactoring and therefore it was better to leave his custom code in place.

I agree, but not for the reasons Paul cites.  I agree because this is not an example of technical debt.

Let's imagine that you rolled your own ORM layer because Hibernate didn't exist when the project started. 5 years later when Hibernate is stable, your custom ORM solution is not debt.  Your custom ORM solution works well, it's well tested, and it's serving your needs.  It's not slowing you down.  Would you move faster if you did switch to Hibernate?  Quite possibly, but that's not because your team made poor design decisions in their ORM, it's because something better has come along.  I'd say that migrating to Hibernate in this case would be a smart thing to do, maybe worth doing if you have no other debt in the system, but way towards the bottom end of the priority list.

Now, if the custom code was **bad** or poorly-tested and it was something your developers have to fight against to get work done, it is debt.  Notice how I can qualify it as debt without even mentioning Hibernate at this point.  The fact that Hibernate exists in this scenario is completely irrelevant: bad code that slows the team is debt.  If there happens to be a vendor-supplied replacement that would make things easier, that's a **huge win**, because the alternative is to write new, well-factored custom code.  Having a replacement library will save a ton of time, but the bad code is debt whether there is a parachute or not.

If you have a large scale refactoring to do because the code currently written is bad, you have serious debt, and the fact that it's large scale doesn't matter - it's still slowing the team down.  If it is costing the team more time than it would take to fix that code, it's a no-brainer to fix it, "lean start-up" or not.  If it's not that bad, and it doesn't slow people down enough to be worth the effort of fixing it, it's still debt, but it's not high-priority debt (in the previous post, that's what I refer to as having a high interest rate).  Table it and revisit later.

# YAGNI as "debt"?

Paul's third example, "limitations left in place", is another example of not-really-debt.  His post mentions having an in-memory collection of objects rather than persisting the data to some kind of storage mechanism.  His team could have replaced it with some kind of permanent storage, but his customers' needs did not require it at the time.  This is not debt.  This is YAGNI, illustrated.  There is no need for persistence, so he didn't build it.  How is that debt?

Caveat: I am assuming here that he had some way of making the in-memory collection resilient against crashes and network problems.  If important user-data was in memory in a way that meant that a machine in his cluster going down caused his users to lose work (or worse, money), then it sounds like he's again advocating highly risky behavior because he got lucky enough to not have to pay the price.  His post is vague on enough on this point that I don't know the technical specifics of his situation, so I'm giving him the benefit of the doubt and assume it wasn't terribly important data he was storing in memory.

Code that exists to solve the problem at hand and no additional problems is not necessarily debt.  YAGNI is a good principle to follow, not an anti-pattern.

His last point and the rest of his blog post continues illustrating a strange dichotomy in Paul's mind.  For him, it seems, code is either "fully-paired, limitation-free, optimised code" or it is "technical debt."

This seems bizarrely simplistic to me, and it flies in the face of the YAGNI principle.  Code can be "good enough for now" without being technical debt.  Code can be debt-free without being completely future-proof to all possible futures.

His fourth example is a reporting function for users which was designed to be simple, but slow.  He claims that this was a suboptimal design, but I contend that not enough is known about the code, at least in the post, to make that determination.

His team had a requirement, which was to provide a report.  They wrote code that provided it.  Story done, requirement satisfied.  Now, let's imagine his users start complaining that it's too slow.  He makes a new story to make the report run in the average case in less than 5 seconds.

Now, when it's time to implement that performance story, that's when we can make the determination about if the existing code is technical debt.  Is the design of that code such that it is much more difficult to make the report faster than it should have been?  Meaning, did hasty decisions when implementing the report cost more time improving it than would have spent making it more robust in the first place?

This is not a question of if the code is "minimal" or "gets the job done and no more", it's a question of if the code is **bad**.  When it came time to make the report faster, did Paul's team merely **extend** the work that was previously done, or did they have to **undo** some of that work to fix poor decisions before they could add the new functionality?  If it was the former case, this is just YAGNI at work, no harm done.  If it was the latter case, Paul's team incurred technical debt that wound up needlessly delaying the delivery of a feature later on (speediness in reports).  

# So What Is Debt?

Technical debt slows down teams.  That speed loss is what I think of as analagous to a credit card's interest rate.  It's money you'd be keeping if not for the debt. 

Having parts of the system that could be better, prettier, or cooler does is not the same as technical debt.  Code can always be better, the question is if the code is bad enough that it's slowing the team down beyond what they could reasonably expect given the features they are implementing.

Technical debt is easy to detect, just listen to your team during standups or status meetings.

 > Well, the XYZ module doesn't currently support generating the report as HTML, so I'm adding that right now.

That's not technical debt.  That's just YAGNI.  Nobody needed HTML before, so it wasn't baked into the module.  On the other hand...

 > The fucking XYZ module needs HTML support, but it turns out the entire thing generates images instead of text so I've got to go back and rip all of the image generating bullshit out of the thing and replace it XML generation so that I can translate it to HTML, plus I've got to fix the code we've already got to work with the XML format instead of the images it's expecting.  So, yeah, I initially thought it would only take a day, but it looks like it's going to take all week now, Jesus Christ.

That's debt.

Notice that work which builds on it has three qualities indicating it's debt:

 * **Rework** - The developer here is not merely adding code to something, he or she has to go back into something that already exists and undo a number of design decisions.
 * **Underestimation** - The developer thought that adding this feature would take a certain amount of time, but after looking at the code he or she has realized it's going to take much longer.
 * **Frustration** - The developer feels as though they are fighting with the code rather than working with it.

Technical Debt is not merely code that you could have written before but didn't.  It's code you wrote before that makes the new code you want to write harder.
