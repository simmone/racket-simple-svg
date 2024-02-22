#lang racket

(provide (contract-out
          [struct PATH
                  (
                   (defs (listof string?))
                   )
                  ]
          [new-path (-> procedure? PATH?)]
          [format-path (-> string? PATH? string?)]
          [*add-path* parameter?]
          ))

(define *add-path* (make-parameter #f))

(struct PATH (
              [defs #:mutable]
              )
        #:transparent
        )

(define (new-path define_proc)
  (let ([defs '()])
    (parameterize
        ([*add-path*
          (lambda (def)
            (set! defs `(,@defs ,def)))])
      (define_proc))
    (PATH defs)))

(define (format-path shape_id path)
  (with-output-to-string
    (lambda ()
      (printf "    <path id=\"~a\"\n" shape_id)
      (printf "          d=\"\n")
      (let loop ([_defs (PATH-defs path)])
        (when (not (null? _defs))
          (printf "             ~a\n" (car _defs))
          (loop (cdr _defs))))
      (printf "            \"/>\n" ))))

