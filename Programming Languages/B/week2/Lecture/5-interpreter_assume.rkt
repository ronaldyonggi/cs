#lang racket

; Interpreter can assume the input is a legal AST (abstract syntax type) for B.

; An example of illegal AST, which we don't need to handle the error:
; (multiply (add (const 3) ("uh-oh") (const 4)) (negate -7))
;
; Above, it seems as if user intendedly use add with a string, which is illegal AST.

(struct const (int) #:transparent) ; int should be a number
(struct negate (e1) #:transparent) ; e1 should be an expression
(struct add (e1 e2) #:transparent) ; e1, e2 should be expressions
(struct multiply (e1 e2) #:transparent) ; e1, e2 should be expressions
(struct bool (b) #:transparent) ; b should be #t or #f
(struct eq-num (e1 e2) #:transparent) ; e1, e2 should be expressions
(struct if-then-else (e1 e2 e3) #:transparent) ; e1, e2, e3 should be expressions

; The following test is legal and works fine.
(define test1
  (multiply
   (negate (add (const 2) (const 2)))
   (const 7)))

; The following test is legal, BUT NOTICE that this will throw error
; since it seemed that the user didn't expect the if-then-else part to return #t.
; NEED TO HANDLE THESE KIND OF ERRORS.
(define test2
  (multiply
   (negate (add (const 2) (const 2)))
   (if-then-else (bool #f) (const 7) (bool #t))))

; The following is an illegal AST. Don't need to handle this error.
(define illegal
  (multiply
   (negate (add (const #t) (const 2)))
   (const 7)))

; This is a bad version of eval-exp that doesn't check the type of expressions
; beforehand. Don't do this.
;(define (eval e)
;  (cond [(const? e) e]
;        [(negate? e) (const (- (const-int (eval (negate-e1 e)))))]
;        [(add? e)
;         (let ([i1 (const-int (eval (add-e1 e)))]
;               [i2 (const-int (eval (add-e2 e)))])
;           (const (+ i1 i2)))]
;        [(multiply? e)
;         (let ([i1 (const-int (eval (multiply-e1 e)))]
;               [i2 (const-int (eval (multiply-e2 e)))])
;           (const (* i1 i2)))]
;        [(bool? e) e]
;        [(eq-num? e)
;         (let ([i1 (const-int (eval (eq-num-e1 e)))]
;               [i2 (const-int (eval (eq-num-e2 e)))])
;           (bool (= i1 i2)))]
;        [(if-then-else? e)
;         (if (bool-b (eval (if-then-else-e1 e)))
;             (eval (if-then-else-e2 e))
;             (eval (if-then-else-e3 e)))]
;        [#t (error "eval-exp expected an exp")] ; not strictly necessary
;        ))

; This is a good version of eval-exp that checks the type of epressions beforehand.
(define (eval e)
  (cond [(const? e) e]
        [(negate? e)
         (let ([v (eval (negate-e1 e))])
           (if (const? v) ; check first whether v is a constant
               (const (- (const-int v)))
               (error "negate applied to non-number")))]
        [(add? e)
         (let ([v1 (eval (add-e1 e))]
               [v2 (eval (add-e2 e))])
           (if (and (const? v1) (const? v2)) ; check first whether both v1 and v2 are constants
               (const (+ (const-int v1) (const-int v2)))
               (error "add applied to non-number")))]
        [(multiply? e)
         (let ([v1 (eval (multiply-e1 e))]
               [v2 (eval (multiply-e2 e))])
           (if (and (const? v1) (const? v2)) ; check first whether both v1 and v2 are constants
               (const (* (const-int v1) (const-int v2)))
               (error "multiply applied to non-number")))]
        [(bool? e) e]
        [(eq-num? e)
         (let ([v1 (eval (eq-num-e1 e))]
               [v2 (eval (eq-num-e2 e))])
           (if (and (const? v1) (const? v2)) ; check first whether both v1 and v2 are constants
               (bool (= (const-int v1) (const-int v2)))
               (error "eq-num applied to non-number")))]
        [(if-then-else? e)
         (let ([v (eval (if-then-else-e1 e))])
           (if (bool? v) ; check first whether if v is a boolean
               (if (bool-b v) ; check if v is true
                   (eval (if-then-else-e2 e)) ; execute if v true
                   (eval (if-then-else-e3 e))) ; execute if v false
               (error "if-then-else applied to non-boolean")))]
        [#t (error "eval-exp expected an exp")] ; not strictly necessary
        ))