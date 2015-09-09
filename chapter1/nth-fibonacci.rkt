#lang Racket
(require htdp/testing)

(define GOLDEN-RATIO 1.6180)

;; Number -> Number
;; Calculates the nth fibonacci number using the
;; golden ratio
;; This definition breaks for larger inputs because... float :/
(define (fibonacci n)
  (nearest-int (/ (expt GOLDEN-RATIO n)
                  (sqrt 5))))

(check-expect (fibonacci 0) 0.0)
(check-expect (fibonacci 1) 1.0)
(check-expect (fibonacci 2) 1.0)
(check-expect (fibonacci 3) 2.0)
(check-expect (fibonacci 6) 8.0)
(check-expect (fibonacci 7) 13.0)
(check-expect (fibonacci 15) 610.0)



;; Number -> Number
;; Finds the nearest integer
;; given 7.75, expect 8
;; given 7.25, expect 7
(define (nearest-int m)
  (cond
    ((< (- m (floor m)) 0.5) (floor m))
    (else (ceiling m))))

(check-expect (nearest-int 7.75) 8)
(check-expect (nearest-int 7.25) 7)
