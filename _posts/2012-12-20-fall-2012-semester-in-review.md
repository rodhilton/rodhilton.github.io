---
layout: post
title: Fall 2012 Semester in Review
category: Life
tags:
- class
- school
- semester
status: publish
type: post
published: true
---
My third semester in the PhD program is over, and it has unquestionably been my hardest yet.  I bit off way more than I could chew, this semester was extremely unpleasant and, for the first time since going back to school, I was glad for the semester to end.

I took two 7000-level PhD courses at once (previously I had only done one in a semester) which was part of the problem.  Originally I was planning on doing three, but quickly decided that was insane and dropped one of the classes, which I'll now be taking in the Spring.  One of these two remaining classes was material I had never been exposed to at all, and it also happened to be structured in a way that would have made it exceptionally difficult even if I had, while the other was material to which I had minimal exposure.  I also took two courses on Coursera during this period of time, both of which I took quite seriously, as though they were credit courses.  And if all of that wasn't crazy enough, I managed to once again get roped into grading.

# Campus Classes

## Artificial Intelligence

Textbook: [Artificial Intelligence, 2nd ed.](http://www.amazon.com/Artificial-Intelligence-Pb-E-Rich/dp/0071008942/ref=sr_1_1?ie=UTF8&qid=1355376492&sr=8-1)

I had never taken an A.I. class as an undergrad, and I always regretted it.  I felt like I should at least be see what it's about, and I was always really interested in things like evolutionary algorithms, genetic algorithms, and other metaheuristics.  This class was taught by a professor I hadn't yet had, so this was a real gamble for me.

**I actually wound up intensely disliking the class.**  Not the material, which I found mostly very interesting, but the actual class itself.  Rather than having a challenging homework due every two weeks like my other classes had been, this class had one homework due each week, on Monday.  Since I work full-time, this meant that every single weekend during the semester was spent working on homework, I never had a full weekend to relax or catch up on anything else.  This had a pretty serious impact on my home life and I really grew to dislike it.

It wasn't just the number of homeworks that was the issue, but the nature of them.  The homeworks often asked us to solve very easy problems whose solutions were incredibly time-consuming to write out, and to make matters worse they often asked us to solve nearly identical problems in the exact same way over and over. It never tested my knowledge any differently to do the same problem twice in exactly the same way, but it was incredibly time-consuming to do these problems by hand.  **Homeworks often took 10-14 hours to complete**, and like I said I could only work on them during the weekends, so my entire weekend was consumed by homework, every weekend, for 12 weeks.  What infuriated me was that these homeworks didn't take time because I didn't understand the material, the amount of effort required was almost completely disconnected from my grasp of the topic.

{% image Artificial.intelligence-229x300.jpg align="right" %}

My lack of weekends also led to me falling behind in my other classes, it felt like I was struggling to keep my head above water all semester long.  This semester felt the most like my undergrad days, pulling all-nighters to complete assignments just before they were due, doing the bare minimum on an assignment just to get it checked off my list and move on to the next one, and always feeling stressed.

Worst of all, this class, which I took as an elective for fun just to see what it would be like, was a constant time distraction, pulling my attention away from my Computational Complexity class, which I had been looking forward to since going back to school.  Another PhD student who has taken a lot of classes with me actually wound up dropping Artificial Intelligence and entering an Independent Study because he felt that A.I.'s disproportionate amount of busywork was distracting him from narrowing down his research area, and would ultimately delay him completing the program.  He did this after the add/drop date, paying for the class and taking a withdrawal; that's how much of a timesink this class was.  As the class went on, I began to realize just how wise a decision this was.

I actually liked the classroom environment quite a lot - the professor tried to run the class very socratically, and almost nothing was taught without having a student come to the board and work through a problem with the entire class helping.  I thought this was a really great way to teach, and the professor clearly had a passion for the subject.  Class was very lively and engaging, which I enjoyed.  **It was unfortunate that the intense workload distracted me so much from the passionate professor, strong lectures, and engaging material.**

Ultimately, the workload is what dragged this class down to me, wasting its potential as a great class and transforming it into the only class I've taken that I didn't like.   It's one thing if the work takes me a long time because I'm struggling to understand the material, but when I understand the material and it takes me 10 hours to write it all up anyway, something is amiss.  I'd have preferred to have half the number of homeworks, and have them be more challenging than what we got.  In fact, I'd have preferred to have some projects, given that I wound up writing a lot of code to generate solutions for me to save time.

There actually WAS a project for the class, but it was extra credit.  This project was assigned halfway through the semester (to help students pull their grades up from the midterm), but the lectures that explained the concepts needed to do the project weren't until the final week of class.  Given how much I was drowning in work just keeping up with his class, I decided not to pursue the project at all and just focus on doing well on the final.  After my final, my professor e-mailed me to let me know I had a B in the class, but I could pull it up to an A if I did this project, which was due in 2 days.

I've had straight-A's for every other class, and I can't imagine a course being more challenging than A.I.  I realized that one day I'd look back at my transcript and see all A's and one B, **a B that I had an opportunity to pull up to an A but I didn't bother because I was lazy and wanted to be done with the semester.**  I decided laziness wasn't a good enough reason to accept the B, so with only two days to do the entire half-semester project, I decided to give it a shot.  It actually wound up being incredibly fun, largely because I made it fun by doing it in Scala.  You can check out the project **[here](https://github.com/rodhilton/trajectories)** if you want.

In the end, I managed to complete the project by staying up until about 2am a few nights, and I wound up with the A in the class.

## Computational Complexity

Textbooks: [Automata, Computability, and Complexity](http://www.amazon.com/Automata-Computability-Complexity-Theory-Applications/dp/0132288060) and [Computational Complexity](http://www.amazon.com/Computational-Complexity-Christos-H-Papadimitriou/dp/0201530821)

The existence of an entire course devoted to Computational Complexity was one of the main reasons I picked UCD over other schools.  Taught by a professor I really enjoyed for Theory of Automata, I figured this class was likely to be my favorite class of all time.  Unfortunately, it wound up being a bit of a disappointment.

As an experiment, the class was, for the first time, taught as a "hybrid" class.  Rather than the traditional classroom setting it had always been, it was taught mostly online.  Once my professor saw that only 3 people wanted to take the class at the 7000-level and everyone else was taking it at 5000-level, it was split further, and the format it wound up taking was that the three of us met in-person once per week and discussed various issues within Complexity.

{% image chp_venn_diagram-300x270.jpg align="left" caption="Complexity Classes, from Math $$\cap$$ Programming" %}

The main issue was that, **by only meeting once a week, we simply we unable to cover a great breadth of material.**  Computational Complexity is a huge subject, there are [495 classes in the Complexity Zoo](http://complexityzoo.uwaterloo.ca/Complexity_Zoo), and the infrequent meetings meant that only a tiny fraction of the topic wound up being covered.  We walked through some of the more difficult, classic papers in theoretical computer science, which was a lot of fun, but fully dissecting a single paper would often take 2 classes, a huge fraction of the available classtime when only meeting once a week.

For my semester project, I did [a literature review and covered 27 complexity classes from the Zoo]({% post_url 2012-12-15-a-stroll-through-the-complexity-zoo %}) that we didn't have time to even mention in class.  Due to the A.I. class, I had much less time to devote to this project than I would have liked, but I still wound up doing a lot of research.  I absolutely loved this project, and discovered a whole bunch of complexity classes I had never heard of before as an undergraduate.  I found the material just as exciting as I expected to, but the sad truth is that I was able to spend much, much less time on this fascinating subject than I wanted to.

There was also a wide disparity between the 3 students.  One of the students had actually taken a different version of the same class in another semester, and another was an upper-level PhD student working on his dissertation that was taking the "class" as an Independent Study.  Both of these students had a much greater grasp of this material than I did, so I often felt like the class moved too quickly for me, and I got lost frequently.  I was reluctant to ask questions because I knew I was the only person in the room who didn't understand things, so I had to do a lot of reading on my own time to keep up.  Of course, I had almost no time to do this kind of reading, so I think there's a lot of stuff that went over my head and stayed there.

Overall, I really enjoyed this class and both of the textbooks we used, but it was also one of my biggest disappointments because I felt like I was only getting half a class.  I would have loved for us to have met twice a week (hell, I'd have loved thrice per week), but I'm glad I took the class and I learned more in the couple weeks of independent research than I have in any other class I've taken.  I wound up ordering physical copies of a number of complexity textbooks because I found the topic so interesting, and I'm eyeing the sub-field closely for potential research topics.

The class was pretty informal, with the only graded components being a presentation we did halfway through the semester, another presentation at the end, and the final term paper.  I wound up with an A in the class.

## Grading: Fundamentals of Computing

I swore off grading last time I did it, with an overabundance of cheating ruining the experience for me.  But after the same class I graded before saw a 100% increase in enrollment, the chair of the department personally asked me if I could help her out by grading it again, along with a second grader.  As much as I didn't want to, I couldn't turn down the chair, so I reluctantly agreed.

{% image grading-rubric.jpg align="right" %}

I only graded the odd homeworks, with the other grader doing the evens.  A grading session took much longer than it did last time I did it, but they were infrequent enough that it wasn't too much of a problem.  It certainly did feel like I never had the time to grade, but I managed to sneak in the time whenever I was too tired to do A.I. work.

Classes started off badly, with more students cheating on the first assignment I was grading.  I once again caught them and called them out and then, to my great surprise, the cheating stopped (or they got much better at hiding it).  Grading was much better this time, the only downside being that **it cut into time I simply didn't have.**

One tip I got a while ago from a blog post or article about getting a PhD is to remember that your goal is to get the PhD, and that anything you spend your time doing that doesn't bring you closer to that goal is inherently taking you further away from it, since your time is limited.  Grading definitely falls into that category, and I particularly felt the drain on my time since I was barely surviving anyway.

I intend to avoid grading in the future as much as possible, though it's hard to turn down a professor or department chair when personally asked by them.

# Online Classes

## Functional Programming Principles in Scala

I, along with something like 10,000 other students, took Functional Programming Principles in Scala taught by Martin Odersky online on Coursera.org.  I had registered for Coursera courses before, but largely treated them as "bonus material."  I'd check out video lectures every so often, glance at assignments, and so forth.  I thought taking a Functional Programming course would help me both academically as well as professionally, since we use Scala exclusively at work.

{% image scala.png align="left" %}

I took this course very seriously.  I carved out time to watch every video lecture, and I treated the homework assignments like real assignments.  I really enjoyed the format of the class, with an autograder running secret tests against my code.  The code had a couple clever tricks to make "???" compile but not work, so you could leave functions unimplemented and submit what you had to see if you were on the right track.  A co-worker would typically do the entire assignment and submit once, but I tended to write a little, submit, write a little, submit, over and over again.  I typically wound up with 10-20 submissions per assignment.

I thought the course started out better than it finished.  When the course first started, it really felt like a class on Functional Programming itself, which simply happened to use Scala as the language.  **Later in the course, it began to feel like a Scala course, with more of a focus on Scala's idioms and syntax.**  I still enjoyed these sections, but definitely less so.  Another thing that irked me was when Odersky dropped the hammer on posting and sharing code solutions to the homeworks.  My co-workers and I would always share our solutions after the deadlines had passed, and I wound up learning a ton from seeing how others implemented the same things as me.  I understand why they had to crack down on "cheating" but I think the restrictions were a bit overly strict.

Odersky teaches a followup to the course at EPFDL, and I'd love to see that course offered online as well.  I'd like to see more focus on FP in general with less time devoted to the particulars of Scala, but I definitely got a lot of out the course as it was.  In fact, I wound up using a very similar style to the course to implement the A.I. project described above, and it worked incredibly well.

I got 100% in the class, I was never willing to walk away from an assignment without getting full credit on it, even when I was pulling my hair out with suboptimal trees in the Huffman Codes assignment.

## Writing in The Sciences

I also took Kristin Sainani's Writing in the Sciences course on Coursera.  This is the online version of a class Sainani teaches at Stanford University.  Since I'm doing a PhD, I know I'll be doing a lot of writing, and I wanted to improve my writing skills.  I also recently read the very similarly-themed [Writing for Computer Science](http://www.amazon.com/Writing-Computer-Science-Justin-Zobel/dp/1852338024/ref=sr_1_1?ie=UTF8&qid=1356058376&sr=8-1) by Justin Zobel, which I found enlightening.

I took this course pretty seriously, in that I actually watched all of the lectures and did all of the assignments, but I didn't give it the level of attention I gave the Scala class or either of my University classes.  The course simply wasn't technical enough to require my full attention and it was always my bottom priority, so I often listened to the lectures in headphones while at work, turning my attention to the video only when something visual was being presented.  One week, I played the lectures on my laptop while doing Scala homework on my desktop.  Now **that's** multitasking.

{% image writing.png align="right" %}

I struggled a bit with the grading of the class.  Since it wasn't code, no auto-grader could be used.  Instead, students simply submitted writing assignments and had 3 other students grade them.  Similarly, you had to grade the work of 3 other students.  The peer reviewers were tasked with making suggestion to improve the overall clarity of the writing, but generally they focused on word choice and minor paragraph tweaks.  Nobody ever turned a 4-paragraph rant into a sleek and slender 2-paragraphs, the tweaks were always much more minor.  By the final assignment, I was putting about the same level of effort in.

I was also shocked at the level of plagiarism.  One student submitted a paper that had a single sentence introducing a scientific peer, then a 4-paragraph quote by them, then another sentence thanking them for their contribution.  What the hell is that supposed to be?  I gave them a zero.

I got pretty good feedback on my writing, and I think I improved overall.  I definitely know some things to watch for when writing, but I also **think I got more out of Zobel's book, possibly because it was more focused on Computer Science** specifically than Sainani's class.

I wound up with a 91.8% in the class, just barely above the 90% required to be considered passing.  This was due almost entirely to my own lack of organization, getting due-dates of two assignments mixed up with all of my other due-dates and earning a couple zeroes as a result.

# Conclusions

This semester was incredibly rough.  On multiple occasions I asked myself just what the hell I was doing, and why I was subjecting myself to it.  Lots of self-doubt, wondering if I was cut-out for the program.  In the end, I pushed through it by thinking that if I can survive this semester, I can survive any of them.

Having finished the semester with my grades and sanity in tact and little more than a severely bruised social life and diminished level of happiness, I think I can probably survive the rest of the program, which is promising.  When I started this program, a goal of mine was to not let it impact my life noticeably; time I normally would spend watching TV or playing video games would be spent doing schoolwork, and otherwise my time would be the same.  While I succeeded in this goal every other semester, this semester I failed, being **completely unavailable for anything during any weekend, including for simple duties around the house**.  Lots of plans had to be cancelled or postponed, and juggling everything in my life was exhausting.

Next semester should be less intense.  I'm taking a class in the business school (it's a requirement) about how to do research.  I somewhat resent having to take a course that isn't really Computer Science, but it's the only non-CS requirement for the degree so I'm just going to have to do it.  Now that I have straight A's, I'm going to feel a lot of pressure in that class, I don't want my only non-CS class to drag my GPA down.

Due to credits transferring from my Master's program, that's actually all I need to be done with classwork.  But since I'll be enrolled anyway, I'm taking Graph Theory as well.  I don't technically need this course, but I find the topic extremely interesting and I've been looking forward to it since the professor who teaches it introduced some of the material in my Algorithms class.  This course is taught simultaneously at a Master's AND Bachelor's level, so I doubt it'd going to be a back-breaking workload, and I get along well with the professor.  

I have one more preliminary exam to take in February before I'm truly considered a PhD candidate, so that's my next big obstacle.  After the prelim and these two more courses, my coursework is finished and all non-research requirements will have been met.  Hopefully I'll have narrowed things down and I'll have a good idea of what I want my research area to be before the summer. **Ideally at the end of next semester I'll defend my proposal and be well on my way in research.**

I'm still glad I'm in the program, and I'm looking forward to continuing, but after this semester I'm definitely ready for a nice long break.

