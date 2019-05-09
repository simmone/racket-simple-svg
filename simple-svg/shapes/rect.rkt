#lang racket

(require "../svg.rkt")

(provide (contract-out
          [svg-rect-def (->* 
                 (natural? natural?)
                 (
                  #:radius? (or/c #f (cons/c natural? natural?))
                  )
                 string?)]
          ))

(define (svg-rect-def width height
              #:radius? [radius? #f])
  (let ([shape_id ((*shape-index*))]
        [properties_map (make-hash)])

    (hash-set! properties_map 'type 'rect)
    (hash-set! properties_map 'width width)
    (hash-set! properties_map 'height height)
    (hash-set! properties_map 'radius radius?)

    ((*add-shape*) shape_id properties_map)))

(define (svg-rect-format rec)
  (format "  <rect ~a/>\n"
          (with-output-to-string
            (lambda ()
              (printf "width=\"~a\" height=\"~a\" fill=\"~a\" "
                      (hash-ref (second rec) 'width)
                      (hash-ref (second rec) 'height)
                      (hash-ref (second rec) 'fill "white"))
              
              (when (hash-has-key? (second rec) 'x)
                    (printf "x=\"~a\" " (hash-ref (second rec) 'x)))

              (when (hash-has-key? (second rec) 'y)
                    (printf "y=\"~a\" " (hash-ref (second rec) 'y)))

              (when (hash-has-key? (second rec) 'radius)
                    (printf "rx=\"~a\" ry=\"~a\" "
                            (car (hash-ref (second rec) 'radius))
                            (cdr (hash-ref (second rec) 'radius))))))))

