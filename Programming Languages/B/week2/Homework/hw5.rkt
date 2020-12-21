;; Programming Languages, Homework 5

#lang racket
(provide (all-defined-out)) ;; so we can put tests in a second file

;; definition of structures for MUPL programs - Do NOT change
(struct var  (string) #:transparent)  ;; a variable, e.g., (var "foo")
(struct int  (num)    #:transparent)  ;; a constant number, e.g., (int 17)
(struct add  (e1 e2)  #:transparent)  ;; add two expressions
(struct ifgreater (e1 e2 e3 e4)    #:transparent) ;; if e1 > e2 then e3 else e4
(struct fun  (nameopt formal body) #:transparent) ;; a recursive(?) 1-argument function
(struct call (funexp actual)       #:transparent) ;; function call
(struct mlet (var e body) #:transparent) ;; a local binding (let var = e in body) 
(struct apair (e1 e2)     #:transparent) ;; make a new pair
(struct fst  (e)    #:transparent) ;; get first part of a pair
(struct snd  (e)    #:transparent) ;; get second part of a pair
(struct aunit ()    #:transparent) ;; unit value -- good for ending a list
(struct isaunit (e) #:transparent) ;; evaluate to 1 if e is unit else 0

;; a closure is not in "source" programs but /is/ a MUPL value; it is what functions evaluate to
(struct closure (env fun) #:transparent) 

;; Problem 1

;; CHANGE (put your solutions here)
(define (racketlist->mupllist lst)
  (if (null? lst) (aunit)
      (apair (car lst) (racketlist->mupllist (cdr lst)))))

(define (mupllist->racketlist lst)
  (if (aunit? lst) null
      (cons (apair-e1 lst) (mupllist->racketlist (apair-e2 lst)))))

;; Problem 2

;; lookup a variable in an environment
;; Do NOT change this function
(define (envlookup env str)
  (cond [(null? env) (error "unbound variable during evaluation" str)]
        [(equal? (car (car env)) str) (cdr (car env))]
        [#t (envlookup (cdr env) str)]))

;; Do NOT change the two cases given to you.  
;; DO add more cases for other kinds of MUPL expressions.
;; We will test eval-under-env by calling it directly even though
;; "in real life" it would be a helper function of eval-exp.
(define (eval-under-env e env)
  (cond [(var? e) 
         (envlookup env (var-string e))]
        [(int? e) e]
        [(add? e) 
         (let ([v1 (eval-under-env (add-e1 e) env)]
               [v2 (eval-under-env (add-e2 e) env)])
           (if (and (int? v1)
                    (int? v2))
               (int (+ (int-num v1) 
                       (int-num v2)))
               (error "MUPL addition applied to non-number")))]
        ;; CHANGE add more cases here
        [(aunit? e) e]
        [(closure? e) e]
        [(fun? e) (closure env e)]
        [(ifgreater? e)
         (let ([v1 (eval-under-env (ifgreater-e1 e) env)]
               [v2 (eval-under-env (ifgreater-e2 e) env)])
           (if (and (int? v1) (int? v2))
               (if (> (int-num v1) (int-num v2))
                   (eval-under-env (ifgreater-e3 e) env)
                   (eval-under-env (ifgreater-e4 e) env))
               (error "ifgreater applied to non-number")))]
        [(mlet? e)
         (if (string? (mlet-var e)) ; check first if mlet-var is a string
             (let ([new-binding (cons (mlet-var e) (eval-under-env (mlet-e e) env))])
               (eval-under-env (mlet-body e) (cons new-binding env)))
             (error "mlet applied to non-string variable"))]
        [(call? e)
         ; evaluate 1st and 2nd subexpression
         (let ([v1 (eval-under-env (call-funexp e) env)] ; v1 = the closure
               [v2 (eval-under-env (call-actual e) env)])
           (if (not (closure? v1)) (error "call applied to non-closure")
               (letrec ([clos-fun-body (fun-body (closure-fun v1))] ; closure's function body
                     [clos-fun-name (fun-nameopt (closure-fun v1))] ; closure's function name
                     [clos-fun-arg (fun-formal (closure-fun v1))] ; closure's function arg
                     [bind2 (cons clos-fun-arg v2)]) ; a pair mapping function arg to v2
                 (if clos-fun-name ; if closure's function name is not #f
                     (letrec ([bind1 (cons clos-fun-name v1)]) ; create a binding of pair mapping function name to v1
                       ; then evaluate closure's fun body with extended environment of both bind1 and bind2
                       (eval-under-env clos-fun-body (cons bind1 (cons bind2 (closure-env v1)))))
                     ; otherwise evaluate closure's fun body with extended environment of only bind2
                     (eval-under-env clos-fun-body (cons bind2 (closure-env v1)))))))]

        [(apair? e)
          (apair (eval-under-env (apair-e1 e) env)
                 (eval-under-env (apair-e2 e) env))]
        ; for fst and snd, evaluate e first and see if it's a pair.
        [(fst? e)
         (let ([p (eval-under-env (fst-e e) env)])
           (if (apair? p) (apair-e1 p)
             (error "fst applied to non-apair")))]
        [(snd? e)
         (let ([p (eval-under-env (snd-e e) env)])
           (if (apair? p) (apair-e2 p)
             (error "snd applied to non-apair")))]
        [(isaunit? e)
         (let ([subex (eval-under-env (isaunit-e e) env)])
           (if (aunit? subex) (int 1) (int 0)))]
        [#t (error (format "bad MUPL expression: ~v" e))]))

;; Do NOT change
(define (eval-exp e)
  (eval-under-env e null))
        
;; Problem 3

(define (ifaunit e1 e2 e3)
  ; Recall if e1 is aunit, (isaunit e1) will return (int 0).
  ; Otherwise (isaunit e1) will return (int 1).
  (ifgreater (isaunit e1) (int 0) e2 e3))

(define (mlet* lstlst e2)
  (if (null? lstlst) e2
      ; car lstlst = the first element of lstlst, which is a pair.
      (mlet (car (car lstlst)) ; take the first element of the pair as the var of mlet
            (cdr (car lstlst)) ; take the 2nd element of the pair as the e of mlet
            (mlet* (cdr lstlst) e2)))) ; body of mlet

; Be careful for misleading problem statement. e3 is evaluated
; ONLY IF e1 = e2.
(define (ifeq e1 e2 e3 e4)
  ; To make sure e1 and e2 are evaluated exactly once, they need to be 
  ; first bound to variables using mlet! 
  ; Since the problem statement explicitly mentioned _x and _y, use them!
  (mlet "_x" e1 
        (mlet "_y" e2
              ; Tricky: this is similar to incorporating:
              ; if e1 > e2 then e4
              ; else if e2 > e1 then e4
              ; else e3
              (ifgreater (var "_x") (var "_y") e4
                         (ifgreater (var "_y") (var "_x") e4 e3)))))
              

;; Problem 4


(define mupl-map
  (fun #f "f" ; curry function
       (fun "map" "mupl-list" ; function that takes a MUPL list
            (ifaunit (var "mupl-list") (aunit) ; similar to (if (null? lst) null
                     ; Otherwise, similar to (cons (f (car lst)) (map (cdr lst)))
                     (apair (call (var "f") (fst (var "mupl-list")))
                            (call (var "map") (snd (var "mupl-list"))))))))


(define mupl-mapAddN 
 (mlet "map" mupl-map
       (fun #f "i" ; initiate a function that takes an integer
            (call (var "map")  
                  (fun #f "x" (add (var "x") (var "i")))))))
; provide the map function with a lambda function with argument "x"
; that adds x with i.


;; Challenge Problem

(struct fun-challenge (nameopt formal body freevars) #:transparent) ;; a recursive(?) 1-argument function

;; We will test this function directly, so it must do
;; as described in the assignment
(define (compute-free-vars e) "CHANGE")

;; Do NOT share code with eval-under-env because that will make
;; auto-grading and peer assessment more difficult, so
;; copy most of your interpreter here and make minor changes
(define (eval-under-env-c e env) "CHANGE")

;; Do NOT change this
(define (eval-exp-c e)
  (eval-under-env-c (compute-free-vars e) null))

