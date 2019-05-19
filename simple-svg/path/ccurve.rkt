#lang racket

(require "../svg.rkt")
(require "path.rkt")

(provide (contract-out
          [svg-path-ccurve (-> 
                            (cons/c integer? integer?)
                            (cons/c integer? integer?)
                            (cons/c integer? integer?)
                            void?)]
          [svg-path-ccurve* (->
                             (cons/c integer? integer?)
                             (cons/c integer? integer?)
                             (cons/c integer? integer?)
                             void?)]
          ))

(define (svg-path-ccurve point1 point2 point3) (curve 'c point1 point2 point3))

(define (svg-path-ccurve* point1 point2 point3) (curve 'C point1 point2 point3))

(define (curve type point1 point2 point3)
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
          [_position3
           (cons
            (+ (car ((*get-position*))) (car point3))
            (+ (cdr ((*get-position*))) (cdr point3)))]
          )
      ((*size-func*) _position1)
      ((*size-func*) _position2)
      ((*size-func*) _position3)
      ((*set-position*) _position3))]
   [else
    ((*size-func*) point1)
    ((*size-func*) point2)
    ((*size-func*) point3)
    ((*set-position*) point3)])
  
  ((*add-path*) (format "~a~a,~a ~a,~a ~a,~a"
                        type 
                        (car point1)
                        (cdr point1)
                        (car point2)
                        (cdr point2)
                        (car point3)
                        (cdr point3)
                        )))
