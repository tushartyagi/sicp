#lang racket
(require scheme/mpair)
(require rackunit)

;;(define  (counted-pairs initial-list)
  ;; (define (insert value)
  ;;   (trave))
  ;; (lambda (operation)))

(define (has-element? item items)
  (cond ((null? items) false)
        ((eq? (car items) item) true) ;; check the id of the object
        (else (has-element? item (cdr items)))))

(define (older-pair? pair pairs)
  (cond ((null? pairs) false)
        ((eq? pair (car pairs)) true)
        (else (older-pair? pair (cdr pairs)))))

(define a (cons 'a null))
(define b (cons a a))
(define c (cons a (cons a null)))
(define d (cons a (cons a a)))

;; (check-true (older-pair?? a a))
;; (check-true (older-pair?? a b))
;; (check-true (older-pair?? a c))
;; (check-true (older-pair?? a d))

(define (count-pairs-old x)
  (if (not (pair? x))
      0
      (+ (count-pairs-old (car x))
         (count-pairs-old (cdr x))
         1)))


;; This question took a lot of my time, because I was not able to get the
;; thing to work. The idea of what I needed to do was clear, but the actual
;; implementation took time. Coding for so many days in purely funcitional
;; terms had my mind fixed in that particular way of thinking probably.
;; Also, previously I was trying to hold the count in a recursive loop, which
;; was causing problems in the inner calls, although the count itself was
;; outside the calls.
;; Now I can finally move to the next question and feel good about it.
(define (count-pairs x)
  (let ((count 0)
        (pairs '()))
    (define (add-element! elem)
      (set! pairs (cons elem pairs)))
    (define (count-unique-pairs x)
      (cond ((not (pair? x)) 0)
            ((memq x pairs)  0)  ;; element already in list
            (else
             (begin
               (add-element! x)
               (set! count (+ count 1))
               (count-unique-pairs (car x))
               (count-unique-pairs (cdr x))
               count))))
    (count-unique-pairs x)))
           
