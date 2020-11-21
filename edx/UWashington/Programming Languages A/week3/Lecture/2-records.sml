(* Records is an each-of type, similar to tuple.
For example, a tuple can have an int and a bool *)

(* Here is an example of a record *)
val x = {bar = (1+2, true andalso true),
         foo = 3 + 4,
         baz = (false, 9)} (* The order of bar, foo, etc doesn't matter *)

val john = {name="John",
            age= 25}

(* If we want to retrieve a data from a record, use #. *)
val john_age = #age john = 25
