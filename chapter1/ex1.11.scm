#lang racket

(define (f-recursive n)
  (cond ((< n 3) n)
        (else (+ (f-recursive (- n 1)) 
                 (* 2 (f-recursive (- n 2)))
                 (* 3 (f-recursive (- n 3)))))))


;;; I was struggling to solve this, and then I realised this is a lot
;;; like solving Fibonnaci series. :) 
(define (f-iterative a b c n)
  (if (= n 0)
      a
      (f-iterative b c  (+ c (* 2 b) (* 3 a)) (- n 1))))

(define (f n)
  (f-iterative 0 1 2 n))
         
