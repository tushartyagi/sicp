#lang racket
(require "operations.rkt")

(define (element-of-set? x st)
  (let ((current (car st)))
    (cond
      ((null? st) false)
      ((< x current) false)
      ((= x current) true)
      ((> x current) (element-of-set? x (cdr st))))))

;; (define (intersection-set set1 set2)
;;   (let ((x1 (car set1))
;;         (x2 (car set2)))
;;     (cond
;;       ((or (empty? set1)
;;            (empty? set2)) '())
;;       ;; Since the element is in both the sets, we can add it
;;       ;; and start looking at the next elements in the list
;;       ((= x1 x2)
;;        (cons x1 (intersection-set (cdr x1) (cdr x2))))
;;       ;; if x1 is less than x2, then the same element will not
;;       ;; be found anywhere else in set2, so we can start searching
;;       ;; for the next element in set1
;;       ((< x1 x2)
;;        (intersection-set (cdr x1) x2))
;;       ;; if x1 is greater than x2, then the same element might be
;;       ;; encountered later in x2, so we need to bump up the second 
;;       ;; set
;;       ((> x1 x2)
;;        (intersection-set x1 (cdr x2))))))

(define (intersection-set set1 set2)
  (if (or (empty? set1) (empty? set2))
      '()
      (let ((x1 (car set1))
            (x2 (car set2)))
        (cond
          ;; Since the element is in both the sets, we can add it
          ;; and start looking at the next elements in the list
          ((= x1 x2)
           (cons x1 (intersection-set (cdr set1) (cdr set2))))
          ;; if x1 is less than x2, then the same element will not
          ;; be found anywhere else in set2, so we can start searching
          ;; for the next element in set1
          ((< x1 x2)
           (intersection-set (cdr set1) set2))
          ;; if x1 is greater than x2, then the same element might be
          ;; encountered later in x2, so we need to bump up the second 
          ;; set
          ((> x1 x2)
           (intersection-set set1 (cdr set2)))))))

;; This is also part of ex2.61
(define (adjoin-set el st)
  (if (< el (car st))
      (cons el st)
      (cons (car st)
            (adjoin-set el (cdr st)))))

(define (union-set set1 set2)
  (cond
    ((empty? set1) set2)
    ((empty? set2) set1)
    (else
     (let ((x1 (car set1)) (x2 (car set2)))
       (cond
         ((= x1 x2)
          (cons x1 (union-set (cdr set1) (cdr set2))))
         ((< x1 x2)
          (cons x1 (union-set (cdr set1) set2)))
         ((> x1 x2)
          (cons x2 (union-set set1 (cdr set2)))))))))
  
;; testing data

(define test-set1 '(1 2 3 4))
(define test-set2 '(1 3 5 7))
(define test-set3 (enumerate-interval 1 10))


(provide element-of-set? intersection-set adjoin-set union-set)
