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
val p9t4 = all [] = true ;

(* Problem 10 tests *)

val p10t1 = zip ([1, 2, 3], [4, 6]) = [(1, 4), (2, 6)] ;
val p10t2 = zip ([1, 2], [4, 5, 6]) = [(1, 4), (2, 5)] ;
val p10t3 = zip ([1, 2, 3], [4, 5, 6]) = [(1,4), (2, 5), (3, 6)] ;

(* Problem 13 tests *)
val p13lp = [("lol", 42), ("huh", 7), ("hi", 4)];
val p13t1 = lookup (p13lp, "huh") = SOME 7;
val p13t2 = lookup (p13lp, "woah") = NONE;

(* Problem 14 tests *)
val p14t1 = splitup [1, ~1, 2, ~2, 3, ~3] = ([1, 2, 3], [~1, ~2, ~3]);

(* Problem 15 tests *)
val p15t1 = splitAt ([1, 2, 3, 5, 6, 7], 4) = ([5, 6, 7], [1, 2, 3]);

(* Problem 16 tests *)
val p16t1 = isSorted [1,2, 2, 3, 5] = true;
val p16t2 = isSorted [1, 2, 4, 3, 5] = false;
val p16t3 = isSorted [1, 2, 1] = false;

(* Problem 17 tests *)
val p17t1 = isAnySorted [1, 2, 2, 3, 5] = true;
val p17t2 = isAnySorted [5, 4, 3, 3, 2] = true;
val p17t3 = isAnySorted [1, 1] = true;
val p17t4 = isAnySorted [1, 2, 1] = false;

(* Problem 18 tests *)
val p18t1 = sortedMerge ([1, 4, 7], [5, 8, 9]) = [1,4,5,7,8,9];
val p18t2 = sortedMerge ([1, 4, 7], [4, 5, 8, 9]) = [1, 4, 4, 5, 7, 8, 9];

(* Problem 20 tests *)
val p20t1 = divide [1, 2, 3, 4, 5, 6, 7] = ([1, 3, 5, 7], [2, 4, 6]) ;

(* Problem 21 tests *)
val p21t1 = not_so_quick_sort [1, 3, 2, 4, 7, 5, 8] = [1, 2, 3, 4, 5, 7, 8];

(* Problem 22 tests *)
val p22t1 = fullDivide (2, 40) = (3, 5);
val p22t2 = fullDivide (3, 10) = (0, 10);


