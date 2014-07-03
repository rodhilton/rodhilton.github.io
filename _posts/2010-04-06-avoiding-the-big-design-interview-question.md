---
layout: post
title: Avoiding The Big Design Interview Question
category: Programming
tags:
- Design
- interview
- oop
- tdd
status: publish
type: post
published: true
---
There is one common type of question that I think sets up both the candidate and the interviewer for failure.  I've seen it asked by my interviewers, my co-interviewers, and even by me. The question takes this format:

 > Sketch out the object model for a (commonplace noun)

Generally this question is asked to feel out someone's OO skills.  Do they understand inheritance, polymorphism, abstraction, etc?  Can they describe the relationship between a _plant_, _flower_, and _petal_ (a flower is-a plant, and has-a petal)?

I used to ask this question myself when I was first starting out doing interviews.  I would ask the candidate to describe the object model for a `Chicken`.  I was expecting the candidate to sketch something resembling the following:

{% image "http://yuml.me/diagram/scruffy;/class/%5BAnimal%5D%5E%5BChicken%5D,%20%5BChicken%5D+-%5BBeak%5D,%20%5BChicken%5Dproduces-.-%3E%5BEgg%5D.png" %}


Now, I wouldn't expect it to be perfect UML or anything like that, but I wanted to see the basic idea that the candidate knew that a `Chicken` was probably a `Animal` or a `Bird`, and maybe `Bird` is an `Animal`, and maybe `Chicken`s have `Feather`s or `Beak`s, or maybe those belong to `Bird`, etc.  I thought this was a great question for gauging a candidate's comfort with Object Oriented Programming.

**I was wrong.**

This is actually a terrible question.  I stopped asking it years ago because I never seemed to get an answer I liked, which told me that it was a bad question.  Only recently, however, have I really come to a full understanding of why it's such a bad question.

# Evolutionary Design

