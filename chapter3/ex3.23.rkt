#lang planet neil/sicp

;;; Deque
;; Each node consists of two pairs:
;; (value . (prev . next))
;; The front and rear pointers will work as they worked in queue.

(define (make-deque)
  (create-deque-node nil nil nil))

(define (front-deque d)
  (car (nodes d)))

(define (rear-deque d)
  (cdr (nodes d)))

(define (value deque-node)
  (car deque-node))

(define (nodes deque-node)
  (cdr deque-node))

(define (prev-node node)
  (car (nodes node)))

(define (next-node node)
  (cdr (nodes node)))

(define (create-deque-node value prev next)
  (cons value (cons prev next)))

(define d1 (make-deque))

(define left (create-deque-node 1 nil nil))
(define right (create-deque-node 3 nil nil))
(define node (create-deque-node 2 left right))
