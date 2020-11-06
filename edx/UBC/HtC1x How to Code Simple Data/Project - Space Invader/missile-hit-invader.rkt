;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname missile-hit-invader) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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

(define HIT-RANGE 10)

(define BACKGROUND (empty-scene WIDTH HEIGHT))

(define MISSILE-SPEED 10)

(define MISSILE (ellipse 5 15 "solid" "red"))

(define INVADER
  (overlay/xy (ellipse 10 15 "outline" "blue")              ;cockpit cover
              -5 6
              (ellipse 20 10 "solid"   "blue")))            ;saucer

;; =========================================================================================================================
;;                                       DATA DEFINITIONS
;; =========================================================================================================================

;; ===================================
;; Game Struct
;; ===================================
(define-struct game (invaders missiles))

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

;; Template rules used:
;; - one of: 2 cases
;;   - atomic distinct: empty
;;   - compound: (cons invader ListofInvader)
;; - reference: (first loi) is invader
;; - self reference: (rest loi) is ListOfInvader

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
;; Checks if an invader about to hit right border screen
;; =========================================================================
;; invader -> Boolean
;; checks whether an invader is about to hit the right edge of the screen
(check-expect (invader-right? (make-invader 120 100 12)) false)
(check-expect (invader-right? (make-invader (- WIDTH 1) 100 12)) true)

;(define (invader-right? i) false) ;stub

(define (invader-right? i)
  (and
   (> (invader-dx i) 0)
   (> (+ (invader-x i) (invader-dx i)) WIDTH)))


;; =========================================================================
;; Checks if an invader about to hit left border screen
;; =========================================================================
;; invader -> Boolean
;; checks whether an invader is about to hit the left edge of the screen
(check-expect (invader-left? (make-invader 120 100 -12)) false)
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
(check-expect (invader-bottom? (make-invader 1 100 -12)) false)
(check-expect (invader-bottom?(make-invader 1 HEIGHT 10)) true)

;(define (invader-bottom? i) false) ;stub

(define (invader-bottom? i)
  (>= (invader-y i) HEIGHT))

;; =========================================================================
;; Checks if a missile is hitting an invader
;; =========================================================================
;; invader missile -> boolean
;; checks whether an invader is within hit range of a missile
(check-expect (hit-missile?
               (make-missile 150 100)
               (make-invader 150 98 12)) true)

(check-expect (hit-missile?
               (make-missile 150 100)
               (make-invader 150 20 12)) false)

;(define (hit-missile? m i) false); stub

(define (hit-missile? m i)
  (and
   (> (missile-y m) (invader-y i))
   (<= (abs (- (invader-x i) (missile-x m))) HIT-RANGE)
   (<= (abs(- (missile-y m) (invader-y i))) HIT-RANGE)))

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
;; Checks if any invader in LOI hits bottom
;; ===================================
;; ListOfInvader -> Boolean
;; Checks if any of the invader in ListOfInvader hit the bottom screen
(check-expect (any-bottom? LOI1) false)
(check-expect (any-bottom? LOI2) true)

;(define (any-bottom? loi) false) ;stub

(define (any-bottom? loi)
  (cond [(empty? loi) false]
        [(invader-bottom?(first loi)) true]
        [else (any-bottom? (rest loi))]))

;; ===================================
;; Lose Game?
;; ===================================
;; ListOfInvader -> Boolean
;; Takes in a game, check the lose-game condition

(define (lose-game? g) (any-bottom? (game-invaders g)))

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
;;                                    MISSILE HIT INVADER
;; ****************************************************************************************

;; ===================================
;; Filter Invader List 
;; ===================================
;; missile ListOfInvader -> ListOfInvader
;; Consumes a missile and a ListOfInvader. Produces the list without the invader that got
;; hit by the missile.
(check-expect (filter-invader
               (make-missile 150 100)
               (list (make-invader 150 120 12) (make-invader 200 200 -12)))
              (list (make-invader 150 120 12) (make-invader 200 200 -12)))

(check-expect (filter-invader
               (make-missile 150 100)
               (list (make-invader 150 90 12) (make-invader 200 200 -12)))
              (list (make-invader 200 200 -12)))
;(define (filter-invader m loi) loi);stub

(define (filter-invader m loi)
  (cond [(empty? loi) empty]
        [(hit-missile? m (first loi)) (filter-invader m (rest loi))]
        [else (cons (first loi) (filter-invader m (rest loi)))]))

