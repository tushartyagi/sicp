#lang racket
(require "../chapter1/gcd.rkt")
;; make-rat
;; the function which handles both positive and negative
;; numbers
(define (make-rat n d)
  (define (create-rat n d)
    (cons n d))
  (let ((g (gcd n d)))
    (if (> (* n d) 0)
        (create-rat (abs (/ n g))
                    (abs (/ d g)))
        (create-rat (- (abs (/ n g)))
                    (abs (/ d g))))))


(provide make-rat)
