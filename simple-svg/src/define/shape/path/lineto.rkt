#lang racket

(require "path.rkt"
         "../../../lib.rkt")

(provide (contract-out
          [svg-path-lineto (-> (cons/c number? number?) void?)]
          [svg-path-lineto* (-> (cons/c number? number?) void?)]
          [svg-path-hlineto (-> number? void?)]
          [svg-path-vlineto (-> number? void?)]
          ))

(define (svg-path-lineto point) (line* 'l point))
(define (svg-path-lineto* point) (line* 'L point))

(define (svg-path-hlineto length) (line 'h length))
(define (svg-path-vlineto length) (line 'v length))

(define (line* type point)
  ((*add-path*) (format "~a~a,~a" type (svg-precision (car point)) (svg-precision (cdr point)))))

(define (line type length)
  ((*add-path*) (format "~a~a" type (svg-precision length))))
