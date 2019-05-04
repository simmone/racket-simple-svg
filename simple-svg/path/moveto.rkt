#lang racket

(require "../svg.rkt")
(require "path.rkt")

(provide (contract-out
          [moveto (-> (cons/c integer? integer?) void?)]
          [moveto* (-> (cons/c integer? integer?) void?)]
          ))

(define (moveto point) (m 'm point))

(define (moveto* point) (m 'M point))

(define (m type point)
  ((*sequence-set*))

  (if (eq? type 'M)
      ((*position-set*)
       (cons
        (+ (car point) (car ((*position-get*))))
        (+ (cdr point) (cdr ((*position-get*))))))
      ((*position-set*)
       (cons
        (+ (car point) (car ((*position-get*))))
        (+ (cdr point) (cdr ((*position-get*)))))))

  ((*size-func*) (car ((*position-get*))) (cdr ((*position-get*))))

  (if (eq? type 'M)
      (fprintf (*svg*) "           M~a,~a\n"
               (+ (car point) (*padding*)) (+ (cdr point) (*padding*)))
      (if (= ((*sequence-get*)) 1)
          (fprintf (*svg*) "           m~a,~a\n"
                   (+ (car point) (*padding*)) (+ (cdr point) (*padding*)))
          (fprintf (*svg*) "           m~a,~a\n"
                   (car point) (cdr point)))))