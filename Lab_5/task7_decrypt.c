#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
    if (argc != 4) return 1;
    FILE *f_in = fopen(argv[1], "r");
    FILE *f_out = fopen(argv[2], "w");
    int k = atoi(argv[3]);
    if (!f_in || !f_out) return 1;

    int ch;
    while ((ch = fgetc(f_in)) != EOF) {
        fputc(ch - k, f_out);
    }

    fclose(f_in);
    fclose(f_out);
    return 0;
}