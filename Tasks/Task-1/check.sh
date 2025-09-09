#!/bin/bash

# Task 1 Testing Script
# Created by: Eyad Farouk

# Task status:
START_DIR=$(pwd)
readonly CORRECT=0
readonly INCORRECT=1
readonly ERROR=2

# Write your code between START and END lines.
# Do not remove any code or comments.
# You can add any notes here if you'd like.

# Need to check for ls
# Need to check if the file is there but with wrong capitals or smalls

# /--------- Helper Functions ------------/
file_exists() {
    [[ -f "$1" ]] || {  return 1; }
}

dir_exists() {
    [[ -d "$1" ]] || { return 1; }
}
advance_step() {
	((steps++))
	echo "[✓] Step $1 is correct!"
}

# /--------- Test Setup ------------/
setup() {
	# Include any starter code needed to execute the test. Assume you are inside the task repo (github-username/repo-name) and move from there. 
	# If you fail to find a folder that should've been there, or fail to set up for grading, return 3
	
	echo "Setting up task environment..."
	chmod +x restart.sh solution.sh
	"./restart.sh" || { echo "Failed to set up the task"; return $ERROR; }
	cd "$START_DIR"

	echo "Running your solution..."
	"./solution.sh" || { echo "Failed to run solution"; return $ERROR; }
}

# /-------- Test Execution ---------/
test() {
	echo "Executing test..."
	# Grade the actual task
	# Return 1 if the task is correct
	# Return 2 if the task is incorrect
	# START
	cd $START_DIR

	steps=0
	first_cmd=$(head -n 1 solution.sh | xargs)

	if ! [[ -s solution.sh ]]; then
		echo "[✗] Solution file is empty."
			return $ERROR

	elif [[ "$first_cmd" != "pwd" ]]; then
		echo "[✗] Write the command you used to print where you are."
	else
		advance_step 1
	fi


	# Not checking ls


	cd gate-1
	if (file_exists "trap"); then
		echo "[✗] A trap is still there in gate-1. You need to remove it."
	elif (! file_exists "key"); then
		echo "[✗] There is no key inside the first gate. If you moved it to gate-1 instead of copying it, copy it back to gate-1. "
	else
		advance_step 2
	fi

	cd gate-2
	if (file_exists "closed"); then 
		echo "[✗] Rename closed to open"		
	elif (! file_exists "key"); then
		echo "[✗] There is no key inside gate-2. Copy it from gate-1. "
	else
		advance_step 3
	fi
	cd gate-3

	if (! file_exists "open"); then
		echo "[✗] You forgot to move open from gate-2 to gate-3."
	elif (file_exists "trap"); then
		echo "[✗] A trap is still there in gate-3. You need to remove it."
	else
		advance_step 4
	fi

	cd gate-4
	if (dir_exists "dimension-x") || (dir_exists "dimension-y"); then
		echo "[✗] Dimension X and/or Y is still inside the fourth gate. Remove it"
	else
		advance_step 5
	fi

	cd earth
	if (! dir_exists "home"); then
		echo "[✗] You didn't rebuild your home! Create a directory named home inside earth."
	else
		advance_step 6
		cd home
		if (! file_exists "bed"); then
			echo "[✗] You forgot to build a bed, how will you sleep? Create a file named bed inside home."
		else
			advance_step 7
		fi
	fi

	cd $START_DIR
	
	if [[ $steps -eq 7 ]]; then
		echo "All steps completed successfully!"
		return $CORRECT
	else
		echo "Not all steps were completed! Solve the errors and try again."
		return $INCORRECT
	fi
	# END
}

# /--------- Test Cleanup ----------/
cleanup() {
	echo "Cleaning up..."
	# If you need to do any cleanup after grading the task, do it here
	# START
	"./restart.sh" || { echo "Failed to complete cleanup. Please run './restart.sh"; return $ERROR; }

	# END
}

# /------------- Main -------------/
setup || exit $ERROR
test
RESULT=$?
cleanup
exit $RESULT
