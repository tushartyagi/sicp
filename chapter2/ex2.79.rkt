#lang racket

(define (install-equ-package)
  (put 'equ? '(complex complex)
       (lambda (x y) (and (= (real x) (real y))
                          (= (imag x) (imag y)))))
  (put 'equ? '(rational rational)
       (lambda (x y) (and (= (num x) (num y))
                          (= (den x) (den y)))))
  (put 'equ? '(scheme-number scheme-number)
       (lambda x y) (= x y)))
