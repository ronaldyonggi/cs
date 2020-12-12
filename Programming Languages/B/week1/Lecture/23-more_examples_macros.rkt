#lang racket

; Here is a macro for let2 that allows 2 local bindings.
(define-syntax let2
  (syntax-rules ()
    [(let2 () body) body]
    [(let2 (var val) body) (let ([var val]) body)]
    [(let2 (var1 val1 var2 val2) body)
     (let ([var1 val1])
       (let ([var2 val2])
         body))]))

(let2 (x 1 y 2) (+ x y))

(define-syntax for
  (syntax-rules (to do)
    [(for lo to hi do body)
     (let ([l lo]
           [h hi])
       (letrec ([loop (lambda (i)
                        (if (> i h) #t
                            (begin body (loop (add1 i)))))])
         (loop l)))]))