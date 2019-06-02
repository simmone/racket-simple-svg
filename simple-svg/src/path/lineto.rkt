#lang racket

(require "../svg.rkt")
(require "path.rkt")

(provide (contract-out
          [svg-path-lineto (-> (cons/c integer? integer?) void?)]
          [svg-path-lineto* (-> (cons/c integer? integer?) void?)]
          [svg-path-hlineto (-> integer? void?)]
          [svg-path-vlineto (-> integer? void?)]
          ))

(define (svg-path-lineto point) (line* 'l point))
(define (svg-path-lineto* point) (line* 'L point))

(define (svg-path-hlineto length) (line 'h length))
(define (svg-path-vlineto length) (line 'v length))

(define (line* type point)
  ((*add-path*) (format "~a~a,~a" type (car point) (cdr point))))

(define (line type length)
  ((*add-path*) (format "~a~a" type length)))

