(define fact
  (lambda (x)
    (if (<= x 0)
        1
        (* x (fact (- x 1))))))

(define (my-fact x)
  (if (<= x 0)
        1
        (* x (fact (- x 1)))))

(define op-maker
  (lambda (op)
    (lambda (x y)
      (op x y))))


