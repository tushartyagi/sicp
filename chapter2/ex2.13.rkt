#lang racket
(require "ex2.12.rkt")
(require "ex2.7.rkt")
(require "interval-arithmatic.rkt")

(define interval1 (make-center-width 3.5 0.10))
(define interval2 (make-center-width 4.7 0.10))

(define interval-product (mul-interval interval1 interval2))

;; The formula is that of addition
;; Till around 10% this is giving 2 places of precision
;; From 15 to around 35, it is giving 1 place of precision
(percent interval-product)
(+ (percent interval1) (percent interval2))
