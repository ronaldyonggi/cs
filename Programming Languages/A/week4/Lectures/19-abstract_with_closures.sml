datatype set = S of { insert: int -> set,
                      member: int -> bool,
                      size  : unit -> int }

(* Implementation of sets: this is the underlying of what's inside 
empty_set. Clients don't need to understand this. *)
val empty_set = 
    let
        (* xs is a private field in result *)
        fun make_set xs = 
            let
            (* contains return true if a duplicate is found *)
                fun contains i = List.exists (fn j => i = j) xs
            in
            (* there shouldn't be any duplicate in insert *)
                S {insert = fn i => if contains i
                                    then make_set xs
                                    else make_set (i::xs),
                   member = contains,
                   size = fn () => length xs
                }
            end
    in
        make_set []
    end

(* Example client *)
fun use_sets () = 
    let
        val S s1 = empty_set
        val S s2 = (#insert s1) 34
        (* Above is equivalent to s1.insert(34) in other programming language *)
        val S s3 = (#insert s2) 34
        (* Above wouldn't work since sets don't have duplicates *)
        val S s4 = #insert s3 19
        (* After running above, the set contains 19 and 34 *)
    in
        if (#member s4) 42
        then 99
        else if (#member s4) 19
        then 17 + (#size s3) ()
        else 0
    end

