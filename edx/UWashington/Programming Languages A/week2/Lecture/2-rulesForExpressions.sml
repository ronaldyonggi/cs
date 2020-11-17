(* Syntax, Typing Rules, and Evaluation Rules for Conditional Expressions *)


Syntax:
if e1 then e2 else e3
where if, then, and else are keywords.
e1, e2 and e3 are subexpressions

Type-checking:
first e1 must have type bool
e2 and e3 can have any type t, but both must have the same type t
The type of the entire expression is also t.

Evaluation rules:
first evaluate e1 to a value v1.
if it's true, evaluate e2 and that result is the whole expression's result
else, evaluate e3 and that result is the whole expression's result

(* Syntax, Typing Rules, and Evaluation Rules for less-than comparisons *)

Syntax:
e1 < e2
e1 and e2 are subexpressions

Type-Checking:
e1 and e2 must both have type int, or a type that's comparable

Evaluation Rules:
evaluate e1 to v1 and e2 to v2
if v1 is less than v2, produce true
otherwise produce false




