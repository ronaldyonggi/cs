#lang racket
(provide (all-defined-out))

; We can use mcons to create a cons that's mutable.


(define x (cons 14 (cons "hi" null)))
(set! x (cons 42 null))
; Once you initiate a cons, you can't change its content. You can
; only change the entire definition of x.
; (set! (car x) 15)
; Above will give an error.
 
  


; Instead, use mcar, mcdr, set-mcar! and set-mcdr! to create
; a mutable cons.
(define a (mcons 14 (mcons #t "hi")))
(set-mcar! a 1)
; Here, a becomes (mcons 1 (mcons #t "hi))

(set-mcdr! a (mcons "lol" null))
; Here, a becomes (mcons 14 (mcons "lol" null))


;Note that you can't use length to get
; the length of an mcons.