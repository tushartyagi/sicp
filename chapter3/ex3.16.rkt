#lang racket
;;(require scheme/mpair)
(define (count-pairs x)
  (if (not (pair? x))
      0
      (+ (count-pairs (car x))
         (count-pairs (cdr x))
         1)))


(define a (cons 'a null))
;; returns 3 although only 2 pairs -- current pair and a
(define b (cons a a))
(count-pairs b)

;; returns 4
(define c (cons a (cons a null)))
(count-pairs c)

;; returns 5
(define d (cons a (cons a a)))
(count-pairs d)

(define a1 (cons a a))
(define e (cons a1 a1))
(count-pairs e)


;; They seem to have removed set-c*r procedures from racket and implemented
;; these for mpair which is now a separate data type.
(define (count-mpairs x)
  (if (not (mpair? x))
      0
      (+ (count-mpairs (mcar x))
         (count-mpairs (mcdr x))
         1)))


(define round1 (mcons 'a null))
(define round2 (mcons 'b round1))
(define round3 (mcons 'c round2))
(set-mcdr! round1 round3)
;; This crashes the machine
;; (count-mpairs round3)
