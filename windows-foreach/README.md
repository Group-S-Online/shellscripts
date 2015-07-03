Foreach Usage
============

## Why would you use windows-foreach?
Often, it is necessary to perform the same set of operations on a list of repositories. This set of scripts makes it possible to do just that. Feel free to inspire yourself from those scripts.

## How do you install windows-foreach?
Add the folder containing the scripts to your PATH environment variable. Instructions for doing this are easily found on the web.

## How do you use windows-foreach?
To execute a single command on all subfolders of the current folder:

    foreach-dir dir *.html
    
To execute a single command on all subfolders being git repositories:

    foeach-git git pull

To execute a single command on all subfolders being grunt projects:

    foreach-grunt grunt --latest --no-deploy

To execute more than one command, I recommend adding a new bat/sh script to your PATH and running this one instead. I have a "do-something.bat" file in my PATH folder which I use to put scripts temporarily without having to bother creating new files.

    foreach-git do-something
   
