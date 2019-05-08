#lang racket

(require "../svg.rkt")

(provide (contract-out
          [svg-rect-def (->* 
                 (natural? natural?)
                 (
                  #:radius? (or/c #f (cons/c natural? natural?))
                  )
                 void?)]
          ))

(define (svg-def-rect width height
              #:radius? [radius? #f])
  (let ([shapes_id ((*shapes_counter*))])
  (hash-set! (*shape_map*) 

(define (svg-rect-format rec)
  (fprintf (*svg*) "  <rect ~a/>\n"
           (with-output-to-string
             (lambda ()
               (printf "width=\"~a\" height=\"~a\" fill=\"~a\" "
                       width height fill)

               (when (or
                      (> (*padding*) 0)
                      start_point?)
                   (printf "x=\"~a\" y=\"~a\" " (+ x (*padding*)) (+ y (*padding*))))

               (when radius?
                     (printf "rx=\"~a\" ry=\"~a\" " radiusX radiusY))))))

