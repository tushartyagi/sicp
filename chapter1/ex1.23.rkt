#lang Racket

(define (start-prime-test n start-time)
  (if (prime? n)
      (report-prime n (- (current-inexact-milliseconds) start-time))
      false))
(define (report-prime n elapsed-time)
  (display n)
  (display " *** ")
  (display elapsed-time)
  (newline))

(define (updated-timed-prime-test n)
  (start-prime-test n (current-inexact-milliseconds)))
  
;; I spent a lot of time thinking that cond only allows one
;; expression per condition (because the indentation says so :/)
;; and since the book has not introduced
;; `progn` at this point, using it was out of question.
;; Looking around, I found that cond does allow using more than
;; one expression :/
(define (search-for-primes a b)
  (cond
    ((even? a) (search-for-primes (add1 a) b))
    (else
     (cond 
       ((< a b) (updated-timed-prime-test a) (search-for-primes (add1 a) b))
       (else (display "end"))))))

(define (smallest-divisor n)
  (find-divisor n 2))
(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (next test-divisor)))))
(define (divides? a b)
  (= (remainder b a) 0))

(define (next n)  
  (if (equal? (remainder n 2) 0)
      (+ n 2)
      n))

(define (prime? n)
  (display "***")
  (= (smallest-divisor n) n))

(define (square n) (* n n))

;; The output has reduced by almost half because the number of steps
;; per prime test has reduced by half. If previously it was trying to
;; find a prime amongst n numbers, now after removing even numbers we
;; only need to find these among n/2. Here are the times
;; ***10000000001 *** 47.001220703125
;; ***10000000003 *** 73.004150390625
;; ***10000000005 *** 41.002197265625
;; MEAN: 53 over previous 84. Ratio: 0.63
;;***100000000003 *** 162.00732421875
;; ***100000000019 *** 201.01123046875
;; ***100000000057 *** 147.008056640625
;; mean: 170 over previous 268. Ratio: 0.63
;; ***1000000000039 *** 535.031005859375
;; ***1000000000061 *** 465.027099609375
;; ***1000000000063 *** 497.0283203125
;; mean: 499 over previous 857. Ratio: 0.58
;; So we are getting around 40-50 percent reduction after cutting the
;; input by half.
;; Why not exactly 50? 
;; I guess this can be because of the new check if the number is even, or
;; adding 2 to the current number to keep the result from turning even.
