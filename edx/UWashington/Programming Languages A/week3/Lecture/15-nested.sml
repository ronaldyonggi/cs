(* The zip function aggregates the elements of a multiple list with the same index.
For example:

zip([1, 2, 3], [4, 5, 6], [7, 8, 9]) = [(1, 4, 7), (2, 5, 8), (3, 6, 9)]
unzip [(1, 4, 7), (2, 5, 8), (3, 6, 9)] = ([1, 2, 3], [4, 5, 6], [7, 8, 9])

*)

(* Below is how you raise an exception! *)
exception ListLengthMismatch;

(* If we didn't know pattern matching, we might implement zip like
the following. Don't do this! *)
fun old_zip (l1, l2, l3) =
    if null l1 andalso null l2 andalso null l3
    then []
    else if null l1 orelse null l2 orelse null l3
    then raise ListLengthMismatch
    else (hd l1, hd l2, hd l3) :: old_zip(tl l1, tl l2, tl l3) ;

(* With pattern matching, we might implement zip as the following.
 Also don't do this!*)
fun shallow_zip (l1, l2, l3) =
    case l1 of
        [] =>
        (case l2 of
             [] => (case l3 of
                        [] => [] 
                     | _ => raise ListLengthMismatch)
           | _ => raise ListLengthMismatch)
     | hd1::tl1 => 
       (case l2 of
            [] => raise ListLengthMismatch
         | hd2::tl2 => (case l3 of
                            [] => raise ListLengthMismatch
                         | hd3 :: tl3 => 
                           (hd1, hd2, hd3)::shallow_zip(tl1, tl2, tl3)));

(* Realize that you can make nested pattern (pattern matching inside
pattern matching). DO this! *)
fun zip list =
    case list of
        ([], [], []) => [] 
     | (hd1::tl1, hd2::tl2, hd3::tl3) => (hd1, hd2, hd3)::zip(tl1,tl2,tl3)
     | _ => raise ListLengthMismatch ;
(* _ means all other cases. This means in other cases, raise ListLengthMismatch *)

fun unzip list =
    case list of
        [] => ([], [], [])
     | (a, b, c)::rest =>  let val (l1, l2, l3) = unzip rest
                         in
                             (a::l1, b::l2, c::l3)
                         end ;


zip([1, 2, 3], [4, 5, 6], [7, 8, 9]) = [(1, 4, 7), (2, 5, 8), (3, 6, 9)];
unzip [(1, 4, 7), (2, 5, 8), (3, 6, 9)] = ([1, 2, 3], [4, 5, 6], [7, 8, 9]) ;

              
