#lang racket

(define make-withdraw
  (lambda (initial-amount)
    ((lambda (balance)     ;; 1
       (lambda (amount)
         (if (>= balance amount)
             (begin (set! balance (- balance amount))
                    balance)
             "Insufficient funds")))
     initial-amount)))


;; The let expression changes to lambda at 1, and it is not a procedure
;; definition, but a procedure call, which is called with the initial amount,
;; sets the stage for the next procedure in line ~lambda (amount) expr~
