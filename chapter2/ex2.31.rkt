#lang racket

;; tree-map
;; apply map over a tree structure
(define (tree-map f tree)
  (map (lambda (sub-tree)
         (if (pair? sub-tree)
             (tree-map f sub-tree)
             (f sub-tree)))
       tree))

(define square (lambda (x) (* x x)))

(define sample-tree (list 1 (list 2 (list 3 4) 5) (list 6 7)))
