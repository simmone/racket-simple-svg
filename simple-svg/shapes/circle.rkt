#lang racket

(require "../svg.rkt")

(provide (contract-out
          [svg-circle-def (-> (cons/c natural? natural?) natural? string?)]
          ))

(define (svg-circle-def center_point radius)
  (let ([shape_id ((*shape-index*))]
        [properties_map (make-hash)])

    (hash-set! properties_map 'type 'circle)
    (hash-set! properties_map 'radius radius)
    (hash-set! properties_map 'center_point center_point)
    
    (hash-set! properties_map 'format-def
               (lambda (index circle)
                 (format "    <circle id=\"~a\" cx=\"~a\" cy=\"~a\" r=\"~a\" />"
                         index
                         (car (hash-ref circle 'center_point))
                         (cdr (hash-ref circle 'center_point))
                         (hash-ref circle 'radius))))

    ((*add-shape*) shape_id properties_map)))
