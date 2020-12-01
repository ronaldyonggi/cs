signature MATHLIB =
sig 
    val fact : int -> int;
    val half_pi : real ;
    (* If we comment out or remove doubler, doubler becomes unavailable to
    outside user! *)
    (*val doubler: int -> int ; *)
end ;

structure MyMathLib :> MATHLIB =
struct

fun fact x =
    if x = 0
    then 1
    else x * fact (x - 1) ;

val half_pi = Math.pi / 2.0 ;

fun doubler y = y + y;

val eight = doubler 4 (* Within the module, works just fine *)
end ;

(*val twentyEight = MyMathLib.doubler 14; 

Above will throw error since doubler isn't available.

Thus, signatures are useful for HIDING THINGS from outside user / clients. *)

