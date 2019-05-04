#lang racket

(require "../svg.rkt")
(require "path.rkt")

(provide (contract-out
          [lineto (-> (cons/c integer? integer?) void?)]
          [lineto* (-> (cons/c integer? integer?) void?)]
          [hlineto (-> (cons/c integer? integer?) void?)]
          [hlineto* (-> (cons/c integer? integer?) void?)]
          [vlineto (-> (cons/c integer? integer?) void?)]
          [vlineto* (-> (cons/c integer? integer?) void?)]
          ))

(define (lineto point) (line 'l point))
(define (lineto* point) (line 'L point))
(define (hlineto point) (line 'h point))
(define (hlineto* point) (line 'H point))
(define (vlineto point) (line 'v point))
(define (vlineto* point) (line 'V point))

(define (line type point)
  ((*sequence-set*))

  (let ([point* #f])
     (if (or
          (eq? type 'L)
          (eq? type 'H)
          (eq? type 'V))
         (set! point*
              (cons
               (+ (car point) (car ((*position-get*))))
               (+ (cdr point) (cdr ((*position-get*))))))
         (set! point* point))

      ((*position-set*) point*)

      ((*size-func*) (car point*) (cdr point*))

      (fprintf (*svg*) "           ~a~a,~a\n"
               type
               (car point*)
               (cdr point*))))
