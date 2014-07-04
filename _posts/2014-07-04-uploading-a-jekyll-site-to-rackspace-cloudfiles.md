---
layout: post
title: Uploading a Jekyll Site to Rackspace Cloudfiles
category: Programming
tags:
- code
- cloud
- web sites
- open source
- hosting
- web
status: publish
type: post
published: true
---

This blog was never intended to be popular by any stretch of the imagination.  Largely I started it simply to have a place to gather solutions to technical problems I've encountered, so that I could easily look those solutions up if I needed them again.  The blog has always run on my own shared hosting server, on a self-installed version of Wordpress.

To my great surprise, a [few](http://www.reddit.com/r/programming/comments/2986e4/the_worst_programming_interview_question/) [of](http://www.reddit.com/r/programming/comments/hn1fx/a_different_kind_of_technical_interview/) [my](http://www.reddit.com/r/programming/comments/yvr9/my_interview_with_google/) [posts](http://www.reddit.com/r/TrueReddit/comments/q98ld/the_star_wars_saga_suggested_viewing_order_iv_v/) have found their way to the front page of [reddit](http://www.reddit.com/domain/nomachetejuggling.com).  My [post about Star Wars]({% post_url 2011-11-11-the-star-wars-saga-suggested-viewing-order %}) has been mentioned on [King of the Nerds](https://www.youtube.com/watch?v=effD1u4oCRE) and [The Big Bang Theory](https://www.youtube.com/watch?v=keSFjjhUyVA), and even landed me an [Interview on NPR](http://www.npr.org/2014/03/20/291977042/theres-more-than-one-way-to-watch-star-wars).  

{% embed %}
<script type="text/javascript" src="//www.google.com/trends/embed.js?hl=en-US&q=Machete+Order&cmpt=q&content=1&cid=TIMESERIES_GRAPH_0&export=5&w=600&h=330"></script>
{% endembed %}

Needless to say, the traffic to my blog has been both extremely unexpected and unpredictable.  The Star Wars post had been online for months with virtually no traffic before [Wired](http://archive.wired.com/geekdad/2012/02/machete-order-star-wars/) suddenly linked to it, instantly decimating my web server.  I've fought and fought with various configurations for Wordpress, used [as much caching](http://wordpress.org/plugins/w3-total-cache/) as possible, and even had my [web host](https://www.servint.net/) temporarily upgrade my service, all trying to keep a web site that makes no money online even when traffic increases by a factor of 100 overnight.  **When my site goes down, it's embarrassing, because even though it's just a personal blog on a shared host, it gives the impression that I, as a software developer, don't know how to make a web site scale**.

# Switching to Jekyll

So after the most recent pummeling I took due to a [Hacker News link](https://news.ycombinator.com/item?id=7953725), I decided it was time to **bite the bullet and convert the entire site to [Jekyll](http://jekyllrb.com/)**.  I've messed around with the technology before to build another, smaller, blog, so I was somewhat familiar with the constructs and idioms.  A lot of work and ten custom plugins later, the entire site was converted, with very little loss of functionality.

{% image jekyll-logo.png align="right" %}

I didn't want to serve the files from my shared host because I know firsthand that the traffic spikes I experience are often enough to overwhelm apache itself, and I couldn't host it with [GitHub Pages](https://pages.github.com/) due to the aforementioned ten custom plugins.  I've used both Amazon S3 (to host the smaller Jekyll-based blog) and Rackspace Cloudfiles (as a CDN for the Wordpress version).  Of those two, I find Amazon S3 to be extremely overcomplicated and difficult to work with, but there's a great [S3_Website](https://github.com/laurilehmijoki/s3_website) gem that makes uploading a Jekyll blog a snap.  Rackspace Cloudfiles is much more straightforward to work with, but the [Python script](https://github.com/nicholaskuechler/jekyll-rackspace-cloudfiles-clean-urls/blob/master/cloudfiles_jekyll_upload.py) that [even Rackspace itself](http://www.rackspace.com/blog/running-jekyll-on-rackspace-cloud-files/) links to has given me various dependency issues.

In the end, Rackspace Cloudfiles is a bit cheaper per GB than Amazon S3, and since this blog receives a nontrivial amount of traffic, that became the deciding factor.  Since I always had issues with the python script that uploads a Jekyll blog to Cloudfiles, I decided to do some research into alternative means of automated uploading ([Cyberduck](http://cyberduck.io/) works, but I wanted something that I could make Jenkins run).

Unfortunately, **almost everything I found wound up linking to the exact same Python script that gave me trouble**.  So I decided to write my own, which I'm open-sourcing for the benefit of anyone else that has had similar problems.

# jekyll-cloudfiles-upload

[jekyll-cloudfiles-upload is hosted on GitHub](https://github.com/rodhilton/jekyll-cloudfiles-upload) and is a single Ruby script that can be dropped into your Jekyll blog project directory.  It will look in `_site` for all of your static site files, compare them to what is in your Rackspace Cloudfiles container, upload any that need updating, and delete anything in the container you no longer have.  It only has a few small dependencies (ruby and a ruby gem named `Fog`), and I've been using it to update this blog with great success.

## Installation and Usage

 1. Log into Rackspace Cloud Files and create your container.  _You must create your container first, the script will not do that_.

    > **Pro-Tip**: Before you upload anything, set your container's TTL to something other than the default, which is 72 hours.  Once a file is loaded into the CDN, it seemed to me that, even if you changed your container's TTL after the fact, the TTL change itself wouldn't propagate until after 72 hours.  Changing it first (I use 15 minutes) before uploading files seemed to fix this issue.

 2. Install `fog` rubygem via `gem install fog`

 3. Put a `.fog` file in your home directory that looks like this (it's a yaml file, be careful not to use tabs instead of spaces):

    ~~~yaml
    default:
        rackspace_username: your_user_name
        rackspace_api_key: your_api_key
        rackspace_region: your_preferred_region
    ~~~

    The rackspace regions are strings like 'iad' or 'dfw', depending on your preferred container region.  You can get your api key from the Rackspace control panel's Account page.

    If you have multiple sites with multiple containers all in different regions, you'll have to hand-alter the script so that it doesn't look up this information in Fog, but just hardcodes it instead.  If you do this, I suggest using the ruby symbol syntax in the `cloudfiles_upload.rb` script, such as `:iad`.

 4. Copy the `cloudfiles_upload.rb` script from the GitHub repository into the directory for your Jekyll project.  It's a good idea to also make it executable via `chmod a+x cloudfiles_upload.rb`

 5. Build your site via `jekyll build`

 6. Execute `./cloudfiles_upload.rb container_name` or `ruby cloudfiles_upload.rb container_name`.

    The script will spider through the `_site` subdirectory and look for any files that need to be added, deleted, or updated.  Only files whose md5 hashes differ will from those in the container will be uploaded, so it will not upload files unnecessarily.

    **Note**: You may optionally leave off the `container_name` parameter, and the script will use the name of the directory you are in.  So if you name your directory and container `mysite.com`, you can just run `./cloudfiles_upload.rb` with no arguments.

    > **Pro-Tip**: Add `cloudfiles_upload.rb` to your `_config.yml` file's exclusion list so it doesn't get uploaded.


# Dogfooding

I offer no guarantee of support on this script, but I can assure you that I'm dogfooding the hell out of it.  I set up a private Jenkins instance that watches for changes to my private [BitBucket](https://bitbucket.org/) repository that contains this blog.  The repository has `jekyll-cloudfiles-upload` as a submodule, with the `cloudfiles_upload.rb` script symlinked to the submodule's version.  Any change to the blog pulls down the most recent copy of the script, builds the blog, and then runs the script to upload it.

I liked this solution so much that I wound up converting the smaller blog that I had been running on Amazon S3 over to Rackspace Cloudfiles as well.  I also have a Jenkins job that looks for changes to the `jekyll-cloudfiles-upload` project, and automatically kicks off the jobs for both web sites whenever it changes as well, so this script is definitely instrumental to a process that controls a web site whose downtime personally embarrasses me a great deal.  Again, no guarantees, but I'm putting a lot of trust in this script, for whatever that's worth.


# Jekyll Thoughts

So far, I'm digging Jekyll a lot.  I'd used it before for the smaller blog as I mentioned, but that was my first, so I used [JekyllBootstrap](http://jekyllbootstrap.com/) thoroughly.  It was good for getting set up, but I found making modifications to themes and general customization quite perplexing and difficult.  This time, I built everything from scratch, including all of the custom plugins I'm using, and I have a much better understanding of how Jekyll works.

The only thing I had to give up was the rightmost sidebar.  Previously, that area actually showed my latest tweet, and various updates from my Goodreads, Trackt, Last.fm, Groovee, and Diigo feeds.  Those used the [Better RSS Widget](https://wordpress.org/plugins/better-rss-widget/) Wordpress plugin, and I liked the feature but it would occasionally have trouble pulling feeds, causing it to leave an error on the cached version of a page for hours until the cache cleared.  I'm alright with my sidebar-o-social-icons that I replaced it with, though.

**I love writing posts in Markdown**.  I've always wanted to be able to do that with Wordpress, but found that plugins which supported it were generally terrible.  I wish it was easier to make custom alterations to the markdown processing, but [Jekyll Tags](http://jekyllrb.com/docs/plugins/#tags) are a decent workaround.  Like I mentioned earlier, I've got a lot of custom plugins gluing this site together, but I'm happy with the readability of my markdown source files, and I like that there's an abstraction layer translating those to HTML rather than embedding HTML directly into posts or writing Wordpress shortcode processors.

I may eventually put some of these plugins into GitHub as well, and I wound up writing a pretty handy extension to [highlight.js](http://highlightjs.org/) that makes it easier to copy and paste syntax highlighted code which I think others might find useful.  But easily, the most useful thing I wrote to support this effort - aside from a highly customized script that ran my blog post's html files through forty regular expressions to convert them to markdown - was the `cloudfiles_upload.rb` script.  Hopefully others may find it useful as well.
