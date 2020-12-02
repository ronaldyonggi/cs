(* Old way of a function taking multiple arguments *)

fun is_sorted_3 (x, y, z) =
    z >= y andalso y >= x ;

is_sorted_3 (7, 9, 11) = true;

(* New Way: Currying *)
val sorted3 = fn x => fn y => fn z =>
                 z >= y andalso y >= x ;

sorted3 7 9 11 = true;

(* Turns out we can write sorted 3 in an even simpler way! *)
fun sorted3_simple x y z = z >= y andalso y >= x ;
sorted3_simple 7 9 11 = true;

(* Here is a curried version of fold function *)
fun fold f acc list =
    case list of
        [] => acc 
      | x :: rest => fold f (f(acc, x)) rest ;

(* And here is an example of using the fold above. *)
fun sum list = fold (fn (x, y) => x+y) 0 list ;
