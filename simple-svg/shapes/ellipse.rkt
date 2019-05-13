#lang racket

(require "../svg.rkt")

(provide (contract-out
          [svg-ellipse-def (-> (cons/c natural? natural?) (cons/c natural? natural?) string?)]
          ))

(define (svg-ellipse-def center_point radius)
  (let ([shape_id ((*shape-index*))]
        [properties_map (make-hash)])

    (hash-set! properties_map 'type 'ellipse)
    (hash-set! properties_map 'center_point center_point)
    (hash-set! properties_map 'radius radius)
    
    (hash-set! properties_map 'format-def
               (lambda (index ellipse)
                 (format "    <ellipse id=\"~a\" cx=\"~a\" cy=\"~a\" rx=\"~a\" ry=\"~a\" />"
                         index
                         (car (hash-ref ellipse 'center_point))
                         (cdr (hash-ref ellipse 'center_point))
                         (car (hash-ref ellipse 'radius))
                         (cdr (hash-ref ellipse 'radius)))))

    ((*add-shape*) shape_id properties_map)))

