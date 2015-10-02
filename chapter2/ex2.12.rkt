#lang racket
(require "ex2.7.rkt")
(require "interval-arithmatic.rkt")

;; make-center-percent
;; Takes in a center and a percentage and produces the desired interval
(define (make-center-percent c p)
  (make-interval (- c (* c p 0.01))
                 (+ c (* c p 0.01))))

;; percent
;; gives the percent of uncertainity of the interval
(define (percent x)
  (/ (* (- (upper-bound x) (lower-bound x)) 100)
     (* 2 (center x))))

(provide percent)
(provide make-center-percent)
