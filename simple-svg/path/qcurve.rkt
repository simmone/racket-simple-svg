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
  ((*add-path*) (format "~a~a,~a ~a,~a"
                        type 
                        (car point1)
                        (cdr point1)
                        (car point2)
                        (cdr point2))))
