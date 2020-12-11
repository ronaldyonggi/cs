#lang racket

; This is the racket version of the eval_exp function
; defined in ML. Recall
; datatype exp = Const of int | Negate of exp |
;                Add of exp * exp | Multiply of exp * exp

; Below are helper functions that create lists where
; the first element is just a symbol.
(define (Const i) (list 'Const i))
(define (Negate e) (list 'Negate e))
(define (Add e1 e2) (list 'Add e1 e2))
(define (Multiply e1 e2) (list 'Multiply e1 e2))

; Below are helper functions that checks what kind of
; exp.
(define (Const? x) (eq? (car x) 'Const))
(define (Negate? x) (eq? (car x) 'Negate))
(define (Add? x) (eq? (car x) 'Add))
(define (Multiply? x) (eq? (car x) 'Multiply))

; Below are helper functions that retrieve the elements
; associated with an expression.
;(define (Const-int e) (car (cdr e))) 
;(define (Negate-e e) (car (cdr e)))
;(define (Add-e1 e) (car (cdr e)))
;(define (Add-e2 e) (car (cdr (cdr e))))
;(define (Multiply-e1 e) (car (cdr e)))
;(define (Multiply-e2 e) (car (cdr (cdr e))))

; Here are the shorter vesion of the functions above,
; using cadr and caddr.
(define Const-int cadr)
(define Negate-e cadr)
(define Add-e1 cadr)
(define Add-e2 caddr)
(define Multiply-e1 cadr)
(define Multiply-e2 caddr)

; Below is the eval-exp function, similarly defined in ML version.
(define (eval-exp e)
  (cond [(Const? e) e]
        [(Negate? e) (Const (- (Const-int (eval-exp (Negate-e e)))))]
        [(Add? e) (let ([v1 (Const-int (eval-exp (Add-e1 e)))]
                        [v2 (Const-int (eval-exp (Add-e2 e)))])
                    (Const (+ v1 v2)))]
        [(Multiply? e) (let ([v1 (Const-int (eval-exp (Multiply-e1 e)))]
                        [v2 (Const-int (eval-exp (Multiply-e2 e)))])
                    (Const (* v1 v2)))]
        [#t (error "eval-exp expected an exp")]))