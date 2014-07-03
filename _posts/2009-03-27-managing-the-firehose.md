---
layout: post
title: 'Managing The Firehose: Controlling RSS Through Pipes'
category: Technology
tags:
- internet
- pipes
- productivity
- tutorial
status: publish
type: post
published: true
---

I love RSS feeds.  I love the fact that I live in a time where the vast majority of sites that I find interesting have managed to export their data, updated live, in a universal format that I can pull together in a single place.  I can read what's going on with hundreds of sites I care about by visiting a single site like Google Reader, or through a single piece of software or a browser plugin.  It's great.

But this comes with a downside.  I have almost 200 subscriptions in my Google Reader account.  Many of these subscriptions are to sites, such as [Reddit](http://reddit.com") or [Digg](http://digg.com"), that themselves, aggregate other sites.  I have divided my Google Reader subscriptions along various categorical tags (such as politics, development, movies, etc) as well as priority tags (Must Read, Should Read, Can Read, Can Ignore, and Should Ignore) but even that isn't quite enough to manage the firehose of information coming my way via RSS.

I have utilized [Yahoo Pipes](http://pipes.yahoo.com") to manage this deluge of information and I thought I'd take some time to share how.  This article will serve both as a basic tutorial for using Yahoo Pipes to manage your RSS feeds as well as a place to show some specific examples I use to control my feeds that you can use as well if you subscribe to the same sites I do.

# Yahoo Pipes

Yahoo Pipes, if you've never used it, is simultaneously both intimidating and insulting the first time you use it.  You drag components around on a screen and connect them together with little paths.  It feels like you're programming in Visio or something.  Yet, even though you feel like a child dragging components around, you find yourself simultaneously overwhelmed by the number of components that exist in the system.  Yahoo Pipes is tough to get used to.

Pipes allow you to essentially define a source of data as a starting point, then run it through a series of operators and output something else when done.  But it's more than just a regular expression being run on a page - it works best with sources that consist of a list of SOMETHINGs, and the operators tend to perform their transformations on every item in the list.

The source we'll be using in this article is the RSS feed source.  Everything we do will be done to take an RSS feed with too much data, then run it through a series of filters and transformations to re-output the same feed, but with only the items we care about.

Once you have a pipe that outputs a transformed list, you can get an RSS url to the output of the Pipe itself, then subscribe to that with your feed reader in place of the original feed.  

For example, let's say that I find far too many posts in the RSS feed for [Digg.com/technology](http://digg.com/technology").  Let's say, for me, I only care about the items that relate specifically to Apple, because I'm a digg user and I love Apple to death like all good Digg users.  Rather than subscribe to the RSS feed for Digg/Technology in my Google Reader, I'll create a pipe that uses that feed as a source, filters out all of the posts that do not relate to Apple, and then subscribe to the RSS feed of my pipe.  I can even rename the subscription "Digg/Technology" in Google Reader, hiding the fact that it's even going through Yahoo Pipes.

# Basic Example: Simple Filter

Let's start with a simple filter.  I like to read [ScrewAttack.com](http://www.screwattack.com"), so naturally I wanted to subscribe to their RSS feed.  But unfortunately for me, they post new videos every day and I'm only interested in some of them.  They have many categories of videos, but the only ones I really like are "Hard News," "Jose's Puntos," and "Trailer Dump".  In particular, I hate their "SideScrollers" feature because I don't listen to podcasts.

So head on over to ScrewAttack and copy the RSS feed URL to your clipboard: [http://screwattack.com/rss.xml](http://screwattack.com/rss.xml")

Then go to Yahoo Pipes and create a new Pipe (you may need to make a Yahoo account).  Open the "Sources" menu on the left and drag the "Fetch Feed" element into your work area.  Paste the ScrewAttack RSS feed into the box.  You can now click on the titlebar of the source and see the output in the lower portion of the screen.

Now, open the Operators list and drag "Filter" into your work area.  Click on the circle at the bottom of the Fetch Feed box and drag the line to the circle on the top of the Filter box, connecting the two.

Change "Block" to "Permit" and change "all" to "any".  Underneath "Rules" click the arrow next to the leftmost box and select "item.category.content".  This makes the filter look at the item/category/content field of the RSS xml.  Leave the dropdown at "Contains" and type in "Hard News" into the box on the right.  Click "Refresh" in the output preview at the bottom and you'll see that the recent Hard News posts (and only those) show up.

Now click the plus icon next to "Rules" to create another rule.  Select the same thing for the left drop down (for the category) but put "Trailers" in the right.  Do it again for "Jose".  Click refresh again and you'll see the interesting stuff on the site only.  You can obviously customize this however you wish if you care about different categories.  

Last, drag the circle at the bottom of the "Filter" box to the circle at the top of the "Output" box.  Your pipe is now done.  Click output and see a preview of what your pipe outputs.

<img src="assets/picture-2.png" alt="" title="Screwattack Pipe" width="500" height="153" class="aligncenter size-full wp-image-317" />

Save your pipe in the upper right corner.  A flare will pop up at the top telling you it's been saved.  Click 'Run Pipe' and you will be brought to the Yahoo Pipes interface for a running pipe.  Click "Get an RSS" and you have your new RSS feed URL.  Feel free to change the name of your pipe if you wish at any time, the RSS feed URL never changes.

Please note that this RSS feed is PUBLIC (it has to be if you want to subscribe to it through something like Google Reader), but not LISTED.  If you publish your feed it will show up in the searchable feeds database on yahoo.  But don't make pipes out of private data.

The later examples will be less more complex and less detailed.  Play around with Yahoo Pipes to see what you can do if you are not already familiar.

# Reddit Filter: Only Talked-About Posts

One of the reasons I generally prefer [Reddit](http://www.reddit.com") to [Digg](http://www.digg.com") is that I find the conversation on Reddit to be a bit more intelligent.  The top comment is usually some snarky one liner, and the second comment is usually some joke or reference to a meme, but after that there's usually some interesting conversation.

As a result, the way I'd like to limit my Reddit RSS feeds is by only selecting the the posts that reach a certain threshold of comments.  This number is different for the different subreddits I read (less popular subreddits need fewer comments to be considered talked-about than, say, the front page).

Let's construct a filter for the [programming subreddit](http://www.reddit.com/r/programming/") (or "proggit") using the RSS feed [http://www.reddit.com/r/programming/.rss](http://www.reddit.com/r/programming/.rss")

If we create a feed source and look through the structure of the object that Pipes has to work with, we can see that in the "Description" element is a link to comments, and it contains the number of them.

{% image picture-3.png %}

What we're going to do is construct a regular expression that pulls that information out, and only permits posts with more than 20 comments.

Create a "Loop" element and connect the output of the feed to the input of the loop.  The loop allows you to perform an operation on every item in the feed and save the result to a new element in the feed (or overwrite an existing one).  This allows you to add information to the feed that it didn't have, which you can then use in subsequent filters.

Drag the "String Regex" element into the inside of the loop and tell it to replace the regex `.*?(\d*) comments?.*` with `$1`.  Since the number of comments is the capturing group, it is essentially just extracting the number of comments.  Tell the loop to assign the the result to "item.comments".

Now your feed has a "comments" element that contains the number of comments on the post.  Pipe the output of the loop to a new "Filter" element and tell it to permit only items that have item.comments greater than 20.  Connect that to your output and voila, you've got a version of the programming reddit RSS feed that only shows the items with more than 20 comments.

{% image picture-5.png %}

If a post that was filtered out because it had, say, 5 comments, were to become more popular and get 21 comments, it would start showing up in the feed (and therefore in your reader).

You can make this pipe even more useful by introducing User Inputs.  User inputs let you send parameters to the feed, which can then be used by the pipe.  For our case, it would be handy to provide the url of the subreddit as a parameter, as well as the number of comments for the inclusion threshold.

Drag a new user input URL element into the work area.  Give it the name "redditurl" and the prompt "URL to Reddit RSS Feed".  Paste the programming reddit RSS feed into the "debug" field.  This allows you to test out that your feed is still working correctly, but when you re-use the pipe it won't use the value in the field.  Pipe the output of that input into the small box to the right of the field in the "Fetch Feed" box.  Your pipe should still be working as normal if you check the output, but if you paste a different reddit rss feed URL into the debug box and click refresh, you'll have a new set of filtered data.

If you run the pipe, you'll now see that you are prompted to input the feed URL before you can run the pipe.  If you paste the feed in here and run the pipe, you can grab the RSS feed for just that subreddit.  If you paste a different RSS feed URL into the box, you will get the filtered feed for a different reddit.

You can do the same thing with a "number input" to control the comment count threshold.  You could also use the "Sort" operator to sort by the number of comments, moving the more popular items to the top.

{% image picture-7.png %}

If you don't want to bother going through all this work, you can feel free to simply use my published version of this pipe [here](http://pipes.yahoo.com/rodhilton/redditfilter").

# Digg Filter

Very much like Reddit, Digg is a link aggregation site that allows users to vote links up or down.  However, for me, the Digg comments aren't as valuable as Reddit comments, so I'm more interested in links based on the number of Diggs they receive, rather than the number of comments they have.

Handily, the Digg RSS feeds actually include the number of Diggs that items have received in the XML, so we can key off that to build a new pipe.  The element can be found at `item.digg:diggCount`, so all you need is a filter that permits entries with a high enough diggCount.  In the example below, I've also included a sorting mechanism.

{% image picture-8.png %}

As with the Reddit filter, you may feel free to just use the pipe that I've published [here](http://pipes.yahoo.com/rodhilton/diggfilter").

# DZone Filters

DZone is like Reddit and Digg, but geared specifically toward software developers.  Just like Reddit and Digg, you can key off of certain elements in the RSS feed XML to determine how popular an item is and filter accordingly.

DZone is slightly more complicated, however, because there are actually two different kinds of sites on DZone.  First, there are different Zone's, such as [Agile Zone](http://agile.dzone.com/"), where you can key off the number of times a post has been read. Then there are the links collections, such as [Agile Links](http://www.dzone.com/links/tag/agile.html") which is more like Digg/Reddit and you can key off the number of votes.

The first type is relatively simple, so I won't even cover it (it works just like the Digg filter, but keying off the number of reads embedded in the feed).  You can use mine [here](http://pipes.yahoo.com/rodhilton/dzonefilter ").

The Links feeds are more interesting.  Even though the site displays the "net vote", the XML only contains the number of up votes and the number of down votes.  That means you need to do the subtraction in your pipe to get the actual net vote count.

We're going to do the subtraction in a loop and assign the results to a new element, then filter by that.

{% image picture-9.png %}

As usual, you can just use mine [here]( http://pipes.yahoo.com/rodhilton/dzonelinksfilter") if you wish.

# Conclusion

Digg, Reddit, DZone, and feeds in which I only care about a subset of the entries make up a major chunk of my RSS subscriptions.  Replacing those subscriptions with hand-tuned versions of feeds coming out of these pipes allowed me do a great deal toward managing the firehose.

Yahoo Pipes can do a lot more than I've covered in this post, and I encourage you to experiment with it.  If you make a particularly interesting (and generic, reusable) pipe, feel free to post about it here in the comments.

