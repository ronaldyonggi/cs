fun length l =
    case l of
        [] => 0 
      | x :: rest => 1 + length rest;

(*
length: tl -> T
l: tl
x: tx
rest: tx list

tl: tx list
T = int (since 0 might be returned)

Conclusion: tx list -> int
There's no constraint of what tx can be. For results like this, we replace tx so
it becomes:
'a list -> int
*)


fun f (x, y, z) =
    if true
    then (x, y, z)
    else (y, x, z) ;

(*
f: tx * ty * tz -> T
x: tx
y: ty
z: tz

T = tx * ty * tz or ty * tx * tz
this means tx must be = ty
thus f: tx * tx * tz -> tx * tx * tz
Or we can replace it so it becomes:
f: 'a * 'a * 'b -> 'a * 'a * 'b
*)

fun compose (f, g) = fn x => f (g x) ;
(*
compose: tf * fg -> T
f: tf
g: tg
x: tx

Body being a function, has a type T = tx -> tfinal
From g being passed x, tg = tx -> tgresult
From f being passed the result of g -> tf = tgresult -> tfresult
From call to f being body of anonymous function, tfresult = tfinal

Thus we have compose:
tf * tg -> T
(tgresult -> tfresult) * (tx -> tgresult) -> (tx -> tfinal)
Now let's call
- tgresult = 'a
- tfresult = tfinal = 'b
- tx = 'c
We have:
('a -> 'b) * ('c -> 'a) -> ('c -> 'b)

