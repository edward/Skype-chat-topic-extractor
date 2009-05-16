Story
=====

  I used to work with this great team who used a Skype chat as their primary channel of communication. A nice feature was that it would maintain history for you, and it was easy to jump to voice or whatever.
  
  However, I think the key feature was that you could set the chat topic to hilarious and pithy phrases that generally made me laugh till I had to sit down in the bathroom. You might not get them, but I’m a sucker for non-sequiturs and surrealist humour.
  
  Or something. Whatever.
  
  Tonight, I was looking for a way of pilfering just these "Someone set topic to [DISCO STICK]" posts from the logs, and discovered that Skype keeps them in these binary files.
  
  Clearly, this was a venture worth delving into.

METHOD TO MADNESS
=================

  I looked around on Google and found this piece of [gold][1]; a dissection of the hex in Skype chat logs (these dbb files), which gave me a leg up in trying to remember what it’s like to mess around in binary files.
  
  Being a poking-and-proding-and-seeing-what-happens sort of learner, I equipped myself with said knowledge, and went to town with [Hex Fiend][2], which is now among my favourite tools ever. It’s really well designed, really fast, and surprised me in many a good way in using it. Give it a shot if you ever have to do something like this.
  
GOING TO TOWN
=============

  I ended up just switching between Skype (to find example topic strings) and Hex Fiend (to see where they were), and compared the hex. Carefully selecting the ascii-representation column in HF and watching where that showed up in the hex helped pick out delimiters and segments that stayed the same between the 256 byte hex-dumps of posts I knew contained topic-setting strings.
  
  Basically: compare two posts in hex, find the ascii topic string, lop off the parts before and after in the 256 byte dump that you know belong to every post, and carefully compare the rest. You’re looking for something that doesn’t change between the posts that set the topic, and aren’t there for non-topic-setting posts.
  
DONE
====

  Eventually, I found the pattern:
  
      FC 03 [the awesome topic string] 00 00 F1 03 05 00 03
  
  or as Ruby Strings know it:
  
      "\374\003[the awesome topic]\000\000\361\003\005\000\003"
  
  Writing some Ruby to extract that topic was pretty trivial. See `skype_topic_extractor.rb`

OTHER NOTES
===========
  
  I also found [this blog post](http://bryon.tumblr.com/post/63704878/parse-skype-dbb-with-ruby) about parsing these dbb files with Ruby, but it didn’t mention anything about grabbing the topics specifically. It also runs forever. Maybe opening the file in binary mode helps?

  [1]: http://www.ndmteam.com/en/node/30 "Skype Chat Logs Dissection"
  [2]: (http://www.ridiculousfish.com/hexfiend/) "Hex Fiend"