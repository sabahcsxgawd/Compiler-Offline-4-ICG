// #include <stdio.h>
int array[16], fib_mem[24];
int _j, __number, word2, word1;

// void println(int n) {
//     printf("%d\n", n);
// }

int fibonacci(int n) {
    if(fib_mem[n] != 0) return fib_mem[n];
    if(n==0 || n==1) {
        fib_mem[n] = n;
        return fib_mem[n];
    }
    fib_mem[n] = fibonacci(n-1) + fibonacci(n-2);
    return fib_mem[n];
}

int factorial(int n) {
    if(n==1) return n;
    int k;
    k = n * factorial(n-1);
    return k;
}

int power(int a, int b) {
    if(b==0) return 1;
    return a * power(a, b-1);
}

void merge(int begin, int mid, int end) {
    int i, j;
    int temp[16];
    i = begin;
    j = mid+1;
    int counter;
    counter = 0;

    for(counter=0; counter < (end-begin+1); counter++) {
        if(i > mid) temp[counter] = array[j++];
        else if(j > end) temp[counter] = array[i++];
        else if(array[i] <= array[j]) temp[counter] = array[i++];
        else temp[counter] = array[j++];
    }

    for(counter=0; counter < (end-begin+1); counter++) {
        array[begin + counter] = temp[counter];
    }
}

int mergeSort(int begin, int end) {
    if (begin >= end)
        return 0;
 
    int mid;
    mid = begin + (end - begin) / 2;
    mergeSort(begin, mid);
    mergeSort(mid + 1, end);
    merge(begin, mid, end);
    return 0;
}

int __MERGE() {
    __number = -15000;
    println(__number);
    return 1;
}

int loop_test() {
    int i;
    for(i=0; i<100; i++) {
        int k[100];
        k[97] = 0;
        k[98] = 0;
        k[99] = k[98] + k[97] + 111;
        if(i == 97) {
            int temp;
            temp = k[99];
            println(temp);
            return 0;
        }
    }
    println(i);
}

void main() {
    // freopen("output.txt", "w", stdout);
    int i, a, b;
    a = 2;
    b = 5;
    __number = power(a, b);
    println(__number);
    __number = factorial(7);
    println(__number);
    loop_test();

    for(i=15; i>=0; i--) 
        array[i] = -17000 - 1000*i;
    i = 16;
    while(i--) {
        int temp;
        temp = array[15-i];
        println(temp);
    }
    
    println(i);
    a = 0;
    b = 15;
    mergeSort(a, b);

    for(i=0; i<16; i++) {
        if(i >= 0 || __MERGE()) {
            word2 = 1;
            word2 = 3;
            word2 = array[i];
            println(word2);
        }
    }
    for(i=0; i<16; i++)
        if(i<0 && __MERGE()) {
            _j = array[i];
            println(_j);
        }

    word1 = 200;
    println(word1);
    fibonacci(23);
    for(i=0; i<24; i++) {
        int temp;
        temp = fib_mem[i];
        println(temp);
    }
}