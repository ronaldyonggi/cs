(* Why Lexical Scope:

f1 and f2 are always the same, no matter where the result is used *)

fun f1 y =
    let val x = y + 1
    in fn z => x + y + z
    end ;

fun f2 y =
    let val q = y + 1
    in fn z => q + y + z
    end ;

val x = 17 (* irrelevant *) ;
val a1 = (f1 7) 4 = 19;
val a2 = (f1 7) 4 = 19;

(* Closures can easily store the data they need *)

fun greater_than_x x = fn y => y > x ;

fun filter (f, list) =
    case list of
        [] => [] 
      | x::rest => if f x
                   then x :: filter (f, rest)
                   else filter (f, rest) ;

fun no_negatives list = filter (greater_than_x ~1, list) ;

(* Below uses anonymous function rather than the
greater_than_x function. *)
fun all_greater (list, n) = filter (fn x => x > n, list) ;

