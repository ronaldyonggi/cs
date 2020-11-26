(* Recall the currying applications from previous lecture. *)

fun sorted3 x y z =
    z >= y andalso y >= x;

fun fold f acc list =
    case list of
        [] => acc 
      | x ::rest => fold f (f(acc, x)) rest ;

(* We can apply TOO FEW arguments, and the result IS ACTUALLY USEFUL *)

val sum = fold (fn (x, y) => x + y) 0 ;
(* Now sum is a function that only need to take in a list! *)
sum [3, 4, 5] = 12;

(* Compare this with the traditional currying implementation
of sum, which is more verbose .*)
fun sum_inferior list =
    fold (fn (x, y) => x + y) 0 list;

(* Below is another example: *)
fun range i j =
    if i > j
    then []
    else i :: range (i+1) j ;

(* countup takes in an int n and returns a value counting up
incrementing by 1 starting from 1 to n *)
val countup = range 1;
countup 5 = [1, 2, 3, 4, 5] ; 
fun countup_inferior x = range 1 x; (* traditional version *)
            


(* Common usage is to curry higher-order functions with function arguments *)

fun exists predicate list =
    case list of
        [] => false 
      | x :: rest => predicate x orelse exists predicate rest;

(* hasZero is a function that takes in a list and checks whether it contains a 0. *)
val hasZero = exists (fn x => x = 0) ;
hasZero [3,4,5] = false;
hasZero [2, 0, 7] = true;

(* ML Standard Library's map and filter can be partial-curried as well! *)
val incrementAll = List.map (fn x => x + 1);
incrementAll[1, 2, 3] = [2, 3, 4];

val removeZeros = List.filter (fn x => x <> 0);
removeZeros [2, 0, 7] = [2, 7]; 
