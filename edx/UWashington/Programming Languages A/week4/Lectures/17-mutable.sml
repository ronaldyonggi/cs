val x = ref 42 ;
val y = ref 42 ;
val z = x; (* z and x now is pointing at the same object *)
val _ = x := 43 (* both the object z and x was pointing at
                 is now changed to 43 *) ;
val w = !y + !z = 85;

(* Note that x is a reference, not an int. If we try
to do x + 1, it will throw an error! )
            
