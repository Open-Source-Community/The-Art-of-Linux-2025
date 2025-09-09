# **Level #10:**  Text Processing

## Check Guidelines
- Run `check.sh` with the answer as a parameter to get the key.

## Level Description
- You are given a server log file named users.log containing records of user login and logout events in this format.
    - 2025-08-15 10:05:22 login: alice ip:192.168.1.10
    - 2025-08-15 10:06:44 login: bob ip:192.168.1.15
    - 2025-08-15 10:09:55 logout: alice ip:192.168.1.10
- Find the name of the user who logs in most frequently (most frequent username with "login" flag)
- Pass the name as a parameter to "check.sh".