A good software developer does not sit down and sketch out all of the objects in the system and their relationships.  Doing so would be a surefire way to add unnecessary complexity to an application.  One particularly interesting example of this can be found [here](http://www.objectmentor.com/resources/articles/xpepisode.htm), a semi-transcript of Bob Koss and Bob Martin sitting down together to create a small program to keep track of bowling scores.

When the Bobs start, they sketch out a `Game` class, `Frame` class, and `Throw` class.  But when they start to write their tests for the `Throw` class, they realize they have none because it has no behaviors.  They start to write some tests for the `Frame` class and discover none there as well.  They finally start by writing tests for the `Game` class itself, which helps them drive all the way to completing the application.  In the end, they only had two classes: `Game` and `Scorer`.

When trying to think of the classes outside of the context in which they would be used, the two Bobs failed.  Once they began writing tests to drive out the behavior, they found that the responsibilities they needed belonged not to three different classes, but to two.  The behavior of the system drove the design.

This is a fundamental principle of Agile software development (and, more specifically, XP): [Evolutionary Design](http://www.artima.com/intv/evolution.html).  Good programmers follow the practice of Evolutionary Design because it prevents the system from being over-engineered and overly complex while incrementally making the system more and more resilient to change.  This is a good practice, and I want to hire people who follow it, but when I asked them design the object model for a `Chicken`, I am essentially asking them to do Big Design Up Front, something I'd prefer them not to do if they join the team.  I'm setting myself up for failure, because anyone who answers this question well may have a tendency to do something I don't really like.

# Context is Key

Imagine asking a similar question to the `Chicken` question above.  You request the candidate "design the object model for a Car."

Maybe you're expecting the candidate to write something like this:

{% image "http://yuml.me/diagram/scruffy/class/%5BVehicle%5D%5E%5BCar%5D%2C%20%5BCar%5D+-%5BSteeringWheel%5D%2C%20%5BCar%5D+-%5BTire%5D%2C%20%5BCar%5D+-%5BEngine%5D" %}

Seems reasonable.  But imagine that the application for which this `Car` has been designed in a full-fledged CAD-like application for a car designer. The `Car` will be used by the designer to help determine how the car looks, how the exterior works, how many doors it has, and so on.  It may look like this:

{% image "http://yuml.me/diagram/scruffy;/class/%5BCar%5D+-%5BHood%5D,%20%5BCar%5D+-%5BRadiator%5D,%20%5BCar%5D+-%5BGrille%5D,%20%5BCar%5D+-%5BBumper%5D,%20%5BCar%5D+-%5BHeadLight%5D,%20%5BCar%5D+-%5BDoor%5D,%20%5BDoor%5D+-%5BDoorHandle%5D,%20%5BCar%5D+-%5BACCondenser%5D,%20%5BCar%5D+-%5BTailLight%5D,%20%5BLight%5D%5E%5BHeadLight%5D,%20%5BLight%5D%5E%5BTailLight%5D,%20%5BCar%5D+-%5BTrunk%5D,%20%5BTrunk%5D+-%5BTrunkLatch%5D,%20%5B%3C%3CHinged%3E%3E%5D%5E-.-%5BTrunk%5D,%20%5B%3C%3CHinged%3E%3E%5D%5E-.-%5BHood%5D,%20%5B%3C%3CHinged%3E%3E%5D%5E-.-%5BDoor%5D.png" %}

Or imagine instead, that the `Car` class will be used in a traffic simulator program that's really meant to test traffic congestion, stop light placement, and so on.  In that application, a Car is really just something with a direction and a velocity, so it would look more like this:

{% image "http://yuml.me/diagram/scruffy/class/%5BCar%5D" %}

In the former, the future changes your design should guard against are new types of doors, or new components for a car.  There is no danger of a different kind of Vehicle, such as a Plane, because this is for a Car company.  In the latter, you may need to guard against additional vehicle types such as `Bicycle` or `Scooter`.  The design that gets evolved by these two systems will be fundamentally different, so why ask the question without providing information about the system itself?

Ultimately, the problem here is that there is a spectrum of answers to this question, ranging from extremely simple to extremely complex.  But depending on the context, any one of those designs can be the right design.  When an interviewer asks the question, theres a specific place on this spectrum where he or she would like the candidate to answer, and anything below that indicates a poor understanding of OO, while anything above it indicates a tendency to overdesign.  The interviewer has set up the candidate to fail.

# How To Ask This Question
If you want to know how comfortable a candidate is with OO, ask them the question in a way that resembles real-life OOP a bit more closely.  Start simple, by providing a single simple requirement.  Though the candidate won't be able to write and run tests, the requirement serves as a driver for the design.

A good indicator that the question is taking you and the candidate off-track is if the boxes he or she draws on the whiteboard lack method names.  If there are no methods, there are no behaviors, which means the candidate is designing first, regardless of requirements.  Steer the candidate back by asking them to write method names.

For example, ask the candidate to design the object model for a simple bookshelf.  A bookshelf is so simple that there's virtually no way to overcomplicate it, so you can say that you simply need to be able to add a book to the bookshelf, nothing else.  Once they have done this, give the candidate another "test", by adding a requirement.  Now say that you want the bookshelf to be a "smart" bookshelf, where you can look up a book by title and get a reference to the book.  The candidate will make some changes to their design.  Continue adding requirements to the thing until you're satisfied with the evolution of the candidate's design.

 * Modify the design to allow me to search the bookshelf by Title, Author, or ISBN
 * Allow me to use the bookshelf as an ad-hoc library, so I can "check out" a book, removing it from the bookshelf.  Make it possible to look up books that have been "borrowed".
 * Require a user provide their name when checking out a book.  Give them a return date.  Make it so the bookshelf can generate a list of overdue books and who has them.  Where does that method belong?  Should it be on its own object that Bookshelf uses?
 * Make the bookshelf more concrete, so that there is only a certain number of books that can fit on any given shelf in the overall bookshelf.  Make it possible to ask which shelf a book is on.  Make it possible to add a new shelf.

You can obviously pick your own model (Car, Elevator, Fridge, etc) and drive the direction the design should go using requirements.  Have the candidate write method names (but not implementations) where appropriate.  Keep asking if the method is on the right object, or it belongs on another one.

# How To Answer This Question

Of course, not everyone reads this blog, so if you're in an interview you may get the "design an object model for a _x_" question.    If you find yourself in this situation, you essentially want to ask questions of your interviewer to pull requirements out of them.  The reality is, they probably **DO** have a particular kind of system in mind when they ask the question, so you need to find out what that is.

If you're supposed to design the `Car` class, ask if there are other types of vehicles in the system.  If not, don't make a `Vehicle` parent class, and explain that you see no need unless the system required additional vehicles.  Before you draw a box named `Tire`, ask if the car needs to be able to support snow tires or some other kind of interchangeable tire.  If not, why would you make a class or interface for them?  Start as simply as you can and only draw a new box when you've extracted enough information from the interviewer to deem it warranted.  If you jump up to the whiteboard and draw two or three boxes before asking any questions, you're placing your interview at risk because the interviewer may be picturing a completely different usage of this system than you are.

Of course, it's always possible that the interviewer will keep asking for the same information, arguing that you should show your OO skills off without requirements that drive that design out.  If you want the job, your best bet there is to take a random stab at the appropriate level of complexity and hope that you strike somewhere near what the interviewer wants.  In that situation, however, I'd imagine your interviewer doesn't know much about designing good software, and their codebase might be an over-engineered mess, so you may not want that job.

