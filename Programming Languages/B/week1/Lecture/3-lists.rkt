#lang racket
(provide (all-defined-out))


;;; sum all the numbers in a list
(define (sum lst)
    (if (null? lst)
    0
    (+ (car lst) (sum (cdr lst)))))

;;; the append function is built-in in racket, but here's
;;; an example of self-defined append

(define (my-append l1 l2)
    (if (null? l1)
    l2
    (cons (car l1) (my-append (cdr l1) l2))))

;;; map function
(define (my-map f lst)
    (if (null? lst)
    null
    (cons (f (car lst))
            (my-map f (cdr lst)))))