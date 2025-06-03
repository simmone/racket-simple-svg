#lang racket

(require racket/serialize
         "../../lib.rkt")

(provide (contract-out
          [struct LINE
                  (
                   (start_x number?)
                   (start_y number?)
                   (end_x number?)
                   (end_y number?)
                   )
                  ]
          [new-line (-> (cons/c number? number?) (cons/c number? number?) LINE?)]
          [format-line (-> string? LINE? string?)]
          ))

(serializable-struct LINE (
                      [start_x #:mutable]
                      [start_y #:mutable]
                      [end_x #:mutable]
                      [end_y #:mutable]
                      )
                #:transparent
                )

(define (new-line start_point end_point)
  (LINE (car start_point) (cdr start_point) (car end_point) (cdr end_point)))

(define (format-line shape_id line)
  (format "    <line id=\"~a\" x1=\"~a\" y1=\"~a\" x2=\"~a\" y2=\"~a\" />\n"
          shape_id
          (svg-precision (LINE-start_x line))
          (svg-precision (LINE-start_y line))
          (svg-precision (LINE-end_x line))
          (svg-precision (LINE-end_y line))))
