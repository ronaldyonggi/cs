#lang racket
(provide (all-defined-out))

; Extra Practice for Week 2 Materials

;; ========Racket Structs=======
;; The following is implementation of binary trees using structs.
(struct btree-leaf () #:transparent)
(struct btree-node (value left right) #:transparent)
; A binary tree is either (btree-leaf) or a Racket value built from
; btree-node where the left and right fields are both binary trees.

; Write a function 'tree-height' that accepts a binary tree and evaluates
; to a height of this tree. The height of a tree is the length of the longest
; path to a leaf. The height of a leaf is 0.
(define (tree-height bt)
  (if (btree-leaf? bt) 0
      (+ 1
         (max
          (tree-height (btree-node-left bt))
          (tree-height (btree-node-right bt))))))

; Write a function sum-tree that takes binary tree and sums all
; the values in all nodes. Assume the value fields all hold numbers.
(define (sum-tree bt)
  (if (btree-leaf? bt) 0
      (+ (btree-node-value bt)
         (+ (sum-tree (btree-node-left bt))
            (sum-tree (btree-node-right bt))))))

; Write a function prune-at-v that takes a binary tree t and
; a value v and produces a new binary tree with structure the
; same as t except any node with value equal to v (use Racket's equal?)
; is replaced (along with all its descendants) by a leaf.
(define (prune-at-v bt v)
  (cond [(btree-leaf? bt) bt]
        [(equal? v (btree-node-value bt)) (btree-leaf)]
        [else (btree-node (btree-node-value bt)
                          (prune-at-v (btree-node-left bt) v)
                          (prune-at-v (btree-node-right bt) v))]))

;; ========Dynamic Typing=======
; Write a function 'crazy-sum' that takes a list of numbers and adds them
; all together starting from the left. However, the list is allowed to contain
; functions in addition to numbers. Whenever an element of a list is a function,
; you should start using it to combine all the following numbers in a list instead
; of +. Assume the list is non-empty and contains only numbers and binary functions
; suitable for operating on 2 numbers. Further assume the first list element
; is a number.
(define (crazy-sum lst)
  (define (helper lst sofar)
    (cond [(null? lst) sofar]
          [(not (number? (car lst)))
           (helper (cddr lst) ((car lst) sofar (cadr lst)))]
          [else (helper (cdr lst) (+ sofar (car lst)))]))
  (helper lst 0))

; Write a function flatten that takes a list and flatten its internal structure,
; merging all the lists inside into a single flat list. This should work for lists
; nested to arbitrary depth. For example:
; (flatten (list 1 2 (list (list 3 4) 5 (list (list 6) 7 8)) 9 (list 10)))
; should evaluate to (list 1 2 3 4 5 6 7 8 9 10)
(define (flatten lst)
  (cond [(null? lst) null]
        [(or (list? (car lst)) (pair? (car lst))) (append (flatten (car lst)) (flatten (cdr lst)))]
        [else (cons (car lst) (flatten (cdr lst)))]))

          