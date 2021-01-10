// Computes RAM[1] = 1 + 2 + 3 + ... + n

// To use, set a number n in RAM[0]

// Part 1 Pseudocode:
// n = R0
// i = 1
// sum = 0

@R0
D = M
// set n = R0
@n 
M = D
// set i = 1
@i
M=1
// sum = 0
@sum
M = 0

// Part 2 Pseudocode:
// LOOP:
//  if i > n goto STOP
//  otherwise 
//  sum = sum + i
//  i = i + 1
//  goto LOOP

// For every loop, i is incremented by 1. Calculate i - n. 
// If the result is greater than 0, then i
// has surpassed n. In this case, STOP the program.
(LOOP)
@i
D = M
@n
D = D - M
@STOP
D;JGT

@sum
D = M
@i
D = D + M
@sum
M = D //sum = sum + i
@i
M = M + 1 // i = i + 1
@LOOP
0;JMP

// Part 3 Pseudocode:
// STOP:
//  R1 = sum
(STOP)
// Retrieve contents of sum
@sum
D = M
@R1
M = D // RAM[1] = sum

(END)
@END
0;JMP