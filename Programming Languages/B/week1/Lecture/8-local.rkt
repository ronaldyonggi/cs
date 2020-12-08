#lang racket
(provide (all-defined-out))

; Racket has 4 ways to define local variables.
; 1. Let: expressions are all evaluated in the environment
; BEFORE the let expression

(define (double1 x)
  (let ([x (+ x 3)]
        [y (+ x 2)]) ; this x is the function argument x
    (+ x y -5)))

; 2. Let* : expressions are evaluated in environment
; produced from PREVIOUS BINDINGS. This is how
; ML let expressions work.
(define (double2 x)
  (let* ([x (+ x 3)]
        [y (+ x 2)]) ; this time the x is from the line above
    (+ x y -8)))

; 3. letrec: expressions are evaluated in environment that
; includes ALL the bindings, previous and after. Not
; recommended unless mutual recursion is involved.

(define (triple x)
  (letrec ([y (+ x 2)]
           [f (lambda (z) (+ z y w x ))] ; notice that w is just defined below!
           [w (+ x 7)])
    (f -9)))

; 4. define. simply local define.
(define (mod x)
  (define (even? x) (if (zero? x) #t (odd? (- x 1))))
  (define (odd? x)(if (zero? x) #f (even? (- x 1))))
  (if (even? x) 0 1))