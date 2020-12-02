(* Simple example of type inference *)
val x = 42;

fun f (y, z, w) =
    if y (* must be bool *)
    then z + x (* result must be int *)
    else 0 (* else also must be int *) ;

(* f must:
- return an int
- take a bool * int * ANYTHING (since w is not used)
so val f : bool * int * 'a -> int *)
