---
layout: post
title: Diving Into Android
category: Programming
tags:
- android
- exercise
- health
- mobile
- phone
- skills
status: publish
type: post
published: true
---
I've finally written my [first real Android app](https://play.google.com/store/apps/developer?id=Absolutely%20No%20Machete%20Juggling&hl=en").  I dabbled a bit with Android development in the very early days, writing [an app that interacted with the web services](https://code.google.com/p/rallydroid/") of the company I was working for at the time.  This app was ugly, written for Froyo, and frankly barely worked at all.  It was a 20% time project at my then-employer, but I never went back and worked on it after the initial effort, and never even bothered getting it packaged into the Android Market, largely out of embarrassment.

I've been wanting to get into Android development more seriously since that effort, because I overall liked the idea, and as a big Android user myself, I felt that it was essential _I be able to develop applications for my own device_, as being unable to do so was a lot like using Linux without the ability to write shell scripts.

I've taken two all-day training sessions on Android before as part of larger development conferences, and while I was able to suss out some basics about the lifecycle and other Android fundamentals from them, neither left me with any sense of real understanding of how I could develop something for Android that people might actually use.  But at [OSCON 2013]({% post_url 2013-07-30-oscon-2013-a-review %}), I took an excellent half-day Android class taught by [Marko Garenta](https://twitter.com/markog").  Among other things, he showed me, for the first time, how to write a modern-looking Holo app, how to use asynchronous background tasks, how to transition between multiple activities, and how to handle fragmentation issues.  These were never touched on in my all-day sessions, and they're all large barriers to writing real applications.

Once I left the class I had a sense that I actually now knew enough that, with some help from web searches, I could actually write an Android app.  I just needed a good idea, so **I tried to take notice of various itches in my life to see if I could scratch any with a phone app**.


# The Concept

After only a couple weeks, I found it.  I use various tools to track my gym workouts, but each one is vastly overcomplicated, attempting to be the "one fitness app to rule them all", so I wind up using about 5% of many different apps to track my health.  This generally means navigating past features I don't care about or working around features I dislike.  For example, when I go weightlifting all I want is to be able to track how much I lifted last time so I can increase it.  I generally do sets until failure, so one workout might have 5 sets, but then after I increase the weight I might only be able to do 3.  The program I use to track this, [JEFIT Pro](https://play.google.com/store/apps/details?id=je.fit.pro&hl=en"), demands I create workout routines consisting of certain exercises, then set each exercise to have a certain number of sets; it's all very rigid, and I find myself fighting with the app constantly to get out of my way and just let me track my workouts.

So this became my itch.  I wanted to write a very simple app that would:

 1. Let me add my own exercises to a list (JEFIT has its own predefined, and there are about fifty billion to scroll through)
 2. Easily let me log sets with a weight and a number of reps
 3. Save those logs to a simple-to-read JSON file stored on my SD card
 4. When I pull up an exercise, go through these logs to show me previous records for the exercise, so I can ensure I'm increasing my weight
 5. Be a rest timer, counting down and alerting me when a rest is over after logging a set
 6. Work well in airplane mode (I usually use this at the gym to avoid getting phone calls and texts)

{% image Screenshot_2013-08-25-15-10-59-168x300.png align="right" %}

