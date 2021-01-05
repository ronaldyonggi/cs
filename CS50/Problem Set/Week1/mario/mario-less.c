#include <stdio.h>
#include <cs50.h>

int main(void)
{
    // Takes user input of height of bricks, has to be between 1 and 8, inclusive.
    int height;
    do
    {
        height = get_int("Height: ");
    }
    while (height < 1 || height > 8);

    for (int i = 1; i <= height; i++)
    {
        // Prints the spaces, depending on the height and i
        for (int h = height; h > i; h--)
        {
            printf(" ");
        }
        // Prints the bricks, depending on i
        for (int j = 1; j <= i; j++)
        {
            printf("#");
        }
        printf("\n");
    }
}