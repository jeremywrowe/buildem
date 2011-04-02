Build'em quick, Build'em right
==============================

Build'em is a small little script parser that is intended for large build systems.
Build'em is still very young :) so be careful using it.  Input is always welcome and if there is a feature that you just half to have i'd probably do it.


Features:
---------
	
Execution:
Scripts go in a plain text file, I use my\_very\_important\_task.buildem
and then simply call buildem my\_very\_important\_task.buildem
	
* Build'em supports sequential tasks (tasks that go in order)
	
Example:
	run "./task.sh"
	run "./another.sh" #another.sh waits for task.sh to complete

* Build'em supports a work queue, what does this mean?
This means that you can run tasks concurrently, easily.

Example:

	unorderd do
		queued_run "./some_task.sh"
		queued_run "./some_task1.sh"  # All of these items will be executed at the same time
		queued_run "./some_task2.sh"
	end
   
*IMPORTANT*  All queued\_run tasks must be inside of an unorderd block if you want them to run at the same time. If you use run for a task, it will block to complete.
That being said you can inject ordered tasks in the middle of unorderd tasks by using run instead of using qeueued_run if you wish to.

* Configuration
To set the worker amount for unorderd tasks before the unorderd block do $configuration.workers = 10 to get 10 nano-bots working for you.

Example:

	$configuration.workers = 5
	unorderd do
		....
	end
	
This will give you 5 nano-bots for your unordered tasks


optional run and queued_run options
--------------------------
* :retry\_amount    (Integer that specifies that you want to retry the execution of the provided command. Default is 1 execution.)
* :retry\_condition (Integer, regular expression, or string that specifies what a good execution is. Default is 0 if not specified.)
* :quit\_on\_error  (Boolean that specifies if build'em should quit when an exception happens executing the provided command. Default is true)


