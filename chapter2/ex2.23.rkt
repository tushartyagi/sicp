#lang racket

;; for-each
;; like map, this iterates over a list, but just applies the function
;; without creating a list of the result.
(define (for-each f items)
  (cond ((not (null? items))
         (f (car items))
         (for-each f (cdr items)))))
