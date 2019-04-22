#lang racket

(require "../svg.rkt")

(provide (contract-out
          [circle (-> pair? natural? string? void?)]
          ))

(define (circle center_point radius fill)
  (fprintf (*svg*) "  <circle ~a/>\n"
           (with-output-to-string
             (lambda ()
               (printf "cx=\"~a\" cy=\"~a\" r=\"~a\" fill=\"~a\" "
                       (car center_point)
                       (cdr center_point)
                       radius
                       fill)))))

