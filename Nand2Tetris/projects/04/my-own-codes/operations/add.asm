// Sets RAM[2] = RAM[0] + RAM[1]

// First set initial values. Let's set RAM[0] to be 3
// and RAM[1] = 7


// Setting RAM[0] = 3
@3
D = A
@0
M = D

// Setting RAM[1] = 7
@7
D = A
@1
M = D

// Reset D
@0
D = A

// Take contents from RAM[0]
// @0 -> Not necessary since we're still at RAM[0]
D = M // D is now 3

// Go to RAM[1] and add the contents to D
@1
D = D + M // D is now 10

// Finally, set RAM[2] = 10
@2
M = D
