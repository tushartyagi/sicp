#|

For very small numbers, the difference will be very small, hence we'll screw up 
the calculation somehow: 0.000000025 fails the test.
For very large number -- with limited precision -- the difference will be 
small (this is what I suppose).

|#
;;; Takes in a previous value of guess and the current guess,
;;; if the previous guess is good enough, then we return the current guess
;;; because a lot has not changed between the two values,
;;; else we need to improve upon the previous one
(define  (sqrt-iter guess x)
  (if (good-enough-ratio? guess x)
      guess
      (sqrt-iter (improve guess x) x)))


;;; Keep a tab on how guess is being changed between the iteration, if it's
;;; a small fraction of previous value, then stop and return.
(define (good-enough?  guess x)
  (< (abs (- (square guess) x)) 0.00001))


;;; A guess is good enough if the ratio of the previous guess
;;; and the new one is very very small
(define (good-enough-ratio? guess x)
  (< (/ guess x) 0.0001))

(define (improve guess x)
  (average guess (/ x guess)))

(define (average x y)
  (/ (+ x y) 2))

(sqrt-iter 1.0 25.0)
