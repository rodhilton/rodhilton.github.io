---
layout: post
title: Coldfusion's Compiler
category: Life
tags:
- code
- coldfusion
status: publish
type: post
published: true
---

Neil asks on his blog, "[ What is it with the Coldfusion Compiler?](http://blog.feed-squirrel.com/2006/12/07/what-is-it-with-the-coldfusion-compiler/)"

Essentially, he posts a simple piece of code in CF that counts up to 1000000 in a loop, then prints out how long that takes.  He does the same thing in JSP, and times that as well.  The JSP code executes much, much more quickly than the CF code, and he wants to know why.  The reason for the interest is that ColdFusion compiles to Java, and one of the big selling points is that CF is just another way of writing Java web code, since it all gets compiled to servlets anyway.

There are a number of reasons why the CF code is slower.  First and foremost, he's using a scriptlet in the JSP.  This compiles directly, character for character, to the .java file that gets compiled into a class.  The CF code is using tags.  I think a more fair comparison would be to use JSTL and write a scriptless JSP to do the same thing, however I'm quite confident the JSP code will still come out way ahead.

The real reasons for the difference are actually quite interesting, and I'll take you through my process of experimentation as I set out to figure out the exact answer. 

One thing you need to be aware of is the way that ColdFusion is typed.  CF uses a weak typing system while Java uses strong typing.  Any variable you declare in CF can be automatically converted into any other kind easily.  Converting a weakly typed language into code that compiles for a strongly typed language is no easy task, and the way ColdFusion does it is by having its own variable management system on top of the Java servlet code.

To put this in perspective, imagine I wrote a web language, called RodML and a Java API to interpret it completely.  You can make an instance of a RodMLInterpreter class and pass a string of RodML to it using the method interpretRodML().  I could say that I “compile your page to a servlet” by simply dumping your RodML code into a String and passing it to the interpreter.  Now, this is only "compiling to a servlet" by a mere technicality, as the entire interpretive stack exists on top of the servlet.

On a scale from 1 to 10, 1 being a scriptlet in JSP (which gets compiled directly as Java), and 10 being the RodML example I just gave, I'd place JSTL-written pages at a 2 or 3 and CF at a 6 or 7.  It does compile to code, but it has a thick enough layer between it and the Java that you can't place it much lower on the scale.

When you compile a CF page into a servlet, it doesn't turn a variable "x" that you initialize with the value 1.234 to be double x = 1.234.  It makes an object of type Variable (part of the cf library).  Whenever it uses this variable, it performs a function called "_autoscalarize" on it, which essentially figures out the type and convert it.  It then has to perform some casting using utility classes in CF in order to get things to behave correctly.

# Compiled Version of Neil's Code

At the risk of being sued, I'm going to show you what Neil's CF code turns into.  

Here's his code:

~~~coldfusion
<cfset start = getTickCount()>

<cfset result = 0>

<cfloop from="1" to="1000000" index="i">
<cfset result = result + i>
</cfloop>

<cfoutput>#result#
</cfoutput>
<cfoutput>Execution Time: #getTickCount() - start#ms</cfoutput>
~~~

And this is what you see if you decompile the .class file that ColdFusion 7 MX generates:

~~~java
import coldfusion.runtime.*;
import coldfusion.tagext.QueryLoop;
import coldfusion.tagext.io.OutputTag;
import java.io.Writer;
import javax.servlet.jsp.PageContext;

public final class cfblogtest2ecfm1762415691 extends CFPage
{

    public cfblogtest2ecfm1762415691()
    {
    }

    protected final void bindPageVariables(VariableScope varscope, LocalScope locscope)
    {
        super.bindPageVariables(varscope, locscope);
        START = bindPageVariable("START", varscope, locscope);
        RESULT = bindPageVariable("RESULT", varscope, locscope);

        I = bindPageVariable("I", varscope, locscope);
    }

