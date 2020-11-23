use "extrapractice.sml";

(* Test Problem 1 *)
val p1t1 = alternate([1, 3, 5, 8])= ~5
val p1t2 = alternate([3]) = 3

(* Problem 2 tests *)
val p2t1 = min_max [3,4,5] = (3, 5)
val p2t2 = min_max [3] = (3, 3)

(* Problem 3 tests *)
val p3t1 = cumsum [1, 4, 20] = [1, 5, 25]
val p3t2 = cumsum[4] = [4]

(* Problem 4 tests *)
val p4t1 = greeting (SOME "foo") = "Hello there, foo!"
val p4t2 = greeting (NONE) = "Hello there, you!"

(* Problem 5 test *)
val p5t1 = repeat([1, 2, 3], [4, 0, 3]) = [1, 1, 1, 1, 3, 3, 3]
val p5t2 = repeat([1], [2]) = [1, 1]

(* Problem 6 tests *)
val p6t1 = addOpt(SOME 3, SOME 4) = SOME 7
val p6t2 = addOpt(SOME 3, NONE) = NONE

(* Problem 7 tests *)
val p7t1 = addAllOpt([SOME 1, NONE, SOME 3]) = SOME 4
val p7t2 = addAllOpt([NONE, NONE]) = NONE

(* Problem 8 tests *)
val p8t1 = any [false, false, false] = false
val p8t2 = any [true, false, false] = true
val p8t3 = any [] = false

(* Problem 9 tests *)
val p9t1 = all [true, true] = true
val p9t2 = all [false, false] = false
val p9t3 = all [true, false] = false
val p9t4 = all [] = true
