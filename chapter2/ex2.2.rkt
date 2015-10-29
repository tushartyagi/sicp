#lang racket
(require "ex2.1.rkt")

;; make-point
;; create point data
(define (make-point a b)
  (cons a b))

;; x-point
;; gets the x coordinate of a point
(define (x-point point)
  (car point))

;; y-point
;; gets the y coordinate of a point
(define (y-point point)
  (cdr point))

;; make-segment
;; creates a line segment
(define (make-segment start end)
  (cons start end))

;; start-segment
;; gets the starting point of the segment
(define (start-segment segment)
  (car segment))

;; end-segment
;; getst the end point of the segment
(define (end-segment segment)
  (cdr segment))

;; length-segment
;; gets the length of the line seg
(define (length-of-segment segment)
  (define (square x) (* x x))
  (let ((x1 (x-point (start-segment segment)))
        (x2 (x-point (end-segment segment)))
        (y1 (y-point (start-segment segment)))
        (y2 (y-point (end-segment segment))))
    (sqrt (+ (square (- x2 x1))
             (square (- y2 y1))))))


;; midpoint-segment
;; gets the midpoint of the line segment
(define (midpoint-segment segment)
  (define (average a b) (/ (+ a b) 2))
  (let ((midpoint-a (average (x-point (start-segment segment))
                             (x-point (end-segment segment))))
        (midpoint-b (average (y-point (start-segment segment))
                             (y-point (end-segment segment)))))
    (make-point midpoint-a midpoint-b)))

(provide make-segment start-segment end-segment length-of-segment)
(provide make-point)
