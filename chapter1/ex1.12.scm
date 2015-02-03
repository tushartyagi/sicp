#lang racket

;;; Pascal's Triangle
;;; P(n, m) = P(n - 1, m - 1) + P(n - 1, m) | n, m  > 0
(define (pt n m)
  (cond ((= m 1) 1)
        ((= n m) 1)
	((< n m) -1)
        (else (+ (pt (- n 1) (- m 1))
                 (pt (- n 1) m )))))
