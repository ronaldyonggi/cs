(* pr stands for pair *)

(* Swaps the contents of a pair. The input 1st argument must be int, 2nd argument must be bool *)
fun swap(pr: int*bool)=
    (#2 pr, #1 pr)

(* Takes in 2 pairs, returns the sum of the contents *)
(* Types: (int * int) * (int * int) -> int   *)
fun sum_two_pairs (pr1: int * int, pr2: int * int) =
    (#1 pr1) + (#2 pr1) + (#1 pr2) + (#2 pr2)

(* Returns a pair where the first element is the result of x / y, while the 2nd element is the remainder *)
(* Types: int * int -> (int * int)  *)
fun div_mod(x: int, y: int) =
    (x div y, x mod y)

(* Sorts a pair. The 1st element should be less than the 2nd element. *)
fun sort_pair(pr: int * int) =
    if (#1 pr) > (#2 pr)
    then (#2 pr, #1 pr)
    else pr
             

(* Tests *)
val testSwap = swap((3, false)) = (false, 3)
val testSumTwoPairs = sum_two_pairs((2, 3), (5, 7)) = 17
val testdivmod = div_mod((3, 2))= (1, 1)
val testSort = sort_pair(7, 3) = (3, 7) 

(* Nesting *)
val x1 = (7, (true, 9))
val x2 = #1 (#2 x1) = true
val x3 = (#2 x1) = (true, 9)
val x4 = ((3,5), ((4,8), (0,0)))
