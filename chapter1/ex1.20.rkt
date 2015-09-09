#lang Racket

(define (gcd1 a b)
  (if (= b 0)
      a
      (gcd1 b (r a b)))) ;; r is the remainder functionn


;; Using normal form, where the leftmost outermost reducible
;; expression is reduced. 

;; a = 206, b = 40
(gcd 206 40) 
;; this opens up to
(if (= 6 0)
    206
    (gcd 40 (r 206 40)))

;; a = (r 206 40), b = (r 40 (r 206 40))
(gcd (r 206 40) (r 40 (r 206 40)))
;; this opens up to
(if (= (r 40 (r 206 40)))
    (r 206 40)
    (gcd (r 40 (r 206 40)) (r (r 206 40)
                              (r 40 (r 206 40)))))
;; after perfoming two operations in if predicate
(if (= 4 0)
    (r 206 40)
    (gcd (r 40 (r 206 40)) (r (r 206 40)
                              (r 40 (r 206 40)))))


;; a = (r 40 (r 206 40))
;; b = (r (r 206, 40) (r 40 (r 206 40))))
(gcd (r 40 (r 206 40)) (r (r 206 40)(r 40 (r 206 40)))))
;; this gives
(if (= 0 (r (r 206 40) (r 40 (r 206 40))))
    (r 40 (r 206 40))
    (gcd (r (r 206 40) (r 40 (r 206 40)))
         (r (r 40 (r 206 40))
            (r (r 206 40) (r 40 (r 206 40))))))

;; this will perform the remainder operation four times
(if (= 0 2)
    (r 40 (r 206 40))
    (gcd (r (r 206 40) (r 40 (r 206 40)))
         (r (r 40 (r 206 40))
            (r (r 206 40) (r 40 (r 206 40))))))

;; a = (r (r 206 40) (r 40 (r 206 40)))
;; b = (r (r 40 (r 206 40)) (r (r 206 40) (r 40 (r 206 40))))))
(gcd (r (r 206 40) (r 40 (r 206 40)))
     (r (r 40 (r 206 40)) (r (r 206 40) (r 40 (r 206 40))))) 
(if (= 0 (r (r 40 (r 206 40)) (r (r 206 40) (r 40 (r 206 40)))))
    (r (r 206 40) (r 40 (r 206 40)))
    (gcd (r (r 40 (r 206 40)) (r (r 206 40) (r 40 (r 206 40))))
         (r (r 40 (r 206 40)) (r 40 (r 206 40))
            (r (r (r 206 40) (r 40 (r 206 40)))
               (r (r 40 (r 206 40)) (r 40 (r 206 40)))))))

;; the if condition now calculates remainder 7 times

;; HOLY SHIT, I AM OUT OF HERE!!!

;; This exercise made the difference between normal and applicative
;; order pretty clear. :/
    
