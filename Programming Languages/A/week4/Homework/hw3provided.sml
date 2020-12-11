exception NoAnswer

datatype pattern = Wildcard
		 | Variable of string
		 | UnitP
		 | ConstP of int
		 | TupleP of pattern list
		 | ConstructorP of string * pattern

datatype valu = Const of int
	      | Unit
	      | Tuple of valu list
	      | Constructor of string * valu

fun g f1 f2 p =
    let 
	val r = g f1 f2 
    in
	case p of
	    Wildcard          => f1 ()
	  | Variable x        => f2 x
	  | TupleP ps         => List.foldl (fn (p,i) => (r p) + i) 0 ps
	  | ConstructorP(_,p) => r p
	  | _                 => 0
    end

(**** for the challenge problem only ****)

datatype typ = Anything
	     | UnitT
	     | IntT
	     | TupleT of typ list
	     | Datatype of string;

(**** you can put all your code here ****)

(* Problem 1 *)
(* List.filter takes 2 curried arguments in the following order:
1. A function to filter the elements of a list
2. The list itself
Here we only provide the function and save it to 
variable 'only_capitals' so 'only_capitals' only
need to take a list *)

val only_capitals =
    List.filter (fn l => Char.isUpper (String.sub (l, 0)));

(* Problem 2 *)
(* foldl takes 3 curried arguments in the following order:
1. A function that processes 2 arguments, starting with the 
   first element of the provided list and the initial provided element 
2. An initial provided element
3. A list
It's called foldl because it starts processing from the left.
(the first elements in the list)

Here we only provide the first 2 arguments so that longest_string1
only needs to take a list. *) 

(* CAUTION! expression foldl f b [x1,x2,...,xn] evaluates 
to f(xn, f(..., f(x2, f(x1,b)))) *)

val longest_string1 =
    foldl
	(fn (x2, x1) => if String.size x2 > String.size x1
		        then x2
			else x1)
	  "";

(* Problem 3 *)
val longest_string2 =
    foldl
	(* If greater or equal, takes the latter element *)
	(fn (x2, x1) => if String.size x2 >= String.size x1
		        then x2
			else x1)
	  "";

(* Problem 4 *)
fun longest_string_helper f l =
       foldl
           (fn (x2, x1) => if f (String.size x2, String.size x1)
                           then x2
                           else x1)
           "" 
           l;
(* EQUIVALENT ALTERNATIVE
val longest_string_helper =
    fn f => fn l => 
       foldl
           (fn (x2, x1) => if f (String.size x2, String.size x1)
                           then x2
                           else x1)
           "" 
           l;
*)

val longest_string3 =
    longest_string_helper
	(fn (x2, x1) => x2 > x1);

val longest_string4 =
    longest_string_helper
	(fn (x2, x1) => x2 >= x1);

(* Problem 5 *)
val longest_capitalized =
    longest_string1 o only_capitals;

(* Problem 6 *)
val rev_string =
    String.implode o List.rev o String.explode;

(* Problem 7 *)
(* Can do var first_answer = fn f => fn l => ...
instead of using fun. *)
fun first_answer f l =
    case l of
	[] => raise NoAnswer 
      | x :: rest => case f x of
			 NONE => first_answer f rest 
		       | SOME i => i;

(* Problem 8 *)
fun all_answers f l =
    let
	fun helper (l, sofar) =
	    case l of (* if empty, then returns SOME of the list accumulated so far *)
		[] => SOME sofar 
	      | x :: rest => case (f x) of
				 (* if applying f to x results NONE, then return NONE. 
				   otherwise append i to the accumulated list so far. *)
				 NONE => NONE 
			      | SOME i  => helper (rest, sofar @ i)
    in
	helper (l, [])
    end;

(* Problem 9 *)
(* Observe function g carefully. We only need to make sure
we provide correct f1 and f2. *)

(* 9a *)
(* Here we only care that if p is Wildcard,
f1 returns 1. *)
val count_wildcards =
    g (fn _ => 1) (fn _ => 0);

(* 9b *)
(* In addition to f1 returning 1, we want f2 to
process the string length of x in case Variable x *)
val count_wild_and_variable_lengths =
    g (fn _ => 1) (fn x => String.size x);
    
(* 9c *)
(* This function takes a pair where the 1st element is the desired
string and the 2nd element is the pattern. Don't mistaken that this function
takes a pattern in form of a pair! *)
fun count_some_var (s, p) =
    g (fn _ => 0) (fn x => if x = s then 1 else 0) p;
    
(* 10 *)
val check_pat =
    let
	(* Helper function 1: returns a list of all strings used for variables. *)
	fun strings_used p =
	    case p of
		Variable s => [s]
	(* Beware that foldl f init [x1, x2, ..., xn] returns f(xn,...,f(x2, f(x1, init))...)
	 This means the 2nd argument of the fn provided for foldl needs to be the
	 accumulator, in this case the list so far.*)
	     | TupleP pl => List.foldl (fn (pat, listsofar) => (strings_used pat) @ listsofar) [] pl
	     | ConstructorP (_, pat) => strings_used pat 
	     | _ => [];

	(* Helper function 2: returns true if there's any duplicate in the input list*)
	fun repeats lst =
	    case lst of
		[] => false 
	      | x :: rest => (List.exists (fn i => i = x) rest) orelse (repeats rest);
    in
	not o repeats o strings_used
    end;
    
(* Problem 11 *)
(* This is basically a code implementation of the rules of matching 
in problem pdf. *)

fun match (v, p) =
    case (v, p) of
	(_, Wildcard) => SOME []
     | (_, Variable s) => SOME [(s, v)] 
     | (Unit, UnitP) => SOME []
     | (Const x, ConstP y) => if x = y then SOME [] else NONE 
     | (Tuple vlist, TupleP plist) => if length vlist = length plist
				      then all_answers match (ListPair.zip (vlist, plist))
				      else NONE
     | (Constructor (s2, v_), ConstructorP (s1, p_)) => if s1 = s2 then match(v_,p_) else NONE 
     | _ => NONE;


(* Problem 12 *)
fun first_match v pl =
    SOME (first_answer (fn p => match (v, p)) pl)
    handle NoAnswer => NONE;
	
