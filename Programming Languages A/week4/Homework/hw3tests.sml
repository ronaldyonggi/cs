(* Problem 1 tests *)

val p1t1 = only_capitals ["Smurf", "hey", "Lol"] = ["Smurf", "Lol"];

(* Problem 2 tests *)
val p2t1 = longest_string1 ["Smurf", "Lol"] = "Smurf";
val p2t2 = longest_string1 ["Smurf"] = "Smurf";
val p2t3 = longest_string1 [] = "";

(* Problem 3 tests *)
val p3t1 = longest_string2 ["Smurf", "Lol"] = "Smurf";
val p3t2 = longest_string2 ["Smurf"] = "Smurf";
val p3t3 = longest_string2 [] = "";

(* Problem 4 tests *)
val p4t1 = longest_string3 ["Smurf", "Lol"] = "Smurf";
val p4t2 = longest_string4 ["Smurf", "Lol"] = "Smurf";

(* Problem 5 tests *)
val p5t1 = longest_capitalized ["Smurf", "hellothere"] = "Smurf";
val p5t2 = longest_capitalized [] = "" ;

(* Problem 6 tests *)
val p6t1 = rev_string "hello" = "olleh" ; 
val p6t2 = rev_string "" = "" ; 


(* Problem 9a tests *)
val p9at1 = count_wildcards Wildcard = 1;
val p9at2 = count_wildcards (Variable "hi") = 0;

(* Problem 9b tests *)
val p9bt1 = count_wild_and_variable_lengths Wildcard = 1;
val p9bt2 = count_wild_and_variable_lengths (Variable "hello") = 5;
                               
(* Problem 9c tests *) 
val p9ct1 = count_some_var ("hi", (Variable "hi")) = 1;
val p9ct2 = count_some_var ("no", (Variable "hi")) = 0;


