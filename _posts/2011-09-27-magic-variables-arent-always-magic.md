---
layout: post
title: Magic Variables Aren't Always Magic
category: Programming
tags:
- code
- discipline
- engineering
- practices
- rules
status: publish
type: post
published: true
---
Software development is a strange beast sometimes.  Despite the fact that it is [not predictable enough](http://www.artima.com/intv/garden.html") or [constant enough](http://www.cs.usfca.edu/~parrt/doc/software-not-engineering.html") to qualify as true engineering, it's often referred to as Software Engineering anyway.

There are no rules in software development.  Some suggest the existence of [best practices](http://www.ibm.com/developerworks/websphere/library/techarticles/0306_perks/perks2.html"), but really there are only guidelines and recommendations.

Despite these truths, there are a number of alleged "rules" in software development, often suffixed with "[considered harmful](http://en.wikipedia.org/wiki/Considered_harmful")" as a reference to Edsger Dijkstra's famous "[Go To Statement Considered Harmful](http://www.cs.utexas.edu/users/EWD/ewd02xx/EWD215.PDF")" essay.  I want to look at one of these rules a bit more closely.

# Magic Constants Considered Harmful
"Magic Constants," also often referred to as "Magic Numbers" break what is regarded as one of the oldest "rules of programming", dating back as far as the manuals for COBOL and FORTRAN in the 60's.

Magic Numbers are numbers that are used and re-used in code.

~~~c
salePrice = 0.90 * regularPrice;
~~~

Above is a simple example.  The usage of `0.90` is generally regarded as bad.  Instead it should be replaced with something like this:

~~~c
const double DISCOUNT_PERCENT = 10;
const double DISCOUNT_FACTOR = 1 - (DISCOUNT_PERCENT / 100);

// ...

salePrice = DISCOUNT_FACTOR * regularPrice;
~~~

It's hard to argue with this reasoning.  The second code snippet is easier to read and easier to modify.  In this case, this seems like a no-brainer.  This is how "rules" are created.

# Why Is It Harmful?

A lot of times, once a best practice or a rule becomes codified in the industry, it stops being questioned.  The **why** is forgotten over time, and it just becomes a rule that everyone follows blindly.  Sometimes it's helpful to remind ourselves of the reasons for a best practice, to avoid becoming [Cargo Cult Programmers](http://en.wikipedia.org/wiki/Cargo_cult_programming").

Why is the first code snippet bad?  

 * **It has no name** - It's not immediately clear to the reader of the code why the 0.90 is there.  The variable `salePrice` gives a good hint, but it takes a bit of inferring.  The second snippet labels the value clearly as `DISCOUNT_FACTOR`, which is much clearer.
 * **It's reused** - Though not directly reused in the example, it's easy to imagine repeated usages of the `0.90` value.  This repetition is less than ideal, particularly because...
 * **It can change** - If we start offering a 15% discount instead of a 10% discount, we'd have to find every usage of `0.90` and replace it with `0.85`.  It's much easier to change it in just the one place.

# Don't Go Overboard

Not too long ago, I came across some code that made me realize that this rule is perhaps followed to the letter without being followed in spirit.

The code has been slightly modified to protect the guilty.

~~~java
class Example {
  private static final String FORWARD_SLASH="/";

  public String getUrlPath() {
    return FORWARD_SLASH + "books" + FORWARD_SLASH + "all";
  }
}
~~~

When I first came across this code, my instinct was to replace it with a simple

~~~java
    return Joiner.on(FORWARD_SLASH).join("books", "all");
~~~

This seemed so reasonable to me at first, plus I get pumped every time I get to use anything in [Google Guava](http://code.google.com/p/guava-libraries/").

But then I thought about it.  This is following the letter of the "don't use Magic Constants" rule, but is it following the spirit of it?

The `"/"` has been extracted to a constant, so now it has a name.  But is the name descriptive?  No, the name is simply `FORWARD_SLASH`, which is about as descriptive as if in the first example we had simply done `const double POINT_NINE_ZERO = 0.90;`.

The constant is clearly being used as part of an HTTP request of some type, so how likely is it that the next version of HTTP would use a new character for path separation?  It's beyond unlikely, so the fact that this constant is easy to change doesn't seem to buy anything.

It's also significantly more to type and read. `return "/books/all"` is 35 fewer characters and much easier to read.

So what about when the constant is reused?  That's actually the most significant problem of all.

Imagine a second class, `Example2`:

~~~java
public class Example2 {
  private static final String FORWARD_SLASH = "/";

  public String getPath() {
    return FORWARD_SLASH + "directory" + FORWARD_SLASH + "file.txt";
  }
}
~~~

Someone may notice the repeated constant and pull them both into a `Constants` class, using `Constants.FORWARD_SLASH` in both `Example` and `Example2`.

Now we're really guarding against change.  If that changes, we can fix both classes by changing only `Constant`!

Except, now you're really screwed.  Even on the off-chance that HTTP changes its path separator character, or in the more likely case that you move your deployment environment from Unix to Windows, you haven't saved yourself any time.  Why?  **Because these won't both change at the same time**.

If that happened happened, you'd have to re-split the usages of these constants so that you were only changing, say, the file path separators but not the URL path separators.  You actually have to modify even more code, not less.  It would be far easier to have used `"/"` in both files, then done a simple regex replace on the relevant files in the unlikely event that the character had to change.

# Don't Follow Rules Blindly

The code example I've provided wasn't made up for the post, it's real.  That means that some of my peers felt like it would be bad code to have simply used the forward slash character inline.  There's no way around it, this comes from internalizing rules without internalizing reasons.

I don't mention this code because I'm specifically bothered by overuse of the "Extract Constant" IntelliJ shortcut, or because I want to pick on old co-workers (though it is fun).  I mention it because, for me, it exemplifies the danger (and hilarity) of following "rules" without giving them due consideration.

Any time you find yourself doing something because it's the "right" way, stop and make sure you understand the reasons for that best practice.  Take two seconds and make sure those reasons still apply, otherwise you'll wind up writing code that might embarrass you later on.

Your code should strive to maximize readability and maintainability.  If that goal is at odds with the occasional "rule", break the rule.  

