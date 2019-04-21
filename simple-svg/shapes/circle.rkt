#lang racket

(require "../svg.rkt")

(provide (contract-out
          [circle (-> natural? natural? natural? string? void?)]
          ))

(define (circle x y radius fill)
  (fprintf (*svg*) "  <circle ~a/>\n"
           (with-output-to-string
             (lambda ()
               (printf "cx=\"~a\" cy=\"~a\" r=\"~a\" fill=\"~a\" "
                       x y radius fill)))))

