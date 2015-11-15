#lang racket

(require "accumulate.rkt")

;; accumulate-n
;; takes a sequence of sequence (all having same length) and
;; accumulates the result in same number of sequences
(define (accumulate-n op init seqs)
  (if (null? (car seqs))
      null
      (cons (accumulate op init (map car seqs))
            (accumulate-n op init (map cdr seqs)))))


(define s '((1 2 3)
            (4 5 6)
            (7 8 9)
            (10 11 12)))

