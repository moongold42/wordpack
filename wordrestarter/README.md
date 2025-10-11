# wordrestarter
a program that converts a video to a "But every next word restarts" video  
  
## REQUIREMENTS  
ffmpeg and lua  
you can find out how to install them by googling something like "how to install lua in windows", if you don't have them   
  
## HOW TO INSTALL WORDRESTARTER  
first, click the green code button and then click "download zip"  
then, extract the zip file  
optionally, remove the version that you're not gonna use -- bash if you're using windows, or cmd if you're using linux/macOs  
  
## HOW TO USE WORDRESTARTER  
before you start, make sure that you have matching video and .srt caption files INSIDE the wordrestarter folder.  
if you have a video, but no captions, you can follow these 2 approaches:  
1. manually make the subtitles in a editor, like **[Aegisub](https://aegisub.org/)**
2. automatically make subtitles using a program like **[Buzz](https://github.com/chidiwilliams/buzz/releases)**, then fix the mistakes with an editor  

the subtitles have to be separated word-by-ord, with no overlap
  
**WARNING: CHECK IF YOUR .srt FILE IS USING THE DOT (.) AS THE DECIMAL SEPERATOR. IF IT'S SOMETHING ELSE -- LIKE A COMMA (,) -- PLEASE ALTER IT TO A DOT.**

now, let's start the program!  
### for cmd (windows)  
  
open the cmd terminal  
change the directory to wordrestarter using "cd path/to/wordrestarter-cmd"  
type "lua main.lua"  
and then follow the program's requests  
you're done!  
  
### for bash (macOs, linux)  
  
open the bash terminal (probably your default terminal)  
change the directory to wordrestarter using "cd path/to/wordrestarter-bash"  
type "lua main.lua"  
and then follow the program's requests  
you're done!  
  
  
**if you just want to experiment the program, you can type "test.mp4" and "test.srt"** 
