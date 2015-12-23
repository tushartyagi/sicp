#lang racket

(define (install-scheme-number)
  ;; internal procedures

  ;; interface to the rest of the system
  (define (tag x) (cons 'scheme-number x))
  (define (add)
    (lambda x y) (+ x y))
  (define (sub)
    (lambda x y) (- x y))

  (put 'add '(scheme-number scheme-number) (tag add))
  (put 'sub '(scheme-number scheme-number) (tag sub))
  (put 'make 'scheme-number
       (lambda (x) (tag x))))
