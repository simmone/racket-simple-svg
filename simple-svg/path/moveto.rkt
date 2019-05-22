#lang racket

(require "../svg.rkt")
(require "path.rkt")

(provide (contract-out
          [svg-path-moveto (-> (cons/c integer? integer?) void?)]
          [svg-path-moveto* (-> (cons/c integer? integer?) void?)]
          ))

(define (svg-path-moveto point) (m 'm point))

(define (svg-path-moveto* point) (m 'M point))

(define (m type point)
  ((*add-path*) (format "~a~a,~a" type (car point) (cdr point))))
