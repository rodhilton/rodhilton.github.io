---
layout: post
title: I Broke Your Code, And It's Your Fault
category: Programming
tags:
- attitudes
- professionalism
- Refactoring
- tests
status: publish
type: post
published: true
---
One of the most enjoyable parts of my last job was that we hired a lot of junior developers and interns.  I really enjoy working with younger people than me, because they're as eager to learn new things as I am.  I also really enjoy discussing technical things with them, largely for selfish reasons: explaining something to someone else makes me understand that thing much better.

One particular intern on my old team was a lot of fun for me.  The company was the first place he worked since graduating with his B.S. in Computer Science.  The things he said were so similar to things I said when I first graduated, and his approaches to problems reminded me so much of my own approaches to problems eight years earlier that it bordered on creepy.

One particular exchange between him and I stood out in my mind.  It was exactly the conversation that 28-year-old me would have had with 20-year-old me.

{% transcript %}
	Him: Arggh, the other team changed the interface of something my code is using, and now it's broken.
	Me: So?  Just fix it.
	Him: I will, but it's annoying.  I mean, if they had just started the application they would have seen it's broken.  They're such idiots.
	Me: Wait, it breaks right away?
	Him: Yeah, you get an error when you hit the front page.  The front page!
	Me: Sounds like we're the idiots.
{% endtranscript %}

He was frustrated the other team had made a change and not even run the application.  They had checked code in without even giving it a run-through in the application live.  **How unprofessional could you be?**

My answer?  A _lot_ more unprofessional.  How?  By not creating any tests for your functionality.

{% image JUnitRunner-300x235.gif align="right" %}

The other team's code immediately broke the entire application.  Yet, **every single test in the commit suite passed**.

The team that failed here was **my** team.  We had not created good test coverage, and the proof was in the pudding.  A change that completely crippled the application turned no tests red.  

Early in my career, I was afraid of making changes that could affect unexpected aspects of the system.  My first job out of college, whenever I made changes, I'd read lots of code and was extra careful.  Of course, nobody can ever be careful enough with this methodology, so I'd wind up breaking things.  I'd feel awful for this, completely embarrassed.  I'd panic and try to fix the code as quickly as possible, assuming my co-workers thought I was an idiot.

Today, I take the exact opposite approach: **fearless refactoring**.  I refactor code without even the slightest bit of concern about the ramifications.  If I break something, a test will let me know.  If no test lets me know when I broke something, I don't feel embarrassed.  I feel like someone else should be embarrassed.

If you break my code and all of the tests pass, it's not your fault, it's mine.  As a corollary, **If I break your code but all of the tests passed, it's not my fault, it's yours.**  

I have unapologetically embraced this attitude, and I'm more than happy to share it with people.  If someone makes a change that breaks my code, I don't give them hell for breaking my code, I thank them.  They found a part of my code that I had not correctly covered with a test.  Code coverage can only do so much, sometimes the only real way to know if you're missing a test is for someone else to break your code in unexpected ways.

"But wait a second," you say, "you're telling me that if I have an application that uses the Twitter API, and they suddenly change the API without telling me, it's MY fault, and not theirs?"  Obviously Twitter shouldn't do that with such a public API, but by the same token I have to ask you, did you really not write one single solitary test that actually integrates your application with Twitter?  Why trust Twitter that much?  If they fundamentally changed their API, one measly test that actually USED your application would tell you that.  A high-level test that interacts with your application the way a user does will test nearly every external dependency you have.  A couple days of time to write the test, and it saves you hours upon hours down the road.  If you don't do that then, well, yeah, it's your fault.

{% image hudson-300x232.png align="left" %}

This attitude extends to deployments as well.  Just recently I was having a conversation with co-workers about whether it was safe to deploy some code that had a lot of changes in it (including mine).  Without even thinking, I said it was fine.  They looked at me like I was crazy.  How could I be so confident in the code without even looking at what anyone had written?  Simple: all of the tests were passing on the build.  **I assume that all code with a passing build is deployable to production.**

Is it possible that I'm wrong?  Absolutely, there's lots of undeployable code in the world that passes a build.  But deploying it and having it fail is extremely valuable - the failure indicates a big area that needs to be covered by automated tests.  I'm happy to deploy code and have it fail spectacularly, it helps me know what tests need to be written, which will prevent such a thing in the future.  I try to keep my eye on the long game of software development.  Obviously you don't want to deploy and have the entire system break - so it's important to be able to rollback a release in the (hopefully rare) event of a problem, or at least roll out to a single node and then remove that node from rotation if there's an issue, but those rare and not-terribly-costly occurrences are a necessary step for building confidence in one's test suite.

I take the attitude that passing tests indicate the underlying code is perfect and, should I be proven wrong via failure, I immediately write tests to justify my attitude.  **Why else would you write tests, if not to prove your code works? **

Tests exist to give you confidence that your application works perfectly.  If your test suite doesn't give you that confidence, your test suite needs improvement.  You need more unit, functional, integration, GUI, browser, performance, or load tests - whatever you need to focus on to feel confident.  **If you're just going to insist on manually testing the hell out of your application anyway, why bother writing the tests?**  You'd get more done if you weren't spending the time writing all of them.  If you're writing tests, you're implicitly stating that a test suite should increase your confidence in your code.  Put your money where your mouth is, declare that any code that passes your full test gamut is production-ready, and dare your code to prove you wrong.

If you assume your code is right because the tests pass, and you are shocked every time that assumption is wrong (and respond appropriately), then after a short time your assumption will be true.  This seems radical and dangerous to many, but it's less difficult than one might think, with [plenty](http://engineering.imvu.com/2010/04/09/imvus-approach-to-integrating-quality-assurance-with-continuous-deployment/) [of](http://about.digg.com/blog/continuous-deployment-code-review-and-pre-tested-commits-digg4) [companies](http://sna-projects.com/blog/2011/06/continuous-deployment-flickr/) [working](http://radar.oreilly.com/2009/03/continuous-deployment-5-eas.html) [this](http://www.startuplessonslearned.com/2009/06/why-continuous-deployment.html) [way](http://www.slideshare.net/jallspaw/10-deploys-per-day-dev-and-ops-cooperation-at-flickr).  A really good strategy for improving your software development process is to take the thing your team is most afraid of doing, and strive to do it much more often.  If your team hates releasing, there's good reason for that, so try to release daily.

Obviously, this kind of mentality doesn't apply to some industries.  I don't think it really works with shrink-wrap software or game development, for example, but for web development in works great.

