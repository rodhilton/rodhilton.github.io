---
layout: post
title: Ubuntu, Tomcat, Jenkins, Git, and SSH Together
category: Programming
tags:
- code
- Continuous Integration
- git
- java
- jenkins
- linux
- ssh
- tomcat
- ubuntu
status: publish
type: post
published: true
---
I recently wanted to set up Jenkins on my personal workstation to manage builds for side and personal projects.  I was already running Tomcat on the system since I use that to run Subsonic, so I wanted to install Jenkins in the same container.

The process of getting everything working was just short of a nightmare, but I managed to eventually get my Jenkins inside of Tomcat successfully checking out and building projects through Git.  While I was dealing with various errors, I was doing a lot of Googling.  My searches seemed to indicate that very few people were trying to set things up as I was, because the internet was very little help.  When hours of Googling turns up nothing, you know you either have a) a technical problem that nobody else has tried to solve or b) a weird fetish.

So I've written this post to explain how to set things up.  But rather than a simple tutorial, I've written it as a step-by-step account of the various difficulties I had setting it up.  I've done this partially to draw a little bit of attention to a gap in the error messaging of these tools, but mostly so that the next person who Googles for specific error messages may come across this page and avoid some headaches.

Ultimately, what I wanted was Jenkins installed in Tomcat running as a system service in Ubuntu to be able to check out projects via Git repositories via the SSH protocol.  I will assume you already have Git installed because it is awesome, but if not it's as easy as using your package manager.

# Install Tomcat

So first, the easy stuff:

~~~terminal
$ sudo apt-get install tomcat6
~~~

The out-of-the-box Tomcat configuration was fine for my purposes, though it's worth mentioning that if your server is going to be accessed remotely, you may want to change the default Tomcat port.

To do this, you have to modify the Tomcat configuration a bit.  One of the things I dislike slightly about installing packages from the Ubuntu repository is that I never know what the default paths are.

In this case, here are the paths you might care about:

 * `/var/lib/tomcat6` - These are the Java-y files for Tomcat.  If you were to just extract Tomcat's tar file and run it as a local user, these are the files you'd mostly be looking at.
 * `/usr/share/tomcat6` - These are the more Linux-y files for Tomcat.  Tomcat's binaries, shell scripts, bootstrap files, etc.

The default port for Tomcat is in it's `server.xml` file, which you will find in `/var/lib/tomcat6/conf` (this is actually a symlink to `/etc/tomcat6` but I won't tell if you won't).

Do a little `sudo service tomcat6 restart` and check `http://localhost:8080` in a browser to make sure your Tomcat is okay (obviously, if you changed your port, go there instead).

# Install Jenkins
We will be deploying Jenkins not as a standalone server, or even using the Ubuntu repository's version (it has one).  That means we need the war file.  Go [download](http://mirrors.jenkins-ci.org/war/latest/) it.

Deploying a webapp to Tomcat is more Java-y than Linux-y, so copy the war file to `/var/lib/tomcat6/webapps`.  As long as the war file is readable, Tomcat will extract it into a new directory of it's own creation, so this should go pretty smoothly.

If you check `http://localhost:8080/jenkins` now, you'll get your first error:

~~~output
Unable to create the home directory '/usr/share/tomcat6/.jenkins'. This is most likely a permission problem.

To change the home directory, use JENKINS_HOME environment variable or set the JENKINS_HOME system property. See Container-specific documentation for more details of how to do this.
~~~

Jenkins depends on an environment variable called `JENKINS_HOME` being set.  Most solutions for this offered by the internet suggest setting the `CATALINA_OPTS` environment variable, and they all generally assume you are running Tomcat as yourself rather than a system user.

Jenkins actually does something handy when `JENKINS_HOME` is not set: it sets it for you, as `.jenkins`.  Of course, it assumes this directory exists relative to where it executing, which means it's looking in `/usr/share/tomcat6`.

~~~terminal
$ cd /usr/share/tomcat6
$ sudo mkdir .jenkins
$ sudo chown tomcat6:nogroup .jenkins
~~~

Jenkins will be making lots of files in `JENKINS_HOME`, but Jenkins is executing from inside of Tomcat, which is running as the user `tomcat6`.  As long as `.jenkins` is writeable by Tomcat, this should be all you need to make Jenkins happy.

