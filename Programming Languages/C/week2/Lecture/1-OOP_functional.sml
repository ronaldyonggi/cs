datatype exp =
	 Int of int
	 | Negate of exp
	 | Add of exp * exp;

exception Badresult of string;

(* Helper function, ensures both values are integers *)
fun add_values (v1, v2) =
    case (v1, v2) of
	(Int i, Int j) => Int (i+j)
      | _ => raise BadResult "non-ints in addition";

fun eval e= 
    case e of
	Int _ => e 
      | Negate e1 => (case eval e1 of
			  Int i => Int (~i) 
			| _ => raise BadResult "non-int in negation")
      | Add (e1, e2) => add_values (eval e1, eval e2);

(* Above, we're just done with one column of the grid 'eval' *)

(* This is for 'toString' column in the matrix *)
fun toString e =
    case e of
	Int i => Int.toString i 
     | Negate e1 => "-(" ^ (toString e1) ^ ")"
     | Add (e1, e2) => "(" ^ (toString e1) ^ " + " ^ (toString e2) ^ ")";

(* This is for the 'hasZero' column *)
fun hasZero e =
    case e of
	Int i => i = 0 
     | Negate e1 => hasZero e1 
     | Add (e1, e2) => (hasZero e1) orelse (hasZero e2);
