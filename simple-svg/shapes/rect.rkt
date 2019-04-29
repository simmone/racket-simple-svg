#lang racket

(require "../svg.rkt")

(provide (contract-out
          [rect (->* 
                 (natural? natural? string?)
                 (
                  #:start_point? (or/c #f (cons/c natural? natural?))
                  #:radius? (or/c #f (cons/c natural? natural?))
                  )
                 void?)]
          ))

(define (rect width height fill
              #:start_point? [start_point? #f]
              #:radius? [radius? #f])

  (let ([x 0]
        [y 0]
        [radiusX 0]
        [radiusY 0])

    (when start_point?
          (set! x (car start_point?))
          (set! y (cdr start_point?)))

    (when radius?
          (set! radiusX (car radius?))
          (set! radiusY (cdr radius?)))
    
  (if start_point?
      ((*size-func*) (+ x width) (+ y height))
      ((*size-func*) width height))

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
                     (printf "rx=\"~a\" ry=\"~a\" " radiusX radiusY)))))))

