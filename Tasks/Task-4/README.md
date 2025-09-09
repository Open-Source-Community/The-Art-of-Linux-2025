# Task #4

**Session #4:** Shell Scripting

---

## Submission Guidelines

- In your task repository, navigate to the folder `Task-4`.
- Complete both parts of this task:
  - **Part 1:** Write your solution script in `extract_key.sh`
  - **Part 2:** Write your solution script in `get_sum.sh`
- Ensure both scripts are executable from the terminal.

---

## Part 1: Archive Key Extraction

### Task Description

Write a Bash script named `extract_key.sh` that performs the following:

- Accept two compressed archive filenames as command-line arguments
- Support `.zip` and `.tar.xz` formats
- Extract both archives into a new folder named `extracted_files`

**Note:** Two compressed files are provided as part of this task. Use them to test your script.

### Acceptance Criteria

- The script runs from the terminal
- Supports archive types: `.zip` and `.tar.xz`
- Correctly creates a folder named `extracted_files`
- Extracts files without errors or data loss
- Script is clearly written and well-structured

---

## Part 2: Positive Number Sum Calculator

### Task Description

Write a Bash script named `get_sum.sh` that:

- Asks the user to enter numbers one by one
- Stops when the user enters `0`
- Uses a **function** to check if the number is positive
- Uses a **loop** to read numbers and sum only the positive ones

### Requirements

1. The user is prompted in a loop to **enter numbers one by one**
2. If the number is `0`, the loop ends
3. If the number is positive (greater than 0), it is added to the sum
4. The script must use a **function** called `is_positive()`:
   - Takes one argument (a number)
   - Returns 0 if the number is positive, otherwise returns 1
5. At the end, print the **total sum** of all positive numbers entered

### Example Run

```bash
Enter a number (0 to stop): 5
Enter a number (0 to stop): -3
Enter a number (0 to stop): 10
Enter a number (0 to stop): 0
Sum of positive numbers: 15
```

---

## File Structure

After completion, your `Task-4` folder should contain:

```
Task-4/
├── extract_key.sh       # Part 1 solution
├── get_sum.sh          # Part 2 solution
├── extracted_files/    # Created by Part 1
├── file1.zip           # Provided test file
├── file2.tar.xz        # Provided test file
└── README.md           # This file
```
