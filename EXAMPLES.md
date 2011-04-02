Worker configuration, and unordered tasks
-----------------------------------------

	$configuration.workers = 2
	
	run "initialize.sh"
	run "clean.sh"
	
	unordered do
	  queued_run "job1.sh"
	  queued_run "job2.sh"
	  queued_run "job3.sh"
	  run "some_task_in_the_middle_of_queue.sh" # this will block all of the queued_run calls after this
	  queued_run "job4.sh"
	  queued_run "job5.sh"
	  queued_run "job6.sh"
	end
	
	run "do_something_at_the_end.sh"
This example will execute job 1 - 3 in any order two at a time, hit some\_task\_in\_the\_middle\_of\_queue run that wait for it to complete and then continue executing job 4 - 6 two at a time.
	
---	
	
	
Worker configuration, and unordered tasks with options
------------------------------------------------------
	
	run "initialize.sh"
	run "clean.sh", :retry_amount => 10  # The default exitstatus for commands is 0, when specifying retry amount of 10 if the run command does not return 0 it will retry up to 10 times.
	run "do_something_at_the_end.sh", {:retry_amount => 10, :retry_condition => 99}  # Same as above, but is considered successful if the exitstatus is 99 due to the supplied retry_condition.
	run "danger_danger_danger", :quit_on_error => false # If a task has explosive behavior (It causes an exception) :quit_on_error => false can be supplied as an option to continue execution 
														# regardless of problems.
	
These options can be applied to both queued_run, and run jobs.