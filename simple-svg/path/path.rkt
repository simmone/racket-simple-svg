#lang racket

(require "../svg.rkt")

(provide (contract-out
          [svg-path-def (-> procedure? string?)]
          ))

(define (svg-path-def width height path_proc)
  (let ([shape_id ((*shape-index*))]
        [properties_map (make-hash)])

    (hash-set! properties_map 'type 'path)
    (hash-set! properties_map 'width width)
    (hash-set! properties_map 'height height)
    (hash-set! properties_map 'defs '())

    (hash-set! properties_map 'format-def
               (lambda (index path)
                 (with-output-to-string
                   (lambda ()
                     (dynamic-wind
                         (lambda ()
                           (printf "  <path\n")
                           (printf "        d=\"\n"))
                         (lambda ()
                           (let ([position (cons 0 0)]
                                 [sequence 0])
                             (parameterize
                              ([*position-get* (lambda () position)]
                               [*position-set* (lambda (_position) (set! position _position))]
                               [*sequence-get* (lambda () sequence)]
                               [*sequence-set* (lambda () (set! sequence (add1 sequence)))])
                              (path_proc))))
                         (lambda ()
                           (printf "          \"\n          />\n" )))))))

    ((*add-shape*) shape_id properties_map)))
