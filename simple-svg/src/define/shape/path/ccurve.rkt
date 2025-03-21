#lang racket

(require "path.rkt")

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
                        (~r (car point1))
                        (~r (cdr point1))
                        (~r (car point2))
                        (~r (cdr point2))
                        (~r (car point3))
                        (~r (cdr point3))
                        )))
