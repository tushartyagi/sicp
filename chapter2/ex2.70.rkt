#lang racket
(require "ex2.68.rkt")
(require "ex2.69.rkt")

(define song-data
  '((A 2) (NA 16) (BOOM 1) (SHA 3)
    (GET 2) (YIP 9) (JOB 2) (WAH 1)))

(define song-huffman-tree
  (generate-huffman-trees song-data))

(define song-lyrics
'(GET A JOB
      SHA NA NA NA NA NA NA NA NA
      GET A JOB
      SHA NA NA NA NA NA NA NA NA
      WAH YIP YIP YIP YIP YIP YIP YIP YIP YIP
      SHA BOOM))

(encode song-lyrics song-huffman-tree)
;; This is 87bits of info
;; '(1 1 1 1 0 1 1 1 0 1 1 1 1 1 0 1 1 0 0 0 0 0 0 0 0 0 1 1 1 1 0 1 1 1 0 1 1 1 1 1 0 1 1 0 0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 1 0 1 1 1 1 1 1 0)

;; For 8 symbol alphabet, we require 3bits for all the possible combinations.
;; The song is 36 symbols long, so (* 36 3), or 108 bits.


