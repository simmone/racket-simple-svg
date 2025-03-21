#lang racket

(require "path.rkt")

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
                        (~r (car point1))
                        (~r (cdr point1))
                        (~r (car point2))
                        (~r (cdr point2)))))
