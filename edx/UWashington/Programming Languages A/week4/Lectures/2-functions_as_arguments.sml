(* The following are simple functions that are written in
an unnecessarily bad way *)

(* Computes n + x *)
fun bad_increment (n, x) =
    if n = 0
    then x
    else 1 + bad_increment(n-1, x) ;

bad_increment(3, 2) = 5 ;

(* Computes 2^n * x   *)
fun bad_double_times (n, x) =
    if n = 0
    then x
    else 2 * bad_double_times(n-1, x) ;

(* Takes the nth tail of a list *)
fun bad_tail (n, list) =
    if n = 0
    then list
    else tl (bad_tail (n-1, list)) ;

bad_tail(2, [4, 8, 12, 16]) = [12, 16]; 

(* Using functions as argument, we can write the functions above
in a simpler way. *)

fun increment x = x+1;
fun double x = x + x;

fun n_times (f, n, x) =
    if n = 0
    then x
    else f(n_times (f, n-1, x)) ;

n_times (increment, 3, 2) = 5;
n_times (double, 3, 4) = 32;
n_times (tl, 2, [4, 8, 12, 16]) = [12, 16]; 

(* With the functions defined above, we can redefine the functions so that
it's easier for users to use. *)

fun addition (n, x) = n_times(increment, n, x) ;
fun double_n_times (n, x) = n_times (double, n, x) ;
fun nth_tail (n, x) = n_times (tl, n, x) ;

addition(5, 7) = 12;
double_n_times (4, 2) = 32 ;
nth_tail (2, [4, 8, 12, 16]) = [12, 16] ;



                          
