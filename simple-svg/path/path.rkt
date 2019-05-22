#lang racket

(require "../svg.rkt")

(provide (contract-out
          [svg-path-def (-> procedure? string?)]
          [*add-path* parameter?]
          ))

(define *add-path* (make-parameter #f))

(define (svg-path-def path_proc)
  (let ([shape_id ((*shape-index*))]
        [properties_map (make-hash)]
        [defs '()])

    (hash-set! properties_map 'type 'path)

    (parameterize
      ([*add-path*
        (lambda (def)
          (set! defs `(,@defs ,def)))])
        (path_proc))
      
    (hash-set! properties_map 'format-def
               (lambda (index path)
                 (with-output-to-string
                   (lambda ()
                     (dynamic-wind
                         (lambda ()
                           (printf "    <path id=\"~a\"\n" shape_id)
                           (printf "          d=\"\n"))
                         (lambda ()
                           (let loop ([_defs defs])
                             (when (not (null? _defs))
                               (printf "             ~a\n" (car _defs))
                               (loop (cdr _defs)))))
                         (lambda ()
                           (printf "            \"/>" )))))))

    ((*add-shape*) shape_id properties_map)))
