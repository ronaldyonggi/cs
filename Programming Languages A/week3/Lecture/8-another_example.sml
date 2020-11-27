(* Recall the exp datatype from previous lecture *)

datatype exp = Constant of int 
       | Negate of exp 
       | Add of exp * exp 
       | Multiply of exp * exp ;

(* We want to define a function max_constant that returns greater of two constants *)

val test_exp = Add (Constant 19, Negate (Constant 4)) ;
(* val nineteen = max_constant test_exp *)

fun max_constant e = (* Notice here we don't need to specify the type of the argument! *)
    case e of
        Constant i => i 
     | Negate e => max_constant e 
     | Add (e1, e2) => if (max_constant e1) > (max_constant e2)
                       then max_constant e1
                       else max_constant e2 
     | Multiply (e1, e2) => if max_constant e1 > max_constant e2
                            then max_constant e1
                            else max_constant e2 ;

val nineteen = max_constant test_exp = 19 ;

(* The max_constant above works BUT involves recursive recomputation (recall let efficiency from previous week. Let's fix this problem! *)

fun max2 e =
    case e of
        Constant i => i 
      | Negate e => max_constant e 
      | Add (e1, e2) =>
        let val m1 = max_constant e1 ;
            val m2 = max_constant e2 ;
        in if m1 > m2 then m1 else m2 end
         | Multiply (e1, e2) =>
           let val m1 = max_constant e1 ;
               val m2 = max_constant e2 ;
           in if m1 > m2 then m1 else m2 end ;

val nineteen_2 = max2 test_exp = 19;

(* This works, but there are lines of duplicated codes, which makes the code ugly!
 One solution is to define the 'let' part in a helper function that's defined early
 within the max funcion. *)
fun max3 e =
    let
        fun helper (e1, e2) =
            let val m1 = max_constant e1 ;
                val m2 = max_constant e2 ;
            in
                if m1 > m2 then m1 else m2 end
    in
        case e of
            Constant i => i 
          | Negate e => max_constant e 
          | Add (e1, e2) => helper(e1, e2)
          | Multiply (e1, e2) => helper (e1, e2) 
    end ;

val nineteen_3 = max3 test_exp = 19 ;

(* The line "if m1 > m2 then m1 else m2" in the helper function can actually be
replaced using ML standard library Int.max(m1, m2) *)

fun helper2 (e1, e2) =
    let val m1 = max_constant e1 ;
        val m2 = max_constant e2 ;
    in
        Int.max (m1, m2) 
    end ;

(* Using ML's standard library, we don't even need to create m1 and m2 since
they don't involve recursive recomputation! *)
fun helper3 (e1, e2) =
    Int.max(max_constant e1, max_constant e2) ;

(* Now realize that we don't actually need a helper function! We can simply use the
ML standard library for the case expression! *)
fun max4 e =
    case e of
        Constant i => i
     | Negate e => max_constant e 
     | Add (e1, e2) => Int.max (max_constant e1, max_constant e2) 
     | Multiply (e1, e2) => Int.max (max_constant e1, max_constant e2) ;

val nineteen_4 = max4 test_exp = 19;
        

        
        

