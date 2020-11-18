(* EXTRA PRACTICE PROBLEMS *)

(* Problem 1: Write a function...
alternate: int list -> int
...that takes a list of numbers and adds them with alternating sign. For example,
alternate [1, 2, 3, 4] = 1 - 2 + 3 - 4 = -2 *)
fun alternate (l: int list) =
    let
        (* Use a multiplier that alternates between 1 and -1 for every recursive call. *)
        fun helper(l: int list, multiplier: int) = 
            if null (tl l)
            then multiplier * hd l
            else (multiplier * hd l)+ helper (tl l, multiplier * ~1)
    in
        helper(l, 1)
    end

(* Problem 1 Tests *)
val test1P1 = alternate [1, 2, 3, 4] = ~2
val test2P1 = alternate[3] = 3

(* Problem 2: Write a function...
min_max: int list -> int * int
...that takes a non-empty list of numbers, and returns a pair (min, max) of the minimum and maximum of the
number in the list. *)

