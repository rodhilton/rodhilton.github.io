---
layout: post
title: What's the Big O?
category: Programming
tags:
- compsci
- algorithms
- complexity
status: draft
type: post
published: false
---

I've often heard look at an algorithm or some code and ask "what's the Big-O of function?"  This question is extremely common in interviews, shortly after some poor interview candidate sketches some code onto a whiteboard to solve some weird puzzle.

What's funny is that this question makes basically no sense, and can only be formulated by people who don't really know that much about Big-O notation in the first place.  I'm not saying it's particularly egregious a misunderstanding, and I'll even concede that the distinction I'm about to make is extremely pedantic in nature, but the people who are always asking about Big-O always seem to want to appear knowledgeable about these kinds of things, which makes it ironic that the very question indicates they are not.

Big-O notation, written as $$O$$, is a way of describing the worst-case upper bound of a function.  A function with $$O(n)$$ runs, in the worst-case, in linear time.  One with $$O(2^n)$$ runs, in the worst case, in exponential time.

People generally know this, but they often seem to forget just how exact the phraseology here is.  They walk away with this fuzzy notion that "Big-O means approximately how fast something is" without realizing that there are two very important phrases in the definition above:

 1. Worst Case
 2. Upper Bound

# Worst Case

Big-O is used to describe the worst possible case for an algorithm.  Meaning, if the inputs happened to be tuned exactly to make the algorithm take as long as possible, that's what Big-O describes.

As a simple example, everyone knows that "bubble sort is bad" but "quick sort is good", right?  Well, as it happens, they both have the same Big-O runtime.  When you do quicksort, you are picking a pivot point somewhere in your array, and then you're swapping elements between the two sides around the pivot so that, when you're done with one iteration, you know everything to the left of the pivot is less than it, and everything to the right of the pivot is greater than it.  Then you take the two halves and quicksort them recursively, until you're working on subsections of the array so small that you can determine if they are sorted or not




FUCK THIS IS WRONG.  the average case for quicksort is O(nlogn), it's still O.https://en.wikipedia.org/wiki/Quicksort


If you had an algorithm

<p>people always ask "what is the big-oh" but this question is useless.  big o is upper bound.  if you ask me the big -oh of anything, I can tell you O(infinity) and I'm correct.  What you're really asking for is the big-theta.</p>
<p>big omega is lower bound.  everything is omega(1)</p>
<p>Big O and Big Omega are for when I tell you about an algorithm.  I give you an algorithm, and I tell you, "dont worry, worse case its bounded by a polynomial, O(n^3)".  r I might say, here's an algorithm, but it's Omega(n) meaning it cannot possibly take less time than linear.</p>
<p>Big Oh and Big Omega are things whose only purpose is for me to TELL you about them, when volunteering the algorithm itself.</p>
<p>If I were to ASK you, I'd be wanting the big theta.  This means tight bound, upper and lower.  </p>
