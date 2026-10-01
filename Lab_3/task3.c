#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
    long a, b, c;
    long result;

    if (argc != 4) {
        printf("Usage: ./task3 a b c\n");
        return 1;
    }

    a = atol(argv[1]);
    b = atol(argv[2]);
    c = atol(argv[3]);

    // Вычисляем ((a - c) + a) + a
    result = ((a - c) + a) + a;

    printf("Result = %ld\n", result);

    return 0;
}
