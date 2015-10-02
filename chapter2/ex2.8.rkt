#lang racket
(require "ex2.7.rkt")


;; sub-interval
;; subtracts two intervals
(define (sub-interval x y)
  (make-interval (- (lower-bound x) (lower-bound y))
                 (- (upper-bound x) (upper-bound y))))

(provide sub-interval)
