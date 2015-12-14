#lang racket
(require "binary-tree-sets.rkt")
(require "ordered-sets.rkt")

;; Ouch! This when used with test-tree1 and test-tree2 creates
;; horrendously unbalanced tree.
;; Anyhow, using foldl this (which I consider clever) felt really nice.
(define (union-set-binary tree1 tree2)
  (cond
    ((empty? tree1) tree2)
    ((empty? tree2) tree1)
    (else 
     (let ((tree-list (tree->list-1 tree1)))
       (foldl (lambda (current tree)
                (adjoin-set-binary current tree))
              tree2 tree-list)))))

(define (intersection-set-binary tree1 tree2)
  (cond
    ((or (empty? tree1)
         (empty? tree2)) '())
    (else
     (let ((list1 (tree->list-2 tree1))
           (list2 (tree->list-2 tree2)))
       (let ((intersection-of-lists (intersection-set list1 list2)))
         (list->tree intersection-of-lists))))))

;; test-data
(define
  test-tree1
  (make-tree 6
             (make-tree 4
                        (make-tree 2 '() '())
                        (make-tree 5 '() '()))
             (make-tree 8
                        (make-tree 7 '() '())
                        (make-tree 9 '() '()))))

(define
  test-tree2
  (make-tree 15
             (make-tree 13
                        (make-tree 12 '() '())
                        (make-tree 14 '() '()))
             (make-tree 17
                        (make-tree 16 '() '())
                        (make-tree 18 '() '()))))

(define
  test-tree3
  (make-tree 10
             test-tree1
             '()))

(define test-tree4
  (make-tree 10
             '()
             test-tree2))

