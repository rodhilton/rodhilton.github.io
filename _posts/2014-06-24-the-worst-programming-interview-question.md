---
layout: post
title: The Worst Programming Interview Question
category: Programming
tags:
- algorithms
- coding
- interview
- puzzle
status: publish
type: post
published: true
---
Years ago, I wrote about a [particular type of interview question]({% post_url 2008-12-11-my-least-favorite-interview-question %}) that I despise.  Today I'd like to discuss a much more specific question, rather than a type.  I've never been asked this question myself, but I have seen it asked in an actual interview, and I officially nominate it as the worst question I've ever heard in an interview.

A co-worker at a previous company used to ask this question, and it was the first time I'd ever heard it in an interview setting.  This company did pair interviews, two engineers with one candidate.  One day he and I were the two engineers interviewing some poor candidate.  The candidate had actually done pretty well as far as I was concerned, and then my co-worker busted this question out.  The candidate stumbled over the answer, visibly frustrated with himself.  In the post-interview pow-wow, all of the engineers who'd interviewed him gave him the thumbs up, except my interview partner, who refused to hire him on the grounds that he completely flubbed this question, and "any engineer worth his salt should be able to answer it."  He actually said that if we hired this individual, he would be unwilling to work on a team with the candidate.  For what it's worth, the story has a happy ending, in that we hired the candidate in spite of his protests, fired the co-worker within a few months, and the candidate is still at that company, doing quite well.

Anyway, I think this question perfectly represents everything that can go wrong with an interview question, so I'd like to discuss it here to explain why it's almost hilariously awful as an interview question:

> __Write a function that can detect a cycle in a linked list.__

Seems like your basic algorithm coding question at first, right?  Hop up and write the function on the white board; totally reasonable, right?  Except it's not, it's brain-meltingly terrible.  Let's break it down.


# 1. It's completely inappropriate

This is a job interview.  You have a dynamic where you're talking to someone who is interviewing for a job.  It's naturally nerve-wracking, and "puzzler" questions where there's some "a-ha" moment of clarity are the worst kind of programming questions you can ask.  If you don't have the a-ha moment in the interview, you won't get it, and a good chunk of your brain will be devoted to thinking "oh shit I'm blowing this interview" rather than focusing on the question at hand.

People like to pose puzzlers to "see how people think" but that's nonsense in the case of puzzler questions.  __You can't reason your way through a puzzler, that's why it's a puzzler__.  You just have to hope you have the a-ha moment.  Sometimes I've heard people like to "see how people handle pressure" but they're _already_ in an interview, the pressure is already there.

Asking puzzler questions is a complete waste of time, __all you're doing is testing if someone has seen your particular puzzler before or not__.  You may also be testing their acting chops, as the person who has heard the question before pretends it's their first time hearing it, and they feign reasoning their way through the problem to arrive at the answer they already know as soon as the question comes out of your mouth.

This particular problem is the worst offender in this regard.  Why, you ask?  Well, imagine if someone truly _was_ hearing this problem for the first time, and you're expecting them to reason their way to the answer. 

In this case, the generally "correct" answer is a tortoise-and-hare algorithm, where you have two pointers at the head of your linked list, one traverses the list two nodes at a time, and one traverses the list one node at a time; if ever the pointers point to the same node, you have a cycle somewhere.

Sure, there are easier answers, like marking each node with some kind of 'seen' boolean, or traversing the list from each node to see if you come back to it, or duplicating the list into a hash and looking for a collision, but as soon as you provide those answers, the interviewer will add restrictions saying to use less memory or use less time or don't modify the underlying data structure.  The only one that makes the question "stop" is the tortoise-and-hare algorithm.

Is it reasonable to expect someone to think of this, from scratch?  After all, you're pretty confident you could think of it, right?  Well, the Linked List as a data structure was [discovered by Allen Newell, Cliff Shaw and Herbert A. Simon](http://en.wikipedia.org/wiki/Linked_list#History) in 1955.  The "correct" cycle detection algorithm for a Linked List is named "Floyd's cycle-finding algorithm" in honor of its inventor, Robert W. Floyd, who discovered it in [a 1967 paper](http://dl.acm.org/citation.cfm?doid=321420.321422).

Between 1955 and 1967, the problem of "how do we determine if there is a cycle in a linked list without modifying the list" was an open problem.  Meaning, any number of PhD candidates in Mathematics or Computer Science could have written about it as part of their dissertation.  With all of those hundreds and hundreds of minds, __this problem remained open for 12 years__.

