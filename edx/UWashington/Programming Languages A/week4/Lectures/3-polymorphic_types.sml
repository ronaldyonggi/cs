(* ('a -> 'a) * int * 'a -> 'a   *)
fun n_times (f, n, x) =
    if n = 0
    then x
    else f (n_times (f, n-1, x)) ;
           

fun increment x = x + 1;
fun double x = x + x;
val x1 = n_times (double, 4, 7) ; (* instantiates 'a with int *)
val x2 = n_times (increment, 4, 7) ; (* instantiates 'a with int *)


val x3 = n_times (tl, 2, [4, 8, 12, 16]); 
(* The first argument tl is polymorphic, so it fulfills the 'a -> 'a
 The last argument is instantiated with int list. *)

(* Higher-order functions are often polymorphic based on the type
of function passed. However, this is not always then case. Below is an example
of a function that counts how many times f is applied to an x, until
x reaches 0. *)
fun until_zero (f, x) =
    if x = 0
    then 0
    else 1 + until_zero (f, f x);
(* Notice that here (int -> int) * int -> int. We can only take x of int and
f a function that processes int! 

Conversely, some polymorphic functions are not higher-order, which
we've seen before *)
fun len list =
    case list of
        [] => 0 
      | _::rest => 1 + len rest;


                                         
