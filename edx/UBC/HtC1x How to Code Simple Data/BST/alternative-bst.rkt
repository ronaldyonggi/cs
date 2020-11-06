;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname alternative-bst) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define-struct entry (key val))
;; Entry is (make-entry Integer String)
;; a key and value pair
(define E1 (make-entry 1 "abc"))
(define E3 (make-entry 3 "ilk"))
(define E4 (make-entry 4 "dcj"))
(define E7 (make-entry 7 "ruf"))
(define E10(make-entry 10"why"))
(define E14(make-entry 14 "olp"))
(define E27(make-entry 27"wit"))
(define E42(make-entry 42"dcj"))
(define E50(make-entry 50"dug"))

#;
(define (fn-for-entry e)
  (... (entry-key e)   ; Integer
       (entry-val e)))   ; String

(define-struct node (e l r))
;; BST is one of:
;; - false
;; - (make-node Entry BST BST)
;; interp. false means no BST, or empty BST
;;         e contains the key and value
;;         l and r are left and right subtrees
;; INVARIANT: for a given node:
;;     key within entry is > all keys in its l(eft)  child
;;     key within entry is < all keys in its r(ight) child
;;     the same key never appears twice in the tree
(define BST0 false)
(define BST1 (make-node E1 false false))
(define BST4 (make-node E4 false (make-node E7 false false)))
(define BST3 (make-node E3 BST1 BST4))
(define BST42
  (make-node E42
             (make-node E27 (make-node E14 false false) false)
             (make-node E50 false false)))
(define BST10 (make-node E10 BST3 BST42))

#;
(define (fn-for-bst t)
  (cond [(false? t) (...)]
        [else
         (... (entry-key (node-e t)) ; Integer 
              (entry-val (node-e t)) ; String
              (fn-for-bst (node-l t))
              (fn-for-bst (node-r t)))]))

(check-expect (lookup-key BST0 99) false)
(check-expect (lookup-key BST1 1) "abc")
(check-expect (lookup-key BST1 99) false)
(check-expect (lookup-key BST10 27) "wit")
(check-expect (lookup-key BST10 44) false)
(check-expect (lookup-key BST10 7) "ruf")
(check-expect (lookup-key BST10 15) false)

(define (lookup-key t k)
  (cond [(false? t) false]
        [(= k (entry-key (node-e t))) (entry-val (node-e t))]
        [(< k (entry-key (node-e t))) (lookup-key (node-l t) k)]
        [(> k (entry-key (node-e t))) (lookup-key (node-r t) k)]))