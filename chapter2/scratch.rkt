#lang racket

(require "operations.rkt")

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


;; (accumulate append
;;             null
;;             (map (lambda (i) 
;;                    (map (lambda (j) (list i j))
;;                         (enumerate-interval 1 (- i 1))))
;;                  (enumerate-interval 1 )))


           
(map (lambda (i)
           (map (lambda (j) (list i j))
                (enumerate-interval 1 (- i 1))))
         (enumerate-interval 1 5))

;; To create permutations of a list:
;; For each item x in S, recursively generate the sequence of permutations of
;; S - x, and adjoin x to the front of each one. This yields, for each x in
;; S, the sequence of permutations of S that begin with x. Combining these
;; sequences for all x gives all the permutations of S

(define s '(1 2 3))

(define (permutations s)
  (if (null? s)
      (list null)
      (flatmap (lambda (current-element)
                 (map (lambda (j)
                        (cons current-element j))
                      (permutations (remove current-element s))))
               s)))

            (flatmap (lambda (i)
                       (map (lambda (j) (list i j))
                            (enumerate-interval 1 (- i 1)))
                       (enumerate-interval 1 6)))
