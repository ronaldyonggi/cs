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
    end

(* Problem 10: Write a function...
zip: int list * int list -> int * int list
that given two lists of integers, creates consecutive pairs, and stops when one of the
lists is empty. For example:
zip ([1, 2, 3], [4, 6]) = [(1, 4), (2, 6)] *)
    
