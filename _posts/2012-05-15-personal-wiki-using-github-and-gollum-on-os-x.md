---
layout: post
title: Personal Wiki using GitHub and Gollum on OS X
category: Technology
tags:
- code
- git
- github
- gollum
- mac
- os x
- personal
- productivity
- ruby
- scripts
- wiki
status: publish
type: post
published: true
---
I've been struggling for a while to get a good personal wiki solution going.  I have a bunch of requirements that have made this quite difficult:

 * Access and edit wiki from browser
 * Run in OS X (Laptop) and Linux (Workstation)
 * Synchronized across all machines
 * Can use offline

I tried using [TiddlyWiki](http://tiddlywiki.org/") with DropBox as the cloud-based sync mechanism, but I use Google Chrome as my browser, which has a lot of trouble with the Java plugin that does the saving.  There are command line arguments for Chrome that fix this, but that's weirdly difficult to deal with on OS X.

So my final solution, subject to improvement, is to use [Gollum](https://github.com/github/gollum").  Gollum is a Ruby-based wiki server that runs completely self-contained (you don't need to install PHP or a database) and is backed by Git.  I use a Git repo cloned off a private [GitHub](http://www.github.com") repository for sync functionality.

There are a number of steps to getting this set up, so I've decided to document them here, both for the benefit of anyone else who wants to do this, as well as for myself if I have to set it up on another machine.

These instructions are geared toward OS X, largely because I found it more difficult to set up on OS X than Linux, simply because OS X's support for scheduled and startup script running is clunky and stupid.

# GitHub

The reason I like [GitHub](http://www.github.com") for backup/sync is that their web interface has a built-in editor that supports [Markdown](http://daringfireball.net/projects/markdown/syntax"), the same Wiki syntax I'm using in Gollum (Gollum actually supports many different formats, but Markdown is one of the easiest to install).  This means I can view, edit, and preview using the GitHub web interface alone, in case I need to access my wiki data from a machine that does not have Gollum set up, but does have a web browser.  My smartphone, for example.

A private repository on GitHub will cost you $7 per month, which is a little pricey if all you're going to do is have a personal wiki stored there.  You could open source your wiki to get around this, or you could also use [BitBucket](https://bitbucket.org/"), which offers free private git repos, but doesn't have the slick web interface for viewing or hand-editing the markdown files Gollum uses.

In any case, get a Git repo set up on either GitHub or BitBucket.  Since I think GitHub is better for this purpose, I'll be using `git@github.com:rodhilton/personalwiki.git` as my repository URL.

# Gollum
The easiest way to install Gollum in OS X is to run `gem install gollum`.  This requires that you have Ruby and RubyGems set up correctly.  OS X 10.5 and up have this already, so this shouldn't require any work on your part.

Once Gollum is installed, you need to install support for a wiki syntax.  I'm using Markdown, so I run `gem install redcarpet`.  Instructions for how to use alternative formats can be found in the [Gollum installation README](https://github.com/github/gollum#installation").

Now, clone your personal wiki somewhere handy.  I'm putting it in my home directory, so I merely run `git clone git@github.com:rodhilton/personalwiki.git` from Terminal in `~`.  This will check things out at `~/personalwiki`.  Change into that directory and run `gollum`.  You should see something like:

~~~output
== Sinatra/1.3.2 has taken the stage on 4567 for development with backup from Mongrel
~~~

Open a browser and load `http://localhost:4567` to verify things are working correctly.

 > **Pro-tip:** Gollum allows you to create files called `_Footer.ext` and `_Sidebar.ext` in the root of your repo that will show on every wiki page, where `.ext` is the extension for the wiki format you're using.  In Markdown's case, `.md`.  The files must be added and committed by hand.

</blockquote>
## Alternative Installation

I often find that installing gems under rvm and then trying to run those gems outside of the shell (like, at login) gives me trouble.  Another way to install Gollum, and the method I'm using on one of my machines, is to check it out from source and use [bundler](http://gembundler.com/").

To do this, clone the [Gollum repo](https://github.com/github/gollum") to somewhere on disk, such as `/usr/share/`.  Then in `/usr/share/gollum`, run `sudo bundle install`.  This will install everything you need.

When I need to reference the absolute path of gollum, it's now `/usr/share/gollum/bin/gollum` so I can work around rvm's oddities.

# Synchronization with GitHub

Gollum makes local commits only, it doesn't push those commits to any remotes.  This means that nothing is going up to GitHub yet, which prevents me from synchronizing across multiple computers.

To solve this, we're going to periodically run `git pull && git push` from our repository.  This will pull any outstanding changes and push any local changes up to GitHub for us automatically.

There is potential here to get merge conflicts.  If I were to edit a wiki entry in Linux, then switch to my Mac and edit the same file, I'm going to get a merge conflict that prevents the sync from executing. This kind of conflict requires manual intervention, but since I'm running the sync commands non-interactively, I wouldn't see this happen and know to fix it.  To mitigate this problem, I'm going to have the sync command run every 60 seconds.  This makes the window for getting a merge conflict very small, though having a machine disconnected from the internet for an extended period of time enlarges this window considerably.

Gollum stores each wiki page in a separate file and uses a very simple markdown syntax for them all.  There are no database files being shared or single-file indexes, so a conflict can only arise by editing the same wiki page, in approximately the same place.  Otherwise Git will be able to merge the files and handle things without intervention.  So far, I have not actually gotten a merge conflict that needed to be dealt with manually, so the windows seem small enough.

In any case, I've added a script to my `~/personalwiki` named `.sync.sh` which looks like this:

~~~bash
DIR="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
(cd $DIR && git pull && git push)
~~~

What this is doing is figuring out the directory of the `.sync.sh` script itself, changing to it, then running git pull (to pull any changes from GitHub) and then git push (to push any changes back up to GitHub).  Make sure to set the script to executable by running `chmod a+x .sync.sh`.  Also make sure to make a local commit of this file (otherwise, ironically, it won't be able to run itself since your git working tree is dirty) by running `git add .sync.sh && git commit -m "Sync script"`.

This script can be run from anywhere (this is important) and it will sync the wiki.  Now it needs to be set to run periodically.  On OS X, we're going to use Apple's incredibly stupid and terrible [launchd](http://en.wikipedia.org/wiki/Launchd"), because [crontab has been deprecated](http://apple.stackexchange.com/questions/12819/why-is-cron-being-deprecated") for reasons that are behind my comprehsion.

Add a file called `com.personalwiki.sync.plist` to `~/Library/LaunchAgents/` which looks like this:

~~~xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>Label</key>
  <string>com.personalwiki.sync</string>
  <key>RunAtLoad</key>
  <true/>
  <key>ProgramArguments</key>
  <array>
    <string>/Users/air0day/.wiki/.sync.sh</string>
  </array>
  <key>StartInterval</key>
  <integer>60</integer>
</dict>
</plist>
~~~

You can have this run more often by decreasing the "60", obviously, but per-minute seems fine for me.

# Running Gollum on Startup

First, we're going to make a script that runs Gollum for us.  Place a script in `~/personalwiki` named `.gollum.sh`:

~~~bash
DIR="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
/usr/bin/gollum --css $DIR
~~~

Again, the goal here is that the script can run from anywhere, so it has to first figure out where it is, then run Gollum on that path.  It's a good idea to provide an absolute path to the `gollum` executable, particularly if you are using `rvm` or something similar.  To get this, just run `which gollum` to see where gollum is running from, then use that path.

If you want gollum to run on a different port, you can add --port [number] like so:

~~~terminal
$ /Users/your_name/.gem/ruby/1.8/bin/gollum --port 7890 $DIR
~~~

Again, make sure you make this script executable (`chmod a+x .gollum.sh`) and commit it to your git repo (`git add .gollum.sh && git commit -m "Gollum script"`).

Now we need to make this script run at startup.  There are lots of ways to run things on startup in OS X.  I think LoginHooks are dangerous because they are difficult to track down, so we're going to stick with OS X's abysmal launchd nonsense.

Place a file named `com.personalwiki.gollum.plist` in `~/Library/LaunchAgents/` which looks like this:

~~~xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>Label</key>
  <string>com.rodhilton.gollum</string>
  <key>ProgramArguments</key>
  <array>
    <string>/Users/air0day/.wiki/.gollum.sh</string>
  </array>
  <key>RunAtLoad</key>
  <true/>
</dict>
</plist>
~~~

God that's hideous.  `/etc/init.d/` too good for you, Apple?

Anyway, you should now be able to log out and back in, and have everything work.

# Testing and Troubleshooting

When you log back in, open up `http://localhost:4567` and make a change.  Within a minute, this change should show up in your GitHub account.  If it doesn't, launch "Console" from Spotlight, and type "personalwiki" in the filter to see if there were any problems running your scripts.

{% image Screen-shot-2012-05-15-at-11.45.56-AM-580x83.png link="http://www.nomachetejuggling.com/files/Screen-shot-2012-05-15-at-11.45.56-AM.png" %}

That should do it, now you've got a GitHub-synced personal wiki.  I actually run two on my machine (that's why I included the bit about the port) one for personal wiki stuff which backs to my GitHub account and one for work-related stuff which backs to my corporate GitHub Enterprise account.  I make sure these always run on the same ports on every machine, so I've got bookmarks in my browser bar that always work across machines.

So far I'm pretty pleased with this solution.  I wish it was easier to sync via Dropbox instead of Git but the benefit of Markdown support in GitHub almost turns this con into a pro.