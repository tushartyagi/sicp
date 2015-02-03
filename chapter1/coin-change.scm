#lang racket

#|
How many ways are there to arrange coins of value a using different 
denominations?

Let's take the first case where we will use some denomination d
* The amount remaining is a-d
* We can use all the denominations to arrange a-d now

The second case covers the remaining case, and doesn't use the denomination d
because it has already been covered in first case. Here we simply use every 
denomination except d to arrange a. 
|#

(define (count-change amount)
  (cc amount 5))

(define (first-denomination kinds-of-coins)
  (cond ((= kinds-of-coins 1) 1)
        ((= kinds-of-coins 2) 5)
        ((= kinds-of-coins 3) 10)
        ((= kinds-of-coins 4) 25)
        ((= kinds-of-coins 5) 50)))


(define (cc amount kinds-of-coins)
  (cond ((= amount 0) 1)
        ((or (< amount 0) (= kinds-of-coins 0)) 0)
        (else (+ (cc amount (- kinds-of-coins 1))
                 (cc (- amount (first-denomination kinds-of-coins)) 
                     kinds-of-coins)))))



