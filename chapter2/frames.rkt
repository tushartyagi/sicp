#lang racket
;; make-frame
;; creates a frame
(define (make-frame origin corner1 corner2)
  (list origin corner1 corner2))

(define (origin-frame frame)
  (first frame))

(define (edge1-frame frame)
  (second frame))

(define (edge2-frame frame)
  (third frame))

