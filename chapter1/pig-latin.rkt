#lang racket
(require htdp/testing)

;; String -> String
;; Converts a given sentence into pig latin, which is the
;; first consonent moved to the end, and then adding 'ay'
;; to the end.
;; given: scheme, expect: emeschay
;; given: tushar, expect: ushartay
(define (pigl s)
  (if (vowel? (string-ref s 0))
      (string-append s "ay")
      (pigl (string-append (substring s 1) (substring s 0 1)))))

;; Char -> Boolean
;; Checks if the given character is a vowel.
(define (vowel? c)
  (member c (string->list "aeiou")))

(check-expect (pigl "scheme") "emeschay")
(check-expect (pigl "tushar") "ushartay")
