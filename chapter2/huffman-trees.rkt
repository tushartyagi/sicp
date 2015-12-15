#lang racket

(define (make-leaf symbol weight)
  (list 'leaf symbol weight))

(define (leaf? object)
  (eq? (first object) 'leaf))

(define (symbol-leaf x)
  (second x))

(define (weight-leaf x)
  (third x))

(define (make-code-tree left right)
  (list left
        right
        (append (symbols-tree left) (symbols-tree right))
        (+ (weight left) (weight right))))

(define (left-branch tree)
  (first tree))

(define (right-branch tree)
  (second tree))

(define (symbols-tree tree)
  (if (leaf? tree)
      (list (symbol-leaf tree))
      (third tree)))

(define (weight tree)
  (if (leaf? tree)
      (weight-leaf tree)
      (fourth tree)))

(define (decode bits tree)
  (define (decode-1 bits current-branch)
    (if (null? bits)
        '()
        (let ((next-branch
               (choose-branch (car bits) current-branch)))
          ;; If the symbol we have found is a leaf, then restart the
          ;; decode-1 process using the tree, otherwise keep going
          ;; down on the current branch.
          (if (leaf? next-branch)
              (cons (symbol-leaf next-branch)
                    (decode-1 (cdr bits) tree))
              (decode-1 (cdr bits) next-branch)))))
  (decode-1 bits tree))

(define (choose-branch bit branch)
  (cond ((= bit 0) (left-branch branch))
        ((= bit 1) (right-branch branch))
        (else (error "bad bit -- CHOOSE-BRANCH" bit))))

(define (adjoin-set x st)
  (cond ((null? st) (list x))
        ((< (weight x) (weight (car st))) (cons x st))
        (else (cons (car st)
                    (adjoin-set x (cdr st))))))

; (make-leaf-set '((A 4) (B 2) (C 1) (D 1)))
; '((leaf D 1) (leaf C 1) (leaf B 2) (leaf A 4))
(define (make-leaf-set pairs)
  (if (null? pairs)
      '()
      (let ((pair (car pairs)))
        (adjoin-set (make-leaf (car pair)    ; symbol
                               (cadr pair))  ; frequency
                    (make-leaf-set (cdr pairs))))))

(define (is-symbol-present sym tree)
  (cond
    ((empty? tree) false)
    ((eq? sym (car tree)) true)
    (else (is-symbol-present sym (cdr tree)))))


(define sample-tree
  (make-code-tree (make-leaf 'A 4)
                  (make-code-tree
                   (make-leaf 'B 2)
                   (make-code-tree (make-leaf 'D 1)
                                   (make-leaf 'C 1)))))

(define sample-message '(0 1 1 0 0 1 0 1 0 1 1 1 0))


(provide leaf?)
(provide make-code-tree make-leaf decode make-leaf-set symbols-tree
         right-branch left-branch)
