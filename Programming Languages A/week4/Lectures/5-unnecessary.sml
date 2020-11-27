fun n_times (f, n, x) =
    if n = 0
    then x
    else f (n_times (f, n-1, x)) ;

(* Let's say we want to define a function that takes in a list and
returns the nth tail. We can use anonymous function as the following: *)

fun nth_tail (n, list) = n_times (fn y => tl y, n, list) ;

(* However, this is unnecesary. We can simply use the tl. *)

fun nth_tail_simple (n, list) = n_times (tl, n, list) ;
