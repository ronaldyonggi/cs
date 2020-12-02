(* Callbacks: functions to apply later when an event occurs. *)

(* Library implementation *)

(* cbs stands for callbacks *)
val cbs = (int -> unit) list ref = ref []

fun onKeyEvent f = cbs := f :: (!cbs)

fun onEvent i = 
    let fun loop fs = 
        case fs of
            [] => ()
            | f :: fs' => ( f i ; loop fs')
    in 
        loop (!cbs)
    end 

(* Clients  *)

val timesPressed = ref 0
(* Register a callbacks. Everytime it's called, it increments
timesPressed. This is a logger that counts how many times key has
been pressed. *)
val _ = onKeyEvent (fn _ =>
            timesPressed := (!timesPressed) + 1)

fun printIfPressed i = 
    onKeyEvent (fn j =>
        if i = j
        then print ("you pressed " ^ Int.toString i)
        else ())
(* j is the key that is pressed.  *)

(* Here we register 4 callbacks. *)
val _ = printIfPressed 4
val _ = printIfPressed 11
val _ = printIfPressed 23
val _ = printIfPressed 4