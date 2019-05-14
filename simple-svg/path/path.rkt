#lang racket

(require "../svg.rkt")

(provide (contract-out
          [svg-path-def (-> procedure? string?)]
          [*position-set* parameter?]
          [*position-get* parameter?]
          [*sequence-set* parameter?]
          [*sequence-get* parameter?]
          ))

(define *position-set* (make-parameter #f))
(define *position-get* (make-parameter #f))

(define *sequence-set* (make-parameter #f))
(define *sequence-get* (make-parameter #f))

(define (path path_proc)
  (dynamic-wind
      (lambda ()
        (fprintf (*svg*) "  <path fill=\"~a\" stroke=\"~a\" stroke-width=\"~a\" stroke-linejoin=\"~a\"\n"
                 fill? stroke-fill? stroke-width? stroke-linejoin?)
        (fprintf (*svg*) "        d=\"\n"))
      (lambda ()
        (let ([position (cons 0 0)]
              [sequence 0])
          (parameterize
              ([*position-get* (lambda () position)]
               [*position-set* (lambda (_position) (set! position _position))]
               [*sequence-get* (lambda () sequence)]
               [*sequence-set* (lambda () (set! sequence (add1 sequence)))])
            (path_proc))))
      (lambda ()
        (fprintf (*svg*) "          \"\n          />\n" ))))
