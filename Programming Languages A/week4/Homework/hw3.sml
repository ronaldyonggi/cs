(* Coursera Programming Languages, Homework 3, Provided Code *)

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
    end ;

(**** for the challenge problem only ****)

datatype typ = Anything
	           | UnitT
	           | IntT
	           | TupleT of typ list
	           | Datatype of string ;

(* Problem 1
List.filter takes only 1 argument: a function.
 *)

val only_capitals = List.filter (
        fn l => Char.isUpper (String.sub (l, 0))) ;

(* Problem 2 *)
val longest_string1 =
    foldl
        (fn (s1, s2) => if String.size s1 >= String.size s2
                      then s1
                      else s2)
        "" ;

(* Problem 3 *)
val longest_string2 =
    foldl
        (fn (s1, s2) => if String.size s1 > String.size s2
                      then s1
                      else s2)
        "" ;

(* Problem 4 *)
fun longest_string_helper f =
    (fn l => 
       foldl
           (fn (s1, s2) => if f (String.size s1, String.size s2)
                           then s1
                           else s2)
           "" 
           l)

val longest_string3 =
    longest_string_helper (fn (s1, s2)=> s1 >= s2)

val longest_string4 = 
    longest_string_helper (fn (s1, s2) => s1 > s2)

(* Problem 5 *)
val longest_capitalized =
    longest_string1 o only_capitals ;

(* Problem 6 *)
val rev_string =
    String.implode o List.rev o String.explode;

(* Problem 7 *)
fun first_answer f l =
    case l of
        [] => raise NoAnswer 
      | x :: rest => case f x of
                         NONE => first_answer f rest 
                       | SOME i => i ;

(* Problem 8 *)
fun all_answers f l = 
    let
        fun helper (l, sofar) =
            case l of 
                [] => SOME sofar
              | x :: rest => case f x of
                                 NONE => NONE
                              | SOME i => helper (rest, sofar @ [i])
    in
        helper (l, [])
    end ;

(* Problem 9 *)
(* 9a *)
val count_wildcards =
    g (fn _ => 1) (fn _ => 0) ;

(* 9b *)
val count_wild_and_variable_lengths =
    g (fn _ => 1) String.size ;

(* 9c *)
fun count_some_var (str, p) =
    g (fn _ => 0) (fn s => if str = s then 1 else 0) p ;

(* Problem 10 *)
val check_pat =
    let
        fun all_strings p = 
            case p of
                Variable s => [s]
              | TupleP ps => List.foldl (fn (pattern, str) => str @ (all_strings pattern)) [] ps
              | ConstructorP (_, pattern) => all_strings pattern 
              | _ => [] ;

        fun repeats lst =
            case lst of
                [] => false 
              | x::rest => (List.exists (fn i => i = x) rest ) orelse (repeats rest) ;
    in
        not o repeats o all_strings
    end ;

(* Problem 11 *)

