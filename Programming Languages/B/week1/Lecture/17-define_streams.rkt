#lang racket
(provide (all-defined-out))

; The following is a stream that always returns 1 when called.
(define ones (lambda () (cons 1 ones)))

; The following is how to get the result of calling
; the stream once and twice;
(car (ones)) ; 1
(car ((cdr (ones)))) ;1

;The following is a stream that returns a number incremental
; by 1, starting from x (e.g. if x
; is 1, then 1, 2, 3, 4, 5, 6 ...)
(define (f x) (cons x (lambda() (f (+ x 1)))))

; Below is a thunk that returns natural numbers starting
; from 1, making use of the stream defined above.
(define nats (lambda () (f 1)))

; However, rather than writing the thunk and stream,
; separately, might as well define nats with the stream
; locally defined.

(define nats2
  (letrec ([f (lambda (x) (cons x (lambda () (f (+ x 1)))))])
    (lambda () (f 1))))

; Below is the thunk powers-of-two that's used from
; previous lecture.
(define powers-of-two
  (letrec ([f (lambda (x) (cons x (lambda () (f (* x 2)))))])
    (lambda () (f 1))))

; Rather than defining streams locally like above,
; one convenient method is to define a stream-maker
; function that can be used to create streams.

(define (stream-maker fn arg)
  (letrec ([f (lambda (x) (cons x (lambda () (f (fn x arg)))))])
    (lambda () (f 1))))

(define nats-easy (stream-maker + 1))
(define powers-of-two2 (stream-maker * 2))

