#lang racket

;; accumulate : combiner null-value term a next b -> Any
;; Uses the combiner function to add the value from low index a to high index b
(define (accumulate combiner null-value term a next b)
  (if (> a b)
      null-value
      (combiner (term a)
                (accumulate combiner null-value term (next a) next b))))


;; sum
;; sums values from a to b
(define (inc a) (+ 1 a))
(define (id x) x)

(define (sum a b)
  (accumulate + 0 id a inc b))

;; product
;; a product function from a to b
(define (product a b)
  (accumulate * 1 id a inc b))
