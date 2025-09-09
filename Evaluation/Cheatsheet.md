## TAOL'25 Evaluation Cheat Sheet

## 1. File and Directory Operations Commands

| Command | Description                        |
| ------- | ---------------------------------- |
| `ls`    | List files and directories.        |
| `cd`    | Change directory.                  |
| `pwd`   | Print current working directory.   |
| `mkdir` | Create a new directory.            |
| `rm`    | Remove files and directories.      |
| `cp`    | Copy files and directories.        |
| `mv`    | Move/rename files and directories. |
| `touch` | Create an empty file.              |
| `cat`   | View the contents of a file.       |
| `ln`    | Create links between files.        |
| `find`  | Search for files and directories.  |

---

## 2. File Compression and Archiving Commands

| Command          | Description                      |
| ---------------- | -------------------------------- |
| `tar`            | Create or extract archive files. |
| `gzip` / `bzip2` | Compress files.                  |
| `zip`            | Create compressed zip archives.  |

---

## 3. File Permission Commands

| Command | Description              |
| ------- | ------------------------ |
| `chmod` | Change file permissions. |
| `chown` | Change file ownership.   |
| `chgrp` | Change group ownership.  |

---

## 4. Users and Groups

| Command   | Description                                         |
| --------- | --------------------------------------------------- |
| `id`      | Display the current user.                           |
| `useradd` | Create a user.                                      |
| `userdel` | Delete a user (including home directory and files). |
| `usermod` | Modify a user (e.g., add them to a group).          |

---

## 5. Processes

| Command        | Description                                   |
| -------------- | --------------------------------------------- |
| `[command] &`  | Run a command in the **background**.          |
| `Ctrl + z`     | Suspend (pause) a running foreground process. |
| `jobs`         | List jobs started in the current shell.       |
| `fg %job_id`   | Bring a job to the **foreground**.            |
| `bg %job_id`   | Resume a suspended job in the **background**. |
| `ps -e`        | List all processes running on the system.     |
| `ps -C [name]` | List processes by name.                       |
| `pkill [name]` | Kill all processes by name.                   |
| `kill -9 PID`  | Force kill a process by **PID**.              |

---

## 6. Redirection vs Pipelining

- **Redirection**: `command > file`
- **Pipelining**: `command | command`
- `>` : Overwrite
- `>>` : Append
- `wc -l`: Count lines

---

## 7. Text Processing Commands

| Command | Description                                                |
| ------- | ---------------------------------------------------------- |
| `cut`   | Extract sections from lines of input.                      |
| `sort`  | Sort lines of text files.                                  |
| `uniq`  | Report or omit repeated lines (works best on sorted data). |
| `grep`  | Search text using patterns (supports regex).               |

---

## 8. Bash Scripting

### Variables

- Declaration → `varName=value`
- Access variable → `$varName`

### Positional Parameters

- Access arguments passed to script → `$1`, `$2`, `$3`, …

### Arithmetic Expansion

- `$((expression))`

---

### If / Else If Syntax

```bash
if [[ condition ]]; then
    # some stuff
elif [[ condition ]]; then
    # other stuff
else
    # yet other stuff
fi
```

---

### Functions

```bash
function_name() {
    # function body
}

# Call the function
function_name
```

**Arguments**:

- `$1` → first argument
- `$2` → second argument
- `$3` → third argument

---

### Case Statements

```bash
case expression in
    pattern1)
        # commands
        ;;
    pattern2)
        # commands
        ;;
    *)
        # default case
        ;;
esac
```
