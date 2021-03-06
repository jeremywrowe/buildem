# -*- ruby -*-
# Adapted from PeepCode RSpec screencast no 1,
# who got it from someone else!
# Adapted with tip from http://ph7spot.com/articles/getting_started_with_autotest
# by DitoCujo (http://ditoinfo.wordpress.com)
module Autotest::GnomeNotify
  EXPIRATION_IN_SECONDS = 5
  ERROR_ICON = "gtk-dialog-error"
  SUCCESS_ICON = "gtk-dialog-info"
  def self.notify(title, msg, icon)
    options = "-t #{EXPIRATION_IN_SECONDS * 1000} -i #{icon}"
    system "notify-send #{options} '#{title}' '#{msg}'"
  end
  Autotest.add_hook :ran_command do |at|
    results = [at.results].flatten.join("\n")
    output = results.slice(/(\d+)\s+examples?,\s*(\d+)\s+failures?(,\s*(\d+)\s+not implemented)?/)
    if output
      if $~[2].to_i > 0
        notify "FAIL", "#{output}", ERROR_ICON
      else
        notify "Success!", "#{output}", SUCCESS_ICON
      end
    end
  end
end

