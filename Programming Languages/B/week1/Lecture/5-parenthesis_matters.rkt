#lang racket
(provide (all-defined-out))

(define (fact n)
    (if (= n 0)
    1
    (* n (fact (- n 1)))))

;;; If we instead have the base case '1' covered in parentheses,
;;; it compiles successfully but gives error when called.
(define (fact1 n)
    (if (= n 0)
    (1)
    (* n (fact1 (- n 1)))))