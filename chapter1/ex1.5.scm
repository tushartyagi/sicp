(define (p) (p))

(define (test x y)
  (if (= x 0)
      0
      y))

(test 0 (p))
;; In case of applicative order, the arguments are evaluated and then
;; applied in the function call so this will send the evaluation in an
;; infinite loop which is precisely what is happening on my machine for
;; racket.
;; (test 0 (p))
;; (test 0 (p))
;; (test 0 (p))
;; and so on

;; If this was a normal order then the evaluation would have first expanded
;; the function call by placing the arguments in the function body, and then
;; take it further from there:
;; (test 0 (p))
;; (if (= 0 0)
;;     0
;;     (p))
;; and since `if` is a special form and won't evaluated the alternate in
;; this case, we will not have an infinite loop.
