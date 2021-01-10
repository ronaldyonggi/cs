// If R0>0, set R1 = 1. Otherwise set R1 = 0

// Set D to whatever's in RAM[0]
@R0
D = M 

@8
D;JGT // If R0 > 0, goto instruction line 8

// Set RAM[1] = 0
@R1
M = 0
// End of program
@10
0;JMP

// Otherwise set R1 =1. In CPUEmulator, this is instruction line 8
@R1
M = 1 

// End of program
@10
0;JMP