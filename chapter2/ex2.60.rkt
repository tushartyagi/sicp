#lang racket
(require "operations.rkt")

(define empty-set '())
(define (empty-set? st)
  (empty? st))

(define (element-of-set? el st)
  (cond
    ((empty-set? st) false)
    ((equal? el (car st)) true)
    (else (element-of-set? el (cdr st)))))

;; Blindly add elements without checking
(define (adjoin-set el st)
  (cons el st))

;; check if the car of s1 is an element of s2,
;; and if it isn't, then add it to s2 
;; By using no-checking at the time of union, the cost of time
;; reduces to O(1), but the space would have increased by n
;; elements where n is the size of s1. This will have problems with
;; the intersection operation because it will now have to search
;; through a lot of extra elements if the unified set is used for
;; intersection with some other set.
(define (union-set s1 s2)
  (append s1 s2))


;; Since the set can now contain repeated elements, then in order to
;; find intersection it is required that the sets on which intersection
;; operation is to be done are unique in nature, that is, these should
;; not have any repeated elements.
;; There are trade-offs: either we can send two unique elements to the
;; intersection-set, or clear out the uniques values later (which will
;; be there becuase each value will be compared between the set multiple
;; times and will be added multiple times.
;; Or the third way will be to check while entering each value whether
;; it is already there and not insert it.
;; I didn't think about the last one before, and it came up while I was
;; writing this. In real world I would have compared the cons of the
;; three methods and see which has less space-time complexity.
(define (intersection-set s1 s2)
  (cond
    ((or (empty-set? s1)
         (empty-set? s2)) '())
    ((element-of-set? (car s1) s2) (adjoin-set
                                    (car s1)
                                    (intersection-set (cdr s1) s2)))
    (else
     (intersection-set (cdr s1) s2))))

(define (intersection-unique-sets s1 s2)
  (intersection-set (uniquilify s1)
                     (uniquilify s2)))

(define (intersection-then-pick-uniques s1 s2)
  (uniquilify (intersection-set s1 s2)))

(define (intersection-set-recur s1 s2 placeholder)
  (cond
    ((or (empty-set? s1)
         (empty-set? s2)) placeholder)

    ;; If the element is a common element of both s1 and s2
    ;; but is not in the placeholder, then add it over there.
    ;; We don't want duplicate elements in placeholder.
    ((and (element-of-set? (car s1) s2)
          (not (element-of-set? (car s1) placeholder)))
     (adjoin-set (car s1)
                 (intersection-set-recur (cdr s1)
                                         s2
                                         placeholder)))
    
    (else (intersection-set-recur (cdr s1) s2 placeholder))))

(define (intersection-set-3 s1 s2)
  (intersection-set-recur s1 s2 empty-set))

;; testing data

(define (uniquilify items)
  (foldl (lambda (current all)
           (if (element-of-set? current all)
               all
               (cons current all)))
         '() items))



(define test-set1 '(1 2 3 4))
(define test-set2 '(1 3 5 7))
(define test-set3 (enumerate-interval 1 10))
(define test-set12 (union-set test-set1 test-set2))

(intersection-set-3 test-set12 test-set3)
