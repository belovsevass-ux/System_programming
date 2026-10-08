#include <stdio.h>

int main() {
    int n, vote, sum = 0;
    printf("Enter number of judges: ");
    scanf("%d", &n);
    for (int i = 0; i < n; i++) {
        printf("Enter vote (0 or 1): ");
        scanf("%d", &vote);
        sum += vote;
    }
    printf("Decision: %d\n", (sum > n / 2) ? 1 : 0);
    return 0;
}