#lang racket

(require "../svg.rkt")

(provide (contract-out
          [svg-def-path (-> procedure? string?)]
          [*add-path* parameter?]
          ))

(define *add-path* (make-parameter #f))

(define (svg-def-path path_proc)
  (let ([properties_map (make-hash)]
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
                           (printf "    <path id=\"~a\"\n" index)
                           (printf "          d=\"\n"))
                         (lambda ()
                           (let loop ([_defs defs])
                             (when (not (null? _defs))
                               (printf "             ~a\n" (car _defs))
                               (loop (cdr _defs)))))
                         (lambda ()
                           (printf "            \"/>\n" )))))))

    ((*add-shape*) properties_map)))
