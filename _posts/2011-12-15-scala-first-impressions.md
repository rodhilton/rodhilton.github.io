---
layout: post
title: Scala First Impressions
category: Programming
tags:
- functional
- languages
- programming languages
- scala
status: publish
type: post
published: true
---
A few months ago, my co-workers and I converted a central part of our codebase from Java and Groovy into [Scala](http://www.scala-lang.org/).  Though I am, by no means, a Scala expert at this point, I wanted to share some of my initial thoughts on the programming language.

Writing this blog post is probably a mistake.  A few years ago I shared [my thoughts on Ruby]({% post_url 2007-09-10-language-marathon-first-impressions-of-ruby-python-and-c %}) after a similar amount of time using it.  When I went back and re-read that post to get the link for this one, I was stunned.  I don't even remember disliking Ruby at any point.  **Today, Ruby is one of my favorite programming languages**, and the tool I reach for most readily for almost any project outside of work.  I still love Python as I did in that post, but my view of Ruby has, apparently, completely changed.

Nonetheless, I have some thoughts on Scala and because I have a blog, I suffer from the delusion that there are people who give a shit what I think about it.  

As with any "first impressions" post, it's entirely possible I will literally discover something that invalidates my complaints tomorrow (maybe even in a comment on this post), so take this with a grain of salt.

# What's Bad?

## Compilation Is Slow

Our Scala codebase is quite large, divided into many different modules.  At the moment, we have over 57,000 lines of Scala code in a series of modules that make up a central Common Services Tier, which is nothing to shake a stick at.  One observation about using Scala in this way is that compiling and running the Scala code takes a very, very long time.  Far longer than with Java or even Groovy.

{% image scala_logo-e1323974677125-300x83.png align="right" %}

I am aware of the existence of the [Fast Scala Compiler](http://www.scala-lang.org/docu/files/tools/fsc.html), which offers a substantial speed improvement.  However, while I was able to get FSC working in IntelliJ without an issue, getting Gradle to use it to build our project has proven surprisingly difficult.  I've followed the tutorials that are available, but ultimately I failed.

And no, the Scala Build Tool is not an option.  It simply doesn't offer the kind of power that we require and are getting out of Gradle.

It's not like compilation is taking hours or anything, but it's a minute or so longer than it ought to be for the amount of code, which adds up to a lot of time.  It's much faster to compile and run Scala from IntelliJ because I got FSC working in it.  As a result, I rarely have to compile from command-line, but when I do I wish it was faster.

## Interop Is A Bitch

We didn't convert to Scala whole-hog, and I dont think we intend to.  Most of our client-facing sites are written with Grails, with the controllers calling a number of services written in Java and Groovy.  

Using Java or Groovy from Scala is a breeze.  Using Java and Groovy from each other are also a breeze.  Using Scala from Java or Groovy pretty much makes me want to drink a pitcher of boiling lava.

I won't pretend to understand the design decisions that went into Scala, but I'm definitely annoyed at the fact that `scala.List`s do not implement the `java.util.List` interface.  It seems to me that Scala could have had the full benefit of using its own lists within the Scala language while still implementing that trivially-small interface.  Doing so would have made it so much easier to at least pass Scala's lists to Java or Groovy methods that are expecting a `java.util.List` or a `java.util.Collection`. I've had to import `scala.collection.JavaConversions` into more .java and .groovy files than I care to recount.

Of course, this wouldn't solve the problem of passing Java `List`s into Scala, which resembles this beauty:

~~~java
scala.collection.JavaConversions.asScalaBuffer(existing).toList()
~~~

Using `trait`s, Scala can give you something resembling multiple inheritance.  This is a powerful addition to the toolbox, but it also makes classes surprisingly difficult to use (and, in particular, mock) in Java or Groovy.  As a result, we tend to use this powerful ability sparingly, which is a shame.

## It's Young

Scala is so young that there isn't much in the way of idiomatic guidelines for it.  **I don't have a good grasp on Scala best practices or patterns.**

{% image eff_java-239x300.jpg align="left" %}

A lot of the Scala code I write I have little confidence in, in terms of design.  When I write good Java or Groovy code, I know it's good, and part of that is I've read so much about those languages that I know what most other developers consider easy to understand.

Java has been around so long that the Java community has learned what kinds of things you can do that make code hard to maintain, and countless books have been written on how to avoid those things.  Most of those tips extend to Groovy as well, but not to Scala.  In fact, some of those patterns and practices seem like antipatterns in Scala.

Whatever book is the "Effective Java" of Scala, I'd love to read it (though I don't think it yet exists).  A coworker told me that it was unnecessary since "Scala is effective Java."  Annoying.

## The APIs Can Be Ugly

I've argued with Java developers before about operator overloading.  Many feel like operator overloading leads to ugly APIs, but I've always said that more power is better, and developers can simply have the discipline not to overuse a feature like operator overloading.  **Scala has convinced me I'm probably wrong.**

We are heavily using the Scala library [Dispatch](http://dispatch.databinder.net/) in our code.  Here are some methods defined on the class [RequestVerbs](http://databinder.net/dispatch-doc/#dispatch.RequestVerbs):

 * `/` - Append an element to the request path.
 * `<&` - Combine this request with another
 * `<:<` - Add headers to the request.
 * `<<` - POST the parameter.
 * `<<<` - PUT the parameter.
 * `<<?` - Add query parameters.
 * `>\` - Set the character set.

This is terrible. It's impossible to write [clean code](http://www.amazon.com/Clean-Code-Handbook-Software-Craftsmanship/dp/0132350882) against this API, because there is no way to express intent.  **Any developer reading the code will have to pull up the API to understand what is happening** unless he or she is intricately familiar with the library already.

It would be one thing if this object had regular, English methods and the overloaded operators called them (or vice versa), but that's not the case.  There's no way to call these methods without invoking these random-seeming combinations of symbols.  The code ends up looking like [Brainfuck](http://www.muppetlabs.com/~breadbox/bf/).

Rather than seeing Dispatch as an embarrassing wart on the Scala community, it seems to be generally highly regarded, [even praised](http://www.scalafied.com/84/one-liner-for-a-urls-last-modified-header-as-date) for its abysmal API.  There seems to be a large constituency of Scala developers who are enamored with operator overloading, seemingly without regard to the adage "just because you _can_ do something, that doesn't mean you _should_."

# What's good?

## The Paradigms Are Great (But Are They Exclusive?)

There is no doubt that our Scala code is highly functional, emphasizing composing functions together rather than declaring steps.  I love functional code, I think it reads much more clearly than iterative code, so **this is a huge win**.  Our objects are always immutable and much more thread-safe.

But are we doing this because of Scala? Scala may **encourage** immutability, but it does not **demand** it. You can declare variables as `var`s even though you’re encouraged to declare them as `val`s. Our team is following functional coding practices because we chose to, not because Scala is enforcing it.

I’ve been making my Java classes immutable and relying on the [Builder Pattern](http://en.wikipedia.org/wiki/Builder_pattern) for object construction for years. And I’ve been writing functional-style code using [Google Guava](http://code.google.com/p/guava-libraries/) in Java for about as long, which is even easier with Groovy.

These paradigms have been part of my coding practices for a while, and since we’re only using them in Scala because we agreed to do so (and could have just as easily not done so), couldn’t we have agreed to do them in Java or Groovy as well? 

[Clojure](http://clojure.org/), I’d understand. Clojure pretty strongly enforces the functional paradigm, it’s not a matter of choice really. But since Scala doesn’t, at least not as much, I’m not really sure I know what Scala is buying us, though I suppose there are some particular functional practices that Scala makes much easier.

## It Keeps Idiots Out

The biggest advantage of Scala, at least so far, is that it keeps a certain type of coder out of the codebase.  Groovy did not accomplish this, since Java code can compile as Groovy with minimal modification.

{% image idiot-300x216.jpg caption="GTFO." %}

Because Scala is a bit more cutting-edge, and involves some pretty serious shifts in thinking, the kinds of coders who are capable of doing their job with Java but have no interest in learning new languages have little interest in understanding Scala well enough to make changes to Scala code.  Most half-assed attempts to do so are met with compilation failures.

Basically this boils down to Paul Graham's [Python Paradox](http://www.paulgraham.com/pypar.html), in which he claims that the caliber of developers who know Python will, on average, be better than the typical Java programmer, which creates an advantage to using Python in your project that is completely separate from the capabilities of the language itself.

I feel kind of bad including this as an advantage, because it's essentially "functional programming is difficult to learn, so it excludes dumb people," but it's kind of true.  It's had a positive impact, and I appreciate Scala for this, even though it's a backhanded benefit.

# Conclusions

Though I list more cons than pros, I'm enjoying Scala.  I like learning new languages and Scala has a lot of movement in the JVM ecosystem, so it's nice that I'm not behind my peers in learning it.

I also like that my team is writing immutable, thread-safe, highly functional code.  Personally, I think we could be doing that in Java or Groovy or any other language really, with a little added discipline.  That said, to some extent if Scala is what's making everyone do that, then Scala is good thing, in a "the ends justify the means" sort of way.

Overall, I view Scala very much how I view C++.  C++ is [not really a good language](http://damienkatz.net/2004/08/why-c-sucks.html) at all, but it was of great historical importance.  C++ supplied a Object-Oriented Programming layer on top of C, which allowed iterative-style C programmers to transition to OOP at their own pace.  Not a great language, but a necessary compromise to help the transition.  I view Scala in much the same way, as a transitional language to help get professional Java programmers more comfortable with functional programming.  Today's Scala programmers are tomorrow's Clojure or Haskell programmers, and in that sense Scala serves a very valuable purpose.

I'm definitely still getting comfortable with the language, and I can easily see myself viewing it more and more favorably as time goes on, but **I'm not quite at a point where I'm sure it's buying me much**.  I love functional programming and always have, and Scala **does** encourage me to do so, which is nice.  I also love [Pattern Matching](http://www.scala-lang.org/node/120), that's a badass feature I could see myself eventually seeing as indispensable.

A lot of my issues with the language (compilation speed, lack of best practices) are due largely to how young the language is, so they're likely to improve over time as well.  In a way, even my complaint about the ugly APIs is due to the age of the language: if it were older there would probably be a decent alternative to Dispatch.

Overall, I'm excited to continue using Scala and see it improve over time.

