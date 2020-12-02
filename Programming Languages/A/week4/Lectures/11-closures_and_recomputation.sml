fun filter (f, list) =
    case list of
        [] => [] 
      | x :: rest => if f x
                     then x :: filter (f, rest)
                     else filter (f, rest) ;

fun all_shorter_than (list, s) =
    filter (fn x => String.size x < String.size s, list) ;

(* The function above works, but there's an efficiency problem:
The String.size s is recomputed every time filter is called. This can
be solved by assigning a variable to the result of String.size i and
reuse that variable. The performance difference is noticeable if s
 is a very long string.*)

fun all_shorter_than_efficient (list,s) =
    let val i = String.size s
    in
        filter (fn x => String.size x < i, list)
    end;

(* One way of seeing if a computation is being run is by printing
something on that piece of code. Here let's have a piece of
code prints "!" when executed. *)

fun shorter_1 (list, s) = 
    filter (fn x => String.size x < (print "!"; String.size s), list);

fun shorter_2 (list, s) =
    let val i = (print "!"; String.size s)
    in
        filter (fn x => String.size x < i, list)
    end ;

val ls = ["1", "333", "22", "4444"];
val s = "xxx" ;
val _ = print "\nshorter_1: " ;
shorter_1 (ls, s) ;

val _ = print "\nshorter_2: " ;
shorter_2 (ls, s);

(* For every '!' printed, a computation is done. shorter_1
prints multiple '!' while shorter_2 only prints it once! *)
        