    protected final Object runPage()
    {
        javax.servlet.jsp.JspWriter out = super.pageContext.getOut();
        javax.servlet.jsp.tagext.Tag parent = super.parent;
        START.set(GetTickCount());
        _whitespace(out, "\r\n\r\n");
        RESULT.set("0");
        _whitespace(out, "\r\n\r\n");
        double t4 = 1.0D;
        double t6 = Cast._double("1000000");
        double t8 = Cast._double("1");
        Object value = Cast._Object(t8);
        SetVariable("i", value);
        for(; CfJspPage._checkCondition(t4, t8, t6); CfJspPage.checkRequestTimeout("CFLOOP"))
        {
            _whitespace(out, "\r\n");
            RESULT.set(Cast._Object(Cast._double(_autoscalarize(RESULT)) + Cast._double(_autoscalarize(I))));
            _whitespace(out, "\r\n");
            value = Cast._Object(t8 += t4);
            SetVariable("i", value);
        }

        _whitespace(out, "\r\n\r\n");
        OutputTag output0 = (OutputTag)_initTag(class$coldfusion$tagext$io$OutputTag, 0, parent);
        try
        {
            int mode0;
            if((mode0 = output0.doStartTag()) != 0)
                do
                {
                    out.write(Cast._String(_autoscalarize(RESULT)));
                    _whitespace(out, "\r\n");
                } while(output0.doAfterBody() != 0);
            if(output0.doEndTag() == 5)
            {
                Object t12 = null;
                return t12;
            }
        }
        catch(Throwable t13)
        {
            output0.doCatch(t13);
        }
        finally
        {
            output0.doFinally();
        }
        _whitespace(out, "\r\n");
        OutputTag output1 = (OutputTag)_initTag(class$coldfusion$tagext$io$OutputTag, 1, parent);
        try
        {
            int mode1;
            if((mode1 = output1.doStartTag()) != 0)
                do
                {
                    out.write("Execution Time: ");
                    out.write(Cast._String(Cast._double(GetTickCount()) - Cast._double(_autoscalarize(START))));
                    out.write("ms");
                } while(output1.doAfterBody() != 0);
            if(output1.doEndTag() == 5)
            {
                Object t18 = null;
                return t18;
            }
        }
        catch(Throwable t19)
        {
            output1.doCatch(t19);
        }
        finally
        {
            output1.doFinally();
        }
        return null;
    }

    public final Object getMetadata()
    {
        return metaData;
    }

    private Variable START;
    private Variable RESULT;
    private Variable I;
    static final Class class$coldfusion$tagext$io$OutputTag = Class.forName("coldfusion.tagext.io.OutputTag");
    static final Object metaData = new AttributeCollection(new Object[0]);
}
~~~

The portion starting with `START.set(GetTickCount());` and ending at the end of the loop is what's interesting.  That's the part that's executing the loop, and therefore it is the most time-consuming task for the page.  The rest of the code is mostly error handling cruft, and it has minimal impact on the running time of the code.  The part in red is, basically, the part that is timed.

# Enter CFScript

CF Supports a tag named CFScript, which allows you to write cf scripting language inside of one tag.  It's more code-oriented and less tag-oriented than regular cfml.  If you convert Neil's example to CFScript, you get this:

~~~coldfusion
<cfscript>
start = getTickCount();
result=0;
for(i=0;i lte 1000000;i=i+1) {
    result=result+i;
}
</cfscript>

<cfoutput>#result#
</cfoutput>
<cfoutput>Execution Time: #getTickCount() - start#ms</cfoutput>
~~~

This code actually executes in 200ms for me, while the tag-based code executes in 2500ms.

That's extremely interesting, and we're going to use it in our experiment.  But first, we need to look at how the cfscript changes the generated class file.  Below is the main change to the code when we write it with cfscript.  That previous section of code now looks like this (the rest is the same)

~~~java
START.set(GetTickCount());
RESULT.set("0");
I.set("0");
for(; CfJspPage._compare(_autoscalarize(I), 1000000D) <= 0.0D; I.set(Cast._Object(Cast._double(_autoscalarize(I)) + 1.0D)))
    RESULT.set(Cast._Object(Cast._double(_autoscalarize(RESULT)) + Cast._double(_autoscalarize(I))));
~~~

So what are the differences between the above code (generated from a cfscript implementation), and the other code (generated from a cfml implementation)?  Here is the relevant portion of the earlier code, so you don't have to scroll up to see it:

