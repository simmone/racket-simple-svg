#lang racket

(require "../svg.rkt")
(require "path.rkt")

(provide (contract-out
          [arc (->
                (cons/c integer? integer?)
                (cons/c integer? integer?)
                (list/c 'left_big 'left_small 'right_big 'right_small)
                (cons/c natural? natural?)
                void?)]
          [arc (->
                (cons/c integer? integer?)
                (cons/c integer? integer?)
                (list/c 'left_big 'left_small 'right_big 'right_small)
                (cons/c natural? natural?)
                void?)]
          ))

(define (arc point radius direction size) (action 'A point radius direction size))

(define (arc* point radius direction size) (action 'a point radius direction size))

(define (action type point radius direction size)
  ((*sequence-set*))

  ((*position-set*) point)

  ((*size-func*) (car size) (cdr size))
  
  (let ([section #f])
    (cond
     [(eq? direction 'left_big)
      (set! section "1,0")]
     [(eq? direction 'left_small)
      (set! section "0,0")]
     [(eq? direction 'right_big)
      (set! section "1,1")]
     [(eq? direction 'right_small)
      (set! section "0,1")])

    (if (eq? type 'A)
          (fprintf (*svg*) "           A~a,~a 0 ~a ~a,~a\n"
                   (car radius) (cdr radius)
                   section
                   (+ (car point) (*padding*)) (+ (cdr point) (*padding*)))
          (fprintf (*svg*) "           a~a,~a 0 ~a ~a,~a\n"
                   (car radius) (cdr radius)
                   section
                   (car point) (cdr point)))))
