#lang racket

;; last-pair
;; gives the last element of a non empty list
(define (last-pair l)
  (if (null? (cdr l))
      (car l)
      (last-pair (cdr l))))

(last-pair (list 1 2 3 4 5))
