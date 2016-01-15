#lang racket

(define (make-account balance secret-password)
  (define (withdraw amount)
    (if (>= balance amount)
        (begin (set! balance (- balance amount))
               balance)
        (error "Insufficient funds")))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (define (dispatch name)
    (cond ((eq? name 'withdraw) withdraw)
          ((eq? name 'deposit) deposit)
          (else (error "Invalid option"))))
  (define (checker password operation)
    (cond ((eq? password secret-password)
           (if (eq? operation 'make-joint)
               dispatch
               (dispatch operation)))
          (else (error "Incorrect password"))))
  checker)

;; make-joint should allow user to access the dispatch operation
;; of the given account, but the password checking mechanism should
;; be outside of that account.
(define (make-joint account account-pass new-pass)
  (let ((core-account (account account-pass 'make-joint)))
    (lambda (password operation)
      (cond ((eq? password new-pass)
             (core-account operation))
            (else (error "Incorrect password"))))))
