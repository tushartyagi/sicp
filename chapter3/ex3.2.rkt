#lang racket

(define (make-monitored f)
  (let ((count 0))
    (lambda (input)
      (cond ((eq? 'how-many-calls? input) count)
            ((eq? 'reset-count input) (set! count 0))
            (else (set! count (+ 1 count))
                  (f input))))))
