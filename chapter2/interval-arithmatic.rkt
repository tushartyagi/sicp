#lang racket
(require "ex2.7.rkt")
(require "ex2.8.rkt")

;; add-interval
;; adds two intervals
(define (add-interval x y)
  (make-interval (+ (lower-bound x) (upper-bound y))
                 (+ (upper-bound x) (upper-bound y))))

;; mul-interval
;; multiplies two intervals
(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))

;; div-interval
;; divides two intervals
(define (div-interval x y)
  (mul-interval x
                (make-interval (/ 1.0 (upper-bound y))
                               (/ 1.0 (lower-bound y)))))

;; make-center-width
;; makes the interval when center and width are given, like c +- w
(define (make-center-width c w)
  (make-interval (- c w) (+ c w)))

;; center
;; gets the center from interval
(define (center i)
  (/ (+ (upper-bound i) (lower-bound i))
     2))

;; width
;; gets the width of an interval
(define (width i)
  (/ (- (upper-bound i) (lower-bound i))
     2))

(provide make-center-width)
(provide center)
(provide add-interval)
(provide mul-interval)
(provide div-interval)
