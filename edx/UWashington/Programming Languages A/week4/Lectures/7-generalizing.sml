(* A function can return functions! *)
fun double_or_triple f =
    if f 7 (* If applying f to 7 returns true *)
    then fn x => 2 * x
    else fn x => 3 * x ;

val double = double_or_triple (fn x => x - 3 = 4) ;
val nine = (double_or_triple (fn x => x = 42)) 3 = 9;

(* Recall our datatype exp *)
datatype exp = Constant of int 
       | Negate of exp 
       | Add of exp * exp 
       | Multiply of exp * exp ;

(* Give an exp, how do we check if every constant in it is
an even number? *)

fun every (f, e) =
    case e of
        Constant i => f i 
     | Negate i => every (f, i) 
     | Add(e1, e2) => every(f, e1) andalso every (f, e2) 
     | Multiply (e1, e2) => every (f, e1) andalso every (f, e2) ;

fun all_even e = every(fn x => x mod 2 = 0, e) ;


