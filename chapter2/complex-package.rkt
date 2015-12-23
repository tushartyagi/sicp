#lang racket

(define (install-complex-package)
  ;; internal procedures
  ;;; constructors
  ;;; This is teh internal representation, storing the number
  ;;; as having made up of real and imag parts, the magnitude and
  ;;; angle are calculated on need basis.
  (define (make-from-real-imag x y)
    (cons x y))
  (define (make-from-mag-ang r a)
    (cons (* r (cos a))
          (* r (sin a))))
  (define (real c)
    car c)
  (define (imag c)
    cdr c)
  (define (magnitude c)
    (sqrt (+ (sqr (real c))
             (sqr (imag c)))))
  (define (angle c)
    (tan (/ (imag c) (real c))))

  (define (add c1 c2)
    (make-from-real-imag (+ (real c1) (real c2))
                         (+ (imag c1) (imag c2))))
  
  ;; interface
  (define (tag x) (cons 'complex x))
  (put 'add '(complex complex)
       (lambda c1 c2) (tag (add c1 c2)))
  (put 'make-from-real-imag 'complex
       (lambda x y) (tag (make-from-real-imag x y)))
  (put 'make-from-mag-ang 'complex
       (lambda r a) (tag (make-from-mag-ang r a)))
  'done)
