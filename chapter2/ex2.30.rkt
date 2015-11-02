#lang racket

;; scale-tree-recurse
;; scales a tree with a given factor
(define (scale-tree-recurse tree factor)
  (cond
    ((null? tree) null)
    ((not (pair? tree)) (* factor tree))
    (else (cons (scale-tree-recurse (car tree) factor)
                (scale-tree-recurse (cdr tree) factor)))))

;; scale-tree-with-map
;; scales the tree using map
;; In haskell, I defined a functor for the custom tree DS
;; The basic idea behind map is that it iterates over a list by following
;; the next pointer of each successive element.
;; (map foo (list 1 2 3 4)) will apply the function foo on 1 then follow the
;; next pointer to 2, apply foo, follow apply, follow apply, halt since the
;; next pointer for element 4 is null. That is the reason map won't work with
;; (cons 1 2) (improper list; dotted list) but will work with
;; (cons 1 (cons 2 null)).
;; When combined with recursion, we are moving forward and down. Forward using
;; the map function by following the next pointers, and down by recursing
;; over the sub-elements.
;; Inside each of the subtree, we are still using map to get from one element
;; to the next, i.e. among siblings.
;; So the movement is done by map, and actual manipulation is done by recursion.
;; Since map always creates a list, we are iterating through a list, and
;; creating one using map.
(define (scale-tree-with-map tree factor)
  (map (lambda (sub-tree)
         (if (pair? sub-tree)
             (scale-tree-with-map sub-tree factor)
             (* sub-tree factor)))
       tree))

;; square-tree-recurse
;; squares the value of each node
(define (square-tree-recurse tree)
  (cond ((null? tree) null)
        ((not (pair? tree)) (* tree tree))
        (else (cons (square-tree-recurse (car tree))
                    (square-tree-recurse (cdr tree))))))

;; square-tree-using-map
;; squares the tree
(define (square-tree-using-map tree)
  (map (lambda (sub-tree)
         (if (pair? sub-tree)
             (square-tree-using-map sub-tree)
             (* sub-tree sub-tree)))
       tree))



(define sample-tree (list 1 (list 2 (list 3 4) 5) (list 6 7)))

