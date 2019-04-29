#lang racket

(require "../svg.rkt")

(provide (contract-out
          [ellipse (-> (cons/c natural? natural?) (cons/c natural? natural?) string? void?)]
          ))

(define (ellipse center_point radius fill)
  ((*size-func*) (+ (car center_point) (car radius)) (+ (cdr center_point) (cdr radius)))

  (fprintf (*svg*) "  <ellipse ~a/>\n"
           (with-output-to-string
             (lambda ()
               (printf "cx=\"~a\" cy=\"~a\" rx=\"~a\" ry=\"~a\" fill=\"~a\" "
                       (+ (car center_point) (*padding*))
                       (+ (cdr center_point) (*padding*))
                       (car radius)
                       (cdr radius)
                       fill)))))

