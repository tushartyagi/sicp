#lang racket

;; Ben Bitdiddle's representation
;; Constructors
(define (make-from-real-imag-rectangular real imag)
  (attach-tag 'rectangular
              (cons real imag)))

(define (make-from-mag-ang-rectangular mag ang)
  (attach-tag 'rectangular?
              (cons (* mag (cos ang))
                    (* mag (sin ang)))))

;; Selectors
;; real-part
;; description here
(define (real-part-rectangular c)
  (car c))

;; imag-part
;; description here
(define (imag-part-rectangular c)
  (cdr c))

;; magnitude
;; description here
(define (magnitude-rectangular c)
  (sqrt (+ (sqr (real-part c)) (sqr (imag-part c)))))

;; angle
;; description here
(define (angle-rectangular c)
  (tan (/ (imag-part c) (real-part c))))

;; Alyssa's representation
;; Constructors
(define (make-from-mag-ang-polar r a)
  (attach-tag 'polar
              (cons r a)))

(define (make-from-real-imag-polar real imag)
  (attach-tag 'polar
              (cons (sqrt (+ (sqr real) (sqr imag)))
                    (tan imag real))))

(define (real-part-polar c)
  (* (magnitude c) (cos (angle c))))

(define (imag-part-polar c)
  (* (magnitude c) (sin (angle c))))

(define (magnitude-polar c)
  (car c))

(define (angle-polar c)
  (cdr c))


;; Higher level procedures:
(define (add-c c1 c2)
  (make-from-real-imag (+ (real-part c1) (real-part c2))
                       (+ (imag-part c1) (imag-part c2))))

(define (sub-c c1 c2)
  (make-from-real-imag (- (real-part c1) (real-part c2))
                       (- (imag-part c1) (imag-part c2))))

(define (mul-c c1 c2)
  (make-from-mag-ang (* (magnitude c1) (magnitude c2))
                     (+ (angle c1) (angle c2))))

(define (div-c c1 c2)
  (make-from-mag-ang (/ (magnitude c1) (magnitude c2))
                     (- (angle c1) (angle c2))))


;; First steps to create tagged-data
(define (attach-tag type-tag contents)
  (cons type-tag contents))

(define (type-tag datum)
  (if (pair? datum)
      (car datum)
      (error "BAD DATA. COULD NOT EXTRACT TAGS")))

(define (contents datum)
  (if (pair? datum)
      (cdr datum)
      (error "BAD DATA. COULD NOT EXTRACT CONTENTS")))

(define (rectangular? z)
  (eq? (type-tag z)
       'rectangular))

(define (polar? z)
  (eq? (type-tag z)
       'polar))

(define (real-part z)
  (cond ((rectangular? z) 
         (real-part-rectangular (contents z)))
        ((polar? z)
         (real-part-polar (contents z)))
        (else (error "Unknown type -- REAL-PART" z))))

(define (imag-part z)
  (cond ((rectangular? z)
         (imag-part-rectangular (contents z)))
        ((polar? z)
         (imag-part-polar (contents z)))
        (else (error "Unknown type -- IMAG-PART" z))))

(define (magnitude z)
  (cond ((rectangular? z)
         (magnitude-rectangular (contents z)))
        ((polar? z)
         (magnitude-polar (contents z)))
        (else (error "Unknown type -- MAGNITUDE" z))))

(define (angle z)
  (cond ((rectangular? z)
         (angle-rectangular (contents z)))
        ((polar? z)
         (angle-polar (contents z)))
        (else (error "Unknown type -- ANGLE" z))))

(define (make-from-real-imag x y)
  (make-from-real-imag-rectangular x y))

(define (make-from-mag-ang r a)
  (make-from-mag-ang-polar r a))
