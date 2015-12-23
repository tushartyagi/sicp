#lang racket

(define (make-from-real-imag x y)
  (define (dispatch op)
    (cond ((eq? op 'real) x)
          ((eq? op 'imag) y)
          ((eq? op 'magnitude)
           (sqrt (+ (sqr x) (sqr y))))
          ((eq? op 'angle)
           (tan (/ y x)))
          (else
           (error "Unknown operation"))))
  dispatch)

(define (make-from-mag-ang r a)
  (define (dispatch op)
    (cond ((eq? op 'real) (* r (cos a)))
          ((eq? op 'imag) (* r (sin a)))
          ((eq? op 'magnitude) r)
          ((eq? op 'angle) a)
          (else
           (error "Unknown operation")))))

