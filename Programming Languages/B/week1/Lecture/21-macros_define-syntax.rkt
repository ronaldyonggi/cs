#lang racket

; Below is a macro that defines the keyword 'then' and 'else'
(define-syntax my-if
  (syntax-rules (then else)
    [(my-if e1 then e2 else e3)
     (if e1 e2 e3)]))

(my-if #t then (+ 3 4 ) else 72 ) ; returns 7

; And below is a macro that ignores the first argument.
(define-syntax comment-out
  (syntax-rules ()
    [(comment-out ignore instead) instead]))

(comment-out (car null) (+ 3 4)) ; returns 7;

; Recall my-delay function takes in a thunk.
; (define (my-delay th)
;  (mcons #f th))

; Here is the macro version of my-delay. Here the argument should
; be just the expression, not a thunk. If we provide a thunk,
; then it would become a double thunk.
(define-syntax my-delay
  (syntax-rules ()
    [(my-delay e)
     (mcons #f (lambda () e))]))

;usage: (f (my-delay e))