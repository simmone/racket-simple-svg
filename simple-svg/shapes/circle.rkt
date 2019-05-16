#lang racket

(require "../svg.rkt")

(provide (contract-out
          [svg-circle-def (-> natural? string?)]
          ))

(define (svg-circle-def radius)
  (let ([shape_id ((*shape-index*))]
        [properties_map (make-hash)])

    (hash-set! properties_map 'type 'circle)
    (hash-set! properties_map 'radius radius)
    
    (hash-set! properties_map 'format-def
               (lambda (index circle)
                 (format "    <circle id=\"~a\" cx=\"~a\" cy=\"~a\" r=\"~a\" />"
                         index
                         (car (hash-ref circle 'at))
                         (cdr (hash-ref circle 'at))
                         (hash-ref circle 'radius))))

    ((*add-shape*) shape_id properties_map)))
