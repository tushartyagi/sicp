#lang racket

;; my-accumulate
;; another implementation of foldr
(define (my-accumulate f seed items)
  (if (null? items)
      seed
      (my-accumulate f
                     (f seed (car items))
                     (cdr items))))

(my-accumulate + 0 (list 1 2 3 4 5 6 7 8 9 10))
