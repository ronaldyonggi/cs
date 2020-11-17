(* Takes in a list, returns the sum of all elements in the list *)
fun sum_list (l: int list) =
    if null l
    then 0
    else hd l + sum_list (tl l)

val testSumList = sum_list [3, 4, 5] = 12


(* Returns a list of countdown starting from n to 1 *)
fun countdown (n: int) =
    if n = 0
    then []
    else n::countdown(n-1)

val testCountdown = countdown(4) = [4,3,2,1]
    

(* Appends 2 lists *)
fun append (a: int list, b: int list) = 
    if null a
    then b
    else hd a :: append(tl a, b)

val testAppend = append([1, 2], [3, 4]) = [1,2,3,4]





                                              
(* FUNCTIONS FOR PAIRS OF LISTS *)

(* Returns the sum of the input pairs *)
fun sum_pair_list (l: (int * int) list ) =
    if null l
    then 0
    else #1 (hd l) + #2 (hd l) + sum_pair_list (tl l)

val testSumPairList = sum_pair_list [(1, 2), (3, 4)] = 10

(* Returns a list containing only the first elements of the given list of pairs *)
fun firsts(l: (int * int) list )=
    if null l
    then []
    else #1 (hd l) :: firsts (tl l)

val testFirsts = firsts [(1, 2), (3, 4)] = [1, 3]

