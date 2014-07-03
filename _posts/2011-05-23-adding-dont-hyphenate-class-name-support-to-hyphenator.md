---
layout: post
title: Adding 'Dont Hyphenate Classname" Support to Hyphenator
category: Programming
tags:
- blog
- code
- formatting
- patch
- wordpress
status: publish
type: post
published: true
---

The Wordpress [Hyphenator](http://wordpress.org/extend/plugins/hyphenator/") plugin is a great plugin that uses [Hyphenator.js](http://code.google.com/p/hyphenator/") to perform client-side hyphenation of blog posts.  I think this makes full-justified posts look much nicer, and I use it extensively on this site.

Hyphenator.js relies on being told what classnames to look for in a page to know what can be hyphenated, but it also has an option called `donthyphenateclassname` which allows one to specify classnames that never get hyphenated, even when they are inside of a class that ought to be.

Unfortunately, the Hyphenator Wordpress plugin does not support this option.  I needed support for it, so I added it.  I don't really know of a place to submit this patch, so I'm posting it here.  This patch has been applied to [version 3.2.0 of Hyphenator](http://wordpress.org/extend/plugins/hyphenator/download/").

~~~patch
diff --git a/options.php b/options.php
index 7e0d5e8..ce3a966 100644
--- a/options.php
+++ b/options.php
@@ -41,7 +41,7 @@ $hyphenator_langindex = array(
 );

 // list of option names (without "languages")
-$hyphenator_options = array("classname", "minwordlenght", "addexceptions", "displaytogglebox", "hypenchar", "usetrunk", "intermediatestate");
+$hyphenator_options = array("classname", "donthyphenateclassname", "minwordlenght", "addexceptions", "displaytogglebox", "hypenchar", "usetrunk", "intermediatestate");

 // check for admin options submission and update options
 if ('process' == $_POST['stage']) {
@@ -126,7 +126,11 @@ jQuery(document).ready(function() {
    <label for="opt1"><?php _e('class name of content to hyphenate', 'hyphenator') ?></label>
     <input id="opt1" name="hyphenator_classname" type="text" size="10" value="<?php echo $hyphenator_['classname'] ?>" />
     <p><small><?php _e('default', 'hyphenator'); echo ": hyphenate" ?></small></p>
-
+
+    <label for="opt3"><?php _e('class name of content to never hyphenate', 'hyphenator') ?></label>
+    <input id="opt3" name="hyphenator_donthyphenateclassname" type="text" size="10" value="<?php echo $hyphenator_['donthyphenateclassname'] ?>" />
+    <p><small><?php _e('default', 'hyphenator'); echo ": donthyphenate" ?></small></p>
+
    <label for="opt2"><?php _e('minimal length of words', 'hyphenator') ?></label>
     <input id="opt2" name="hyphenator_minwordlenght" type="text" size="10" value="<?php echo $hyphenator_['minwordlenght'] ?>" />
     <p><small><?php _e('default', 'hyphenator'); echo ": 6"; ?></small></p>
diff --git a/plugin.php b/plugin.php
index 0d2aad0..665e299 100644
--- a/plugin.php
+++ b/plugin.php
@@ -20,6 +20,7 @@ $hyphenator_options_page = get_option('siteurl') . '/wp-admin/admin.php?page=hyp

 // add default options
 add_option('hyphenator_classname', 'hyphenate');
+add_option('hyphenator_donthyphenateclassname', 'donthyphenate');
 add_option('hyphenator_minwordlenght', '6');
 add_option('hyphenator_languages', 'auto');
 add_option('hyphenator_addexceptions', '');
@@ -46,6 +47,7 @@ add_action('wp_head', 'hyphenator_header');
 function hyphenator_header() {
       // get values
       $hyphenator_classname = get_option('hyphenator_classname');
+       $hyphenator_donthyphenateclassname = get_option('hyphenator_donthyphenateclassname');
       $hyphenator_minwordlenght = get_option('hyphenator_minwordlenght');
       $hyphenator_languages = get_option('hyphenator_languages');
       $hyphenator_addexceptions = get_option('hyphenator_addexceptions');
@@ -82,6 +84,9 @@ function hyphenator_header() {
       if ($hyphenator_classname != '') {
               $hyphenatorHeadConfig .= "\n\t\t\tclassname: '{$hyphenator_classname}',";
       }
+       if ($hyphenator_donthyphenateclassname != '') {
+               $hyphenatorHeadConfig .= "\n\t\t\tdonthyphenateclassname: '{$hyphenator_donthyphenateclassname}',";
+       }
       if ($hyphenator_displaytogglebox == '1') {
               $hyphenatorHeadConfig .= "\n\t\t\tdisplaytogglebox: true,";
       }
--
1.7.3.5
~~~

