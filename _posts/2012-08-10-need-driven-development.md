---
layout: post
title: Need-Driven Development
category: Programming
tags:
- Automated Testing
- Design
- object oriented programming
- software design
- tdd
status: publish
type: post
published: true
---
I love Test-Driven Development, but I've found that there are a number of different ways people actually do TDD in real-world projects.  Over time, I have discovered that I have a particular way of working that I prefer above all others, and I would like to describe it.

Imagine you are writing some software that will have a number of interacting components.  I'm going to suggest a toy example, one that will help illustrate what I'm talking about, but is not so complex to actually warrant it.  Imagine you are going to write a Lottery game.  Players will have lottery tickets, and they will listen for Callers to read out the winning lottery number (think Observer pattern).  The Callers will use a Hopper with numbered balls, selecting the appropriate number of balls and then calling out the winning number at the end.

To follow the [Single-Responsibility Principle](http://en.wikipedia.org/wiki/Single_responsibility_principle"), you think your game will probably have three classes:

 1. The `Hopper` - this contains all of the numbered balls and, when asked, returns one to the caller (removing it).
 2. The `Caller` - once the lottery has started, this will ask the `Hopper` for numbers and call out the final sequence of numbers to registered `Player`s
 3. The `Player` - this will observe the `Caller`, listening for numbers to be called and determine if he is a winner by comparing the numbers to his array of numbers (given at construction).

The `Player` is going to interact with the `Caller`, and the `Caller` is going to interact with the Hopper.

{% image "http://yuml.me/diagram/scruffy;/class/%5BPlayer%5D-%3E%5BCaller%5D,%20%5BCaller%5D-%3E%5BHopper%5D" %}

# Traditional Bottom-Up Coding

The `Hopper` has no dependencies on anything else, so it's the simplest to write.  You can construct it with a set of numbers, provide a way to get one of the numbers at random (removing it from the set).  It's the easiest to test and the easiest to write because it doesn't depend on any of the other classes.  So some (most?) developers will start with the `Hopper`.  Once the `Hopper` is done and it has a clearly defined interface, the developer will write the `Caller`.  Then they will finally write the `Player` and be done.

One might reasonably refer to this as the bottom-up approach to this problem, starting at the bottom-most, dependency-less class and working upwards, building on each newly-created class to make the next one. ** This is a very abstraction-oriented approach to development, and it's a natural fit for many developers.**  For example, a developer knows that his or her code will have to eventually hit a database, so they naturally want to write the database-accessing component first, then build on top of it once it's done.

There are problems with this approach, of course.  The primary issue is, you might write Hopper and think you're done, then as you're writing `Caller` you discover that you really wish `Hopper` worked in a slightly different way.  Since the issue is a problem of the interface, you must modify the `Hopper` interface, breaking the tests written against it.  So you have to halt your work on `Caller`, go back and modify the `Hopper` tests, modify the `Hopper` interface and implementation, and then even modify the mocked version of `Hopper` being used in the `Caller` tests, all before getting back to `Caller`.  This kind of interruption kills any sense of momentum.

Because of this, you're never really working on a class in isolation.  You're juggling between that class and its dependencies, keeping all of them up in the air and available for change at any time, potentially burrowing all the way into your bottommost dependency, far away from where you're trying to focus.

Developing this way also means that nothing is presentable to a customer until it's almost completely finished.  The class closest to the customer is done last, which means an awful lot of work has been done before the customer has a chance to indicate that things aren't quite as he or she would like.

# Alternative: Need-Driven Development

Allow me to propose a different way of dealing with this problem:** code top-down, start with the `Player`**.

The `Player` is ultimately the client and the real point of entry for this system.  The `Player` is the class closest to the user.  `Player` will obviously need to reference `Caller`, so create an interface for `Caller` and mock it out in the test for `Player`.  As you are writing `Player`, whenever you need `Caller` to do something, just assume it already does it and write the interface method for how you wish it to work, from the perspective of the `Player`.  Mock it out so that, within the test, it DOES do that, and move on.

When you're done with `Player`, since you already assumed `Caller` works, move on to implementing `Caller`.  You have already defined its interface based on the needs of the code consuming it, and you already have a head-start on what tests you need to write based on the behavior you mocked out in the `Player` test.  Write `Caller`, this time mocking out `Hopper` in a similar way.  Then move onto `Hopper`.

At each stage, rather than simply _guessing_ at how you will want to use the class you are writing, you've already defined exactly how you want it to be used.  This client-oriented approach means that **your classes are always designed with the client in mind**, and therefore the code that uses them is always extremely clean and intent-revealing.  As a bonus, you have a great outline for the tests you need to write at each level.

I've liked developing this way for a long time, but I never knew what to call it.  Well, I recently found out this approach already has a name: Need-Driven Development (([xUnit Test Patterns](http://www.amazon.com/xUnit-Test-Patterns-Refactoring-Code/dp/0131495054"), p. 149)).

# Advantages

As mentioned, the main advantage here is that your code is always designed with the consumer in mind, which helps ensure code is clean and understandable.

Another advantage of this approach is that it will help with YAGNI (([You Ain't Gonna Need It](http://en.wikipedia.org/wiki/You_ain't_gonna_need_it"))): bear in mind the example from Bob Martin's [Bowling Game](http://www.objectmentor.com/resources/articles/xpepisode.htm"), in which Martin and Bob Koss developed a Bowling scoring program bottom-up, only to discover they were needlessly creating more classes than really essential.  Working top-down means you only split out into a new class when it's truly essential.  A good heuristic to follow is if you're coding and think "I really shouldn't do this in this class..." you can assume another class is doing it, create the interface for that class, write the methods as you wish they existed, mock them out, and continue on without letting it distract you for long.

It also lets work you quite a bit faster.  Instead of getting hung up on the implementation detail of something unrelated, if you find yourself saying "I really don't feel like figuring that out right now" you can refuse to.  Instead, create a class whose job it is to figure that out, then** keep working on the assumption that it's already done**.  Delegate difficult work to a placeholder, then go back and fill it in later.

This even works extremely well when doing heavy front-end or client work.  Build a stub that claims to do the work you wish was already done, then code to that stub.  Once the component is completely finished, you can move on and flesh out the real implementation of the stub, all the while knowing that you can't break the client.

Lastly, this approach makes your work demoable much earlier.  No matter where you are in the process, the part closest to the user is the most complete, so your customer or product owner can interact with it and have a decent idea of how the final version will work ((It's a good idea to make it visually clear the work isn't complete, however.  Otherwise they may want to ship early.)).

So next time you're writing some new code, don't start at the bottom, start at the top.  Develop based on your need.

