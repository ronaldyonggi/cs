#lang racket
(provide (all-defined-out))

; If we want to delay a computation, call my-delay on
; a thunk th. This returns a mutable pair consisting
; of a false and the thunk.
(define (my-delay th)
  (mcons #f th))


; If we want to compute the thunk, use my-force with
; the argument p as the pair created from my-delay. This p
; is called a promise.
(define (my-force p)
  ; If the car of the promise is true, that means
  ; the cdr is already in form of result of calling the thunk.
  ; Simply return that.
  (if (mcar p)
      (mcdr p)
      ; Otherwise, do the following:
      ; 1. Set the car of the promise to be true
      ; 2. Call the thunk by calling the thunk
      ; with parentheses (mcdr p) so that now the thunk
      ; becomes the result of calling the thunk.
      ; 3. Return the result of calling the trunk
      (begin (set-mcar! p #t)
             (set-mcdr! p ((mcdr p)))
             (mcdr p))))
; The 'begin' keyword executes a sequence of program and
; return the last statement as the result, in this case,
; the (mcdr p).


; Now recall the mult function from yesterday.
(define (mult x thunk)
  (cond [(= x 0) 0]
        [(= x 1) (thunk)] ; if x is 1, return the result of calling the thunk 
        [ #t (+ (thunk) (mult (- x 1) thunk))])) ; Notice that the recursive
        ; call is not a call to the thunk, but simply the thunk itself.


; Here is an example of using mult, where the thunk is a promise that
; if called, returns the result of adding 3 with 4.
(mult 100
      (let ([p (my-delay (lambda () (slow-add 3 4)))])
        (lambda () (my-force p))))
; once called, the result of the promise is memorized instead of
; recomputed. Thus when the program multiplies the result with 100,
; the program doesn't need to recompute slow-add once again.