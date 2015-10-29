#lang racket

;;; I was unable to think through the way list is supposed
;;; to be reversed. This is a new pattern which was pretty
;;; interesting to come across.

;; reverse
;; reverses the list
;; given (reverse (list 1 2 3 4 5))
;; expects '(5 4 3 2 1)
(define (reverse-list l addendum)
  (if (null? l)
      addendum
      (reverse-list (cdr l)
                    (cons (car l) addendum))))

(define (reverse l)
  (reverse-list l '()))

(list 1 2 3 4 5)
(cons 5 (cons 4 (cons 3 (cons 2 (cons 1 '())))))
(reverse (list 1 2 3 4 5))

