#lang racket
(require "ex2.2.rkt")

;; make-rect
;; creates a rectangle using 2 segments
(define (make-rect l b)
  (cons l b))

;; get-length
;; gets the length side of the rect
(define (get-length-segment rect)
  (car rect))

;; get-breadth
;; gets the breadth side of the rect
(define (get-breadth-segment rect)
  (cdr rect))


;; perimeter
;; gets the perimeter of rect
(define (perimeter rect)
  (* 2 (+ (length-of-segment (get-length-segment rect))
          (length-of-segment (get-breadth-segment rect)))))

;; area
;; gets the area of the rect
(define (area rect)
  (* (length-of-segment (get-length-segment rect))
     (length-of-segment (get-breadth-segment rect))))


(define length (make-segment (make-point 0 0) (make-point 5 0)))
(define breadth (make-segment (make-point 0 0) (make-point 0 3)))

(define rect1 (make-rect length breadth))
(perimeter rect1)
(area rect1)

