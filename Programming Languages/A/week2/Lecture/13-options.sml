(* Recall the good max function from previous lecture. Here we rename it as old_max. *)
fun old_max(l: int list) =
    if null l
            (* Simply returning 0 is a bad practice! *)
    then 0
    else if null (tl l)
    then hd l
    else
        let val next = old_max(tl l)
        in
            if hd l > next
            then hd l
            else next
        end
            
(* Instead of 0, might think of returning a zero element a.k.a. empty list, but this is also a bad practice! A better practice is to use an option: NONE and SOME.  *)
fun option_max(l: int list) =
    if null l
            (* If initially input l is empty, then return NONE *)
    then NONE
    else let
        val next = option_max(tl l)
    in
        (* If there's still next element left, and the next element is greater than current element, return that element WITHIN SOME. Otherwise return current element WITHIN SOME *)
        if isSome next andalso valOf next > hd l
        then next
        else SOME(hd l)
    end
             (* BEWARE! this function returns SOME, not the actual value themselves. You still need to unwrap the return value using valOf. *)

val testOptionMax = option_max([3, 4, 5]) = SOME(5)
val testNone = option_max([]) = NONE
(* Accessing the value within SOME *)
val testAccess = valOf(SOME(5)) = 5
                                      (* Note that you can't take the valOf of a NONE *)




                                      (* The function above can be optimized even further. Notice the part 'isSome next' is called for every recursive call. This is unnecessary since we only need to check whether the input list is empty in the BEGINNING CALL (if null, then NONE). The following is an optimized function. *)
fun optimized_max(l: int list) =
    if null l
    then NONE
    else let (* By the time we get here, we know that our initial input
        list IS NOT EMPTY. The smallest would be a single element list. *)
        fun helper(l: int list) =
            (* Since we know the smallest would be a single element list, for base case we can check that if the next element is null, return hd. *)
            if null (tl l)
            then hd l
            else let val next = helper(tl l)
                 in
                     if hd l > next
                     then hd l
                     else next
                 end
    in
        (* Remember that our output has to be wrapped in SOME! *)
        SOME (helper(l))
    end

val testOptimized =  optimized_max([3, 4, 5]) = SOME(5)
val testOptimizedNull = optimized_max([]) = NONE
            
