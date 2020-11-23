(* Map: applies f to each element in a list *)

fun map (f, list) =
    case list of
        [] => [] 
      | x::rest => (f x)::map(f, rest) ;

map (fn x => x + 1, [4, 8, 12]) = [5, 9, 13];
map (hd, [[1, 2], [3, 4], [5, 6, 7]]) = [1, 3, 5];


(* Filter: returns a list that contains elements in which f(e) is true *)
fun filter (f, list) = 
    case list of
        [] => [] 
      | x::rest => if f x then x::filter(f, rest) else filter(f, rest);
                  

filter (fn x => x mod 2 = 0, [1,2,3])  = 2; (* Only take elements that are even *)
