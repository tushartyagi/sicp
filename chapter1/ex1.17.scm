#lang racket
(require htdp/testing)

(define (mul a b)
  (if (= b 0)
      0
      (+ a (mul a (- b 1)))))

(define (double a)
  (+ a a))

(define (halve a)
  (/ a 2))

(define (even? a)
  (= (remainder a 2) 0))

;;; Just like fast-expt procedure given in the book, this one
;;; depends on the fact that calculating a number from its half
;;; only requires a single multiplication. This can be made 
;;; even faster if we are memoizing the value in halve method.
(define (fast-mul a b)
  (cond ((= b 0) 0)
        ((even? a) (double (fast-mul (halve a) b)))
        (else (+ a (fast-mul a (- b 1))))))
  

(check-expect (fast-mul 2 4) 8)
(check-expect (fast-mul 8 8) 64)
