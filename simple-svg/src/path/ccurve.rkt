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
  ((*add-path*) (format "~a~a,~a ~a,~a ~a,~a"
                        type 
                        (car point1)
                        (cdr point1)
                        (car point2)
                        (cdr point2)
                        (car point3)
                        (cdr point3)
                        )))
