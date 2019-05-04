#lang racket

(require "../svg.rkt")
(require "path.rkt")

(provide (contract-out
          [qcurve (-> 
                   (cons/c integer? integer?)
                   (cons/c integer? integer?)
                   void?)]
          [qcurve* (->
                    (cons/c integer? integer?)
                    (cons/c integer? integer?)
                    void?)]
          ))

(define (qcurve point1 point2) (curve 'q point1 point2))

(define (qcurve* point1 point2) (curve 'Q point1 point2))

(define (curve type point1 point2)
  ((*sequence-set*))

  (let ([point1* #f]
        [point2* #f])
  (if (eq? type 'Q)
      (begin
        (set! point1* point1)
        (set! point2* point2))
      (begin
        (set! point1*
              (cons
               (+ (car point1) (car ((*position-get*))))
               (+ (cdr point1) (cdr ((*position-get*))))))

        (set! point2*
              (cons
               (+ (car point2) (car ((*position-get*))))
               (+ (cdr point2) (cdr ((*position-get*))))))))
        
      ((*position-set*) point2*)

      ((*size-func*) (car point1*) (cdr point1*))
      ((*size-func*) (car point2*) (cdr point2*))

      (if (eq? type 'Q)
          (fprintf (*svg*) "           Q~a,~a ~a,~a\n"
                   (+ (car point1*) (*padding*)) (+ (cdr point1*) (*padding*))
                   (+ (car point2*) (*padding*)) (+ (cdr point2*) (*padding*)))
          (fprintf (*svg*) "           q~a,~a ~a,~a\n"
                   (car point1) (cdr point1)
                   (car point2) (cdr point2)))))

