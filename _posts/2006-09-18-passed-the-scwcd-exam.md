---
layout: post
title: Passed The SCWCD Exam!
category: Programming
tags:
- internet
- java
status: publish
type: post
published: true
---

I've been studying for a while for the Sun Certified Web Component Developer exam, and I just finished the test a little ago with a passing score (a pretty good one, too).

This exam was very interesting for me.  I decided after I completed my Sun Certified Java Programmer certification that the next one I wanted to tackle was the web cert.  It was different, though, because I had been programming in Java for some time before taking the JP exam, whereas I had never written a Servlet or JSP file in my life when I decided to pursue the SCWCD path.

The reason I decided to study for an exam rather than simply read a book on the material was quite simple: it forces me to learn EVERYTHING about the topic.  Generally when I learn something new, I learn by example and experimentation.  This makes me a quick and eager learner, but the end result is what I call "swiss cheese knowledge."  I know a lot, but there are gaping holes in my understanding of the topic, and usually I don't even know they exist.  Before I took the SCJP exam, I thought I was a Java guru.  Only by studying the material and practicing for the exam did I come to see the many gaps in my knowledge.  The process both alerted me to the existence of the gaps, as well as filled them in.  The SCJP exam was very valuable for me.  Not just because it makes my resume looks nice, or because Sun sent me a snazzy lapel pin, but because the process involved in preparing for the exam made me a far, far greater Java developer.  The test itself isn't all that important for the process, other than to tell me that I correctly filled in most of the gaps.

Thus, when I realized I wanted to learn about Servlet and JSP technolgy, I decided that the best way to learn the material deeply was by preparing for the SCWCD exam.

The first book I bought was "[Head First Servlets and JSP](http://www.amazon.com/Head-First-Servlets-JSP-Component/dp/0596005407/")".  I liked the Head First Design Patterns book a great deal, and the HFSJ book was written by people who prepared the exam.  I found, unfortunately, that the book did not make me feel like I was coming to a complete and thorough understanding of the material.  I understood what I read, but I still felt like I had gaping holes.  It's hard to explain exactly what made me feel this way, but something about the structure of the book seemed so loose that it felt like I was getting information from all sorts of angles, and I was missing spots.

I decided that I needed a book that gave me excersizes.  I'm not very good at memorizing things (in fact, I'm terrible at it) so I have to actually LEARN the stuff.  Learning means doing, rather than merely reading.  I purchased the [SCWCD Study Guide by David Bridgewater](http://www.amazon.com/Certified-Component-Developer-310-081-Oracle/dp/0072258810/sr=8-1/qid=1158623201").  This book had an excersize for every single objective, which gave me a great hands-on experience with each objective, as well as a small petri dish to experiment with for each objective ("Will it break if I do.. this? Oh, yeah it will.").  

Both of these books had problems for me.  The Head First book was good for something nebulous and conceptual such as Design Patterns, but it was awful at teaching me something as formal as J2EE Specifications (ultimately what the tests are on).  The Bridgewater book was much better in this regard, but it suffered from one problem that was unforgivable: typos.

The book was riddled with typographical errors.  And I don't mean simple things, like turning "the" into "teh".  I mean typos that would wind up saying things that were incorrect, and I'd be tested on.

For example, there was a section that had a few code snippets showing how to provide run time expressions as values for attributes in tags.  The snippets showed using the expressions without surrounding quotes. There were two in a row, and it was in the section introducing using run-time expressions for values.  This left me with the impresson that run-time expressions didn't have to be quoted as values for attributes.  It seemed wrong, though, so I checked it out and discovered that they DO need the quotes.  Had I not checked, I would have had incorrect beliefs about the topic.

Another example was far more confusing.  When writing classic custom tags, doStartTag() has to return a constant indicating to the web container what to do with the body.  You can return EVAL_BODY_INCLUDE or SKIP_BODY to either evaluate or skip the body of the tag, respectively (there are other possible values for other custom tag interfaces).  doEndTag() can return EVAL_PAGE or SKIP_PAGE, which is very straightforward.  The use of _INCLUDE on the end of EVAL_BODY_INCLUDE is somewhat confusing, since it doesn't preserve the parallel to the _PAGE constants.  Indeed, EVAL_BODY is totally and completely wrong.  Using it would prevent compilation from succeeding.  I saw questions on two different mock exams that used EVAL_BODY, expecting you to realize it wouldn't work.  One of these mock exams was actually in the Bridgewater book.  Yet in the chapter summary, he mentions EVAL_BODY as a possible return type.

These kinds of typos were peppered throughout every chapter, some of them extremely misleading and others less damaging.  I had to do a great deal of work to fix some false conclusions I came to as a result of these typos.  Yet it was still the best book I used to learn the material.

In the end, I wound up studying almost exclusively from the Bridgewater book, then filling in a few gaps with the Head First book.

In any case, I'm now a certified Web Component Developer.  I feel very confident writing Servlets and JSPs, and I feel like I have a very thorough and complete understanding of that copic.  I'm hoping to tackle the Web Services exam next, though that will be far more challenging since no study guide currently exists for it.  

