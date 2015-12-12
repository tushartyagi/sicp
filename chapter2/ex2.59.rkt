#lang racket
(require "unordered-sets.rkt")

(define (union-set s1 s2)
  (cond
    ((empty-set? s1) s2)
    ((element-of-set? (car s1) s2) (union-set (cdr s1) s2))
    (else
     (adjoin-set (car s1) (union-set (cdr s1) s2)))))
