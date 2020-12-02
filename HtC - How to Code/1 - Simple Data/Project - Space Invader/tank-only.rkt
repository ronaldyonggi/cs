;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname tank-only) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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

;; ****************************************************************************************
;;                                     RENDER
;; ****************************************************************************************

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
(define (main t)
  (big-bang t
    (on-tick   next)     
    (to-draw   render)
    (on-key handle-key)))

;; ===================================
;; On Tick
;; ===================================
(define (next t)
  (next-tank t))


;; ===================================
;; Render Everything
;; ===================================
(define (render t)
  (render-tank t))

;; ===================================
;; Key Handler
;; ===================================
(define (handle-key t ke)
  (cond [(key=? ke "left") (make-tank (tank-x t) -1)]
        [(key=? ke "right") (make-tank (tank-x t) 1)]))

        (main T0)