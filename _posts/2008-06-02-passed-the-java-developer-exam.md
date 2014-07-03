---
layout: post
title: Passed The Java Developer Exam!
category: Programming
tags:
- certification
- development
- java
status: publish
type: post
published: true
---

Since my current job switched everything off of Java to Ruby and Rails a while back, I was concerned that my Java skills may get rusty.  I had wanted to pursue another Sun Certification anyway, so I decided to take the [Sun Certified Java Developer](http://www.sun.com/training/certification/java/scjd.xml) exam.

This exam was very different from the other two exams I had taken, in that I did not need to study or answer any questions.  I did not have to go into a room and answer randomly chosen multiple choice questions.  Instead, I was given a document that called for an application to be written with specific functionality, and I had to then write that application and submit it for review.

The test consisted of two parts: the first was writing the application and submitting.  The second was taking an essay exam in which I had to explain my design choices.  The second half was largely to ensure I did not pay someone else to write my project for me.

The project definition itself was very odd.  It was essentially an application to manage hotel reservations.  All of the projects required some kind of networking component between client and server (I used RMI), and all of them forced you to deal with some locking and concurrency issues.

What was particularly strange about my project was the input data file the stored hotel information.  I'm not allowed to get into specifics, but essentially there were chunks of bytes that had to be converted into a short, followed by chunks that had to be converted into a long, followed by chunks that had to be converted into characters as part of a string, etc.  Then the interfaces for the project provided passed all data as String arrays.

It bothered me that a project that stressed object oriented programming concepts would pass string arrays instead of actual objects, so even though the project definition didn't say to do so, I wound up writing a whole layer for parsing in and out of the file format, then another layer on top of that that could work with the string data (coded to the provided interfaces), then yet another on top of that which converted the data into actual Objects to be used by my GUI.  I was concerned that I had over engineering the thing, but I guess I hadn't.

The project description was intentionally very vague.  A lot of guessing had to be done to figure out what was desired by the graders.  To this end, the [JavaRanch Big Moose Saloon](http://saloon.javaranch.com/cgi-bin/ubb/ultimatebb.cgi) was extremely helpful.  They have an entire forum devoted to the SCJD exam, which allows people to ask questions of each other for help in parsing the requirements of the document.

I had an interesting problem with the exam.  When I first got the project description, I was excited to code some Java, so I finished it in a week.  After submitting it, however, I had to separately sign up to take an essay exam, the purpose of which was proving I wrote the project.  Of course, I like writing code a helluva lot more than writing words, so I wound up procrastinating for months before taking the essay exam.  As a result, I had to review my own code prior to the exam, having forgotten nearly all of my own design choices.  Since the purpose of the exam was to make sure I was familiar with my own code, this was actually quite a challenge, especially since I had designed so many extra layers into the application.

All in all, I'd say the exam was worth doing.  It was significantly more expensive than the other exams, but it also proves that I can sling code.  I feel like I learned less from this exam than the others, since there was no actual studying required, but it was nice to write some Java code once again, which was the primary purpose.

