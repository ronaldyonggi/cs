// Computues sum of 1 + 2 + ... + 100
@i   // i = 1
M=1
@sum // sum = 0
M=0
(LOOP)
@i // if (i-100) = 0 go to END
D=M
@100
D=D-A
@END
D;JGT
@i // sum++i
D=M
@sum
M=D+M
@i // i++
M=M+1
@LOOP // go to LOOP
0;JMP
(END) // infinite loop
@END
0;JMP