#lang racket

(require "../svg.rkt")

(provide (contract-out
          [ellipse (-> pair? natural? natural? string? void?)]
          ))

(define (ellipse center_point radius_width radius_height fill)
  (fprintf (*svg*) "  <ellipse ~a/>\n"
           (with-output-to-string
             (lambda ()
               (printf "cx=\"~a\" cy=\"~a\" rx=\"~a\" ry=\"~a\" fill=\"~a\" "
                       (car center_point) (cdr center_point) radius_width radius_height fill)))))

