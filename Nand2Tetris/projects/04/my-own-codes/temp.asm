// Using temporary variable temp to swap the values in 
// RAM[0] and RAM[1]

// The computer actually uses a random available memory register
// (e.g n) to represent the variable temp. Thus, every occurrence of @temp
// is translated into @n. Variables use memory register 16 and greater.

@R1
D = M
// Assign temp = R1
@temp
M = D

// Retrieve contents of RAM[0]
@R0
D = M
// Assign R1 = R0
@R1
M = D

// Retrieve contents of temp
@temp
D = M
// Assign R0 = temp
@R0
M = D

// End the program
(END)
@END
0;JMP