#lang racket

(require "operations.rkt") ;; 

;; fold-left
;; fold from left
(define (fold-left op initial sequence)
  (define (iter result rest)
    (if (null? rest)
        result
        (iter (op result (car rest))
              (cdr rest))))
  (iter initial sequence))


(fold-right / 1 (list 1 2 3))
(fold-left / 1 (list 1 2 3))
(fold-right list null (list 1 2 3))
(fold-left list null (list 1 2 3))

;; In order for foldr and foldl to give identical results, the operation needs
;; to be symetrical, like * and +. - and / and list are asymmetrical operations.
