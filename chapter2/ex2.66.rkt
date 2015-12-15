#lang racket
(require "binary-tree-sets.rkt")

(define (lookup-binary-tree key tree)
  (cond
    ((empty? tree) false)
    ((= key (entry tree)) tree)
    ((< key (entry tree)) (lookup-binary-tree key (left-branch tree)))
    ((> key (entry tree)) (lookup-binary-tree key (right-branch tree)))))
