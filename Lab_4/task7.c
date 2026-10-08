#include <stdio.h>

int main() {
    long n, rev = 0;
    printf("Enter n: ");
    scanf("%ld", &n);
    while (n != 0) {
        rev = rev * 10 + n % 10;
        n /= 10;
    }
    printf("Reversed = %ld\n", rev);
    return 0;
}