int a, b, c;

int main() {
    int d, e, f;
    d = 7*20/5;    
    {
        int gg, ff[4];
        gg = 100 + 34 + 69 - 53;
        println(gg);
        gg = !33;
        println(gg);
        gg = !0;
        println(gg);
        println(d); 

        gg = 0 && 0;
        println(gg);
        gg = 0 && 1;
        println(gg);
        gg = 1 && 0;
        println(gg);
        gg = 1 && 1;
        println(gg);
    }

    f = 420 % 55;
    println(f);
    e = 20 < 300;
    println(e);
    e = 20 >= 300;
    println(e);
}