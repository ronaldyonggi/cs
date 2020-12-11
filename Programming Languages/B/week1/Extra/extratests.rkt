#lang racket

;; Be sure to put your homework file in the same folder as this test file.
;; Uncomment the line below and change HOMEWORK_FILE to the name of your homework file.
(require "extra.rkt")

(require rackunit)

;; Helper functions
(define ones (lambda () (cons 1 ones)))
(define a 2)
(define (stream-for-n-steps s n)
  (if (< n 0) null
      (cons (car (s)) (stream-for-n-steps (cdr (s)) (- n 1)))))

(define tests
  (test-suite
   "Sample tests for Week 1 Extra Practice"
   
   ; Problem 1 : Palindromic
   (check-equal? (palindromic (list 1 2 4 8)) (list 9 6 6 9) "Palindromic test")

   ; Problem 2 : Fibonacci
   (check-equal? (stream-for-n-steps fibonacci 5) (list 0 1 1 2 3 5) "Fibonacci test") 
   
   ; Problem 4 : stream-map
   (check-equal? (stream-for-n-steps (stream-map (lambda (x) (+ 2 x)) fibonacci) 5)
                 (list 2 3 3 4 5 7) "stream-map test")

   ; Problem 5 : 
   (check-equal? (stream-for-n-steps
                  (stream-zip fibonacci (stream-map (lambda (x) (+ 2 x)) fibonacci)) 3)
                  (list (cons 0 2) (cons 1 3) (cons 1 3) (cons 2 4))
                 "stream-zip test") 
   ))

(require rackunit/text-ui)
;; runs the test
(run-tests tests)
