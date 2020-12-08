#lang racket
(provide (all-defined-out))
(define b 3)

(define f
  (lambda (x)
    (* 1 (+ x b))))

(define c (+ b 4)) ; here b=3, so c is 7

(set! b 5)
; b is now mutated to 5, but c is still 7

(define z (f 4)) ; now z is 9, not 7

(define w c) ; c is still 7, so w = 7


; Having the ability to mutate top-level definitions
; can be problematic. A general principle is that if
; something that doesn't need to change might change,
; make a local copy for it.

; For example, here we define t in global scope.
(define t 7)
; If you're worried that this t might change and thus changes
; f's behavior, just set a local variable in f that saves
; the original value of t.

(define f
  (let ([t t])
    (lambda (x) (* 1 (+ x t)))))
; Here we set "inner t" to be 7. This way,
; f will always be a function that adds 7 to its argument.