int array[16], fib_mem[24];
int _j, number1, WORD, word1;

void merge1(int begin, int mid, int end) {
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
    merge1(begin, mid, end);
    return 0;
}

int MERGE() {
    number1 = -15000;
    println(number1);
    return 1;
}

void main() {
    int i, a, b;
    a = 0;
    b = 15;
    mergeSort(a, b);

    for(i=0; i<16; i++) {
        if(i >= 0 || MERGE()) {
            WORD = 1;
            WORD = 3;
            WORD = array[i];
            println(WORD);
        }
    }
    for(i=0; i<16; i++)
        if(i<0 && MERGE()) {
            _j = array[i];
            println(_j);
        }    

}