(* Recall the list append function *)

fun append (l1, l2) =
    case l1 of
        [] => l2 
      | a:: list => a :: append (list, l2) ;

val ok1 = append(["hi", "bye"], ["programming", "languages"]) =
          ["hi","bye","programming","languages"];
val ok2 = append([1, 2], [4, 5]) = [1,2,4,5];

(* Notice that if we execute the program, the append function type is:
'a list * 'a list -> 'a list. This is why the program can take any
type, whether string or int. NOT the combination of both:

val not_ok = append([1, 2], ["programming","languages"])

if you execute not_ok, it will throw an error!


The type...

'a list * 'a list -> 'a list

...is more general than the type...

string list * string list -> string list

...thus, it can be used as any less general type such as...

int list * int list -> int list

...but it's not more general than...

int list * string list -> int list 

GENERAL RULE OF THUMB:
A type t is more general than the type z if you can take t,
replace all the t variables consistently, and get z.
For example: replace each 'a with int * int
or replace each 'a with bool and each 'b' with int.

There's also a type with two quotes, ''a. For example:

''a list * ''a -> bool

These are equality types which indicates that the = operator is involved.
Here's an example of equality type.
 *)

(* ''a * ''a -> string *)
fun same_thing(x, y) =
    if x=y then "yes" else "no" ;

(* Notice that in then function above, the argument x and y can be more than
one type. they can be string, or int. Thus the ''a.)

However, if the comparison within the body of the function is more specific,
then the type indicated will be different. For example: *)

(* int -> string *)
fun is_three x =
    if x=3 then "yes" else "no";

(* In the function above, ML expects that the argument x is an int! *)
                  
