;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname invaders-only) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/universe)
(require 2htdp/image)

;; Space Invaders - Invaders Only

;; =========================================================================================================================
;;                                           CONSTANTS
;; =========================================================================================================================

(define WIDTH  300)
(define HEIGHT 500)

(define INVADER-X-SPEED 1.5)  ;speeds (not velocities) in pixels per tick
(define INVADER-Y-SPEED 1.5)

(define INVADE-RATE 100) ;greater INVADE-RATE means less frequent invader to show up

(define BACKGROUND (empty-scene WIDTH HEIGHT))

(define INVADER
  (overlay/xy (ellipse 10 15 "outline" "blue")              ;cockpit cover
              -5 6
              (ellipse 20 10 "solid"   "blue")))            ;saucer

;; =========================================================================================================================
;;                                       DATA DEFINITIONS
;; =========================================================================================================================

;; ===================================
;; Invader Struct
;; ===================================
(define-struct invader (x y dx))
;; Invader is (make-invader Number Number Number)
;; interp. the invader is at (x, y) in screen coordinates
;;         the invader along x by dx pixels per clock tick

(define I1 (make-invader 150 100 12))           ;not landed, moving right
(define I2 (make-invader 150 HEIGHT -10))       ;exactly landed, moving left
(define I3 (make-invader 150 (+ HEIGHT 10) 10)) ;> landed, moving right
(define ICENTER (make-invader (/ WIDTH 2) (/ HEIGHT 2) 0)) ; Stationary invader at the center
(define I11 (make-invader 150 87 -9))
(define I12 (make-invader 99 23 13))
(define I13 (make-invader 34 120 -14))

;; ===================================
;; Invader List
;; ===================================
;; ListOfInvader is one of:
;; - empty
;; - (cons invader ListOfInvader)
;; interp. a list of invaders

(define LOI0 empty)
(define LOI1 (list I1)) ; 1 invader, moving
(define LOI2 (list I1 I2))
(define LOI3 (list I1 I2 ICENTER))
(define LOI4 (list I1 I11 I12 I13)); All moving!

;; =========================================================================================================================
;;                                         FUNCTIONS
;; =========================================================================================================================
;; ****************************************************************************************
;;                                   CHECKS OBJECTS POSITION
;; ****************************************************************************************

;; =========================================================================
;; Checks if invader about to hit right border screen
;; =========================================================================
;; invader -> Boolean
;; checks whether an invader is about to hit the right edge of the screen
(check-expect (invader-right? I1) false)
(check-expect (invader-right? (make-invader (- WIDTH 1) 100 12)) true)

;(define (invader-right? i) false) ;stub

(define (invader-right? i)
  (and
   (> (invader-dx i) 0)
   (> (+ (invader-x i) (invader-dx i)) WIDTH)))


;; =========================================================================
;; Checks if invader about to hit left border screen
;; =========================================================================
;; invader -> Boolean
;; checks whether an invader is about to hit the left edge of the screen
(check-expect (invader-left? I1) false)
(check-expect (invader-left? (make-invader 1 100 -12)) true)

;(define (invader-left? i) false) ;stub

(define (invader-left? i)
  (and
   (< (invader-dx i) 0)
   (< (+ (invader-x i) (invader-dx i)) 0 )))

;; =========================================================================
;; Checks if an invader about to hit bottom border screen
;; =========================================================================
;; invader -> Boolean
;; checks whether an invader is hitting the bottom screen, causing the game to lose
(check-expect (invader-bottom? I1) false)
(check-expect (invader-bottom? (make-invader 1 100 -12)) false)
(check-expect (invader-bottom?(make-invader 1 HEIGHT 10)) true)

;(define (invader-bottom? i) false) ;stub

(define (invader-bottom? i)
  (>= (invader-y i) HEIGHT))

;; ****************************************************************************************
;;                                      INVADER GENERATOR
;; ****************************************************************************************


;; =========================================================================
;; Randomly Generate Invaders
;; =========================================================================
(define (random-invader loi)
  (if (< (random INVADE-RATE) 5)
      (cons
       (make-invader
        (random WIDTH)
        0
        (* (- 1 (* 2 (random 2))) INVADER-X-SPEED)) loi)
      loi))
;(if generate? (cons (make-invader (random WIDTH) 0 (* random-direction INVADER-X-SPEED)) loi)
;loi))

;; ****************************************************************************************
;;                                     AFTER TICK
;; ****************************************************************************************
                                     
;; =========================================================================
;; Individual invader moves
;; =========================================================================
;; invader -> invader
;; updates invader's x and y position in 1 tick 
(check-expect (next-invader I1)
              (make-invader 
               (+ (invader-dx I1) (invader-x I1))
               (+ INVADER-Y-SPEED (invader-y I1))
               (invader-dx I1)))

(check-expect (next-invader (make-invader WIDTH 170 12))
              (make-invader WIDTH (+ INVADER-Y-SPEED 170) -12))

(check-expect (next-invader (make-invader 0 230 -10))
              (make-invader 0 (+ INVADER-Y-SPEED 230) 10))

;(define (next-invader i) i); stub

(define (next-invader i)
  (cond [(invader-left? i)
         (make-invader 0 (+ INVADER-Y-SPEED (invader-y i)) (- (invader-dx i)))]
        [(invader-right? i)
         (make-invader WIDTH (+ INVADER-Y-SPEED (invader-y i)) (- (invader-dx i)))]
        [else
         (make-invader (+ (invader-x i) (invader-dx i)) (+ INVADER-Y-SPEED (invader-y i)) (invader-dx i))]))

;; ===================================
;; ListOfInvader moves
;; ===================================
;; ListOfInvader -> ListOfInvader
;; updates all invader's position in ListOfInvader
(check-expect (next-invader-list LOI1)
              (cons (make-invader
                     (+ (invader-dx I1) (invader-x I1))
                     (+ INVADER-Y-SPEED (invader-y I1))
                     (invader-dx I1)) empty))

;(define (next-invader-list loi) loi) ;stub

(define (next-invader-list loi)
  (if (empty? loi) empty
      (cons (next-invader (first loi)) (next-invader-list(rest loi)))))

;; ===================================
;; Lose Game? List
;; ===================================
;; ListOfInvader -> Boolean
;; Checks if any of the invader in ListOfInvader hit the bottom screen
(check-expect (lose-list? LOI1) false)
(check-expect (lose-list? LOI2) true)

;(define (lose-list? loi) false) ;stub

(define (lose-list? loi)
  (cond [(empty? loi) false]
        [(invader-bottom?(first loi)) true]
        [else (lose-list? (rest loi))]))

;; ****************************************************************************************
;;                                     RENDER
;; ****************************************************************************************
;; ===================================
;; Invaders Render
;; ===================================
;; ListOfInvader -> Image
;; Render the Invaders in ListOfInvaders
(check-expect (render-invaders LOI0) BACKGROUND)
(check-expect (render-invaders LOI1)
              (place-image INVADER 150 100 BACKGROUND))

;(define (render-invaders loi) BACKGROUND);

(define (render-invaders loi)
  (if (empty? loi) BACKGROUND
      (place-image INVADER (invader-x (first loi)) (invader-y (first loi)) (render-invaders (rest loi)))))


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
    (to-draw   render)
    (stop-when lose-list?)))

;; ===================================
;; On Tick
;; ===================================
(define (next loi)
  (random-invader (next-invader-list loi)))

(define (render loi)
  (render-invaders loi))

(main LOI0)