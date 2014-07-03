---
layout: post
title: 5 Ways To Hose Your Estimates
category: Programming
tags:
- brain
- consistency
- crossposted
- Estimating
- Planning
- planning poker
- triangulation
- warnings
status: publish
type: post
published: true
---

Everyone knows the drill with Agile: the developers put estimates on stories, and those estimates are used to plan releases.  Of course, some releases go awry, with the engineering team delivering far fewer completed stories than expected.  When this happens, people start to ask "why are our estimates so inaccurate?"  What many don't realize, however, is that this is the wrong question.  Estimates don't need to be accurate, they need to be consistent.

Our velocity corrects for the inaccuracy of our estimates.  As long as engineers are consistently wrong, the velocity will ensure that releases can be planned and executed smoothly.  If releases start to become increasingly bumpy and unpredictable over time, there's a good chance that your consistency is to blame.  Poor consistency means rocky, less predictable releases, which in turn can lead to incurring technical debt in order to meet release commitments.

Here are five things to watch out for within your team.  These are inhibitors to consistency that typically will plague a seasoned agile team, not a new team transitioning into agile.

# 1. Lack of Analogy

Estimates on stories are meant to be relative to other estimates on stories.  Whenever engineers think of an estimate, they need to be comparing the story to other stories in the past in order to evaluate consistently.

Whenever the engineers put, say, 3 points on a story, find a 1-point story nearby and ask "Alright, is this 3 times as complicated as this earlier story?"  This is called **triangulation**, and it's vital to ensuring consistency.  Do this periodically throughout planning, particularly for stories that generate a lot of discussion and disagreement.

It's helpful to have a set of stories close at hand to make this comparison.  I recommend creating a **point board** in whatever room is used for planning.  On that board, list a handful of previous stories and the estimates that were given to them.  Try to have a story or two for each possible estimate.  When you are planning, you can say "we gave this a 5, which is the same thing we gave story so-and-so according to the point board.  Are these approximately the same in complexity?"

_How To Fix: Triangulate regularly, keep a point board._ 

# 2. False Precision

It takes a certain level of arrogance to decide you can make a computer do anything you want, so it's no surprise that engineers have a natural hubris.  Unfortunately, this hubris can often mean that engineers think they have a better understanding of things than they really do.  A good indicator that your team is overconfident in its analytical skills is that their estimates are unnaturally precise.

Do discussions like "well, I don't think that story is really a 3.  Maybe a 2.5," sound familiar?  If so, your team is working with a fictional level of precision.  The difference between a 3 and a 2.5 is smaller than the natural margin of error for something so inexact as story point estimates.  If an engineer starts arguing that story should have a 4 since a 3 is too low and a 5 is too high, there's a good chance the engineer is treating points with a level of a precision that they simply do not carry.  If that engineer were in a sour mood, they may have said a 5 instead.

You want your points to be forced into buckets &#8211; buckets with wide enough gaps between them that there is no need to quibble over insignificant differences.  [Mike Cohn](http://www.amazon.com/Agile-Estimating-Planning-Robert-Martin/dp/0131479415) recommends either a fibonacci-like sequence (0, 1, 2, 3, 5, 8, 13, 20, 40, 100) or a base-2 sequence (0, 1, 2, 4, 8, 16, 32, 64, 128) to ensure that the buckets are reasonable.

Seasoned agile teams may find themselves eventually estimating within a very small range of possible values and making up for the loss of range with an increase in precision.  Don't buy into it, the precision is imaginary.

_How To Fix: Pick a sequence and stick to it._

# 3. Groupthink

Over time, your agile team will increasingly gel together.  This is normally a good thing, but it can have negative consequences if the team eventually starts to act and think as a pack.

For a group to be smarter than the individuals in the group, it has to be [diverse, independent, and decentralized](http://en.wikipedia.org/wiki/Wisdom_of_crowds#Four_elements_required_to_form_a_wise_crowd).  The longer an agile team works together, the more trust they build together (that's good).  The more trust they build, however, the more they start to think that a subset of the group is a good representative of the entire group (that's bad).  When only part of the group is consulted for estimates, you lose the diversity and decentralization properties of the team, and as a result your estimates become less consistent.

{% image 2009-07-24-092738-150x150.jpg align="right" %}

It's also very common for seasoned teams to tire of using planning poker cards, instead electing to hold fingers in the air.  This simply makes it too easy to move as a group.  If you hold your fist in the air with the intention of throwing a 3, but notice that another team member throws a 2, it may affect your vote, even if you are not aware of it.  Furthermore, using fingers instead of cards makes it difficult to estimate at an 8 or above (as soon as someone lifts both arms, you know they aren't going to throw a 5).

_How To Fix: Always estimate with the entire team, even if it's a little inconvenient.  Use planning poker cards instead of fingers (or at least have everyone close their eyes when throwing their estimates)._

# 4. Mental Drain

The longer a meeting goes, the less able people are to maintain a consistent level of focus.  A story estimated towards the end of planning simply will not get the same consideration as one towards the beginning.  You want to limit the amount of time planning takes without limiting the amount of good, useful discussion that takes place during the meeting.

Handily, there are diminishing returns on conversations.  The first few minutes of a discussion will reveal the bulk of information that engineers should consider.  A few more minutes reveal more still.  But after that, people are just going to be repeating what they said earlier.  Cut the conversation off and move on.

I recommend playing planning poker twice, separated by a sand timer.  After the first set of estimates are made on a story, start the timer (you can find these at hobby shops and game stores).  When the time is up, play another round of planning poker.  If the team still can't agree, it should shake confidence in the team's estimate as a whole, and you should take the largest estimate (not the average).

_How To Fix: Play two rounds of planning poker and use a timer to limit discussion._

# 5. Large Stories

It's easier to wrap your brain around smaller things than larger things.  Next time you have a large story and decide to break it into smaller stories, see how many points fall out?  Does your 13-pointer break into two 3's, two 2's, and three 1's?  Probably not.  In all likelihood, your 13-point story, when broken into smaller stories, becomes something closer to a 20-pointer.  Not only is this a problem for scheduling, it is a good indicator that the engineers aren't considering all of the angles when estimating the larger story.

It's not the 20 points worth of small stories that are wrong, it's the 13 points initially.  It's simply too hard to consider everything when estimating large stories.  Product Owners need to understand this and break stories up as small as possible BEFORE engineers estimate them.  Once the number has been assigned to a large story, it affects the points given to the smaller stories that break out of it.  This is called [anchoring](http://en.wikipedia.org/wiki/Anchoring), and it's a well-known cognitive bias.

Encourage your product owners to break stories up before they are estimated.

_How To Fix: When a story 'feels' too large, break it into smaller stories before any estimates are given._

# Wrapping Up

These problems are symptomatic of a seasoned agile team that is falling into a rut.  Being a successful agile team requires work; it requires a continuous level of self-assessment and self-improvement.

Engineers have a duty to be as consistent as possible with their estimates so that their estimates can be used to create predictable, smooth releases.  If your team starts slipping in this regard, try to figure out if you are making any of the mistakes listed here.