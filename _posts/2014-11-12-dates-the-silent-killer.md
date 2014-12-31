---
layout: post
title: "Dates: The Silent Killer"
category: Programming
tags:
- process
- agile
status: publish
type: post
published: false
---

I'm a big fan of agile software development.  That's a big umbrella, there are all sorts of things that fit under the phrase "agile" and I think they can be categorized into two different groups: processes and practices.  Practices are the things that your engineering team does to make development go more smoothly, referring to things like test-driven development, pair-programming, one-click deployments, version-controlling configuration and environments, and the like.  Processes are the things your engineering team does as part of its interaction with the rest of the business: planning, estimating, velocity tracking, monitoring kanban metrics, and the like.

Most of the jobs I've had have been at "agile" shops, so I've had lots of time to come to a somewhat-recent observation.  I don't actually love agile software development.  I love agile **practices**.  I *tolerate* agile processes.

This should be no surprise, the practices are engineering-focused and the processes are business-focused, and I'm an engineer so obviously it's not for me.  The process stuff I don't particularly enjoy, but I realize that businesses **need** the output of that work from me and my peers, so I tolerate it because it's better than most alternatives.

All my career, I've taken for granted that businesses need things like predictability, and I've seen that agile processes seem to be the least-intrusive and most-effective way for me as an engineer to fill those needs.  Hence, I "like" them.  But for this post, I'd like to peel the onion a little bit and ask: do businesses really need the things that agile processes provide?

# Dates

When it comes down to it, the goal of agile process is to provide predictability.  In Scrum, you use planning poker and planning meetings along with velocity metrics to come up with predictions.  We've gotten 28 points worth of stories done in each sprint, and we have 115 points worth of stories in the backlog, so we should be finished in a little over 4 sprints.  Or in Kanban, you track your team's cycle times and throughput, perhaps you avoid bringing unreliable developer estimates into the equation and all and simply use historical data, but that data ends up being employed to provide the business with some kind of sense of when a set of features will be completed.

All of this process is in the servive of predictability, and the sole application of predictabilty is to boil sets of features down to dates.  Sometimes these dates are actually needed by other engineering teams, who need to know when something they depend on will be done, but they are actually only needed by that team so that *they* can provide some sense of predictabilty.

The entire "hook" of agile planning is that it takes a longstanding problem in development, a fixed scope with fixed time, and says that either of those dimensions can be frozen but the other one will have to vary as a result.  This means that you can either fix the delivery date and figure out what scope of features will be done by that date, or you fix the set of features and figure out when it will go out the door.  The scope of features, meaning, "what are we working on" is obviously something that cannot be avoided - it's a fundamental necessity to development.  But what's strange is, why does "time" have an equal importance?  Why do we treat "how long will it take?" as just as fundamental?

The answer seems to be that businesses care a great deal about these dates, and the dates are just as important to the business as the featureset is to the developers.  Perhaps it's the fact that I work in development, but I'm really starting to question the value of these dates to the business.  


Dude. lightbulb.  the business needs these numbers, because they have to know how much they're paying for features, so they can decide what to spend money on. you're dumb.