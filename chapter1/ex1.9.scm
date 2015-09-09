(define (add1 a b)
  (if (= a 0)
      b
      (inc (add1 (dec a) b))))
;; (add1 4 5)
;; (inc (add1 3 5))
;; (inc (inc (add1 2 5)))
;; (inc (inc (inc (add 1 5))))
;; (inc (inc (inc (inc (add 0 5)))))
;; and so on. So this is a linear recursive process with O(a) space
;; and O(a) time.


(define (add2 a b)
  (if (= a 0)
      b
      (add2 (dec a) (inc b))))

;; (add2 4 5)
;; (add2 3 6)
;; (add2 2 7)
;; (add2 1 8)
;; (add2 0 9)
;; This is a linear iterative process with O(1) space and O(a) time.
