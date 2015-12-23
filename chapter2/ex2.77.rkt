;; The given representation (called x) is -> Complex -> Rectangular -> 3 . 4
;; After installing the given procedures for the real and imag parts of
;; complex numbers, we will get the following calls:
;; (real-part x)
;; => (apply-generic 'real-part 'complex x)
;; => (apply real-part 'rectangular -> 3 . 4)
;; => (real-part 'rectangular -> 3 . 4)
;; => (apply-generic 'rectangular [3 . 4])
;; => (apply real-part 3 . 4)
;; => (car 3 . 4)
;; => 3
;; Simlarly for the other 3 procedures
