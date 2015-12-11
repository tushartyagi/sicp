#lang racket

;; This will only take care of the cases when the
;; expression is a list of size 3 like '(* x y)
;; Anything more and this will give wrong answers.
(define (differ expr var)
  (cond
    ((constant? expr var) 0)
    ((same-expr? expr var) 1)
    ((raised-to-zero? expr) 0)
    ((raised-to-one? expr) 1)
    ((sum? expr)
     (make-sum (differ (a1 expr) var)
               (differ (a2 expr) var)))
    ((product? expr)
     (make-sum (make-product (m1 expr)
                             (differ (m2 expr) var))
               (make-product (m2 expr)
                             (differ (m1 expr) var))))
    ((exponentiation? expr)
     (make-product (make-product (exponent expr)
                                 (make-exponentiation (base expr)
                                                      (- (exponent expr) 1)))
                   (differ (base expr) var)))))

;; the constant will either be a number
;; or another expression which is not a variable of var.
;; (* 2 x) will be taken care by the product? so we can
;; safely check only a single letter expressions for example
;; b, c, d, y, z with respect to x, 
(define (constant? expr var)
  (and (not (list? expr))
       (not (eq? expr var))))

(define (same-expr? expr var)
  (and (not (list? expr))
       (eq? expr var)))

(define (sum? expr)
  (eq? (car expr) '+))

(define (product? expr)
  (eq? (car expr) '*))


;; (define (make-sum expr1 expr2)
;;   (list '+ expr1 expr2))

;; (define (make-product expr1 expr2)
;;   (list '* expr1 expr2))

(define (make-sum expr1 expr2)
  (cond
    ((eq? expr1 0) expr2)
    ((eq? expr2 0) expr1)
    (else
     (list '+ expr1 expr2))))

(define (make-product expr1 expr2)
  (cond
    ((or (eq? expr1 0)
         (eq? expr2 0))
     0)
    ((eq? expr1 1) expr2)
    ((eq? expr2 1) expr1)
    (else
     (list '* expr1 expr2))))

(define (a1 expr)
  (second expr))

(define (a2 expr)
  (third expr))

(define (m1 expr)
  (second expr))

(define (m2 expr)
  (third expr))

(define (exponentiation? expr)
  (eq? (first expr) '**))

(define (base expr)
  (second expr))

(define (exponent expr)
  (third expr))

(define (make-exponentiation b e)
  (list '** b e))

(define (raised-to-zero? expr)
  (eq? (exponent expr) 0))

(define (raised-to-one? expr)
  (eq? (exponent expr) 1))

;; x^2 + 2xy + y^2
(define test-expr-1 '(+ (* x x)
                        (* 2 y)
                        (* y y)))


;; x^2 + y^x
(define test-expr-2 '(+ (* x x)
                        (* y x)))

;; ax^2 + bx + c
(define test-expr-3 '(+ (* a (* x x))
                        (* b x)
                        c))
