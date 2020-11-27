use "extra.sml" ;

(* Problem 2 tests *)
val p2t1 = do_until (fn x => x div 2) (fn x => x mod 2 <> 1) 8 = 1;
val p2t2 = do_until (fn x => x div 2) (fn x => x mod 2 <> 1) 5 = 5;

(* Problem 3 tests *)
val p3t1 = factorial 3 = 6 ;
val p3t2 = factorial 4 = 24;

(* Problem 4 tests *)

(* Problem 5 tests *)
val p5t1 = map2 (fn x => 2*x) (5, 7) = (10, 14);

(* Problem 6 tests *)
fun p6fn x = [x, 2 * x, 3 * x];
val p6t1 = app_all p6fn p6fn 1 = [1,2,3,2,4,6,3,6,9];

(* Problem 7 tests *)
val p7t1 = foldr (fn (x,y) => x + y) 5 [1, 2, 3]
