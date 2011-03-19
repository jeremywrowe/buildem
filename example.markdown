configuration.workers 2
configuration.output_file "output.out"
configuration.error_file "errors.out"

run "initialize.sh"
run "clean.sh"

unorderd do
  run "build.sh"
  run "checkin.sh"
  run "publish.sh", :output => "publish_output.out", :errors => "publish_errors.out"
end

...
run "do_something_at_the_end.sh"