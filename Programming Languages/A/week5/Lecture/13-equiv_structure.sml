(* This signature exposes rational datatype to client! *)

signature RATIONAL_A = 
sig
datatype rational = Frac of int * int | Whole of int
exception BadFrac
val make_frac: int * int -> rational
val add : rational * rational -> rational
val toString : rational -> string
end


(* RATIONAL B is better that it hides the implementation of rational  *)
signature RATIONAL_B =
sig
type rational
exception BadFrac
val make_frac: int * int -> rational
val add : rational * rational -> rational
val toString : rational -> string
end


(* RATIONAL_C is a cute twist since it exposes Whole *)
signature RATIONAL_B =
sig
type rational
exception BadFrac
val Whole : int -> rational
val make_frac: int * int -> rational
val add : rational * rational -> rational
val toString : rational -> string
end