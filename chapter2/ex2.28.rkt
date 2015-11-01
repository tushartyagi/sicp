#lang racket

;; If the car of the tree is a list, then go inside and create fringe
;; else just add the elements of the list in the holder.
;; I am using append function here because it flattens a list before
;; adding it to the given list, while cons simply prepends the element.

(define (fringe items)
  (cond ((null? items) null)
        ((list? (car items))
         (append (fringe (car items))
                 (fringe (cdr items))))
        (else (cons (car items)
                    (fringe (cdr items))))))

(define x (list (list (list (- 1) 0) 1 2) (list 3 4)))

;; (fringe x)
;; (fringe (list x x))
(provide fringe)
