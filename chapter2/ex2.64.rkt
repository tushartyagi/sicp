#lang racket
(require "binary-tree-sets.rkt")

(define (list->tree elements)
  (car (partial-tree elements (length elements))))

;; This procedure works because when given a list of elements
;; it finds the middle element, then finds all the elements before and
;; after it, creates subtrees from these elements and creates a tree
;; out of these three element's sets.
(define (partial-tree elts n)
  (if (= n 0)
      (cons '() elts)
      (let ((left-size (quotient (- n 1) 2)))
        (let ((left-result (partial-tree elts left-size)))
          (let ((left-tree (car left-result))
                (non-left-elts (cdr left-result))
                (right-size (- n (+ left-size 1))))
            (let ((this-entry (car non-left-elts))
                  (right-result (partial-tree (cdr non-left-elts)
                                              right-size)))
              (let ((right-tree (car right-result))
                    (remaining-elts (cdr right-result)))
                (cons (make-tree this-entry left-tree right-tree)
                      remaining-elts))))))))

;; For a size of n, the procedure creates 2 recursive sub-procedures of size
;; n/2 and this goes on until we have m lists of size 0, at which point the
;; procedure moves back, creating one tree from each call.
;; If the number of elements in a list are doubled, the number of recursive
;; calls are also doubled. So the procedure is proportional to n. O(n).
