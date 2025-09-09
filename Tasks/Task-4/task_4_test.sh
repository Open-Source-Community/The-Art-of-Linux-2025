#!/bin/bash
set -euo pipefail

# Task status
readonly CORRECT=0
readonly INCORRECT=1
readonly ERROR=2

# Configuration
readonly TASK_FOLDER="."
readonly SCRIPT_1_NAME="extract_key.sh"
readonly SCRIPT_2_NAME="get_sum.sh"
readonly ARCHIVES=("file1.zip" "file2.tar.xz")

# Logging helpers
log_info()    { echo -e "[INFO] $1"; }
log_error()   { echo -e "[ERROR] $1" >&2; }
log_success() { echo -e "[SUCCESS] $1"; }

# Check helpers
file_exists() { [[ -f "$1" ]] || { log_error "Missing file: $1"; return 1; }; }
dir_exists()  { [[ -d "$1" ]] || { log_error "Missing directory: $1"; return 1; }; }

# Setup
setup() {
    log_info "Setting up environment..."
    if [[ ! -d "$TASK_FOLDER" ]]; then
        log_error "Task folder '$TASK_FOLDER' not found!"
        return 3
    fi
    cd "$TASK_FOLDER" || return 3
    file_exists "$SCRIPT_1_NAME" || return 3
    file_exists "$SCRIPT_2_NAME" || return 3
    
    chmod +x "$SCRIPT_1_NAME"
    chmod +x "$SCRIPT_2_NAME"
    
    for archive in "${ARCHIVES[@]}"; do
        file_exists "$archive" || return 3
    done
    log_success "Setup complete"
    return 0
}
set +e
# Test
Test() {
    
    passed=0
    failed=0
    
    # -------- PART ONE: extract_key.sh
    
    log_info "Testing part one..."
    
    log_info "[INFO] Running $SCRIPT_1_NAME with arguments"
    chmod +x "$SCRIPT_1_NAME"
    ./"$SCRIPT_1_NAME" "file1.zip" "file2.tar.xz"
    
    zip_folder=$(find . -maxdepth 1 -type d -name "extracted_*" | head -n1)
    
    
    # -------- Test 1: Extraction
    if [[ -n "$zip_folder" && -d "$zip_folder" ]]; then
        log_success "Extraction folder created: $zip_folder"
        ((passed++))
    else
        log_error "Failed to create extracted_<timestamp> folder"
        ((failed++))
    fi
    
    
    # -------- Test 3: TAR.XZ support
    log_info "Checking if .tar.xz archive was extracted correctly..."
    if [[ -n "$zip_folder" ]] && find "$zip_folder" -type f -name "file2" | grep -q .; then
        log_success "tar.xz content extracted and visible"
        ((passed++))
    else
        log_error "tar.xz content not found or extraction failed"
        ((failed++))
    fi
    
    # -------- Test 4: Folder naming
    if [[ $(basename "$zip_folder") == "extracted_files" ]]; then
        log_success "Folder naming format is correct"
        ((passed++))
    fi
    
    # -------- Test 5: Script structure
    if grep -q "tar" "$SCRIPT_1_NAME" && grep -q "zip" "$SCRIPT_1_NAME" ; then
        log_success "Script contains zip/tar support and uses timestamps"
        ((passed++))
    else
        log_error "Script structure seems incomplete"
        ((failed++))
    fi
    # -------- PART TWO: get_sum.sh
    echo -e "\n========================="
    log_info "Testing part two..."
    log_info "Testing $SCRIPT_2_NAME functionality"

    # -------- Test 2: Loop structure
    if grep -q -E "(while|for)" "$SCRIPT_2_NAME"; then
        log_success "Loop structure found"
        ((passed++))
    else
        log_error "Loop structure missing"
        ((failed++))
    fi
    
    # -------- Test 3: User input handling
    if grep -q "read" "$SCRIPT_2_NAME"; then
        log_success "User input handling found"
        ((passed++))
    else
        log_error "User input handling missing"
        ((failed++))
    fi

    
    # -------- Test 5: Sum calculation
    if grep -q -E "(\+|\+=|sum)" "$SCRIPT_2_NAME"; then
        log_success "Sum calculation logic found"
        ((passed++))
    else
        log_error "Sum calculation logic missing"
        ((failed++))
    fi
    
    # -------- Test 6: Basic functionality test
    log_info "Testing basic functionality with input: 5, -3, 10, 0"
    temp_input="temp_input_$$"
    echo -e "5\n-3\n10\n0" > "$temp_input"
    
    output=$(timeout 10s bash "$SCRIPT_2_NAME" < "$temp_input" 2>&1)
    exit_code=$?
    rm -f "$temp_input"
    
    if [[ $exit_code -eq 0 ]]; then
        actual_sum=$(echo "$output" | grep -oE "[0-9]+" | tail -1)
        if [[ "$actual_sum" == "15" ]]; then
            log_success "Basic test passed - Expected: 15, Got: $actual_sum"
            ((passed++))
        else
            log_error "Basic test failed - Expected: 15, Got: $actual_sum"
            ((failed++))
        fi
    else
        log_error "Script execution failed"
        ((failed++))
    fi
    
    # -------- Test 7: All positive numbers test
    log_info "Testing all positive numbers: 1, 2, 3, 4, 5, 0"
    temp_input="temp_input_$$"
    echo -e "1\n2\n3\n4\n5\n0" > "$temp_input"
    
    output=$(timeout 10s bash "$SCRIPT_2_NAME" < "$temp_input" 2>&1)
    exit_code=$?
    rm -f "$temp_input"
    
    if [[ $exit_code -eq 0 ]]; then
        actual_sum=$(echo "$output" | grep -oE "[0-9]+" | tail -1)
        if [[ "$actual_sum" == "15" ]]; then
            log_success "All positive test passed"
            ((passed++))
        else
            log_error "All positive test failed - Expected: 15, Got: $actual_sum"
            ((failed++))
        fi
    else
        log_error "All positive test execution failed"
        ((failed++))
    fi
    
    # -------- Test 8: Mixed numbers test
    log_info "Testing mixed numbers: 10, -5, -2, 8, -1, 3, 0"
    temp_input="temp_input_$$"
    echo -e "10\n-5\n-2\n8\n-1\n3\n0" > "$temp_input"
    
    output=$(timeout 10s bash "$SCRIPT_2_NAME" < "$temp_input" 2>&1)
    exit_code=$?
    rm -f "$temp_input"
    
    if [[ $exit_code -eq 0 ]]; then
        actual_sum=$(echo "$output" | grep -oE "[0-9]+" | tail -1)
        if [[ "$actual_sum" == "21" ]]; then
            log_success "Mixed numbers test passed"
            ((passed++))
        else
            log_error "Mixed numbers test failed - Expected: 21, Got: $actual_sum"
            ((failed++))
        fi
    else
        log_error "Mixed numbers test execution failed"
        ((failed++))
    fi
    
    # -------- Final Report
    total_tests=12
    grade=$(( (passed * 10) / total_tests ))
    
    echo -e "\n========================="
    echo "Tests Passed : $passed"
    echo "Tests Failed : $failed"
    echo "========================="
    
    if [[ $failed -eq 0 ]]; then
        log_success "Excellent submission"
        return 0
    elif [[ $failed -le 4 ]]; then
        log_success "Passing submission"
        return 0
    elif [[ $passed -eq 0 ]]; then
        log_success "Not submitted!"
        return 2
    else
        log_info "Submission needs improvement"
        return 1
    fi
    }

# Cleanup
cleanup() {
    log_info "Cleaning up..."
    rm -rf extracted_files
    log_info "Cleanup complete"
}

# Main
setup || exit $ERROR
Test
RESULT=$?
cleanup
exit $RESULT
