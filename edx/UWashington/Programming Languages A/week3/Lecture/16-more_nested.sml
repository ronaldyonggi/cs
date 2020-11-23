(* Here are some examples of nested patterns *)

(* This function takes in a list and returns true if all the elements
are increasing or equal *)
(* int list -> bool *)
fun increasing list =
    case list of
        [] => true
     | _::[] => true
     | head::(neck::rest) => head <= neck
                             andalso increasing(neck::rest) ;

(* The following function takes in a tuple of 2 int and determine
whether their sign will be positive, negative or zero if multiplied. *)

datatype sign = P 
       |  N
       | Z ;

fun multiplysign (x, y) =
    let
        fun sign a =
            if a = 0 then Z else if a > 0 then P else N
    in
        case (sign x, sign y) of
            (Z, _) => Z 
         | (_, Z) => Z 
         | (P, P) => P 
         | (N, N) => P
         | _ => N
    (* We don't need to write the case of (P, N) and (N,P) since
     they are already covered in other cases `_`*)
    end ;

multiplysign (~3, 2) = N;
multiplysign (0, 7) = Z;

(* And here's a function that calculates the length of a list *)
fun len list =
    case list of
        [] => 0 
      | _::rest => 1 + len rest;

len [3, 4, 5] = 3;