;; ===================================
;; Filter Invader List with ListOfMissile
;; ===================================
;; ListOfMissile ListOfInvader -> ListOfInvader
;; Filters ListOfInvader with ListOfMissile
(check-expect (filter-invader-list
               (list (make-missile 150 100) (make-missile 200 275))
               (list (make-invader 150 90 12) (make-invader 100 175 -12)))
              (list (make-invader 100 175 -12)))

(check-expect (filter-invader-list
               (list (make-missile 150 200) (make-missile 200 275))
               (list (make-invader 150 90 12) (make-invader 100 175 -12)))
              (list (make-invader 150 90 12)(make-invader 100 175 -12)))

;(define (filter-invader-list lom loi) loi);stub

(define (filter-invader-list lom loi)
  (cond [(empty? lom) loi]
        [(empty? loi) empty]
        [else (filter-invader-list (rest lom) (filter-invader (first lom) loi))]))

;; ===================================
;; Filter Invader List game
;; ===================================
;; game -> loi
(define (filter-invader-game g)
  (filter-invader-list (game-missiles g) (game-invaders g)))

;; ===================================
;; Filter Missile List 
;; ===================================
;; invader ListOfMissile -> ListOfMissile
;; Consumes an invader and a ListOfMissile. Produces the list without the missile that
;; hit an invader.
(check-expect (filter-missile
               (make-invader 150 90 12)
               (list (make-missile 150 100) (make-missile 200 275)))
              (list (make-missile 200 275)))

(check-expect (filter-missile
               (make-invader 150 120 -13)
               (list (make-missile 150 100) (make-missile 200 275)))
              (list (make-missile 150 100) (make-missile 200 275)))
              

;(define (filter-missile i lom) lom);stub

(define (filter-missile i lom)
  (cond [(empty? lom) empty]
        [(hit-missile? (first lom) i) (filter-missile i (rest lom))]
        [else (cons (first lom) (filter-missile i (rest lom)))]))

;; ===================================
;; Filter Missile List with ListOfInvader
;; ===================================
;; ListOfInvader ListOfMissile -> ListOfMissile
;; Filters ListOfMIssile with ListOfInvader
(check-expect (filter-missile-list
               (list (make-invader 150 120 12) (make-invader 90 65 -12))
               (list (make-missile 150 100) (make-missile 200 275)))
              (list (make-missile 150 100) (make-missile 200 275)))

(check-expect (filter-missile-list
               (list (make-invader 150 120 12) (make-invader 90 65 -12))
               (list (make-missile 150 128) (make-missile 200 275)))
              (list  (make-missile 200 275)))

;(define (filter-missile-list loi lom) lom);stub

(define (filter-missile-list loi lom)
  (cond [(empty? loi) lom]
        [(empty? lom) empty]
        [else
         (filter-missile-list
          (rest loi)
          (filter-missile (first loi) lom))]))

;; ===================================
;; Filter Missile List Game
;; ===================================
;; game -> lom
(define (filter-missile-game g)
  (filter-missile-list (game-invaders g) (game-missiles g)))

;; ****************************************************************************************
;;                                   UPDATE EVERYTHING AFTER TICK
;; ****************************************************************************************
;; game -> loi
(define (update-invaders g)
  (random-invader
   (filter-invader-list
   (next-missile-list (game-missiles g))
   (next-invader-list (game-invaders g)))))

;; game -> lom
(define (update-missiles g)
  (filter-missile-list
   (next-invader-list (game-invaders g))
   (next-missile-list (game-missiles g))))
  
  

;; ****************************************************************************************
;;                                     RENDER
;; ****************************************************************************************
;; ===================================
;; Invaders Render
;; ===================================

(define (render-invaders loi img)
  (if (empty? loi) img
      (place-image INVADER (invader-x (first loi)) (invader-y (first loi)) (render-invaders (rest loi) img))))

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
(define (main g)
  (big-bang g
    (on-tick   next)     
    (to-draw   render)
    (stop-when lose-game?)))

;; ===================================
;; On Tick
;; ===================================
(define (next g)
  (make-game (update-invaders g) (update-missiles g)))

(define (render g)
  (render-invaders (game-invaders g)
                   (render-missiles (game-missiles g))))

(main (make-game
       (list (make-invader 150 50 0))
       (list (make-missile 150 200) (make-missile 100 298) (make-missile 37 250))))
