#lang racket

(provide (contract-out
          [*svg* parameter?]
          [start-svg (-> void?)]
          [end-svg (-> void?)]
          ))

(define *svg* (make-parameter #f))

(define (start-svg)
  (fprintf (*svg*) "<svg>\n"))

(define (end-svg)
  (fprintf (*svg*) "</svg>\n"))

  
