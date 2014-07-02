---
layout: post
title: Getting A Java Object's Refence ID
category: Programming
tags:
- code
- java
status: publish
type: post
published: true
---
In Java, when you call the `toString()` method of an object that hasn't overridden it, it prints out strings that look like these:

~~~output
Object@3e25a5
Car@19821f
~~~

Many people believe that this is the memory location of the object, but it's not quite.  It is, however, a string that _seems_ unique to an object, so the confusion seems understandable.

A friend recently asked me if there was any way to get that "address" on an object that has overridden `toString`.  Once `toString` has been overridden, calling it will bypass this default implementation.  Since his internet search didn't pull anything up, I figured I'd do some research and blog about the answer to his conundrum in case anyone else is ever curious about it.

It may be surprising, but calling the default `hashCode()` actually gives you this value.  The `hashCode` method doesn't hash the actual object by it's value, but by it's identity, meaning this is the reference ID.

To illustrate this simply, take a look at the following code snippet.  It creates two identical objects, then adds them to a `HashMap`, and prints out the size of the `HashMap`.

~~~java
Car car1=new Car("Chevy", "Blazer")
Car car2=new Car("Chevy", "Blazer");

AbstractMap<Car, String> map=new HashMap<Car, String>();
map.put(car1, "Got it");
map.put(car2, "Got it");

System.out.println("Size is: "+map.size());  //We get 2
~~~

`HashMap` works by calling `hashCode()` on the keys going into the map.  You might expect for the size to be 1, since the two cars are the same.  However, they do not have the same `hashCode`, because `hashCode`s are, by default, identity-based.  Since the two objects take up two unique spots in memory (as they were instantiated separately), they have different `hashCode`s, and thus the size of the map is 2.

This means that you can get the reference ID, the thing after the @ in default `toString()` implementations, simply by calling `hashCode()` on the object.  It comes back as an int, but it has the same value as the hexadecimal string would in the default `toString()` implementation.

However, `hashCode()` is often overridden, as it ought to be whenever someone overrides `equals()`.  And if someone has overridden `toString()`, it's likely they've overridden `equals()` and `hashCode()` as well.

Fear not, as the `System` object will actually give you access to the identity-based `hashCode` on any object, even if the class it is an instance of has overridden `hashCode()`.  It exposes this via a method called `identityHashCode`.

You can also handily convert an integer to a hex string using the `Integer` class, so you can get the value that would come after the @ in a default toString() implementation by calling this:

~~~java
Integer.toHexString(System.identityHashCode(object))
~~~

Now, the question is, is this the "address" of the object, as my friend originally wanted.  The answer to that is: sort of.

It has no direct link to the physical location in memory.  As the JVM runs, it's constantly moving your objects between different parts of memory, transferring objects from Eden space in to Survivor space, and even transferring objects back and forth between two different Survivor spaces, possibly even to the Old Generation.  So there's never a "physical" address for the object.

However, it does uniquely identify the object itself in memory.  Or rather, it mostly does.  The Javadocs for `hashCode` on `Object` say:

> As much as is reasonably practical, the hashCode method defined by class Object does return distinct integers for distinct objects. (This is typically implemented by converting the internal address of the object into an integer, but this implementation technique is not required by the JavaTM programming language.)

So yes, the identity hash code *is* the address of the object, except when it's not "reasonably practical", at which point all bets are off.  The identity hashCode provides a good approximation for the uniqueness of an object by reference, but it's no guarantee.  In fact, you could technically run on an alternative JVM that returns the exact same value for every call to `identityHashCode1`, and it's not actually violating any specifications.

The following Java code, provided by a commenter, illustrates this principle.

~~~java
import java.util.Hashtable;
import java.util.Map;

public class HashcodeTest {
    public static void reportCollision(Object obj1, Object obj2) {
        System.out.println("obj1.hashCode() = " + obj1.hashCode());
        System.out.println("obj2.hashCode() = " + obj2.hashCode());
        System.out.println("(obj1 == obj2) = " + (obj1 == obj2) + " (!)");
    }

    public static void main(String[] args) {
        Map map = new Hashtable();
        for (int count = 1; true; count++) {
            Object obj = new Object();
            if (map.containsKey(obj.hashCode())) {
                System.out.println(
                        "Collision after instantiating " + count + " objects.");
                reportCollision(map.get(obj.hashCode()), obj);
                System.exit(0);
            }
            map.put(obj.hashCode(), obj);
        }
    }
}
~~~

I increased my heap space to 2 gigs and was unable to ever get an actual collision, but you may have better luck.

In any case, this identityHashCode is a handy way to get an approximate unique identifier for an object in memory, but be careful using it in such a way, as it's not technically guaranteed unique by the JVM.
