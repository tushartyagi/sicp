#lang racket

(define (factorial-recursive n)
  (if (= n 1)
      1
      (* n (factorial-recursive (- n 1)))))

(define (factorial-iter product n)
  (if (= n 1)
      product
      (factorial-iter (* product n) (- n 1))))


(define (factorial n)
  (factorial-iter 1 n))

(factorial 12)


  
