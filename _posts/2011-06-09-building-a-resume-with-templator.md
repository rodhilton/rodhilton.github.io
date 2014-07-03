---
layout: post
title: Building a Résumé With Templator
category: Life
tags:
- career
- code
- latex
- resume
status: publish
type: post
published: true
---

I care, probably more than I should, about my résumé.  I sort of think of it like a real-life character sheet, so I like to keep it current at all times.  But my résumé has always been a source of irritation for me as well, as I have a number of things I would like to do with it that I've been unable to do.

 1. I want to have it version-controlled, so it should be plain text.
 2. I want to have a plain HTML version of it that I can post on my blog, [here](http://www.nomachetejuggling.com/resume/)
 3. I want to have a $$\LaTeX$$ version of it, because I like the way it looks, and I'd like to send that version to potential employers.
 4. I would like to have a "master" version of the résumé with all of my data, but be able to easily build customized versions of it.  For example, I want to include the sections on what courses I took in school if I'm sending my résumé to an academic institution, but I want to leave that off if I'm applying for an industry job.

I started building some tools that would let me accomplish this, including a specialized résumé data format that I called "rml" but I quickly realized that not everyone wants to store the same data on their résumé, so I kept generalizing and generalizing the tool until I had something usable: [Templator](https://github.com/rodhilton/templator).

Templator is a general tool that allows someone to store data in a text file and run that data through various template files to get generated output.  It utilizes [YAML](http://www.yaml.org/) and [ERB](http://www.ruby-doc.org/stdlib/libdoc/erb/rdoc/), so Ruby programmers should already be comfortable with it.

In this article I'm going to explain how to use Templator to store a version-controllable, customizable résumé.

# Getting Started With Templator

The way Templator works is simple (once you've cloned the git repo):

~~~terminal
$ ./templator --data-file data_file template_file
~~~

The `data_file` file is where we will store our master résumé data, and the `template_file` is the file we will use to store the template, which in this example will be generating HTML.

Let's start with a simple data file, which I'll save as `example1.yaml`.

~~~yaml
name: Bob Smith
~~~

And here is our first template, which I will save as `template1.html.erb`

~~~html
<html>
<body>
  <h1>Resume for <%= name %></h1>

</body>
</html>
~~~

Now, if I execute:

~~~terminal
./templator -d example1.yaml template1.html.erb
~~~

I get the output to `stdout`, so I'm going to dump that into a file.

~~~terminal
./templator -d example1.yaml template1.html.erb > template1.html
~~~

Now I get a new HTML file, `template1.html`, which looks like this:

~~~html
<html>
<body>
  <h1>Resume for Bob Smith</h1>

</body>
</html>
~~~

As you can see, the ERB escape sequences have access to everything defined in the YAML file, in this case `name`.  If `name` had not been defined in the yaml file, the then `name` in the template would have simply been `nil`.

# A More Complicated Example: Lists

Alright so let's add our skills to this résumé.  We have many skills, so this will be a list.  Here's our new YAML file, `example2.yaml`

~~~yaml
name: Bob Smith

skills:
  - C++
  - Typing
  - Ping-pong
~~~

Here we've defined a simple list under "skills."  I don't plan on covering the basics of YAML here, but obviously the whitespace matters.  For more information on YAML, check [this tutorial](http://www.yaml.org/YAML_for_ruby.html) or [the spec](http://www.yaml.org/spec/1.2/spec.html).

Now let's make another template, `template2.html.erb`:

~~~html
<html>
<body>
  <h1>Resume for <%= name %></h1>

  <h1>Skills</h1>
  <ul>
    <% skills.each do |skill| %>
      <li><%= skill %></li>
    <% end %>
  </ul>
</body>
</html>
~~~

When we run this through templator:

~~~terminal
./templator -d example2.yaml template2.html.erb
~~~

We get this output:

~~~html
<html>
<body>
  <h1>Resume for Bob Smith</h1>

  <h1>Skills</h1>
  <ul>

      <li>C++</li>

      <li>Typing</li>

      <li>Ping-pong</li>

  </ul>
</body>
</html>
~~~

Notice the somewhat surprising additional spaces.  Ruby programmers will be familiar with this, but it's the result of having linebreaks before and after the ERB lines, like `<% skills.each do |skill| %>`.  Since we're outputting HTML, the additional linebreaks don't matter, but if you want to output plain text you'd need to ensure that ERB escapes aren't surrounded by linebreaks and other spacing.  This makes your template files less readable, so it's a tradeoff.

# Nested Data

Now we'd like to add our work experience.  This data is significantly more hierarchical, but Templator has us covered.  Here is example3.yaml:

~~~yaml
name: Bob Smith

skills:
  - C++
  - Typing
  - Ping-pong

experience:
  - company: XYZ Widgets, Inc
    title: Senior Widget Analyst
    accomplishments:
      - Made over 300 widgets
      - Increased widget production by 55%
  - company: GlobalInfraComm
    title: Intern
    accomplishments:
      - Made great coffee
      - Seriously, the coffee was awesome.
~~~

This nested format will mean that there is going to be a `experience` variable available to the template file.  `experience` will be a list of objects, and each of those objects will have properties named `company`, `title`, and `accomplishments`.  `accomplishments` will also be a list, but of strings.

Here is example3.html.erb:

~~~html
<html>
<body>
  <h1>Resume for <%= name %></h1>

  <h1>Skills</h1>
  <ul>
    <% skills.each do |skill| %>
      <li><%= skill %></li>
    <% end %>
  </ul>

  <h1>Experience</h1>
  <% experience.each do |job| %>
    <p>
      <%= job.company %> (<%= job.title %>)
      <ul>
        <% job.accomplishments.each do |accomplishment| %>
          <li><%= accomplishment %></li>
        <% end %>
      </ul>
    </p>
  <% end %>
</body>
</html>
~~~

Each aspect of the hierarchy can be referred to by a simple object-style syntax.  Anything not defined in the yaml file returns `nil`, and `nil.[anything]` also returns `nil`, so referencing things that aren't defined doesn't result in an error. For example, `<%= experience.something.otherstuff.morethings %>` simply returns `nil`.

Arrays can be referred to how one would expect.  For example, if I wanted to only print out my top accomplishment somewhere, I could do `<%= experience[0].accomplishments[0] %>`.

Running this through Templator yields (extra linebreaks removed):

~~~html
<html>
<body>
  <h1>Resume for Bob Smith</h1>

  <h1>Skills</h1>
  <ul>
      <li>C++</li>
      <li>Typing</li>
      <li>Ping-pong</li>
  </ul>

  <h1>Experience</h1>
    <p>
      XYZ Widgets, Inc (Senior Widget Analyst)
      <ul>
          <li>Made over 300 widgets</li>
          <li>Increased widget production by 55%</li>
      </ul>
    </p>
    <p>
      GlobalInfraComm (Intern)
      <ul>
          <li>Made great coffee</li>
          <li>Seriously, the coffee was awesome.</li>
      </ul>
    </p>
</body>
</html>
~~~

# Flags

The real power in Templator comes from the ability to set flags at runtime.  Let's add an "Education" section to the résumé.  I want to list my GPA in the master résumé YAML file, but only have it show up when I build certain kinds of résumés.  I'd like it to be included whenever I build an academic résumé, but leave it off whenever I am building a regular résumé.

Even though we've only got one degree, we're going to make our degrees a list, in case we ever go back to school.

~~~yaml
name: Bob Smith

skills:
  - C++
  - Typing
  - Ping-pong

experience:
  - company: XYZ Widgets, Inc
    title: Senior Widget Analyst
    accomplishments:
      - Made over 300 widgets
      - Increased widget production by 55%
  - company: GlobalInfraComm
    title: Intern
    accomplishments:
      - Made great coffee
      - Seriously, the coffee was awesome.

education:
  - degree: B.A., Basket-weaving
    school: University of Basketweaving
    gpa: 3.4
~~~

And here's our new template:

~~~html
<html>
<body>
  <h1>Resume for <%= name %></h1>

  <h1>Skills</h1>
  <ul>
    <% skills.each do |skill| %>
      <li><%= skill %></li>
    <% end %>
  </ul>

  <h1>Experience</h1>
  <% experience.each do |job| %>
    <p>
      <%= job.company %> (<%= job.title %>)
      <ul>
        <% job.accomplishments.each do |accomplishment| %>
          <li><%= accomplishment %></li>
        <% end %>
      </ul>
    </p>
  <% end %>

  <h1>Education</h1>
  <ul>
    <% education.each do |e| %>
      <li>
        <%= e.degree %> (<%= e.school %>)
        <% if flags[:academic] %>
          - GPA: <%= e.gpa %>
        <% end %>
      </li>
    <% end %>
  </ul>
</body>
</html>
~~~

Notice the `if` using `flags[:academic]` surrounding the printing of the GPA.

Now if we run Templator like normal:

~~~terminal
./templator -d example4.yaml template4.html.erb
~~~

We get:

~~~html
<html>
<body>
  <h1>Resume for Bob Smith</h1>

  <h1>Skills</h1>
  <ul>
      <li>C++</li>
      <li>Typing</li>
      <li>Ping-pong</li>
  </ul>

  <h1>Experience</h1>

    <p>
      XYZ Widgets, Inc (Senior Widget Analyst)
      <ul>
          <li>Made over 300 widgets</li>
          <li>Increased widget production by 55%</li>
      </ul>
    </p>

    <p>
      GlobalInfraComm (Intern)
      <ul>
          <li>Made great coffee</li>
          <li>Seriously, the coffee was awesome.</li>
      </ul>
    </p>

  <h1>Education</h1>
  <ul>
      <li>
        B.A., Basket-weaving (University of Basketweaving)
      </li>
  </ul>
</body>
</html>

~~~

No GPA listed.  But if we run Templator with a flag, like so:

~~~terminal
./templator -d example4.yaml --flag academic template4.html.erb
~~~

We'll get:

~~~html
<html>
<body>
  <h1>Resume for Bob Smith</h1>

  <h1>Skills</h1>
  <ul>
      <li>C++</li>
      <li>Typing</li>
      <li>Ping-pong</li>
  </ul>

  <h1>Experience</h1>

    <p>
      XYZ Widgets, Inc (Senior Widget Analyst)
      <ul>
          <li>Made over 300 widgets</li>
          <li>Increased widget production by 55%</li>
      </ul>
    </p>

    <p>
      GlobalInfraComm (Intern)
      <ul>
          <li>Made great coffee</li>
          <li>Seriously, the coffee was awesome.</li>
      </ul>
    </p>

  <h1>Education</h1>
  <ul>
      <li>
        B.A., Basket-weaving (University of Basketweaving)
          - GPA: 3.4
      </li>
  </ul>
</body>
</html>

~~~

Notice that the GPA is now included.

# Putting It All Together

It's very easy to use a build tool such as [Rake](http://rake.rubyforge.org/) or [Ant](http://ant.apache.org/) to create different build targets that utilize flags.  Flags are also supported in the yaml file itself, so you can use flags to hide data from the template files.  For example, if you wanted to only include a specific job if a flag was set, you can surround that job in the YAML file with an ERB-escaped `if` statement.

I have a `Rakefile` that uses an `expand_school` flag to include my coursework (an escape in the template) as well as my job as a T.A. (an escape in the YAML file).  I also use a flag called `public` that hides my phone number and e-mail address for résumés that get posted on my web site, but includes them for résumés that I intend to send out to individuals.

I also have two template files, an HTML one and a $$\LaTeX$$ one.  `Rake latex` will build the `latex_private` and `latex_public` artifacts, then execute `pdflatex` on those files to get a nice PDF.  `Rake upload_resume` will upload the HTML and PDF files to my web site as well, which is extremely convenient.

There's definitely a learning curve with doing this, which is why I've written this article.  But once I got everything up and running, I was very happy with the result.  I've got my résumé file checked into a private git repo, and I've even set up [Jenkins](http://jenkins-ci.org/) to poll that repo and automatically build my public résumés and upload them to my web site.

