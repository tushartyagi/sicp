#lang racket
(require "monte-carlo.rkt")

;; This will give the area of the circle
(define (estimate-integral P x1 x2 y1 y2 trials)
  (define (area-rect)
    (abs (* (- x2 x1) (- y2 y1))))
  (define (rect-test)
    (lambda ()
      (let ((x (random-in-range x1 x2))
            (y (random-in-range y1 y2)))
        (P x y))))
  (* (area-rect)
     (monte-carlo trials (rect-test))))

(define (create-circle-predicate x0 y0 r)
  (lambda (x y)
    (<= (+ (sqr (- x0 x))
           (sqr (- y0 y)))
        (sqr r))))

(define (random-in-range low high)
  (+ low
     (* (random) high)))

(define P (create-circle-predicate 5 7 3))
(define unit-pred (create-circle-predicate 0 0 1))

;; Taking the values as given in the book
;; Since estimate-integral gives area of a circle, need to divide this by
;; (sqr r) to get pi
(estimate-integral unit-pred 1.0 -1.0 1.0 -1.0 1000000)
(/ (estimate-integral P 2 8 4 10 1000000)
   (sqr 3.0))

;; The biggest problem I face here is that the estimate-integral just doesn't
;; work with anything other than unit circle and unit square. I calculate the
;; area of the circle and divide it by (sqr r) but this gives some value which
;; isn't pie. 
   