Even once you fix this, Jenkins is in a confused state.  The easiest thing to do is restart Tomcat, so `sudo service tomcat6 restart` again.  You won't have to do it much anymore.

Once you load Jenkins in your browser, you should see that things are happy again.

# Install The Git Plugin
Jenkins needs to have the Git plugin installed in order to check out source code from Git repositories.  Click "Manage Jenkins", followed by "Manage Plugins", then navigate to the "Available" tab.

Find "Git Plugin", check it off, then scroll down and click "Install".  Jenkins will tell you that it is checking your internet connection and then downloading the Git Plugin.  It will eventually say it succeeded. Click the "restart" checkbox and Jenkins will restart.

Then you can go back to "Manage Plugins" and go to the "Installed" tab to make sure that it installed correctly.

Unless Jenkins has fixed something between the time of writing this post and the time you're reading it, you will notice that the Git Plugin is not in the list of installed plugins.  No matter how many times you install it, the result will be the same.  If this is not happening to you, you can skip to the next step.  Otherwise, read on.

What is happening is that Jenkins didn't actually download the plugin file, but Jenkins thinks it did.  Go to `/usr/share/tomcat6/.jenkins/plugins`.  Notice a file named `git.hpi` is there, as well as a directory named `git`, which is empty.  Also notice how extremely small the plugin file (the .hpi file) is compared to others.

~~~output
$ ls -l
drwxr-xr-x 4 tomcat6 tomcat6    4096 2011-07-31 17:03 cvs
-rw-r--r-- 1 tomcat6 tomcat6  189373 2011-07-25 17:46 cvs.hpi
drwxr-xr-x 2 tomcat6 tomcat6    4096 2011-07-31 17:08 git
-rw-r--r-- 1 tomcat6 tomcat6     329 2011-07-31 17:06 git.hpi
drwxr-xr-x 4 tomcat6 tomcat6    4096 2011-07-31 17:03 maven-plugin
-rw-r--r-- 1 tomcat6 tomcat6 7935221 2011-07-25 17:46 maven-plugin.hpi
drwxr-xr-x 4 tomcat6 tomcat6    4096 2011-07-31 17:03 ssh-slaves
-rw-r--r-- 1 tomcat6 tomcat6   49018 2011-07-25 17:46 ssh-slaves.hpi
drwxr-xr-x 4 tomcat6 tomcat6    4096 2011-07-31 17:03 subversion
-rw-r--r-- 1 tomcat6 tomcat6 2097909 2011-07-25 17:46 subversion.hpi
~~~

Now run `cat git.hpi`.  This is what I got:

~~~html
<!DOCTYPE HTML PUBLIC "-//IETF//DTD HTML 2.0//EN">
<html><head>
<title>302 Found</title>
</head><body>
<h1>Found</h1>
<p>The document has moved <a href="http://mirrors.jenkins-ci.org/plugins/git/1.1.11/git.hpi">here</a>.</p>
<hr>
<address>Apache/2.2.12 (Ubuntu) Server at updates.jenkins-ci.org Port 443</address>
</body></html>
~~~

