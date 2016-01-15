#lang racket
(require "monte-carlo.rkt")

;; circle is (x, y, r)
(define (create-predicate c)
  (lambda (point)
    (let ((x (car point))
          (y (cdr point)))
      (<= (+ (sqr (- (first c) x))
             (sqr (- (second c) y)))
          (sqr (third c))))))

(define test-circle '(5 7 3))
(define P (create-predicate test-circle))

(define (estimate-integral P x1 x2 y1 y2 trials)
  (* (rect-area x1 x2 y1 y2)
     (monte-carlo trials (rect-test x1 x2 y1 y2))))

(define (rect-area x1 x2 y1 y2)
  (abs (* (- x2 x1)
          (- y2 y1))))

(define (random-in-range low high)
  (let ((range (- high low)))
    (+ low (random range))))


;; The rect test should pick up a random point and find out if
;; the point lies both inside the rect and satisfies the circle's equation.
(define (rect-test x1 x2 y1 y2)
  (define (lies-inside-rect point)
    (let ((x (car point))
          (y (cdr point)))
      (and (and (>= x x1) (<= x x2))
           (and (>= y y1) (<= y y2)))))
  (define (get-random-point)
    (cons (random-in-range x1 x2)
          (random-in-range y1 y2)))
  (lambda () 
    (let ((point (get-random-point)))
      (and (lies-inside-rect point)
           (P point)))))

(estimate-integral rect-test 2 8 4 10 10000)
