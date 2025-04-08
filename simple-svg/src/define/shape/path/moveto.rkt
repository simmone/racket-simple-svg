#lang racket

(require "path.rkt")

(provide (contract-out
          [svg-path-moveto (-> (cons/c number? number?) void?)]
          [svg-path-moveto* (-> (cons/c number? number?) void?)]
          ))

(define (svg-path-moveto point) (m 'm point))

(define (svg-path-moveto* point) (m 'M point))

(define (m type point)
  ((*add-path*) (format "~a~a,~a" type (~r (car point)) (~r (cdr point)))))
