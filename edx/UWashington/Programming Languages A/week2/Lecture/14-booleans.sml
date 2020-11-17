(* andalso works like and *)
val andalsoFalse = true andalso false = false
val andalsoTrue = true andalso true = true

(* orelse works like or *)
val orTrue = false orelse true = true

(* not works just like...not *)
val notTrue = not true = false

(* Note the following are equivalent! Thisis why andalso, orelse, and 'not' exists! *)

(* e1 andalso e2 *)
if e1
then e2
else false

(* e1 orelse e2 *)
if e1
then true
else e2
                                               
(* not e1 *)
if e1
then false
else true

(* Just e! *)
if e
then true
else false
                                                                 

(* You can't compare int with real (float). You will get an error! *)
val compare1 = 3 > 2 = true
val compare2 = 5.0 < 3.0 = false
(* Can't compare 3 with 5.0 *)

(* We also can't use = to check equality for reals because of accuracy issue (decimal points!) *)

                              
