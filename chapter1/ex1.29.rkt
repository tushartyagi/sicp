#lang Racket
(require "sum.rkt")

(define (cube x) (* x x x))

(define (simpson-rule f a b n)
  (define h (/ (- b a) n))
  (define (y k) (f (+ a (* k h))))
  (define (term i)
    (if (= (remainder i 2) 0)
        (* 2 (y i))
        (* 4 (y i))))
  (define (next i) (+ i 1))
  (* (/ h 3)
     (+ (y 0)
        (y n)
        (sum term 1 next (- n 1) ))))


(simpson-rule cube 0 1 10.0)
(simpson-rule cube 0 1 100.0) 
(simpson-rule cube 0 1 1000.0)
(simpson-rule cube 0 1 2000.0) 
