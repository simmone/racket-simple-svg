#lang racket

(require "../svg.rkt")
(require "path.rkt")

(provide (contract-out
          [svg-path-lineto (-> (cons/c integer? integer?) void?)]
          [svg-path-lineto* (-> (cons/c integer? integer?) void?)]
          [svg-path-hlineto (-> (cons/c integer? integer?) void?)]
          [svg-path-hlineto* (-> (cons/c integer? integer?) void?)]
          [svg-path-vlineto (-> (cons/c integer? integer?) void?)]
          [svg-path-vlineto* (-> (cons/c integer? integer?) void?)]
          ))

(define (svg-path-lineto point) (line 'l point))
(define (svg-path-lineto* point) (line 'L point))
(define (svg-path-hlineto point) (line 'h point))
(define (svg-path-hlineto* point) (line 'H point))
(define (svg-path-vlineto point) (line 'v point))
(define (svg-path-vlineto* point) (line 'V point))

(define (line type point)
  (cond
   [(or
     (eq? type 'l)
     (eq? type 'h)
     (eq? type 'v))
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
