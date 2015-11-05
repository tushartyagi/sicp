#lang racket

;; horner-eval
;; for calculating the value of a polynomial at x
;; Let's not pretend that accumulate isn't foldr,
;; this saves me one import
(define (horner-eval x coefficient-sequence)
  (foldr (lambda (this-coeff higher-terms)
           (+ (* higher-terms x)
              this-coeff))
         0
         coefficient-sequence))