In other words, **a clipboard, piece of paper, pencil, and stopwatch, but on a phone**.  I didn't want it to have any more features than this, because I felt that would risk it being another app that just gets in my way and tries to dictate how I should work out.  In fact, I specifically insisted that this app not even need internet permission, instead writing all log data out to the SD card for the user to sync however they please (I'm using [Dropsync](https://play.google.com/store/apps/details?id=com.ttxapps.dropsync&hl=en")).

I came up with a name as simple as the idea: **Simple Strength Log**.  I also decided that, should the experience be a positive one, I could go on to write similar apps to track fitness and write to simple JSON files, like Simple Cardio Log, Simple Food Log, Simple Water Log, Simple Weight Log, etc.  I like collecting data.


# Development

Development of the app took me about one week.  I expected this to be a month-long project as I sputtered my way along unfamiliar territory, but honestly it wasn't too bad.  With what I learned from the OSCON session, I was able to get some basic functionality working pretty quickly, and any time I had a question on how to do something, **99.9% of the time there was a StackOverflow post addressing it**.  Basically I started development after work on a Friday, spent every waking hour of my weekend working on it, worked after hours (and sometimes during lunch) during the week, and had it done by the next Friday.  I took one more weekend with it before releasing, since a change I wanted to make was going to fundamentally alter the file format I was using, and it was simpler to wait than to release it and deal with parsing the legacy format.

I used Eclipse for development, despite being an IntelliJ user, because we used Eclipse for the OSCON session and I wanted to hit the ground running.  **I hated using Eclipse**, it's even more clunky and annoying than I remember.  Obviously the keyboard shortcuts were unfamiliar, but honestly I find it to be a less capable IDE overall, and I found some of its quirks maddening.  One thing that happened constantly was I'd copy some code with Command-C, delete it, go somewhere to paste it, and it would paste the thing that was in my buffer previously, with the copy having been ignored.  I'd have to then undo the deletion, re-copy, re-delete, and re-paste.  And before you say I probably wasn't hitting Command-C correctly or something, bear in mind that I use the clipboard like this in every application I use, including IntelliJ, and this only happens in Eclipse.  The Android tools themselves were great, particularly the wizard for creating Android XML files with different constraints, and the UI/Layout editor.  Hopefully I know enough now about Android that I can confidently use the new IntelliJ environment.

{% image Screen-Shot-2013-08-30-at-4.07.48-PM-580x423.png %}

Overall, development went very smoothly.  I felt like there was an enormous mountain to climb in terms of my lack of knowledge, but that the learning curve wasn't steep at all.  Most development felt very natural, often the way to do something was the way I'd expect to, so the principle of least surprise was satisfied.  **I generally found that, if you were meant to do something, the Android API made it dirt simple to do, and if you weren't, a StackOverflow post told you how**.

Being able to write in Java definitely smoothed the process.  Being very familiar with Java and its conventions helped me move briskly through the development, I never had to think about language questions at all, focusing entirely on Android questions.  One thing that was tough was, I'm used to doing JVM development in languages like Scala or Groovy, and when I've done Java in recent years I've done so with the help of Java libraries that made it much easier to work with, like [Apache Commons](http://commons.apache.org/proper/commons-lang/") and [Guava](https://code.google.com/p/guava-libraries/").  But each jar file I downloaded increased the size of my tiny little .apk file substantially, so I often hand-rolled methods that I normally don't have to write.  I wound up only including a library if I used a number of functions from it, and managed to keep my binary (just barely) under 1 MB.

The two biggest challenges were, by far, layout and managing state.  Layout was the easier of the two, largely because of the quality of the Eclipse tools.  Managing state was very tricky however, in that you basically have instance fields in your activities, but can't trust that they have the values you think.  Assignment to and from these fields needs to happen through various lifecycle methods and, while there are diagrams that illustrate the flow, it's sometimes difficult to know which lifecycle methods get called when, and it's tricky to trace through these steps to ensure that data is where you expect it to be.  For example, if you call one activity from another, the lifecycle methods that get called on the parent differ depending on whether you return to it by hitting the "up" button on the action bar or hit the "back" button of your device.

{% image Screenshot_2013-08-30-12-50-37-168x300.png align="left" %}

Managing state was a particular challenge for this app, because I refused to store any persistent data inside of internal databases the way most apps do.  Instead, I wanted to read and write from a large collection of json files on the SD card, which means disk access on the slowest part of the phone, reading from a particularly slow-to-parse file format, and serializing/deserializing frequently.  In other words, **my persistence and unpersistence operations were particularly slow**, and I had to take a lot of extra precautions to avoid working with them in the main UI thread to avoid the dreaded "Force Close" popup.

Tracking down bugs due to my understanding of lifecycle methods and state management took the majority of my time developing.   Even now, my code is littered with an overabundance of null checks for extra safety.

The other big challenge was layout and UI.  Simple layouts were very easy, particularly with the tools, but **any time I wanted to be slightly complex or specific with my layout, it was a struggle**.  I love the ability to handle fragmentation and different screen sizes by making alternative xml layouts with the same component ids and specify "this layout is for landscape mode" or "this landscape is for large screens".  That's a cool feature and it makes things easy.  But any complex layout often wound up being a nightmare, with me being essentially forced to create lots of nested LinearLayouts with different weights.  The tool specifically warns me that this is bad for performance, but frankly it always works fine on my phone so I kind of ignored the warnings.  I really like the notion of defining behaviors in code and interface/strings/UI stuff in XML files, I held myself to preserving this separation even when I was having a tough time making something look right in XML.

Often the UI didn't work the way it seemed like it was supposed to.  For example, I wanted my ActionBar title to be a drop-down to select different filters for the exercise list (Favorites, Chest exercises, Leg exercises, etc).  When I implemented it the way the documentation indicated, it was impossible to properly set the text color to white, even though the title was white before (as specified by me in a style file) and the ActionBar background was dark.  I tried every manner of customization but was simply never able to find the magic incantation to make it work.  Additionally, the pop-up menu with the dropdown list was black on gray rather than white on black like the other pop-up menus.  Again, even with the help of StackOverflow, I was unable to figure out how to fix this, so **I wound up writing a whole bunch of custom components to make it work right, which was annoying**.

Another frustration I had was when I tried to create an AlertDialog with a NumberPicker inside.  No matter what I did, the Dialog background and NumberPicker foreground were both white, making it impossible to use.  I wound up completely re-designing my UI to work around this.  In the end, **I like what I wound up with quite a bit more than my original plan**, but it was frustrating that I was unable to do something that the documentation gave me all indications I should be able to do.

The Android SDK and related tools provide a way to run emulators of various devices for testing your apps, and I did this for a while but frankly found the whole process very slow.  In the end, _I wound up doing almost all development with my actual phone connected_.  This was faster, gave me a more accurate sense of how the app would work, and frankly I got a kick out of seeing something I wrote on my actual phone that I use every day.  As a bonus, my phone always had the last version I tested on it, so I was easily able to test my app at the gym to work out kinks (get it? WORK OUT kinks? har har har) well before releasing it.  I also had a tablet that I tested on, but never ran the emulator again after using my phone, so I have no idea if my app works like shit on other devices.

{% image Screenshot_2013-08-25-15-11-33-168x300.png align="right" %}

I dealt with the Android version fragmentation as poorly as I could have: **screw you if you have an old phone**.  I would write code using specific features of the Android API, and whenever ADT would warn me that I was using an API that was newer than my target API, I just bumped my target API.  What originally started as an app that would work on Froyo quickly became an app that would work on Honeycomb, as I found the hoop-jumping needed to work around not having an ActionBar simply not worth the hassle.  Shortly after, I wound up wanting to use some simple function that required Ice Cream Sandwich as the target.  This function would have been easy to write on my own, but it was even easier to just bump my target API again.  Not exactly the tactic I'd take if I were doing Android professionally, but good enough for something I'm doing in my spare time.  Hey, I made a setting to let people switch from Imperial to Metric units even though I live in the U.S., what more do you people want from me?

I wound up never writing a single test for my project, which is very much against my normal patterns of development.  I felt annoyed having to test and re-test my app my hand after making changes, but I found the unit testing stuff too difficult to set up, and my app too small to bother with.  I often wanted to just write simple unit tests against my <code>Util</code> class, but the only way to test a single class is apparently to set an entire Test Project version of the app, and it was all too convoluted to bother with.  Maybe next time.


# Publishing

Publishing the app to the store was pretty easy.  I had come under the false impression this involved getting certificates and other crazy crap, but it was much simpler than all that.  The documentation on the Android site was actually pretty confusing, but I eventually fumbled my way through creating a signed, zipaligned (that's important) apk and getting it into the Play Store.

Working with the Store is easy, updating your apps, changing the descriptions, **all of that is cake**.  The web UI built around managing your Android Developer Console is one of Google's best, definitely the easiest part of this whole process.

In the end, I had [an app in the Play Store](https://play.google.com/store/apps/details?id=com.nomachetejuggling.ssl&hl=en").  Just seeing my own app in this store, searchable on the web or in the app, was a trip.  It was like seeing yourself on television.  This isn't a place for me, it's a place for professionals, but there I am!  My app!  My wife got such a kick out of it that she installed it and put it on her home screen, despite not using the gym.

I released the app for free, and made the source available on GitHub [here](https://github.com/rodhilton/SimpleStrengthLog").  In today's Android ecosystem, this seems to be increasingly rare, it's become a lot more like the App Store, with a lot of apps that cost $2, or have a free version with a $2 pro version key.  I rarely see Android apps open sourced anymore, but I did it anyway because when I first **adopted** android, it was the norm.  And since it was one of the reasons why I decided I liked the Android ecosystem in generally and got my first Android device, I felt like I should preserve it.  The [T-Mobile-G1](http://www.engadget.com/2008/10/16/t-mobile-g1-review/")-buying version of me would have wanted me to keep it open.


# Android in my Future

I really enjoyed my Android experience.  In fact, I set about writing the followup, [Simple Cardio Log](https://play.google.com/store/apps/details?id=com.nomachetejuggling.scl&hl=en"), and completed it in about 4 days, largely stealing a lot of code from Simple Strength Log.  While developing it, I learned a bit more, especially about the Android UI, that I wound up backporting back into the Strength Log.

{% image Screenshot_2013-08-29-21-07-13-168x300.png align="right" %}

I definitely intend on doing more Android development.  I do indeed plan to write the followup apps like Simple Food Log (my next one) and maybe even a non-free apps that work with the output files.

I now feel about my phone the way I feel about my desktop machines, in the sense that if I have an issue on the device I want to solve, I feel competent being able to write software that runs on it to solve the problem.  I've already responded to a few complaints my wife has made about various things with "maybe I'll write a tiny Android app for you to fix that."  I've even inquired a bit at work about which team works on my company's Android apps, to consider if I'd like to work on them as well (yeah, my company is so large I literally don't even know who works on the Android apps).

Android is a fun platform to develop on, and it's come a long way since I first tried back in the days of Froyo.  It's a lot easier to write good-looking apps now, utilizing Android APIs to implement common patterns on the Android platform.  There is now a wealth of information out there, with tons of books and the indispensable [StackOverflow](http://stackoverflow.com/questions/tagged/android"), which is a welcome shift from when I first wanted to write an Android app and there were only 3 books on the subject, all out of date by the time I got them.  The Android platform is stabilizing and maturing, and the documentation is reaching a point where it's actually almost helpful, so writing an app was a lot more fun than I expected going in.

When all done, I had a whole bunch of new knowledge under my belt for writing applications, I have a skill I can add to my resume, a field that I'd definitely consider in future employment and, best of all, I finally have apps to track my workouts on my phone.

