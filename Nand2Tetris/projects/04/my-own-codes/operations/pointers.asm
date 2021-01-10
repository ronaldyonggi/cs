// Simulates the following:
// for (i = 0; i < n; i++) {
//     arr[i] = -1
// }

// Here, supposed arr = 100 and n = 10. 
// We want to set RAM[100] up to RAM[109] to contain -1.

@100
D = A
// Set arr = 100
@arr
M = D

@10
D = A
// Set n = 10
@n
M = D

// initialize i = 0
@i
M = 0

(LOOP)
@i
D=M
@n
D = D-M
// if i == n, goto END
@END
D;JEQ

// RAM[arr+i] = -1
@arr
D = M
@i
A = D + M // Set currently selected RAM to RAM[arr+i]
M = -1

// Whenever we have to access a memory using a pointer,
// we need an instruction like A = something (set the address
// register to the contents of some memory register)

// i++
@i
M = M+1

@LOOP
0;JMP

(END)
@END
0;JMP