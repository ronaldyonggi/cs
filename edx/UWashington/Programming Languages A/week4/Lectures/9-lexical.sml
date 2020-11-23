(* First example *)

(* This x is irrelevant *)
val x = 1;

fun f y =
    let
        val x = y + 1
    in
        fn z => x + y + z (* Returns a function! *)
    end ;

(* This x is irrelevant *)
val x = 3;
val g = f 4 ;
(* Here, we call f 4. Now g is bounded to
fn z => 5 + 4 + z *)

(* This y is irrelevant *)
val y = 5;
val z = g 6 = 15;
(* Recall g is fn z => 5 + 4 + z
 Now z is 5 + 4 + 6 = 15 *)
        

(* Second Example *)

fun f g =
    let val x = 3
    in
        g 2
    end ;

val x = 4 ; 

fun h y = x + y ;
(* h is now a function with argument y that adds y with 4 *)
val z = f h = 6;
(* within f's scope, we're applying function h to 2 since h becomes the argument (g)
of the function f. Thus we'll have 2 + 4 = 6. *)





        
