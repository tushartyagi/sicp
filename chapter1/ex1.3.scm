(define (larger a b)
  (if (>= a b)
      a
      b))

;;; The pattern there:
;;; find the largest and then add the bigger number from the
;;; remaining two.
(define (sum-big a b c)
  (cond ((> a b) (+ a (larger b c)))
	((> a c) (+ a (larger b c)))
	((> b a) (+ b (larger a c)))
	((> b c) (+ b (larger a c)))
	((> c b) (+ c (larger a b)))
	((> c a) (+ c (larger a b)))))

(sum-big 1 2 3)
