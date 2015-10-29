#lang racket

(define (square x) (* x x))

;; square-list
;; one which gives reversed list
(define (square-list items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (cons (square (car things))
                    answer))))
  (iter items null))

;; the answer is giving back reversed list because we are iterating
;; through the cdr and consing the car, but in the list we should
;; cons the car and iterate the cdr.
;; (square-list (list 1 2 3 4 5))
;; '(25 16 9 4 1)

(define (square-list-2 items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (cons answer
                    (square (car things))))))
    (iter items null))

;; cons creates a list, and expects the first item to be a primitive and the
;; second param as a list. The if branch of the expression is correct in this
;; function and the previous one, but in the cons we are passing null and
;; another number, which creates a pair instead of a list, and we have this:
;; (square-list-2 (list 1 2 3 4 5))
;; '(((((() . 1) . 4) . 9) . 16) . 25)
