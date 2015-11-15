#lang racket

(define (square x) (* x x))

(define (id x) x)

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define fold-right accumulate)

(define (accumulate-n op init seqs)
  (if (null? (car seqs))
      null
      (cons (accumulate op init (map car seqs))
            (accumulate-n op init (map cdr seqs)))))


(provide fold-right)
(provide accumulate)
(provide accumulate-n)
(provide id)
(provide square)
