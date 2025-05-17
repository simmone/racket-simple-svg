#lang racket

(require racket/serialize
         "../../lib.rkt")

(provide (contract-out
          [struct ELLIPSE
                  (
                   (radius_x number?)
                   (radius_y number?)
                   )
                  ]
          [new-ellipse (-> number? number? ELLIPSE?)]
          [format-ellipse (-> string? ELLIPSE? string?)]
          ))

(serializable-struct ELLIPSE (
                         [radius_x #:mutable]
                         [radius_y #:mutable]
                         )
                #:transparent
                )

(define (new-ellipse radius_x radius_y)
  (ELLIPSE radius_x radius_y))

(define (format-ellipse shape_id ellipse)
  (format "    <ellipse id=\"~a\" ~a />\n"
          shape_id
          (with-output-to-string
            (lambda ()
              (printf "rx=\"~a\" ry=\"~a\""
                      (svg-round (ELLIPSE-radius_x ellipse))
                      (svg-round (ELLIPSE-radius_y ellipse)))
              ))))
