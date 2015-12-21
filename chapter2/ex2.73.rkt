#lang racket

;; a)
;; The table to hold the mapping for operator and type requires a unique
;; mapping in order to get to the procedure. That is the reason we use
;; 'polar 'add-complex because these can provide a unique procedure.
;; In case of predicate like number?, will making it work for multiple
;; types make sense? Because all the numbers will correspond to number?
;; and it doesn't make sense to add this to the table. And even if we
;; go ahead try to add number? to the table, what will be use? It will be
;; only called for the type of number. In short, this is not a generic
;; procedure by definition, so there is no need to add this to the table.

;; b)
(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (apply proc (map contents args))
          (error
            "No method for these types -- APPLY-GENERIC"
            (list op type-tags))))))

(define (deriv exp var)
   (cond ((number? exp) 0)
         ((variable? exp) (if (same-variable? exp var) 1 0))
         (else ((get 'deriv (operator exp)) (operands exp)
                                            var))))
(define (operator exp) (car exp))
(define (operands exp) (cdr exp))

(define (put op type item)
  (display "Put ")
  (display op)
  (display "\n"))

(define (get op type)
  (display "Put ")
  (display op)
  (display "\n"))

(define (install-derivative-package)
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

  ;; Instead of using second and third, we will use first and second
  ;; here because we are getting cdr of the expression list from which the
  ;; operator has been stripped off.
  ;; For an expression like (+ 2 x), we will now get (2 x).
  (define (addend x) (first x))
  (define (augend x) (second x))
  (define (multiplier x) (first x))
  (define (multiplicand x (second x)))
  
  (put '+ '(deriv) (lambda (expr var)
                     (make-sum (deriv (addend expr) var)
                               (deriv (augend expr) var))))
  (put '* '(deriv) (lambda (expr var)
                     (make-sum (make-product (multiplier expr)
                                             (deriv (multiplicand expr) var))
                               (make-product (multiplicand expr)
                                             (deriv (multiplier expr) var0))))))

;; d) If the definition is changed to
;; ((get (operator exp) 'deriv) (operands exp) var)
;; then there will be corresponding changes in the put procedure and the
;; install package. Here we are flipping the rows and columns of the table,
;; but setting the data is still the same. So we have to make corresponding
;; changes in the code to swap the rows and columns as well.

