#lang racket
(provide (all-defined-out))

; Problem 1
; Write a function 'palindromic' that takes a list of numbers and evaluates
; to a list of numbers of the same length, where each elements is obtained as follows:
; - the first element should be the sum of the first and the last elements of the
;   original list
; - the second one should be the sum of the second and second to last elements of
;   the original list
; - and so on.
; For example, (palindromic (list 1 2 4 8)) evaluates to (list 9 6 6 9)
(define (palindromic l)
  (letrec ([f (lambda (lst i)
                (if (null? lst) null
                    (cons (+ (car lst) (list-ref l i))
                          (f (cdr lst) (- i 1)))))])
    ; i is the index going backwards starting from the last element of l
    (f l (- (length l) 1))))

; Problem 2
; Define a stream 'fibonacci', the first element of which is 0,
; the second one is 1, and each successive element is the sum of two
; immediately preceding elements.
(define fibonacci
  (letrec ([f (lambda (current next)
                (cons current
                      (lambda () (f next (+ current next)))))])
    (lambda () (f 0 1))))

; Problem 3
; Write a function 'stream-until' that takes a function f and a stream s, and
; applies f to the values of s in succession until f evaluates to #f

; Problem 4
; Write a function 'stream-map' that takes a function f and a stream s, and
; returns a new stream whose values are the result of applying f to the
; values produced by s.
(define (stream-map f s)
  (letrec ([h (lambda (x)
                (cons (f (car (x)))
                      (lambda () (h (cdr (x))))))])
    (lambda () (h s))))

; Problem 5
; Write a function stream-zip that takes in two streams s1 and s2 and returns a
; stream that produces the pairs that result from the other two streams (so the first
; value for the result stream will be the pair of the first value of s1 and
; the first value of s2).