#lang racket

;; make-vect
;; creates a vect
(define make-vect cons)
(define xcor-vect car)
(define ycor-vect cdr)

(define (add-vect v1 v2)
  (make-vect (+ (xcor-vect v1) (xcor-vect v2))
             (+ (ycor-vect v1) (ycor-vect v2))))

(define (sub-vect v1 v2)
  (make-vect (- (xcor-vect v1) (xcor-vect v2))
             (- (ycor-vect v1) (ycor-vect v2))))

(define (scale-vect scalar vect)
  (make-vect (* scalar (xcor-vect vect))
             (* scalar (ycor-vect vect))))

(provide make-vect)
(provide xcor-vect)
(provide ycor-vect)
(provide add-vect)
(provide sub-vect)
(provide scale-vect)
