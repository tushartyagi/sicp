#lang racket

(define (square x) (* x x ))

(define (good-enough?  guess x)
  (< (abs (- (* (square guess) guess) x)) 0.00001))

(define (improve guess x)
  (/ (+
      (/ x (square guess))
      (* 2 guess))
     3))

(define (cube-iter guess x)
  (if (good-enough? guess x)
      guess
      (cube-iter (improve guess x) x)))

(define (cube-root x)
  (cube-iter 1.0 x))
