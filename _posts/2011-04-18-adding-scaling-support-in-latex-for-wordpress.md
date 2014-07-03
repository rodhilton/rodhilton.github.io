---
layout: post
title: Adding Scaling Support in Latex for Wordpress
category: Programming
tags:
- blog
- code
- computer science
- latex
- math
- open source
- patch
- wordpress
status: publish
type: post
published: true
---

There's a great WordPress plugin called [Latex for Wordpress](http://wordpress.org/extend/plugins/latex/).  It's less popular than the similar [WP Latex](http://wordpress.org/extend/plugins/wp-latex/), but I think it's better.

Both plugins allow Wordpress users to insert $$\LaTeX$$ into their posts, but the main reason why the former is superior is that, while both plugins generate image files containing processed text, Latex for Wordpress augments this functionality with [MathJax](http://www.mathjax.org/), a client-side JavaScript $$\LaTeX$$ renderer.  MathJax is the primary means of rendering, with png files as a fallback.  This means that $$\LaTeX$$ renders much more cleanly.

Unfortunately, Latex for Wordpress does not provide an option to provide custom config options to MathJax.  This is a problem, since my blog uses a large font for text, and the default text scaling size is very small.  I needed a way to use the [MathJax config](http://www.mathjax.org/docs/1.1/options/HTML-CSS.html) to adjust the text scale.

I went ahead and patched this functionality into Latex for Wordpress.  So far, I have been unable to figure out how to commit this patch to the maintainer of the project, so until I am able to do that I'm posting it here.

This is a standard patch file, simply save it and apply the patch to the directory to which Latex for Wordpress has been extracted (inside of your wordpress plugins directory).  The patch runs against version [3.04 of Latex for Wordpress](http://wordpress.org/extend/plugins/latex/download/), hopefully I can get this patch merged in before a new version is released.

~~~
diff --git a/latex-admin.php b/latex-admin.php
index e5bb652..87d2b90 100644
--- a/latex-admin.php
+++ b/latex-admin.php
@@ -13,6 +13,7 @@ if (!is_dir(get_option("latex_cache_path")))
 <?php

 if (isset($_REQUEST["update_latex_option"])){
+        update_option("mathjax_config", $_REQUEST["mathjax_config"]);
 	update_option("latex_imgcss", $_REQUEST["latex_imgcss"]);
 	if ($_REQUEST["latex_img_server"] != "custom")
 		update_option("latex_img_server", $_REQUEST["latex_img_server"]);
@@ -125,9 +126,19 @@ if (isset($_REQUEST["update_latex_option"])){
 			 <?php echo get_option('mathjax_server')==''?'checked="checked"':'';?>
 			value="" class="tog">Turn off</label></th>
 			<td>Displaying fourmula as images is good enough for me, and I don't want to use MathJax.</td>
-		</tr>
+		</tr>
+<tr>
+                        <th scope="row">Custom Config for MathJax</th>
+                        <td>
+                                <textarea name="mathjax_config" rows="4" cols="50"><?php echo get_option('mathjax_config');?></textarea><br/>
+For more information, consult the <a href="http://www.mathjax.org/docs/1.1/options/HTML-CSS.html">MathJax Config</a> documentation.
+
+			</td>
+
+                </tr>
+
 	</tbody></table>
-
+

 	<p class="submit"><input type="submit" name='update_latex_option' class="button-primary" value="Update LaTeX Options"></p>
 	</form>
@@ -140,4 +151,4 @@ if (isset($_REQUEST["update_latex_option"])){
 		you need to delete your caches before the images are refreshing.</p>
 		<p class="submit"><input type="submit" name='delete_cache' class="button-primary" value="Delete LaTex Caches"></p>
 	</form>
-</div>
\ No newline at end of file
+</div>
diff --git a/latex.php b/latex.php
index 1094c15..ce46e15 100644
--- a/latex.php
+++ b/latex.php
@@ -65,6 +65,7 @@ function latex_for_wp_activate() {
 		update_option("mathjax_server", "http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=default");
 //	if (get_option("latex_cache_path") == FALSE )
 		update_option("latex_cache_path", ABSPATH."wp-content/plugins/latex/cache/");
+		update_option("mathjax_config", "scale:85");
 }

 register_activation_hook( __FILE__, 'latex_for_wp_activate' );
@@ -173,7 +174,7 @@ function add_latex_mathjax_code(){
 	echo '<script type="text/x-mathjax-config">
 		MathJax.Hub.Config({
 		"HTML-CSS": {
-			scale: 85
+			'.get_option("mathjax_config").'
 		}
 	});</script>
 	<script type="text/javascript" src="'.get_option("mathjax_server").'"></script>';
@@ -192,4 +193,4 @@ $latex_qmr_work_tags = array(
 foreach ( $latex_qmr_work_tags as $latex_qmr_work_tag ) {
 	remove_filter ($latex_qmr_work_tag, 'wptexturize');
 }
-?>
\ No newline at end of file
+?>

~~~

I used this to set my scale to 110.  The scale factor prior to the patch (and the current default) is 85.

$$!\int_0^\infty e^{-x^2} dx=\frac{\sqrt{\pi}}{2}$$

Ahh, much better.

Enjoy!

