#lang racket

(require "../svg.rkt")

(provide (contract-out
          [svg-line-def (-> (cons/c natural? natural?) (cons/c natural? natural?) string?)]
          ))

(define (svg-line-def start_point end_point)
  (let ([properties_map (make-hash)])

    (hash-set! properties_map 'type 'line)
    (hash-set! properties_map 'start_point start_point)
    (hash-set! properties_map 'end_point end_point)
    
    (hash-set! properties_map 'format-def
               (lambda (index line)
                 (format "    <line id=\"~a\" x1=\"~a\" y1=\"~a\" x2=\"~a\" y2=\"~a\" />"
                         index
                         (car (hash-ref line 'start_point))
                         (cdr (hash-ref line 'start_point))
                         (car (hash-ref line 'end_point))
                         (cdr (hash-ref line 'end_point)))))

    ((*add-shape*) properties_map)))
