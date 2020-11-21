(* In the previous datatype example, our example was not useful. Here is some
example of useful application of datatypes: playing cards! *)

datatype suit = Club 
       |  Diamond 
       |  Heart 
       | Spade ;

datatype rank = Jack 
       |  Queen 
       |  King 
       |  Ace 
       |  Num of int ;

(* Without these datatypes, we might ended up using something like...1 for spade, 2 for hearts, etc. *)

(* Another application is an ID to identify people. Below is an example of a datatype that identifies students based on student ID, or name if the student don't have student ID (this is true when the student is not officially enrolled in the class, such as auditing the class, or guest student) *)

datatype id = StudentNum of int 
            | Name of string
                          * (string option)
                          * string ;

(* Using a one-of datatype like above is a good practice compared to an each-of, which is common in other languages. *)

(*{ student_num: int,
  first: string,
  middle: string option, (* option because a person might not have middle name *)
  last : string}*) ;

(* The implementation above is a bad style because we know that a student that has a student id already have all these data, so it's better to simply have one or the other (either student id number or names) *)


(* Here is another datatype that represents arithmetic expression *)
datatype exp = Constant of int
       | Negate of exp 
       | Add of exp * exp 
       | Multiply of exp * exp ;

(* Functions over recursive datatypes are usually recursive *)
fun eval e=
    case e of
        Constant i => i 
     | Negate e => ~ (eval e) 
     | Add (e1, e2) =>  (eval e1) + (eval e2) 
     | Multiply(e1, e2) =>  (eval e1) * (eval e2) ;

(* When we use Add, it's an exp, not an int! Eval that exp to extract the int *)
val fifteen_exp = Add(Constant 19, Negate (Constant 4))  ;
val fifteen = eval fifteen_exp = 15

