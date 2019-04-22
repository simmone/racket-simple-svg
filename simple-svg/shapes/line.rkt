#lang racket

(require "../svg.rkt")

(provide (contract-out
          [line (-> pair? pair? string? natural? void?)]
          ))

(define (line start_point end_point stroke_fill stroke_width)
  (fprintf (*svg*) "  <line ~a />\n"
           (with-output-to-string
             (lambda ()
               (printf "x1=\"~a\" y1=\"~a\" x2=\"~a\" y2=\"~a\" stroke=\"~a\" stroke-width=\"~a\""
                       (car start_point)
                       (cdr start_point)
                       (car end_point)
                       (cdr end_point)
                       stroke_fill
                       stroke_width)))))

