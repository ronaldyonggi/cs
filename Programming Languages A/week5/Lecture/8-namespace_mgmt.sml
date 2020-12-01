structure MyMathLib =
struct

fun fact x =
    if x = 0
    then 1
    else x * fact (x-1);

val half_pi = Math.pi / 2.0 ;

fun doubler y = y + y
end;

val pi = MyMathLib.half_pi + MyMathLib.half_pi ;

val twentyEight = MyMathLib.doubler 14 = 28;

(* We can use variables and functions that are within
MyMathLib module without calling MyMathLib by using open, but
it's a bad practice since it can potentially collide with variables and
 functions that are also in the same scope. *)

open MyMathLib;
val twentyeightagain = doubler 14 = 28;

