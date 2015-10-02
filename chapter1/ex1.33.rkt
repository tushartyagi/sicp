#lang racket
(require "prime-number.rkt")

(define (filtered-accumulate combiner null-value filter term a next b)
  (cond ((> a b) null-value)
        ((filter (term a))
         (combiner (term a)
                   (filtered-accumulate combiner null-value filter term (next a) next b)))
        (else (filtered-accumulate combiner null-value filter term (next a) next b))))


;; sum
;; sums values from a to b
(define (inc a) (+ 1 a))
(define (id x) x)
(define (even? a) (= (remainder a 2) 0))
(define (square a) (* a a))

(define (sum-even a b)
  (filtered-accumulate + 0 even? id a inc b))

;; product
;; a product function from a to b
;; (define (product a b)
;;   (accumulate * 1 id a inc b))


;; sum-squared-prime
;; takes the sum of the squares of prime number between a and b
(define (sum-squared-prime a b)
  (filtered-accumulate + 0 prime? square a inc b))
