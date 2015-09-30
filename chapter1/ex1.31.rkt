#lang Racket

(define (product term a next b)
  (if (> a b)
      1
      (* (term a)
         (product term (next a) next b))))

(define (identity x) x)
(define (inc x) (+ x 1))

(define (factorial n)
  (product identity 1 inc n))

(define (calc-pi)
  (define (square x) (* x x))
  (define (next n) (+ n 2))
  (define (term n)
    (/ (* n (+ n 2))
       (square (+ n 1.0))))
  (* 4
     (product term 2 next 480)))

(calc-pi)
