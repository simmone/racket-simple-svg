#lang racket

(require "../svg.rkt")

(provide (contract-out
          [svg-def-rect (->* 
                 (natural? natural?)
                 (
                  #:radius? (or/c #f (cons/c natural? natural?))
                  )
                 string?)]
          ))

(define (svg-def-rect width height
              #:radius? [radius? #f])
  (let ([properties_map (make-hash)])

    (hash-set! properties_map 'type 'rect)
    (hash-set! properties_map 'width width)
    (hash-set! properties_map 'height height)
    (when radius?
          (hash-set! properties_map 'radius radius?))
    
    (hash-set! properties_map 'format-def
               (lambda (index rect)
                 (format "    <rect id=\"~a\" ~a/>"
                         index
                         (with-output-to-string
                           (lambda ()
                             (printf "width=\"~a\" height=\"~a\" "
                                     (hash-ref rect 'width)
                                     (hash-ref rect 'height))
                             
                             (when (hash-has-key? rect 'radius)
                                   (printf "rx=\"~a\" ry=\"~a\" "
                                           (car (hash-ref rect 'radius))
                                           (cdr (hash-ref rect 'radius))))
                             
                             )))))

    ((*add-shape*) properties_map)))
