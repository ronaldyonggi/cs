(* Recall from previous lectures, we have datatype bindings. This time, we
have a new kind of binding: type synonym. *)

(* Recall our playing cards datatype *)
datatype suit = Club 
       | Diamond 
       | Heart 
       | Spade ;

datatype rank = Jack 
       | Queen 
       | King 
       | Ace 
       | Num of int ;

(* Now if we have a datatype of suit paired with a rank, we can think of a card! *)

type card = suit * rank ;

(* Turns out whenever we initiate a variable, we can confirm the type using : *)
val c1 : card = (Diamond, Ace) ;
val c2 : suit * rank = (Heart, Ace) ;
val c3 = (Spade, Ace) ; (* What's the type of c3? Answer: Both card and suit*rank *)

(* Now let's create a function that uses these variables. *)

fun is_heart_ace (c: card) =
    #1 c = Heart andalso #2 c = Ace ;

val testfunction1 = is_heart_ace(c1) = false;
val testfunction2 = is_heart_ace(c2) = true;
val testfunction3 = is_heart_ace(c3) = false;

(* See that all the tests above works! This means even c2 and c3 which we didn't explicitly
set to be a card type, work as a card since the function is_heart_ace
 takes them just fine! *)




