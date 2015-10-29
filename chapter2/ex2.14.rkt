#lang racket
(require "ex2.12.rkt")
(require "ex2.7.rkt")
(require "interval-arithmatic.rkt")


;; par1
;; The first way of finding resistance of two parallel resistors
(define (par1 r1 r2)
  (div-interval (mul-interval r1 r2)
                (add-interval r1 r2)))


;; par2
;; The second way
(define (par2 r1 r2)
  (let ((one (make-interval 1 1)))
    (div-interval one
                  (add-interval (div-interval one r1)
                                (div-interval one r2)))))

;; par3
;; where I change par2 to remove "one" in order to see how the
;; percentage changes
(define (par3 r1 r2)
  (div-interval (make-interval 1 1)
                (add-interval (div-interval (make-interval 1 1) r1)
                              (div-interval (make-interval 1 1) r2))))




(define interval1 (make-center-width 3.5 0.10))
(define interval2 (make-center-width 4.7 0.10))

(define par1-interval (par1 interval1 interval2))
(define par2-interval (par2 interval1 interval2))
(define par3-interval (par3 interval1 interval2))


(center par1-interval)
(percent par1-interval)
(center par2-interval)
(percent par2-interval)
(center par3-interval)
(percent par3-interval)


