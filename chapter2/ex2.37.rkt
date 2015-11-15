#lang racket

(require "operations.rkt")

;; dot-product
;; sigma (i) v (i) * w (i)
;; the pattern here is to first multiply the respective elements
;; of the two vectors, and then accumulate the result using +
(define (dot-product v w)
  (accumulate +
              0
              (map * v w)))


;; matrix-*-vector
;; will return a vector where:
;; element = sigma (j) mij*vj
;; the pattern is to accumulate the products; the products will be n sequences
;; created by creating a dot product of each row of the matrix with the vector.
;; So each column/row will be the dot product of matrix's row and the vectors
(define (matrix-*-vector-recurse m v)
  (cond
    ((null? m) null)
    ((cons (dot-product (car m) v)
           (matrix-*-vector-recurse (cdr m) v)))))

;; While the recursive approach was easy and I was able to quickly thought about
;; it, the mapping approach took some time because, as written above, I was
;; thinking that I will have to accumulate the products (not thinking that I was
;; already doing it in dot-product). A lot like when you have a hammer, every
;; problem looks like a nail.
(define (matrix-*-vector m v)
  (map (lambda (x)
         (dot-product x
                      v))
       m))

;; transpose
;; transposes a matrix
(define (transpose m)
  (accumulate-n cons null m))


;; matrix-*-matrix
;; multiplies two matrices
;; I found out that in order to multiply two matrices, it's symetrical to
;; multiply each row of the first one with the transpose of the second one.
(define (matrix-*-matrix m n)
  (let ((nt (transpose n)))
    (map (lambda (x)
           (matrix-*-vector nt x))
         m)))

(define t '((1 2 3)
            (4 5 6)
            (7 8 9)))

(define tt (transpose t))

(define s '((12 17 18)
            (98 98 12)
            (18 81 12)
;;            (10 11 12)
            ))
