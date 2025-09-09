# Task #3

**Session #3:** Users, Groups, Permissions & Processes

## Submission Guidelines

- In your task repo, find the folder `Task-3`.
- Write **all commands** you used to solve the task in a file called `solution.sh`.
- Write the commands like that in the `solution.sh`:

```
cd Linux
echo "Hello world"
```

without adding any type of additions, just the commands only.

- Make sure your commands can run without errors when executed. Verify this by running `./solution.sh`

---

## Task Description

You are inside a broken **digital world**. Everything is gone — people, tribes, and files. Please **fix the system step by step**.
Write every command you use in a file called **solution.sh**.

### **Part 1 – Make the People**

- Please create a user called `hero` — this is you.
- Please create a fake user called `intruder` and then remove this user.

### **Part 2 – Make the Tribes**

- Please create two groups called `warriors` and `healers`.
- Please add `hero` to the `warriors` group.
- Please create another user called `sage` and add them to the `healers` group.

### **Part 3 – The Secret File**

- Please create a file called `treasure.txt` with the text:

  ```
  CyberWorld's Core
  ```

- Please lock this file so no one can read or change it (`000` permission).
- Then:

  1. Please change the owner of the file to `hero`.
  2. Please give `hero` permission to read and write this file.

### **Part 4 – The Wild Programs**

- Please start a fake program in the background (`sleep 100`).
- Please find it using `ps`.
- Please stop it using a signal (`kill`).
