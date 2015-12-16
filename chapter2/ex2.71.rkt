#lang racket

;; In a huffman tree, the bit to encode the most frequent symbol is always 1,
;; since, navigation wise, this symbol will always be the first left (or right)
;; branch, and therefore will always have a representation of 0.
;; The least used symbol will be the right (or left) child of going down n-2
;; levels, and will therefore be n-1 levels deep. So this will also require
;; n-1 bits to be represented.

;; For n = 5, taking the symbols and relative frequencies as: 
;; A : 1
;; B : 2
;; C : 3
;; D : 4
;; E : 5
;; Since E is supporsed to be the first left child, it will be represented
;; by 0.
;; A on the other hand will be represented by 1111.
;; E 16 (0)    ----|
;; D 8  (10)   ----|
;; C 4  (110)  ----|
;; B 2  (1110) ----|
;; A 1  (1111) ----|

