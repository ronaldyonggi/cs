;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname tank-missiles) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/universe)
(require 2htdp/image)

;; Space Invaders - Tank Only

;; =========================================================================================================================
;;                                           CONSTANTS
;; =========================================================================================================================

(define WIDTH  300)
(define HEIGHT 500)

(define TANK-SPEED 2)

(define TANK
  (overlay/xy (overlay (ellipse 28 8 "solid" "black")       ;tread center
                       (ellipse 30 10 "solid" "green"))     ;tread outline
              5 -14
              (above (rectangle 5 10 "solid" "black")       ;gun
                     (rectangle 20 10 "solid" "black"))))   ;main body

(define TANK-HEIGHT/2 (/ (image-height TANK) 2))

(define BACKGROUND (empty-scene WIDTH HEIGHT))



;; =========================================================================================================================
;;                                       DATA DEFINITIONS
;; =========================================================================================================================

;; ===================================
;; Game Struct
;; ===================================
(define-struct game (missiles tank))

;; ===================================
;; Tank Struct
;; ===================================
(define-struct tank (x dir))
;; Tank is (make-tank Number Integer[-1, 1])
;; interp. the tank location is x, HEIGHT - TANK-HEIGHT/2 in screen coordinates
;;         the tank moves TANK-SPEED pixels per clock tick left if dir -1, right if dir 1

(define T0 (make-tank (/ WIDTH 2) 1))   ;center going right
(define T1 (make-tank 50 1))            ;going right
(define T2 (make-tank 50 -1))           ;going left

#;
(define (fn-for-tank t)
  (... (tank-x t) (tank-dir t)))

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
;;                                   CHECKS OBJECTS POSITION
;; ****************************************************************************************

;; =========================================================================
;; Check if a tank is about to hit left border
;; =========================================================================
;; Tank -> Boolean
;; checks whether a tank is about to hit the left edge of the screen
(check-expect (tank-left? T0) false)
(check-expect (tank-left? (make-tank 0 -1)) true)

;(define (tank-left? t) false) ;stub

(define (tank-left? t)
  (and
   (< (tank-dir t) 0)
   (< (+ (tank-x t) (* (tank-dir t) TANK-SPEED)) 0)))

;; =========================================================================
;; Check if a tank is about to hit right border
;; =========================================================================
;; Tank -> Boolean
;; checks whether a tank is about to hit the right edge of the screen
(check-expect (tank-right? T0) false)
(check-expect (tank-right? (make-tank WIDTH 1)) true)

;(define (tank-right? t) false) ;stub

(define (tank-right? t)
  (and
   (> (tank-dir t) 0)
   (> (+ (tank-x t) (* (tank-dir t) TANK-SPEED)) WIDTH)))


;; ****************************************************************************************
;;                                     AFTER TICK
;; ****************************************************************************************

;; ===================================
;; Tank moves
;; ===================================
;; tank -> tank
;; updates tank's x position
(check-expect (next-tank T1) (make-tank (+ (tank-x T1) (* TANK-SPEED (tank-dir T1))) (tank-dir T1)))
(check-expect (next-tank T2) (make-tank (+ (tank-x T2) (* TANK-SPEED (tank-dir T2))) (tank-dir T2)))

;(define (next-tank t) t); stub

(define (next-tank t)
  (cond [(tank-right? t) (make-tank WIDTH (tank-dir t))]
        [(tank-left? t) (make-tank 0 (tank-dir t))]
        [else (make-tank (+ (tank-x t) (* TANK-SPEED (tank-dir t))) (tank-dir t))]))

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
;; ListOfMissile move
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
(check-expect (render-missiles
              (list (make-missile 150 200) (make-missile 130 170))
              BACKGROUND)
              (place-image MISSILE 150 200
                           (place-image MISSILE 130 170 BACKGROUND)))

;(define (render-missiles lom) BACKGROUND);

(define (render-missiles lom img)
  (if (empty? lom) img
      (place-image MISSILE (missile-x (first lom)) (missile-y (first lom)) (render-missiles (rest lom) img))))

;; ===================================
;; Tank Render 
;; ===================================
(check-expect (render-tank T0)
              (place-image TANK (tank-x T0) (- HEIGHT TANK-HEIGHT/2) BACKGROUND))

(define (render-tank t)
  (place-image TANK (tank-x t) (- HEIGHT TANK-HEIGHT/2) BACKGROUND))



;; ****************************************************************************************
;;                                     BIG-BANG
;; ****************************************************************************************

;; =======================================================
;; Big Bang Functions
;; =======================================================
;; 
(define (main g)
  (big-bang g
    (on-tick   next)     
    (to-draw   render)
    (on-key handle-key)))

;; ===================================
;; On Tick
;; ===================================
(check-expect (next (make-game
                     (list (make-missile 150 100) (make-missile 23 200))
                     (make-tank 100 1)))
              (make-game
               (list (make-missile 150 90) (make-missile 23 190))
               (make-tank (+ 100 TANK-SPEED) 1)))

(define (next g)
  (make-game (next-missile-list (game-missiles g)) (next-tank (game-tank g))))


;; ===================================
;; Render Everything
;; ===================================
(define (render g)
  (render-missiles (game-missiles g)
                   (render-tank (game-tank g))))

;; ===================================
;; Key Handler
;; ===================================
(define (handle-key g ke)
  (cond [(key=? ke "left") (make-game (game-missiles g) (make-tank (tank-x (game-tank g)) -1))]
        [(key=? ke "right") (make-game (game-missiles g) (make-tank (tank-x (game-tank g)) 1))]
        [(key=? ke " ") (make-game (cons (make-missile (tank-x (game-tank g)) (- HEIGHT TANK-HEIGHT/2)) (game-missiles g)) (game-tank g))]
        [else g]))

(main (make-game empty T0))