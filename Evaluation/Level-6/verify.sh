#!/bin/bash

# Task 6 Testing Script part 1
# Created by: Samir Ahmed

# Task status:
readonly CORRECT=0
readonly INCORRECT=1
readonly ERROR=2

TEST='/tmp/minning'

# Write your code between START and END lines.
# Do not remove any code or comments.
# You can add any notes here if you'd like.

# /--------- Helper Functions ------------/
file_exists() {
    [[ -f "$1" ]] || { echo "Required file not found: $1"; return 1; }
}

dir_exists() {
    [[ -d "$1" ]] || { log_error "Required directory not found: $1"; return 1; }
}

# /--------- Test Setup ------------/
setup() {
	# Include any starter code needed to execute the test. Assume you are inside the task repo (github-username/repo-name) and move from there. 
	# If you fail to find a folder that should've been there, or fail to set up for grading, return 3
	echo "Setting up task environment..."
	# START
	touch "$TEST" || return $ERROR
	# END
}
display_key() {
    # chang the part uniqSecrect to unique part for the level
    # Call this function to display the key for the level on successful completion
    # Replace N with the level number

    echo "CONGRATULATIONS! You have completed first part of Level #6."
    echo "GO Ahead and continue"
}

# /-------- Test Execution ---------/
test() {
    echo "Executing test..."

    # Check if processes exist
    if pgrep -f man >/dev/null && pgrep -f sleep >/dev/null; then
	    echo [OK] man and sleep are both running
        # Both running, now check suspension state of man
        if is_suspended man; then
            echo "[OK] man is suspended"
            display_key
            echo 'dGhpcyBub3Qgb2YgeW91ciBidXNpbmVzcw==' > $TEST
            return $CORRECT
        else
            echo "[FAILED] man is running but not suspended"
            cleanup
            return $INCORRECT
        fi
    else
        echo "[FAILED] required processes are not running"
        cleanup
        return $INCORRECT
    fi
}

# accept name of process and return 0 or 1 for true/false respectively
is_suspended() {
    local pname="$1"
    local pid
    pid=$(pgrep -x "$pname" | head -n 1)

    if [ -n "$pid" ] && [ -d "/proc/$pid" ]; then
        local state
        state=$(awk '{print $3}' /proc/"$pid"/stat)
        [[ "$state" == "T" ]]
    else
        return 1
    fi
}

# /--------- Test Cleanup ----------/
cleanup() {
	echo "Cleaning up..."
	# If you need to do any cleanup after grading the task, do it here
	# START
	rm $TEST
	# END
}

# /------------- Main -------------/
setup || exit $ERROR
test
RESULT=$?
exit $RESULT
