#lang racket

(require "../svg.rkt")

(provide (contract-out
          [ellipse (-> natural? natural? natural? natural? string? void?)]
          ))

(define (ellipse x y radius_width radius_height fill)
  (fprintf (*svg*) "  <ellipse ~a/>\n"
           (with-output-to-string
             (lambda ()
               (printf "cx=\"~a\" cy=\"~a\" rx=\"~a\" ry=\"~a\" fill=\"~a\" "
                       x y radius_width radius_height fill)))))

