#lang racket

;; make-interval
;; procedure to allow us to do interval arithmatic
(define (make-interval a b)
  (cons a b))


;; upper-bound
;; gets the upper bound of the interval
(define (upper-bound x)
  (car x))


;; lower-bound
;; gets the lower bound of the interval
(define (lower-bound x)
  (cdr x))

(provide make-interval)
(provide upper-bound)
(provide lower-bound)
