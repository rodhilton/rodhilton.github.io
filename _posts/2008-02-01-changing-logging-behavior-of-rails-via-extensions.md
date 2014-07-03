---
layout: post
title: Changing Logging Behavior of Rails via Extensions
category: Programming
tags:
- code
- rails
- ruby
status: publish
type: post
published: true
---

One of the nicest things about Ruby is how well it supports metaprogramming.  You can dynamically, at runtime, change the behavior of any other class or module in the system, even private methods.  

When I was first learning Ruby, this seemed like a flaw, and while I still feel that this ability can be abused, it is definitely handy.

I'm going to explain a simple method of changing the behavior of part of Rails by a real-life example from work.

For a Ruby on Rails project I'm currently working on, we had a somewhat uncommon requirement.  We're dealing with a lot of data, which we store for other companies.  For various reasons, one of the concerns is that we may be subpoenaed and forced to provide all of our records for legal reasons.  In order to fully protect the identities of our customers, our system was designed around never actually storing any identifying information about our customers.  Instead, customers get a special code that identifies them, and we only have the ability to know the code, but we can't tie the code to any specific organization.  This may seem like a strange restriction, but for our application it was important.

This important aspect of the project had a number of implications for the design and implementation of the system, but in this post I'm only going to talk about one of them.  IP addresses, when recorded along with the time that an IP address accessed the system, could be used to make educated guesses about the companies using the system.  While the system itself does not record IP addresses or timestamps for hits, the web servers themselves do.  Modifying Apache not to log this kind of information was trivial, but one glaring issue remained.

In production mode, when an error occurs in the system, a log entry is created in production.log, which tries to provide details that the developers can use to figure out why the error occured.  This log contains a stacktrace, some time information, and various other pieces of data that can be helpful in debugging a critical issue.  It also logs the IP address of the user that generated the request that resulted in an error, like so:

~~~output
Processing PostsController#some_action (for 127.0.0.1 at 2008-01-24 10:23:59) [POST]
  Session ID: b8f0b05d77fc4a5efdc04cf809f810d4
  Parameters: {} 
~~~

The problem here is that the IP address is logged , and there is no way to change that via a configuration option.  I can turn logging off entirely, but I'd like to keep the error information in the event that the system actually does have a bug in it.

Luckily, the design of Ruby allows us to actually override this behavior relatively easily, and I'm going to explain how.

# Step 1: Figure Out What You Want To Change

For this problem, figuring out what needed to be modified was relatively easy.  I was able to simply grep for "Processsing " inside of /usr/lib/ruby/gems/1.8/gems to find the file that was responsible for printing this line to the log.  It turns out that it was the base.rb file inside of action_controller.  Opening this file and searching revealed this method:

~~~ruby
def log_processing
  if logger &amp;&amp; logger.info?
    logger.info "\n\nProcessing #{controller_class_name}\##{action_name} (for #{request_origin}) [#{request.method.to_s.upcase}]"
    logger.info "  Session ID: #{@_session.session_id}" if @_session and @_session.respond_to?(:session_id)
    logger.info "  Parameters: #{respond_to?(:filter_parameters) ? filter_parameters(params).inspect : params.inspect}"
  end
end
~~~

This was a private method on the Base class inside of the ActionController module.  The rest of the process is quite easy.

# Step 2: Write The Override

To override something, you simply define a new method as though it never existed before.  These get qualified in the same as defining any method on a class or a module.  Here is what mine looked like:

~~~ruby
module ActionController
  class Base
    private
    def log_processing
      if logger &amp;&amp; logger.info?
        logger.info "\n\nProcessing #{controller_class_name}\##{action_name} (for [FILTERED]) [#{request.method.to_s.upcase}]"
        logger.info "  Session ID: #{@_session.session_id}" if @_session and @_session.respond_to?(:session_id)
        logger.info "  Parameters: #{respond_to?(:filter_parameters) ? filter_parameters(params).inspect : params.inspect}"
      end
    end
  end
end
~~~

As you can see, I am simply defining a method called "log_processing" on the Base class inside the ActionController module.  When Ruby interprets the above code, it will define this method, overwriting the method if it already exists.  All I did was change the IP address to say that it was filtered.  Note that even though this method is private, I am still able to do this painlessly.

The next step is to simply get Rails to run over this code and overwrite the existing log_processing method.

# Step 3: Making It Load

There are a lot of ways you can do this.  The ideal way is to create a plugin in vendor/plugins that contains this code.  Rails will automatically run over the code at the correct time.  This is a slightly more complex approach than I'd like to cover here, however, so we're going to just try and get this into the system as quickly as possible.

I've found that once you start doing this sort of stuff, you like to have a single place to keep all the behavior modifications you are using.  Sometimes you'd like to simply add a method to a class, or change part of Rails.  These changes are basically all unrelated, except that they are important for your application.  For this reason, I like to keep them all together in a single file so that it's easy to see what has been changed/added.  Obviously if you wind up making a lot of changes, you should make a plugin instead, particularly if the changes might be useful in other rails apps.

Save the above code into a file called "extensions.rb" inside of the "extras" directory under my rails project directory.

Then, go into your environment.rb file and add this line to the bottom:

~~~ruby
require File.join(RAILS_ROOT, 'extras', 'extensions')
~~~

The reason I suggest the bottom of the file (after the Rails::Initializer.run) is that you want to make sure all of the rails libraries are loaded first, otherwise they will overwrite YOUR method, instead of the other way around.

That's it.  Now, whenever you run rails (even in script/console), your changes will be reflected.  This successfully causes the error log to leave the IP address out of what is recorded.  

This is not something that should be done a lot in your application.  Changing the behavior of core parts of rails will likely confuse other developers on your team.  That's why, if this method is employed, I believe you should keep these changes to a minimum, and keep them all in one place.

