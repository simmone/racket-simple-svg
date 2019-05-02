#lang racket

(require "../svg.rkt")
(require "path.rkt")

(provide (contract-out
          [moveto (-> (cons/c natural? natural?) void?)]
          [moveto* (-> (cons/c natural? natural?) void?)]
          ))

(define (moveto point) (m 'm point))

(define (moveto* point) (m 'M point))

(define (m type point)
  (if (eq? type 'M)
      ((*position-set*) point)
      ((*position-set*)
       (cons
        (+ (car point) (car ((*position-get*))))
        (+ (cdr point) (cdr ((*position-get*)))))))

  ((*size-func*) (car ((*position-get*))) (cdr ((*position-get*))))

  (if (eq? type 'M)
      (fprintf (*svg*) "           ~a~a,~a\n"
               type
               (+ (car point) (*padding*)) (+ (cdr point) (*padding*)))
      (fprintf (*svg*) "           ~a~a,~a\n"
               type
               (car point) (cdr point))))

