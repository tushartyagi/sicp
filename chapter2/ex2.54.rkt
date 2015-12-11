#lang racket

(define (equal? item1 item2)
  (cond
    ;; base cases:
    ;; when both are empty -- true
    ;; when one is and the other is not -- false
    ((and (empty? item1)
          (empty? item2)) true)
    ((or (and (empty? item1)
              (not (empty? item2)))
         (and (empty? item2)
              (not (empty? item1)))) false)
    ((and (symbol? item1)
          (symbol? item2)
          (eq? item1 item2)) true)
    ((and (list? item1)
          (list? item2)
          (eq? (car item1) (car item2))
          (equal? (cdr item1) (cdr item2))) true)
    (else false)))
