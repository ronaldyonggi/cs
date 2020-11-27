(* Problem 1: Write a function
compose_opt : ('b -> 'c option) -> ('a -> 'b option) -> 'a -> 'c option
that composes two functions with "optional" values. If either function returns
NONE then the result is NONE. *)



(* Problem 2: Write a function do_until:
('a -> 'a) -> ('a -> bool) -> 'a -> 'a

do_until f p x will apply f to x and f again to that result and so on
until p x is false. Example:
do_until (fn x => x div 2) (fn x => x mod 2 <> 1) will evaluate to a function
of type int -> int that divides its argument by 2 until it reaches
and odd number. In effect, it will remove all factors of 2 its argument. *)

fun do_until f p x =
    if not (p x)
    then x
    else do_until f p (f x) ;


(* Problem 3: Use do_until to implement factorial. *)
fun factorial x =
    #1 (do_until
                    (fn (acc, x) => (acc * x, x - 1))
                    (fn (_, x) => x > 1)
                    (1, x)) ;

(* Problem 4: Use do_until to write a function fixed_point:
(''a -> ''a) -> ''a -> ''a
that given a function f and an initial value x applies f to x until f x = x
(Notice the use of '' to indicate equality types) *)

fun fixed_point f x =
    do_until f (fn i => (f i) <> i) x; 

(* Problem 5: Write a function map2:
('a -> 'b) -> 'a * 'a -> 'b * 'b
that given a function that takes 'a values to 'b values and a pair of 'a values returns
the corresponding pair of 'b values *)

fun map2 f (pr: 'a * 'a) = 
    (f (#1 pr), f (#2 pr)) ;

(* Problem 6 : Write a function app_all:
('b -> 'c list) -> ('a -> 'b list) -> 'a -> 'c list

so that app_all f g x will apply f to every element of the list g x
and condcatenate the results into a single list. For example, if we have:
fun f n = [n, 2 * n, 3 * n],
then we have
app_all f f 1 = [1, 2, 3, 2, 4, 6, 3, 6, 9] *)

fun app_all f g x =
    let
        fun append (l1, l2) =
            case l1 of
                [] => l2 
              | x :: rest =>  x :: append (rest, l2) ;

        fun helper (f,list) =
            case list of
                [] => [] 
             | x :: rest => append ((f x), helper (f, rest))
    in
        helper (f,(g x))
    end ;

(* Problem 7: Implement List.foldr *)
fun foldr f init list =
    case list of
        [] => init 
     | x :: rest => f x (foldr f init rest)


