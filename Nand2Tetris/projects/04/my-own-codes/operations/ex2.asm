// Setting RAM[5] = RAM[3]
// Let's say RAM[3] is 23 at first.
@23
D = A

// Set RAM[3] = 23
@3
M = D

// Reset D back to 0
@0
D = A

// Set D to whatever's in RAM[3]
@3
D = M

// Finally, set RAM[5] = RAM[3]
@5
M = D