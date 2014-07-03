---
layout: post
title: Scala Second Impressions
category: Programming
tags:
- functional
- functional programming
- impressions
- programming languages
- scala
status: publish
type: post
published: true
---
In December, I posted about [my early thoughts]({% post_url 2011-12-15-scala-first-impressions %}) on Scala after using it for a short time.  Initially, I thought that using Scala didn't buy very much - the functional style could be adopted in in Java, and the syntax and libraries could be ugly.

Since that time, I've been using Scala almost exclusively, and I wish to revise my view: **Scala is awesome**.

While some of my initial thoughts still stand, particularly that Scala APIs often overuse operator overloading, much of my perception has shifted otherwise.  Scala not only allows, but encourages solid functional programming principles that are difficult or impossible in Java.

# Comfort and Training

A great deal of my perception shift has been due to familiarity and training.  I realize that a lot of my earlier issues with Scala were due to my own lack of comfort with the language, and over the last year I've done a great deal to level up my Scala skills significantly, like:

 * Read the entirety of Odersky et. al.'s [Programming in Scala](http://www.artima.com/shop/programming_in_scala_2ed) cover to cover
 * Attended Dick Wall and Bill Venner's excellent [Stairway to Scala](http://www.artima.com/shop/stairway_to_scala) week-long workshop (this probably made the biggest contribution to me getting over the Scala hump).
 * Read what was available of the MEAP [Functional Programming in Scala](http://www.manning.com/bjarnason/), a book focused not on Scala but on Functional Programming principles
 * Enrolled in Odersky's [Functional Programming Principles in Scala](https://www.coursera.org/course/progfun) class on Coursera.
 * Currently reading Josh Suereth's [Scala in Depth](http://www.manning.com/suereth/), which actually wound up being the Effective Scala book I wanted in the previous post.

All of these resources, combined with a continued daily use of Scala, led to me using Scala in a much meatier way than previously, enabling me to write some extremely expressive code.

# Cool Stuff in Scala

{% image artinodersky-209x300.jpg caption="Close your eyes during lectures, it sometimes it sounds like Schwarzenegger is teaching you programming." %}

I really like how strict Scala is in terms of the compiler.  Many developers are embracing increasingly dynamic languages, but Scala bucks the trend.  The ability to define generics, covariant types, contravariant types, as well as the existence of classes like Any, AnyRef, and Nothing, allow developers to rely on the compiler to check things that, in other languages, can only be checked at runtime.  It's possible to be this strict in Java most of the time, but somehow I feel like the way Scala handles this complexity is cleaner and more elegant.  At work, we implemented our own Dependency Injection system that checks all injections at compile time, no XML required.

Scala makes it easy to implement good Functional Programming paradigms, like higher-order functions, function composition, and currying.  Though possible to implement the Option pattern in other languages, Scala's type hierarchy and rich generics support makes it much easier to cleanly avoid exceptions.  Being able to perform flatMaps on collections of Options in a way that feels natural is excellent.

Pattern matching is simply awesome.  Declaring extractors for types has allowed me to write some incredibly cool code.  Pattern matching can have a tendency to lead to deeply nested matcher blocks, but I still like them overall.  My biggest complaint is that, while they work so well at matching against Regular Expressions, Regexes not being a first-class type makes working with them a little clunky.  You have to declare Regex variables by calling the `r()` method on a String (usually triple-quoted).  It would be much easier to work with regular expressions `/like this/`.

As with all other languages I enjoy, I love being able to return multiple things from a method and perform multiple assignments in a single line.  And being able to pass a type to a method which solely defines the type anonymously in terms of which method(s) it must have is a super cool feature that can be abused.

I initially complained about operator overloading, and I still feel like it can be overused, but I've always felt like Java should at least support limited operator overloading, at least on the basics like +, -, <, >, and so on.  Scala supports totally arbitrary operator overloading, which gives me what I want at the expense of allowing other people to overuse it.  Additionally, the rules that Scala has to follow to allow for normal order of operations with infix operator overloading are a bit ridiculous (check page 135 of the Odersky et. al. book), but that's the price you pay to keep infix support, I suppose.

# The Point of Scala

Scala is a great language because it's to FP what C++ was to OO.  It's familiar to users of the more traditional programming paradigm, but capable of a different one.  It allows people to gradually shift towards Functional Programming as they gain comfort with the ideas, and it allows programmers to use Object-Oriented Programming where it's the best tool for the job.  Scala lets you leverage the power of a functional language and the power of an OO language simultaneously, catering your code to the strengths of each paradigm where more appropriate.  Code that would be henious in OO land might be very reasonable in FP style, and code that would be unweildy and complex in FP might be totally understandable in OO.  Scala lets you choose whichever works best for what you're doing.

I'm not aware of any other languages that embrace both FP and OO as thoroughly as Scala.  Programmers are free to use it as an even stricter, more statically compiled Java (with less boilerplate and some handy convenience features like case classes and traits) if they wish, or they can go whole-hog into the Functional style and leverage lazy evaluation, tail recursive functions, currying, partial application, monads, and so on.

This allows me to use the power of Scala without losing my knowledge of the JVM, the huge library of open source code written in Java, or even JVM-based frameworks.  I'm not totally on board with any of the web frameworks for Scala, so I'm using Groovy/Grails for a client-facing site, which connects to a bunch of backend services written in Scala.  Being able to do this is great (though the switch can be a bit jarring at times).

Overall, Scala is exactly what it needs to be, and it's an incredibly well-designed and clever language.

# Still Some Woes

There are a few nags I have about Scala.  It's power comes with a price - even though I understand Scala pretty well now, it's still common for me to encounter code that looks almost unreadable, sometimes resembling particularly bad Perl programs.  I have to really sit and stare at this code to parse it, which can be time-consuming.  This seems to be common even among seasoned Scala vets, which is disheartening.

{% image scala_logo-e1323974677125-300x83.png align="left" %}

There are also some nags I have about the language design itself.  I hate that XML is treated as a first class type with lots of compiler support, but regular expressions are not.  In 2012, it's difficult for me to take an expressive language seriously if I can't define a regex without first creating a String.  It also annoys me that there is an annotation that makes the compiler check for tail recursion, but not one that provides automatic function memoization.

Interop between Java and Scala still seems to suck pretty bad, especially around Collections.  You can do some things to make this problem less severe, but it's still harder than it needs to be, and I'm not convinced there's a good reason.

My biggest complaint is with the Scala ecosystem.  IDE support is tolerable but not excellent, but more importantly the build tools are terrible.  All of this power and all of the things the compiler does for you causes compilation to be extremely slow.  A large Scala project can take ten minutes just to compile.  

The only workaround for this seems to be to use SBT and leverage its built-in incremental compilation, but SBT happens to be extremely difficult to understand and use.  Unfortunately, SBT seems to be the only game in town for Scala; we tried a Gradle build for our large Scala project and converted to SBT after spending a great deal of effort and still failing to make the full build in Gradle take fewer than 40 minutes.  

Basically, you're using either Maven or Gradle to build your project but it takes forever, or you're using SBT and it builds quickly, but modifying your build takes forever instead.  My understanding is that some work is going on in the Twitter/Foursquare land to create a new build system that perhaps leverages the incremental compiler, so I'm excited to see what comes out of that.

All in all, I'm very happy using Scala regularly now, and I often find myself missing it when I'm using another language.  The community seems to have exploded in the last year or so, with excellent online courses based on Scala, and tons of fantastic functional programming books having been released or currently being written using Scala as the base language.  I think it still has a ways to go in terms of good tooling support and compilation speed, but I've definitely come around to the Scala way of thinking this past year.

