(* Produce a list counting up from 'from' to 'to'. For example, if from is 3 and to is 6, then output is [3, 4, 5, 6] *)
fun count (from: int, to: int) =
    if from = to
    then to::[]
    else from :: count(from+1, to)

val testCount = count(3, 6) = [3,4,5,6]

(* Return a list counting up starting from 1 to x *)
fun countup_from1(x: int) = 
    count(1, x)

val testCountup = countup_from1(4) = [1, 2, 3, 4]

(* A better way is to have the count function within the countup function *)
fun countup2(x: int) =
    let
        fun count(from: int) =
            if from = x
            then x::[]
            else from :: count(from+1)
    in
        count(1)
    end

val testCountup2 = countup2(4) = [1, 2, 3, 4]
            
