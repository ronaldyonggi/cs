(* Recall the n_times function *)

fun n_times (f, n, x) =
    if n = 0
    then x
    else f (n_times (f, n-1, x)) ;

(* Then we generalize a function that triples using n_times above. *)
fun triple x = 3*x ;
fun triple_n_times (n, x) = n_times (triple, n, x);

(* However there's a better way: defining the triple within
the triple_n_times using let! *)

fun triple_n_times2 (n, x) =
    let
        fun triple x = 3 * x
    in
        n_times (triple, n, x)
    end; 

(* Notice that the function definition triple is very short that we might
as well fit it in one line. *)
fun triple_n_times3 (n, x) =
    n_times (let fun triple x = 3*x in triple end, n, x) ; 

(* However, above is not a good style. The best way? Anonymous function!
This is analogous to lambda function in other languages. *)
fun triple_n_times_best (n, x) =
    n_times (fn x => 3 * x, n, x);
        

           
