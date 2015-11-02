#lang racket
(require "ex2.28.rkt")

;; make-branch
;; a branch has a length, and a structure (which is either a number for weight
;; or another binary mobile)
(define (make-branch length structure)
  (list length structure))

;; branch-length
(define (branch-length branch)
  (first branch))

;; branch-structure
(define (branch-structure branch)
  (second branch))

;; make-mobile
;; a binary-mobile is a structure with two branches, left and right
(define (make-mobile left right)
  (list left right))

;; left-branch
(define (left-branch mobile)
  (first mobile))

;; right-branch
(define (right-branch mobile)
  (second mobile))

;; total-weight
;; A branch can either have a weight or a mobile, in case it is a weight, add
;; it to the sum, else go inside and get the sum of this mobile and add.
(define (total-weight mobile)
  (if (empty? mobile)
      0
      (+ (branch-weight (left-branch mobile))
         (branch-weight (right-branch mobile)))))

;; if the structure of this branch is a list, therefore a mobile, then
;; find the weights of the left and right branches.
;; else the weight is the value of structure itself.
(define (branch-weight branch)
  (let ((structure (branch-structure branch)))
    (if (mobile? structure)
        (+ (branch-weight (left-branch structure))
           (branch-weight (right-branch structure)))
        structure)))

;; balanced?
;; a mobile is balanced if the torque applied by the left submobile is
;; equal to the torque of the right submobile and these submobiles are
;; themselves balanced
;; Where torque = length * weight
;; I am not sure about the balancing of only weights, this is a base case
;; which needs to be handled more gracefully, but as of now I am not able
;; to think of how to do it:
;; an empty mobile should be balanced
;; a simple weight should be balanced
(define (balanced? mobile)
  (cond ((empty? mobile) #t)
        ((weight? mobile) #t)
        ((and (= (torque (left-branch mobile))
                 (torque (right-branch mobile)))
              (balanced? (left-submobile mobile))
              (balanced? (right-submobile mobile))))
        (else #f)))

;; a structure is mobile if it is a list (and not a number), and something
;; which is not a mobile is a weight.
(define (mobile? structure)
  ;;(list? structure))
  (pair? structure))
(define (weight? structure)
  (not (mobile? structure)))

(define (left-submobile mobile)
  (branch-structure (left-branch mobile)))
(define (right-submobile mobile)
  (branch-structure (right-branch mobile)))

;; torque
;; gets the total torque of a branch 
(define (torque branch)
  (if (empty? branch)
      0
      (* (branch-length branch)
         (branch-weight branch))))

;; branches with just the weights
(define branch1 (make-branch 12 13))
(define branch2 (make-branch 2 4))

(define mob11 (make-mobile branch1 branch1))
(define mob12 (make-mobile branch1 branch2))
(define mob22 (make-mobile branch2 branch2))


(define branch3 (make-branch 3 mob11))
(define branch4 (make-branch 4 mob22))

(define mob (make-mobile branch3 branch4))

(define balanced-mob (make-mobile branch3 branch3))
