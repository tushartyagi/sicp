#lang racket

;; reverse-l
;;  
(define (reverse-l items)
  (foldl (lambda (x y))
         null
         sequence))

;; reverse-r
;; description here
(define (reverse-r items)
  (foldr (lambda (x y))
         null
         sequence))

