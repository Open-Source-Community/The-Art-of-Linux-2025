#!/bin/bash

# Task #5 Testing Script
# Created by: A Ghost

# Task status:
readonly CORRECT=0
readonly INCORRECT=1
readonly ERROR=2

# Write your code between START and END lines.
# Do not remove any code or comments.
# You can add any notes here if you'd like.

# /--------- Helper Functions ------------/

log_error() {
    local ts
    ts="$(date +'%Y-%m-%d %H:%M:%S')"
    echo "[$ts] ERROR: $*" >&2
}
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
    dir_exists Task || return 3;
    file_exists ./Task/mixed.zip || return 3;
    file_exists ./Task/records.zip || return 3;
    file_exists ./Task/mixed.txt || return 3;
    file_exists ./Task/records.txt || return 3;
    
    # END
}

# /-------- Test Execution ---------/
test() {
    echo "Executing test..."
    # Grade the actual task
    # Return 1 if the task is correct
    # Return 2 if the task is incorrect
    # START
    file_exists ./Task/solution.txt || return 1;
    if [[ $(sha256sum ./Task/solution.txt | cut -d ' ' -f1) == "47a816cffc841a049b7de0e80c4a1f1a582c6b5896e3dce021a4948c2633a841" ]]
    then
        echo "Task 1 Pass!"
        file_exists ./Task/solution2.txt || return 1;
        if [[ $(sha256sum ./Task/solution2.txt | cut -d ' ' -f1) == "72a3d411e83c6e04951df996b5295b5092e1a5836a0d847d4c06134de4f7571a" ]]
        then
            echo "Task 2 Pass!"
            echo "Congratulations!"
            return 0;
        fi
        echo "Task 2 Incorrect!"
        return 1;
    fi
    echo "Incorrect Answer!"
    return 1;
    # END
}

# /--------- Test Cleanup ----------/
cleanup() {
    echo "Cleaning up..."
    # If you need to do any cleanup after grading the task, do it here
    # START
    :
    # END
}

# /------------- Main -------------/
setup || exit $ERROR
test
RESULT=$?
cleanup
exit $RESULT
