#!/bin/bash

# Task #3 Testing Script
# Created by: Hadeer Ramadan
# Modified: Incremental Scoring Version

# Task status:
readonly CORRECT=0
readonly INCORRECT=1
readonly NOTSUBMITTED=2

# --- Test Configuration ---
readonly SOLUTION_FILE="solution.sh"

# /--------- Helper Functions ------------/
log_info()    { echo "[INFO] $1"; }
log_error()   { echo "[ERROR] $1" >&2; }
log_success() { echo "[SUCCESS] $1"; }

file_exists() {
    [[ -f "$1" ]] || { log_error "Required file not found: $1"; return 1; }
}

dir_exists() {
    [[ -d "$1" ]] || { log_error "Required directory not found: $1"; return 1; }
}

user_exists() {
    id "$1" &>/dev/null
}

group_exists() {
    getent group "$1" &>/dev/null
}

user_in_group() {
    groups "$1" | grep -q "\b$2\b"
}

check_sleep_and_grep(){
    local file="$SOLUTION_FILE"
    local sleep_line kill_line

    sleep_line=$(grep -n 'sleep 100' "$file" | cut -d: -f1 | head -n1)
    kill_line=$(grep -n 'kill' "$file" | cut -d: -f1 | head -n1)

    if [[ -n $sleep_line && -n $kill_line && $sleep_line -lt $kill_line ]]; then
        return 0
    else
        return 1
    fi
}

# /--------- Test Setup ------------/
setup() {
    log_info "Setting up task environment..."
    file_exists "$SOLUTION_FILE" || return $NOTSUBMITTED
    return 0
}

# /-------- Test Execution ---------/
test() {
    log_info "Running student solution with command filtering..."
    while IFS= read -r line; do
        if [[ "$line" =~ sudo[[:space:]]+su || "$line" =~ ^[[:space:]]*exit || "$line" =~ ^[[:space:]]*\} ]]; then
            echo "[SKIP] Bypassing problematic command: $line"
            continue
        fi
        if [[ -z "$line" || "$line" =~ ^[[:space:]]*# ]]; then
            continue
        fi
        timeout 10 bash -c "$line" 2>/dev/null || echo "[WARN] Command failed: $line"
    done < "$SOLUTION_FILE"

    log_info "Executing checks..."
    local score=0
    local max_score=9

    # 1. hero user exists
    if user_exists "hero"; then
        log_success "User 'hero' exists."
        score=$((score+1))
    else
        log_error "User 'hero' not found."
    fi

    # 2. intruder removed
    if ! user_exists "intruder"; then
        log_success "User 'intruder' removed."
        score=$((score+1))
    else
        log_error "User 'intruder' still exists."
    fi

    # 3. groups warriors & healers
    if group_exists "warriors"; then
        log_success "Group 'warriors' exists."
        score=$((score+1))
    else
        log_error "Group 'warriors' missing."
    fi
    if group_exists "healers"; then
        log_success "Group 'healers' exists."
        score=$((score+1))
    else
        log_error "Group 'healers' missing."
    fi

    # 4. hero in warriors
    if user_in_group "hero" "warriors"; then
        log_success "'hero' is in group 'warriors'."
        score=$((score+1))
    else
        log_error "'hero' not in group 'warriors'."
    fi

    # 5. sage exists & in healers
    if user_exists "sage"; then
        log_success "User 'sage' exists."
        score=$((score+1))
        if user_in_group "sage" "healers"; then
            log_success "'sage' is in group 'healers'."
            score=$((score+1))
        else
            log_error "'sage' not in group 'healers'."
        fi
    else
        log_error "User 'sage' missing."
    fi

    # 6. treasure.txt exists
    if file_exists "treasure.txt"; then
        log_success "File 'treasure.txt' exists."
        score=$((score+1))
        owner=$(stat -c '%U' treasure.txt 2>/dev/null)
        if [[ "$owner" == "hero" ]]; then
            log_success "treasure.txt owner is 'hero'."
            score=$((score+1))
        else
            log_error "treasure.txt owner is not 'hero' (found: $owner)."
        fi

        perm=$(stat -c '%a' treasure.txt 2>/dev/null)
        if [[ "$perm" == "600" ]]; then
            log_success "treasure.txt permissions are 600."
            score=$((score+1))
        else
            log_error "treasure.txt permissions not 600 (found: $perm)."
        fi
    else
        log_error "File 'treasure.txt' missing."
    fi

    # 7. sleep & kill check
    if check_sleep_and_grep; then
        log_success "'sleep 100' followed by 'kill' found in solution.sh."
        score=$((score+1))
    else
        log_error "Missing 'sleep 100' and/or 'kill' in solution.sh."
    fi

    echo "-------------------------------------"
    log_info "Final Score: $score / $max_score" # Max is 11

    if [[ "$score" -ge 6 ]]; then
        log_success "Task passed!"
        cleanup
        return $CORRECT
    elif [[ "$score" -le 1 ]]; then
        log_error "No requirements satisfied."
        cleanup
        return $NOTSUBMITTED
    else
        log_error "Partial success: Some checks failed."
        cleanup
        return $INCORRECT
    fi
}

# /--------- Test Cleanup ----------/
cleanup() {
    log_info "Cleaning up..."
    sudo rm -f treasure.txt &>/dev/null
    sudo userdel -r hero &>/dev/null
    sudo userdel -r sage &>/dev/null
    sudo groupdel warriors &>/dev/null
    sudo groupdel healers &>/dev/null
}

# /------------- Main -------------/
setup || exit $NOTSUBMITTED
test
RESULT=$?
exit $RESULT
