// Draws a rectangle at screen's top left corner.
// Rectangle width = 16 pixels
// Rectangle height = RAM[0]

// Usage: Assign a non-negative number in RAM[0].

@R0
D = M
@n
M = D // set n = RAM[0]

@i
M = 0 // set i = 0

@SCREEN
D = A
@address
M = D // set address = 16384 (base address of the Hack screen)

(LOOP)
@i
D = M
@n
D = D - M
@END
D;JGT // if i > n, goto END


@address
A = M
M = -1 // set RAM[address] = -1 (16 pixels)

@i
M = M + 1 // i = i + 1
@32
D = A
@address
M = D + M // address = address + 32 (increment by 32 because next row = 32 bits differences)
@LOOP
0;JMP

(END)
@END
0;JMP