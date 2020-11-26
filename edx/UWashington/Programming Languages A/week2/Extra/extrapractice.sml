(* EXTRA PRACTICE PROBLEMS *)

(* Problem 1: Write a function...

alternate: int list -> int

...that takes a list of numbers and adds them with alternating sign. For example,
alternate [1, 2, 3, 4] = 1 - 2 + 3 - 4 = -2 *)
fun alternate (l: int list) =
    let
        (* Use a multiplier that alternates between 1 and -1 for every recursive call. *)
        fun helper(l: int list, multiplier: int) = 
            if null (tl l)
            then multiplier * hd l
            else (multiplier * hd l)+ helper (tl l, multiplier * ~1)
    in
        helper(l, 1)
    end


(* Problem 2: Write a function...

min_max: int list -> int * int

...that takes a non-empty list of numbers, and returns a pair (min, max) of the minimum and maximum of the
number in the list. *)
fun min_max (l: int list) =
    let
        fun min (l: int list) =
            if null (tl l)
            then hd l
            else let val next = min (tl l)
                 in
                     if hd l < next
                     then hd l
                     else next
                 end

        fun max (l: int list) =
            if null (tl l)
            then hd l
            else let val next = max (tl l)
                 in
                     if hd l > next
                     then hd l
                     else next
                 end
    in
        (min l, max l)
    end ;


(* Problem 3: Write a function...

cumsum: int list -> int list

... that takes a list of numbers and returns a list of the partial sums
of those numbers. For example,
cumsum [1, 4, 20] = [1, 5, 25]. *)
fun cumsum (l: int list) =
    let
        fun helper (l: int list, sumsofar: int) =
            if null (tl l)
            then [hd l + sumsofar]
            else (hd l + sumsofar) :: helper(tl l, hd l + sumsofar)
    in
        helper(l, 0)
    end


(* Problem 4: Write a function...

greeting: string option -> string

...that given a string option SOME name returns the string "Hello there, ...!" where
the dots would be replaced by name. Note that the name is given as an option, so if
it is NONE then replace the dots with "you". *)
fun greeting (s: string option) =
    let
        val message = "Hello there, "
    in
        if isSome(s)
        then message ^ valOf(s) ^ "!"
        else message ^  "you!"
    end


(* Problem 5: Write a function...

repeat: int list * int list -> int list

...that given a list of integers and another list of nonnegative integers, repeats
the integers in the first list according to the numbers indicated by the second
list. For example:
repeat ([1, 2, 3], [4, 0, 3]) = [1, 1, 1, 1, 3, 3, 3] *)

