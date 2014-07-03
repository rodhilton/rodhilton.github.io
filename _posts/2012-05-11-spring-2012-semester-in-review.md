---
layout: post
title: Spring 2012 Semester In Review
category: Life
tags:
- class
- school
status: publish
type: post
published: true
---

The second semester in my PhD program had me crank up the difficulty level a bit.  Since I got A's in both of my classes in the Fall, I figured I could extend myself and take on a bigger challenge: taking my first 7000-level course.

5000-level classes are Master's classes, 7000-level classes are PhD classes.  PhD students need to take 6 Master's classes and 4 PhD classes (plus 30 credit hours of research), and ideally 3 of those 6 Master's classes will be transferred for me.  Basically, I had to get my ass in gear and take a PhD-level class.

I still stuck with 2 classes per semester, though next semester I'm registered for 3 PhD-level classes, which is probably stupid and may change.

# Classes

## Theory of Automata

Textbook: [Essentials of Theoretical Computer Science](http://www.cs.uky.edu/~lewis/texts/theory/title.pdf")

When I was an undergrad, I hated theory.  It was just too far removed from actual computers, I slacked off in all of my theory classes, and I refused to even open the textbook.  It was my years-later decision to look at that book again that sparked my interest in returning to school, so this class was a make-or-break thing for me.  Theoretical Computer Science is what I came back to school to study, so if I hated this class or struggled with it, I would have dropped out at the end of the semester.

{% image turingMachine-300x205.gif align="right" %}

I'm not sure what it is exactly.  Maybe it's because I was in school by choice.  Maybe it was because I'm paying for it myself.  Maybe it was the professor, Tom Altman, and his lectures.  Maybe it was the book.  Whatever the reason, this class made me actually **get**  theoretical computer science.  Finite state machines, push-down automata, turing machines, undecidable problems, context-free languages, the halting problem, the pumping lemma, all of those things were phrases I remember from my undergrad days, but exclusively in the context of words that were bringing my grade down.  This semester, I got it - all of it.  I got 100% on the first test (which Professor Altman announced when handing them back, much to my embarassment) and quickly became the class "expert" on the material.

I was constantly IMed or e-mailed questions from classmates, and I found myself, to my amazement, consistently able to answer them.  I **LOVE** Theoretical Computer Science, and I loved the textbook and the class.  I looked forward to it every week, the only negative being that often my classmate's inability to understand the material would annoy the professor visibly, which made me feel kind of awkward.

The book was excellent.  Every other Theory book I've looked at (a lot of them these days) first covers Finite Automata, then Pushdown Automata, then Linear-Bounded Automata, and finally Turing Machines.  Each time more power is added to the machine, with something like the Halting Problem being discussed pretty late (since it has so much to do with Turing Machines).  This book flips it, IMMEDIATELY covering Turing Machines, the Halting Problem, computability, and decidability.  Afterwards, it takes a more standard order, FSA, PDA, and LBA (but then Grammars at the very end).  At first I thought this order would be terrible, but I was completely wrong.  Covering Turing Machines first frames the discussion about other types of machines in a completely new way, and I think it really works well.  I'd suggest anyone teaching a Theory class, even an undergrad one, consider using this textbook, or at least this order.

All in all, I loved this class.  The unit on Complexity was removed from this class (we skipped the chapter in the book) and instead moved to its own course next semester, which I'm really looking forward to.  I'm certain I got the highest grade in the class, and I really felt like I mastered the material (aside from a question on the final that I bombed).  A great experience overall.

## Graduate Computer Security

Textbook: [Introduction to Cryptography with Coding Theory](http://www.amazon.com/Introduction-Cryptography-Coding-Theory-Edition/dp/0131862391")

Don't let the name fool you, this class had very little to do with the concept of Security and everything to do with Cryptography.  It's taught by a professor who transitioned into a PhD in Computer Science after getting her PhD in Mathematics.  It was a very math-heavy course on cryptography.

To be honest, I wasn't really looking forward to this course.  I took a Cryptography course as an undergrad and, though I enjoyed it, I didn't really connect with the material.  I found a lot of the more complex math difficult because I couldn't develop intuitions for it, and I wasn't exactly looking to repeat the experience.

{% image Computer-Network-Security-300x225.jpg align="left" %}

However, knowing that I needed to take 4 7000-level classes with only 2 that really got me excited, I decided Computer Security was probably the way to go.  The class skipped over classical ciphers and focused primarily on AES, DES, RSA, Quantum Cryptography, Secret Sharing, Group Theory, and Elliptic Curve cryptography.  About half of the class was material I remembered (and struggled with) from undergrad, and the rest was brand new.

I definitely understood things better this time around, but I also struggled quite a bit with some of the math, particularly with Elliptic Curve cryptography and a lot of the Group Theory stuff.  I don't really feel like I mastered the material, which is a bummer, but I did well enough and earned an A in the class.  The A was due largely to the fact that the grades were based on homeworks and a project, with no exams.  Homeworks meant no time limit, so I could spend hours and hours on homeworks that should have taken someone else less time, and I picked a project topic with less intense math, so I was able to understand it.

My project was actually a lot of fun.  Based on a project one of my friends did in undergrad, I decided to research and implement [an attack on substitution ciphers using Genetic Algorithms](/files/RodHilton-CSCI7002-Cryptanalysis-Against-Monosub-Ciphers.pdf"). A cool [open source project](https://github.com/rodhilton/Geneticrypt") fell out of this as well.

Overall, I enjoyed the course far, far more than I was expecting too, but I'm disappointed in myself for not feeling like I grasped the material better.  I'm glad there were no time-limited exams, or I'd have probably gotten the B I probably deserved.  I hope that my struggle was due to the subject, and not due to the level of the class, because if the latter than I'm in store for a painful semester taking three 7000-level classes.

# Cheating

One thing that cast a shadow over the semester was my sudden inability to ignore a problem that appears to be rampant at the school: **The University of Colorado at Denver has a major cheating problem.**  One of my classes last semester had a lot of cheating, and [the class I graded for did as well]({% post_url 2011-12-21-fall-2011-semester-in-review %}#toc-grading-fundamentals-of-computing).  I thought these may have been isolated, but I'm less able to convince myself of that after this past semester.

Like I said before, I wound up becoming something of the class "expert" in my theory class.  So before every exam, people would ask me questions.  One day, minutes before the second exam, a student asked me a really strange question I'd never heard before.  I thought about it a second and supplied her with a proof.  I asked her where this question came from and she said she saw it on the internet.  When the exams were handed out, I was stunned to see that Question #4 was this exact question, word for word.  Could it have been a weird coincidence or a lucky guess?

{% image Cheating-Photo_1-300x190.jpg align="right" %}

The day before the third and final exam for the class, I was suddenly inundated with emails from other students asking me questions.  What was weird was, 10 different people had the exact same question for me.  I asked one of them where it came from and she said she saw it on the internet.  I asked for a link, and she sent me one.  I read over the link and replied "this link doesn't have the question you asked, where did you find that question?"  After putting some more pressure on her and making it clear I wasn't going to answer it unless she told me where she heard it, the truth came out.  A small group of students had the last 4 years worth of exams and were trading them around.  This particular question appeared on two of the exams, and they didn't know how to answer it.

Some might say that simply knowing previous exam questions isn't really cheating, but if it's not something they'd be comfortable with the professor knowing, I say it falls squarely in the camp of cheating.  Additionally, the students who weren't "in the know" didn't get the advantage - either everyone should have previous exams to study from or nobody should, otherwise it's unfair to the students who are working their butts off honestly to learn the stuff.

I also found out that a number of students in my Computer Security class got zeroes for plagiarizing homework, and even a few zeroes for plagiarizing their project proposals.  How do you even do that?  After talking to some other students about this, everyone has similar experiences.  It appears to just be a widespread thing everyone has come to accept.

I really don't understand why the school doesn't just kick these people out.  They have an academic honesty policy which clearly states that's what happens if you cheat, but it's a complete joke.  I have seen cheating take place over and over again, and when it gets called out, it results in zeroes for a single assignment.  Not even an F for the class - they can still get B's or C's.  It devalues my degree for the institution granting it to also grant one to people who don't learn the material, and I really wish the school would crack down on the cheating.  

# Summer and Next Semester

This summer there are no graduate courses being offered that I'm interested in, so I'm taking the summer off.  It's going to be weird not taking any classes for so long, I hope I don't have trouble re-adjusting in the Fall.  I do plan on sitting in on an undergrad A.I. class, but I have a pretty busy schedule this summer and I'm going to probably miss half the lectures.

In the Fall, I'll be taking 3 PhD-level classes: Graduate A.I., Computational Complexity, and some Information Systems cross-department requirement that I don't care about and deeply resent having to take.  Computational Complexity is the course that made me pick UCD over every other school, so I'm incredibly excited about that one.

I've been back in school for one year now, and so far I'm loving it.  I wasn't sure if I'd enjoy it, or even if I was cut out for it, but my level of excitement and my grades tell me both are the case.  I'm so glad I decided to go back to school, I wish I had done it sooner.

