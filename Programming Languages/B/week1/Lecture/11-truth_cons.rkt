#lang racket
(provide (all-defined-out))

; Truth is cons just makes a pair.
(define pr (cons 1 (cons #t "hi")))
; here, pr is (1 #t . "hi)
; If we want to access "hi", use (cdr (cdr pr))
(define hi (cdr (cdr pr)))



; On the other hand with the list below, we access "hi" using
; (car (cdr (cdr lst)))
(define lst (cons 1 (cons #t (cons "hi" null))))
(define hi2 (car (cdr (cdr lst))))
; A shorthand of (car (cdr (cdr ...))) is (caddr ...)
(define hi3 (caddr lst))



; a pair is not a list.
(list? pr) ;false

; but a list is a pair as well.
(pair? lst) ;true

; can check length of a list using built-in length
(length lst)

; but we can't use length to check the length of a pair.
; this will throw an error.
; (length pr)