So the file moved and what Jenkins downloaded was the HTML file directing us to the right place.  Just copy the correct url (in my case http://mirrors.jenkins-ci.org/plugins/git/1.1.11/git.hpi) and do this:

~~~terminal
$ sudo rm -r git
$ sudo rm git.hpi
$ sudo wget
  http://mirrors.jenkins-ci.org/plugins/git/1.1.11/git.hpi
~~~

You need to restart Jenkins, but the easiest thing to do is restart Tomcat yet again.

Afterwards when Jenkins comes back up you should see the Git plugin installed correctly.

# Create a Job
The next thing to do is create your job, which means giving your Git repo URL.  For the purpose of this post, I will assume your URL is `ssh://user@mydomain.com:22/~/git/project.git`.

It's a good idea, for a number of reasons, to make sure you can check out your repository yourself before you try to make Jenkins do it.

~~~terminal
$ git clone ssh://user@mydomain.com:22/~/git/project.git
~~~

If you're asked for a password, stop and [set up ssh keys](http://pkeck.myweb.uga.edu/ssh/).  This ensures you won't have to type passwords anymore.

Once you give your Git repo URL to Jenkins, tell it to go ahead and make a build.

## Set up SSH Keys For Tomcat

Your first build should fail, and if you click on the failed job and click Console Output you will see something like this:

~~~output
Permission denied, please try again.
Permission denied (publickey,gssapi-with-mic,password).
fatal: The remote end hung up unexpectedly

ERROR: Could not fetch from any repository
FATAL: Could not fetch from any repository
hudson.plugins.git.GitException: Could not fetch from any repository
	at hudson.plugins.git.GitSCM$2.invoke(GitSCM.java:959)
	at hudson.plugins.git.GitSCM$2.invoke(GitSCM.java:919)
	at hudson.FilePath.act(FilePath.java:758)
	at hudson.FilePath.act(FilePath.java:740)
	at hudson.plugins.git.GitSCM.checkout(GitSCM.java:919)
	at hudson.model.AbstractProject.checkout(AbstractProject.java:1193)
	at hudson.model.AbstractBuild$AbstractRunner.checkout(AbstractBuild.java:555)
	at hudson.model.AbstractBuild$AbstractRunner.run(AbstractBuild.java:443)
	at hudson.model.Run.run(Run.java:1376)
	at hudson.model.FreeStyleBuild.run(FreeStyleBuild.java:46)
	at hudson.model.ResourceController.execute(ResourceController.java:88)
	at hudson.model.Executor.run(Executor.java:175)
~~~

There's no easy way to make Jenkins use a password, so you will need to set up keys for Jenkins as well.  Remember, Jenkins is running as the user `tomcat6`, so the fact that you can check out from the repo fine doesn't mean anything.

To generate a key for tomcat, do the following:

~~~terminal
$ cd /usr/share/tomcat6/
$ sudo mkdir .ssh
$ sudo ssh-keygen -t rsa -C "tomcat@localhost"
~~~

When asked, type the location of your new file as /usr/share/tomcat6/.ssh/id_rsa and when it's generated, do:

~~~terminal
$ sudo chown -R tomcat6:nogroup .ssh
~~~

Now you need to SSH up to the server hosting your git repository and edit the `~/.ssh/authorized_keys` file to add the contents of `/usr/share/tomcat6/.ssh/id_rsa.pub` to it.

You can actually think of `/usr/share/tomcat6/` as if it were the tomcat6 home directory.  Since a `.ssh` directory goes in your home directory normally, putting one there will have the same effects, as will any files you put there.

## Adding a Known Host

Build your project and it will still fail. This time the error will look like this:

~~~output
Host key verification failed.
fatal: The remote end hung up unexpectedly

Trying next repository
ERROR: Could not clone repository
FATAL: Could not clone
hudson.plugins.git.GitException: Could not clone
	at hudson.plugins.git.GitSCM$2.invoke(GitSCM.java:993)
	at hudson.plugins.git.GitSCM$2.invoke(GitSCM.java:919)
	at hudson.FilePath.act(FilePath.java:758)
	at hudson.FilePath.act(FilePath.java:740)
	at hudson.plugins.git.GitSCM.checkout(GitSCM.java:919)
	at hudson.model.AbstractProject.checkout(AbstractProject.java:1193)
	at hudson.model.AbstractBuild$AbstractRunner.checkout(AbstractBuild.java:555)
	at hudson.model.AbstractBuild$AbstractRunner.run(AbstractBuild.java:443)
	at hudson.model.Run.run(Run.java:1376)
	at hudson.model.FreeStyleBuild.run(FreeStyleBuild.java:46)
	at hudson.model.ResourceController.execute(ResourceController.java:88)
	at hudson.model.Executor.run(Executor.java:175)
~~~

The problem now is that, even though your git repo trusts Jenkins, Jenkins doesn't really trust the git repo.

To fix this, do the following:

~~~terminal
$ cat ~/.ssh/known_hosts
~~~

You'll see a number of entries here.  These are all of the hosts that you SSH'd into and, when asked, said you trust them based on their fingerprints.  One of those hosts is your git repository, but you're more or less safe just doing:

~~~terminal
$ sudo cp ~/.ssh/known_hosts /usr/share/tomcat6/.ssh/known_hosts
$ sudo chown tomcat6:nogroup /usr/share/tomcat6/.ssh/known_hosts
~~~

## Avoid ~

Build again.  You may see an error that looks like this:

~~~output
fatal: '~/git/project.git ' does not appear to be a git repository
fatal: The remote end hung up unexpectedly

Trying next repository
ERROR: Could not clone repository
FATAL: Could not clone
~~~

For some reason, even though my local git is perfectly happy checking out a repository with `~` used to specify the home directory of the remote user, the git Jenkins is using hates it.

This is easy to fix, simply replace the `~` if you are using one with the full remote path to your repo, such as `ssh://user@mydomain.com:22/home/user/git/project.git`

## Letting Jenkins Tag

Build again and you should get a totally new kind of failure.

~~~output
FATAL: Could not apply tag jenkins-project-5
hudson.plugins.git.GitException: Could not apply tag jenkins-project-5
	at hudson.plugins.git.GitAPI.tag(GitAPI.java:698)
	at hudson.plugins.git.GitSCM$4.invoke(GitSCM.java:1181)
	at hudson.plugins.git.GitSCM$4.invoke(GitSCM.java:1129)
	at hudson.FilePath.act(FilePath.java:758)
	at hudson.FilePath.act(FilePath.java:740)
	at hudson.plugins.git.GitSCM.checkout(GitSCM.java:1129)
	at hudson.model.AbstractProject.checkout(AbstractProject.java:1193)
	at hudson.model.AbstractBuild$AbstractRunner.checkout(AbstractBuild.java:555)
	at hudson.model.AbstractBuild$AbstractRunner.run(AbstractBuild.java:443)
	at hudson.model.Run.run(Run.java:1376)
	at hudson.model.FreeStyleBuild.run(FreeStyleBuild.java:46)
	at hudson.model.ResourceController.execute(ResourceController.java:88)
	at hudson.model.Executor.run(Executor.java:175)
Caused by: hudson.plugins.git.GitException: Error performing command: git tag -a -f -m Jenkins Build #5 jenkins-project-5
Command "git tag -a -f -m Jenkins Build #11 jenkins-project-5" returned status code 128:
*** Please tell me who you are.
~~~

What's happening now is that your build is actually successfully checking out your code.  Jenkins tries to make a tag in git so that you know the build number for any given set of commits.  Unfortunately, git is not configured with a name to put as the person creating that tag, so it explodes.

It would be nice to set global config here, but I don't know of any easy way to do so for the `tomcat6` user.  If you know of a way, please let me know in the comments.

To fix this, we need to set project-level config options for git.

~~~terminal
$ cd /usr/share/tomcat6/.jenkins/jobs/project/workspace
$ sudo git config user.email "jenkins@localhost"
$ sudo git config user.name "Jenkins"
~~~

Obviously you will have to use the name of your job rather than `project` above.  You have to do this for any job that you create.

Alternatively, you can set the options globally for the Tomcat user by creating a new file, `/usr/share/tomcat6/.gitconfig` and putting something like this in it:

~~~ini
[user]
name = Jenkins
email = jenkins@domain
~~~

**UPDATE**: I've discovered a better way of doing this part.  In "Manage Jenkins" there's actually a "Git Plugin" field set that lets you set this from within Jenkins itself.

{% image Screen-shot-2011-08-05-at-9.01.03-AM.png %}

Click build again, and it should actually succeed.

If you're building java projects, you may get an error with something Maven or Ivy.  This is likely more permissions difficulties, and generally making a `.m2` or `.ivy` directory in `/usr/share/tomcat6` and ensuring that it is owned and writable by the `tomcat6` user will fix things.  Part of me wonders if setting `/usr/share/tomcat6` writeable by the `tomcat6` user would save a lot of headaches, but I'm not sure if that has security implications I'm not considering, so I haven't done it.

I'm not a Linux, Tomcat, Jenkins, Git, or SSH guru by any stretch of the imagination.  If you know of a better way to do one of the steps above, please leave a comment and let me (and anyone else who finds this post) know.

Happy integrating!

