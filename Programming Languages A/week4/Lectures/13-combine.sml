(* Function composition *)

fun compose (f, g) = fn x => f (g x);

(* Examples: *)
fun sqrt_of_abs i = Math.sqrt(Real.fromInt(abs i)) ;


(* ML standard library provides an operator o that we can use conveniently. *)
fun sqrt_of_abs2 i = (Math.sqrt o Real.fromInt o abs) i ;
(* Turns out above is an unnecessary function wrapping! We have a simpler way. *)
val sqrt_of_abs3 = Math.sqrt o Real.fromInt o abs ;

(* We can even incorporate backup pipeline for functions! *)

fun backup1 (f, g) = fn x => case f x of
                                 NONE => g x 
                               | SOME i =>  i ;

fun backup2 (f, g) =
    (* If applying f x raises any exception, execute g x *)
    fn x => f x handle _ => g x


