#lang racket

(require "operations.rkt")

;; queens
;; a way to solve n x n queens problem
(define (queens board-size)
  (define (queen-cols k)
    (if (= k 0)
        (list empty-board)
        (filter
         ;; filter out the positions which do not mess up the
         ;; arrangement at column k. Since this is a recursive
         ;; algorithm, the positions will be filtered out at
         ;; every step -- the first step will have the largest
         ;; number of positions, and the it will keep on decreasing
         ;; because every iteration gives a fixed set of positions.
         (lambda (positions) (safe? k positions))
         (flatmap
          (lambda (rest-of-queens)
            (map (lambda (new-row)
                   (adjoin-position new-row k rest-of-queens))
                 (enumerate-interval 1 board-size)))
          (queen-cols (- k 1))))))
  (define empty-board '())
  (queen-cols board-size))

;; The idea is that adjoin-position will add all the possible positions
;; for the given column. This means that all the positions from 1 to n
;; will be added for the column k. This needs to be added blindly at first,
;; because there is no need for optimization initially, and also because
;; safe? will filter out the position before sending this column's data.
;; TODO: Find a better way of adding element at the end of the list
(define (adjoin-position new-row col rest-of-queens)
  (cons (list new-row col) rest-of-queens)
  ;;(append rest-of-queens (list (list new-row col)))
  )

(define (row x) (first x))
(define (column x) (second x))

;; safe?
;; from a set of given combination, pick the one which solves the problem
;; Positions will be a nested list like (for 2x2 grid):
;; '(((1 2) (1 1)) ((2 2) (1 1))
;; where the queen has already been placed at the 1,1 cell (which is
;; guarateed to be safe) and for the second queen there are two positions:
;; both are unsafe.
(define (safe? col positions)
  ;; As per the way I have arraged the positions, car is the position of the
  ;; current queen, and the rest of these are the positions
  (let ((current (first positions))
        (previous (rest positions)))
    (if (and (safe-row current previous)
             (safe-column current previous)
             (safe-diagonal current previous))
        true
        false)))

(define (safe-row current other-positions)
  (let ((current-row (row current)))
    (foldl (lambda (x acc)
               (and acc
                    (not (eq? current-row
                              (row x)))))
           true
           other-positions)))

(define (safe-column current other-positions)
  (let ((current-col (column current)))
    (foldl (lambda (x acc)
             (and acc
                  (not (eq? current-col
                            (column x)))))
           true
           other-positions)))

;; diagonals are same if the difference between the
;; row and columns is same.
;; e.g. (5 5) and (3 3) are on the diagonal, so are (5 2) and (4 1)
;; and the difference of rows and columns is (2 2) and (1 1) resp.
;; By the same logic, (5 5) and (4 1) are not on the same diagonal.
(define (safe-diagonal current other-positions)
  (foldl (lambda (x acc)
           (and acc
                (not (eq? (abs (- (column x) (column current)))
                          (abs (- (row x) (row current)))))))
         true
         other-positions))

;; It's really good to break the problem into subproblems, at the end of the
;; day, it makes sense to NOT think too abstractly.

;; TESTING DATA
;; For the solution that is given in the book, k-1 arrangement will be
;; like this:
(define queen-cols-k-1 '((3 1)  (7 2) (2 3)  (8 4) (5 5) (1 6) (7 4)))
(define queen-cols-k-2 '((3 1)  (7 2) (2 3)  (8 4) (5 5) (1 6)))
(define positions-k-1
  '(((1 8) (3 1) (7 2) (2 3) (8 4) (5 5) (1 6) (7 4))
    ((2 8) (3 1) (7 2) (2 3) (8 4) (5 5) (1 6) (7 4))
    ((3 8) (3 1) (7 2) (2 3) (8 4) (5 5) (1 6) (7 4))
    ((4 8) (3 1) (7 2) (2 3) (8 4) (5 5) (1 6) (7 4))
    ((5 8) (3 1) (7 2) (2 3) (8 4) (5 5) (1 6) (7 4))
    ((6 8) (3 1) (7 2) (2 3) (8 4) (5 5) (1 6) (7 4))
    ((7 8) (3 1) (7 2) (2 3) (8 4) (5 5) (1 6) (7 4))
    ((8 8) (3 1) (7 2) (2 3) (8 4) (5 5) (1 6) (7 4))))

(define unsafe-position-8 '((1 8) (3 1) (7 2) (2 3) (8 4) (5 5) (1 6) (7 4)))
(define safe-position-8 '((6 8) (3 1) (7 2) (2 3) (8 4) (5 5) (1 6) (7 4)))
(define position-set-1
  '(
    ((1 1) (1 2))
    ((1 1) (2 2))))

(define safe-rc (lambda (pos) (and (safe-row (first pos) (rest pos)) (safe-column  (first pos) (rest pos)))))
