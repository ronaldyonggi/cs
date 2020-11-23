(* The built-in hd in ML actually as the following, *)
fun hd list =
    case list of
        [] => raise List.Empty 
      | x::_ => x ;

(* As we can see from above, we raise an exception when the list is empty. We can
actually write our own exceptions! *)

exception ugh ;

fun mydiv (x, y) =
    if y = 0
    then raise ugh
    else x div y ;

(* We can actually pass an exception as an argument to a function! The exception has
a type exn. *)
fun maxlist (list, ex) = (* int list * exn -> int *)
    case list of
        [] => raise ex 
     | x ::[] => x 
     | x::rest => Int.max(x, maxlist(rest, ex)) ;

(* And last but not least, we can HANDLE exceptions *)

maxlist([], ugh)  = 42
handle ugh => 42


