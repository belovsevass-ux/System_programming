#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void reverse_lines(const char *in_file, const char *out_file) {
    FILE *f_in = fopen(in_file, "r");
    FILE *f_out = fopen(out_file, "w");
    if (!f_in || !f_out) return;

    char *lines[1000];
    int count = 0;
    char buffer[1024];

    while (fgets(buffer, sizeof(buffer), f_in)) {
        lines[count] = strdup(buffer);
        count++;
    }

    for (int i = count - 1; i >= 0; i--) {
        fputs(lines[i], f_out);
        free(lines[i]);
    }

    fclose(f_in);
    fclose(f_out);
}