(* Here if we're adding a new datatype Mult, we need to update the datatype
AND add another entry in pattern matching for all the functions. Otherwise
if we didn't add another entry, all these functions will throw a warning saying
cases are not complete / exhaustive. *)

datatype exp =
	 Int of int
	 | Negate of exp
	 | Add of exp * exp
     | Mult of exp * exp; (* Need to add a Mult *)

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
      | Add (e1, e2) => add_values (eval e1, eval e2)
      | Mult (e1,e2) => (case (eval e1, eval e2) of
                            (Int i, Int j) => Int (i*j) 
                            | _ => raise BadResult "non-int in multiplication")

fun toString e =
    case e of
	Int i => Int.toString i 
     | Negate e1 => "-(" ^ (toString e1) ^ ")"
     | Add (e1, e2) => "(" ^ (toString e1) ^ " + " ^ (toString e2) ^ ")"
     | Mult (e1, e2) => "(" ^ (toString e1) ^ " * " ^ (toString e2) ^ ")";

fun hasZero e =
    case e of
	Int i => i = 0 
     | Negate e1 => hasZero e1 
     | Add (e1, e2) => (hasZero e1) orelse (hasZero e2);
     | Mult (e1, e2) => (hasZero e1) orelse (hasZero e2)

fun noNegConstants e = 
    case e of
        Int => if i < 0 then Negate (Int (~i)) else 1
        | Negate e1 => Negate (noNegConstants e1)
        | Add (e1, e2) => Add(noNegConstants e1, noNegConstants e2)
        | Mult (e1, e2) => Mult (noNegConstants e1, noNegConstants e2)