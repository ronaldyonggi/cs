(* Recall an option is an example of one-of type: either there's data or NONE.
 Here we make our own one-of type using datatype.

Also recall so far we've made bindings with 'val' for
variables and 'fun' for functions. Here we use 'datatype'. *) 

datatype mytype = TwoInts of int * int
               |  Str of string
       |  Pizza

(* mytype carries either int*int or string or nothing. The names 'TwoInts',
 'Str', 'Pizza' are constructors. These constructors are functions that given the correct
type of argumenst, return a mytype. *)

val a = TwoInts(3, 4)
val b = Str "lol"
val c = Pizza
 (* Notice that the types of a, b and c are all mytype. *)
