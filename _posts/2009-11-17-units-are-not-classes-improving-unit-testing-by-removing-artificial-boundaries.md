---
layout: post
title: 'Units are Not Classes: Improving Unit Testing By Removing Artificial Boundaries'
category: Programming
tags:
- Automated Testing
- bdd
- code
- crossposted
- java
- junit
- mocking
- mockito
- Refactoring
- testing
status: publish
type: post
published: true
---

Many developers think of unit tests as tests that test a single class.  In fact, I myself once thought this way.  If I wanted to write unit tests for a two-class system in which a class used another class, I'd write two unit tests.  After all, if I created instances of both classes in my test, that wouldn't **really** be a unit test, would it?

In recent years, I have revised my stance on this matter.  This distinction between what is and is not a unit test is one I no longer draw in the same way.

Unit Tests need to be:

 * **Fast**: Unit Tests should never run so slowly that they discourage developers from running them all the time.
 * **Focused**: Unit Tests should focus on a single area so that they can isolate problems to that area when they fail.

Once upon a time, I thought &#8216;focused' meant that it should be focused on a single class.  Instead, it should focus on an area, but that area can include multiple classes.

# An Example

Let's say we have a simple Calculator class with some tests (normally we'd write the tests first, but since we're talking about the tests in this post we're going to write them afterwards).  As with any example fabricated for demonstration purposes, the classes in this post have little need for the level of testing I will be applying to them, but they serve an illustrative purpose.

~~~java
package com.rallydev.engblog.unittesting;

public class Calculator {

  public int calculate(char operation, int operand1, int operand2) {
    switch (operation) {
    case '+':
      return operand1 + operand2;
    case '-':
      return operand1 - operand2;
    default:
      throw new UnsupportedOperationException(String.format(
          "'%s' is not a known operation", operation));
    }
  }

}
~~~

Here is the test for this class:

~~~java
package com.rallydev.engblog.unittesting;

import static org.junit.Assert.assertEquals;

import org.junit.Before;
import org.junit.Test;

public class CalculatorTest {

  private Calculator calculator;

  @Before
  public void setUp() {
    this.calculator = new Calculator();
  }

  @Test
  public void shouldAdd() {
    assertEquals(5, calculator.calculate('+', 2, 3));
  }

  @Test
  public void shouldSubtract() {
    assertEquals(1, calculator.calculate('-', 5, 4));
  }

  @Test(expected = UnsupportedOperationException.class)
  public void shouldThrowExceptionForUnknownOperation() {
    calculator.calculate('Q', 1, 2);
  }
}
~~~

But after thinking about it, we realize that the responsibility for parsing what the caller wants to do and the responsibility for actually performing that operation should be separated.

So we're going to create a new class, CalculationProcessor, which actually handles the calculations themselves.

~~~java
package com.rallydev.engblog.unittesting;

public class CalculationProcessor {
  public int add(int operand1, int operand2) {
    return operand1 + operand2;
  }

  public int subtract(int operand1, int operand2) {
    return operand1 - operand2;
  }
}
~~~

The tests for this class should be obvious, so we won't go into them.

We will also modify our Calculator class to be injected with CalculationProcessor at construction time, which it will use to perform the operations.  That looks like this:

~~~java
package com.rallydev.engblog.unittesting;

public class NewCalculator {
  private CalculationProcessor calculationProcessor;

  public NewCalculator(CalculationProcessor calculationProcessor) {
    this.calculationProcessor = calculationProcessor;
  }

  public int calculate(char operation, int operand1, int operand2) {
    switch (operation) {
    case '+':
      return calculationProcessor.add(operand1, operand2);
    case '-':
      return calculationProcessor.subtract(operand1, operand2);
    default:
      throw new UnsupportedOperationException(String.format(
          "%s is not a known operation", operation));
    }
  }
}
~~~

So the question is, what should the test for `NewCalculator` look like?

If we follow the strict "One Unit Test, One Class" paradigm, we have to create a mock for the `CalculatorProcessor` and pass it into the `Calculator`.  

One possible way it could work is by mocking out the `add` and `subtract` methods so that they have mock implementations which actually perform the operations.  That solution really only works here because this example is so simple (the implementation of add is trivial).  Were this problem more real-world, mocking out the responses based on the inputs may not be feasible, so let's imagine that we cannot do this for the purposes of this post (when mocking out the responses is possible, most of this post is rendered moot, as that is usually the best way to go).

The other way to write these tests would be to create a mock and verify that our `NewCalculator` delegates to `CalculationProcessor` appropriately.  It would like this:

~~~java
package com.rallydev.engblog.unittesting;

import org.junit.Before;
import org.junit.Test;

import static org.mockito.Mockito.*;

public class NewCalculatorBadTest {
  private NewCalculator calculator;
  private CalculationProcessor mockCalculationProcessor;

  @Before
  public void setUp() {
    this.mockCalculationProcessor = mock(CalculationProcessor.class);
    this.calculator = new NewCalculator(mockCalculationProcessor);
  }

  @Test
  public void shouldAdd() {
    calculator.calculate('+', 2, 3);
    verify(mockCalculationProcessor).add(2,3);
  }

  @Test
  public void shouldSubtract() {
    calculator.calculate('-', 2, 3);
    verify(mockCalculationProcessor).subtract(2,3);
  }

  @Test(expected=UnsupportedOperationException.class)
  public void shouldThrowExceptionForUnknownOperation() {
    calculator.calculate('Q', 1, 2);
  }
}
~~~

I hate this test.  This test does little but double-check the implementation of `NewCalculator`.

