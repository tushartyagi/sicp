#lang racket

;; my-map
;; implementing map
(define (my-map f items)
  (if (null? items)
      null
      (cons (f (car items))
            (my-map f (cdr items)))))
