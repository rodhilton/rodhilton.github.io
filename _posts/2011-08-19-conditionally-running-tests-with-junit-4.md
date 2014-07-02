---
layout: post
title: Conditionally Running Tests With JUnit 4
category: Programming
tags:
- code
- groovy
- hamcrest
- integration
- java
- junit
- tdd
- testing
status: publish
type: post
published: true
---
At work, I'm building a module that interfaces with a customer billing system.  Writing unit tests for something like this is easy using mocks, but I really wanted to write an integration test the ensured the two systems worked together correctly.

Unfortunately, because the system is a billing system, it is considered sensitive, even the developer instance.  This means that, though the Continuous Integration environment (which is hosted in a secure location) is able to access the billing system, the remote office in Denver (where I work) is not.

This can be solved by opening up an [SSH tunnel](http://www.engadget.com/2006/03/21/how-to-ssh-tunnels-for-secure-network-access/) to the CI environment, allowing me to tunnel traffic through HTTP to the remote billing system.  But that presents a separate problem.

My integration will work in the CI environment, it will work locally when the tunnel is open, but it will fail any other time.  So if I check this code in, every other developer on my team will have to know that, before they run all of the tests locally, they have to open an SSH tunnel, even if they're working on a component totally unrelated to my work.

While trying to find a solution to this problem, I discovered JUnit 4's conditional assumption API.  Since I had never seen it before, I wanted to talk about my usage of it here.  In order to make these tests read cleanly, I am using Junit 4, Hamcrest, and HttpClient.  My test itself is also written in Groovy, but it would work just as well in Java (I'm only using Groovy for spaces in test names and [Power Asserts](http://dontmindthelanguage.wordpress.com/2009/12/11/groovy-1-7-power-assert/)).

So here's a stripped down version of my test:

~~~ groovy
package com.nomachetejuggling

import org.junit.Before
import org.junit.Test
import static org.junit.Assume.assumeThat
import static com.nomachetejuggling.UrlAccessibleMatcher.isAccessible

class BillingIntegrationTest {

  def url

  @Before
    void setUp() {
    url = "http://billing.system/endpoint"
    assumeThat(url, isAccessible())
  }

  @Test
  void "can request data"() {
    BillingModule billing = new BillingModule(url)

    BillingData response = billing.getDataForAccount("12345")

    assert response.isSuccessful()
  }

  @Test
  void "should fail when account number invalid"() {
    BillingModule billing = new BillingModule(url)

    BillingData response = billing.getDataForAccount("XXXXX")

    assert response.isFailure();
  }
}
~~~

The specifics of the tests are not important here.  What's important is the <code>@Before</code> method, which calls <code>assumeThat()</code>.  <code>assumeThat</code> is a method that, if it's matcher evaluates to false, ignores the test.  The test does not fail, it's marked as passed (with some information recorded to the log).

You can also use <code>assumeTrue()</code> and pass a simple boolean, but I prefer to use Hamcrest because I think it reads nicer and it provides a convenient central location for the boolean logic needed here.

The other piece of the puzzle here is, of course, <code>UrlAccessibleMatcher</code>, which does the work of determining if the URL can be accessed.

~~~ java
package com.nomachetejuggling;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpConnectionManager;
import org.apache.commons.httpclient.HttpMethod;
import org.apache.commons.httpclient.SimpleHttpConnectionManager;
import org.apache.commons.httpclient.methods.GetMethod;
import org.apache.commons.httpclient.params.HttpConnectionManagerParams;
import org.hamcrest.Description;
import org.hamcrest.Matcher;
import org.junit.internal.matchers.TypeSafeMatcher;

public class UrlAccessibleMatcher extends TypeSafeMatcher<String> {

  public static Matcher<String> isAccessible() {
    return new UrlAccessibleMatcher();
  }

  @Override
  public boolean matchesSafely(String url) {
    HttpMethod method = new GetMethod(url);
    try {
      HttpConnectionManager connectionManager = new SimpleHttpConnectionManager();
      HttpConnectionManagerParams params = connectionManager.getParams();
      params.setConnectionTimeout(500);
      params.setSoTimeout(500);

      HttpClient client = new HttpClient(connectionManager);

      client.executeMethod(method);

      return method.getStatusCode() == 200;
    }
    catch (Exception e) {
      return false;
    }
  }

  public void describeTo(Description descriptionIn) {
    descriptionIn.appendText("Site would be connectable, but wasn't");
  } 
}
~~~

A couple points of note here are that I give this method only 200 milliseconds before timing out.  This is so that the checking for accessibility does not slow all of the tests down.  The downside here is that, if the system is responding slowly, the test will assume that it is not connectable and it won't run the tests.  I had to weigh that against bogging down my entire team by having them open up tunnels before running the tests and decided this was worth it.

When this test is run and the tunnel is open or the site is otherwise connectable, it works as expected.  When running them when the site is not connectable, the bar is still green but the tests don't actually run.  Running the test from IntelliJ looks like this:

<a href="http://www.nomachetejuggling.com/files/Screen-shot-2011-08-16-at-12.53.31-PM.png"><img src="/assets/Screen-shot-2011-08-16-at-12.53.31-PM-580x143.png" alt="" title="Screen shot 2011-08-16 at 12.53.31 PM" width="580" height="143" class="aligncenter size-large wp-image-1426" /></a>

This seems like a pretty clean way of conditionally running tests and only a small amount of ceremony is needed to accomplish it.  The tests do exactly what I want: run when they can, don't run when they can't (but print out that they aren't running to the log).

It's obviously inferior to actually being able to access the integrated systems from all environments, but it's a compromise with which I'm pretty happy.