~~~java
START.set(GetTickCount());
_whitespace(out, "\r\n\r\n");
RESULT.set("0");
_whitespace(out, "\r\n\r\n");
double t4 = 1.0D;
double t6 = Cast._double("1000000");
double t8 = Cast._double("1");
Object value = Cast._Object(t8);
SetVariable("i", value);
for(; CfJspPage._checkCondition(t4, t8, t6); CfJspPage.checkRequestTimeout("CFLOOP"))
{
    _whitespace(out, "\r\n");
    RESULT.set(Cast._Object(Cast._double(_autoscalarize(RESULT)) + Cast._double(_autoscalarize(I))));
    _whitespace(out, "\r\n");
    value = Cast._Object(t8 += t4);
    SetVariable("i", value);
}
~~~

# Analysis

So what are the main differences in this code?

 * The call to checkRequestTimeout in the CFML version
 * The way the loop condition comparison is done.
 * The repeated calls to _whitespace in the CFML version
 * The way that i is set in the code.

Note that the actual code that tabulates the RESULT variable is actually identical in both versions.  Despite how many autoscalarize calls and casts are done, it doesn't seem to be the biggest contributor to the run-time difference.

So let's go through these.  I can take the decompiled code for the CFML version and actually compile it with cfusion.jar in my classpath.  Then I can take the class file and replace the cached version of the class file on disk.  After reloading ColdFusion, it will use the version I wrote.

The checkRequestTimeout seems like something that could take some time, and it's called on every iteration of the loop.  I removed that, recompiled, restarted CF, and re-ran the page.  The execution time was still around 2500ms.

Since it wasn't the checkRequestTimeout method, I imagined it could be the way that the loop condition is tested.  I replaced the for loop in the code with my own for loop:

~~~java
for(double i=0;i<=1000000;i++)
~~~

Since the variable the code was using, I (of Variable type) was different from my i, I could leave all of the other code the same.  The I Variable would still be incremented the same way, the same number of times.  My loop replacement was ensuring the block would execute the same number of times, but it was merely removing the  CfJspPage._checkCondition call that it was using to control the loop.  I recompiled, restarted, and re-ran, only to discover the same 2500ms run-time.  Obviously the slowness wasn't due to the way the loop itself worked.

Now, this next one may surprise you.  _whitespace merely outputs to the page, how can it be the cause of the slowdown?  Because it actually appends that whitespace to a buffer, and the buffer has to grow.  Those two characters have to be added one million times, since they occur in the loop.  In fact, they occur in the loop twice, so that's 4 million characters being output to the buffer as the loop runs.  When I removed these lines from the code and re-ran it, my execution time dropped to 1100ms.  That's right, **the calls to _whitespace were a major culprit for the slow execution time.**

This happens because there are linebreaks between the cfml tags, and those have to be output directly to the page.  Since Neil's JSP code used a scriptlet, no such whitespace was printed to the buffer, therefore the JSP wasn't slowed down by it.  

You can actually fix this problem yourself without recompiling your code.  Simply go into the CF Administrator and into the Settings menu, then turn "Whitespace Management" on.  When this setting is enabled, the call to _whitespace will see that it's on and return immediately, rather than add the characters to the buffer.  When I leave the _whitespace calls in the code but enable Whitespace Management, the code runs in 1200ms.  It makes sense that it's slightly more because it still has the extra function calls inside the loop, but it's still much faster with the setting enabled.

The last thing is how the index variable, I, is incremented.  Since I had a loop that didn't use I (the Coldfusion Variable instance), I simply removed these lines:

~~~cfscript
value = Cast._Object(t8 += t4);
SetVariable("i", value);
~~~

and modified the RESULT.set code to use the double i rather than the Variable I.  When I do this, the code runs in a much more reasonable 150ms.  So what's the problem, the cast or the SetVariable?

If I put the SetVariable line back in, it executes in about 1200ms.  

_So there you have it, the SetVariable implementation is slow, and it gets called on every single iteration through the loop in order to set the "I" variable to be one larger.  That, combined with the whitespace buffer issue, is why the CF page is so much slower._

The good news is Neil can make his page run in half the time by enabling a single setting in CF Administrator.  The bad news is the real culprit, SetVariable, cannot be controlled by any such setting.

CFScript doesn't use SetVariable, so if you're doing heavy loop code like this, I'd recommend writing it using CFScript rather than CFML.

