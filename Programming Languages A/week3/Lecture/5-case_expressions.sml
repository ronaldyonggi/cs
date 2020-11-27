(* Recall mytype from previous lecture. *)
datatype mytype = TwoInts of int * int
                | Str of string
      |  Pizza ;

(* Now recall that in options, we can:
- check if something is NONE or SOME using isSome
- extract the data within SOME using valOf

similarly, we use hd and tl to extract data from lists! Here with datatype,
we use case expression. *)
             
fun f (x: mytype) =  (* we can even simply write fun f x *)
    case x of (* Similar to if this then that else somethingelse *)
        Pizza => 3
     | Str s => String.size s
     | TwoInts(i1,i2) => i1+i2 ;
(* We can't have duplicate case, for example, if we have Pizza => 8 on top of the cases above. If we
do, when we compile the code it'll throw an error! *)

(* NOTE: the return type of the case expression must be all of the same type! Can't have
different types (e.g. Pizza => bool, Str s => string, etc. *)

val a = TwoInts(3, 4) ;
val seven = f(a) = 7;

val b = Pizza;
val three = f(b) = 3;

val c = Str "lol";
val three = f(c) 

