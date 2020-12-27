(* If a function expects an argument of type t1 -> t2, 
can we pass a t3 -> t4 instead? *)

(* distMoved calculates the distance between p and f(p) *)
fun distMoved (f: {x:real, y:real} -> {x:real, y:real},
               p: {x:real, y:real}) = 
    let val p2: {x:real, y:real} = f p
        val dx:real = p2.x - p.x
        val dy:real = p2.y - p.x
    in Math.sqrt (dx * dx + dy * dy) end

fun flip p = {x = ~p.x, y = ~p.y}
val d = distMoved(flip, {x=3.0, y=4.0})
(* The program above works just fine. 

However, what about this? *)
fun flipGreen p = {x = ~p.x, y = ~p.y, color="green"}
val d = distMoved(flipGreen, {x=3.0, y=4.0})

(* flipGreen return type: {x:real, y:real, color:string}
but distMoved expects a return type of {x:real, y:real}

This works just fine.!
A function is allowed to return something with an extra unneeded field *)

(*The next one DOESN'T WORK *)
fun flipIfGreen p = if p.color = "green"
                    then {x = ~p.x, y = ~p.y}
                    else {x = p.x, y = p.y}
val d = distMoved(flipIfGreen, {x=3.0, y=4.0})
(* Argument type required for flipIfGreen is {x:real, y:real, color:string}, but
it's called with {x:real, y:real}. p.color does not exist! *)

(* The opposite works. *)
fun flipY0 p = {x = ~p.x, y = 0.0}
val d = distMoved(flipY0, {x=3.0, y=4.0})
(* Argument type of flipY0 is {x:real}, but it's called with
{x:real, y:real}. A function can assume "less than it needs to" for arguments. *)

(* Can do both *)
fun flipXMakeGreen p = {x= ~p.x, y=0.0, color="green"}
val d = distMoved(flipXMakeGreen, {x=3.0, y=4.0})

(* Here, flipxMakeGreen has type:
{x:real} -> {x:real, y:real, color:string} *)