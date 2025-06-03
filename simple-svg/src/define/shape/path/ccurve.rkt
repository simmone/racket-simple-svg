#lang racket

(require "path.rkt"
         "../../../lib.rkt")

(provide (contract-out
          [svg-path-ccurve (-> 
                            (cons/c number? number?)
                            (cons/c number? number?)
                            (cons/c number? number?)
                            void?)]
          [svg-path-ccurve* (->
                             (cons/c number? number?)
                             (cons/c number? number?)
                             (cons/c number? number?)
                             void?)]
          ))

(define (svg-path-ccurve point1 point2 point3) (curve 'c point1 point2 point3))

(define (svg-path-ccurve* point1 point2 point3) (curve 'C point1 point2 point3))

(define (curve type point1 point2 point3)
  ((*add-path*) (format "~a~a,~a ~a,~a ~a,~a"
                        type 
                        (svg-precision (car point1))
                        (svg-precision (cdr point1))
                        (svg-precision (car point2))
                        (svg-precision (cdr point2))
                        (svg-precision (car point3))
                        (svg-precision (cdr point3))
                        )))
