#lang racket

;;; linear recursive
(define (expt-recursive b n)
  (if (= n 0)
      1
      (* b (expt-recursive b (- n 1)))))

;;; linear iterative
(define (expt-iter product b n)
  (if (= n 0)
      product
      (expt-iter (* b product) b (- n 1))))


;;; logarithmic
(define (fast-expt b n)
  (cond ((= n 0) 1)
        ((even? n) (sqr (fast-expt b (/ n 2))))
        (else (* b (fast-expt n (- n 1))))))


(define (my-expt b n)
  (expt-iter 1 b n))

