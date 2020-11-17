
(* Bad version of max because of recomputation of recursive call. Takes in a list of numbers and return the max number. *)
fun bad_max(l: int list) =
    if null l
    then 0
    else if null (tl l)
    then hd l
    else if hd l > bad_max (tl l)
    then hd l
    else bad_max(tl l)

(* Helper functions countup and countdown, will be used to test our max function *)
fun countup (from: int, to: int) =
    if from = to
    then to :: []
    else from :: countup(from+1, to)

fun countdown(from: int, to: int) =
    if from = to
    then to :: []
    else from :: countdown(from-1, to)

                          (* The badmax function works fine for a list in which the highest element is found early. However for a list in which the highest number is found in the end, it is slow! *)

val earlyMax = bad_max(countdown(28, 1)) = 30
(*val lateMax = bad_max(countup(1, 25)) = 30 *)

(* A more efficient practice is to put the result of calling recursive max in a variable beforehand. This can avoid recursive recomputation! *)
fun good_max(l: int list) = 
    if null l 
    then 0
    else if null (tl l)
    then hd l
    else let
        (* Here we store the result of recursive computation in a variable *)
        val next_max = good_max(tl l)
    in
        (* Here, using the next_max variable DOESN'T call recursive computation! *)
        if hd l > next_max
        then hd l
        else next_max
    end

val earlyGoodMax = good_max(countdown(50, 1)) = 50
val lateGoodMax = good_max(countup(1, 40)) = 40
