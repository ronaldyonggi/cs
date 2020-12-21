(* Examples of false positives that isn't necessarily will
happen, but ML won't compile*)

(* f1 is defined but never called. ML rejects it anyway
during compile time so you won't be able to compile the file.
This is an example of false positive *)
fun f1 x =
    4 div "hi"

(* f2 is even more false positive. The else clause will
never be executed, but ML still rejects the code. *)
fun f2 x =
    if true then 0 else 4 div "hi"

fun f3 x =
    if x then 0 else 4 div "hi"
val x = f3 true

fun f4 x =
    if x <= abs x
    then 0
    else 4 div "hi"

fun f5 x = 4 div x
val y = f5 (if true then 1 else "hi")