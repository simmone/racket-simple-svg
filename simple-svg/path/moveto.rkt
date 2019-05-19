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
  (cond
   [(eq? type 'm)
    (let ([current_position
           (cons
            (+ (car ((*get-position*))) (car point))
            (+ (cdr ((*get-position*))) (cdr point)))])
      ((*size-func*) current_position)
      ((*set-position*) current_position))]
   [else
    ((*size-func*) point)
    ((*set-position*) point)])

  ((*add-path*) (format "~a~a,~a" type (car point) (cdr point))))
