---
layout: post
title: 'QCon New York 2015: A Review'
category: Programming
tags:
- career
- conference
status: publish
type: post
published: true
---

My default yearly conference, for many years, has been [UberConf](http://uberconf.com/conference/denver/2015/07/home).  I really love UberConf because it's packed full of tons of great sessions, and it's conveniently local.  However, because I go to various local user groups and attend so often, I find that, if I go two years in a row there are too many sessions I've seen before, and I wind up disappointed.  So for the past few years, I've been alternating between UberConf and something new.  Two years ago, it was [OSCON](http://www.nomachetejuggling.com/2013/07/30/oscon-2013-a-review/), and this year it was [QCon New York](https://qconnewyork.com/).

I chose QCon for a few reasons.  One, the sessions seemed very focused on architecture and higher-level concepts, with very few language/technology talks.  This was right up my alley because, while there are some languages and tools I'd like to go deeper on, I think a more significant area for improvement for me is architecture and scalability.  We get tons of traffic at my job - more than any other place I've ever worked - so I've had to learn a lot about scalability, and the nature of the work has forced me to really see broad system design differently.

I went to QCon specifically wanting to improve some areas where I was weak, namely containerization, microservices, and reactive programming.  I hear a lot of buzz about these things, and they pop up on recent [ThoughtWorks Technology Radar](http://www.thoughtworks.com/radar/a-z)s, and QCon seemed to have a lot of sessions to offer in these areas.  It took a LOT of convincing to get my employer to agree to send me to a conference location as expensive as New York, but eventually they approved it.  Here I will detail some of my thoughts about the experience, in case it may be of use to others considering QCon.

<!--more-->

# Sessions

First and foremost, the sessions.  Networking isn't my thing, I'm all about the quality, quantity, and variety of sessions offered.  **I picked QCon based on the sessions, and I was not disappointed.**

The sessions were well-arranged into tracks, as is common with these kinds of conferences.  What was somewhat different about QCon, at least from my perspective, was how cohesive sessions were within a track, and how diverse the tracks themselves were.  A lot of times tracks are really general, like "Java" or "Agile", or they can be too similar to each other.  In QCon's case, all of the tracks themselves were very different, but very specific, like "Fraud Detection and Hack Prevention" and "High Performance Streaming Data".  Within a track, all of the talks were very closely related, and it actually made sense to pick a track and stick with it, rather than buffet style picking-and-choosing based on session alone.

The sessions were the perfect length.  I've complained before that UberConf's 90 minute sessions can sometimes seem overlong or padded, and that OSCON's 30-minute sessions seemed rushed or abbreviated right when they were getting good, but QCon strikes a great balance at 50 minutes each.  This is short enough to prevent topic fatigue, but long enough to go in depth.  Speakers usually did a great job of giving a presentation in-line with the topic title and description as well, which is (somewhat surprisingly) rare for tech conferences.

One complaint is that __slides were usually made available AFTER sessions were over__.  I hate when this happens, I want to see slides ahead of time, both because I can use them to make sure the content is going to be interesting, and because I use Evernote to actually take notes IN the PDF itself, highlighting or marking up the document with my own notes.  The only argument I can imagine for why slides would be held off until after a presentation is that speakers might be modifying the slides until just before they give a talk, but frankly I think that stinks of unpreparedness.  Slides should be available in advance, no exceptions.

One excellent feature of QCon was that almost all of the talks were published in video form after the sessions were over (usually late at night or the next day).  The recording quality was excellent, full video of the speaker and their slides synced up, and actual cameramen that kept the speaker in frame for the whole talk.  Audio quality was excellent as well.  UberConf does something similar by making audio-only available, but sometimes speakers forget to press record, and I often found myself skipping some sessions with the intent to listen to them on audio later, only to find that they weren't recorded.  QCon solves this problem entirely with a professional A/V staff and quick editing/uploading.  What's more, the slides are available when the video is - **I actually found myself more easily able to take notes on the recorded talks than I was able to when watching talks live.**

I learned a whole bunch from the sessions I went to, though there was a day (Thursday) where I narrowed down to two talks for every time slot, only to find out based on Twitter that the session I _didn't_ choose was the better one.  This was annoying, but I fixed it with the video recordings.

I also really liked there being a special "Modern Computer Science in the Real World" track - it's rare to see really heavy CS stuff at programmer conferences, I liked it.

{% image qcon_sessions.jpg %}

## Mini-Talks

On Wednesday, each of the tracks had a session which was "mini-talks", kind of a series of lightning talks related to the track.  I really, really love lightning talks, I have found that there are a lot of 40-50 minute talks that really should just be 5 or 10 minute lightning talks, and they're a great way to get wide exposure on a lot of different topics.

I wish QCon had done a mini-talks session for every track, rather than just the tracks on the first day of the conference, because **the mini-talks were great**.  Again, the video recordings were instrumental here, it was extremely tough to decide which mini-talks to attend, and with the help of video I was able to attend all of them.

## Open Spaces

QCon also has an "Open Space" slot for each track, where attendees would get together and brainstorm their own topics, then other attendees would speak about them if they knew anything about the topic.

I hate these things, I typically find that they either fizzle out due to not enough participation, or get completely controlled by a single enthusiastic person.  I guess a lot of people like Open Spaces, but they just aren't for me.  Every time I saw an Open Spaces talk on the schedule, I wished it was another session, or a session of mini-talks.

# Workshops

Like a lot of other conferences, QCon had two days of workshops.  Workshops can be really hit or miss in my experience (usually miss), and QCon was no exception.  One way QCon did a good job was that Monday was for all-day workshops, and Tuesday was for two half-day workshops (though they had some all-day ones as well).  This is a good way to go, personally **I've found half-day workshops tend to work better than the all-day variety**.

The workshop I picked for Monday wound up being entirely not what was I expecting.  It was extremely academic and not very hands-on, which is about the greatest sin a "workshop" can commit.  If every participant isn't on their laptop, it's not a workshop, it's just an all-day lecture.  QCon was particularly strict about not allowing you to change workshops after making selections, so I was stuck in the workshop the whole day, hating it.

The two half-day workshops were much better, but again they suffered from the problem so many workshops have, which is **catering to the slowest, least prepared people in the workshop**.  I've said it before but if you ignore the e-mail that goes out with the instructions to get set up, you should be left behind.  Read the e-mails and do the setup, if you can't do that then you deserve to have your money wasted; the alternative is that everything slows down so you can catch up meaning everyone else's money is wasted instead.

I especially want to call out [Everett Toews](https://twitter.com/everett_toews) for doing an excellent job with his OpenStack half-way workshop.  He had a bunch of helpers who got the slower people set up without having to slow down himself, and overall the workshop got a lot accomplished and taught me a lot about OpenStack.  I think the session occasionally devolved into "here, copy and paste these commands" lacking explanation, but for the most part the entire workshop was great, and **easily a highlight of the conference for me**.

# Keynotes

I tend to expect Keynotes to be extremely non-technical technical talks.  Like a talk that you might find scheduled normally, except watered down to a point where every audience member would be okay choosing it.  These usually mean I'm not a fan of them.

OSCON had an interesting approach to the Keynote, which was a series of short keynotes, almost lightning-talk style, which I really liked.  QCon didn't do this, but they actually managed to avoid the "technical talks with no technical information" by having legitimate technical talks, pretty in-depth from a technical standpoint.

**Mary Poppendieck's Microchips to Microservices keynote was fantastic, as was Todd Montgomery and Trisha Gee's less technical but still highly enjoyable "How Did We End Up Here?" talk**.  I disagreed with a lot of points that Todd and Trisha made, but their talk gave me a lot to think about, which is always fun.

I wasn't a big fan of "Driven to Distraction" which was a talk about the different kinds of "X-Driven-Development" there are.  This was largely intended to be a comedy talk, rather than a technical talk, and it closed the day rather than opened it.  I wasn't a fan of the humor, honestly.  A little into the talk, I realized he was literally going to the entire alphabet, ADD, BDD, CDD, DDD, EDD, and so on.  Some letters got multiple definitions, I think I gave up and left around GDD ("Google Driven Development", because we Google things, har).  Kind of ended the conference on a sour note, but something skippable at the end is nice in case your brain is fried, as mine was.

# Expo Hall

Like OSCON, QCon had an area for vendors promoting their products and giving stuff away.  This room was much smaller than OSCON's, but it wasn't off to the side.  In fact, you had to walk through to get to 3 of the salons with regular talks, which was somewhat annoying.  However, the vendors themselves were a lot less pushy, and only tried to talk to you if you came directly to their book and initiated conversation.  They also let you go more easily once you indicated you wanted to move on.

I can't complain much about the vendor room, they gave cool stuff away and getting your nametag scanned for the low low price of being pestered via e-mail later on earned you a spot in a drawing.  There were enough giveaways that your chances were fairly decent, in fact I won a Lego Mindstorm set.

{% image qcon_haul.jpg caption="Swag!" %}

I still think the coolest version of this I've ever seen is at OSCON, where the Expo Hall was gigantic and had all sorts of interesting stuff in it, with a lot of demos and products (even a car).  QCon's room being so much smaller meant that you could go see every booth in just a few minutes, but then were stuck going through the same room multiple times throughout the conference.  It also could get extremely crowded in the room, with both booth traffic and just-passing-through traffic, which discouraged me from wanting to spend much time booth hopping.

# Attendees

**I really liked the class of people at QCon, it seemed like mostly seasoned veterans in the world of software engineering**.  There weren't a lot of young hipsters or brogrammers or anything like that, it seemed like a lot of graybeards.  I'm a fan of that, I think our industry generally undervalues people that have been in the field for a while, so it was nice to see such a seasoned group.

Of course, I mostly avoided talking to people because I hate networking, so I can't say much more than that.  All I can say is I didn't overhear conversations that made me cringe with people saying dumb shit like "what's the big deal with functional programming, I've been using C++ for years and it's fine" (a real thing I heard at a conference once).  So it seemed like a brighter group of people overall than I've seen at some other conferences.

One thing I will say, I really liked how QCon set up their lunch tables.  Lunch is typically when most of the socializing happens, and OSCON for example has tables for people with similar interests to meet and mingle.  QCon had a similar setup, but I appreciated that they also had a handful of rectangular tables pushed against the walls on the perimeter of the lunchroom.  A clear set of "I don't want to mingle" tables.  Good stuff if you hate chit-chat like I do.

<blockquote class="twitter-tweet" lang="en"><p lang="en" dir="ltr">Just ran into stranger at <a href="https://twitter.com/hashtag/qconnewyork?src=hash">#qconnewyork</a> who recognized my name from my badge because he follows me on Twitter and doesn&#39;t know why. <a href="https://twitter.com/hashtag/surreal?src=hash">#surreal</a></p>&mdash; Rod Hilton (@rodhilton) <a href="https://twitter.com/rodhilton/status/608641289379262464">June 10, 2015</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

# Venue

Alright, here's the bad news.  The conference was held at the New York Marriott at the Brooklyn Bridge, and **the venue was easily my biggest complaint about the entire conference**.

The hotel itself had absolutely no restaurant (or bar for that matter), which made meals a bit difficult.  What the Marriott had was a lounge that you could pay to access for $75 per day, which is outrageous.  The lounge was the only place to get a meal or a drink in the entire building, and there was no room service offered.

Normally only dinners would be a problem in this type of situation, since conferences usually include breakfast and lunch.  However, what passed for 'Breakfast' was extremely disappointing - 100% pastries and breads, no eggs or meat or protein of any kind (actually they did have bland, ice cold poached eggs).  Nothing served warm or even warmable (bagels, no toaster).  A bunch of pastries and muffins are not "brain food" - starting a full day of technical talks with a bunch of muffins is a surefire way to be nodding off by the third talk.  I wound up walking to a nearby Panera every single morning to get an egg sandwich.

Lunch was better, but also not great.  I think by choice of QCon itself, the hotel catering had to make everything gluten-free.  I find the whole gluten-free for non-celiacs fad generally irritating but what really made this annoying was what foods they chose to serve.  If I say to you "okay we need a vegetarian meal" you try to think of foods that don't involve meat, you don't immediately think of a meat dish and substitute tofu in.  Similarly, why does your 'gluten free' menu consist almost entirely of gluten-free pasta?  I wound up grabbing lunch elsewhere for 3 of the 5 days I was at the conference.  This was frustrating, because I convinced my employer to send me to NY by arguing that meals were mostly included, but then I wound up having to pay for most meals.

Aside from workshops, it was very rare to find tables in the sessions - usually it was just rows of seats.  And the walls were those sliding accordion walls that hotels use to divide huge rooms into sections.  The end result being, it was very hard to find a place to plug in a laptop, and situate it in a way to take notes.  This isn't really the venue's fault, I'm sure QCon told them no tables, but it's always something that irks me as a notetaker.  Like I mentioned earlier, I actually found it easier to take notes and watch sessions from the video recordings, from the comfort of my hotel room after hours.

# Misc

In summary, QCon absolutely excelled in terms of session quality, variety, and depth, but workshops were an area for improvement (as with every other conference that offers them), and the venue itself was dreadful.

I learned a lot at the conference, and was able to gain a lot of insight in the areas where I was hoping to.  One particular interesting note was, I went to a lot of "microservices" talks, but almost all of them were "here are some tips for your microservices" and not "here are pros and cons of microservices" or "why you should use microservices".  In other words, most of the microservices talks assumed that you were already building and deploying microservices.  This was somewhat shocking to me and made me feel behind the curve a bit - I'm really not sold on microservices, I think the operational concerns are likely to outweigh the benefits, so it was interesting to see it presented like that ship has already sailed.  There was a talk by StackOverflow in favor of monoliths, but everything else was all microservices all the time.  Martin Fowler recently published a great [pros-and-cons of Microservices article](http://martinfowler.com/articles/microservice-trade-offs.html) that I found myself nodding along to.

QCon had a nice 'custom schedule' builder like OSCON but QCon's was a bit behind, it didn't integrate with an app and give notifications like OSCON's did.  However, the full video recordings of sessions available same day were phenomenal, and the ability to share with 10 other people who didn't attend the conference is awesome.

**Overall, I really enjoyed my QCon experience and it's definitely on my radar for a conference to attend again in the future**.  However, most of the things I disliked about the conference were related to its physical location and venue, which makes me wonder if it's worth the (very high) price tag since the best part (the recorded sessions) are eventually made available on the internet.