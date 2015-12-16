#lang racket
(require "huffman-trees.rkt")

(define (generate-huffman-trees pairs)
  (successive-merge (make-leaf-set pairs)))

;; A failed attempt because
;; a) the code was looking messy
;; b) I remembered that we are decreasing a list to a single value, so
;; fold functions will do the job.
;; (define (successive-merge ordered-pairs)
;;   (cond ((null? ordered-pairs) '())
;;         ((let ((left (first ordered-pairs)))
;;            (make-code-tree left
;;                            (successive-merge (rest ordered-pairs)))))))

;; This code looks pretty clean, but I had to think a lot to get to this.
;; I wanted this to be my first approach, but I also wanted to use foldr
;; because I was thinking along different lines. Only when I started
;; using foldl, I came to realise that this is the right approach since
;; the result of applying the function to the left and right nodes need
;; to produce the right node for the next iteration, and the left node
;; will come from the next value of the list.
;; While this sounds easy, I guess I still need more experience with the
;; functional way of thinking.
;; Only when I wrote this procedure did I read the warning from the authors:
;; " This procedure is slightly tricky, but not really complicated.
;; If you find yourself designing a complex procedure, then you are almost
;; certainly doing something wrong. "
;; Realised the difference between tricky and complex :)
(define (successive-merge ordered-pairs)
  (foldl (lambda (current total)
           (make-code-tree current total))
         (first ordered-pairs)   ;; init -- total's first value
         (rest ordered-pairs)))  ;; list to fold

;;(generate-huffman-trees  '((B 2) (C 1) (D 3) (A 4)))

(provide generate-huffman-trees)



