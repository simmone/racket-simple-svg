#lang racket

(require "../svg.rkt")

(provide (contract-out
          [circle (-> (cons/c natural? natural?) natural? string? void?)]
          ))

(define (circle center_point radius fill)
  ((*size-func*) (* (car center_point) 2) (* (cdr center_point) 2))

  (fprintf (*svg*) "  <circle ~a/>\n"
           (with-output-to-string
             (lambda ()
               (printf "cx=\"~a\" cy=\"~a\" r=\"~a\" fill=\"~a\" "
                       (+ (car center_point) (*padding*))
                       (+ (cdr center_point) (*padding*))
                       radius
                       fill)))))
