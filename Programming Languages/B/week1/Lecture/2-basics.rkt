#lang racket

(provide (all-defined-out))

(define x 3) ; similar to val x = 3
(define y (+ x 2))

;;; Define a cube function using lambda. This is 
;;; similar to fn x => x * x * x
(define cubelambda
    (lambda (x)
        (* x x x)))

;;; Define a cube function in a regular method of
;;; defining a function
(define (cube x)
    (* x x x))

;;; x to the power of y
(define (pow1 x y)
    (if (= y 0)
        1
        (* x (pow1 x (- y 1)))))

;;; pow function using currying
(define pow2
    (lambda (x)
        (lambda (y)
            (pow1 x y))))

;;; Use the curried pow2 to define 3 to the power of argument
(define three-to-the (pow2 3))