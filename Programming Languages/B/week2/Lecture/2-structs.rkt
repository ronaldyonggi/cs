#lang racket

; Structs are like ML constructors, but it provides
; constructor, tester, and extractor functions.
; (e.g. const, const?, const-int)
(struct const (int) #:transparent)
(struct negate (e) #:transparent)
(struct add (e1 e2) #:transparent)
(struct multiply (e1 e2) #:transparent)

; the #:transparent is an optional attribute that prints
; struct values in the REPL. VERY USEFUL for debugging

(define (eval-exp e)
  (cond [(const? e) e]
        [(negate? e) (const (- (const-int (eval-exp (negate-e e)))))]
        [(add? e) (let ([v1 (const-int (eval-exp (add-e1 e)))]
                        [v2 (const-int (eval-exp (add-e2 e)))])
                    (const (+ v1 v2)))]
        [(multiply? e) (let ([v1 (const-int (eval-exp (multiply-e1 e)))]
                        [v2 (const-int (eval-exp (multiply-e2 e)))])
                    (const (* v1 v2)))]
        [#t (error "eval-exp expected an exp")]))

(define x (add (const 3) (const 4)))
(eval-exp x) ; returns (const 7)
x ; because of the #:transparent, REPL displays (add (const 3) (const 4))

; If we don't have the #:transparent, the contents of the struct
; won't be displayed in the repl when we call it.
(struct lol (i))
(define y (lol 3))
y ; REPL only says #<lol>

; There's also #:mutable attribute that provides function that
; allows mutation.
(struct card (suit rank) #:transparent #:mutable)
; Here on top of card, card?, card-suit and card-rank, we also have
; set-card-suit! and set-card-rank! to mutate the suit and rank.