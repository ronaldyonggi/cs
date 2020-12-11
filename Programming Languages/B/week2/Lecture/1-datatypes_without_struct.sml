(* in ML, we can't have a list of "ints or strings", so we define 
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
fun eval_exp e = (* exp -> int *)
    case e of
	Const i => i 
     | Negate ex => ~ (eval_exp ex)
     | Add (e1, e2) => (eval_exp e1) + (eval_exp e2)
     | Multiply (e1, e2) => (eval_exp e1) * (eval_exp e2);

val test_eval = Multiply (Negate (Add (Const 2, Const 2)),
			 Const 7);
val evaluate_test = eval_exp test_eval = ~28;

(* Below is a dfferent version of eval_exp, but instead of
exp -> int, here it's exp -> exp *)
exception Error of string;

fun eval_new e =
    let
	fun get_int e =
	    case e of
		Const i => i 
	     | _ => raise (Error "expected Const result")
    in
	case e of
	    Const _ => e 
	 | Negate ex => Const (~ (get_int (eval_new ex)))
	 | Add (e1, e2) => Const ((get_int (eval_new e1)) + (get_int (eval_new e2)))
	 | Multiply (e1, e2) => Const ((get_int (eval_new e1)) * (get_int (eval_new e2)))
    end;

val evaluate_new = eval_new test_eval = Const ~28;
