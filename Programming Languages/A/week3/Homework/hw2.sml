(* Dan Grossman, Coursera PL, HW2 Provided Code *)

(* if you use this function to compare two strings (returns true if the same
   string), then you avoid several of the functions in problem 1 having
   polymorphic types that may be confusing *)
fun same_string(s1 : string, s2 : string) =
    s1 = s2 ;

(* put your solutions for problem 1 here *)

(* a *)
fun all_except_option (s: string, l: string list) =
    (* Remove s from l. If the resulting string is the same as initial l, then return NONE
    otherwise return that result *)
    let
        fun remove (l: string list) =
            case l of
                [] => [] 
              | x :: rest => if same_string (x, s)
                             then remove rest
                             else x :: remove rest ;
        val removed = remove l
    in
        if removed = l 
        then NONE
        else SOME removed
    end ;

(* b *)
fun append (l1: string list, l2 : string list) =
    case l1 of
        [] => l2 
      | x:: rest => x :: append(rest, l2) 

fun get_substitutions1 (l: string list list, s: string) =
    case l of
        [] => [] 
      | slist :: rest => case all_except_option (s, slist) of
                             NONE => get_substitutions1 (rest, s) 
                           | SOME result  => append (result, get_substitutions1 (rest, s))

(* c *)
fun get_substitutions2 (l: string list list, s: string) = 
    let
        fun helper (l: string list list, sofar: string list) =
            case l of
                [] => sofar 
              | slist :: rest  => case all_except_option (s, slist) of
                                      NONE => helper (rest, sofar)
                                           | SOME result => helper (rest, append (sofar, result))
    in
        helper (l, [])
    end ;

(*d*)
type full_name = {first:string, middle: string, last: string}
fun similar_names (lst: string list list, fname: full_name) =
    let
        val {first = f, middle = m, last = l} = fname ;
        val names = get_substitutions2 (lst, f) ;
        fun helper (names: string list) =
            case names of
                [] => [] 
                   | x::rest => {first = x, middle = m, last = l} :: helper rest
    in
        fname :: helper(names)
    end

(* you may assume that Num is always used with values 2, 3, ..., 10
   though it will not really come up *)
datatype suit = Clubs | Diamonds | Hearts | Spades
datatype rank = Jack | Queen | King | Ace | Num of int 
type card = suit * rank

datatype color = Red | Black
datatype move = Discard of card | Draw 

exception IllegalMove;

(* put your solutions for problem 2 here *)             

(*a*)
fun card_color (c: card) =
    case c of
        (Spades, _) => Black 
     | (Clubs, _) => Black 
     | _ => Red ;

(*b*)
fun card_value (c: card) =
    case c of
        (_, Ace) => 11 
     | (_, King) =>  10 
     | (_, Queen) => 10 
     | (_, Jack) => 10 
     | (_, Num i) => i ;

(*c*)
fun remove_card (l: card list, c: card, e: exn) =
    let
        fun samecard (c1: card) =
            c1 = c ;

        fun remove (l: card list) =
            case l of
                [] => [] 
             | x :: rest => if samecard x
                            then rest
                            else x :: remove rest ;

        fun count (l: card list) =
            case l of
                [] => 0 
              | x :: rest => 1 + count rest ;

        val removed = remove l
        val lenOriginal = count l ;
        val lenRemoved = count removed 
    in
        if lenOriginal = lenRemoved
        then raise e
        else removed
    end ;

(*d*)
fun all_same_color (l: card list) =
    case l of
        [] => true 
     | x :: rest => case rest of
                        [] => true 
                     | y :: rest2 => if (card_color x) = (card_color y)
                                     then all_same_color rest
                                     else false ;

(*e*)
fun sum_cards (l: card list) =
    let
        fun helper (l: card list, sofar: int) =
            case l of
                [] => sofar 
             | x:: rest => helper (rest, sofar + (card_value x))
    in
        helper (l, 0)
    end;

(*f*)
fun score (l: card list, goal: int) =
    let
        val cardsum = sum_cards l ; 
        val same_color = all_same_color l ;
    in
        case (cardsum > goal, same_color) of
            (true, true) => (3 * (cardsum - goal)) div 2
         | (false, true) => (goal - cardsum) div 2 
         | (true, false) => (3* (cardsum - goal))
         | (false, false) => goal - cardsum
    end; 

(*g*)
fun officiate (card_list, move_list, goal) =
    let
        fun helper (card_list, move_list, held) = 
            case move_list of
                [] => score (held, goal) 
                            (* Cases for discarding a card *)
             | (Discard c) :: rest => 
               (case held of
                   [] => raise IllegalMove
                 | _ => helper (card_list, rest, remove_card (held, c, IllegalMove) ) )
                   (* Cases for drawing a card from card_list *)
             | Draw :: rest => case card_list of
                                   [] => score (held, goal) 
                                 | c :: rest_cardlist =>
                                   if (sum_cards held) > goal
                                   then score (held, goal)
                                   else helper (remove_card (card_list, c, IllegalMove ), rest, c::held)
    in
        helper (card_list, move_list, [])
    end

