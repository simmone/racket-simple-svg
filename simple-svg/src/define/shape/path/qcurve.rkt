#lang racket

(require "path.rkt"
         "../../../lib.rkt")

(provide (contract-out
          [svg-path-qcurve (-> 
                            (cons/c number? number?)
                            (cons/c number? number?)
                            void?)]
          [svg-path-qcurve* (->
                             (cons/c number? number?)
                             (cons/c number? number?)
                             void?)]
          ))

(define (svg-path-qcurve point1 point2) (curve 'q point1 point2))

(define (svg-path-qcurve* point1 point2) (curve 'Q point1 point2))

(define (curve type point1 point2)
  ((*add-path*) (format "~a~a,~a ~a,~a"
                        type 
                        (svg-precision (car point1))
                        (svg-precision (cdr point1))
                        (svg-precision (car point2))
                        (svg-precision (cdr point2)))))
