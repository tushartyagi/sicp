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

(define (element->list-recur type list-size lst)
  (cond
    ((= list-size 0) '())
    (else
     (cons type
           (element->list-recur type
                                 (- list-size 1)
                                 lst)))))

(define (element->list type size)
  (element->list-recur type size '()))

(define (nth index items)
  (cond
    ((empty? items) '())
    ((= 1 index) (car items))
    (else (nth (- index 1) (cdr items)))))

(define (index el items)
  (define (find-index el items idx)
    (cond ((empty? items) 0)          
          ((eq? el (car items)) idx)
          (else (find-index el (cdr items) (+ 1 idx)))))
  (find-index el items 1))

(define (apply-times fn n value)
  (if (= n 0)
      value
      (apply-times fn (- n 1)
                (fn value))))

(provide fold-right accumulate accumulate-n id square enumerate-interval)
(provide flatmap for-each memq element->list nth index apply-times)
;; (provide fold-right)
;; (provide flatmap)
;; (provide accumulate)
;; (provide accumulate-n)
;; (provide id)
;; (provide square)
;; (provide enumerate-interval)
;; (provide flatmap)
;; (provide for-each)
