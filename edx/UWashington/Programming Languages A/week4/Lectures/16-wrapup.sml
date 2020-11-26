(* The following range function is DIFFERENT from previous lecture. The previous lecture
version is curried (notice the argument is not a tuple). Here, the arguments
are tupled *)
fun range (i, j) =
    if i > j
    then []
    else i :: range(i+1, j) ;

(* In the previous lecture, we were able to define countup by simply:
val countup = range 1
However here we can't do that because the function range takes a tupled argument. This is
when currying a function becomes useful. *)

fun curry f x y = f (x, y) ; (* Curries a 2-tupled function *)
fun uncurry f (x, y) = f x y (* Uncurry a function
                         that takes 2 arguments *) ;

val countup = curry range 1;
countup 5 = [1,2,3,4,5];

(* Below is is an example of uncurrying a curried function *)

fun curried_range i j =
    if i > j
    then []
    else i :: curried_range (i+1) j ;

val uncurried_countup = uncurry curried_range;
uncurried_countup (1, 5) = [1, 2, 3, 4, 5]

