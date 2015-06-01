---
layout: post
title: Moving One Git Repository Into Another As A Subdirectory
category: Programming
tags:
- git
- scm
status: publish
type: post
published: true
---
I recently had to merge a number of independent projects into a larger project to enable a long-term project reorganization effort.  Since we're using Git for both projects, this was quite easy, but it required some investigating to figure out how to do it.

So you have two projects, `old-project` and `new-project`.  You want to end up with a subdirectory inside of `new-project` called `old-project` with all of the code from `old-project`, and you want to preserve that project's history.

Here's an overview of what we're going to do here, in the abstract:

 1. Get a local copy of the repository containing the project being pulled in
 2. Modify the local copy to move all of the files into a subdirectory
 3. Add the local copy as a fake "remote" to our larger project
 4. Pull the local "remote" in, thereby pulling the entire history along with it

For the purposes of this demonstration, `old-project` is cloned at `/home/machete/old-project` and `new-project` is cloned at `/home/machete/new-project`.

At the end of this, we want there to be a `/home/machete/new-project/old-project` with all of the commits from `old-project` intact.

The way we're going to do this, it's going to completely overlay `old-project` on top of `new-project`, so first we need to adjust the directories inside of `old-project`

~~~terminal
$ cd /home/machete/old-project
$ mkdir old-project
$ mv !(old-project) old-project
$ git commit -a -m "Preparing old project for move"
~~~

All we've done is move every file in the `old-project` project codebase into a subdirectory with the same name.  So you've now got `/home/machete/old-project/old-project`.  Then this is committed, you should see in the commit that every single file change is a rename.

This just moves all of the files in `old-project` into a subdirectory structure matching what we want to have inside of `new-project`, then makes a commit.

Next we need to copy the history of this repository into `new-project`.  So we don't have to push our temporary move anywhere, we're going to add our local directory as a remote git repository, then pull its changes in.

~~~terminal
$ cd /home/machete/new-project
$ git remote add temp /home/machete/old-project
$ git fetch temp
$ git merge temp/master
$ git remote rm temp
~~~

This pulls the entirety of old-project's history in.  This history includes a commit in which all files were moved into a subdirectory named `old-project`, so you're left with a subdirectory in `new-project` called `old-project`.

Since we did a merge, we will have a new commit at HEAD that has two parents, one for the regular `old-project` codeline, and one for the old `new-project` codeline.

That's it, you can push `new-project` anywhere and the next fetch will pull down all of `old-project`'s history.

It's also a good idea to go back to your `old-project` and make a commit that deletes the entire old-project subdirectory, write a readme indicating the project has been pulled into `new-project` and commit and push that.

