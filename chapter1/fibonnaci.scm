#lang racket

(define (fib-recursive n)
  (if (or (= n 0) (= n 1))
      n
      (+ (fib-recursive (- n 1))
         (fib-recursive (- n 2)))))

(define (fib n)
  (fib-iter 0 1 n))

(define (fib-iter a b count)
  (if (= count 0)
      a
      (fib-iter (+ a b) a (- count 1)))
  )
  

