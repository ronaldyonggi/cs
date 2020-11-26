use "extra.sml";

val f1 = {grade = SOME 76, id = 12345} ;
val f2 = {grade = SOME 74, id = 958} ;
val f3 = {grade = NONE, id = 11} ; 
val f4 = {grade = SOME 80, id = 583} ; 

(* Tests for Problem 1 *)
val p1t1 = pass_or_fail {grade = SOME 76, id = 12345} = pass; 
val p1t2 = pass_or_fail {grade = SOME 74, id = 958} = fail;
val p1t3 = pass_or_fail f3 = fail;

(* Tests for Problem 2 *)
val p2t1 = has_passed {grade = SOME 76, id = 12345} = true;
val p2t2 = has_passed {grade = SOME 74, id = 958} = false;
val p2t3 = has_passed f3 = false;

(* Tests for Problem 3 *)
val p3t1 = number_passed [f1, f2, f3, f4] = 2;

(* Tests for Problem 4 *)
val a1 = {pass_fail = pass, final_grade = f1} ;
val a2 = {pass_fail = pass, final_grade = f2} ;
val a3 = {pass_fail = fail, final_grade = f3} ;
val a4 = {pass_fail = fail, final_grade = f4} ;
val listP4 = [a1, a2, a3, a4] ;
val p4t1 = number_misgraded listP4 = 2;

(* Tests for Problem 5 *)
val p5node1 = node {value = "leaf", left = leaf, right = leaf}; 
val p5node2 = node {value = "node", left = p5node1, right = leaf } ;
val p5t1 = tree_height p5node2 = 2 ;
val p5t2 = tree_height leaf = 0;

(* Tests for Problem 6 *)
val p6node1 = node {value = 8, left = leaf, right = leaf}; 
val p6node2 = node {value = 9, left = p6node1, right = leaf}; 
val p6t1 = sum_tree p6node2 = 17 ;
val p6t2 = sum_tree leaf = 0;

(* Tests for Problem 9 *)
val p9t1 = is_positive (SUCC (SUCC ZERO)) = false ;

(* Tests for Problem 10 *)
val p10t1 = pred (SUCC (SUCC ZERO)) = SUCC ZERO;

(* Tests for Problem 11 *)
val p11t1 = nat_to_int (SUCC (SUCC ZERO)) = 2;
val P11t2 = nat_to_int ZERO = 0;
val p11t3 = nat_to_int (SUCC (SUCC (SUCC ZERO))) = 3;

(* Tests for Problem 12 *)
val p12t1 = int_to_nat 2 = SUCC (SUCC ZERO) ;
val p12t2 = int_to_nat 0 = ZERO;

(* Tests for Problem 13 *)
val p13t1 = add (SUCC ZERO, ZERO) = SUCC ZERO;
val p13t2 = add (SUCC (SUCC ZERO), SUCC (SUCC ZERO)) = SUCC (SUCC (SUCC (SUCC ZERO))) ;

(* Tests for Problem 14 *)
val p14t1 =  sub (SUCC ZERO, ZERO) = SUCC ZERO;
val p14t2 =  sub (SUCC (SUCC ZERO), SUCC ZERO) = SUCC ZERO;

(* Tests for Problem 15 *)
val p15t1 = mult (ZERO, SUCC (SUCC ZERO)) = ZERO;
val p15t2 = mult (SUCC (SUCC ZERO), SUCC (SUCC ZERO)) = SUCC(SUCC(SUCC(SUCC ZERO)));

(* Tests for Problem 16 *)
val p16t1 = less_than (ZERO, ZERO) = false;
val p16t2 = less_than (SUCC ZERO, SUCC (SUCC ZERO)) = true;
val p16t3 = less_than (SUCC (SUCC ZERO), SUCC ZERO) = false;
