Build'em quick, Build'em right
==============================

Build'em is a small little script parser that is intended for large build systems.

[![Code Climate](https://codeclimate.com/github/jeremywrowe/buildem.png)](https://codeclimate.com/github/jeremywrowe/buildem) 
[![Dependency Status](https://gemnasium.com/jeremywrowe/buildem.png)](https://gemnasium.com/jeremywrowe/buildem)
[![Build Status](https://secure.travis-ci.org/jeremywrowe/buildem.png)](http://travis-ci.org/jeremywrowe/buildem) 

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

	unordered do
		queued_run "./some_task.sh"
		queued_run "./some_task1.sh"  # All of these items will be executed at the same time
		queued_run "./some_task2.sh"
	end
   
*IMPORTANT*  All queued\_run tasks must be inside of an unordered block if you want them to run at the same time. If you use run for a task, it will block to complete.
That being said you can inject ordered tasks in the middle of unordered tasks by using run instead of using qeueued_run if you wish to.

* Configuration
To set the worker amount for unordered tasks before the unordered block do $configuration.workers = 10 to get 10 nano-bots working for you.

Example:

	$configuration.workers = 5
	unordered do
		....
	end
	
This will give you 5 nano-bots for your unordered tasks

optional run and queued_run options
--------------------------
* :retry\_amount    (Integer that specifies that you want to retry the execution of the provided command. Default is 1 execution.)
* :retry\_condition (Integer, regular expression, or string that specifies what a good execution is. Default is 0 if not specified.)
* :quit\_on\_error  (Boolean that specifies if build'em should quit when an exception happens executing the provided command. Default is true)

**Notice** If the retry\_condition is not met within the retry\_amount interval an error will be throw unless :quit\_on\_error is set to false

Logging
-------
If you wish to log all of the output to a specific file you can do so with an output\_to block

Example:

	output_to "my_nifty_output_file.txt" do
		run "./task.sh"
		run "./another.sh"
		unordered do
			queued_run "./some_task.sh"
			queued_run "./some_task1.sh"
			queued_run "./some_task2.sh"
		end
	end
	
* output\_to parameters

filename: The filename that you wish to output to (optional, default is output.log)
IO capture: possible values :stdout, :stderr etc (optional, default is :stdout)
	
	output_to do ... will save all stdout output to output.log
	output_to "another_file.txt" do ... same as above but would be saved to another_file.txt
	output_to "err.txt", :stderr do ... will output all stderr to err

--------------------------------------------------

What follows is the modified MIT License that applies to Buildem

Copyright © 2011 Jeremy Rowe (http://jeremyrowe.com)

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sub-license, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice, and every other copyright notice found in this software, and all the attributions in every file, and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

