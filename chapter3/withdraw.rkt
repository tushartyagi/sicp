#lang sicp

;; make-withdrawal
;; stateful function
(define (make-withdrawal balance)
  (lambda (amount)
    (if (< amount balance)
        (begin (set! balance (- balance amount))
               balance)
        "Insufficient funds")))
