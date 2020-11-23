(* The following is a traditional factorial function *)
fun fact n =
    if n = 0
    then 1
    else n * fact (n-1) ;

(* However, if n is large, the call stack becomes large, thus the function
becomes inefficient! There is a way to solve this: implement our function
tail-recursively! *)

fun fact_tail n =
    let fun helper(n, acc) =
            if n = 0
            then acc
            else helper (n-1, acc * n)
    in
        helper(n, 1)
    end;

(* Here, ML uses the same stack for each recursive call, thus more efficient. *)

