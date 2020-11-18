(* EXTRA PRACTICE PROBLEMS *)

(* Problem 1: Write a function...
alternate: int list -> int
...that takes a list of numbers and adds them with alternating sign. For example,
alternate [1, 2, 3, 4] = 1 - 2 + 3 - 4 = -2 *)
fun alternate (lst: int list) =
    let
        fun helper(lst: int list, multiplier: int) = 
            if null (tl lst)
            then multiplier * hd lst
            else (multiplier * hd lst)+ helper (tl lst, multiplier * ~1)
    in
        helper(lst, 1)
    end
