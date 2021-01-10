// If R0>0, set R1 = 1. Otherwise set R1 = 0

// Set D to whatever's in RAM[0]
@R0
D = M 

@POSITIVE
D;JGT // If R0 > 0, goto instruction (POSITIVE). The CPUEmulator is smart that
// it can tell the (POSITIVE) is at line (ROM) 8.
// @LABEL translates to @n, where n is the instruction number following
// the (LABEL) declaration.



// Set RAM[1] = 0
@R1
M = 0
// Go to (END) to end the prgoram
@END
0;JMP

// Otherwise set R1 =1. 
(POSITIVE)
@R1
M = 1 

// End of program with infinite loop.
(END)
@10
0;JMP