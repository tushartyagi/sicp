#lang racket

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
  (define (get-record div-records emp-name)
    (cond
      ((empty? div-records) '())
      ((eq? (tag (car div-records)) emp-name) (content (car div-records)))
      (else (get-record (cdr div-records) emp-name))))
  (define (get-record-div1 emp-name)
    (let ((record (get-record div1-records emp-name)))
      (if (empty? record)
          '()
          (tag record))))
  ;; interface
  (define (tag x) (attach-tag 'div1 x))
  (put 'div1 'get-salary get-salary-div1)
  (put 'div1 'get-age get-age-div1)
  (put 'div1 'get-record get-record-div1)
  'done)

(define (find-employee-record emp-name divisions)
  )
