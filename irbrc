#require "rubygems"
#require "pp"
#require "wirble"
#require "irbtools"
#require "irbtools/configure"
#require "kconv"
#require "irb/completion"
#require "what_methods"

#Wirble.init(:skip_prompt => :DEFAULT)
#Wirble.colorize

#Irbtools.libraries -= %w(fileutils hirb)
#Irbtools.start

require 'irb/completion'
IRB.conf[:SAVE_HISTORY] = 100
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb-save-history"

IRB.conf[:PROMPT][:DEFAULT] = {
  :PROMPT_I=>"%N(%m):%03n:%i> ",
  :PROMPT_N=>"%N(%m):%03n:%i> ",
  :PROMPT_S=>"%N(%m):%03n:%i%l ",
  :PROMPT_C=>"%N(%m):%03n:%i* ",
  :RETURN=>"=> %s\n"
}

begin
  require 'wirb'
  Wirb.start
rescue LoadError
end
