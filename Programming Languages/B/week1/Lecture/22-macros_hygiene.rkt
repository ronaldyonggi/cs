#lang racket

;Below is a function that doubles its argument.
;It can be either one.
(define (dbf x) (+ x x))
;(define (dbf x) (* 2 x))

; Below prints "hi" once, then doubles 42.
(dbf (begin (print "hi") 42)) 

; However with macros, doubling is more complicated.
(define-syntax dbm1
  (syntax-rules ()
    [(dbm1 x)
       (+ x x)]))

; Below prints "hi" twice, then doubles 42
(dbm1 (begin (print "hi") 42))

;If we change the macro definition, the result would
; change as well.

(define-syntax dbm2
  (syntax-rules ()
    [(dbm2 x)
       (* 2 x)]))

; Below prints "hi" once, then doubles 42
(dbm2 (begin (print "hi") 42))

; In the case of dbm1, macros re-evaluate the argument
; that's passed. To prevent this, use
; a local binding.
(define-syntax dbloc
  (syntax-rules ()
    [(dbl x)
     (let ([y x]) (+ y y))]))

; In Racket macros, local variables are looked up where
; the macro is defined.

(define-syntax db-silly
  (syntax-rules ()
    [(db-silly x)
     (let ([y 1])
       (* 2 x y))]))

;If we have the following:
(let ([y 7]) (db-silly y))

; Racket is smart that it recognizes that 7 becomes the
; x-argument to db-silly, thus evaluates to 14.
; In language like C/C++ it becomes the following:
(let ([y 7]) (let ([y 1]) (* 2 y y)))
