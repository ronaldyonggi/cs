(* Here is another example of a function that can be implemented recursively *)

fun sum list =
    case list of
        [] => 0 
      | x :: rest => x + sum rest ;

fun sum_tail list =
    let fun helper(list, sumsofar) =
            case list of
                [] => 0 
             | x :: rest => helper(rest, x + sumsofar)
    in
        helper(list, 0)
    end;

(* And here is a function rev that reverses a list, that is easier to write with
the tail-recursive way! *)

fun rev_tail list =
    let fun helper(list, acc) =
            case list of
                [] => acc 
             | x :: rest =>  helper(rest, x::acc)
    in
        helper(list, [])
    end ;
