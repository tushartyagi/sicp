#lang racket
(require "huffman-trees.rkt")

(define (encode message tree)
  (if (null? message)
      '()
      (append (encode-symbol (car message) tree)
              (encode (cdr message) tree))))

(define (symbol-present? sym tree)
  (cond
    ((empty? tree) false)
    ((eq? sym (car tree)) true)
    (else (symbol-present? sym (cdr tree)))))

;; Empty symbol is already handled in the encode function
;; Not doing empty tree checking 
(define (encode-symbol sym tree)
  (define (symbol-in-branch? branch)
    (symbol-present? sym (symbols-tree branch)))  
  (define (find-symbol tree path)
    (cond
      ((leaf? tree) path)
       ;; Need to clean this up as well, make this some sort of
       ;; a generic operation
      ((symbol-in-branch? (left-branch tree))
       (cons 0 (find-symbol (left-branch tree) path)))
      ((symbol-in-branch? (right-branch tree))
       (cons 1 (find-symbol (right-branch tree) path)))
      (else (error "Given symbol not found in the tree" sym))))
  (find-symbol tree '()))


(define sample-tree
  (make-code-tree (make-leaf 'A 4)
                  (make-code-tree
                   (make-leaf 'B 2)
                   (make-code-tree (make-leaf 'D 1)
                                   (make-leaf 'C 1)))))

(define st sample-tree)

(define sample-message '(0 1 1 0 0 1 0 1 0 1 1 1 0))

(encode '(A D A B B C A) st)
