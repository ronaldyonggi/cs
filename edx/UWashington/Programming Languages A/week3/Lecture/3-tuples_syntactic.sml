(* A tuple is actually a record where the fields are orderly-numbered field name
 1 = ..., 2 = ..., ...*)
val a_pair = {2 = 5, 1 = 6} = (6, 5)
(* Notice the field 1 means 6 should be placed first, then 5 is placed second.
 However, a record can only be equivalent to a tuple if the number ordering is
 proper. Below is an example of a non-proper numbering of a record, which becomes
 a normal record. *)
val b_pair = {1 = 6, 3 = 7}
val thirdfield = #3 b_pair

(* If we try to access #2 in b_pair, it'll throw an
error because it doesn't exist! *)
