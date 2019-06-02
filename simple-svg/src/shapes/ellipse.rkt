#lang racket

(require "../svg.rkt")

(provide (contract-out
          [svg-ellipse-def (-> (cons/c natural? natural?) string?)]
          ))

(define (svg-ellipse-def radius)
  (let ([properties_map (make-hash)])

    (hash-set! properties_map 'type 'ellipse)
    (hash-set! properties_map 'radius radius)
    
    (hash-set! properties_map 'format-def
               (lambda (index ellipse)
                 (format "    <ellipse id=\"~a\" cx=\"~a\" cy=\"~a\" rx=\"~a\" ry=\"~a\" />"
                         index
                         (hash-ref ellipse 'cx)
                         (hash-ref ellipse 'cy)
                         (car (hash-ref ellipse 'radius))
                         (cdr (hash-ref ellipse 'radius)))))

    ((*add-shape*) properties_map)))

