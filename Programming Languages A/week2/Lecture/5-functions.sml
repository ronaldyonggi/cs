
(* x to the power of y. Works only if y >= 0 *)
fun pow(x: int, y: int) =
    if y = 0
    then 1
    else x * pow(x, y - 1)

fun cube(x: int) =
    pow(x, 3)


(* Evaluates to 43 *)
val fortythree = cube(3) + pow(2, 4) 
