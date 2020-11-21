(* Recall from previous lecture that lists and options are claimed to be not special
(can be created with datatypes). *)

(* in ML, before our program starts running, the following POLYMORPHIC DATATYPES
are run! *)

datatype 'a option = NONE
                   | SOME of 'a ;

datatype 'a mylist = Empty 
                  |  Cons of 'a * 'a mylist ;

(* The following is a polymorphic datatype implementation of a binary tree! *)

datatype ('a, 'b) tree = Node of 'a * ('a, 'b) tree * ('a, 'b) tree 
                       | Leaf of 'b ;

fun sum_tree tr =
    case tr of
        Leaf i => i 
     | Node (i, left, right) =>  i + sum_tree left + sum_tree right
                      
