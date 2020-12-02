(* Recall our datatype of expression: *)

datatype exp = Constant of int 
       | Negate of exp 
       | Add of exp * exp 
       | Multiply of exp * exp ;

(* And recall our function definition of eval: *)
fun eval e=
    case e of
        Constant i => i 
     | Negate e => ~ (eval e) 
     | Add (e1, e2) => (eval e1) + (eval e2) 
     | Multiply(e1, e2) => (eval e1) * (eval e2) ;

(* There's actually another style of implementing this function!

When we define a function, we can actually do pattern matching
like the following, *)

fun f p = e 
  | f p2 = e2 ;

(* Thus, our new eval function will look like the following, *)

fun eval (Constant i) = i 
  | eval (Negate e2) =  ~ (eval e2) 
  | eval (Add (e1, e2)) =  (eval e1) + (eval e2) 
  | eval (Multiply(e1, e2)) = (eval e1) * (eval e2) ;

(* And here's another way of writing the append function: *)
fun append([], list) = list 
  | append (x::rest, list) = x :: append(rest, list) ;

(* In general, the following format: *)
fun f x =
    case x of
        p1 => e1 
     | p2 => e2
     | ... ;

(* ...can be written as: *)
fun f p1 = e1 
  | f p2 = e2 
  | ... 
  | f pn = en ;


                                        

