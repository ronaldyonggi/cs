val emptyList = []
(* All elements of a list needs to be of the same type *)
val threeElements = [3, 4, 5] 

(* Append lists with ::. This is useful for base cases for functions involving lists. *)
val test1 = 5::threeElements = [5, 3, 4, 5]
val test2 = 7::[] = [7]
val test3 = 6::3::[] = [6, 3]

(* We can't do [4, 3] :: [2, 3], however we can add a list to a nested list. *)
(* For e1::e2 to work (type-check), e1 needs to be of type t and e2 of type t list. Result type is t list. *)
val nested = [1, 2]::[[3, 4], [5, 6]] = [[1, 2], [3, 4], [5, 6]]


(* ACCESSING LISTS *)
(* Beware of taking 'hd' or 'tl' of an empty list. It will give error! *)
(* Use 'null' to indicate empty lists *)
val testNull = null emptyList = true

(* 'hd' is the same as 'first' in Racket *)
val three = hd threeElements = 3

(* 'tl' is the same as 'rest' in Racket *)
val rest = tl threeElements = [4, 5]


(* EMPTY LIST *)
(* empty list [] has type 'a list, which can be replaced by any type. *)
val truelist = true::[] = [true]
val intlist = 3::[] = [3]
(* null is a function that takes an 'a list and checks whether the list is empty. This way, null can take in a list of any types. hd and tl also takes in 'a lists! *)
val nullbool = null [true, false] = false
