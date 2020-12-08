#lang racket
(provide (all-defined-out))

;;; dynamic typing: can use values of any type anywhere.
;;; For example: a list that holds numbers or nested lists.
(define xs (list 4 5 6))
(define ys (list (list 4 5) 6 7 (list 8)))

;;; A function that sums all the numbers in a list (even nested ones)
(define (sum1 lst)
    (if (null? lst)
    0
    (if (number? (car lst))
        (+ (car lst) (sum1 (cdr lst)))
        (+ (sum1 (car lst)) (sum1 (cdr lst))))))

;;; sum1 doesn't handle in case we have a non-number element. Below
;;; is a version that ignores the element in case it's non-number.
(define (sum2 lst)
    (if (null? lst)
    0
    (if (number? (car lst))
        (+ (car lst) (sum2 (cdr lst)))
        (if (list? (car lst))
            (+ (sum2 (car lst)) (sum2 (cdr lst)))
            (sum2 (cdr lst))))))