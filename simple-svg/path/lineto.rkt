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
  (if (eq? type 'l)
      (let ([current_position
             (cons
              (+ (car ((*get-position*))) (car point))
              (+ (cdr ((*get-position*))) (cdr point)))])
        ((*size-func*) current_position)
        ((*set-position*) current_position))
      (begin
        ((*size-func*) point)
        ((*set-position*) point)))
  
  ((*add-path*) (format "~a~a,~a" type (car point) (cdr point))))

(define (line type length)
  (if (eq? type 'h)
      (let ([current_position
             (cons
              (+ (car ((*get-position*))) length)
              (cdr ((*get-position*))))])
        ((*size-func*) current_position)
        ((*set-position*) current_position))
      (let ([current_position
             (cons
              (car ((*get-position*)))
              (+ (cdr ((*get-position*))) length))])
        ((*size-func*) current_position)
        ((*set-position*) current_position)))
  
  ((*add-path*) (format "~a~a" type length)))

