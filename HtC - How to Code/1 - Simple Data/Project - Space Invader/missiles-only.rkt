;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname missiles-only) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/universe)
(require 2htdp/image)

;; Space Invaders - Missiles Only

;; =========================================================================================================================
;;                                           CONSTANTS
;; =========================================================================================================================

(define WIDTH  300)
(define HEIGHT 500)

(define MISSILE-SPEED 10)

(define MISSILE (ellipse 5 15 "solid" "red"))

(define BACKGROUND (empty-scene WIDTH HEIGHT))


;; =========================================================================================================================
;;                                       DATA DEFINITIONS
;; =========================================================================================================================

;; ===================================
;; Missile Struct
;; ===================================
(define-struct missile (x y))
;; Missile is (make-missile Number Number)
;; interp. the missile's location is x y in screen coordinates

(define M1 (make-missile 150 300))                       ;not hit U1
(define M2 (make-missile 30 287))
(define M3 (make-missile 200 98))
(define M4 (make-missile 185 120))
(define MLEAVE (make-missile 200 0))

#;
(define (fn-for-missile m)
  (... (missile-x m) (missile-y m)))

;; ===================================
;; Missile List
;; ===================================
;; ListOfMissile is one of:
;; - empty
;; - (cons missile ListOfMissile)
;; interp. a list of missiles
(define LOM0 empty)
(define LOM1 (list M1))
(define LOMLEAVE (list M1 MLEAVE))
(define LOMALL (list M1 M2 M3 M4))

#;
(define (fn-for-lom)
  (cond [(empty? lom) (...)]
        [else
         (... (fn-for-missile (first lom))
              (fn-for-lom (rest lom)))]))

;; Template rules used:
;; - one of: 2 cases
;;   - atomic distinct: empty
;;   - compound: (cons missile ListofMissile)
;; - reference: (first lom) is missile
;; - self reference: (rest lom) is ListOfMissile

;; =========================================================================================================================
;;                                         FUNCTIONS
;; =========================================================================================================================
;; ****************************************************************************************
;;                                     AFTER TICK
;; ****************************************************************************************

;; ===================================
;; Missile moves
;; ===================================
;; missile -> missile
;; updates missile's y-position in 1 tick 
(check-expect (next-missile M1)
              (make-missile (missile-x M1) (- (missile-y M1) MISSILE-SPEED) ))

;(define (next-missile m) m) ;stub

(define (next-missile m)
  (make-missile (missile-x m) (- (missile-y m) MISSILE-SPEED)))

;; ===================================
;; ListOfMissile moves
;; ===================================
;; ListOfMissile -> ListOfMissile
;; updates all missile's position in ListOfMissile. If a missile is leaving
;; the top screen, remove that missile from the list.
(check-expect (next-missile-list LOMLEAVE)
              (cons (make-missile (missile-x M1) (- (missile-y M1) MISSILE-SPEED)) empty))
              

;(define (next-missile-list lom) lom) ;stub

(define (next-missile-list lom)
  (cond [(empty? lom) empty]
        [(<= (missile-y (first lom)) 0) (next-missile-list (rest lom))]
        [else (cons (next-missile (first lom)) (next-missile-list (rest lom)))]))
                                     

;; ****************************************************************************************
;;                                     RENDER
;; ****************************************************************************************
;; ===================================
;; Missiles Render
;; ===================================
;; ListOfMissiles -> Image
;; Render the Missiles in ListOfMissiles
(check-expect (render-missiles LOM0) BACKGROUND)
(check-expect (render-missiles LOM1)
              (place-image MISSILE 150 300 BACKGROUND))

;(define (render-missiles lom) BACKGROUND);

(define (render-missiles lom)
  (if (empty? lom) BACKGROUND
      (place-image MISSILE (missile-x (first lom)) (missile-y (first lom)) (render-missiles (rest lom)))))

;; ****************************************************************************************
;;                                     BIG-BANG
;; ****************************************************************************************

;; =======================================================
;; Big Bang Functions
;; =======================================================
;; 
(define (main loi)
  (big-bang loi
    (on-tick   next)     
    (to-draw   render)))

;; ===================================
;; On Tick
;; ===================================
(define (next lom)
  (next-missile-list lom))
  
(define (render lom)
  (render-missiles lom))

(main LOMALL)