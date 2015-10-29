#lang racket

;; square-list
;; squares the numbers in the list
(define (square-list lst)
  (map (lambda (x) (* x x))
       lst))

;; square-list'
;; squares the number using recursion
(define (square-list-recurse lst)
  (cond
     ((null? lst) null)
     (else (cons (* (car lst) (car lst))
                 (square-list-recurse (cdr lst))))))

