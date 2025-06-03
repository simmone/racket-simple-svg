#lang racket

(require racket/serialize
         "../../lib.rkt")

(provide (contract-out
          [struct CIRCLE
                  (
                   (radius number?)
                   )
                  ]
          [new-circle (-> number? CIRCLE?)]
          [format-circle (-> string? CIRCLE? string?)]
          ))

(serializable-struct CIRCLE (
                        [radius #:mutable]
                        )
                #:transparent
                )

(define (new-circle radius)
  (CIRCLE radius))

(define (format-circle shape_id circle)
  (format "    <circle id=\"~a\" r=\"~a\" />\n"
          shape_id
          (svg-precision (CIRCLE-radius circle))))
