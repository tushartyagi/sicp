;; Before the call to car, the argument to car will be evaluated.
;; Now I am not sure if the argument will be evaluated inside out, because
;; this is what seems to be happening.
;; ''euh opens up to (quote (quote euh)) and the inner one is being
;; treated as a list with the car as quote and cdr as euh.
(car ''abracadabra)
