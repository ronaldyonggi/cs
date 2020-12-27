(* In this whole file, assume we're using an imaginary language that's
like half ML, half Java *)

(* Record Creation 
Evaluate ei, make a record. *)
{f1 = e1, f2 = e2, ..., fn = en}

(* Record Field Access
Evaluate e to record v with an f field, then retrieve
the contents of f*)
e.f

(* Record Field Update
Evaluate e1 to a record v1 and e2 to a value v2.
Change v1's f to v2. Then return v2. *)
e1.f = e2

(* Record Types
What fields a record has, and type for each field. *)
{f1:t1, f2:t2, ..., fn:tn}
(*
If e1 has type t1, ..., en has type tn,
then {f1=e1, ..., fn=en} has type {f1:t1, ..., fn:tn} 

If e has a record type containing f:t
then e.f has type t.

If e1 has record type containing f:t and e2 has type t,
then e1.f = e2 has type t *)

(* Now let's say we have a point, and we want to calculate the distance
of that point from the origin. *)
fun distToOrigin (p: {x:real, y:real}) = 
    Math.sqrt(p.x * p.x + p.y * p.y)

val pythagoras: {x:real, y:real} = {x=3.0, y=4.0}
val five : real = distToOrigin (pythagoras)

(* The program above will type check just fine. However, below will NOT 
type check. *)
val c : {x:real, y: real, color:string} = 
    {x=3.0, y=4.0, color = "green"}

val five:real = distToOrigin(c)

(* How do we make it work?
Idea: if an expression has type {f1:t1, ..., fn: tn},
then it can also have a type with some fields removed.

These are what we need to type check the function calls *)
fun distToOrigin (p: {x:real, y:real}) =  ...
fun makePurple (p:{color:string}) = ...
val c : {x:real, y: real, color:string} = 
    {x=3.0, y=4.0, color = "green"}

val _ = distToOrigin(c)
val _ = makePurple(c)