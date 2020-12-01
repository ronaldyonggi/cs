(* Example of Mutual Recursion *)

(* Returns true if l is a list of ints alternating between 1 and 2
and ends with 2 *)

fun match l =
    let 
        fun s_need_one l =
            case l of
                [] => true
             | 1 :: rest => s_need_two rest
             | _ => false
        and s_need_two l = 
            case l of
                [] => false 
             | 2 :: rest => s_need_one rest 
             | _ => false
    in
        s_need_one l
    end ;

match [1, 2, 1, 2] = true ;
match [1, 2, 1] = false;
match [1, 2, 1, 3] = false;


datatype t1 = Foo of int 
           |  Bar of t2 
     and t2 = Baz of string 
            | Quux of t1 ;

(* A function that returns true if the input is neither
a 0 nor an empty string. *)

fun ft1 x =
    case x of
        Foo i => i <> 0
     | Bar y => ft1 y
and ft2 x = 
    case x of
        Baz s = size s > 0
     | Quux y => ft1 y
