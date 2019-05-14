#lang racket

(require "../svg.rkt")

(provide (contract-out
          [svg-path-raw (->* 
                 (natural? natural? string?)
                 (
                  #:fill? string?
                  #:stroke-fill? string?
                  #:stroke-width? natural?
                  #:stroke-linejoin? string?
                  )
                 void?)]
          ))

(define (svg-path-raw width height raw_data)
  (let ([shape_id ((*shape-index*))]
        [properties_map (make-hash)])

    (hash-set! properties_map 'type 'rect)
    (hash-set! properties_map 'width width)
    (hash-set! properties_map 'height height)

    (hash-set! properties_map 'format-def
               (lambda (index path)
                 (format "  <path d=\"~a\" />\n" raw_data)))

    ((*add-shape*) shape_id properties_map)))

