#lang racket
(require "ordered-sets.rkt")

;; In the best case scenario, the cost will be O(1) since the element
;; will be inserted at the first location. In the worst case the element
;; will be inserted at the last location, causing the cost to rise to O(n)
;; and in the average case, the element will be inserted at the middle
;; location, causing the cost to decrease to O(n/2), which is again O(n)
;; for all the technical reasons but is 50% more effective.

(define (adjoin-set el st)
  (if (< el (car st))
      (cons el st)
      (cons (car st)
            (adjoin-set el (cdr st)))))

