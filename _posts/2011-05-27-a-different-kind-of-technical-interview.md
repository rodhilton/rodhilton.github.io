---
layout: post
title: A Different Kind of Technical Interview
category: Programming
tags:
- career
- interview
- job
status: publish
type: post
published: true
---

Everyone who's been programming professionally for a while knows the standard format of the technical interview.  You go in, there's a whiteboard in the room, and you write code on it to answer questions.

Everyone also has the same basic complaints about these interviews.  In a normal work environment, you have access to an API or search engine, but at a whiteboard you don't.  Whiteboard questions generally don't include much in the way of overall design, and they're typically limited to simple algorithms, so they don't really test all of a candidate's skills.  And let's be honest, programmers tend to have awful handwriting, and writing vertically on a large board doesn't help things.

**We like coding.**  We like sitting at a computer.  We like running ideas by our coworkers and our compilers.  The whiteboard interview helps interviewers know a bit about candidates, but it doesn't help candidates learn anything about interviewers.  In short, the standard interview leaves a lot to be desired.

At my current company, we've tried to improve the technical interview by augmenting it with something else: **a pairing exercise**.

We haven't replaced any aspect of the interview, merely added to it.  The candidate goes through a typical phone screen, then a 1-hour in-person interview (whiteboard style) with two developers on the team.  Then the candidate comes down to the development area and sits at a pairing station with one developer, and they work on a task together.

I've been conducting a number of interviews in this style and this addition to the interview process has been great, so I wanted to detail a bit how it works and what kind of benefits it provides.

# How It Works

We have a remote git repo called 'pairing' which contains an IntelliJ project skeleton.  There are Java, Ruby, and JavaScript modules, which allows the interviewee to pick the language with which they feel most comfortable (of the languages we use regularly).

Each module has a basic project structure.  The Java module, for example, has a maven pom.xml file and your typical "main" and "test" directories.  The pom file also includes a number of common libraries so that interviewees don't have to fight against the language.  A lot of commons-lang is included, as well as [Google Guava](http://code.google.com/p/guava-libraries/), [JUnit](http://www.junit.org/), [TestNG](http://testng.org/doc/index.html), [Mockito](http://testng.org/doc/index.html), and many more regularly-used libraries.

Each module also contains a `README.txt` file, which contains a few possible exercises.  Our Java module has five exercises.  The candidate reads over the list, then picks whichever one sounds most interesting to them.  All of the exercises are meant to consume approximately two hours of pair-programming, so they're all about the same level of difficulty.  Together, they cover a wide variety of the kinds of problems programmers solve; some use a lot of `String`s and text manipulation, while others are purely mathematical in nature.  

As an example, one of our questions is to write a program that can analyze a poker hand and determine it's best rank (Straight, Full House, Pair, etc).  Initially, this question was to take two poker hands and determine the winner, but we decided that this made the question quite a bit more difficult than the other 4 possible questions, and simplified it to make it more in line with the others.

{% image pairing2-300x227.jpg align="right" caption="At a pairing station (the monitors are mirrored)" %}

I explain to the candidate (and this is important) that they are **not expected to finish the task**. "The goal is not to complete the task, the goal is for us both to get a feel for how the other likes to work."  A lot of candidates still try to finish the task as quickly as they can, and when I detect them doing this I start asking thought-provoking questions about the code in order to slow them down.  Once a candidate realizes he or she no longer has any chance at completing the exercise, they slow down and stop rushing.

After the candidate has written a bit of code, I ask them how they plan on checking that their code is correct.  Some like to run their code regularly, some will write a `public static void main` and verify their functions do the right things, and some will want to actually write unit tests.  Whatever their answer, I suggest we go ahead and do that to make sure what we've got is right so far.  This is usually a good idea because the worst thing that can happen during the exercise is that they don't run it until the interview is nearly over, only to discover it contains a number of bugs, and there is too much code to debug it in the remaining time.  If the candidate likes to write tests, I'll start [ping-pong pairing](http://en.wikipedia.org/wiki/Pair_programming#Ping_pong_pair_programming) with him or her.

