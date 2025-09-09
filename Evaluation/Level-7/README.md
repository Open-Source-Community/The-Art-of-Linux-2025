# Level 7
# Level 7 : File Permissions and Ownership
>[!WARNING ]
> ALL NAMES ARE CASE SENSITIVE

**Check Guidelines**

- Run `./check.sh` to verify completion and get your key.
    
### **Step 1 – Set file permissions**

Set the following permissions in `perm_lab`:

- `run.sh` must be **executable only by the owner**. (No read/write, no permissions for group or others).    
- `info.txt` must be **readable and writable only by the owner** (No execute, no permissions for group or others).
- `app.log` must be **readable and writable by everyone**. (No execute permissions).
---

### **Step 2 – Change ownership**

- Add a user named `developer`.
- Change the owner of `run.sh`  to **user**: `developer`

--- 

>[!NOTE]
> Don't Forget to run check.sh 
