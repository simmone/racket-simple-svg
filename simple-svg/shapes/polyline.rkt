#lang racket

(require "../svg.rkt")

(provide (contract-out
          [polyline (-> (listof pair?) string? natural? string? void?)]
          ))

(define (polyline points stroke_fill stroke_width fill)
  (fprintf (*svg*) "  <polyline ~a />\n"
           (with-output-to-string
             (lambda ()

               (printf "points=\"")
               (let loop ([loop_points points])
                 (when (not (null? loop_points))
                       (printf "~a,~a" (caar loop_points) (cdar loop_points))
                       (when (> (length loop_points) 1) (printf " "))
                       (loop (cdr loop_points))))
               (printf "\" ")

               (printf "stroke=\"~a\" stroke-width=\"~a\" fill=\"~a\""
                       stroke_fill
                       stroke_width
                       fill)))))