fun repeat (p: int list * int list) =
    let
        (* Takes in a number from first list and a number from 2nd list, returns a list where
        the e is repeated n times. *)
        fun helper(e: int, n: int) = 
                  if n = 0
                  then []
                  else e::helper(e, n-1)

        fun append(l1, l2) =
            if null l1
            then l2
            else hd l1 :: append(tl l1, l2)

        (* Append the result of applying helper of current element to the rest of the list. *)
        fun helperlist(l1, l2) =
            if null(l1)
            then []
            else append(helper(hd l1, hd l2), helperlist (tl l1, tl l2))
    in
        helperlist (#1 p, #2 p)
    end


(* Problem 6: Write a function...

addOpt: int option * int option -> int option

...that given two "optional" integers, adds them if they are both present (returning
SOME of their sum), or returns NONE if at least one of the two arguments is NONE. *)
fun addOpt(p: int option* int option) = 
    if isSome (#1 p) andalso isSome (#2 p)
    then SOME(valOf (#1 p) + valOf (#2 p))
    else NONE

(* Problem 7: Write a function...

addAllOpt : int option list -> int option

...that given a list of "optional" integers, adds those integers that are
there (e.g. adds all the SOME i). For example,

addAllOpt ([SOME 1, NONE, SOME 3]) = SOME 4

If the list does not not contain any SOME int it (e.g. all NONE or the list is empty), the function should
return none. *)
fun addAllOpt(l: int option list) = 
    if null l
    then NONE
    else let
        fun helper (l: int option list, sumsofar: int) =
            if null l
            then sumsofar
            else if isSome (hd l)
            then helper(tl l, sumsofar + valOf (hd l))
            else helper(tl l, sumsofar)
    in
        let val result = helper(l, 0)
        in
            if result = 0
            then NONE
            else SOME result
        end
    end

(* Problem 8: Write a function...
any : bool list -> bool
...that given a list of booleans returns true if there is at least of them that is true,
otherwise returns false. If the list is empty, return false because there's no true. *)
fun any (l: bool list) =
    if null l
    then false
    else let
        fun helper(l: bool list, lastbool: bool) = 
                  if null l
                  then lastbool
                  else helper (tl l, lastbool orelse hd l)
    in
        helper(l, false)
    end

(* Problem 9: Write a function...
all: bool list -> bool
...that given a list of booleans returns true if all of them true, otherwise
returns false. If the list is empty, return true because there is no false. *)
fun all(l: bool list) = 
    if null l
    then true
    else let
        fun helper(l: bool list, lastbool: bool) =
            if null l
            then lastbool
            else helper (tl l, lastbool andalso hd l)
    in
        helper(l, true)
    end ;

(* Problem 10: Write a function...
zip: int list * int list -> int * int list
that given two lists of integers, creates consecutive pairs, and stops when one of the
lists is empty. For example:
zip ([1, 2, 3], [4, 6]) = [(1, 4), (2, 6)] *)

fun zip (l1: int list, l2: int list) =
    if (null l1) orelse (null l2)
    then []
    else (hd l1, hd l2) :: zip(tl l1, tl l2);

(* Problem 12: Lesser challenge
Write a version zipOpt of zip with return type (int * int) list option.
This version should return SOME of a list when the original lists have the
same length, and NONE if they don't. *)

fun zipOpt (l1: int list, l2: int list) =
    let
        fun helper (l1: int list, l2: int list) =
            if (null l1) orelse (null l2)
            then if not ((null l1) andalso (null l2))
                 then NONE
                 else []
            else (hd l1, hd l2) :: helper (tl l1, tl l2) ;

        val result = helper (l1, l2)
    in
        if not (isSome result)
        then result
        else SOME result
    end

(* Problem 13: Write a function lookup:
(string * int) list * string -> int option
that takes a list of pairs (s, i) and also a string s2 to look up. It then goes through the list
of pairs looking for the string s2 in the first component. If it finds a match with the
corresponding number i, then it returns SOME i. Otherwise, returns NONE. *)

fun lookup (lp: (string * int) list, s: string ) =
    if null lp
    then NONE
    else if (#1 (hd lp)) = s
    then SOME (#2 (hd lp))
    else lookup (tl lp, s) ;


(* Problem 14: Write a function splitup: )
int list -> int list * int list
that given a list of integers creates two lists of integers, one containing the non-negative
entries, the other containing the negative entries. Relative order must be preserved: All non-
negative entries must appear in the same order in which they were on the original list, and similarly
for the negative entries. *)

fun splitup (l: int list) =
    let
        fun reverse (l: int list) = 
            let
                fun reverseHelper (l: int list, result : int list) =
                    if null l
                    then result
                    else reverseHelper (tl l, hd l :: result)
            in
                reverseHelper(l, [])
            end

        fun helper (l, sofarpos, sofarneg) =
            if null l
                    (* If we don't reverse the end result, the result would be all in reversed order!*)
            then (reverse sofarpos,reverse sofarneg)
            else if (hd l) < 0
            then helper (tl l, sofarpos, hd l :: sofarneg )
            else helper (tl l, hd l :: sofarpos, sofarneg) ;

    in
        helper(l, [], [])
    end ;

(* Problem 15: Write a version splitAt:
int list * int -> int list * int list
of the previous function that takes an extra "threshold" parameter, and uses that
instead of 0 as the separating oint for the two resulting lists.*)

fun splitAt (l: int list, threshold: int) =
    let
        fun reverse (l: int list) = 
            let
                fun reverseHelper (l: int list, result : int list) =
                    if null l
                    then result
                    else reverseHelper (tl l, hd l :: result)
            in
                reverseHelper(l, [])
            end

        fun helper (l, sofarpos, sofarneg) =
            if null l
                    (* If we don't reverse the end result, the result would be all in reversed order!*)
            then (reverse sofarpos,reverse sofarneg)
            else if (hd l) < threshold
            then helper (tl l, sofarpos, hd l :: sofarneg )
            else helper (tl l, hd l :: sofarpos, sofarneg) ;

    in
        helper(l, [], [])
    end ;

(* Problem 16: Write a function isSorted: int list -> boolean
that given a list of integers determines whether the list is roted in
increasing order. *)

fun isSorted (l: int list) =
    if null l
    then true
    else let (* at this point we know the input list is not empty *)
        fun helper (l: int list) =
            if null (tl l)
            then true
            else if (hd l) > (hd (tl l))
            then false
            else helper (tl l)
    in
        helper l
    end ;

(* Problem 17 : isAnySorted:
int list -> boolean
that given a list of integers determines whether the list os sorted in
in either increasing or decreasing order *)

fun isAnySorted (l: int list) =
    if null l
    then true
    else let
        fun isIncreasing (l: int list) =
            if null (tl l)
            then true
            else if (hd l) > (hd (tl l))
            then false
            else isIncreasing (tl l)

        fun isDecreasing (l: int list) =
            if null (tl l)
            then true
            else if (hd l) < (hd (tl l))
            then false
            else isDecreasing (tl l)
    in
        (isIncreasing l) orelse (isDecreasing l)
    end;

(* Problem 18: write a function sortedMerge:
int list * int list -> int list
that takes 2 list of integers that are each sorted from smallest to largest,
and merges them into one sorted list. For example,
sortedMerge ([1, 4, 7], [5, 8, 9]) = [1, 4, 5, 7, 8, 9] *)

fun sortedMerge (l1: int list, l2: int list) =
    if (null l1) andalso (null l2)
    then []
    else if null l1
    then l2
    else if null l2
    then l1
    else if (hd l1) < (hd l2)
    then (hd l1) :: sortedMerge (tl l1, l2)
    else (hd l2) :: sortedMerge (l1, tl l2);

(* Problem 19: Write a sorting function qsort: int list -> int list
that works as follows:
1. Take the first element out and use it as the "threshold" for splitAt
2. Then recursively sort the two lists produced by splitAt
3. Finally bring the two lists together. Don't forget to put back the
first element that was taken out.
You could use sortedMerge for the "bring together" part, buy you do not
need to as all the numbers in one list are less than all the numbers
in the other. *)

(* Problem 20: Write a function divide:
int list -> int list * int list
that takes a list of integers and produces two lists by alternating elements
between the two lists. For example:
divide ([1, 2, 3, 4, 5, 6, 7]) = ([1, 3, 5, 7], [2, 4, 6]) *)

fun divide (l: int list) =
    let
        fun reverse (l: int list) = 
            let
                fun reverseHelper (l: int list, result : int list) =
                    if null l
                    then result
                    else reverseHelper (tl l, hd l :: result)
            in
                reverseHelper(l, [])
            end

        fun helper (l: int list, left: int list, right: int list, isLeft : bool) =
            if null l
            then (reverse left, reverse right)
            else if isLeft
            then helper (tl l, (hd l) :: left, right, not isLeft)
            else helper (tl l, left, (hd l) :: right, not isLeft)
    in
        helper (l, [], [], true)
    end;

(* Problem 21: Write another sorting function not_so_quick_sort : int lst -> int list
that works as follows: Given the initial list of integers, splits it in two
lists using divide, then recursively sorts those two lists, then merges
them together with sortedMerge. *)

fun not_so_quick_sort (l: int list) =
    sortedMerge (divide l) ;

(* Problem 22: Write a function fullDivide: int * int -> int * int
that given two numbers k and n it attempts to evenly divide k into
n as many times as possible, and returns a pair (d, n2) where d
is the number of times while n2 is the resulting n after all those divisions.
Example:
fullDivide (2, 40) = (3, 5) because 2 * 2 * 2 * 5 = 40
fullDivide (3, 10) = (0, 10) because 3 does not divide 10 *)

fun fullDivide (k: int, n: int) =
    let
        fun helper (count: int, result: int) =
            if result mod k <> 0
            then (count, result)
            else helper (count + 1, result div k)
    in
        helper (0, n)
    end ;

(* Problem 23: Using fullDivide, write a function
factorize: int -> (int * int) list
that given a number n returns a list of pairs (d, k) where
- d is a prime number dividing n
- k is the number of times it fits
The pairs should be in increasing order of prime factor, and the process
should stop when the divisor considered surpasses the square root of n. If you make sure
to use the reduced number n2 given by fullDivide for each next step, you should
not need to test if the dvisiors are prime:
If a number divides into n, it must be prime. If it had prime factors, they would
have been earlier prime factors of n and thus reduced earlier. Examples:
- factorize 20 = [(2, 2), (5, 1)]
- factorize 36 = [(2, 2), (3, 2)]
- factorize 1 = []
*)

