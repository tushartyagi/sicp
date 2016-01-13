#lang racket

(define (make-accumulator seed)
  (lambda (value-to-add)
    (set! seed (+ value-to-add seed))
    seed))
