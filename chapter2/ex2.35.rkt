#lang racket
(require "accumulate.rkt")

;; count-leaves
;; description here
(define (count-leaves t)
  ;; The binary function will be fed the value of init (0) and
  ;; the value calculated by the map function.
  (accumulate +
              0
              ;; map produces the sequence to be used for the accumulation,
              ;; which should replace the elements by 1 and subtrees by their
              ;; lengths. To count the length of the subtrees, we are again
              ;; using the count-leaves function.
              ;; Since the parameters are already evaluated before the function
              ;; call, the map will have created the list to be used for foldr.
              (map (lambda (x)
                     ;; (display x)
                     ;; (display "\n")
                     (if (pair? x)
                         (count-leaves x)
                         1))
                   t)))

;; In case of recursive sequences, I can use this combination of accumulation
;; and map wherein map calculates the sequence that is being used by the
;; accumulation function. Indeed, the entire section was not able to drill this
;; idea of conventional interfaces but this question was able to do.
