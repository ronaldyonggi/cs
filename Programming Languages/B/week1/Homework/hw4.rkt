#lang racket

(provide (all-defined-out)) ;; so we can put tests in a second file

;; put your code below

; Problem 1
(define (sequence low high stride)
  (if (> low high) null
      (cons low (sequence (+ low stride) high stride))))

; Problem 2
(define (string-append-map xs suffix)
  (map (lambda (x) (string-append x suffix)) xs))

; Problem 3
(define (list-nth-mod xs n)
  (cond [(< n 0) error "list-nth-mod: negative number"]
        [(null? xs) error "list-nth-mod: empty list"]
        [#t (car (list-tail xs (remainder n (length xs))))]))

; Problem 4
(define (stream-for-n-steps s n)
  (if (<= n 0) null
      (cons (car (s)) (stream-for-n-steps (cdr (s)) (- n 1)))))

; Problem 5
(define funny-number-stream
  (letrec ([f (lambda (x)
                (cons (if (zero? (remainder x 5)) (- x) x)
                      (lambda () (f (+ x 1)))))])
    (lambda () (f 1))))

; Problem 6
(define dan-then-dog
  (letrec ([f (lambda (x)
                (cons x (lambda ()
                          (if (eq? "dan.jpg" x) "dog.jpg" "dan.jpg"))))])
    (lambda () (f "dan.jpg"))))

; Problem 7
(define (stream-add-zero s)
  (letrec ([f (lambda (x)
                  (cons ; it's a list!
                   (cons 0 (car (x)))  ;the car of the list is a pair of 0 and the element
                   (lambda () (f (cdr (x))))))]) ;while the cdr is thunk to the next element
    (lambda () (f s))))

; Problem 8
(define (cycle-lists xs ys)
  (letrec ([f (lambda (n)
                (cons
                 (cons (list-nth-mod xs n)
                       (list-nth-mod ys n))
                 (lambda () (f (+ 1 n)))))])
    (lambda () (f 0))))

; Problem 9
(define (vector-assoc v vec)
  (letrec ([ f (lambda (n)
                 (if (> n (vector-length vec)) #f
                     ; let current is the currently selected nth element in the vector
                     (let ([current (vector-ref vec n)])
                       (if (and (pair? current)
                                (equal? v (car current)))
                           current
                           (f (+ 1 n))))))])
    (f 0)))

; Problem 10
(define (cached-assoc xs n)
  (letrec ([cache null]
           
  