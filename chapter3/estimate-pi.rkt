#lang racket
(require "monte-carlo.rkt")

(define (estimate-pi trials)
  (sqrt (/ 6 (monte-carlo trials cesaro-test))))

(define (rand)
  (random 429333333))

(define (cesaro-test)
  (= (gcd (rand) (rand)) 1))

(estimate-pi 5000000)
