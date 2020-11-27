(* We can create a linked list using our own datatype. Below is an example of an int
linked list. *)

datatype int_list = Empty 
                  | Cons of int * int_list ;

val x = Cons (4, Cons (5, Cons (6, Empty))) ;

fun append (l1, l2) =
    case l1 of
        Empty => l2 
      | Cons (a, list) => Cons (a, append(list, l2)) ;

(* Note that in actual practice, we should just use built-in list. The self-defined
linked list above is actually a bad style.

Options are actually a datatype binding with constructors NONE and SOME. Here is
a function that takes in an option and contains a case expression. *)

fun inc_or_zero (intoption) =
    case intoption of
        NONE => 0 
      | SOME i =>  i + 1 ;

(* Built-in lists in ML are actually datatypes as well!*)

fun sum_list (l) =
    case l of
        [] => 0 
      | a::list => a + sum_list(list) ;

fun append (l1, l2) =
    case l1 of
        [] = l2 
     | a::list => a :: append(list, l2)
