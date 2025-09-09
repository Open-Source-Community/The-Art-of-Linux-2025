# Task #2

**Session #2:** Finding, Links, Compression & Archiving

---

## Submission Guidelines

Task correction is **automatic**. Please follow the guidelines to ensure that your task is graded correctly.

- In your task directory (`Task-2`), extract the file `Ghost.tar.gz`.
- Navigate into the `Ghost` directory to start the challenge.
- Complete all **5 stages** of the "Data Ghost" challenge.
- After completing all stages:
  - In `solution.txt` (inside `Task-2`), include:
    - The **final flag** discovered in Stage 5.
    - The **exact command(s)** used to solve each stage.

**IMPORTANT**: The directory Ghost must remain intact and not be deleted or modified in any way. The task will not be graded if the directory is missing or altered.

### solution.txt Format

Write your report using this Markdown format:

```markdown
FLAG{SECRET}
Stage 1:
command1
command2
Stage 2:
command3
command4
Stage 3:
...
```

---

## Task Description

A **Data Ghost** has hidden a secret message. Your mission is to follow a trail of clues through 5 stages to find the **final flag**.

The challenge workspace is the `Ghost` folder. Your first step is to **extract** this folder and navigate into it.

---

### Stages

#### **Stage 1: Find the Anomaly**

- **Goal:** Identify the **empty file** inside `data_stream`.
- **Action:** Write the name of this empty file into `stage1_answer.txt`.

---

#### **Stage 2: Unpack the Tools**

- **Goal:** Extract `diagnostics.sh` from `system_tools.tar.gz` (found in `backups`) into a directory named `tools`.

---

#### **Stage 3: Capture the Error**

- **Goal:** When running `bash diagnostics.sh` (in the `tools` directory), an error occurs.
- **Action:** Redirect this error output to `stage3_answer.txt` (in your `Task-2` folder).

---

#### **Stage 4: Find the Broken Link**

- **Goal:** Identify the **broken symbolic link** in `asset_links`.
- **Action:** Write the name of this broken link into `stage4_answer.txt`.

---

#### **Stage 5: Uncover the Final Flag**

- **Goal:** Run this command `bash system/system_check.sh` in `Ghost` directory to reveal a hidden flag.
- **Action:** Use a pipeline to print the flag and record it in a new file called `flag.txt` and place it in `Ghost` directory.

---

## Additional Notes

If you accidentally delete the `Ghost` directory or want to restart the task, simply extract `Ghost.tar.gz` again.
