#include <cs50.h>
#include <stdio.h>

int main(void) {
    char c = get_char("Do you agree? ");
    // In programming languages C, for comparing char, use single quote ', not double quote ".
    // Double quotes " are for strings!
    if (c == 'y' || c == 'Y') {
        printf("Agreed.\n");
    } else if (c == 'n' || c == 'N') {
        printf("Not agreed.");
    }
}