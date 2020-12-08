#lang racket
(provide (all-defined-out))

; A silly addition function that runs slow
(define (slow-add x y)
  (letrec ([slow-id (lambda (a b)
                      (if (= 0 b)
                          a
                          (slow-id a (- b 1))))])
    (+ (slow-id x 50000000) y)))

; multiplies x and result of calling f-thunk.
; f-thunk is called x times.
(define (mult x f-thunk)
  (cond [(= x 0) 0]
        [(= x 1) (f-thunk)]
        [#t (+ (f-thunk) (mult (- x 1) f-thunk))]))

; Notice that here the result of slow-add is slow!
(slow-add 3 4)

; Here calling mult with x of 0 is fast because the cond
; only cares about the result of x = 0 immediately. This multiplites
; 7 by 0
(mult 0 (lambda () (slow-add 3 4)))

; However here, calling mult with x = 2 is slow! This multiplies
; 7 by 2
(mult 2 (lambda () (slow-add 3 4)))


; Don't even think about calling mult with x = 10 or more!
; This is because when x > 1, the slow-d is called that many times
; so with x = 10, imagine recursive slow-id of 50000000 times,
; and recalling that recursive call 10 times!

; One alternative is to save the result of calling slow-id to
; a local variable (similar to 'let' in SML).
(mul 20 (let ([x (slow-add 3 4)]) (lambda () x)))

; However, the drawback of this method is that the program
; computes that slow-add even when x is 0. So calling mult
; with 0 becomes slow, but it's not going to be any slower.