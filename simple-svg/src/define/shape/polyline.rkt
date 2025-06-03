#lang racket

(require racket/serialize
         "../../lib.rkt")

(provide (contract-out
          [struct POLYLINE
                  (
                   (points (listof (cons/c number? number?)))
                   )
                  ]
          [new-polyline (-> (listof (cons/c number? number?)) POLYLINE?)]
          [format-polyline (-> string? POLYLINE? string?)]
          ))

(serializable-struct POLYLINE (
                          [points #:mutable]
                          )
                #:transparent
                )

(define (new-polyline points)
  (POLYLINE points)) 

(define (format-polyline shape_id polyline)
  (format "    <polyline id=\"~a\" points=\"~a\" />\n"
          shape_id
          (string-join
           (map
            (lambda (point)
              (format "~a,~a" (svg-precision (car point)) (svg-precision (cdr point))))
            (POLYLINE-points polyline)))))
