#include <stdio.h>

int main() {
    long n;
    printf("Enter n: ");
    scanf("%ld", &n);
    
    int prev = 10; // больше любой цифры
    int ok = 1;
    
    while (n > 0) {
        int digit = n % 10;
        if (digit > prev) {
            ok = 0;
            break;
        }
        prev = digit;
        n /= 10;
    }
    
    if (ok) {
        printf("Yes (non-decreasing)\n");
    } else {
        printf("No (not non-decreasing)\n");
    }
    
    return 0;
}