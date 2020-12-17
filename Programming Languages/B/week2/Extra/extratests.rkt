#lang racket

;; Be sure to put your homework file in the same folder as this test file.
;; Uncomment the line below and change HOMEWORK_FILE to the name of your homework file.
(require "extra.rkt")

(require rackunit)

(define tests
  (test-suite
   "Sample tests for Week 2 Extra Practice"
   
   ; tree-height 
   (check-equal? (tree-height (btree-leaf)) 0 "tree-height test 1")
   (check-equal? (tree-height (btree-node 495
                                          (btree-node 9582321 (btree-leaf) (btree-leaf))
                                          (btree-leaf))) 2 "tree-height test 2")

   ; sum-tree 
   (check-equal? (sum-tree (btree-leaf)) 0 "sum-tree test 1")
   (check-equal? (sum-tree (btree-node 1
                                          (btree-node 3 (btree-leaf) (btree-leaf))
                                          (btree-leaf))) 4 "sum-tree test 2")

   ; prune-at-v
   (check-equal? (prune-at-v (btree-node "a"
                                          (btree-node "b" (btree-leaf) (btree-leaf))
                                          (btree-leaf)) "b")
                 (btree-node "a" (btree-leaf) (btree-leaf)) "prune-at-v test")

   ; crazy-sum
   (check-equal? (crazy-sum (list 10 * 6 / 5 - 3)) 9 "crazy-sum test")

   ; flatten
   (check-equal? (flatten (list 1 2 (list (list 3 4) 5 (list (list 6) 7 8)) 9 (list 10)))
                 (list 1 2 3 4 5 6 7 8 9 10) "flatten test")


   
   
   
   ))

(require rackunit/text-ui)
;; runs the test
(run-tests tests)
