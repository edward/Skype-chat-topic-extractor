# 
#  skype_topic_extractor.rb
#  skype_topic_extractor
#  
#  Created by Edward Ocampo-Gooding on 2009-05-16.
#  Copyright 2009 Edward Ocampo-Gooding. All rights reserved.
#  Licensed under the MIT license
# 
# 
#  EXAMPLE USAGE
#    $ ruby skype_topic_extractor.rb chatmsg256.dbb
#                     - or -
#    $ ruby skype_topic_extractor.rb /Users/edward/Library/Application\ Support/Skype/edward.og/chatmsg256.dbb
# 
# (or something along those lines; you just need to feed it the chatmsg256.dbb log file.)
# 

def extract_topic(block)
  block[/\374\003(.+)\000\000\361\003\005\000\003/, 1]
end

dbb_file = ARGV[0]

File.open(dbb_file, 'rb') do |f|
  loop do
    break if f.eof?
    topic = extract_topic(f.read(256))
    puts topic unless topic.nil?
  end
end