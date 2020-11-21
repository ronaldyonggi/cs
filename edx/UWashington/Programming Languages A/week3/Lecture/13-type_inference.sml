(* Type-checker can use patterns to figure out types. For example, if we execute these
functions from previous lecture, ML can figure out that sum_triple is int*int*int -> int
and full_name is {first:string, last: string, middle:string} because of what's inside
the function (only int can be operated with +, only string can be operated with ^) *)

fun sum_triple (x, y, z) =
    x + y + z ;

fun full_name {first = x, middle = y, last = z} =
    x ^ " " ^ y ^ " " ^ z ;
                

(* If we instead used the #, *)
fun sum_triple2 (triple: int*int*int) =
    #1 triple + #2 triple + #3 triple ;

fun full_name2 (r: {first: string, middle: string, last: string}) =
    #first r ^ " " ^ #middle r ^ " " ^ #last r ;

(* it works, but notice that we need to specify the type of the arguments (e.g. int*int*int). If
we didn't specift them, we will get an error when we execute the code! *)

(* Note that we can even do the following UNEXPECTED POLYMORPHISM *)
fun partial_sum (x, y, z) =
    x + z ;

fun partial_name {first=x, middle=y, last = z} =
    x ^ " " ^ z ;

(* When we execute the functions above, we can see that ML read the type of y to be 'a.
The type-checker is smart enough to recognize that the middle argument isn't used, so
you can use whatever type of argument for the middle argument. *)

val eight = partial_sum(3, "lol", 5) = 8
            

