#lang racket

(define (install-zero-package)
  (put '=zero? '(complex) 
       (lambda (x) (and (= (real x) 0)
                        (= (imag x) 0))))
  (put '=zero? '(rational)
       (lambda (x) (and (= (num x) 0))))
  (put '=zero? '(scheme-number) 
       (lambda (x) (= x 0))))
