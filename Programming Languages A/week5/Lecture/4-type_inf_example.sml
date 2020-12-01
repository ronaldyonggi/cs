

fun f x =
    let
        val (y, z) = x
    in
        (abs y) + z
    end ;

(*
f: tx -> T
x: tx
y: ty
z: tz

tx = ty * tz
ty = int (abs has type int -> int)
tz = int (because z is added to y, which is an int)

so,
tx is int * int
(abs y) + z : int
let-expression :int
body: int
T: int
f: int * int -> int *)


fun sum l =
    case l of
        [] => 0 
      | x :: rest => x + (sum rest) ;

(*
sum: tl -> T
l: tl
x: tx
rest: tx list (pattern match a tx)

tl = tx list
T = int (because 0 might be returned)
tx = int (because x::tx list and we add x to something)

thus tl = int list, T = int
so sum: int list -> int *)
                             
