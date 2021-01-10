// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed. 
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

// Put your code here.

(START)
// The entire screen is 32 * 256 = 8192 pixels.
@8192
D = A
// Set an iterator i that indicates the remaining pixels still need to be changed,
// starting 8192 decrementing to 0.
@i
M = D

(LOOP)
@i
M = M - 1 // i = i - 1
D = M
@START
D;JLT // if i < 0, the program finishes updating all pixels. go back to START.
@KBD
D = M // Retrieve the contents of the keyboard
@BLACK
D;JGT // If any key is pressed, D must be > 0.
@WHITE
D;JEQ // Otherwise if no key is pressed, D must be == 0

(BLACK)
@SCREEN
D = A // Retrieve the screen address
@i
A = D + M // Adding the screen address to the index, we start with the last pixel, decreasing
M = -1 // Update the contents of that last pixel to -1
@LOOP
0;JMP


// REPEAT the same process for WHITE with the only difference changing to 0 instead of -1
(WHITE)
@SCREEN
D = A // Retrieve the screen address
@i
A = D + M // Adding the screen address to the index, we start with the last pixel, decreasing
M = 0 // Update the contents of that last pixel to 0 to represent white.
@LOOP
0;JMP