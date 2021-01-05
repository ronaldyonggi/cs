#include <stdio.h>
#include <cs50.h>

int main(void)
{
    // Takes user input of name
    string name = get_string("What is your name?\n");

    // Greets the user with the name input from previous line.
    printf("hello, %s\n", name);
}