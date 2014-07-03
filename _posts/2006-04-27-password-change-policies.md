---
layout: post
title: Password Change Policies
category: Life
tags:
- code
- java
status: publish
type: post
published: true
---

I'm no security guru by any stretch, but I am someone who cares a great deal about security.  I've studied encryption academically a great deal, I've read a number [excellent](http://www.amazon.com/gp/product/0471117099/") [books](http://www.amazon.com/gp/product/0387026207") [about](http://www.amazon.com/gp/product/076454280X/") [security](http://www.amazon.com/gp/product/0764574817/"), and I'm a huge fan of [Bruce Schneier](http://www.schneier.com/blog/").  My point here is that I'm not a security genius, but I do think a lot about it, so take this post with the same grain of salt you'd take anything by a non-expert.

That being said, something that has always bugged me has been corporate password change policies. Despite how [pointless](http://www.cerias.purdue.edu/weblogs/spaf/general/post-30/") it is to implement a change policy, it seems to be the standard. The problem is, when I have to change my password monthly, I can't use the handful of secure passwords I memorized long ago because I don't have that many, and thus I am forced to pick passwords that I can remember (which makes them more breakable) or write them down and keep them with me (which is better, but still has flaws).

Because I dislike both options, I devised a system that allows me to maintain a monthly-changing password, without having to write it down where someone can find it, and without having to make my password weaker so that I can memorize it.

I will describe this system and post some usable source code in this post.  I do this for two reasons:

 1. I believe this system is pretty good, so other people may be able to benefit from using it.
 2. I'd like some critical feedback about it, in case there are flaws in the design I don't realize.  Like I said, I'm no guru.

# The Concept

Basically, it works like this.  You pick an **internal password**.  This should be relatively secure, like one of those really good passwords you create every so often.  The kind of thing that's pure garbage: you just have to memorize it.  Let's pick, for the purpose of this explanation: XM2idB.  It can (and should) be longer, but we'll keep it short here.  Something like your initials followed by your birthdate would not be so good.

Now, you generate a series of **password maps**, which look like this:

~~~
[a hP]  [j A5]  [s kg]  [1 oP]
[b k4]  [k 5k]  [t 9G]  [2 Kt]
[c ri]  [l xd]  [u DU]  [3 n9]
[d gf]  [m aA]  [v H3]  [4 55]
[e Dz]  [n ut]  [w 2b]  [5 ak]
[f FD]  [o GM]  [x UG]  [6 LR]
[g yr]  [p FV]  [y L3]  [7 m@]
[h rz]  [q zS]  [z Ay]  [8 vU]
[i RX]  [r CM]  [0 wK]  [9 sC]
~~~

Print them out, maybe 20 of them or so.  Now you can put that paper up in your cubicle, or fold it up and put it into your wallet.

Now you simply create your **external password** using the combination of the **internal password** and **password map**.  In our case, X maps to UG, M to aA, 2 to Kt, i to RX, d to gf, and B to k4.

Thus, our **external password** is UGaAKtRXgfk4.  That's the password we use with the system.  When it's time to change the password, we have three options:

 1. Change our **internal password**.
 2. Pick a new mapping on our sheet.
 3. Print a new sheet.

Of course, you could print a new sheet AND pick a new mapping AND pick a new password, if you wish.  The point here is that it turns one-factor authentication (your password) into two-factor authentication, since you theoretically need the sheet AND the internal password to crack the system password.

# The Concerns

It should be noted that this doesn't mean you can pick an internal password of, like, "password" or something.  If someone DID have your sheet, they could mount a typical dictionary attack against the system by simply adding an additional translation to the passwords they try (convert them using all of your password maps).  The fact that you print 20 maps rather than just one is largely irrelevant for real security: it only multiplies the number of attempts required by 20.  This is really just to prevent your co-workers from trying to guess your password.

The first thing you're likely to ask yourself is "isn't it a pain in the neck to look up my password using this sheet every time?"  The answer to that question is "yes, at first."  See, the reason I use two character mappings is that the brain is very good at memorizing pairs of things together.  What you'll find, if you use this system, is that within a day or two of typing your password with the sheet in front of you, you wind up memorizing the **external password** unintentionally.  I've gotten a number of other folks to use this system for their passwords, and they all found that they do, in fact, unintentionally memorize the password.

The next natural question is "what happens if I lose my sheet or can't remember what password I picked?"  If you lose your sheet, you just regenerate it.  The tool I include below allows you to supply a password on the commandline so that, with the same password, you can regenerate the same list.  You shouldn't forget which map you pick, because there aren't that many to choose from, but if you can remember just PART of the external password you'd be able to figure out which map you're using.

# The Code

Here is a relatively small application that you can use to generate your very own password map list.

~~~java
//PasswordMapGenerator.java
package com.air0day.machetejuggling.passwordgenerator;

import java.security.SecureRandom;
import java.util.Map;
import java.util.Random;

/**
 * This is the Password Map Generator application. The
 * default implementations can easily be overridden by your
 * own implementers of the MapGenerator and MapPrinter
 * interfaces if you need more specific rules for passwords
 * or alternative printing mechanisms.
 * 
 * URL: http://blog.air0day.com
 * 
 * @author Rod Hilton
 * 
 */
public class PasswordMapGenerator {
  // These are the characters that can be used in the
  // passwords as the MAP FROM characters.
  private static final String MAP_FROM_CHARS = 
    "abcdefghijklmnopqrstuvwxyz0123456789";

  public static void main(String[] args) {
    // See if there is a seed passphrase on the commandline.
    // If so, use that to seed the RNG, so the list can be
    // regenerated from that seed.
    SecureRandom rand = new SecureRandom();
    if(args.length == 1) {
      rand.setSeed((long) args[0].hashCode());
    }
    else {
      rand.setSeed(System.currentTimeMillis());
    }

    MapGenerator mapGenerator = new DefaultMapGenerator();
    mapGenerator.setSeed(rand);
    mapGenerator.setAlphabet(MAP_FROM_CHARS);

    MapPrinter mapPrinter = new DefaultMapPrinter();
    mapPrinter.print(mapGenerator);
  }
}

interface MapGenerator {
  public void setSeed(Random seed);
  public void setAlphabet(String alphabet);
  public Map<Character, String> generate();
}

interface MapPrinter {
  public void print(MapGenerator mapGenerator);
}
~~~

As you can see, it merely creates a DefaultMapGenerator and DefaultMapPrinter, then uses the latter to print the map generated by the former.  The reason for the separation is so that, if you want to use this, you can write your own classes to replace the default implementations.  Your company may have specific rules about passwords, and a new MapGenerator can help.  Or you may wish to change how things are printed (two ideas are: create a nice printable PDF file OR create a wallpaper for your login screen).  

The default generator is below.  It just creates a basic map of one
character to two random characters.  The only thing special it does is not use characters that look alike for the mappings, since these are likely to be printed:

~~~java
//DefaultMapGenerator.java
package com.air0day.machetejuggling.passwordgenerator;

import java.util.Map;
import java.util.Random;
import java.util.TreeMap;

/**
 * The Default Map Generator simply has a list of characters
 * that are valid for the mapping, and maps each character
 * in the input alphabet to a pair of random characters. The
 * characters that can be mapped to avoid similar- looking
 * characters, such as 1 (one) and l (ell).
 * 
 * @author Rod Hilton
 * 
 */
public class DefaultMapGenerator implements MapGenerator {
  private static final int MAP_LENGTH = 2;
  private static final String MAP_TO_CHARS = "23456789@#$" + 
   "qwertyuiopasdfghjkzxcvbnm"  + "QWERTYUPASDFGHJKLZXCVBNM";

  private Random seed;
  private String alphabet;

  public void setAlphabet(String alphabet) {
    this.alphabet = alphabet;
  }

  public void setSeed(Random seed) {
    this.seed = seed;
  }

  public Map<Character, String> generate() {
    if(alphabet == null || seed == null) {
      throw new IllegalStateException(
          "Generator requires seed and alphabet");
    }

    Map<Character, String> mapping = 
      new TreeMap<Character, String>();

    for (int i = 0; i < alphabet.length(); i++) {
      char curChar = alphabet.charAt(i);
      StringBuilder sb = new StringBuilder();
      for (int j = 0; j < MAP_LENGTH; j++) {
        int randomCharIndex = getRandomNum(MAP_TO_CHARS
            .length());
        char mapChar = MAP_TO_CHARS.charAt(randomCharIndex);
        sb.append(mapChar);
     }

      mapping.put(curChar, sb.toString());
    }

    return mapping;
  }

  private int getRandomNum(int maxVal) {
    return ((int) (seed.nextDouble() * (maxVal)));
  }
}
~~~

And this is the default printer.  It just prints a nice box like the one above to the console:

~~~java
//DefaultMapPrinter.java
package com.air0day.machetejuggling.passwordgenerator;

import java.util.Map;
import java.util.Set;

/**
 * The Default Map Outputter simply prints nicely formatted
 * boxes to the console.
 * 
 * @author Rod Hilton
 * 
 */
public class DefaultMapPrinter implements MapPrinter {
  private static final int MAP_COLUMNS = 4;
  private static final int MAP_NUM = 20;

  private StringBuilder output;

  public void print(MapGenerator mapGenerator) {
    output = new StringBuilder();

    for (int x = 0; x < MAP_NUM; x++) {
      Map passwordMap = mapGenerator.generate();
      addMap(passwordMap);
    }

    System.out.println(output.toString());
  }

  private void addMap(Map<Character, String> passwordMap) {
    // This is kind of a hack just to get the map in the
    // order I like: letters first, followed by non-letters.
    // Since that's a printing preference, it belongs in
    // this class, even if it is kind of ugly.
    Set<character> alphabetSet = passwordMap.keySet();
    StringBuilder nonletters = new StringBuilder();
    StringBuilder letters = new StringBuilder();
    for (Character alphabetCharacter : alphabetSet) {
      if(Character.isLetter(alphabetCharacter))
        letters.append(alphabetCharacter);
      else
        nonletters.append(alphabetCharacter);
    }
    String alphabet = letters.toString()
        + nonletters.toString();

    int cols = (int) Math.ceil(alphabet.length()
        / (double) MAP_COLUMNS);
    int rows = MAP_COLUMNS;

    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        int index = (j * cols) + i;
        output.append("[" + alphabet.charAt(index) + " "
            + passwordMap.get(alphabet.charAt(index))
            + "]  " + ((j == rows - 1) ? "\n" : ""));
      }
    }

    output.append("\n\n");
  }
}
~~~

Of course, you can download a [fully compiled version](/files/PasswordGenerator.zip) that should run fine as long as you have a Java 5 JRE installed correctly.

Enjoy!  If anyone out there sees any glaring flaws with this system, please let me know via a comment.