---
layout: post
title: A Stroll Through the Complexity Zoo
category: Programming
tags:
- complexity
- compsci
- school
- theory
status: publish
type: post
published: true
---
This Fall, I took a course on Computational Complexity.  I've been exposed to complexity in Computer Science before, but as an undergrad it rarely went beyond discussing P, NP, and NP-Complete.  While I enjoyed the class a great deal, I was slightly disappointed that we mostly studied some of the space complexity classes like PSPACE as well as went much, much deeper in depth on P, NP, and NP-Complete, without covering many of the other complexity classes, of which there are lots.

For a final paper, we had to pick a topic of our own choosing in Complexity Theory and research it on our own.  For my topic, I choose to explore a bunch of the other important classes in complexity theory.  I had never had any exposure to any of these classes before, so I really enjoyed this project, though I was unable to cover as many classes as I'd have liked, and none of them in as much depth as I was hoping.

{% image chp_venn_diagram-300x270.jpg align="right" caption="Complexity Classes, from Math ∩ Programming" link="http://jeremykun.wordpress.com/2012/02/29/other-complexity-classes/" %}

Nonetheless, I'm pretty happy with my paper, which provides an undergraduate-level explanation of 26 other complexity classes, based off [The Complexity Zoo](http://complexityzoo.uwaterloo.ca/Complexity_Zoo"), kept by MIT professor Scott Aaronson.  I tried to boil these classes down to the bare essentials and explain them with examples in plain english as much as I could.  The goal of the paper is to expose those new to Complexity Theory or early in their Computer Science careers to a handful of interesting classes and explain how they relate to each other, the more common classes, and of course the $$P =? NP$$ question.

You can download the paper **[here](/files/complexity_zoo.pdf")**.

Please note, this paper has not been peer-reviewed in any fashion.  It has not been (nor will it be) submitted to any academic journals, and it makes no novel contributions to the field.  It's purely an overview of other classes, a literature review at best.  I post it here in case others might find it interesting or informative, but it is **not to be cited**.  If you somehow find something valuable for your own research, I suggest you follow the citations in the paper and look up the references yourself, then use those as a source.

I also cannot stress enough how incomplete this paper is.  It only covers 26 classes, leaving out over 450.  There is a great deal of information about these classes as well as those not covered, which I do not touch upon at all.  The paper is intended as an introduction to these complexity classes, so don't be surprised if things are left out.  I tried my best to avoid errors, and I had a few corrections issued by my professor where my language was misleading (for example, claiming a problem was not in $$NP$$ when in fact it was simply not **known** to be in $$NP$$), but if you find something confusing or surprising, I suggest using the references provided, as this paper may have some mistakes.  If you find any, feel free to leave a comment and I'll correct them.

