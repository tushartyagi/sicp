#lang racket

;; accumulate takes in a binary function and applies it inside out on the
;; sequence, i.e. the start value and last value of the sequence become
;; the parameters of the first call to f:
;; (f 1 (f 2 (f 3 (f 4 start))))
;; this is foldr
(define (accumulate f start sequence)
  (if (null? sequence)
      start
      (f (car sequence)
         (accumulate f start (cdr sequence)))))

(define (map p sequence)
  (accumulate (lambda (x y) (if (p x)
                                (cons x y)
                                y)) null sequence))

(define (append seq1 seq2)
  (accumulate cons seq2 seq1))


(define (length sequence)
  (accumulate (lambda (x y) (+ y 1)) 0 sequence))
