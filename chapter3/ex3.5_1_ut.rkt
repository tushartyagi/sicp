#lang racket
(require rackunit "ex3.5_1.rkt")

(define P (create-circle-predicate 5 7 3))
(check-true (P (cons 5 7)))
(check-false (P (cons 0 0)))


