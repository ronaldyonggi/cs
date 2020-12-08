#lang racket
(provide (all-defined-out))

(define (f x) (+ x (* x b)))
(define b 3)
; Above, function f refers to b. This forward reference
; is okay.

(define c (+ b 4)) ;this works just fine since b is already defined

;(define d (+ e 4))
(define e 5)
; above d is NOT okay, will get an error
