(* Fold accumulates an answer by repeatedly applying f
to answer so far. *)

fun fold (f, acc, list) =
    case list of
        [] => acc 
      | x :: rest => fold (f, f(acc, x), rest) ;
 (* Above is a fold-left version. Here order doesn't matter *)

(* Examples not using private data *)
fun f1 list = fold (fn (x, y) => x + y, 0, list) ;
fun f2 list = fold (fn (x, y) => x andalso y >= 0, true, list) ;
(* In both f1 and f2, x is the acc while y is the next element in the list *)

(* Examples of using private data *)
(* Returns how many elements in a list that's between lo and hi, inclusive .*)
fun f3 (list, lo, hi) = 
    fold ((fn (x, y) =>
               x + (if y >= lo andalso y <= hi
                              then 1
                               else 0)),
          0, list) ;

fun f4 (list, s) =
    let val i = String.size s
    in
        fold ((fn (x, y) => x andalso String.size y < i), true, list )
    end;

fun f5 (g, list) = fold ((fn (x, y) => x andalso g y), true, list) ;

(* And here is an example of function f4 that simply uses f5 *)
fun f4again (list, s) = 
    let val i = String.size s
    in
        f5 (fn y => String.size y < i, list )
    end; 


                        

