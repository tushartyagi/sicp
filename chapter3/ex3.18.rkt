#lang planet neil/sicp

(define (cycle? items)
  (let ((visited-list '()))
    (define (check-cycle items)
      (cond ((not (pair? items)) false)
            ((visited?!) true)
            (else (or (check-cycle (car items))
                      (check-cycle (cdr items))))))
    (define (visited?!)
      (if (memq items visited-list)
          true
          (begin (set! visited-list (cons items visited-list))
                 false)))
    (check-cycle items)))

(define cycled-list '(a))
(set-cdr! cycled-list cycled-list)
(cycle? cycled-list)