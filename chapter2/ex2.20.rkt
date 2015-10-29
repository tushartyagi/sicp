#lang racket

;; dotted tail notation -- there's a dot before the last parameter and
;; the last parameter will have all the remaining arguments.

;; f
;; dotted tail
(define (f x y . z)
  (display z))


(define (same-parity parity . others)
  (if (odd? parity)
      (filter odd? (cons parity others))
      (filter even? (cons parity others))))
