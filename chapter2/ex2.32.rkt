#lang racket

;; subsets
;; creates subsets out of a list

;; While I went around on the internet trying to find the
;; solution to this problem, I read the basic theory behind the
;; recursive definition of subsets in the solution of bill the lizard.
;; From there (without looking at how he implemented) moved to the
;; definition at wikipedia and implemented the solution here.
;; I didn't know powerset had this definition :(

;; Union of the power-set not containing the chosen element,
;; i.e. (car s) with the element (car s) added in each of the
;; subset of the remaining elements, i.e. (cdr s) are the
;; remaining elements, (subsets (cdr s)) are the subsets of
;; all the remaining elements.
(define (subsets s)
  (if (null? s)
      (list null)
      (let ((rest (subsets (cdr s))))
        (append rest (map (lambda (subset) (cons (car s) subset))
                          rest)))))
