#lang racket

(define x (cons (list 1 2) (list 3 4)))

;; count-leaves
;; iterates through a tree structure and counts the number of leaves in it
;; if the car is a list, then count it and add to the count-leaves of cdr
;; else add 1 to the count-leaves of cdr
(define (count-leaves tree)
  (cond
    ((null? tree) 0)
    ((not (pair? tree)) 1)
    (else (+ (count-leaves (car tree))
             (count-leaves (cdr tree))))))
