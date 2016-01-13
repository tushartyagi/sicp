#lang racket

;; Definitions. The type info will be automatically stripped by the
;; apply-generic procedure
(define (raise-int-to-rational int)
  (make-rational value 1))

(define (raise-rational-to-real rat)
  (let ((n (numer rat))
        (d (denom rat)))
    (make-real (/ n (* d 1.0)))))

(define (raise-real-to-complex real)
  (make-complex-from-real-imag real 0))

;; installation
(put 'raise 'int
     (lambda (x) (attach-tag 'rational (raise-int-to-rational x))))
(put 'raise 'rational
     (lambda (x) (attach-tag 'real (raise-rational-to-real x))))
(put 'raise 'real
     (lambda (x) (attach-tag 'complex (raise-real-to-complex x))))
