#lang racket

;; a) In such a case, the call to apply-generic will have infinite recursion.
;; t1->t2 will always map to complex->complex and the resulting call will again
;; call itself. The better approach is to do what part c asks us to do.

;; b) There are two cases:
;; 1) The same-type operation is found in the operations table, and in this
;; case the apply-generic will work as is because the lookup in the operations
;; table is done before than the lookup in the coercion table, and we will
;; find the operations in the former.
;; 2) The same type operation is not found in the operations table, then the
;; same is searched for in the coercion table. By what I understand, if we
;; leave the same type coercion as is -- without handling that case in teh
;; coercion table, the code will be fine. If the method is not defined in the
;; operations table, that means it is not defined, period. Not every combination
;; of operations make sense -- exponential for complex is one such case (I hope
;; so, with my limited mathematical knowledge).

;; c)
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
                  (let ((t1->t2 (get-coercion type1 type2))
                        (t2->t1 (get-coercion type2 type1)))
                    (cond (t1->t2
                           (apply-generic op (t1->t2 a1) a2))
                          (t2->t1
                           (apply-generic op a1 (t2->t1 a2)))
                          (else
                           (error "No method for these types"
                                  (list op type-tags))))))
                (error "No method for these types"
                       (list op type-tags))))))))
