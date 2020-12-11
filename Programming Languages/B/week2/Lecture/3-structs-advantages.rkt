#lang racket

; Let's compare structs with datatype that we made using lists.
(struct add (e1 e2) #:transparent)

; vs.

;(define (add e1 e2) (list 'add e1 e2))
;(define (add? e) (eq? (car e) 'add))
;(define add-e1 cadr)
;(define add-e2 caddr)

; Struct creates a new kind of data. The result of calling (add x y)
; is not a list.
(struct const (int) #:transparent)

(define x (add (const 3) (const 4)))
(pair? x) ; #f. x is not a pair!
(list? x) ; #f. nor x is a list!
(add? x) ; #t

; If we use list inner implementation, it's more error prone because
; we can potentially retrieve elements simply using list retrieval
; keywords (car, cadr, etc.) or using the wrong method (e.g. retrieve
; add-e1 using multiply-e1)