Do you honestly think you could, in a twenty minute interview, from scratch, come up with the solution to a problem that remained open in the field for 12 years, all under a pressure far more intense than any academic?  Seems pretty damn unlikely, __the only reason you think you could do so is that you've heard the answer before, and it seems obvious and simple in retrospect__.  In other words, "a-ha!"

# 2. It's completely disconnected from reality

As if the above weren't reason enough for this to be a laughably bad question, you have to also ask yourself, is this even a good question for determining if this engineer has the skills they need for the job?

Let me challenge the question altogether: __why would you ever find yourself in a situation where your linked list has a cycle?__

In the real-world, what could lead to this?  I don't mean mechanically, obviously you get a cycle if you have a node whose "next" pointer is upstream of that node.  I mean, how does it actually happen in real life?

See, a Linked List is a data structure, it's not an abstract data type.  Generally you wouldn't be making a `LinkedList` class, you'd be making a `Stack` or a `Queue` or something like that.  Those would be the classes you're writing and exposing to a consumer of your class, and it would just so happen that your internal _implementation_ of those types is a linked list.  So what are the methods on your `Stack` class, for example?  `push`, `pop`, `peek`, etc?  Well, if someone is using those methods, how on earth are you going to get a cycle in your list?  They're not messing with the `next` or `prev` pointers, they're just pushing and popping with objects of some type.

Even if you wrote a `LinkedList` class for some library, you still can't find yourself in this situation.  Take a look at [Java's `LinkedList`](http://docs.oracle.com/javase/7/docs/api/java/util/LinkedList.html) class.  There is no way to manipulate the pointers for the node's next or previous references.  You can get the first, or get the last, or add an object to a specific place in the list, or remove an object by index or by value.  

Take a look at the Java source code and you'll find those next and previous pointers are here, inside of `LinkedList`:

~~~ java
    private static class Entry <E> {
      E element;
      
      java.util.LinkedList.Entry<E> next;
      java.util.LinkedList.Entry<E> previous;
      
      Entry(E e, java.util.LinkedList.Entry<E> entry, java.util.LinkedList.Entry<E> entry1) { /* compiled code */ }
    }
~~~

This is a `private static` class, inside of `LinkedList`.  You can't instantiate a `LinkedList.Entry`.  You have no way to manipulate these `next` or `previous` pointers.  Because those things are the state of the list, and __`LinkedList` encapsulates the behaviors with the state inside of the class,__ like it ought to.

If your `LinkedList` class were vulnerable to any kind of cycle creation, you've done a poor job of encapsulation.  You either have a design failure in your interface, or a bug in your implementation.  In either case, your time would be better spent addressing your error rather than coding up some kind of cycle detection mechanism.

Here's the only cycle detector you'll ever need to write for your `LinkedList`:

~~~java
public class LinkedList {
    public boolean containsCycle() {
        return false;
    }
}
~~~

There is no real situation in which this method's return value would be different than one that uses a tortoise-and-hare algorithm.

In the real world of actual coding, you'd very rarely find yourself ever needing to code up a linked list implementation from scratch, but if you did, you'd certainly have no reason to expose methods that would allow someone using your code to create a cycle.  The only way it could be done is through intentional, malicious metaprogramming or reflection of some kind, which could just as easily bypass your `detectCycle` method anyway.

# Conclusion

Many interview questions fail for one of these two reasons.  Either the question is too much of a puzzler to reasonably be solved in an interview setting, or it's so far removed from the skillset required to do the job ("how would you move Mt. Fuji") that it's useless.

This question, hilariously, suffers from both of these major problems, and it suffers from each about as hard as it possibly could.

If you're asking this question, everyone who has ever answered it to your satisfaction was merely proving they have good memory recall abilities from their Computer Science curriculum, nothing more.  Folks you turned away from the job for failing to answer this question may have been more qualified than you realize, and your company maybe should have turned you away instead.

Linked List cycle detection: just don't ask it.

Update: One commenter pointed out that if the data structure in question was a digraph where every node has an out degree of at most one, the question still applies.  Totally valid point, in that case you __are__ exposing methods that allow consumers of your structure to manually set the pointers.  That's a far more reasonable question but, again, I think you're still just asking someone how well they recall their computer science classes, or you're asking an unreasonable question in an interview, unless you're willing to accept answers with worse runtime or space complexity than the tortoise-and-hare algorithm.

