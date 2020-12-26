
datatype exp =
	 Int of int
	 | Negate of exp
	 | Add of exp * exp
     | Mult of exp * exp
     (* Added new datatypes: String and Rational *)
     | String of string
     | Rational of int  * int ;

exception Badresult of string;

fun add_values (v1, v2) =
    case (v1, v2) of
	(Int i, Int j) => Int (i+j)
    (* Added a lot more cases for helper function *)
    | (Int i, String s) => String (Int.toString i ^ s)
    | (Int i, Rational (j, k)) => Rational (i*k+j, k)
    | (String s, int i) => String(s ^ Int.toString i)
    | (String s1, String s2) => String (s1 ^ s2)
    | String s, Rational (i, j)) => String (s ^ Int.toString i ^ "/" ^ Int.toString j)
    (* Earlier we had a case of adding int and rational. in case of rational and int, just
    recursive call add_values with swapped arguments *)
    | (Rational _, Int _) => add_values (v2, v1) 
    | (Rational (i, j), String s) => String (Int.toString i ^ "/" ^ Int.toString j ^ s)
    | (Rational (a, b), Rational (c,d)) => Rational (a*d + b*c, b*d)
    | _ => raise BadResult "non-values passed to add_values"

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
      (* However, adding more cases for each function is easy *)
      | String _ => e
      | Rational _ => e

fun toString e =
    case e of
	Int i => Int.toString i 
     | Negate e1 => "-(" ^ (toString e1) ^ ")"
     | Add (e1, e2) => "(" ^ (toString e1) ^ " + " ^ (toString e2) ^ ")"
     | Mult (e1, e2) => "(" ^ (toString e1) ^ " * " ^ (toString e2) ^ ")";
     | String s => s
     | Rational (i, j) => Int.toString i ^ "/" ^ Int.toString j

fun hasZero e =
    case e of
	Int i => i = 0 
     | Negate e1 => hasZero e1 
     | Add (e1, e2) => (hasZero e1) orelse (hasZero e2);
     | Mult (e1, e2) => (hasZero e1) orelse (hasZero e2)
     | String _ => false (* A string will never have a zero! *)
     | Rational (i, j) => i = 0 (* For rational, just need to check whether numerator is 0*)

fun noNegConstants e = 
    case e of
        Int => if i < 0 then Negate (Int (~i)) else 1
        | Negate e1 => Negate (noNegConstants e1)
        | Add (e1, e2) => Add(noNegConstants e1, noNegConstants e2)
        | Mult (e1, e2) => Mult (noNegConstants e1, noNegConstants e2)
        | String _ => e
        | Rational (i, j) => if i < 0 andalso j < 0 then Rational (~i, ~j)
                             else if j < 0 then Negate (Rational (i, ~j))
                             else if i < 0 then Negate (Rational (~i, j))
                             else e
