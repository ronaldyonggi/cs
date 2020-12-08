#lang racket
(provide (all-defined-out))

;;; The last condition, #t, is similar to else
(define (sum3 lst)
(cond [(null? lst) 0]
      [(number? (car lst)) (+ (car lst) (sum3 (cdr lst)))]
      [#t (+ (sum3 (car lst)) (sum3 (cdr lst)))]))

;;; Counts how many falses in a list
(define (count-falses lst)
(cond [(null? lst) 0]
    ;;;   If (car lst) if anything other than #f, it counts as true
      [(car lst) (count-falses (cdr lst))]
      [#t (+ 1 (count-falses (cdr lst)))]))