#lang racket
(provide (all-defined-out))

; A stream is in form of a pair where the:
; - car is the next element
; - cdr is the next thunk

; Here we have a stream that continuosly multiply
; a number by 2.
(define (stream-maker fn arg)
  (letrec ([f (lambda (x) (cons x (lambda () (f (fn x arg)))))])
    (lambda () (f 2))))

(define powers-of-two (stream-maker * 2))

; And here's how we call the first three element of
; the stream.
(car (powers-of-two))
(car ((cdr (powers-of-two))))
(car ((cdr ((cdr (powers-of-two))))))

