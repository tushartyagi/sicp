#lang racket

(define (cube x) (* x x x))

(define (p x) (- (* 3 x) (* 4 (cube x))))

(define (sine angle)
  (if (not (> (abs angle) 0.1))
      angle
      (p (sine (/ angle 3.0)))))

#|

b.The method is linear recursive in design, hence the number of steps required 
is theta(n), so is the memory requirement and time requirement.

|#
