#lang racket

(require "../svg.rkt")
(require "path.rkt")

(provide (contract-out
          [svg-path-arc (->
                (cons/c integer? integer?)
                (cons/c natural? natural?)
                (or/c 'left_big 'left_small 'right_big 'right_small)
                (cons/c natural? natural?)
                void?)]
          [svg-path-arc* (->
                 (cons/c integer? integer?)
                 (cons/c natural? natural?)
                 (or/c 'left_big 'left_small 'right_big 'right_small)
                 (cons/c natural? natural?)
                 void?)]
          ))

(define (svg-path-arc point radius direction size) (action 'a point radius direction size))

(define (svg-path-arc* point radius direction size) (action 'A point radius direction size))

(define (action type point radius direction size)
  ((*set-position*) point)

  ((*size-func*) (cons (+ (car point) (car radius)) (+ (cdr point) (cdr radius))))
  
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
