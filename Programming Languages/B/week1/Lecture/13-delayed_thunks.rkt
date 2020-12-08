#lang racket
(provide (all-defined-out))

; Here is a normal definition of a factorial function.
(define (factorial x)
  (if (= x 0) 1
      (* x (factorial (- x 1)))))

; Here's an unnecessary function wrapping that works
; as an if statement.
(define (my-if e1 e2 e3)
  (if e1 e2 e3))

; If we incorporate my-if with factorial, it will become
; a broken function that never terminates!
(define (fact-bad x)
  (my-if (= x 0) 1
         (* x (fact-bad (- x 1)))))

; Why? Because a function evaluates all expressions inside it,
; while an if expression only evaluates the expression if
; needed (e.g. if condition is true, only evaluates
; the true expression).

;For example in normal factorial function, the
; (* x (factorial (- x 1))) is not evaluated in the
; base case since the if clause only returns the "output if true",
; which is 1.

; On the other hand with my-if as a function, it evaluates both the
; base case AND the recursive (* x (fact-bad (- x 1))) regardless
; the value of x. This means fact-bad is called continuously
; even when x is 0!


; There's a work around to this problem: delayed evaluation
; a.k.a. thunks.

(define (good-if e1 e2 e3)
  (if e1 (e2) (e3)))

; Here, (e2) and (e3) mean call the function with zero argument,
; just like calling a function f() in other programming languages.

(define (fact-thunks x)
  (good-if (= x 0)
           (lambda () 1)
           (lambda () (* x (fact-thunks (- x 1))))))

; We just used a zero-argument function to delay evaluation.
; this is called thunk (e.g. thunk the expression). The expressions
; within the lambda functions (e.g. 1, (* x (fact-thunks (- x 1)))
; are NOT EVALUATED UNTIL CALLED.



