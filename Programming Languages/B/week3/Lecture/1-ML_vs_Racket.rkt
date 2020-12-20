#lang racket

; ===== ML from a Racket Perspective ======

; ML is like a well-defined subset of Racket.
; ML automatically tells if a program has a bug during
; compile time.

(define (g x) (+ x x )); This works fine

; Below, Racket file compiles just fine, but will throw error in ML
; because ML points out right away that y can't be both an int and
; a list / pair.
(define (f y) (+ y (car y)))

; Same goes for below. You can't + 2 lists together, so ML
; will point out immediately that this is an error.
(define (h z) (g (cons z 2)))


;; However, ML doesn't allow programs that actually works fine.
; For example, a function that outputs either one type or another.
(define (f x)
  (if (> x 0) #t
      (list 1 2)))

; Or a list containing multiple types
(define xs (list 1 #t "hi"))