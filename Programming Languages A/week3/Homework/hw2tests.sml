use "hw2.sml" ;

(* PROBLEM 1 TESTS *)

(*a*)
val at1 = all_except_option ("b", ["a", "b", "c"]) =SOME ["a", "c"];
val at2 = all_except_option ("d", ["a", "b", "c"]) = NONE;

(*b*)
val bt1 = get_substitutions1([["Fred", "Fredrick"], ["Elizabeth","Betty"], ["Freddie", "Fred", "F"]], "Fred") = ["Fredrick", "Freddie", "F"];
val bt2 = get_substitutions1([["Fred", "Fredrick"], ["Jeff", "Jeffrey"], ["Geoff", "Jeff", "Jeffrey"]], "Jeff") = ["Jeffrey", "Geoff", "Jeffrey"];

(*c*)
val ct1 = get_substitutions2([["Fred", "Fredrick"], ["Elizabeth","Betty"], ["Freddie", "Fred", "F"]], "Fred") = ["Fredrick", "Freddie", "F"];
val ct2 = get_substitutions2([["Fred", "Fredrick"], ["Jeff", "Jeffrey"], ["Geoff", "Jeff", "Jeffrey"]], "Jeff") = ["Jeffrey", "Geoff", "Jeffrey"];

(*d*)
val dt1 =similar_names([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]],
                       {first="Fred", middle="W", last="Smith"}) =[{first="Fred", last="Smith", middle="W"},
                                                                   {first="Fredrick", last="Smith", middle="W"},
                                                                   {first="Freddie", last="Smith", middle="W"},
                                                                   {first="F", last="Smith", middle="W"}] ;

(* PROBLEM 2 TESTS *)
(*a*)
val a2t1 = card_color (Spades, Queen) = Black;
val a2t2 = card_color (Clubs, King) = Black;
val a2t1 = card_color (Diamonds, Ace) = Red;

(*b*)
val b2t1 = card_value (Diamonds, Ace) = 11;
val b2t2 = card_value (Spades, King) = 10;
val b2t1 = card_value (Clubs, Num 3) = 3 ;

(*c*)
val c2t1 = remove_card ([(Spades, Queen), (Spades, Queen)], (Spades, Queen), IllegalMove) = [(Spades, Queen)];
val c2t2 = remove_card ([(Spades, Queen), (Clubs, King)], (Clubs, King), IllegalMove) = [(Spades, Queen)];

(*d*)
val d2t1 = all_same_color [(Spades, Queen), (Clubs, Queen)] = true;
val d2t2 = all_same_color [(Spades, King), (Diamonds, Ace)] = false;

(*e*)
val e2t1 = sum_cards [(Spades, Queen), (Diamonds, Ace), (Clubs, Num 5)] = 26;

(*f*)
val f2t1 = score ([(Spades, Queen) ,(Diamonds, Ace)], 15) = 18;
val f2t2 = score ([(Spades, Queen) ,(Clubs, Ace)], 15) = 9;
val f2t3 = score ([(Spades, Queen) ,(Clubs, Ace)], 31) = 5;
val f2t4 = score ([(Diamonds, Queen) ,(Clubs, Ace)], 31) = 10;

