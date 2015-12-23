#lang racket

;; Because of the lack of the record table, these procedures have not
;; been tested (or run, for that matter).

(define (attach-tag tag-name data)
  (cons tag-name data))
(define (tag data)
  (car data))
(define (content data)
  (cdr data))

;; Division 1 stores name, address, age, salary
(define div1-record-emp1
  (attach-tag 'div1 '(Jack "Some address" 25 10000)))
;; Division 2 stores name, age, salary, address
(define div2-record-emp1
  (attach-tag 'div2 '(Jack 25 10000 "Some address")))
(define (get-division data)
  (first data))

;; This structure assumes that the individual get-record method
;; of the division will tag the individual record of the division with the
;; division tag. Something like:
;; '(div1 (Jack "Some address" 25 10000))
;; Here the employee name level tag has been removed and replaced with the
;; division level tag.
(define div1-records
  '((Jack (Jack "Some address" 25 10000))
    (Jill (Jill "Some address" 20 20000))))

(define div2-records
  '((Jack (Jack 25 10000 "Some address"))
    (Jill (Jill 20 20000 "Some address"))))

;; global function working on the assumption that for the generic
;; interface, each of the records have the emp-name as tags.
(define (install-division1-package)
  ;; internal procedures
  (define (get-salary-div1 emp-data)
    (fourth emp-data))
  (define (get-age-div1 emp-data)
    (third emp-data))
  (define (get-record division-records emp-name)
    (cond
      ((empty? division-records) '())
      ((eq? (tag (car division-records))
            emp-name)
       (content (car division-records)))
      (else (get-record (cdr division-records) emp-name))))
  ;; Records in the division files are using employee name as keys,
  ;; and since we are only returning the employee info from the
  ;; get-record method, the data should be tagged as div1 here so
  ;; that the other division specific procedures can work with the
  ;; data
  (define (get-record-div1 emp-name)
    (let ((record (get-record div1-records emp-name)))
      (if (empty? record)
          '()
          (tag record)))) ;; add division level tag to the data
  ;; interface
  (define (tag x) (attach-tag 'div1 x))
  (put 'get-salary 'div get-salary-div1)
  (put 'get-age    'div get-age-div1)
  (put 'get-record 'div get-record-div1)
  'done)
