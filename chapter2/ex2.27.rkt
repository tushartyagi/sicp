#lang racket

(define x (list (list 1 2) (list 3 4)))

;; This seeds the reverse function with an empty list and
;; keeps adding the cars to this list, when the original
;; list is empty, then the holder is returned which contains
;; all the reverse cars.
(define (reverse-with-holder items holder)
  (if (null? items)
      holder
      (reverse-with-holder (cdr items)
                           (cons (car items) holder))))

(define (reverse-list items)
  (reverse-with-holder items null))

(reverse-list x)
(reverse-list null)


;; here we have the case when the car of the list in question
;; is itself a list. In that case we need to dive deep and return
;; the iterated list.
(define (deep-reverse items holder)
  (cond ((null? items) holder)
        (else (deep-reverse (cdr items)
                            (cons (if (list? (car items))
                                      (reverse-list (car items))
                                      (car items))
                                  holder)))))
        
(deep-reverse x null)