This test is extremely brittle.  If the calculator had more responsibilities (say, multiplication, exponents, etc.) and the tests were more thorough (boundary checking, looking for division by zero, and so on) then changing the implementation of `NewCalculator` would require changing dozens of broken tests.

_The tests are there to make us feel safe about refactoring the code, but virtually any refactoring breaks them, which requires us to manually fix the tests._  When this happens, a refactoring effort loses its test harness: the code and the tests must _both_ change together, rather than one at a time with the one verifying the correctness of the other.

Instead, I would prefer to leave the test as it was, only modifying the `setUp` method to correctly construct the `NewCalculator` with real instantiations of its dependency.

~~~java
package com.rallydev.engblog.unittesting;

import org.junit.Before;
import org.junit.Test;

import static org.junit.Assert.assertEquals;

public class NewCalculatorBetterTest {
  private NewCalculator calculator;

  @Before
  public void setUp() {
    CalculationProcessor calculationProcessor = new CalculationProcessor();
    this.calculator = new NewCalculator(calculationProcessor);
  }

  @Test
  public void shouldAdd() {
    assertEquals(5, calculator.calculate('+', 2, 3));
  }

  @Test
  public void shouldSubtract() {
    assertEquals(1, calculator.calculate('-', 5, 4));
  }

  @Test(expected = UnsupportedOperationException.class)
  public void shouldThrowExceptionForUnknownOperation() {
    calculator.calculate('Q', 1, 2);
  }
}
~~~

There are a few things to notice about this test.  First and foremost, the bodies of the three test methods are now identical to how they were before the refactoring.  This means that the refactoring could have taken place while using the test to ensure it was correct, though the `setUp` method would have had to change.

Secondly, even though a real `CalculationProcessor` was instantiated for the test, it was not assigned to a field.  It is scoped exclusively to the `setUp` method.  This is because the test really has no reason to know about the class beyond the fact that it needs it to construct the `NewCalculator`.

# Blurring the Line

Is this a unit test, or is it something else?  Unit-testing pedants would argue that it's not a unit test, but an integration test.  [Michael Feathers](http://www.michaelfeathers.com/) may disagree:

 > "In the industry, people often go back and forth about whether particular tests are unit tests. Is a test really a unit test if it uses another production class? I go back to the two qualities: Does the test run fast? Can it help us localize errors quickly?"
 > (Source: [Working Effectively with Legacy Code](http://www.amazon.com/Working-Effectively-Legacy-Michael-Feathers/dp/0131177052))

The test above is extremely fast, but how effectively does it help us localize errors?  If it were the only failing test for a system full of classes and tests, it would help us narrow down the error pretty quickly: there is either a problem parsing the operator, or a problem performing the operation.

If we had a separate test for the CalculationProcessor itself, but it was passing, then we would know the error is in the parsing.  It didn't help us localize the problem quite as quickly as the mocking test would have, but it is also a far stronger test, less likely to break under the strain of a refactoring.

It's a trade-off, of course, but I now tend to lean toward creating instances of the dependency classes in the setup of the test in these situations.  I have simple guidelines to help me determine when I should create a mock versus a concrete instance of a class.

# Verify() is a Crutch

When you're writing a test, you go through three phases, which [BDD](http://en.wikipedia.org/wiki/Behavior_driven_development) proponents refer to as the Given, When, and Then.  First you write the Givens, which attempt to fabricate a pre-existing situation for the purposes of your test.  Then you write the Whens, which are the operations being tested.  Last you assert some Thens, which are the expected results of performing the operation.

In the case of our simple unit test above, the Given is that a `NewCalculator` exists.  The When is that `calculate` is called with some parameters.  And then Then, of course, is that we get the desired result.  But how do we write our Thens?

My feeling is that, if we reach into our toolbox and pull out a `verify` to write our Thens, we are cheating our tests out of the chance to be truly valuable.  When we reach for `verify`, we are creating brittle tests that resist refactoring rather than enable it.  We are using `verify` as a crutch, but we should only reach for it as a last resort.

Instead, reach for concrete instantiations of classes where possible.  Create a mock that will be used to verify method invocation for one of two reasons:

 1. **Speed**: If creating an instance of the class will significantly slow down the test, it should be mocked out instead.  This is likely to be the case for classes that clearly turn tests into integration tests, such as classes that facilitate a connection to a database or over a network.  This may also be the case for classes that perform a great deal of processing.
 2. **Complexity**: Create a mock if creating an instance of a class requires creating a number of additional classes that it depends on, which in turn depend on more classes, and so on.  You do not want your setUp methods to contain thousands of lines of object instantiation to support your tests.  I recommend creating real objects as deeply down the dependency tree as possible, then mocking out the rest.  How far down the tree should you go?  That's really a matter of taste, but I recommend trying two layers deep and no more.  When you do this, you are likely to find that you have no need to verify the calls on the mock objects (other tests already cover those scenarios), but instead can set up mock objects to respond in specific ways to method invocations, simulating their behavior for the purpose of the test so that your tests can verify actual results.

# Going Forward

Writing tests without the hard Unit/Class restriction allows us to write tests that enable the safe refactoring of classes, but come at the potential price of slowing down our tests and complicating the `setUp` methods for those tests.  There is a delicate balance there, but in general I recommend trying to err on the side of concrete class instantiation in tests, at least over method invocation verification (mocking out responses is always still preferred).

This view is, of course, subject to change (as it was when I felt that the restriction was valuable), but since blurring this line my tests have remained fast and, more importantly, allowed me to code faster by letting me refactor when necessary.