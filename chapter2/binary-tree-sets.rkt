#lang racket
(require "operations.rkt")
(require "ordered-sets.rkt")

;; left and right are lists, not elements.
(define (make-tree entry left right)
  (list entry left right))

(define (entry tree)
  (first tree))

(define (left-branch tree)
  (second tree))

(define (right-branch tree)
  (third tree))

(define (element-of-set-binary? el tree)
  (cond
    ((empty? tree) false)
    ((= el (entry tree)) true)
    ((< el (entry tree))
     (element-of-set-binary? el (left-branch tree)))
    ((> el (entry tree))
     (element-of-set-binary? el (right-branch tree)))))

;; While defining this function, I got confused as to why is this
;; working. Then I got into the wishful thinking mode :P
(define (adjoin-set-binary el st)
  (cond
    ;; Either this is an empty set, or we have reached the right
    ;; postion after traversing down the tree
    ((empty? st) (make-tree el '() '()))

    ;; The element is already present in the set, do nothing
    ((= el (entry st)) st)

    ;; If the entry is either less than (or greater than in the
    ;; next cond clause) then we need to create a new tree with
    ;; the same entry and right (or left) branch and the new
    ;; element is inserted in the respective element.
    ((< el (entry st))
     (make-tree (entry st)
                (adjoin-set-binary el (left-branch st))
                (right-branch st)))

    ((> el (entry st))
     (make-tree (entry st)
                (left-branch st)
                (adjoin-set-binary el (right-branch st))))))


(define (tree->list-1 tree)
  (if (empty? tree)
      '()
      (append (tree->list-1 (left-branch tree))
              (cons (entry tree)
                    (tree->list-1 (right-branch tree))))))

(define (tree->list-2 tree)
  (define (copy-to-list tree result-list)
    (if (empty? tree)
        result-list
        (copy-to-list (left-branch tree)
                      (cons (entry tree)
                            (copy-to-list (right-branch tree)
                                          result-list)))))
  (copy-to-list tree '()))

(define (list->tree elements)
  (car (partial-tree elements (length elements))))

(define (partial-tree elts n)
  (if (= n 0)
      (cons '() elts)
      (let ((left-size (quotient (- n 1) 2)))
        (let ((left-result (partial-tree elts left-size)))
          (let ((left-tree (car left-result))
                (non-left-elts (cdr left-result))
                (right-size (- n (+ left-size 1))))
            (let ((this-entry (car non-left-elts))
                  (right-result (partial-tree (cdr non-left-elts)
                                              right-size)))
              (let ((right-tree (car right-result))
                    (remaining-elts (cdr right-result)))
                (cons (make-tree this-entry left-tree right-tree)
                      remaining-elts))))))))


(define (union-set-binary tree1 tree2)
  (cond
    ((empty? tree1) tree2)
    ((empty? tree2) tree1)
    (else 
     (let ((tree-list (tree->list-1 tree1)))
       (foldl (lambda (current tree)
                (adjoin-set-binary current tree))
              tree2 tree-list)))))

(define (intersection-set-binary tree1 tree2)
  (cond
    ((or (empty? tree1)
         (empty? tree2)) '())
    (else
     (let ((list1 (tree->list-2 tree1))
           (list2 (tree->list-2 tree2)))
       (let ((intersection-of-lists (intersection-set list1 list2)))
         (list->tree intersection-of-lists))))))

;; test-data
(define
  test-tree1
  (make-tree 6
             (make-tree 4
                        (make-tree 2 '() '())
                        (make-tree 5 '() '()))
             (make-tree 8
                        (make-tree 7 '() '())
                        (make-tree 9 '() '()))))

(define
  test-tree2
  (make-tree 15
             (make-tree 13
                        (make-tree 12 '() '())
                        (make-tree 14 '() '()))
             (make-tree 17
                        (make-tree 16 '() '())
                        (make-tree 18 '() '()))))

(define
  test-tree3
  (make-tree 10
             test-tree1
             '()))

(define test-tree4
  (make-tree 10
             '()
             test-tree2))

(define e (enumerate-interval 1 10))

(provide tree->list-1 tree->list-2 list->tree)
(provide make-tree entry left-branch right-branch element-of-set-binary?  adjoin-set-binary)
