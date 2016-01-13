#lang racket
(require "operations.rkt")

(define type-heirarchy '(int rational real complex))

;; Gives the number of times raise will have to be called from t1 to reach
;; t2.
(define (height t1 t2)
  (let ((index-t1 (index t1 type-heirarchy)))
    (let ((index-t2 (index t2 type-heirarchy)))
      (if (and (> index-t1 0)
               (> index-t2 index-t1))
          (- index-t2 index-t1)
          0))))

;; raise has to come from ex2.83, but this is also one procedure given
;; in Scheme standard library (for exceptions I guess).
;; value will have type info attached to it, so apply-generic will work.
(define (raise-type n value)
  (apply-times raise n value))

(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (apply proc (map contents args))
          (let ((type1 (car type-tags))
                (type2 (cadr type-tags)))
            (if (and (not (eq? type1 type2))
                     (= (length args) 2))
                (let ((a1 (car args))
                      (a2 (cadr args)))
                  (let ((height-t1->t2 (height type1 type2))
                        (height-t2->t1 (height type2 type1)))
                    (cond ((> height-t1->t2 0)
                           (apply-generic op (raise-type height-t1->t2 a1) a2))
                          ((> height-t2->t1 0)
                           (apply-generic op a1 (raise-type height-t2->t1 a2)))
                          (else
                           (error "No method for these types"
                                  (list op type-tags))))))
                (error "No method for these types"
                       (list op type-tags))))))))
