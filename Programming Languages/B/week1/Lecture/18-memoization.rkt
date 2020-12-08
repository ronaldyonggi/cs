#lang racket
(provide (all-defined-out))

; The following is a common, inefficient implementation
; of the fib function.
(define (fib1 x)
  (if (or (= x 1) (= x 2))
      1
      (+ (fib1 (- x 1)) (fib1 (- x 2)))))

; Here is a built-in assoc function which if the
; argument x is contained within the list l,
; return the pair containing x, otherwise
; returns false. Note that this x
; only work for the car of the pair, not the cdr
; of the pair!
(define l (list (cons 1 2) (cons 3 4) (cons 5 6)))
(assoc 3 l) ; returns (cons 3 4)
(assoc 6 l) ; returns #f

; In our memoization fib implementation, 'memo' is
; (initially empty) a list that contains a list of pairs
; (arg . result). If the arg is found in 'memo', returns
; the result associated with that arg.

(define fib3
  (letrec ([memo null]
           [f (lambda (x)
                (let ([ans (assoc x memo)])
                  ; if ans is found in memo, return result
                  (if ans (cdr ans)
                      ; Otherwise, compute the new fib result
                      ; as new-ans.
                      (let ([new-ans (if (or (= x 1) (= x 2))
                                         1
                                         (+ (f (- x 1)) (f (- x 2))))])
                        ; And append a new pair containing the new
                        ; args paired with new-ans into memo
                        (begin
                          (set! memo (cons (cons x new-ans) memo))
                                ; And return this new-ans
                                new-ans)))))])
    f))

; We'll find that this fib3 memoization implementation
; is fast, even when we compute the fib of a large number!
(fib3 1000)