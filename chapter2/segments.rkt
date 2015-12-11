#lang racket
(require "ex2.46.rkt") ;; for vectors

(define (make-segment v1 v2)
  (list v1 v2))

(define (start-segment line-segment)
  (first line-segment))

(define (end-segment line-segment)
  (second line-segment))

(provide make-segment)
(provide start-segment)
(provide end-segment)
