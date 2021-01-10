// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)

// Put your code here.

// A multiplication can be seen as adding 
// R0, R1 times.

// First, initialize temporary variable sofar and iterator i to be 0
@sofar
M = 0
@i
M = 0

// This part is similar to 
// for (i = 0; i <= R1; i++) {
//     sofar += R0;
// }
// Now set up the loop.
(LOOP)
@i
D = M
@R1
D = D - M
// goto STOP once i is equal to RAM[1]
@STOP
D;JEQ

// The lines below are executed within a loop
@sofar
D = M
@R0
D = D + M
@sofar
M = D // sofar = sofar + RAM[1]
@i
M = M + 1 // i = i + 1
@LOOP
0;JMP

// The lines below are executed once the STOP condition is met.
(STOP)
@sofar
D = M
@R2
M = D //RAM[2] = sofar

// End of program
(END)
@END
0;JMP