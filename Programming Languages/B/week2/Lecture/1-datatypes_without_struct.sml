(* in ML, we can't have a list of "ints or strings", so we use 
our own datatype. *)

datatype int_or_string = I of int | S of string;

(* int_or_string list -> int *)
fun funny_sum xs =
    case xs of
	[] => 0
     | (I i) :: rest => i + funny_sum rest
     | (S s) :: rest => String.size s + funny_sum rest ;

(* In Racket, dynamic typing makes this natural without explicit tags.
We can simply check car of list with number? or string? *)

(* Recall the exp datatype we defined on previous course *)

datatype exp = Const of int
	     | Negate of exp
	     | Add of exp * exp
	     | Multiply of exp * exp;

(* And a function to evaluate an exp *)
fun eval_exp e =
    case e of
	Const i => i 
     | Negate ex => ~ (eval_exp ex)
     | Add (e1, e2) => (eval_exp e1) + (eval_exp e2)
     | Multiply (e1, e2) => (eval_exp e1) * (eval_exp e2);

val test_exp = Multiply (Negate (Add (Const 2, Const 2)),
			 Const 7);
val old_test = eval_exp test_exp = ~28;
