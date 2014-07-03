---
layout: post
title: 'How To: Convert Audible .aa Files to .mp3 Quickly'
category: Technology
tags:
- audible
- audio books
- book
- code
- conversion
- music
- ruby
status: publish
type: post
published: true
---

I do not belong to the cult of iPod.  I use a nonstandard mp3 player and I hate iTunes.  If I'm going to use an mp3 player, it needs to show up as a USB drive on my Linux workstation, my Windows desktop, and my Mac laptop.  I need to be able to drag files over and be done with it.  So far, I've been successful at accomplishing this.

But the simplicity comes with a price.  I cannot download books from [Audible.com](http://www.audible.com) and put them on my player to listen to them.  I have to convert all of the files I download from Audible into DRM-free mp3 files.  There are lots of ways to do this, and even software tools that will do this automatically, but **all of them just play the file in iTunes and capture the audio stream to a file**.  I want something completely digital, which can run in the background without me having to worry about my operating system making other sounds that interfere with the result.

I have developed an alternative to this method, which lets you convert your Audible audio book downloads to DRM-free mp3s in just a few minutes, with a very small amount of manual work.

# You Will Need

 * Windows (sorry, the programs needed only run in Windows)
 * [Nero](http://www.nero.com/enu/store-nero9.html) for Windows (cost: $70, free trial available) **Note:** Do not use versions later than 9.4.  Apparently the functionality this tutorial depends on has been removed.
 * [UltraISO](http://www.ezbsystems.com/ultraiso/) for Windows (cost: $30, free trial available)
 * [Ruby](http://rubyinstaller.rubyforge.org/wiki/wiki.pl) for Windows (free)
 * [Lame](http://www.free-codecs.com/download/Lame_Encoder.htm) for Windows (free)
 * An [Audible.com](http://www.audible.com) account
 * Some patience

# Step 1: Download The .aa Files

On Audible.com, find the book you want and download it.  Make sure that it downloads using the Audible Download Manager and results in you getting .aa files for the book.  If Audible tries to make you download something else, you may have to add a new device on Audible.com.  Pick something simple (not an iPod) and select 'Format 4' for the desired type.

# Step 2: Burn to images using Nero

Once you have your .aa file (or two), open up Nero.

Create a new compilation, select 'CD' as the type, and scroll down to 'Audiobook CD'

{% image nero_audiobookselect-580x437.png caption="Selecting the Audiobook Type" %}

Now drag your .aa file into the Nero.  Select 'Image Recorder' from the list of recorders.  Then click Burn.

{% image nero_compilation1-580x452.png caption="Nero Compilation Screen" %}

Before the 'discs' start burning, you'll be asked for a name.  The default, "Image' is probably fine.  **Make sure you are saving into a COMPLETELY EMPTY directory.**

You will be asked if you want to manually select new file names or Autocreate them.  Choose auto create so you can do something else while they are 'burning'. 

The goal here is to get the .aa files, which represent multiple burnable discs, into .nrg files, one file for each 'disc'.  You'll have to do this step once for every .aa file in your book (long books sometimes have two .aa files).  This is the most manual part of the process, after this it's smooth sailing.

# Step 3: Convert to mp3

Now, you have a directory somewhere that contains files that look like Image.nrg, Image02.nrg, Image03.nrg, etc.  Let's call that directory `C:\MyBook` for the purposes of this tutorial.

You will need to install some more software before you can proceed.  Download and install UltraISO and Lame (links above).  Let's assume you have installed those to `C:\Program Files\UltraISO\` and `C:\Program Files\Lame\`, respectively.  Also make sure you install Ruby.

You will also need to download this ruby script that I wrote (click 'view source' in the top right, copy the contents, and paste into a new file using notepad):

~~~ruby
# Written by Rod Hilton, nomachetejuggling.com
# Modify these to be the paths to your copies of ultraiso.exe and lame.exe.
# Remember to do \\ for backslashes, and don't use /

ULTRAISO_PATH = "c:\\program files\\ultraiso\\ultraiso.exe"
LAME_PATH = "c:\\program files\\lame\\lame.exe"

# Read the directory to convert from the command line.

@workingdir = ARGV[0]
if @workingdir.nil? or not File.directory?(@workingdir)
	abort "Usage: ruby #{File.basename(__FILE__)} <path to directory>"
end

# Deletes a file

def delete(filepath)
	shortname = File.basename(filepath).slice(0..50)
	print "  Deleting #{shortname}...";
	print File.delete(filepath) ? "Done!\n" : "Failed!\n"
end

# Convert method.  Converts all files in the working directory with

# a specific extension using a function block

def convert(extension, options = {}, &amp;function)
	Dir.foreach(@workingdir) do |file|
		if(file.match(/.#{extension}$/))
			filepath = File.join(@workingdir, file)
			command = function.call(filepath)
			print "  Converting #{file.slice(0..50)}..."
			retval = system command
			if(retval)
				print "Done!\n"
				delete(filepath) if options[:delete_after]
			else
				abort "Failed!"
			end
		end
	end
end

puts "--Converting in #{@workingdir}--"

puts "Converting all .nrg files to .wav files..."
convert("nrg", :delete_after=>true) do |filepath|
	"\"#{ULTRAISO_PATH}\" -in \"#{filepath}\" -extract \"#{@workingdir}\""
end

puts "Converting all .wav files to .mp3 files..."
convert("wav", :delete_after=>true) do |filepath|
	"\"#{LAME_PATH}\" --abr 56 -mm -S \"#{filepath}\""
end
~~~

This script basically uses UltraISO to extract .wav files from the .nrg files, then uses lame to convert the .wav files to .mp3 files.

If you installed UltraISO or Lame to different directories, change the top few lines to reflect their real paths.

Let's assume you saved this file to `C:\nrg2mp3.rb`.

Now, open up a command prompt (Start->Run->type 'cmd' and hit enter).  Type:

~~~terminal
$ ruby C:\nrg2mp3.rb "C:\MyBook"
~~~

Make sure that you use the quotes if you have spaces in your directory name.

Now just sit back and wait.  The script will convert all of the nrg files to mp3 files.  It will delete all of the .nrg files when it is done with them.  If you'd like to tell the script not to do that, modify line 43 to remove the :delete_after stuff, like so:

~~~ruby
convert("nrg") do |filepath|
~~~

There are lots of ways to do this, but I believe this one involves the fewest number of manual steps, and I believe it is the only method that does no analog conversion (no recording your sound card as the file plays).  It is also, as far as I'm aware, the fastest method.  Ripping the wavs out using UltraISO only takes a few seconds for me, and converting them to mp3 doesn't take very long at all.

If you can think of a way to make this process faster and require fewer non-free programs (or, ideally, a way to make this work in Linux), leave a comment.

