#lang racket

(define (square x) (* x x))

(define (id x) x)

(define (for-each f elems)
  (cond
    ((null? elems) null)
    ((null? (cdr elems)) (f (car elems)))
    (else (f (car elems))
          (for-each f (cdr elems)))))

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

(define (enumerate-interval low high)
  (if (> low high)
      null
      (cons low
            (enumerate-interval (+ low 1) high))))

(define (flatmap proc seq)
  (accumulate append null (map proc seq)))

(define (memq symbol items)
  (cond
    ((empty? items) '())
    ((eq? symbol (car items)) items)
    (else (memq symbol (cdr items)))))

(provide fold-right accumulate accumulate-n id square enumerate-interval)
(provide flatmap for-each memq)
;; (provide fold-right)
;; (provide flatmap)
;; (provide accumulate)
;; (provide accumulate-n)
;; (provide id)
;; (provide square)
;; (provide enumerate-interval)
;; (provide flatmap)
;; (provide for-each)
