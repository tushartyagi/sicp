#lang sicp

; Each table is just a list of nodes of (key, value) and next-pointer
(define (create-table)
  (define table '())
  (define (new-node k v)
    (cons k v))
  (define (get-key node)
    (car node))
  (define (get-value node)
    (cdr node))
  (define (insert k v)
    (set! table (cons (new-node k v) table)))
  (define (get k) (get-value-from-table k table))
  (define (get-value-from-table k table)
    (cond ((null? table) false)
          ((eq? (get-key (car table)) k)
           (get-value (car table)))
          (else (get-value-from-table k (cdr table)))))
  (define (update-table k v) (update k v table))
  (define (update k v table)
    (cond ((null? table) false)
          ((eq? (get-key (car table)) k)
           (set-car! table (new-node k v))
           true)
          (else (update k v (cdr table)))))
  (define (update-value v node)
    (set-cdr! node v)) 
  (define (dispatch operation)
    (cond ((eq? operation 'update)
           update-table) 
          ((eq? operation 'insert)
           insert)
          ((eq? operation 'show)
           table)
          ((eq? operation 'get)
           get)))
  dispatch)

(define insert (lambda (table k v) ((table 'insert) k v)))
(define update (lambda (table k v) ((table 'update) k v)))
(define get (lambda (table k) ((table 'get) k)))
(define show  (lambda (table) (table 'show)))

(define polar (create-table))
;; In polar representation: (2,4) = 2 + 4j
(insert polar 'real-part (lambda (z) (car z)))
(insert polar 'imag-part (lambda (z) (cdr z)))

(define rectangular (create-table))
;; In rectangular representation: (2,4) = (r, theta)
(insert rectangular 'magnitude (lambda (z) (car z)))
(insert rectangular 'angle (lambda (z) (cdr z)))


;; interface for the function table
;; this is a table working with 2 indices. The values of the first table are
;; tables 
(define function-table (create-table))
(insert function-table 'polar polar)
(insert function-table 'rectangular rectangular)

;; The way to access the functions stored in function table: 2 way redirection

;; (put <type> <op> <item>) -- First index by type, then by operation.
;; This is reversed from what we use in sicp. 
(define (get-op table type op)
  (let ((sub-table (get table type)))
    (if (null? sub-table)
        false
        (let ((op (get sub-table op)))
          (if (null? op)
              false
              op)))))

(define (put-op table type op item)
  (let ((sub-table (get table type)))
    (if (null? sub-table)
        false
        (insert sub-table op item))))


(define real-part (create-table))
;; In real-part representation: (2,4) = 2 + 4j
(insert real-part 'polar (lambda (z) (car z)))
(insert real-part 'rectangular  (lambda (z) (* (car z) (cos (cdr z)))))

(define imag-part (create-table))
;; In imag-part representation: (2,4) = 2 + 4j
(insert imag-part 'polar (lambda (z) (cdr z)))
(insert imag-part 'rectangular  (lambda (z) (* (car z) (sin (cdr z)))))

(define op-table (create-table))
(insert op-table 'real-part real-part)
(insert op-table 'imag-part imag-part)