A lot of times candidates will ask questions.  "What should we do if the input is invalid?" and similar questions.  I usually just turn the question back around and ask what they'd like to do.  There aren't really any wrong answers during the exercise.  Sometimes they will ask for permission to Google something or check documentation, like it's cheating or something.  I tell them there are no limitations on what resources are available to them, and I reiterate that **they should approach the task like anything else they do at work**.

In the last 20 minutes or so of the exercise, I like to stop the programming and start talking about the code.  Why did the candidate make a particular design decision over another, are there other things he or she would like to do, etc.  I also tend to ask "if we were to do a code review on this with everyone else in the engineering area, are there any things you'd like to do with the code before turning it over for review?"  Usually two hours isn't enough time for candidates to refactor their code as much as they'd like, so I'd like to hear where they'd take it if they had the time.

After they leave, of course, this is exactly what I do.  A number of other developers review their code with me, ask me questions about it, and we discuss style, decisions, and the like. 

# Why It's Good

This feedback from this experience has been wildly positive.  First and foremost, candidates seem to absolutely love it.  Developers are **much** more comfortable writing code at an actual computer than they are fumbling with whiteboard markers in a quiet room, and they tend to be much more relaxed than during a traditional interview (which surprised me a bit at first).  Every candidate we've done this with has said they loved it, and that all interviews should be done this way.  Furthermore, the interview isn't one-sided anymore: the candidate gets a sense for how the interviewer likes to work as well, so both sides can gauge compatibility.

Another nice thing about this approach is that interviewers can get a sense for a candidates softer skills better than in a normal interview.  How well do they communicate, what's their process for thinking through an idea with a co-worker?  Are they fun to work with and personable?  Do they joke around?  I've walked away from these coding exercises with a much better sense for the answers to these questions than I ever have from a traditional interview.

Most importantly, you're actually interviewing someone in the kind of environment that they really work day-to-day.  **Whiteboard interviews really only test how well a candidate does when doing whiteboard interviews**, because developers don't generally code on whiteboards.  They use their compiler or interpreter, they use tests, they use Google.  These tools are all available during a pairing exercise, but denied during a whiteboard interview.  Testing a developer in his or her natural habitat seems like a **vastly** more effective means of judging them.

Because the interview is two hours long and focused on a single task, there are opportunities to learn how candidates approach the design of their code in a way that's far less artificial than the "[show me the object model for a chicken]({% post_url 2010-04-06-avoiding-the-big-design-interview-question %})" style of design question.  You can get a sense for someone's design skills without asking them to draw UML, which is good since it's very unlikely they'd ever draw UML in real life.

It's important to do this exercise in the main development area, not in a side room specifically set up for pairing exercises.  The candidate gets to see the area where he or she would be working, and it helps gauge cultural fit.  If you work in a loud, informal area where developers are playing music and making jokes all the time, the candidate gets to experience that, and the interviewer gets to see how they handle it.  

It's also important that this doesn't **feel** like an interview.  It should not consist of the candidate writing all of the code while the interviewer grills them on their decisions.  That's not how pair programming works in real life, so that's not how it should be during a pairing exercise.  The interviewer should be writing some code as well to make sure things feel equal and the candidate stays comfortable (though it's natural to shift the problem-solving burden a bit more in the candidate's direction than one would with a coworker).

Based on how much candidates and interviewers both seem to enjoy this, I hardly see any reason to do a whiteboard interview at all anymore.  Personally, I don't even look a resume before I do a pairing exercise with a candidate.  I don't feel the need to know anything about someone going into it, and I feel like I learn all I need to spending two hours with them on a task.

If you're having trouble hiring good programmers, give it a shot.  Replace part of your interview process with a pairing exercise and see if it makes a difference.

