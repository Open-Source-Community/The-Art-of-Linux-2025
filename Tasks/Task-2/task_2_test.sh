#!/bin/bash

# Task #2 Testing Script
# Created by: Bishoy Ehab

# Task status:
readonly CORRECT=0
readonly INCORRECT=1
readonly NOTSUBMITTED=2

# Test configuration
readonly SOLUTION_FILE="solution.txt"
readonly WORKSPACE="Ghost"

# Write your code between START and END lines.
# Do not remove any code or comments.
# You can add any notes here if you'd like.

# /--------- Helper Functions ------------/
log_info() {
    echo "[INFO] $1"
}

log_error() {
    echo "[ERROR] $1" >&2
}

log_success() {
    echo "[SUCCESS] $1"
}

file_exists() {
    [[ -f "$1" ]] || { log_error "Required file not found: $1"; return 1; }
}

dir_exists() {
    [[ -d "$1" ]] || { log_error "Required directory not found: $1"; return 1; }
}

read_answer() {
    # tr -d removes newline characters to prevent comparison issues
    cat "$1" | tr -d '\n\r'
}

# /--------- Test Setup ------------/
setup() {
    echo "Setting up task environment..."
    # START
    file_exists "$SOLUTION_FILE"
    dir_exists "$WORKSPACE"
    log_success "Setup validated. Found solution, and workspace."
    return 0
    # END
}

# /-------- Test Execution ---------/
test() {
    echo "Executing test..."
    # START
    local score=0
    local max_score=6
    
    # Test 1: Stage 1 Answer
    log_info "Checking Stage 1..."
    if file_exists "$WORKSPACE/stage1_answer.txt" && grep -o -q -E "dmp_42de12016dfb.bin" "$WORKSPACE/stage1_answer.txt"; then
        log_success "Stage 1 Answer is correct."
        score=$((score + 1))
    else
        log_error "Stage 1: Answer not found in stage1_answer.txt or incorrect format."
    fi
    
    # Test 2: Stage 2 Completion
    log_info "Checking Stage 2..."
    if [ -f "$WORKSPACE/tools/diagnostics.sh" ]; then
        log_success "Stage 2 Tool is correctly extracted."
        score=$((score + 1))
    else
        log_error "Stage 2: You should put extract diagnostics.sh in tools directory, Check stage2 in readme."
    fi
    
    # Test 3: Stage 3 Answer
    log_info "Checking Stage 3..."
    if file_exists "$WORKSPACE/stage3_answer.txt" && grep -o -q -E "ERR_KEY_[[:print:]]+" "$WORKSPACE/stage3_answer.txt"; then
        log_success "Stage 3 Answer is correct."
        score=$((score + 1))
    else
        log_error "Stage 3: Answer not found in stage3_answer.txt or incorrect format."
    fi
    
    # Test 4: Stage 4 Answer
    log_info "Checking Stage 4..."
    if file_exists "$WORKSPACE/stage4_answer.txt" && grep -o -q -E "link_2000.txt" "$WORKSPACE/stage4_answer.txt"; then
        log_success "Stage 4 Answer is correct."
        score=$((score + 1))
    else
        log_error "Stage 4: Answer not found in stage4_answer.txt or incorrect format."
    fi
    
    # Test 5: Final Flag in Report
    log_info "Checking Final Flag in report..."
    if grep -o -q -E 'FLAG\{[[:print:]]*\}' "$SOLUTION_FILE"; then
        log_success "Final Flag is correct in the report."
        score=$((score + 1))
    else
        log_error "Final Flag not found in solution.txt or flag is incorrect."
    fi
    
    # Test 6: Command Documentation
    log_info "Checking command documentation in solution..."
    local stage_count
    
    if grep -o -q -E "type[[:space:]]+l" "$SOLUTION_FILE"; then
        score=$((score + 1))
    else
        log_error "Stage 4: You did not using find or -xtype to find the broken link."
    fi
    
    
    # --- Final Grade ---
    echo "-------------------------------------"
    log_info "Final Score: $score / $max_score"
    if [[ "$score" -ge 4 ]]; then
        log_success "Task passed!"
        return $CORRECT
        elif [[ "$score" -eq 0 ]]; then
        log_error "Task not submitted."
        return $NOTSUBMITTED
        
    else
        log_error "Task failed. Please review the stages and submission guidelines."
        return $INCORRECT
    fi
    # END
}

# /------------- Main -------------/
setup || exit $ERROR
test
RESULT=$?
exit $RESULT
