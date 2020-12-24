(* Here the function even and odd are within a closure, thus even
if we shadow any of the functions later on, it will not affect any of
these functions. *)

fun even x =
    (print "in even ";
     if x = 0 then true else odd (x-1))
and
odd x =
(print "in odd ";
 if x = 0 then false else even (x-1)) ;

val a1 = odd 7;
val _ = print "\n" ;

(* Here even though we shadowed even, a2's odd will still call the even function
that's defined in the very beginning instead of the (x mod 2). *)
fun even x = (x mod 2) = 0 ;
val a2 = odd 7
val _ = print "\n" ;

(* The same thing applies here. odd still calls the even function defined
at the beginning. *)
fun even x = false;
val a3 = odd 7;
val _ = print "\n";
		 
