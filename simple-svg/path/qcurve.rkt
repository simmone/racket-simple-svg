#lang racket

(require "../svg.rkt")
(require "path.rkt")

(provide (contract-out
          [svg-path-qcurve (-> 
                            (cons/c integer? integer?)
                            (cons/c integer? integer?)
                            void?)]
          [svg-path-qcurve* (->
                             (cons/c integer? integer?)
                             (cons/c integer? integer?)
                             void?)]
          ))

(define (svg-path-qcurve point1 point2) (curve 'q point1 point2))

(define (svg-path-qcurve* point1 point2) (curve 'Q point1 point2))

(define (curve type point1 point2)
  (cond
   [(eq? type 'q)
    (let (
          [_position1
           (cons
            (+ (car ((*get-position*))) (car point1))
            (+ (cdr ((*get-position*))) (cdr point1)))]
          [_position2
           (cons
            (+ (car ((*get-position*))) (car point2))
            (+ (cdr ((*get-position*))) (cdr point2)))]
          )
      ((*size-func*) _position1)
      ((*size-func*) _position2)
      ((*set-position*) _position2))]
   [else
    ((*size-func*) point1)
    ((*size-func*) point2)
    ((*set-position*) point2)])
  
  ((*add-path*) (format "~a~a,~a ~a,~a"
                        type 
                        (car point1)
                        (cdr point1)
                        (car point2)
                        (cdr point2))))
