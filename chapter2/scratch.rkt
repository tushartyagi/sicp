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


(define (double-tree tree)
  (cond
    ((null? tree) null)
    ((not (list? tree))
     (* 2 tree))
    (else
     (cons (double-tree (car tree))
           (double-tree (cdr tree))))))

;; scale-tree
;; scales a tree
(define (scale-tree factor tree)
  (map (lambda (subtree)
         (if (pair? subtree)
             (scale-tree factor subtree)
             (* factor subtree)))
       tree))
