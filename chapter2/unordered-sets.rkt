#lang racket
(require "operations.rkt")

(define empty-set '())
(define (empty-set? st)
  (empty? st))

(define (element-of-set? el st)
  (cond
    ((empty-set? st) false)
    ((equal? el (car st)) true)
    (else (element-of-set? el (cdr st)))))

(define (adjoin-set el st)
  (if (element-of-set? el st)
      st
      (cons el st)))

;; check if the car of s1 is an element of s2,
;; and if it isn't, then add it to s2 
(define (union-set s1 s2)
  (cond
    ((empty-set? s1) s2)
    ((element-of-set? (car s1) s2) (union-set (cdr s1) s2))
    (else
     (adjoin-set (car s1) (union-set (cdr s1) s2)))))

;; exact opposite of union-set
;; if the current element is in the other set, then add it to the
;; current intersection, else skip it
;; (define (intersection-set s1 s2)
;;   (cond
;;     ((empty-set? s1) s2)
;;     ((element-of-set? (car s1) s2) (adjoin-set
;;                                     (car s1)
;;                                     (intersection-set (cdr s1) s2)))
;;     (else
;;      (intersection-set (cdr s1) s2))))

(define (intersection-set-recur s1 s2 placeholder)
  (cond
    ((or (empty-set? s1)
         (empty-set? s2)) placeholder)

    ;; if the current element at the head of set1 is an element of s2
    ;; then add it to the placeholder set and continue with the rest
    ;; of the elements in s1
    ((element-of-set? (car s1) s2)
     (adjoin-set (car s1)
                 (intersection-set-recur (cdr s1)
                                         s2
                                         placeholder)))
    
    (else (intersection-set-recur (cdr s1) s2 placeholder))))

(define (intersection-set s1 s2)
  (intersection-set-recur s1 s2 empty-set))

;; testing data

(define test-set1 '(1 2 3 4))
(define test-set2 '(1 3 5 7))
(define test-set3 (enumerate-interval 1 10))

(provide empty-set? intersection-set element-of-set? adjoin-set)
