#lang planet neil/sicp

(define (make-queue)
  (let ((front-ptr car)
        (rear-ptr  cdr)
        (queue (cons '() '())))    
    (define (set-front-ptr!  item)
      (set-car! queue item))
    (define (set-rear-ptr!  item)
      (set-cdr! queue item))
    (define (empty-queue? )
      (null? (front-ptr queue))) 
    (define (create-queue)
      (cons '() '()))
    (define (front-queue)
      (if (empty-queue? )
          (error "The queue is empty!!")
          (front-ptr queue)))
    (define (insert-queue!  item)
      (let ((new-item (cons item '())))
        (if (empty-queue? )
            (begin (set-front-ptr!  new-item)
                   (set-rear-ptr!  new-item)
                   (print-queue))
            (begin (set-cdr! (rear-ptr queue) new-item)
                   (set-rear-ptr!  new-item)
                   (print-queue)))))    
    (define (delete-queue! )
      (if (empty-queue? )
          (error "Trying to delete an empty queue")
          (begin (set-front-ptr! (cdr (front-ptr queue)))
                 (print-queue))))    
    (define (print-queue)
      (let ((fp (front-ptr queue)))
        (cond ((null? fp) '())
              (else fp))))
    (define (dispatch m)
      (cond ((eq? m 'empty?)  empty-queue?)
            ((eq? m 'insert!) insert-queue!)
            ((eq? m 'delete!) delete-queue!)
            (else (error "Invalid operation"))))
    dispatch))

(define (insert-queue! q value)
  ((q 'insert!) value))

(define (delete-queue! q)
  ((q 'delete!)))