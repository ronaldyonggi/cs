signature RATIONAL_A = 
    sig
        datatype rational = Frac of int * int | Whole of int
        exception BadFrac
        val make_frac: int * int -> rational
        val add : rational * rational -> rational
        val toString : rational -> string
    end 
structure Rational1 : RATIONAL_A

(* Let's say client want to create 2 different frac and add them together *)
Rational1.add (Rational1.make_frac(1,0), Rational1.make_frac(2,3))

(* Above would give an exception BadFrac since the client is trying to 
make_frac with 1 and 0. *)

(* However since the signature implementation of datatype rational is 
not hidden to client, a client can bypass the error handler by creating 
a Frac directly: *)
Rational1.Frac(1,0)

(* How to prevent clients so that they don't violate abstraction? Hide more! *)
signature RATIONAL_B = 
sig
type rational
exception BadFrac
val make_frac : int * int -> rational
val add : rational * rational -> rational
val toString: rational -> string
end

structure Rational1 :> RATIONAL_B

(* with this implementation, clients know that the type 'rational' exists, but
they don't know its definition (e.g. don't know rational has Frac constructor) *)