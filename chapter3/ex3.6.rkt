#lang racket

(define (rand proc)
  (define random-init (random 500000))
  (define (rand-update x) (random x))
  (let ((x random-init))
    (cond ((eq? proc 'reset)
           (lambda (new-init)
             (set! x new-init)))
          ((eq? proc 'generate)
           (begin
             (set! x (rand-update x))
             x))
          (else (error "Bad param provided")))))
