#lang racket
(require "binary-tree-sets.rkt")
(require "operations.rkt")

;; This does a depth first walk of the tree, going to the leftmost leaf
;; of the tree and going to the entry, then to the right
(define (tree->list-1 tree)
  ;; (display tree)
  ;; (display "\n")
  (if (empty? tree)
      '()
      (append (tree->list-1 (left-branch tree))
              (cons (entry tree)
                    (tree->list-1 (right-branch tree))))))

;; As far as I can tell, this one is collecting the rightmost tree, then
;; cons that to the entry. If we encounter an empty left branch, which
;; will happen in the case of a leaf, then the entire tree is returned.
;; This is a tough call, will need to put pen to paper for this one.

;; Holy crap! I was so wrong.
;; This is a linear iterative process with recursion. There are two things
;; to understand here:
;; 1) The way functions are evaluated, since the arguments are evaluated
;; before the function call, the second argument of copy-to-list will always
;; be available before the call to left-branch is made. So next level's
;; elements are already copied to the result-lst of this level before a
;; call to left-branch is made. This result-list is also available to the left
;; branch's call, and when we hit a leaf, the result-list is updated with
;; the entry node and send upward. 
;; 2) The result list is send from one level to the next so it holds the data
;; for the next call. In this way the data (and the state of the function) is
;; saved.
(define (tree->list-2 tree)
  (define (copy-to-list tree result-list)
    ;; (display tree)
    ;; (display result-list)
    ;; (display "\n")
    (if (empty? tree)
        result-list
        (copy-to-list (left-branch tree)
                      (cons (entry tree)
                            (copy-to-list (right-branch tree)
                                          result-list)))))
  (copy-to-list tree '()))

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

(define e (enumerate-interval 1 10))

(provide tree->list-1 tree->list-2)
