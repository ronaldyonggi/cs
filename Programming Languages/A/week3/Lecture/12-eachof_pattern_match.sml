(* Pattern matching also works for records and tuples! Here are some examples that
are bad because they only have one branch cases. *)

fun sum_triple triple =
    case triple of
        (x, y ,z) => x + y + z ;

fun full_name r =
    case r of
        {first = x, middle = y, last = z } =>
        x ^ " " ^ y ^ " " ^ z ;

val testsum1 = sum_triple(3, 4, 5) = 12;

(* Here is a better example, but it can be better. *)

fun sum_triple2 triple =
    let
        val (x, y, z) = triple
    in
        x + y + z
    end ;

fun full_name r =
    let
        val {first = x, middle = y, last = z} = r
    in
        x ^ " " ^ y ^ " " ^ z
    end ;

val testsum2 = sum_triple2(3, 4, 5) = 12;

(* It turns out that val not only can bind variables, it can also bind a pattern!
However, an even better example is the following:

A function argument can be not only variables, but a pattern as well!! *)

fun sum_triple3 (x, y, z) =
    x + y + z ;

fun full_name {first = x, middle = y, last = z} =
    x ^ " " ^ y ^ " " ^ z ;

val testsum3 = sum_triple3 (3, 4, 5) = 12;

(* How do we know if the function sum_triple3 takes a tuple or 3 different ints? Answer:
it turns out that all this time, regardless of the number of arguments,
functions only take one argument: a tuple! *)

fun rotate_left (x, y, z) = (y, z, x) ;
val rotatesum = sum_triple3(rotate_left(3, 4, 5)) = 12;

