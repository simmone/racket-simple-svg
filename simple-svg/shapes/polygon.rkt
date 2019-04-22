#lang racket

(require "../svg.rkt")

(provide (contract-out
          [polygon (-> (listof pair?) string? void?)]
          ))

(define (polygon points  fill)
  (fprintf (*svg*) "  <polygon ~a />\n"
           (with-output-to-string
             (lambda ()

               (printf "points=\"")
               (let loop ([loop_points points])
                 (when (not (null? loop_points))
                       (printf "~a,~a" (caar loop_points) (cdar loop_points))
                       (when (> (length loop_points) 1) (printf " "))
                       (loop (cdr loop_points))))
               (printf "\" ")

               (printf "fill=\"~a\""
                       fill)))))

