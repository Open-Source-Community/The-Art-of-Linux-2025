# Level 9: Shell Script Calculator

## Objective
Create a shell script `calc.sh` that acts as a simple calculator.  
The script must define **four separate functions**:
- `add`: takes two numbers and prints their sum.
- `sub`: takes two numbers and prints their difference.
- `mul`: takes two numbers and prints their product.
- `div`: takes two numbers and prints their division result.  
    - No need to handle division by zero

## Requirements
1. The script must be executable (`chmod +x calc.sh`).
2. The script should accept **three arguments**:
   - First number
   - Operation (`+`, `-`, `x` (the letter), `/`)
   - Second number
3. Based on the chosen operation, call the corresponding function.
4. Display the result.

## Example Run
```bash
$ ./calc.sh 8 x 4
Result: 32

$ ./calc.sh 6 / 3
Result: 2
```
