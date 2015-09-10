#lang Racket
(require "prime-number.rkt")

(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (current-inexact-milliseconds)))
(define (start-prime-test n start-time)
  (if (prime? n)
      (report-prime n (- (current-inexact-milliseconds) start-time))
      false))
(define (report-prime n elapsed-time)
  (display n)
  (display " *** ")
  (display elapsed-time)
  (newline))

;; The previous function displays too much information,
;; and all the tests take 0 milliseconds
;; refactoring it
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

;; We can use (time (search-for-primes a b)) to get the time
;; The 3 smallest primes
;; > 1000: (search-for-primes 1000 10000): 1009, 1013, 1019
;; cpu time: 0 real time: 371 gc time: 0
;; > 10000: (search-for-primes 10000 19000): 10007, 10009, 10037
;; cpu time: 16 real: 776: gc: 0
;; > 100000: (search-for-primes 100000 109000): 100003, 100019, 100043
;; cpu: 47 real: 557 gc: 0
;; > 1000000: (search-for-primes 1000000 1009000): 1000003, 1000033, 1000037
;; cpu: 31 real: 569: gc; 0
;; The problem is that the computer is too fast for this algorithm,
;; and for this range. Looking at the data it seems that almost 99% of
;; the individual calculation take 0 ms even though I am using the slow
;; prime method.

;; > 10**10 for 1000 values: 
;; (time (search-for-primes (expt 10 10) (+ (expt 10 10) 1000)))
;; 10000000019 *** 74.003662109375
;; 10000000033 *** 105.005859375
;; 10000000061 *** 76.004638671875
;; cpu: 3812 real: 3912 gc: 78
;; > 10**11 for 1000 values
;; (time (search-for-primes (expt 10 11) (+ (expt 10 11) 1000)))
;; 100000000003 *** 275.014892578125
;; 100000000019 *** 263.01513671875
;; 100000000057 *** 267.01513671875
;; cpu time: 13485 real time: 13820 gc time: 108
;; > 10**12 for 1000 values
;; 1000000000039 *** 857.049560546875
;; 1000000000061 *** 861.049072265625
;; 1000000000063 *** 853.048828125
;; (time (search-for-primes (expt 10 12) (+ (expt 10 12) 1000)))
;; cpu time: 34484 real time: 34648 gc time: 327

;; Here I am able to see that with an increase in input values for a
;; factor of 10, the time taken increase by (sqrt 10)
;; 10**10 : 10**11 = 84 : 268 and 265 = (* 84  (sqrt 10))
;; 10**11 : 10**12 = 268: 857 and 847 = (* 268 (sqrt 10))
