#lang racket

;; Replacing the fixity of operators from prefix to infix.
;; The challenge is not to change the differ function.
(define (differ expr var)
  (cond
    ((constant? expr var) 0)
    ((same-expr? expr var) 1)
    ((sum? expr)
     (make-sum (differ (addend expr) var)
               (differ (augend expr) var)))
    ((product? expr)
     (make-sum (make-product (multiplier expr)
                             (differ (multiplicand expr) var))
               (make-product (multiplicand expr)
                             (differ (multiplier expr) var))))))
;; Predicates.
;; sum? and product? need to change because the underlying representation
;; of the data has changed
(define (constant? expr var)
  (and (not (list? expr))
       (not (eq? expr var))))

(define (same-expr? expr var)
  (and (not (list? expr))
       (eq? expr var)))

(define (sum? expr)
  (eq? (second expr) '+))

(define (product? expr)
  (eq? (second expr) '*))

;; Contructors
(define (make-sum expr1 expr2)
  (cond
    ((eq? expr1 0) expr2)
    ((eq? expr2 0) expr1)
    (else
     (list expr1 '+ expr2))))

(define (make-product expr1 expr2)
  (cond
    ((or (eq? expr1 0)
         (eq? expr2 0))
     0)
    ((eq? expr1 1) expr2)
    ((eq? expr2 1) expr1)
    (else
     (list expr1 '* expr2))))

;; The selectors need to change as well becuase the symbols have changed
;; their location in the data
(define (addend expr)
  (first expr))

(define (augend expr)
  (third expr))

(define (multiplier expr)
  (first expr))

(define (multiplicand expr)
  (third expr))

;; Returns the list from nth element to the end
(define (iter-n-to-end n lst)
  (if (or (eq? n 1) (empty? lst))
      lst
      (iter-n-to-end (- n 1) (cdr lst))))

;; x^2 + xy
(define test-expr-1 '((x * x) + (x * y)))

;; x^2 + y^x
(define test-expr-2 '(x + (3 * (x + (y + 2)))))

(define test-expr-3 '(+ (* a (* x x))
                        (* b x)
                        c))


