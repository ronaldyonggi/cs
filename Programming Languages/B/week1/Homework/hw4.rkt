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
  (cond [(null? xs) (error "list-nth-mod: empty list")]
        [(< n 0) (error "list-nth-mod: negative number")]
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
  (letrec ([f (lambda (bool)
                (if bool
                    (cons "dan.jpg" (lambda () (f (not bool))))
                    (cons "dog.jpg" (lambda () (f (not bool))))))])
    (lambda () (f #t))))

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
                 (if (>= n (vector-length vec)) #f
                     ; current = the currently selected nth element in the vector
                     (let ([current (vector-ref vec n)])
                       (if (and (pair? current)
                                (equal? v (car current)))
                           current
                           (f (+ 1 n))))))])
    (f 0)))

; Problem 10
(define (cached-assoc xs n)
  (letrec ([cache (make-vector n #f)]
           [index 0]
           [f (lambda (v)
                ; Use the vector-assoc defined in the previous
                ; problem to find if v is already within cache
                (let ([ans (vector-assoc v cache)])
                  (if ans ans
                      (let ([found (assoc v xs)])
                        (if found
                            (begin
                              ; update the element in vector
                              (vector-set! cache index found)
                              ; update the index
                              (set! index (remainder (add1 index) n))
                             found)
                            #f)))))])
    f))