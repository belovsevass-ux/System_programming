#include <stdio.h>
#include <stdlib.h>

// Объявление функций из ассемблера
extern int* create_array(int size);
extern void fill_random(int* arr, int size);
extern int count_primes(int* arr, int size);
extern int get_odd_numbers(int* arr, int size, int* result);
extern int count_even(int* arr, int size);
extern void free_array(int* arr, int size);

int main() {
    int size;
    printf("Введите размер массива: ");
    scanf("%d", &size);

    int* arr = create_array(size);
    if (!arr) {
        printf("Ошибка выделения памяти!\n");
        return 1;
    }

    fill_random(arr, size);

    printf("Исходный массив: ");
    for (int i = 0; i < size; i++) {
        printf("%d ", arr[i]);
    }
    printf("\n");

    int primes = count_primes(arr, size);
    printf("Простых чисел: %d\n", primes);

    int evens = count_even(arr, size);
    printf("Четных чисел: %d\n", evens);

    int* odds = (int*)malloc(size * sizeof(int));
    int odd_count = get_odd_numbers(arr, size, odds);
    
    printf("Нечетные числа: ");
    for (int i = 0; i < odd_count; i++) {
        printf("%d ", odds[i]);
    }
    printf("\n");

    free(odds);
    free_array(arr, size);

    return 0;
}