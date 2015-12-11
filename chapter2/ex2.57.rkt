#lang racket

;; This will only take care of the cases when the
;; expression is a list of size 3 like '(* x y)
;; Anything more and this will give wrong answers.

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

(define (addend expr)
  (second expr))

;; The symbol + has already been removed by the pattern matching,
;; so the rest of the elements are again being summed.
;; (+ x y (+ x 3)) is now:
;; (+ y (+ x 3)) because we need to handle all the remaining elements
;; in this function only
;; The first two positions hold the operator symbol and the addend
(define (augend expr)
  (if (> (length expr) 3)      
      (cons '+ (iter-n-to-end 3 expr))
      (third expr)))

;; Returns the list from nth element to the end
(define (iter-n-to-end n lst)
  (if (or (eq? n 1) (empty? lst))
      lst
      (iter-n-to-end (- n 1) (cdr lst))))

(define (multiplier expr)
  (second expr))

(define (multiplicand expr)
  (if (> (length expr) 3)
      (cons '* (iter-n-to-end 3 expr))
      (third expr)))

;; x^2 + 2xy + y^2
(define test-expr-1 '(+ (* x x)
                        (* 2 x y)
                        (* y y)))


;; x^2 + y^x
(define test-expr-2 '(+ (* x x)
                        (* y x)))

;; ax^2 + bx + c
(define test-expr-3 '(+ (* a (* x x))
                        (* b x)
                        c))
