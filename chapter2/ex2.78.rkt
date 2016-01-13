#lang racket

(define (attach-tag type-tag x)
  (cond ((or (symbol? x) (number? x)) x)
        (else (cons type-tag x))))

(define (type-tag x)
  (cond ((or (symbol? x) (number? x)) x)
        ((pair? x) (car x))
        (else (error "Whoops! Invalid data"))))

(define (contents x)
   (cond ((or (symbol? x) (number? x)) x)
        ((pair? x) (cdr x))
        (else (error "Whoops! Invalid data"))))

