#lang racket

(require "../svg.rkt")
(require "path.rkt")

(provide (contract-out
          [ccurve (-> 
                   (cons/c integer? integer?)
                   (cons/c integer? integer?)
                   (cons/c integer? integer?)
                   void?)]
          [ccurve* (->
                    (cons/c integer? integer?)
                    (cons/c integer? integer?)
                    (cons/c integer? integer?)
                    void?)]
          ))

(define (ccurve point1 point2 point3) (curve 'c point1 point2 point3))

(define (ccurve* point1 point2 point3) (curve 'C point1 point2 point3))

(define (curve type point1 point2 point3)
  ((*sequence-set*))

  (let ([point1* #f]
        [point2* #f]
        [point3* #f])
  (if (eq? type 'C)
      (begin
        (set! point1* point1)
        (set! point2* point2)
        (set! point3* point3))
      (begin
        (set! point1*
              (cons
               (+ (car point1) (car ((*position-get*))))
               (+ (cdr point1) (cdr ((*position-get*))))))

        (set! point2*
              (cons
               (+ (car point2) (car ((*position-get*))))
               (+ (cdr point2) (cdr ((*position-get*))))))

        (set! point3*
              (cons
               (+ (car point3) (car ((*position-get*))))
               (+ (cdr point3) (cdr ((*position-get*))))))))
        
      ((*position-set*) point3*)

      ((*size-func*) (car point1*) (cdr point1*))
      ((*size-func*) (car point2*) (cdr point2*))
      ((*size-func*) (car point3*) (cdr point3*))

      (if (eq? type 'C)
          (fprintf (*svg*) "           C~a,~a ~a,~a ~a,~a\n"
                   (+ (car point1*) (*padding*)) (+ (cdr point1*) (*padding*))
                   (+ (car point2*) (*padding*)) (+ (cdr point2*) (*padding*))
                   (+ (car point3*) (*padding*)) (+ (cdr point3*) (*padding*)))
          (fprintf (*svg*) "           c~a,~a ~a,~a ~a,~a\n"
                   (car point1) (cdr point1)
                   (car point2) (cdr point2)
                   (car point3) (cdr point3)))))

