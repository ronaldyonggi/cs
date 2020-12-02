(* First class functions are where functions become values or argument of another function *)

fun double x = 2* x ;
fun incr x = x + 1;
val a_tuple = (double, incr, double (incr 7)) ;
(#1 a_tuple) 9 = 18;
