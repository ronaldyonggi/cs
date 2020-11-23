
(* The following type definitions are used in Problem 1-4 *)
type student_id = int;
type grade = int (* must be in 0 to 100 range *) ;
type final_grade = { id : student_id, grade : grade option } ;
datatype pass_fail = pass | fail ;


(* Problem 1: Write a function pass_or_fail of type

{grade: int option, id: 'a} -> pass_fail

that takes a final_grade (or a more general type) and return pass if the grade field
contains SOME i for an i >= 75. Else fail.

*)

fun pass_or_fail (x: final_grade) =
    let
        val {grade = a, id = b } = x
    in
      case a of
          SOME i => if i >= 75 then pass else fail 
        | _ => fail
    end ;

(* Problem 2: Using pass_or_fail as a helper function, write
a function has_passed of type

{grade: int option, id : 'a} -> bool

...that returns true if and only if the grade field contains SOME i for an i >= 75. *)

fun has_passed (x: final_grade) =
    pass_or_fail(x) = pass ;

(* Problem 3: Using has_passed as a helper function, write a
function number_passed that takes a list of type final_grade (or a more general type) and returns how
many list elements have passing (again, >= 75) grades. *)

fun number_passed (list) =
    case list of
        [] => 0 
      | x::rest => if has_passed(x)
                   then 1 + number_passed (rest)
                   else number_passed (rest) ;

(* Problem 4: Write a function number_misgraded of type

(pass_fail * final_grade) list -> int

that indicates how many elements are "mislabeled" where mislabeling means:
- (pass, x) where has_passed x is false , or
- (fail, x) where has_passed x is true.
*)


fun number_misgraded (list) =
    case list of
        [] => 0 
     | x :: rest => 
       let
           val {pass_fail = p, final_grade = f} = x
       in
           case (p, has_passed(f)) of
               (pass, false) => 1 + number_misgraded (rest) 
            | (fail, true) => 1 + number_misgraded (rest) 
            | _ => number_misgraded (rest)
       end ;

(* The following datatypes are used in problem 5-7 *)
datatype 'a tree = leaf 
                 | node of { value : 'a, left : 'a tree, right : 'a tree }
datatype flag = leave_me_alone | prune_me ;

(* Problem 5: Write a function tree_heigth that accepts an 'a tree and evaluates to a height
of this tree. The height of a tree is the length of the longest path to a leaf. Thus
the height of a leaf is 0. *)

fun tree_height (tree : 'a tree) =
    case tree of
        leaf => 0  
      | node {value= v, left = l, right = r} => 1 + Int.max (tree_height l, tree_height r) ;


(* Problem 6: Write a function sum_tree that takes an int tree and evaluates to the sum of
all values in the nodes. *)
fun sum_tree (tree) =
    case tree of
        leaf => 0 
      | node {value = v, left = l, right = r} => v + sum_tree l + sum_tree r ;


(* The following datatype is used in Problems 9-16. *)
datatype nat = ZERO | SUCC of nat ;

(* Problem 9: Write is_positive : nat -> bool
which, given a "natural number" returns whether that number is positive
(e.g. not zero) *)

fun is_positive x =
    x = ZERO ;

(* Problem 10: Write pred: nat -> nat, which given a "natural number"
returns its predecessor. Since 0 does not have a predecessor in the natural numbers,
throw an exception Negative (will need to define it first). *)

exception Negative;
fun pred x =
    case x of
        ZERO => raise Negative
      | SUCC y => y;


(* Problem 11: Write nat_to_int: nat -> int, which given
a "natural number" returns the corresponding int. For example,
nat_to_int (SUCC (SUCC ZERO)) = 2 *)

fun nat_to_int x =
    case x of
        ZERO => 0
      | SUCC i => 1 + nat_to_int i;
