#lang racket
(require "operations.rkt")

(define (get-coercion types-list)
  (display "get-coercion")
  (display types-list)
  (display "\n")
  false)

(define (find-coercion-proc types-list)
  (define (find-proc index types-list)
    (if (> index (length types-list))
        false
        (let ((current-type (nth index types-list)))
          (let ((coercion-list (element->list current-type
                                              (length types-list))))
            (let ((proc (get-coercion coercion-list)))
              (if proc
                  proc
                  (find-proc (+ 1 index) types-list)))))))
  (find-proc 1 types-list))

(define sample-types-list
  '(foo bar baaz buux ))

;; This fails when the arguments have different types.
;; Here the calls would be n times, since we are blindly searching for
;; list of same types n times.
;; In case all the possible combinations are taken up, we require a lot of
;; calls, how many - I am yet to figure out. 
(find-coercion-proc sample-types-list)
;; Output: 
;; get-coercion(foo foo foo foo)
;; get-coercion(bar bar bar bar)
;; get-coercion(baaz baaz baaz baaz)
;; get-coercion(buux buux buux buux)
;; #f
