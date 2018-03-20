// First ten problems of Project Euler

#include "stdio.h"
#include "stdlib.h"

void p1() {
    // Find the sum of all the multiples of 3 or 5 below 1000
    int accum = 0;
    for (int i = 1; i < 1000; i++)
        if ((i % 3 == 0) || (i % 5 == 0)) accum += i;
    printf("Answer to 1 is %d\n", accum);
}

void p2() {
    int fib1 = 1;
    int fib2 = 2;
    int accum = 0;
    while (1) {
        if (fib2 > 4000000) break;
        if (fib2 % 2 == 0) accum += fib2;
        fib1 += fib2;
        if (fib1 > 4000000) break;
        if (fib1 % 2 == 0) accum += fib1;
        fib2 += fib1;
    }
    printf("Answer to 2 is %d\n", accum);
}

void p3() {
    // Terrible performance. Fix.
    int largest = 1;
    for (int i = 1; i < 600851475143/5; i += 2) {
        short flag = 1;
        for (int j = 3; j*j <= i; j += 2) {
            if (i % j == 0) {
                flag = 0;
                break;
            }
        }
        if (flag) largest = i;
    }
    printf("Answer to 3 is %d\n", largest);
}

void p4() {
}

void p5() {
}

void p6() {
}

void p7() {
}

void p8() {
}

void p9() {
}

void p10() {
}

int main(int argc, char **argv) {
        if (argc == 2) {
            switch(atoi(argv[1])) {
                case 1:
                    p1();
                    return 1;
                case 2:
                    p2();
                    return 1;
                case 3:
                    p3();
                    return 1;
                case 4:
                    p4();
                    return 1;
                case 5:
                    p5();
                    return 1;
                case 6:
                    p6();
                    return 1;
                case 7:
                    p7();
                    return 1;
                case 8:
                    p8();
                    return 1;
                case 9:
                    p9();
                    return 1;
                case 10:
                    p10();
                    return 1;
                default :
                    printf("Invalid option!");
                    return 0;
            }
        }
        else if (argc < 2) printf("Too few arguments!");
        else printf("Too many arguments!");
        return 1;
}
