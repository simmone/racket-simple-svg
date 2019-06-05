#lang racket

(require "../svg.rkt")

(provide (contract-out
          [svg-def-ellipse (-> (cons/c natural? natural?) string?)]
          ))

(define (svg-def-ellipse radius)
  (let ([properties_map (make-hash)])

    (hash-set! properties_map 'type 'ellipse)
    (hash-set! properties_map 'radius radius)
    
    (hash-set! properties_map 'format-def
               (lambda (index ellipse)
                 (if (hash-has-key? ellipse 'cx)
                     (format "    <ellipse id=\"~a\" cx=\"~a\" cy=\"~a\" rx=\"~a\" ry=\"~a\" />\n"
                             index
                             (hash-ref ellipse 'cx)
                             (hash-ref ellipse 'cy)
                             (car (hash-ref ellipse 'radius))
                             (cdr (hash-ref ellipse 'radius)))
                     "")))

    ((*add-shape*) properties_map)))

