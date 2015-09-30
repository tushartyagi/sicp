#lang Racket
(require htdp/testing)

;; Number, Number -> N
;; Gets the value of N raised to some power by successive squaring
(define (expt b n)
  (fast-expt 1 b n))

;; Number, Number, Number -> Number
;; Keeps a state variable a along with the base b and
;; exponent e and calculates the value of base raised to the
;; power e.
(define (fast-expt a b e)
  (cond ((= 0 e) a)
        ((odd? e) (fast-expt (* a b)
                             b
                             (sub1 e)))
        ((even? e) (fast-expt (* a (fast-expt 1 b (halve e)))
                              b
                              (halve e)))))

(check-expect (expt 2 10) 1024)
(check-expect (expt 2 0) 1)
(check-expect (expt 4 4) 256)
(check-expect (expt 6 4) 1296)

;; Number -> Number
;; Returns the half of a number
(define (halve n)
  (/ n 2))


(define (slow-expt b n)
  (if (= n 0)
      1
      (* b (slow-expt b (- n 1)))))




